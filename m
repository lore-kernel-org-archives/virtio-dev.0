Return-Path: virtio-dev-return-7602-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F2DD985A89
	for <virtio-dev@lists.oasis-open.org>; Mon, 20 Jul 2020 17:51:24 +0000 (UTC)
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 20 Jul 2020 10:51:22 -0700
Message-ID: <20200720175122.21935.78013.stgit@localhost.localdomain>
In-Reply-To: <20200720175030.21935.80052.stgit@localhost.localdomain>
References: <20200720175030.21935.80052.stgit@localhost.localdomain>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 QEMU 2/3] virtio-balloon: Add locking to prevent possible
 race when starting hinting
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: david@redhat.com, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, peter.maydell@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

There is already locking in place when we are stopping free page hinting
but there is not similar protections in place when we start. I can only
assume this was overlooked as in most cases the page hinting should not be
occurring when we are starting the hinting, however there is still a chance
we could be processing hints by the time we get back around to restarting
the hinting so we are better off making sure to protect the state with the
mutex lock rather than just updating the value with no protections.

Based on feedback from Peter Maydell this issue had also been spotted by
Coverity: CID 1430269

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 hw/virtio/virtio-balloon.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index ce70adcc6925..6e2d1293402f 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -592,6 +592,8 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
         return;
     }
 
+    qemu_mutex_lock(&s->free_page_lock);
+
     if (s->free_page_report_cmd_id == UINT_MAX) {
         s->free_page_report_cmd_id =
                        VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
@@ -600,6 +602,8 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
     }
 
     s->free_page_report_status = FREE_PAGE_REPORT_S_REQUESTED;
+    qemu_mutex_unlock(&s->free_page_lock);
+
     virtio_notify_config(vdev);
 }
 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

