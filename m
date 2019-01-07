Return-Path: virtio-dev-return-5279-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4C4D5985B8B
	for <virtio-dev@lists.oasis-open.org>; Mon,  7 Jan 2019 22:30:24 +0000 (UTC)
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Mon,  7 Jan 2019 17:29:44 -0500
Message-Id: <1546900184-27403-6-git-send-email-venu.busireddy@oracle.com>
In-Reply-To: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
Subject: [virtio-dev] [PATCH v3 5/5] pci: query command extension to check the bus master enabling status of the failover-primary device
To: venu.busireddy@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

From: Si-Wei Liu <si-wei.liu@oracle.com>

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
---
 hmp.c          | 5 +++++
 hw/pci/pci.c   | 5 +++++
 qapi/misc.json | 5 ++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hmp.c b/hmp.c
index 7828f93..7a75c93 100644
--- a/hmp.c
+++ b/hmp.c
@@ -890,6 +890,11 @@ static void hmp_info_pci_device(Monitor *mon, const PciDeviceInfo *dev)
         }
     }
 
+    if (dev->has_failover_status) {
+        monitor_printf(mon, "      Failover primary, bus master %s.\n",
+                       dev->failover_status ? "enabled" : "disabled");
+    }
+
     monitor_printf(mon, "      id \"%s\"\n", dev->qdev_id);
 
     if (dev->has_pci_bridge) {
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 56b13b3..9da49fd 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1761,6 +1761,11 @@ static PciDeviceInfo *qmp_query_pci_device(PCIDevice *dev, PCIBus *bus,
             pci_get_word(dev->config + PCI_CB_SUBSYSTEM_VENDOR_ID);
     }
 
+    if (dev->failover_primary) {
+        info->has_failover_status = true;
+        info->failover_status = dev->bus_master_enable_region.enabled;
+    }
+
     return info;
 }
 
diff --git a/qapi/misc.json b/qapi/misc.json
index 6c1c5c0..05f003e 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -865,6 +865,9 @@
 #
 # @regions: a list of the PCI I/O regions associated with the device
 #
+# @failover_status: if 'failover-primary' property is 'true', true if PCI
+#                   bus master bit on the device is enabled
+#
 # Notes: the contents of @class_info.desc are not stable and should only be
 #        treated as informational.
 #
@@ -874,7 +877,7 @@
   'data': {'bus': 'int', 'slot': 'int', 'function': 'int',
            'class_info': 'PciDeviceClass', 'id': 'PciDeviceId',
            '*irq': 'int', 'qdev_id': 'str', '*pci_bridge': 'PciBridgeInfo',
-           'regions': ['PciMemoryRegion']} }
+           'regions': ['PciMemoryRegion'], '*failover_status': 'bool'} }
 
 ##
 # @PciInfo:

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

