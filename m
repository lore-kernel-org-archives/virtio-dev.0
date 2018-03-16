Return-Path: virtio-dev-return-3581-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FBBD5819030
	for <virtio-dev@lists.oasis-open.org>; Fri, 16 Mar 2018 04:07:32 -0700 (PDT)
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 16 Mar 2018 18:48:27 +0800
Message-Id: <1521197309-13544-4-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1521197309-13544-1-git-send-email-wei.w.wang@intel.com>
References: <1521197309-13544-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v5 3/5] migration: API to clear bits of guest free pages from the dirty bitmap
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch adds an API to clear bits corresponding to guest free pages
from the dirty bitmap. Spilt the free page block if it crosses the QEMU
RAMBlock boundary.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
---
 include/migration/misc.h |  2 ++
 migration/ram.c          | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 77fd4f5..fae1acf 100644
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
index 38c991d..2e82181 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2193,6 +2193,50 @@ static int ram_init_all(RAMState **rsp)
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
+
+    for (; len > 0; len -= used_len) {
+        block = qemu_ram_block_from_host(addr, false, &offset);
+        if (unlikely(!block)) {
+            return;
+        }
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

