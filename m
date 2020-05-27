Return-Path: virtio-dev-return-7414-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F12D7985FB4
	for <virtio-dev@lists.oasis-open.org>; Wed, 27 May 2020 04:14:18 +0000 (UTC)
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 26 May 2020 21:14:14 -0700
Message-ID: <20200527041414.12700.50293.stgit@localhost.localdomain>
In-Reply-To: <20200527041212.12700.60627.stgit@localhost.localdomain>
References: <20200527041212.12700.60627.stgit@localhost.localdomain>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v25 QEMU 3/3] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: david@redhat.com, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

In an upcoming patch a feature named Free Page Reporting is about to be
added. In order to avoid any confusion we should drop the use of the word
'report' when referring to Free Page Hinting. So what this patch does is go
through and replace all instances of 'report' with 'hint" when we are
referring to free page hinting.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 hw/virtio/virtio-balloon.c         |   78 ++++++++++++++++++------------------
 include/hw/virtio/virtio-balloon.h |   20 +++++----
 2 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 3e2ac1104b5f..dc15409b0bb6 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -527,21 +527,21 @@ static bool get_free_page_hints(VirtIOBalloon *dev)
             ret = false;
             goto out;
         }
-        if (id == dev->free_page_report_cmd_id) {
-            dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
+        if (id == dev->free_page_hint_cmd_id) {
+            dev->free_page_hint_status = FREE_PAGE_HINT_S_START;
         } else {
             /*
              * Stop the optimization only when it has started. This
              * avoids a stale stop sign for the previous command.
              */
-            if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START) {
-                dev->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
+            if (dev->free_page_hint_status == FREE_PAGE_HINT_S_START) {
+                dev->free_page_hint_status = FREE_PAGE_HINT_S_STOP;
             }
         }
     }
 
     if (elem->in_num) {
-        if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START) {
+        if (dev->free_page_hint_status == FREE_PAGE_HINT_S_START) {
             qemu_guest_free_page_hint(elem->in_sg[0].iov_base,
                                       elem->in_sg[0].iov_len);
         }
@@ -567,11 +567,11 @@ static void virtio_ballloon_get_free_page_hints(void *opaque)
         qemu_mutex_unlock(&dev->free_page_lock);
         virtio_notify(vdev, vq);
       /*
-       * Start to poll the vq once the reporting started. Otherwise, continue
+       * Start to poll the vq once the hinting started. Otherwise, continue
        * only when there are entries on the vq, which need to be given back.
        */
     } while (continue_to_get_hints ||
-             dev->free_page_report_status == FREE_PAGE_REPORT_S_START);
+             dev->free_page_hint_status == FREE_PAGE_HINT_S_START);
     virtio_queue_set_notification(vq, 1);
 }
 
@@ -592,14 +592,14 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
         return;
     }
 
-    if (s->free_page_report_cmd_id == UINT_MAX) {
-        s->free_page_report_cmd_id =
-                       VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
+    if (s->free_page_hint_cmd_id == UINT_MAX) {
+        s->free_page_hint_cmd_id =
+                       VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN;
     } else {
-        s->free_page_report_cmd_id++;
+        s->free_page_hint_cmd_id++;
     }
 
-    s->free_page_report_status = FREE_PAGE_REPORT_S_REQUESTED;
+    s->free_page_hint_status = FREE_PAGE_HINT_S_REQUESTED;
     virtio_notify_config(vdev);
 }
 
@@ -607,18 +607,18 @@ static void virtio_balloon_free_page_stop(VirtIOBalloon *s)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
 
-    if (s->free_page_report_status != FREE_PAGE_REPORT_S_STOP) {
+    if (s->free_page_hint_status != FREE_PAGE_HINT_S_STOP) {
         /*
          * The lock also guarantees us that the
          * virtio_ballloon_get_free_page_hints exits after the
-         * free_page_report_status is set to S_STOP.
+         * free_page_hint_status is set to S_STOP.
          */
         qemu_mutex_lock(&s->free_page_lock);
         /*
-         * The guest hasn't done the reporting, so host sends a notification
-         * to the guest to actively stop the reporting.
+         * The guest isn't done hinting, so send a notification
+         * to the guest to actively stop the hinting.
          */
-        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
+        s->free_page_hint_status = FREE_PAGE_HINT_S_STOP;
         qemu_mutex_unlock(&s->free_page_lock);
         virtio_notify_config(vdev);
     }
@@ -628,15 +628,15 @@ static void virtio_balloon_free_page_done(VirtIOBalloon *s)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
 
-    s->free_page_report_status = FREE_PAGE_REPORT_S_DONE;
+    s->free_page_hint_status = FREE_PAGE_HINT_S_DONE;
     virtio_notify_config(vdev);
 }
 
 static int
-virtio_balloon_free_page_report_notify(NotifierWithReturn *n, void *data)
+virtio_balloon_free_page_hint_notify(NotifierWithReturn *n, void *data)
 {
     VirtIOBalloon *dev = container_of(n, VirtIOBalloon,
-                                      free_page_report_notify);
+                                      free_page_hint_notify);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     PrecopyNotifyData *pnd = data;
 
@@ -685,7 +685,7 @@ static size_t virtio_balloon_config_size(VirtIOBalloon *s)
     if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
         return offsetof(struct virtio_balloon_config, poison_val);
     }
-    return offsetof(struct virtio_balloon_config, free_page_report_cmd_id);
+    return offsetof(struct virtio_balloon_config, free_page_hint_cmd_id);
 }
 
 static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
@@ -697,14 +697,14 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
     config.actual = cpu_to_le32(dev->actual);
     config.poison_val = cpu_to_le32(dev->poison_val);
 
-    if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED) {
-        config.free_page_report_cmd_id =
-                       cpu_to_le32(dev->free_page_report_cmd_id);
-    } else if (dev->free_page_report_status == FREE_PAGE_REPORT_S_STOP) {
-        config.free_page_report_cmd_id =
+    if (dev->free_page_hint_status == FREE_PAGE_HINT_S_REQUESTED) {
+        config.free_page_hint_cmd_id =
+                       cpu_to_le32(dev->free_page_hint_cmd_id);
+    } else if (dev->free_page_hint_status == FREE_PAGE_HINT_S_STOP) {
+        config.free_page_hint_cmd_id =
                        cpu_to_le32(VIRTIO_BALLOON_CMD_ID_STOP);
-    } else if (dev->free_page_report_status == FREE_PAGE_REPORT_S_DONE) {
-        config.free_page_report_cmd_id =
+    } else if (dev->free_page_hint_status == FREE_PAGE_HINT_S_DONE) {
+        config.free_page_hint_cmd_id =
                        cpu_to_le32(VIRTIO_BALLOON_CMD_ID_DONE);
     }
 
@@ -817,14 +817,14 @@ static int virtio_balloon_post_load_device(void *opaque, int version_id)
     return 0;
 }
 
-static const VMStateDescription vmstate_virtio_balloon_free_page_report = {
+static const VMStateDescription vmstate_virtio_balloon_free_page_hint = {
     .name = "virtio-balloon-device/free-page-report",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = virtio_balloon_free_page_support,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
-        VMSTATE_UINT32(free_page_report_status, VirtIOBalloon),
+        VMSTATE_UINT32(free_page_hint_cmd_id, VirtIOBalloon),
+        VMSTATE_UINT32(free_page_hint_status, VirtIOBalloon),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -851,7 +851,7 @@ static const VMStateDescription vmstate_virtio_balloon_device = {
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * []) {
-        &vmstate_virtio_balloon_free_page_report,
+        &vmstate_virtio_balloon_free_page_hint,
         &vmstate_virtio_balloon_page_poison,
         NULL
     }
@@ -883,12 +883,12 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
                            VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
         s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
                                            virtio_balloon_handle_free_page_vq);
-        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
-        s->free_page_report_cmd_id =
-                           VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
-        s->free_page_report_notify.notify =
-                                       virtio_balloon_free_page_report_notify;
-        precopy_add_notifier(&s->free_page_report_notify);
+        s->free_page_hint_status = FREE_PAGE_HINT_S_STOP;
+        s->free_page_hint_cmd_id =
+                           VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN;
+        s->free_page_hint_notify.notify =
+                                       virtio_balloon_free_page_hint_notify;
+        precopy_add_notifier(&s->free_page_hint_notify);
         if (s->iothread) {
             object_ref(OBJECT(s->iothread));
             s->free_page_bh = aio_bh_new(iothread_get_aio_context(s->iothread),
@@ -919,7 +919,7 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
     if (virtio_balloon_free_page_support(s)) {
         qemu_bh_delete(s->free_page_bh);
         virtio_balloon_free_page_stop(s);
-        precopy_remove_notifier(&s->free_page_report_notify);
+        precopy_remove_notifier(&s->free_page_hint_notify);
     }
     balloon_stats_destroy_timer(s);
     qemu_remove_balloon_handler(s);
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index d49fef00cef2..28fd2b396087 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -23,7 +23,7 @@
 #define VIRTIO_BALLOON(obj) \
         OBJECT_CHECK(VirtIOBalloon, (obj), TYPE_VIRTIO_BALLOON)
 
-#define VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN 0x80000000
+#define VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN 0x80000000
 
 typedef struct virtio_balloon_stat VirtIOBalloonStat;
 
@@ -33,20 +33,20 @@ typedef struct virtio_balloon_stat_modern {
        uint64_t val;
 } VirtIOBalloonStatModern;
 
-enum virtio_balloon_free_page_report_status {
-    FREE_PAGE_REPORT_S_STOP = 0,
-    FREE_PAGE_REPORT_S_REQUESTED = 1,
-    FREE_PAGE_REPORT_S_START = 2,
-    FREE_PAGE_REPORT_S_DONE = 3,
+enum virtio_balloon_free_page_hint_status {
+    FREE_PAGE_HINT_S_STOP = 0,
+    FREE_PAGE_HINT_S_REQUESTED = 1,
+    FREE_PAGE_HINT_S_START = 2,
+    FREE_PAGE_HINT_S_DONE = 3,
 };
 
 typedef struct VirtIOBalloon {
     VirtIODevice parent_obj;
     VirtQueue *ivq, *dvq, *svq, *free_page_vq, *reporting_vq;
-    uint32_t free_page_report_status;
+    uint32_t free_page_hint_status;
     uint32_t num_pages;
     uint32_t actual;
-    uint32_t free_page_report_cmd_id;
+    uint32_t free_page_hint_cmd_id;
     uint64_t stats[VIRTIO_BALLOON_S_NR];
     VirtQueueElement *stats_vq_elem;
     size_t stats_vq_offset;
@@ -55,7 +55,7 @@ typedef struct VirtIOBalloon {
     QEMUBH *free_page_bh;
     /*
      * Lock to synchronize threads to access the free page reporting related
-     * fields (e.g. free_page_report_status).
+     * fields (e.g. free_page_hint_status).
      */
     QemuMutex free_page_lock;
     QemuCond  free_page_cond;
@@ -64,7 +64,7 @@ typedef struct VirtIOBalloon {
      * stopped.
      */
     bool block_iothread;
-    NotifierWithReturn free_page_report_notify;
+    NotifierWithReturn free_page_hint_notify;
     int64_t stats_last_update;
     int64_t stats_poll_interval;
     uint32_t host_features;


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

