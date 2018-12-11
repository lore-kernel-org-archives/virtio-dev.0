Return-Path: virtio-dev-return-5169-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3B43A985C84
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Dec 2018 08:58:01 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue, 11 Dec 2018 16:24:50 +0800
Message-Id: <1544516693-5395-5-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1544516693-5395-1-git-send-email-wei.w.wang@intel.com>
References: <1544516693-5395-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v11 4/7] migration: API to clear bits of guest free pages from the dirty bitmap
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Cc: pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch adds an API to clear bits corresponding to guest free pages
from the dirty bitmap. Spilt the free page block if it crosses the QEMU
RAMBlock boundary.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Peter Xu <peterx@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h |  2 ++
 migration/ram.c          | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

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
 
diff --git a/migration/ram.c b/migration/ram.c
index 01d267f..c13b44f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3131,6 +3131,53 @@ static void ram_state_resume_prepare(RAMState *rs, QEMUFile *out)
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
+    for (; len > 0; len -= used_len, addr += used_len) {
+        block = qemu_ram_block_from_host(addr, false, &offset);
+        if (unlikely(!block || offset >= block->used_length)) {
+            /*
+             * The implementation might not support RAMBlock resize during
+             * live migration, but it could happen in theory with future
+             * updates. So we add a check here to capture that case.
+             */
+            error_report_once("%s unexpected error", __func__);
+            return;
+        }
+
+        if (len <= block->used_length - offset) {
+            used_len = len;
+        } else {
+            used_len = block->used_length - offset;
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

