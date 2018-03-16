Return-Path: virtio-dev-return-3582-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A4FA45818FA3
	for <virtio-dev@lists.oasis-open.org>; Fri, 16 Mar 2018 04:07:40 -0700 (PDT)
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 16 Mar 2018 18:48:26 +0800
Message-Id: <1521197309-13544-3-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1521197309-13544-1-git-send-email-wei.w.wang@intel.com>
References: <1521197309-13544-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v5 2/5] migration: use bitmap_mutex in migration_bitmap_clear_dirty
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

The bitmap mutex is used to synchronize threads to update the dirty
bitmap and the migration_dirty_pages count. This patch makes
migration_bitmap_clear_dirty update the bitmap and count under the
mutex.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
---
 migration/ram.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 7266351..38c991d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -790,11 +790,14 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
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

