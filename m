Return-Path: virtio-dev-return-3690-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7ED1258191D7
	for <virtio-dev@lists.oasis-open.org>; Sun,  1 Apr 2018 02:33:31 -0700 (PDT)
From: Si-Wei Liu <si-wei.liu@oracle.com>
Date: Sun,  1 Apr 2018 05:13:08 -0400
Message-Id: <1522573990-5242-2-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
References: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
Subject: [virtio-dev] [RFC PATCH 1/3] qemu: virtio-bypass should explicitly bind to a passthrough device
To: mst@redhat.com, jiri@resnulli.us, stephen@networkplumber.org, alexander.h.duyck@intel.com, davem@davemloft.net, jesse.brandeburg@intel.com, kubakici@wp.pl, jasowang@redhat.com, sridhar.samudrala@intel.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

The new backup option allows guest virtio-bypass driver to explicitly
bind to a corresponding passthrough instance, which is identifiable by
the <bus>:<slot>.<function> notation. MAC address is still validated
in the guest but not the only criteria for pairing two devices.
MAC address is more a matter of network configuration than a (virtual)
device identifier, the latter of which needs to be unique as part of
VM configuration. Techinically it's possible there exists more than
one device in the guest configured with the same MAC, but each belongs
to completely isolated network.

The direct benefit as a result of the explicit binding (or pairing),
apparently, is the prohibition of improper binding or malicious pairing
due to any flexiblility in terms of guest MAC address config.

What's more important, the indicator of guest device location can even
be used as a means to reserve the slot for the corresponding passthrough
device in the PCI bus tree if such device is temporarily absent, but
yet to be hot plugged into the VM. We'd need to preserve the slot for
the passthrough device to which virtio-bypass is bound, such that once
it is plugged out as a result of migration we can ensure the slot
wouldn't be occupied by other devices, and any user-space application
assumes consistent device location in the bus tree still works.

The usage for the backup option is as follows:

   -device virtio-net-pci, ... ,backup=<bus-id>:<slot>[.<function>]

for e.g.

   -device virtio-net-pci,id=net0,mac=52:54:00:e0:58:80,backup=pci.2:0x3
   ...
   -device vfio-pci,host=02:10.1,id=hostdev0,bus=pci.2,addr=0x3

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 hw/net/virtio-net.c                         | 29 ++++++++++++-
 include/hw/pci/pci.h                        |  3 ++
 include/hw/virtio/virtio-net.h              |  2 +
 include/standard-headers/linux/virtio_net.h |  1 +
 qdev-monitor.c                              | 64 +++++++++++++++++++++++++++++
 5 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index de31b1b98c..a36b169958 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -26,6 +26,7 @@
 #include "qapi-event.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
+#include "hw/pci/pci.h"
 
 #define VIRTIO_NET_VM_VERSION    11
 
@@ -61,6 +62,8 @@ static VirtIOFeature feature_sizes[] = {
      .end = endof(struct virtio_net_config, max_virtqueue_pairs)},
     {.flags = 1 << VIRTIO_NET_F_MTU,
      .end = endof(struct virtio_net_config, mtu)},
+    {.flags = 1 << VIRTIO_NET_F_BACKUP,
+     .end = endof(struct virtio_net_config, bsf2backup)},
     {}
 };
 
@@ -84,10 +87,24 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
     struct virtio_net_config netcfg;
+    uint16_t busdevfn;
 
     virtio_stw_p(vdev, &netcfg.status, n->status);
     virtio_stw_p(vdev, &netcfg.max_virtqueue_pairs, n->max_queues);
     virtio_stw_p(vdev, &netcfg.mtu, n->net_conf.mtu);
+    if (n->net_conf.backup) {
+        /* Below function should not fail as the backup ID string
+         * has been validated when device is being realized.
+         * Until guest starts to run we can can get to the
+         * effective bus num in use from pci config space where
+         * guest had written to.
+         */
+        pci_get_busdevfn_by_id(n->net_conf.backup, &busdevfn,
+                               NULL, NULL);
+        busdevfn <<= 8;
+        busdevfn |= (n->backup_devfn & 0xFF);
+        virtio_stw_p(vdev, &netcfg.bsf2backup, busdevfn);
+    }
     memcpy(netcfg.mac, n->mac, ETH_ALEN);
     memcpy(config, &netcfg, n->config_size);
 }
@@ -1935,11 +1952,19 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIONet *n = VIRTIO_NET(dev);
     NetClientState *nc;
+    uint16_t bdevfn;
     int i;
 
     if (n->net_conf.mtu) {
         n->host_features |= (0x1 << VIRTIO_NET_F_MTU);
     }
+    if (n->net_conf.backup) {
+        if (pci_get_busdevfn_by_id(n->net_conf.backup, NULL,
+                                   &bdevfn, errp))
+            return;
+        n->backup_devfn = bdevfn;
+        n->host_features |= (0x1 << VIRTIO_NET_F_BACKUP);
+    }
 
     virtio_net_set_config_size(n, n->host_features);
     virtio_init(vdev, "virtio-net", VIRTIO_ID_NET, n->config_size);
@@ -2160,8 +2185,8 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_UINT16("host_mtu", VirtIONet, net_conf.mtu, 0),
     DEFINE_PROP_BOOL("x-mtu-bypass-backend", VirtIONet, mtu_bypass_backend,
                      true),
-    DEFINE_PROP_BIT("backup", VirtIONet, host_features,
-                     VIRTIO_NET_F_BACKUP, false),
+    DEFINE_PROP_STRING("backup", VirtIONet, net_conf.backup),
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index d8c18c7fa4..dbb910d162 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -431,6 +431,9 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
 
 PCIDevice *pci_vga_init(PCIBus *bus);
 
+int pci_get_busdevfn_by_id(const char *id, uint16_t *busnr,
+                           uint16_t *devfn, Error **errp);
+
 static inline PCIBus *pci_get_bus(const PCIDevice *dev)
 {
     return PCI_BUS(qdev_get_parent_bus(DEVICE(dev)));
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index b81b6a4624..276b39f64f 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -38,6 +38,7 @@ typedef struct virtio_net_conf
     uint16_t rx_queue_size;
     uint16_t tx_queue_size;
     uint16_t mtu;
+    char *backup;
 } virtio_net_conf;
 
 /* Maximum packet size we can receive from tap device: header + 64k */
@@ -99,6 +100,7 @@ typedef struct VirtIONet {
     int announce_counter;
     bool needs_vnet_hdr_swap;
     bool mtu_bypass_backend;
+    uint16_t backup_devfn;
 } VirtIONet;
 
 void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
index 65dde3209d..cd936e5521 100644
--- a/include/standard-headers/linux/virtio_net.h
+++ b/include/standard-headers/linux/virtio_net.h
@@ -79,6 +79,7 @@ struct virtio_net_config {
 	uint16_t max_virtqueue_pairs;
 	/* Default maximum transmit unit advice */
 	uint16_t mtu;
+	uint16_t bsf2backup;
 } QEMU_PACKED;
 
 /*
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 846238175f..600a81c73e 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -32,6 +32,8 @@
 #include "qemu/help_option.h"
 #include "qemu/option.h"
 #include "sysemu/block-backend.h"
+#include "hw/pci/pci.h"
+#include "hw/vfio/pci.h"
 #include "migration/misc.h"
 
 /*
@@ -896,6 +898,68 @@ void qmp_device_del(const char *id, Error **errp)
     }
 }
 
+int pci_get_busdevfn_by_id(const char *id, uint16_t *busnr,
+                           uint16_t *devfn, Error **errp)
+{
+    uint16_t busnum = 0, slot = 0, func = 0;
+    const char *pc, *pd, *pe;
+    Error *local_err = NULL;
+    ObjectClass *class;
+    char value[1024];
+    BusState *bus;
+    uint64_t u64;
+
+    if (!(pc = strchr(id, ':'))) {
+        error_setg(errp, "Invalid id: backup=%s, "
+                   "correct format should be backup="
+                   "'<bus-id>:<slot>[.<function>]'", id);
+        return -1;
+    }
+    get_opt_name(value, sizeof(value), id, ':');
+    if (pc != id + 1) {
+        bus = qbus_find(value, errp);
+        if (!bus)
+            return -1;
+
+        class = object_get_class(OBJECT(bus));
+        if (class != object_class_by_name(TYPE_PCI_BUS) &&
+            class != object_class_by_name(TYPE_PCIE_BUS)) {
+            error_setg(errp, "%s is not a device on pci bus", id);
+            return -1;
+        }
+        busnum = (uint16_t)pci_bus_num(PCI_BUS(bus));
+    }
+
+    if (!devfn)
+        goto out;
+
+    pd = strchr(pc, '.');
+    pe = get_opt_name(value, sizeof(value), pc + 1, '.');
+    if (pe != pc + 1) {
+        parse_option_number("slot", value, &u64, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return -1;
+        }
+        slot = (uint16_t)u64;
+    }
+    if (pd && *(pd + 1) != '\0') {
+        parse_option_number("function", pd, &u64, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return -1;
+        }
+        func = (uint16_t)u64;
+    }
+
+out:
+    if (busnr)
+        *busnr = busnum;
+    if (devfn)
+        *devfn = ((slot & 0x1F) << 3) | (func & 0x7);
+    return 0;
+}
+
 BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
 {
     DeviceState *dev;
-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

