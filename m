Return-Path: virtio-dev-return-5173-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4E2299812B8
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Dec 2018 08:58:10 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue, 11 Dec 2018 16:24:52 +0800
Message-Id: <1544516693-5395-7-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1544516693-5395-1-git-send-email-wei.w.wang@intel.com>
References: <1544516693-5395-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v11 6/7] migration/ram.c: add the free page optimization enable flag
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Cc: pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch adds the free page optimization enable flag, and a function
to set this flag. When the free page optimization is enabled, not all
the pages are needed to be sent in the bulk stage.

Why using a new flag, instead of directly disabling ram_bulk_stage when
the optimization is running?
Thanks for Peter Xu's reminder that disabling ram_bulk_stage will affect
the use of compression. Please see save_page_use_compression. When
xbzrle and compression are used, if free page optimizaion causes the
ram_bulk_stage to be disabled, save_page_use_compression will return
false, which disables the use of compression. That is, if free page
optimization avoids the sending of half of the guest pages, the other
half of pages loses the benefits of compression in the meantime. Using a
new flag to let migration_bitmap_find_dirty skip the free pages in the
bulk stage will avoid the above issue.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h |  1 +
 migration/ram.c          | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 15f8d00..1227279 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -37,6 +37,7 @@ void precopy_infrastructure_init(void);
 void precopy_add_notifier(NotifierWithReturn *n);
 void precopy_remove_notifier(NotifierWithReturn *n);
 int precopy_notify(PrecopyNotifyReason reason, Error **errp);
+void precopy_enable_free_page_optimization(void);
 
 void ram_mig_init(void);
 void qemu_guest_free_page_hint(void *addr, size_t len);
diff --git a/migration/ram.c b/migration/ram.c
index 1e00d92..188bbad 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -290,6 +290,8 @@ struct RAMState {
     uint32_t last_version;
     /* We are in the first round */
     bool ram_bulk_stage;
+    /* The free page optimization is enabled */
+    bool fpo_enabled;
     /* How many times we have dirty too many pages */
     int dirty_rate_high_cnt;
     /* these variables are used for bitmap sync */
@@ -354,6 +356,15 @@ int precopy_notify(PrecopyNotifyReason reason, Error **errp)
     return notifier_with_return_list_notify(&precopy_notifier_list, &pnd);
 }
 
+void precopy_enable_free_page_optimization(void)
+{
+    if (!ram_state) {
+        return;
+    }
+
+    ram_state->fpo_enabled = true;
+}
+
 uint64_t ram_bytes_remaining(void)
 {
     return ram_state ? (ram_state->migration_dirty_pages * TARGET_PAGE_SIZE) :
@@ -1567,7 +1578,11 @@ unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
         return size;
     }
 
-    if (rs->ram_bulk_stage && start > 0) {
+    /*
+     * When the free page optimization is enabled, we need to check the bitmap
+     * to send the non-free pages rather than all the pages in the bulk stage.
+     */
+    if (!rs->fpo_enabled && rs->ram_bulk_stage && start > 0) {
         next = start + 1;
     } else {
         next = find_next_bit(bitmap, size, start);
@@ -2600,6 +2615,7 @@ static void ram_state_reset(RAMState *rs)
     rs->last_page = 0;
     rs->last_version = ram_list.version;
     rs->ram_bulk_stage = true;
+    rs->fpo_enabled = false;
 }
 
 #define MAX_WAIT 50 /* ms, half buffered_file limit */
-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

