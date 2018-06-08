Return-Path: virtio-dev-return-4315-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 0AED61CB807B
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Jun 2018 01:36:23 -0700 (PDT)
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri,  8 Jun 2018 16:10:40 +0800
Message-Id: <1528445443-43406-4-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1528445443-43406-1-git-send-email-wei.w.wang@intel.com>
References: <1528445443-43406-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v8 3/6] migration: API to clear bits of guest free pages from the dirty bitmap
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: peterx@redhat.com, pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch adds an API to clear bits corresponding to guest free pages
from the dirty bitmap. Spilt the free page block if it crosses the QEMU
RAMBlock boundary.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h |  2 ++
 migration/migration.c    |  2 +-
 migration/migration.h    |  1 +
 migration/ram.c          | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 4ebf24c..113320e 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -14,11 +14,13 @@
 #ifndef MIGRATION_MISC_H
 #define MIGRATION_MISC_H
 
+#include "exec/cpu-common.h"
 #include "qemu/notify.h"
 
 /* migration/ram.c */
 
 void ram_mig_init(void);
+void qemu_guest_free_page_hint(void *addr, size_t len);
 
 /* migration/block.c */
 
diff --git a/migration/migration.c b/migration/migration.c
index 05aec2c..220ff48 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -647,7 +647,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
  * Return true if we're already in the middle of a migration
  * (i.e. any of the active or setup states)
  */
-static bool migration_is_setup_or_active(int state)
+bool migration_is_setup_or_active(int state)
 {
     switch (state) {
     case MIGRATION_STATUS_ACTIVE:
diff --git a/migration/migration.h b/migration/migration.h
index 8f0c821..5a74740 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -230,6 +230,7 @@ void migrate_fd_error(MigrationState *s, const Error *error);
 void migrate_fd_connect(MigrationState *s, Error *error_in);
 
 void migrate_init(MigrationState *s);
+bool migration_is_setup_or_active(int state);
 bool migration_is_blocked(Error **errp);
 /* True if outgoing migration has entered postcopy phase */
 bool migration_in_postcopy(void);
diff --git a/migration/ram.c b/migration/ram.c
index 2eabbe9..237f11e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2530,6 +2530,54 @@ static void ram_state_resume_prepare(RAMState *rs, QEMUFile *out)
 }
 
 /*
+ * This function clears bits of the free pages reported by the caller from the
+ * migration dirty bitmap. @addr is the host address corresponding to the
+ * start of the continuous guest free pages, and @len is the total bytes of
+ * those pages.
+ */
+void qemu_guest_free_page_hint(void *addr, size_t len)
+{
+    RAMBlock *block;
+    ram_addr_t offset;
+    size_t used_len, start, npages;
+    MigrationState *s = migrate_get_current();
+
+    /* This function is currently expected to be used during live migration */
+    if (!migration_is_setup_or_active(s->state)) {
+        return;
+    }
+
+    for (; len > 0; len -= used_len) {
+        block = qemu_ram_block_from_host(addr, false, &offset);
+        assert(block);
+
+        /*
+         * This handles the case that the RAMBlock is resized after the free
+         * page hint is reported.
+         */
+        if (unlikely(offset > block->used_length)) {
+            return;
+        }
+
+        if (len <= block->used_length - offset) {
+            used_len = len;
+        } else {
+            used_len = block->used_length - offset;
+            addr += used_len;
+        }
+
+        start = offset >> TARGET_PAGE_BITS;
+        npages = used_len >> TARGET_PAGE_BITS;
+
+        qemu_mutex_lock(&ram_state->bitmap_mutex);
+        ram_state->migration_dirty_pages -=
+                      bitmap_count_one_with_offset(block->bmap, start, npages);
+        bitmap_clear(block->bmap, start, npages);
+        qemu_mutex_unlock(&ram_state->bitmap_mutex);
+    }
+}
+
+/*
  * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
  * long-running RCU critical section.  When rcu-reclaims in the code
  * start to become numerous it will be necessary to reduce the
-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

