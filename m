Return-Path: virtio-dev-return-4316-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id CC8A258191B5
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Jun 2018 01:36:27 -0700 (PDT)
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri,  8 Jun 2018 16:10:41 +0800
Message-Id: <1528445443-43406-5-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1528445443-43406-1-git-send-email-wei.w.wang@intel.com>
References: <1528445443-43406-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v8 4/6] migration/ram.c: add ram save state notifiers
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: peterx@redhat.com, pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch adds a ram save state notifier list, and expose RAMState for
the notifer callbacks to use.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 52 +++++++++++++++++++++++++++++++++++++++
 migration/ram.c          | 64 +++++++++++++++++-------------------------------
 2 files changed, 75 insertions(+), 41 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 113320e..b970d7d 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -16,9 +16,61 @@
 
 #include "exec/cpu-common.h"
 #include "qemu/notify.h"
+#include "qemu/thread.h"
 
 /* migration/ram.c */
 
+typedef enum RamSaveState {
+    RAM_SAVE_ERR = 0,
+    RAM_SAVE_RESET = 1,
+    RAM_SAVE_BEFORE_SYNC_BITMAP = 2,
+    RAM_SAVE_AFTER_SYNC_BITMAP = 3,
+    RAM_SAVE_MAX = 4,
+} RamSaveState;
+
+/* State of RAM for migration */
+typedef struct RAMState {
+    /* QEMUFile used for this migration */
+    QEMUFile *f;
+    /* Last block that we have visited searching for dirty pages */
+    RAMBlock *last_seen_block;
+    /* Last block from where we have sent data */
+    RAMBlock *last_sent_block;
+    /* Last dirty target page we have sent */
+    ram_addr_t last_page;
+    /* last ram version we have seen */
+    uint32_t last_version;
+    /* We are in the first round */
+    bool ram_bulk_stage;
+    /* How many times we have dirty too many pages */
+    int dirty_rate_high_cnt;
+    /* ram save states used for notifiers */
+    int ram_save_state;
+    /* these variables are used for bitmap sync */
+    /* last time we did a full bitmap_sync */
+    int64_t time_last_bitmap_sync;
+    /* bytes transferred at start_time */
+    uint64_t bytes_xfer_prev;
+    /* number of dirty pages since start_time */
+    uint64_t num_dirty_pages_period;
+    /* xbzrle misses since the beginning of the period */
+    uint64_t xbzrle_cache_miss_prev;
+    /* number of iterations at the beginning of period */
+    uint64_t iterations_prev;
+    /* Iterations since start */
+    uint64_t iterations;
+    /* number of dirty bits in the bitmap */
+    uint64_t migration_dirty_pages;
+    /* protects modification of the bitmap */
+    QemuMutex bitmap_mutex;
+    /* The RAMBlock used in the last src_page_requests */
+    RAMBlock *last_req_rb;
+    /* Queue of outstanding page requests from the destination */
+    QemuMutex src_page_req_mutex;
+    QSIMPLEQ_HEAD(src_page_requests, RAMSrcPageRequest) src_page_requests;
+} RAMState;
+
+void add_ram_save_state_change_notifier(Notifier *notify);
 void ram_mig_init(void);
 void qemu_guest_free_page_hint(void *addr, size_t len);
 
diff --git a/migration/ram.c b/migration/ram.c
index 237f11e..d45b5a4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -56,6 +56,9 @@
 #include "qemu/uuid.h"
 #include "savevm.h"
 
+static NotifierList ram_save_state_notifiers =
+    NOTIFIER_LIST_INITIALIZER(ram_save_state_notifiers);
+
 /***********************************************************/
 /* ram save/restore */
 
@@ -267,49 +270,18 @@ struct RAMSrcPageRequest {
     QSIMPLEQ_ENTRY(RAMSrcPageRequest) next_req;
 };
 
-/* State of RAM for migration */
-struct RAMState {
-    /* QEMUFile used for this migration */
-    QEMUFile *f;
-    /* Last block that we have visited searching for dirty pages */
-    RAMBlock *last_seen_block;
-    /* Last block from where we have sent data */
-    RAMBlock *last_sent_block;
-    /* Last dirty target page we have sent */
-    ram_addr_t last_page;
-    /* last ram version we have seen */
-    uint32_t last_version;
-    /* We are in the first round */
-    bool ram_bulk_stage;
-    /* How many times we have dirty too many pages */
-    int dirty_rate_high_cnt;
-    /* these variables are used for bitmap sync */
-    /* last time we did a full bitmap_sync */
-    int64_t time_last_bitmap_sync;
-    /* bytes transferred at start_time */
-    uint64_t bytes_xfer_prev;
-    /* number of dirty pages since start_time */
-    uint64_t num_dirty_pages_period;
-    /* xbzrle misses since the beginning of the period */
-    uint64_t xbzrle_cache_miss_prev;
-    /* number of iterations at the beginning of period */
-    uint64_t iterations_prev;
-    /* Iterations since start */
-    uint64_t iterations;
-    /* number of dirty bits in the bitmap */
-    uint64_t migration_dirty_pages;
-    /* protects modification of the bitmap */
-    QemuMutex bitmap_mutex;
-    /* The RAMBlock used in the last src_page_requests */
-    RAMBlock *last_req_rb;
-    /* Queue of outstanding page requests from the destination */
-    QemuMutex src_page_req_mutex;
-    QSIMPLEQ_HEAD(src_page_requests, RAMSrcPageRequest) src_page_requests;
-};
-typedef struct RAMState RAMState;
-
 static RAMState *ram_state;
 
+void add_ram_save_state_change_notifier(Notifier *notify)
+{
+    notifier_list_add(&ram_save_state_notifiers, notify);
+}
+
+static void notify_ram_save_state_change_notifier(void)
+{
+    notifier_list_notify(&ram_save_state_notifiers, ram_state);
+}
+
 uint64_t ram_bytes_remaining(void)
 {
     return ram_state ? (ram_state->migration_dirty_pages * TARGET_PAGE_SIZE) :
@@ -1139,6 +1111,9 @@ static void migration_bitmap_sync(RAMState *rs)
     int64_t end_time;
     uint64_t bytes_xfer_now;
 
+    rs->ram_save_state = RAM_SAVE_BEFORE_SYNC_BITMAP;
+    notify_ram_save_state_change_notifier();
+
     ram_counters.dirty_sync_count++;
 
     if (!rs->time_last_bitmap_sync) {
@@ -1205,6 +1180,9 @@ static void migration_bitmap_sync(RAMState *rs)
     if (migrate_use_events()) {
         qapi_event_send_migration_pass(ram_counters.dirty_sync_count, NULL);
     }
+
+    rs->ram_save_state = RAM_SAVE_AFTER_SYNC_BITMAP;
+    notify_ram_save_state_change_notifier();
 }
 
 /**
@@ -1961,6 +1939,8 @@ static void ram_state_reset(RAMState *rs)
     rs->last_page = 0;
     rs->last_version = ram_list.version;
     rs->ram_bulk_stage = true;
+    rs->ram_save_state = RAM_SAVE_RESET;
+    notify_ram_save_state_change_notifier();
 }
 
 #define MAX_WAIT 50 /* ms, half buffered_file limit */
@@ -2709,6 +2689,8 @@ out:
 
     ret = qemu_file_get_error(f);
     if (ret < 0) {
+        rs->ram_save_state = RAM_SAVE_ERR;
+        notify_ram_save_state_change_notifier();
         return ret;
     }
 
-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

