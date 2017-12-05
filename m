Return-Path: virtio-dev-return-2741-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A609D581815E
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Dec 2017 19:49:44 -0800 (PST)
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue,  5 Dec 2017 11:33:12 +0800
Message-Id: <1512444796-30615-4-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v3 3/7] virtio/virtio-pci.c: add vhost-pci-net-pci
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Cc: jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com, Wei Wang <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Add the virtio-pci emulation part of the vhost-pci device. BAR2 is used
to expose the remote VM's memory to the guest, and its default size is
set to 64GB.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/virtio-pci.c                         | 55 ++++++++++++++++++++++++++
 hw/virtio/virtio-pci.h                         | 14 +++++++
 include/hw/pci/pci.h                           |  1 +
 include/standard-headers/linux/vhost_pci_net.h |  3 ++
 4 files changed, 73 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index e92837c..2a614b8 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2386,6 +2386,60 @@ static const TypeInfo virtio_net_pci_info = {
     .class_init    = virtio_net_pci_class_init,
 };
 
+/* vhost-pci-net */
+
+static Property vpnet_pci_properties[] = {
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vpnet_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VhostPCINetPCI *dev = VHOST_PCI_NET_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    memory_region_init(&dev->vdev.bar_region, NULL, "RemoteMemory",
+                       REMOTE_MEM_BAR_SIZE);
+    pci_register_bar(&vpci_dev->pci_dev, REMOTE_MEM_BAR_ID,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY |
+                     PCI_BASE_ADDRESS_MEM_PREFETCH |
+                     PCI_BASE_ADDRESS_MEM_TYPE_64,
+                     &dev->vdev.bar_region);
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    virtio_pci_force_virtio_1(vpci_dev);
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void vpnet_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    VirtioPCIClass *vpciklass = VIRTIO_PCI_CLASS(klass);
+
+    k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    k->device_id = PCI_DEVICE_ID_VHOST_PCI_NET;
+    k->class_id = PCI_CLASS_NETWORK_ETHERNET;
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+    dc->props = vpnet_pci_properties;
+    vpciklass->realize = vpnet_pci_realize;
+}
+
+static void vpnet_pci_instance_init(Object *obj)
+{
+    VhostPCINetPCI *dev = VHOST_PCI_NET_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_PCI_NET);
+}
+
+static const TypeInfo vpnet_pci_info = {
+    .name          = TYPE_VHOST_PCI_NET_PCI,
+    .parent        = TYPE_VIRTIO_PCI,
+    .instance_size = sizeof(VhostPCINetPCI),
+    .instance_init = vpnet_pci_instance_init,
+    .class_init    = vpnet_pci_class_init,
+};
+
 /* virtio-rng-pci */
 
 static void virtio_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
@@ -2626,6 +2680,7 @@ static void virtio_pci_register_types(void)
     type_register_static(&virtio_balloon_pci_info);
     type_register_static(&virtio_serial_pci_info);
     type_register_static(&virtio_net_pci_info);
+    type_register_static(&vpnet_pci_info);
 #ifdef CONFIG_VHOST_SCSI
     type_register_static(&vhost_scsi_pci_info);
 #endif
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 12d3a90..cc58c17 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -18,6 +18,7 @@
 #include "hw/pci/msi.h"
 #include "hw/virtio/virtio-blk.h"
 #include "hw/virtio/virtio-net.h"
+#include "hw/virtio/vhost-pci-net.h"
 #include "hw/virtio/virtio-rng.h"
 #include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-scsi.h"
@@ -44,6 +45,7 @@ typedef struct VirtIOSCSIPCI VirtIOSCSIPCI;
 typedef struct VirtIOBalloonPCI VirtIOBalloonPCI;
 typedef struct VirtIOSerialPCI VirtIOSerialPCI;
 typedef struct VirtIONetPCI VirtIONetPCI;
+typedef struct VhostPCINetPCI VhostPCINetPCI;
 typedef struct VHostSCSIPCI VHostSCSIPCI;
 typedef struct VHostUserSCSIPCI VHostUserSCSIPCI;
 typedef struct VirtIORngPCI VirtIORngPCI;
@@ -293,6 +295,18 @@ struct VirtIONetPCI {
 };
 
 /*
+ * vhost-pci-net-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VHOST_PCI_NET_PCI "vhost-pci-net-pci"
+#define VHOST_PCI_NET_PCI(obj) \
+        OBJECT_CHECK(VhostPCINetPCI, (obj), TYPE_VHOST_PCI_NET_PCI)
+
+struct VhostPCINetPCI {
+    VirtIOPCIProxy parent_obj;
+    VhostPCINet vdev;
+};
+
+/*
  * virtio-9p-pci: This extends VirtioPCIProxy.
  */
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 8d02a0a..7911fa8 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -85,6 +85,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
 #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
 #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
+#define PCI_DEVICE_ID_VHOST_PCI_NET      0x1014
 
 #define PCI_VENDOR_ID_REDHAT             0x1b36
 #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
diff --git a/include/standard-headers/linux/vhost_pci_net.h b/include/standard-headers/linux/vhost_pci_net.h
index cfb2413..792261e 100644
--- a/include/standard-headers/linux/vhost_pci_net.h
+++ b/include/standard-headers/linux/vhost_pci_net.h
@@ -29,7 +29,10 @@
 
 #include "standard-headers/linux/virtio_ids.h"
 
+#define REMOTE_MEM_BAR_ID 2
+#define REMOTE_MEM_BAR_SIZE 0x1000000000
 #define METADATA_SIZE 4096
+
 #define MAX_REMOTE_REGION 8
 
 struct vpnet_config {
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

