Return-Path: virtio-dev-return-4961-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A8EA9985E52
	for <virtio-dev@lists.oasis-open.org>; Thu, 15 Nov 2018 10:41:15 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Thu, 15 Nov 2018 18:08:01 +0800
Message-Id: <1542276484-25508-6-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v9 5/8] migration/ram.c: add a notifier chain for precopy
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: peterx@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch adds a notifier chain for the memory precopy. This enables various
precopy optimizations to be invoked at specific places.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 12 ++++++++++++
 migration/ram.c          | 31 +++++++++++++++++++++++++++++++
 vl.c                     |  1 +
 3 files changed, 44 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 113320e..0bac623 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -19,6 +19,18 @@
 
 /* migration/ram.c */
 
+typedef enum PrecopyNotifyReason {
+    PRECOPY_NOTIFY_ERR = 0,
+    PRECOPY_NOTIFY_START_ITERATION = 1,
+    PRECOPY_NOTIFY_BEFORE_SYNC_BITMAP = 2,
+    PRECOPY_NOTIFY_AFTER_SYNC_BITMAP = 3,
+    PRECOPY_NOTIFY_MAX = 4,
+} PrecopyNotifyReason;
+
+void precopy_infrastructure_init(void);
+void precopy_add_notifier(Notifier *n);
+void precopy_remove_notifier(Notifier *n);
+
 void ram_mig_init(void);
 void qemu_guest_free_page_hint(void *addr, size_t len);
 
diff --git a/migration/ram.c b/migration/ram.c
index 229b791..65b1223 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -292,6 +292,8 @@ struct RAMState {
     bool ram_bulk_stage;
     /* How many times we have dirty too many pages */
     int dirty_rate_high_cnt;
+    /* ram save states used for notifiers */
+    int ram_save_state;
     /* these variables are used for bitmap sync */
     /* last time we did a full bitmap_sync */
     int64_t time_last_bitmap_sync;
@@ -328,6 +330,28 @@ typedef struct RAMState RAMState;
 
 static RAMState *ram_state;
 
+static NotifierList precopy_notifier_list;
+
+void precopy_infrastructure_init(void)
+{
+    notifier_list_init(&precopy_notifier_list);
+}
+
+void precopy_add_notifier(Notifier *n)
+{
+    notifier_list_add(&precopy_notifier_list, n);
+}
+
+void precopy_remove_notifier(Notifier *n)
+{
+    notifier_remove(n);
+}
+
+static void precopy_notify(PrecopyNotifyReason reason)
+{
+    notifier_list_notify(&precopy_notifier_list, &reason);
+}
+
 uint64_t ram_bytes_remaining(void)
 {
     return ram_state ? (ram_state->migration_dirty_pages * TARGET_PAGE_SIZE) :
@@ -1642,6 +1666,8 @@ static void migration_bitmap_sync(RAMState *rs)
     int64_t end_time;
     uint64_t bytes_xfer_now;
 
+    precopy_notify(PRECOPY_NOTIFY_BEFORE_SYNC_BITMAP);
+
     ram_counters.dirty_sync_count++;
 
     if (!rs->time_last_bitmap_sync) {
@@ -1699,6 +1725,8 @@ static void migration_bitmap_sync(RAMState *rs)
     if (migrate_use_events()) {
         qapi_event_send_migration_pass(ram_counters.dirty_sync_count);
     }
+
+    precopy_notify(PRECOPY_NOTIFY_AFTER_SYNC_BITMAP);
 }
 
 /**
@@ -2555,6 +2583,8 @@ static void ram_state_reset(RAMState *rs)
     rs->last_page = 0;
     rs->last_version = ram_list.version;
     rs->ram_bulk_stage = true;
+
+    precopy_notify(PRECOPY_NOTIFY_START_ITERATION);
 }
 
 #define MAX_WAIT 50 /* ms, half buffered_file limit */
@@ -3324,6 +3354,7 @@ out:
 
     ret = qemu_file_get_error(f);
     if (ret < 0) {
+        precopy_notify(PRECOPY_NOTIFY_ERR);
         return ret;
     }
 
diff --git a/vl.c b/vl.c
index fa25d1a..48ae0e8 100644
--- a/vl.c
+++ b/vl.c
@@ -3057,6 +3057,7 @@ int main(int argc, char **argv, char **envp)
     module_call_init(MODULE_INIT_OPTS);
 
     runstate_init();
+    precopy_infrastructure_init();
     postcopy_infrastructure_init();
     monitor_init_globals();
 
-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

