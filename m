Return-Path: virtio-dev-return-7089-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 06B78986071
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Apr 2020 20:00:48 +0000 (UTC)
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 16 Apr 2020 13:00:42 -0700
Message-ID: <20200416200042.13144.65487.stgit@localhost.localdomain>
In-Reply-To: <20200416195641.13144.16955.stgit@localhost.localdomain>
References: <20200416195641.13144.16955.stgit@localhost.localdomain>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v20 QEMU 3/5] virtio-balloon: Implement support for page
 poison tracking feature
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: david@redhat.com, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

We need to make certain to advertise support for page poison tracking if
we want to actually get data on if the guest will be poisoning pages. So
if free page hinting is active we should add page poisoning support and
let the guest disable it if it isn't using it.

Page poisoning will result in a page being dirtied on free. As such we
cannot really avoid having to copy the page at least one more time since
we will need to write the poison value to the destination. As such we can
just ignore free page hinting if page poisoning is enabled as it will
actually reduce the work we have to do.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 hw/virtio/virtio-balloon.c         |   27 +++++++++++++++++++++++++++
 include/hw/virtio/virtio-balloon.h |    1 +
 2 files changed, 28 insertions(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a1d6fb52c876..19d587fd05cb 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -531,6 +531,23 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
         return;
     }
 
+    /*
+     * If page poisoning is enabled then we probably shouldn't bother with
+     * the hinting since the poisoning will dirty the page and invalidate
+     * the work we are doing anyway.
+     *
+     * If at some point in the future the implementation is changed in the
+     * guest we would still have issues as the poison would need to be
+     * applied to the last state of the page on the remote end.
+     *
+     * To do that we could improve upon this current implementation by
+     * migrating a poison/zero page if the page is flagged as dirty instead
+     * of simply skipping it.
+     */
+    if (virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
+        return;
+    }
+
     if (s->free_page_hint_cmd_id == UINT_MAX) {
         s->free_page_hint_cmd_id =
                        VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN;
@@ -634,6 +651,7 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
 
     config.num_pages = cpu_to_le32(dev->num_pages);
     config.actual = cpu_to_le32(dev->actual);
+    config.poison_val = cpu_to_le32(dev->poison_val);
 
     if (dev->free_page_hint_status == FREE_PAGE_HINT_S_REQUESTED) {
         config.free_page_hint_cmd_id =
@@ -697,6 +715,10 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
         qapi_event_send_balloon_change(vm_ram_size -
                         ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT));
     }
+    dev->poison_val = 0;
+    if (virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
+        dev->poison_val = le32_to_cpu(config.poison_val);
+    }
     trace_virtio_balloon_set_config(dev->actual, oldactual);
 }
 
@@ -706,6 +728,9 @@ static uint64_t virtio_balloon_get_features(VirtIODevice *vdev, uint64_t f,
     VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
     f |= dev->host_features;
     virtio_add_feature(&f, VIRTIO_BALLOON_F_STATS_VQ);
+    if (virtio_has_feature(f, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+        virtio_add_feature(&f, VIRTIO_BALLOON_F_PAGE_POISON);
+    }
 
     return f;
 }
@@ -854,6 +879,8 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
         g_free(s->stats_vq_elem);
         s->stats_vq_elem = NULL;
     }
+
+    s->poison_val = 0;
 }
 
 static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 108cff97e71a..3ca2a78e1aca 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -70,6 +70,7 @@ typedef struct VirtIOBalloon {
     uint32_t host_features;
 
     bool qemu_4_0_config_size;
+    uint32_t poison_val;
 } VirtIOBalloon;
 
 #endif


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

