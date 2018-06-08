Return-Path: virtio-dev-return-4317-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 536A258191B5
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Jun 2018 01:36:30 -0700 (PDT)
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri,  8 Jun 2018 16:10:42 +0800
Message-Id: <1528445443-43406-6-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1528445443-43406-1-git-send-email-wei.w.wang@intel.com>
References: <1528445443-43406-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v8 5/6] migration: move migrate_postcopy() to include/migration/misc.h
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: peterx@redhat.com, pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

The ram save state notifier callback, for example the free page
optimization offerred by virtio-balloon, may need to check if
postcopy is in use, so move migrate_postcopy() to the outside header.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 1 +
 migration/migration.h    | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index b970d7d..911aaf3 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -109,6 +109,7 @@ bool migration_has_failed(MigrationState *);
 /* ...and after the device transmission */
 bool migration_in_postcopy_after_devices(MigrationState *);
 void migration_global_dump(Monitor *mon);
+bool migrate_postcopy(void);
 
 /* migration/block-dirty-bitmap.c */
 void dirty_bitmap_mig_init(void);
diff --git a/migration/migration.h b/migration/migration.h
index 5a74740..fee5af8 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -236,8 +236,6 @@ bool migration_is_blocked(Error **errp);
 bool migration_in_postcopy(void);
 MigrationState *migrate_get_current(void);
 
-bool migrate_postcopy(void);
-
 bool migrate_release_ram(void);
 bool migrate_postcopy_ram(void);
 bool migrate_zero_blocks(void);
-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

