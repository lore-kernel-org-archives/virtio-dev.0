Return-Path: virtio-dev-return-3367-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A9C8C1CB807D
	for <virtio-dev@lists.oasis-open.org>; Fri,  2 Mar 2018 01:06:33 -0800 (PST)
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri,  2 Mar 2018 16:47:28 +0800
Message-Id: <1519980450-3404-2-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1519980450-3404-1-git-send-email-wei.w.wang@intel.com>
References: <1519980450-3404-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v3 1/3] migration: API to clear bits of guest free pages from the dirty bitmap
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
 migration/ram.c          | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

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
index 5e33e5c..769a0f6 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2189,6 +2189,26 @@ static int ram_init_all(RAMState **rsp)
     return 0;
 }
 
+void qemu_guest_free_page_hint(void *addr, size_t len)
+{
+    RAMBlock *block;
+    ram_addr_t offset;
+    size_t used_len, start, npages;
+
+    for (used_len = len; len > 0; len -= used_len) {
+        block = qemu_ram_block_from_host(addr, false, &offset);
+        if (unlikely(offset + len > block->used_length)) {
+            used_len = block->used_length - offset;
+            addr += used_len;
+        }
+
+        start = offset >> TARGET_PAGE_BITS;
+        npages = used_len >> TARGET_PAGE_BITS;
+        bitmap_clear(block->bmap, start, npages);
+        ram_state->migration_dirty_pages -= npages;
+    }
+}
+
 /*
  * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
  * long-running RCU critical section.  When rcu-reclaims in the code
-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

