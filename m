Return-Path: virtio-dev-return-4963-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4F9A3985E65
	for <virtio-dev@lists.oasis-open.org>; Thu, 15 Nov 2018 10:41:18 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Thu, 15 Nov 2018 18:08:03 +0800
Message-Id: <1542276484-25508-8-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v9 7/8] migration: move migrate_postcopy() to include/migration/misc.h
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: peterx@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

The ram save state notifier callback, for example the free page
optimization offerred by virtio-balloon, may need to check if
postcopy is in use, so move migrate_postcopy() to the outside header.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Peter Xu <peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/misc.h | 1 +
 migration/migration.h    | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 67cb275..06b816f 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -70,6 +70,7 @@ bool migration_has_failed(MigrationState *);
 /* ...and after the device transmission */
 bool migration_in_postcopy_after_devices(MigrationState *);
 void migration_global_dump(Monitor *mon);
+bool migrate_postcopy(void);
 
 /* migration/block-dirty-bitmap.c */
 void dirty_bitmap_mig_init(void);
diff --git a/migration/migration.h b/migration/migration.h
index e413d4d..e1e92ff 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -249,8 +249,6 @@ bool migration_is_blocked(Error **errp);
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

