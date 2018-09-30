Return-Path: virtio-dev-return-4881-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BA23B98402D
	for <virtio-dev@lists.oasis-open.org>; Sun, 30 Sep 2018 13:50:24 +0000 (UTC)
MIME-Version: 1.0
References: <20180918122052.349ba42e.cohuck@redhat.com> <20180918093310-mutt-send-email-mst@kernel.org>
 <20180918151337.GA7432@vbusired-dt> <20180918111540-mutt-send-email-mst@kernel.org>
 <CADGSJ21CujSW=aF7BqdXmSFahLwSgPmG3_KFF5mSeVA5Z8PkQg@mail.gmail.com>
 <20180919230502-mutt-send-email-mst@kernel.org> <CADGSJ22OybVCOsBmqdAHLPBU0PKF13xWz3YtHT=Pw5bT_a71BA@mail.gmail.com>
 <20180920220951-mutt-send-email-mst@kernel.org> <CADGSJ23GRrt25k1G9wD3JhA6en4MuXLE9WA24Ep8PLgkyk_4=A@mail.gmail.com>
 <CAKPgXcEk9Pb_WKdywnQOixtfXGoER0BN82DwNBTjU=ajz53XcA@mail.gmail.com>
 <20180927121621-mutt-send-email-mst@kernel.org> <2f6490b7-258a-328c-4ef8-b95d8438264f@intel.com>
 <CAKPgXcH+_jzWpRE7U_PW3JHtDULpMqK6QJT2umR=HR4rbCFb=A@mail.gmail.com>
In-Reply-To: <CAKPgXcH+_jzWpRE7U_PW3JHtDULpMqK6QJT2umR=HR4rbCFb=A@mail.gmail.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Sun, 30 Sep 2018 16:50:06 +0300
Message-ID: <CAKPgXcG=x_YoJpNUPYxxCXv=4W4Ho-YVDHJXpXNTM3gcFsqAMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY feature
To: sridhar.samudrala@intel.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Siwei Liu <loseweigh@gmail.com>, venu.busireddy@oracle.com, cohuck@redhat.com, virtio-dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

I have created the following pacth which implements the basic
functionality of hiding and plugging the primary device upon acking
the standby feature.
It's not currently implemented for vfio devices but for e1000 as I
don't have access to vfio device on my current setup, however the
implementation
should be similar. I am facing an issue with hotplug handler being
NULL whe calling qdev_get_hotplug_handler even though it did work for
me before,
if anyone has any idea what the issue could be it would be much appreciated.

I think there should be a structure which describes the state of the
primary device in order to implement the migration feature.

Please share your thoughts and insights

commit 39a350ee65a26ab6ede4c08b3ca3b9e945fcf305 (HEAD -> failover)
Author: Sameeh Jubran <sjubran@redhat.com>
Date:   Sun Sep 16 13:21:41 2018 +0300

    virtio-net: Implement standby feature

    Signed-off-by: Sameeh Jubran <sjubran@redhat.com>

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 13a9494a8d..026b8631ed 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -36,6 +36,8 @@
 #include "qemu/range.h"

 #include "e1000x_common.h"
+#include "hw/virtio/virtio-net.h"
+#include "hw/virtio/virtio-pci.h"

 static const uint8_t bcast[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};

@@ -118,6 +120,7 @@ typedef struct E1000State_st {
     bool mit_timer_on;         /* Mitigation timer is running. */
     bool mit_irq_level;        /* Tracks interrupt pin level. */
     uint32_t mit_ide;          /* Tracks E1000_TXD_CMD_IDE bit. */
+    char *primary_id_str;

 /* Compatibility flags for migration to/from qemu 1.3.0 and older */
 #define E1000_FLAG_AUTONEG_BIT 0
@@ -1652,9 +1655,16 @@ static void e1000_write_config(PCIDevice
*pci_dev, uint32_t address,
     }
 }

+static bool standby_device_present(const char *id,
+        struct PCIDevice **pdev)
+{
+    return pci_qdev_find_device(id, pdev) >= 0;
+}
+
 static void pci_e1000_realize(PCIDevice *pci_dev, Error **errp)
 {
     DeviceState *dev = DEVICE(pci_dev);
+    PCIDevice *standby_pci_dev;
     E1000State *d = E1000(pci_dev);
     uint8_t *pci_conf;
     uint8_t *macaddr;
@@ -1690,6 +1700,12 @@ static void pci_e1000_realize(PCIDevice
*pci_dev, Error **errp)

     d->autoneg_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
e1000_autoneg_timer, d);
     d->mit_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, e1000_mit_timer, d);
+    if (d->primary_id_str && standby_device_present(
+            d->primary_id_str, &standby_pci_dev) && standby_pci_dev) {
+        VirtIOPCIProxy *proxy = VIRTIO_PCI(standby_pci_dev);
+        VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
+        virtio_net_register_primary_device(DEVICE(vdev), dev);
+    }
 }

 static void qdev_e1000_reset(DeviceState *dev)
@@ -1708,6 +1724,7 @@ static Property e1000_properties[] = {
                     compat_flags, E1000_FLAG_MAC_BIT, true),
     DEFINE_PROP_BIT("migrate_tso_props", E1000State,
                     compat_flags, E1000_FLAG_TSO_BIT, true),
+    DEFINE_PROP_STRING("primary", E1000State, primary_id_str),
     DEFINE_PROP_END_OF_LIST(),
 };

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f154756e85..fbe10f4fe1 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -26,7 +26,9 @@
 #include "qapi/qapi-events-net.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
+#include "hw/pci/pci.h"
 #include "standard-headers/linux/ethtool.h"
+#include "hw/vfio/vfio-common.h"

 #define VIRTIO_NET_VM_VERSION    11

@@ -312,9 +314,14 @@ static void virtio_net_set_link_status(NetClientState *nc)
     uint16_t old_status = n->status;

     if (nc->link_down)
+    {
         n->status &= ~VIRTIO_NET_S_LINK_UP;
+    }
     else
+    {
+
         n->status |= VIRTIO_NET_S_LINK_UP;
+    }

     if (n->status != old_status)
         virtio_notify_config(vdev);
@@ -721,6 +728,16 @@ static void virtio_net_set_features(VirtIODevice
*vdev, uint64_t features)
     } else {
         memset(n->vlans, 0xff, MAX_VLAN >> 3);
     }
+
+    if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
+        Error * errp;
+        DeviceState *pdev = DEVICE(n->primary_pdev);
+        DeviceClass *klass = DEVICE_GET_CLASS(pdev);
+        if (klass->hotpluggable && n->primary_hph)
+        {
+            hotplug_handler_plug(n->primary_hph, pdev, &errp);
+        }
+    }
 }

 static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
@@ -1946,6 +1963,41 @@ void virtio_net_set_netclient_name(VirtIONet
*n, const char *name,
     n->netclient_type = g_strdup(type);
 }

+static bool primary_device_present(const char *id, struct PCIDevice **pdev)
+{
+    return pci_qdev_find_device(id, pdev) >= 0 &&
+    vfio_is_vfio_pci(*pdev);
+}
+
+bool virtio_net_register_primary_device(DeviceState *dev, DeviceState
*primary_dev)
+{
+    bool ret = false;
+    VirtIONet *n = VIRTIO_NET(dev);
+    Error *errp;
+    DeviceClass *klass = DEVICE_GET_CLASS(primary_dev);
+
+    if (n->primary_pdev == NULL)
+    {
+        n->primary_pdev = PCI_DEVICE(primary_dev);
+    }
+
+    if (n->primary_hph == NULL)
+    {
+        n->primary_hph = qdev_get_hotplug_handler(primary_dev);
+    }
+
+    /* Hide standby from pci till the feature is acked */
+    if (klass->hotpluggable && n->primary_hph)
+    {
+        object_ref(OBJECT(primary_dev));
+        qdev_simple_device_unplug_cb(n->primary_hph, primary_dev, &errp);
+        n->host_features |= (1ULL << VIRTIO_NET_F_STANDBY);
+        ret = true;
+    }
+
+    return ret;
+}
+
 static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1976,6 +2028,11 @@ static void
virtio_net_device_realize(DeviceState *dev, Error **errp)
         n->host_features |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
     }

+    if (n->net_conf.standby_id_str && primary_device_present(
+        n->net_conf.standby_id_str, &n->primary_pdev)) {
+        virtio_net_register_primary_device(dev, DEVICE(n->primary_pdev));
+    }
+
     virtio_net_set_config_size(n, n->host_features);
     virtio_init(vdev, "virtio-net", VIRTIO_ID_NET, n->config_size);

@@ -2198,6 +2255,7 @@ static Property virtio_net_properties[] = {
                      true),
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
+    DEFINE_PROP_STRING("standby", VirtIONet, net_conf.standby_id_str),
commit 39a350ee65a26ab6ede4c08b3ca3b9e945fcf305 (HEAD -> failover)
Author: Sameeh Jubran <sjubran@redhat.com>
Date:   Sun Sep 16 13:21:41 2018 +0300

    virtio-net: Implement standby feature

    Signed-off-by: Sameeh Jubran <sjubran@redhat.com>

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 13a9494a8d..026b8631ed 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -36,6 +36,8 @@
 #include "qemu/range.h"

 #include "e1000x_common.h"
+#include "hw/virtio/virtio-net.h"
+#include "hw/virtio/virtio-pci.h"

 static const uint8_t bcast[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};

@@ -118,6 +120,7 @@ typedef struct E1000State_st {
     bool mit_timer_on;         /* Mitigation timer is running. */
     bool mit_irq_level;        /* Tracks interrupt pin level. */
     uint32_t mit_ide;          /* Tracks E1000_TXD_CMD_IDE bit. */
+    char *primary_id_str;

 /* Compatibility flags for migration to/from qemu 1.3.0 and older */
 #define E1000_FLAG_AUTONEG_BIT 0
@@ -1652,9 +1655,16 @@ static void e1000_write_config(PCIDevice
*pci_dev, uint32_t address,
     }
 }

+static bool standby_device_present(const char *id,
+        struct PCIDevice **pdev)
+{
+    return pci_qdev_find_device(id, pdev) >= 0;
+}
+
 static void pci_e1000_realize(PCIDevice *pci_dev, Error **errp)
 {
     DeviceState *dev = DEVICE(pci_dev);
+    PCIDevice *standby_pci_dev;
     E1000State *d = E1000(pci_dev);
     uint8_t *pci_conf;
     uint8_t *macaddr;
@@ -1690,6 +1700,12 @@ static void pci_e1000_realize(PCIDevice
*pci_dev, Error **errp)

     d->autoneg_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
e1000_autoneg_timer, d);
     d->mit_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, e1000_mit_timer, d);
+    if (d->primary_id_str && standby_device_present(
+            d->primary_id_str, &standby_pci_dev) && standby_pci_dev) {
+        VirtIOPCIProxy *proxy = VIRTIO_PCI(standby_pci_dev);
+        VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
+        virtio_net_register_primary_device(DEVICE(vdev), dev);
+    }
 }

 static void qdev_e1000_reset(DeviceState *dev)
@@ -1708,6 +1724,7 @@ static Property e1000_properties[] = {
                     compat_flags, E1000_FLAG_MAC_BIT, true),
     DEFINE_PROP_BIT("migrate_tso_props", E1000State,
                     compat_flags, E1000_FLAG_TSO_BIT, true),
+    DEFINE_PROP_STRING("primary", E1000State, primary_id_str),
     DEFINE_PROP_END_OF_LIST(),
 };

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f154756e85..fbe10f4fe1 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -26,7 +26,9 @@
 #include "qapi/qapi-events-net.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
+#include "hw/pci/pci.h"
 #include "standard-headers/linux/ethtool.h"
+#include "hw/vfio/vfio-common.h"

 #define VIRTIO_NET_VM_VERSION    11

@@ -312,9 +314,14 @@ static void virtio_net_set_link_status(NetClientState *nc)
     uint16_t old_status = n->status;

     if (nc->link_down)
+    {
         n->status &= ~VIRTIO_NET_S_LINK_UP;
+    }
     else
+    {
+
         n->status |= VIRTIO_NET_S_LINK_UP;
+    }

     if (n->status != old_status)
         virtio_notify_config(vdev);
@@ -721,6 +728,16 @@ static void virtio_net_set_features(VirtIODevice
*vdev, uint64_t features)
     } else {
         memset(n->vlans, 0xff, MAX_VLAN >> 3);
     }
+
+    if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
+        Error * errp;
+        DeviceState *pdev = DEVICE(n->primary_pdev);
+        DeviceClass *klass = DEVICE_GET_CLASS(pdev);
+        if (klass->hotpluggable && n->primary_hph)
+        {
+            hotplug_handler_plug(n->primary_hph, pdev, &errp);
+        }
+    }
 }

 static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
@@ -1946,6 +1963,41 @@ void virtio_net_set_netclient_name(VirtIONet
*n, const char *name,
     n->netclient_type = g_strdup(type);
 }

+static bool primary_device_present(const char *id, struct PCIDevice **pdev)
+{
+    return pci_qdev_find_device(id, pdev) >= 0 &&
+    vfio_is_vfio_pci(*pdev);
+}
+
+bool virtio_net_register_primary_device(DeviceState *dev, DeviceState
*primary_dev)
+{
+    bool ret = false;
+    VirtIONet *n = VIRTIO_NET(dev);
+    Error *errp;
+    DeviceClass *klass = DEVICE_GET_CLASS(primary_dev);
+
+    if (n->primary_pdev == NULL)
+    {
+        n->primary_pdev = PCI_DEVICE(primary_dev);
+    }
+
+    if (n->primary_hph == NULL)
+    {
+        n->primary_hph = qdev_get_hotplug_handler(primary_dev);
+    }
+
+    /* Hide standby from pci till the feature is acked */
+    if (klass->hotpluggable && n->primary_hph)
+    {
+        object_ref(OBJECT(primary_dev));
+        qdev_simple_device_unplug_cb(n->primary_hph, primary_dev, &errp);
+        n->host_features |= (1ULL << VIRTIO_NET_F_STANDBY);
+        ret = true;
+    }
+
+    return ret;
+}
+
 static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1976,6 +2028,11 @@ static void
virtio_net_device_realize(DeviceState *dev, Error **errp)
         n->host_features |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
     }

+    if (n->net_conf.standby_id_str && primary_device_present(
+        n->net_conf.standby_id_str, &n->primary_pdev)) {
+        virtio_net_register_primary_device(dev, DEVICE(n->primary_pdev));
+    }
+
     virtio_net_set_config_size(n, n->host_features);
     virtio_init(vdev, "virtio-net", VIRTIO_ID_NET, n->config_size);

@@ -2198,6 +2255,7 @@ static Property virtio_net_properties[] = {
                      true),
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
+    DEFINE_PROP_STRING("standby", VirtIONet, net_conf.standby_id_str),
     DEFINE_PROP_END_OF_LIST(),
 };

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 866f0deeb7..593debe56e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -220,6 +220,12 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
 #endif
 }

+bool vfio_is_vfio_pci(PCIDevice* pdev)
+{
+    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
+    return vdev->vbasedev.type == VFIO_DEVICE_TYPE_PCI;
+}
+
 static void vfio_intx_update(PCIDevice *pdev)
 {
     VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 821def0565..26dfde805f 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -195,5 +195,6 @@ int vfio_spapr_create_window(VFIOContainer *container,
                              hwaddr *pgsize);
 int vfio_spapr_remove_window(VFIOContainer *container,
                              hwaddr offset_within_address_space);
+bool vfio_is_vfio_pci(PCIDevice* pdev);

 #endif /* HW_VFIO_VFIO_COMMON_H */
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 4d7f3c82ca..3b86f17805 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -42,6 +42,7 @@ typedef struct virtio_net_conf
     int32_t speed;
     char *duplex_str;
     uint8_t duplex;
+    char *standby_id_str;
 } virtio_net_conf;

 /* Maximum packet size we can receive from tap device: header + 64k */
@@ -103,9 +104,13 @@ typedef struct VirtIONet {
     int announce_counter;
     bool needs_vnet_hdr_swap;
     bool mtu_bypass_backend;
+    PCIDevice *primary_pdev;
+    HotplugHandler *primary_hph;
 } VirtIONet;

 void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
                                    const char *type);
+bool virtio_net_register_primary_device(DeviceState *vdev, DeviceState *pdev);
+

 #endif
On Sun, Sep 30, 2018 at 12:17 PM Sameeh Jubran <sameeh@daynix.com> wrote:
>
> On Thu, Sep 27, 2018 at 8:25 PM Samudrala, Sridhar
> <sridhar.samudrala@intel.com> wrote:
> >
> >
> > On 9/27/2018 9:17 AM, Michael S. Tsirkin wrote:
> > > On Thu, Sep 27, 2018 at 10:17:37AM +0300, Sameeh Jubran wrote:
> > >> What do you think about the following alternative implementation which
> > >> uses cross id validation.
> > >>
> > >> -device virtio-net,standby=<device_id_of_vfio_device>,id=<device_id_of_virtio_net_device>
> > >> -vfio #address,id=<device_id_of_vfio_device>,primary=<device_id_of_virtio_net_device>
> > > virtio is a standby device, isn't it?
> > >
> > > Besides that I don't see issues with this API.
> >
> > Yes. I think 'standby' and 'primary' are reversed in the above suggestion. This should work.
> hmm, I thought about standby being a property that virtio-net has, and
> this property is that it is a standby for the
> primary device and vice versa for the vfio. However this can be viewed
> from different aspects and isn't a deal breaker :)
> >
> > -device virtio-net,primary=<device_id_of_vfio_device>,id=<device_id_of_virtio_net_device>
> > -vfio #address,id=<device_id_of_vfio_device>,standby=<device_id_of_virtio_net_device>
> >
> > It should be OK to have virtio-net in standby mode without an associated vfio primary device,
> > but a vfio primary device should not allowed without a virtio-net standby device.
> >
> > Will it be possible to remove vfio device when virtio_net driver is unloaded in the VM?
> >
> > Thanks
> > Sridhar
> >
> >
> >
> >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >
>
>
> --
> Respectfully,
> Sameeh Jubran
> Linkedin
> Software Engineer @ Daynix.



-- 
Respectfully,
Sameeh Jubran
Linkedin
Software Engineer @ Daynix.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

