Return-Path: virtio-dev-return-5171-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 42DE4985C81
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Dec 2018 08:57:59 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue, 11 Dec 2018 16:24:49 +0800
Message-Id: <1544516693-5395-4-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1544516693-5395-1-git-send-email-wei.w.wang@intel.com>
References: <1544516693-5395-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v11 3/7] migration: use bitmap_mutex in migration_bitmap_clear_dirty
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Cc: pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

The bitmap mutex is used to synchronize threads to update the dirty
bitmap and the migration_dirty_pages counter. For example, the free
page optimization clears bits of free pages from the bitmap in an
iothread context. This patch makes migration_bitmap_clear_dirty update
the bitmap and counter under the mutex.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Peter Xu <peterx@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 7e7deec..01d267f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -316,7 +316,7 @@ struct RAMState {
     uint64_t target_page_count;
     /* number of dirty bits in the bitmap */
     uint64_t migration_dirty_pages;
-    /* protects modification of the bitmap */
+    /* Protects modification of the bitmap and migration dirty pages */
     QemuMutex bitmap_mutex;
     /* The RAMBlock used in the last src_page_requests */
     RAMBlock *last_req_rb;
@@ -1556,11 +1556,14 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
 {
     bool ret;
 
+    qemu_mutex_lock(&rs->bitmap_mutex);
     ret = test_and_clear_bit(page, rb->bmap);
 
     if (ret) {
         rs->migration_dirty_pages--;
     }
+    qemu_mutex_unlock(&rs->bitmap_mutex);
+
     return ret;
 }
 
-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

