Return-Path: virtio-dev-return-7497-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 99F3D986134
	for <virtio-dev@lists.oasis-open.org>; Fri, 19 Jun 2020 21:53:12 +0000 (UTC)
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 19 Jun 2020 14:53:09 -0700
Message-ID: <20200619215309.25598.7553.stgit@localhost.localdomain>
In-Reply-To: <20200619214912.25598.8400.stgit@localhost.localdomain>
References: <20200619214912.25598.8400.stgit@localhost.localdomain>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 1/2] virtio-balloon: Prevent guest from starting a report
 when we didn't request one
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: david@redhat.com, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Based on code review it appears possible for the driver to force the device
out of a stopped state when hinting by repeating the last ID it was
provided.

Prevent this by only allowing a transition to the start state when we are
in the requested state. This way the driver is only allowed to send one
descriptor that will transition the device into the start state. All others
will leave it in the stop state once it has finished.

In addition add the necessary locking to provent any potential races
between the accesses of the cmd_id and the status.

Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 hw/virtio/virtio-balloon.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 10507b2a430a..7f3af266f674 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -527,7 +527,8 @@ static bool get_free_page_hints(VirtIOBalloon *dev)
             ret = false;
             goto out;
         }
-        if (id == dev->free_page_report_cmd_id) {
+        if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED &&
+            id == dev->free_page_report_cmd_id) {
             dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
         } else {
             /*
@@ -592,14 +593,16 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
         return;
     }
 
-    if (s->free_page_report_cmd_id == UINT_MAX) {
+    qemu_mutex_lock(&s->free_page_lock);
+
+    if (s->free_page_report_cmd_id++ == UINT_MAX) {
         s->free_page_report_cmd_id =
                        VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
-    } else {
-        s->free_page_report_cmd_id++;
     }
 
     s->free_page_report_status = FREE_PAGE_REPORT_S_REQUESTED;
+    qemu_mutex_unlock(&s->free_page_lock);
+
     virtio_notify_config(vdev);
 }
 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

