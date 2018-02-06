Return-Path: virtio-dev-return-3156-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D35A5818FA0
	for <virtio-dev@lists.oasis-open.org>; Tue,  6 Feb 2018 03:27:31 -0800 (PST)
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue,  6 Feb 2018 19:08:19 +0800
Message-Id: <1517915299-15349-4-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com>
References: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v2 3/3] virtio-balloon: add a timer to limit the free page report waiting time
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch adds a timer to limit the time that host waits for the free
page hints reported by the guest. Users can specify the time in ms via
"free-page-wait-time" command line option. If a user doesn't specify a
time, host waits till the guest finishes reporting all the free page
hints. The policy (wait for all the free page hints to be reported or
use a time limit) is determined by the orchestration layer.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c         | 84 +++++++++++++++++++++++++++++++++++++-
 hw/virtio/virtio-pci.c             |  3 ++
 include/hw/virtio/virtio-balloon.h |  4 ++
 3 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index b424d4e..9ee0de4 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -207,6 +207,65 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
     balloon_stats_change_timer(s, 0);
 }
 
+static void balloon_free_page_change_timer(VirtIOBalloon *s, int64_t ms)
+{
+    timer_mod(s->free_page_timer,
+              qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + ms);
+}
+
+static void balloon_stop_free_page_report(void *opaque)
+{
+    VirtIOBalloon *dev = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+
+    timer_del(dev->free_page_timer);
+    timer_free(dev->free_page_timer);
+    dev->free_page_timer = NULL;
+
+    if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START) {
+        dev->host_stop_free_page = true;
+        virtio_notify_config(vdev);
+    }
+}
+
+static void balloon_free_page_get_wait_time(Object *obj, Visitor *v,
+                                            const char *name, void *opaque,
+                                            Error **errp)
+{
+    VirtIOBalloon *s = opaque;
+
+    visit_type_int(v, name, &s->free_page_wait_time, errp);
+}
+
+static void balloon_free_page_set_wait_time(Object *obj, Visitor *v,
+                                            const char *name, void *opaque,
+                                            Error **errp)
+{
+    VirtIOBalloon *s = opaque;
+    Error *local_err = NULL;
+    int64_t value;
+
+    visit_type_int(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    if (value < 0) {
+        error_setg(errp, "free page wait time must be greater than zero");
+        return;
+    }
+
+    if (value > UINT32_MAX) {
+        error_setg(errp, "free page wait time value is too big");
+        return;
+    }
+
+    s->free_page_wait_time = value;
+    g_assert(s->free_page_timer == NULL);
+    s->free_page_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
+                                      balloon_stop_free_page_report, s);
+}
+
 static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
@@ -330,6 +389,7 @@ static void virtio_balloon_poll_free_page_hints(VirtIOBalloon *dev)
             if (id == dev->free_page_report_cmd_id) {
                 dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
             } else {
+                dev->host_stop_free_page = false;
                 dev->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
                 break;
             }
@@ -385,6 +445,10 @@ static void virtio_balloon_free_page_poll(void *opaque)
     virtio_notify_config(vdev);
     s->free_page_report_status = FREE_PAGE_REPORT_S_REQUESTED;
 
+    if (s->free_page_wait_time) {
+        balloon_free_page_change_timer(s, s->free_page_wait_time);
+    }
+
     virtio_balloon_poll_free_page_hints(s);
 }
 
@@ -395,7 +459,19 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
 
     config.num_pages = cpu_to_le32(dev->num_pages);
     config.actual = cpu_to_le32(dev->actual);
-    config.free_page_report_cmd_id = cpu_to_le32(dev->free_page_report_cmd_id);
+    if (dev->host_stop_free_page) {
+        /*
+         * Host is actively requesting to stop the free page reporting, send
+         * the stop sign to the guest. This happens when the migration thread
+         * has reached the phase to send pages to the destination while the
+         * guest hasn't done the reporting.
+         */
+        config.free_page_report_cmd_id =
+                                    VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID;
+    } else {
+        config.free_page_report_cmd_id =
+                                    cpu_to_le32(dev->free_page_report_cmd_id);
+    }
 
     trace_virtio_balloon_get_config(config.num_pages, config.actual);
     memcpy(config_data, &config, sizeof(struct virtio_balloon_config));
@@ -539,6 +615,7 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
         s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE, NULL);
         s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
         s->free_page_report_cmd_id = VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID;
+        s->host_stop_free_page = false;
     }
     reset_stats(s);
 }
@@ -602,6 +679,11 @@ static void virtio_balloon_instance_init(Object *obj)
                         balloon_stats_get_poll_interval,
                         balloon_stats_set_poll_interval,
                         NULL, s, NULL);
+
+    object_property_add(obj, "free-page-wait-time", "int",
+                        balloon_free_page_get_wait_time,
+                        balloon_free_page_set_wait_time,
+                        NULL, s, NULL);
 }
 
 static const VMStateDescription vmstate_virtio_balloon = {
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 6c75cca..3345104 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2250,6 +2250,9 @@ static void virtio_balloon_pci_instance_init(Object *obj)
     object_property_add_alias(obj, "guest-stats-polling-interval",
                               OBJECT(&dev->vdev),
                               "guest-stats-polling-interval", &error_abort);
+    object_property_add_alias(obj, "free-page-wait-time",
+                              OBJECT(&dev->vdev),
+                              "free-page-wait-time", &error_abort);
 }
 
 static const TypeInfo virtio_balloon_pci_info = {
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 11b4e01..c16855b 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -40,6 +40,8 @@ enum virtio_balloon_free_page_report_status {
 typedef struct VirtIOBalloon {
     VirtIODevice parent_obj;
     VirtQueue *ivq, *dvq, *svq, *free_page_vq;
+    /* Host is requesting the guest to stop free page reporting */
+    bool host_stop_free_page;
     uint32_t free_page_report_status;
     uint32_t num_pages;
     uint32_t actual;
@@ -49,8 +51,10 @@ typedef struct VirtIOBalloon {
     VirtQueueElement *stats_vq_elem;
     size_t stats_vq_offset;
     QEMUTimer *stats_timer;
+    QEMUTimer *free_page_timer;
     int64_t stats_last_update;
     int64_t stats_poll_interval;
+    int64_t free_page_wait_time;
     uint32_t host_features;
 } VirtIOBalloon;
 
-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

