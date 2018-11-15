Return-Path: virtio-dev-return-4962-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 21008985E37
	for <virtio-dev@lists.oasis-open.org>; Thu, 15 Nov 2018 10:41:17 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Thu, 15 Nov 2018 18:08:02 +0800
Message-Id: <1542276484-25508-7-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v9 6/8] migration/ram.c: add a function to disable the bulk stage
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: peterx@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch adds a function to enable a precopy notifier callback outside
the migration subsystem to disable the bulk stage flag. This is needed by
the free page optimization offered by virtio-balloon.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 1 +
 migration/ram.c          | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 0bac623..67cb275 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -30,6 +30,7 @@ typedef enum PrecopyNotifyReason {
 void precopy_infrastructure_init(void);
 void precopy_add_notifier(Notifier *n);
 void precopy_remove_notifier(Notifier *n);
+void precopy_disable_bulk_stage(void);
 
 void ram_mig_init(void);
 void qemu_guest_free_page_hint(void *addr, size_t len);
diff --git a/migration/ram.c b/migration/ram.c
index 65b1223..8745ca3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -352,6 +352,15 @@ static void precopy_notify(PrecopyNotifyReason reason)
     notifier_list_notify(&precopy_notifier_list, &reason);
 }
 
+void precopy_disable_bulk_stage(void)
+{
+    if (!ram_state) {
+        return;
+    }
+
+    ram_state->ram_bulk_stage = false;
+}
+
 uint64_t ram_bytes_remaining(void)
 {
     return ram_state ? (ram_state->migration_dirty_pages * TARGET_PAGE_SIZE) :
-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

