Return-Path: virtio-dev-return-4887-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 77CAE985C8A
	for <virtio-dev@lists.oasis-open.org>; Mon,  8 Oct 2018 22:07:16 +0000 (UTC)
MIME-Version: 1.0
References: <20180918111540-mutt-send-email-mst@kernel.org>
 <CADGSJ21CujSW=aF7BqdXmSFahLwSgPmG3_KFF5mSeVA5Z8PkQg@mail.gmail.com>
 <20180919230502-mutt-send-email-mst@kernel.org> <CADGSJ22OybVCOsBmqdAHLPBU0PKF13xWz3YtHT=Pw5bT_a71BA@mail.gmail.com>
 <20180920220951-mutt-send-email-mst@kernel.org> <CADGSJ23GRrt25k1G9wD3JhA6en4MuXLE9WA24Ep8PLgkyk_4=A@mail.gmail.com>
 <20180927121739-mutt-send-email-mst@kernel.org> <CADGSJ22JC9asjQ3nVV5e-ajxB-pggJ6ToMGqG072Q5TvFVCKBQ@mail.gmail.com>
 <20181002083928-mutt-send-email-mst@kernel.org> <CADGSJ23NaaPXrgoL1-ySs=SWytE65SORatOFMSapzFsKZUH4yA@mail.gmail.com>
 <20181005101419-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181005101419-mutt-send-email-mst@kernel.org>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 9 Oct 2018 01:06:59 +0300
Message-ID: <CAKPgXcF6vu-O5wDRmK+-4cFQH1w7exEUtMuMvxkgUVeXt=Punw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY feature
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Siwei Liu <loseweigh@gmail.com>, venu.busireddy@oracle.com, cohuck@redhat.com, sridhar.samudrala@intel.com, virtio-dev <virtio-dev@lists.oasis-open.org>, ehabkost@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi All,

I have been busy trying to figure out how to implement the feature and
got very confused with the current open questions and tier impact.

As I have stated earlier, I thought about doing the following:

1 - Have an id for virtio-net (the standby device) and one for the
vfio device (primary).
2 - On realize of virtio-net check for the existence of the primary
device and hide the standby feature.
3 - Once the feature is acked by the guest, the device would be
plugged back by virtio-net.

I've faced few issues when I tried to implement this which I overcame.
At the end of the email I've included a prototype which implements
this basic functionality using e1000 instead of vfio net device, I'm
sharing this as a draft only (it has many flaws) as parts of it are
valid for the actual implementation.

Issues that I've faced:

* I've used a device_listener callbacks it get the device to register
itself for virtio-net. This makes virtio-net listen to the realization
of the device. I don't think this approach is right, as it makes the
virtio-net listen to every device which can be avoided by extending
the current implementation of the device listner, Moreover, this
doesn't solve the migration issues, as far as I understand, the
realize function doesn't get called after the migration process which
means this doesn't work. (correct me if I'm wrong)

* When testing with PC machine type which uses the PIIX4 as the
hotplug handler, the hotplug handler get's set after the virtio-net
and e1000 device has been realized. This means that I can't save the
hotplug handler before detaching the device which means I can't plug
it back as when the device is unplugged it is unattached from it's
parent bus. This was resolved by saving a pointer to the parent bus
instead and when attempting to replug the device then the parent can
be used to get the hotplug handler. Note that unplugging the device
using "qdev_simple_device_unplug_cb" doesn't require the hotplug
handler as this function simply detaches the device object from it's
parent object (the pci bus).

I've talked to Eduardo and he mentioned that he and Michael had
discussed the following approach: using a property (for pci devices
currently and maybe for others in the future?) which tells Qemu to
hide the device from the bus upon init. This approach leaves the
responsibility of managing the failover device to the management. The
management can send commands to plug the hidden device or hide it back
as well. I think that I like this approach better as it is proof of
issues that can come up when trying to handle the failure of
unplug/plug requests to the guest.

Please share your thoughts on this approach versus the draft implementation.

_____________________________________________________________________________________________________

commit 06afc24a613b2cb31c064859e89b709ec54fecdc (HEAD -> failover)
Author: Sameeh Jubran <sjubran@redhat.com>
Date:   Sun Sep 16 13:21:41 2018 +0300

    virtio-net: Implement standby feature

    Signed-off-by: Sameeh Jubran <sjubran@redhat.com>

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 13a9494a8d..387d8856c0 100644
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
+        virtio_net_register_primary_device(DEVICE(vdev));
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
index f154756e85..b831ba438b 100644
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

@@ -721,6 +723,20 @@ static void virtio_net_set_features(VirtIODevice
*vdev, uint64_t features)
     } else {
         memset(n->vlans, 0xff, MAX_VLAN >> 3);
     }
+
+    if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
+        Error * errp;
+        DeviceState *pdev = DEVICE(n->primary_pdev);
+        DeviceClass *klass = DEVICE_GET_CLASS(pdev);
+
+        /* Plug the primary device back to the pci bus */
+        if (klass->hotpluggable && n->primary_parent_bus)
+        {
+            BusState *qbus = BUS(n->primary_parent_bus);
+            hotplug_handler_plug(qbus->hotplug_handler, pdev,
+                    &errp);
+        }
+    }
 }

 static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
@@ -1946,6 +1962,52 @@ void virtio_net_set_netclient_name(VirtIONet
*n, const char *name,
     n->netclient_type = g_strdup(type);
 }

+static bool primary_device_present(const char *id, struct PCIDevice **pdev)
+{
+    return pci_qdev_find_device(id, pdev) >= 0 &&
+    vfio_is_vfio_pci(*pdev);
+}
+
+
+static void primary_device_realize(DeviceListener *listener,
+                              DeviceState *dev)
+{
+    VirtIONet *n = container_of(listener, VirtIONet, primary_listener);
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE) && dev->id
+    && !strcmp(dev->id, n->net_conf.standby_id_str))
+    {
+        Error *errp;
+        DeviceClass *klass = DEVICE_GET_CLASS(dev);
+
+        if (n->primary_pdev == NULL)
+        {
+            n->primary_pdev = PCI_DEVICE(dev);
+        }
+
+        if (n->primary_parent_bus == NULL)
+        {
+            n->primary_parent_bus = qdev_get_parent_bus(dev);
+        }
+
+        /* Hide standby from pci till the feature is acked */
+        if (klass->hotpluggable && n->primary_parent_bus)
+        {
+            object_ref(OBJECT(dev));
+            qdev_simple_device_unplug_cb(NULL ,dev, &errp);
+            n->host_features |= (1ULL << VIRTIO_NET_F_STANDBY);
+        }
+    }
+}
+
+void virtio_net_register_primary_device(DeviceState *dev)
+{
+    VirtIONet *n = VIRTIO_NET(dev);
+    n->primary_listener.realize = primary_device_realize;
+    n->primary_listener.unrealize = NULL;
+    device_listener_register(&n->primary_listener);
+}
+
 static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1976,6 +2038,11 @@ static void
virtio_net_device_realize(DeviceState *dev, Error **errp)
         n->host_features |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
     }

+    if (n->net_conf.standby_id_str && primary_device_present(
+        n->net_conf.standby_id_str, &n->primary_pdev)) {
+        virtio_net_register_primary_device(dev);
+    }
+
     virtio_net_set_config_size(n, n->host_features);
     virtio_init(vdev, "virtio-net", VIRTIO_ID_NET, n->config_size);

@@ -2198,6 +2265,7 @@ static Property virtio_net_properties[] = {
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
index 4d7f3c82ca..cfb8843a77 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -42,6 +42,7 @@ typedef struct virtio_net_conf
     int32_t speed;
     char *duplex_str;
     uint8_t duplex;
+    char *standby_id_str;
 } virtio_net_conf;

 /* Maximum packet size we can receive from tap device: header + 64k */
@@ -103,9 +104,14 @@ typedef struct VirtIONet {
     int announce_counter;
     bool needs_vnet_hdr_swap;
     bool mtu_bypass_backend;
+    PCIDevice *primary_pdev;
+    BusState *primary_parent_bus;
+    DeviceListener primary_listener;
 } VirtIONet;

 void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
                                    const char *type);
+void virtio_net_register_primary_device(DeviceState *vdev);
+

 #endif
(END)
On Fri, Oct 5, 2018 at 10:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Oct 04, 2018 at 05:03:14PM -0700, Siwei Liu wrote:
> > On Tue, Oct 2, 2018 at 5:43 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Oct 02, 2018 at 01:42:09AM -0700, Siwei Liu wrote:
> > > > The VF's MAC can be updated by PF/host on the fly at any time. One can
> > > > start with a random MAC but use group ID to pair device instead. And
> > > > only update MAC address to the real one when moving MAC filter around
> > > > after PV says OK to switch datapath.
> > > >
> > > > Do you see any problem with this design?
> > >
> > > Isn't this what I proposed:
> > >         Maybe we can
> > >         start VF with a temporary MAC, then change it to a final one when guest
> > >         tries to use it. It will work but we run into fact that MACs are
> > >         currently programmed by mgmnt - in many setups qemu does not have the
> > >         rights to do it.
> > >
> > > ?
> > >
> > > If yes I don't see a problem with the interface design, even though
> > > implementation wise it's more work as it will have to include management
> > > changes.
> >
> > I thought we discussed this design a while back:
> > https://www.spinics.net/lists/netdev/msg512232.html
> >
> > ... plug in a VF with a random MAC filter programmed in prior, and
> > initially use that random MAC within guest. This would require:
> > a) not relying on permanent MAC address to do pairing during the
> > initial discovery, e.g. use the failover group ID as in this
> > discussion
> > b) host to toggle the MAC address filter: which includes taking down
> > the tap device to return the MAC back to PF, followed by assigning
> > that MAC to VF using "ip link ... set vf ..."
> > c) notify guest to reload/reset VF driver for the change of hardware MAC address
> > d) until VF reloads the driver it won't be able to use the datapath,
> > so very short period of network outage is (still) expected
> >
> > though I still don't think this design can elimnate downtime.
>
>
> No, my idea is somewhat different. As you say there is a problem
> of delay at point (c). Further, the need to poke at PF filters
> with set vf does not match the current security model where
> any security related configuration such as MAC filtering is done upfront.
>
>
> So I have two suggestions:
>
> 1. Teach pf driver not to program the filter until vf driver actually goes up.
>
>    How do we know it went up? For example, it is highly likely
>    that driver will send some kind of command on init.
>    E.g. linux seems to always try to set the mac address during init.
>    We can have any kind of command received by the PF enable
>    the filter, until reset.
>
>    In absence of an appropriate command, QEMU can detect bus master
>    enable and do that.
>
> 2. Create a variant of trusted VF where it starts out without a valid
>    MAC, guest can set a softmac MAC but only can set it to the specific
>    value that matches virtio.
>    Alternatively - if it's preferred for some reason - allow
>    guest to program just two MACs, the original one and the virtio one.
>    Any other value is denied.
>
>
>
> > However,
> > it looks like as of today the MAC matching still haven't addressed the
> > datapath switching and error handling in a clean way. As said, for
> > SR-IOV live migration on iSCSI root disk there will be a lot of
> > dancing parts going along the way, reliable network connectity and
> > dedicated handshakes are critical to this kind of setup.
> >
> > -Siwei
>
> I think MAC matching removes downtime when device is removed but not
> when it's re-added, yes. It has the advantage of an already present
> linux driver support, but if you are prepared to work on
> adding e.g. bridge based matching, that will go away.
>
>
> > >
> > > --
> > > MST
> > >
> > > ---------------------------------------------------------------------
> > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > >
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


-- 
Respectfully,
Sameeh Jubran
Linkedin
Software Engineer @ Daynix.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

