Return-Path: virtio-dev-return-4559-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 510D21CB807B
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Jun 2018 20:50:00 -0700 (PDT)
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Tue, 26 Jun 2018 22:49:31 -0500
Message-Id: <20180627034935.20276-2-venu.busireddy@oracle.com>
In-Reply-To: <20180627034935.20276-1-venu.busireddy@oracle.com>
References: <20180627034935.20276-1-venu.busireddy@oracle.com>
Subject: [virtio-dev] [PATCH v2 1/4] Add a true or false option to the DEFINE_PROP_UUID macro.
To: venu.busireddy@oracle.com, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

It may not always be desirable to have a random UUID stuffed into the
'_field' member. Add a new boolean option '_default' that will allow
the caller to specify if a random UUID needs be generated or not.

Also modified the instance where this macro is used.

Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
---
 hw/acpi/vmgenid.c            | 2 +-
 include/hw/qdev-properties.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index d78b579a20..6d53757ee5 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -215,7 +215,7 @@ static void vmgenid_realize(DeviceState *dev, Error **errp)
 }
 
 static Property vmgenid_device_properties[] = {
-    DEFINE_PROP_UUID(VMGENID_GUID, VmGenIdState, guid),
+    DEFINE_PROP_UUID(VMGENID_GUID, VmGenIdState, guid, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 4f60cc88f3..7d39a4bdcd 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -218,12 +218,12 @@ extern const PropertyInfo qdev_prop_off_auto_pcibar;
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_off_auto_pcibar, \
                         OffAutoPCIBAR)
 
-#define DEFINE_PROP_UUID(_name, _state, _field) {                  \
+#define DEFINE_PROP_UUID(_name, _state, _field, _default) {        \
         .name      = (_name),                                      \
         .info      = &qdev_prop_uuid,                              \
         .offset    = offsetof(_state, _field)                      \
             + type_check(QemuUUID, typeof_field(_state, _field)),  \
-        .set_default = true,                                       \
+        .set_default = _default,                                   \
         }
 
 #define DEFINE_PROP_END_OF_LIST()               \

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

