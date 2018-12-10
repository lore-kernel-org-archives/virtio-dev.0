Return-Path: virtio-dev-return-5165-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA89C985BB2
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Dec 2018 23:08:02 +0000 (UTC)
Date: Mon, 10 Dec 2018 18:07:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181210175553-mutt-send-email-mst@kernel.org>
References: <1544458548-5986-1-git-send-email-venu.busireddy@oracle.com>
 <1544458548-5986-3-git-send-email-venu.busireddy@oracle.com>
 <20181210123215-mutt-send-email-mst@kernel.org>
 <2b7b3ddc-8857-e980-c4f1-99a4185e1c3f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2b7b3ddc-8857-e980-c4f1-99a4185e1c3f@oracle.com>
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH 2/3] virtio_net: Add support for "Data Path
 Switching" during Live Migration.
To: si-wei liu <si-wei.liu@oracle.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, Liran Alon <liran.alon@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Dec 10, 2018 at 12:22:37PM -0800, si-wei liu wrote:
>=20
>=20
> On 12/10/2018 9:41 AM, Michael S. Tsirkin wrote:
> > On Mon, Dec 10, 2018 at 11:15:47AM -0500, Venu Busireddy wrote:
> > > Added two new events, FAILOVER_PLUG_PRIMARY and FAILOVER_UNPLUG_PRIMA=
RY.
> > > The first is emitted when the guest negotiates the F_STANDBY feature
> > > bit. The second is emitted when the virtio_net driver is removed, eit=
her
> > > manually or as a result of guest reboot.
> > So the names mean "should plug" and "should unplug" right?
> Sounds about right, but management stack may ignore the message if not go=
ing
> to plug in the primary device.
>=20
> > It seems inelegant to tell upper layers what they should do.
> > After all they are upper layers because presumably
> > there is a policy question as opposed to a mechanism.
> > Can we expose information without telling managmenent what to do?
> Is it just the name itself that is offensive? The information exposed to
> upper layer is just that time is ready to plug/unplug the paired device.
> Would the names FAILOVER_STANDY_SET and FAILOVER_STANDY_CLEAR fit your
> expectation?

So really the same thing applies as with the other events:
event should just signal a change, status should be
reported with a query command. Avoids event floods
and handles management restarts gracefully.


> > Alternatively, is there a real need to unplug the device completely?
> > Would it work to just hide the device from guest instead?  QEMU can do
> > it itself and this is the direction that Sameeh has been taking.
> See below in the cover letter:
>=20
> 3. While the hidden device model (viz. coupled device model) is still
> =A0=A0 being explored for automatic hot plugging (QEMU) and automatic dat=
apath
> =A0=A0 switching (host-kernel), this series provides a supplemental set
> =A0=A0 of interfaces if management software wants to drive the SR-IOV live
> =A0=A0 migration on its own. It should not conflict with the hidden device
> =A0=A0 model but just offers simplicity of implementation.
>=20
> As said this is a supplemental implementation that involves and leverages
> management software before we can converge to the ideal hidden/coupled
> device model.

So I don't think there's a problem with sending an event when
the feature bit gets set/cleared, as long as there's
no implication that management is required to react
in a certain way. So yes, it's a naming issue at that level.

> As I understand it, we're still exploring the best way to handle the
> datapath (MAC filter) switching problem for the hidden (coupled) device
> model, right. Even if we can hide the device there's still need to inform
> upper layer for datapath switching that is currently being handled in
> userspace management stack. I think the best fit for the hidden (coupled)
> model is that all datapath switching can be handled automatically and
> transparently in the kernel without needing to notify userspace and depend
> on userspace reaction.
>=20
> >=20
> > > Management stack can use these
> > > events to determine when to plug/unplug the VF device to/from the gue=
st.
> > >=20
> > > Also, the Virtual Functions will be automatically removed from the gu=
est
> > > if the guest is rebooted. To properly identify the VFIO devices that
> > > must be removed, a new property named "x-failover-primary" is added to
> > > the vfio-pci devices. Only the vfio-pci devices that have this proper=
ty
> > > enabled are removed from the guest upon reboot.
> > If this property needs to be set by management then
> > it must not start with "x-" - that prefix means
> > "unstable do not use from external tools".
>=20
> Sure, will remove "x-" (sorry, missed to correct it before sending out
> publicly).
>=20
> Thanks,
> -Siwei
>=20
> >=20
> > > Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
> >=20
> >=20
> > > ---
> > >   hw/acpi/pcihp.c                | 27 ++++++++++++++++++++++++++
> > >   hw/net/virtio-net.c            | 23 ++++++++++++++++++++++
> > >   hw/vfio/pci.c                  |  3 +++
> > >   hw/vfio/pci.h                  |  1 +
> > >   include/hw/pci/pci.h           |  1 +
> > >   include/hw/virtio/virtio-net.h |  4 ++++
> > >   qapi/net.json                  | 44 +++++++++++++++++++++++++++++++=
+++++++++++
> > >   7 files changed, 103 insertions(+)
> > >=20
> > > diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> > > index 80d42e1..2a3ffd3 100644
> > > --- a/hw/acpi/pcihp.c
> > > +++ b/hw/acpi/pcihp.c
> > > @@ -176,6 +176,25 @@ static void acpi_pcihp_eject_slot(AcpiPciHpState=
 *s, unsigned bsel, unsigned slo
> > >       }
> > >   }
> > > +static void acpi_pcihp_cleanup_failover_primary(AcpiPciHpState *s, i=
nt bsel)
> > > +{
> > > +    BusChild *kid, *next;
> > > +    PCIBus *bus =3D acpi_pcihp_find_hotplug_bus(s, bsel);
> > > +
> > > +    if (!bus) {
> > > +        return;
> > > +    }
> > > +    QTAILQ_FOREACH_SAFE(kid, &bus->qbus.children, sibling, next) {
> > > +        DeviceState *qdev =3D kid->child;
> > > +        PCIDevice *pdev =3D PCI_DEVICE(qdev);
> > > +        int slot =3D PCI_SLOT(pdev->devfn);
> > > +
> > > +        if (pdev->failover_primary) {
> > > +            s->acpi_pcihp_pci_status[bsel].down |=3D (1U << slot);
> > > +        }
> > > +    }
> > > +}
> > > +
> > >   static void acpi_pcihp_update_hotplug_bus(AcpiPciHpState *s, int bs=
el)
> > >   {
> > >       BusChild *kid, *next;
> > > @@ -207,6 +226,14 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
> > >       int i;
> > >       for (i =3D 0; i < ACPI_PCIHP_MAX_HOTPLUG_BUS; ++i) {
> > > +        /*
> > > +         * Set the acpi_pcihp_pci_status[].down bits of all the
> > > +         * failover_primary devices so that the devices are ejected
> > > +         * from the guest. We can't use the qdev_unplug() as well as=
 the
> > > +         * hotplug_handler to unplug the devices, because the guest =
may
> > > +         * not be in a state to cooperate.
> > > +         */
> > > +        acpi_pcihp_cleanup_failover_primary(s, i);
> > >           acpi_pcihp_update_hotplug_bus(s, i);
> > >       }
> > >   }
> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > index 411f8fb..d37f33c 100644
> > > --- a/hw/net/virtio-net.c
> > > +++ b/hw/net/virtio-net.c
> > > @@ -248,6 +248,28 @@ static void virtio_net_drop_tx_queue_data(VirtIO=
Device *vdev, VirtQueue *vq)
> > >       }
> > >   }
> > > +static void virtio_net_failover_notify_event(VirtIONet *n, uint8_t s=
tatus)
> > > +{
> > > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> > > +
> > > +    if (virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_STANDB=
Y)) {
> > > +        gchar *path =3D object_get_canonical_path(OBJECT(n->qdev));
> > > +        /*
> > > +         * Emit the FAILOVER_PLUG_PRIMARY event
> > > +         *   when the status transitions from 0 to VIRTIO_CONFIG_S_D=
RIVER_OK
> > > +         * Emit the FAILOVER_UNPLUG_PRIMARY event
> > > +         *   when the status transitions from VIRTIO_CONFIG_S_DRIVER=
_OK to 0
> > > +         */
> > > +        if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> > > +                (!(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK))) {
> > > +            FAILOVER_NOTIFY_EVENT(plug, n, path);
> > > +        } else if ((!(status & VIRTIO_CONFIG_S_DRIVER_OK)) &&
> > > +                (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > > +            FAILOVER_NOTIFY_EVENT(unplug, n, path);
> > > +        }
> > > +    }
> > > +}
> > > +
> > >   static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_=
t status)
> > >   {
> > >       VirtIONet *n =3D VIRTIO_NET(vdev);
> > > @@ -256,6 +278,7 @@ static void virtio_net_set_status(struct VirtIODe=
vice *vdev, uint8_t status)
> > >       uint8_t queue_status;
> > >       virtio_net_vnet_endian_status(n, status);
> > > +    virtio_net_failover_notify_event(n, status);
> > >       virtio_net_vhost_status(n, status);
> > >       for (i =3D 0; i < n->max_queues; i++) {
> > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > index 5c7bd96..ce1f33c 100644
> > > --- a/hw/vfio/pci.c
> > > +++ b/hw/vfio/pci.c
> > > @@ -3077,6 +3077,7 @@ static void vfio_realize(PCIDevice *pdev, Error=
 **errp)
> > >       vfio_register_err_notifier(vdev);
> > >       vfio_register_req_notifier(vdev);
> > >       vfio_setup_resetfn_quirk(vdev);
> > > +    pdev->failover_primary =3D vdev->failover_primary;
> > >       return;
> > > @@ -3219,6 +3220,8 @@ static Property vfio_pci_dev_properties[] =3D {
> > >                                      qdev_prop_nv_gpudirect_clique, u=
int8_t),
> > >       DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice,=
 msix_relo,
> > >                                   OFF_AUTOPCIBAR_OFF),
> > > +    DEFINE_PROP_BOOL("x-failover-primary", VFIOPCIDevice,
> > > +                     failover_primary, false),
> > >       /*
> > >        * TODO - support passed fds... is this necessary?
> > >        * DEFINE_PROP_STRING("vfiofd", VFIOPCIDevice, vfiofd_name),
> > > diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> > > index b1ae4c0..06ca661 100644
> > > --- a/hw/vfio/pci.h
> > > +++ b/hw/vfio/pci.h
> > > @@ -167,6 +167,7 @@ typedef struct VFIOPCIDevice {
> > >       bool no_vfio_ioeventfd;
> > >       bool enable_ramfb;
> > >       VFIODisplay *dpy;
> > > +    bool failover_primary;
> > >   } VFIOPCIDevice;
> > >   uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int l=
en);
> > > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > > index e6514bb..b0111d1 100644
> > > --- a/include/hw/pci/pci.h
> > > +++ b/include/hw/pci/pci.h
> > > @@ -351,6 +351,7 @@ struct PCIDevice {
> > >       MSIVectorUseNotifier msix_vector_use_notifier;
> > >       MSIVectorReleaseNotifier msix_vector_release_notifier;
> > >       MSIVectorPollNotifier msix_vector_poll_notifier;
> > > +    bool failover_primary;
> > >   };
> > >   void pci_register_bar(PCIDevice *pci_dev, int region_num,
> > > diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virti=
o-net.h
> > > index 4d7f3c8..a697903 100644
> > > --- a/include/hw/virtio/virtio-net.h
> > > +++ b/include/hw/virtio/virtio-net.h
> > > @@ -22,6 +22,10 @@
> > >   #define VIRTIO_NET(obj) \
> > >           OBJECT_CHECK(VirtIONet, (obj), TYPE_VIRTIO_NET)
> > > +#define FAILOVER_NOTIFY_EVENT(type, n, path) \
> > > +        qapi_event_send_failover_##type##_primary \
> > > +                (!!n->netclient_name, n->netclient_name, path)
> > > +
> > >   #define TX_TIMER_INTERVAL 150000 /* 150 us */
> > >   /* Limit the number of packets that can be sent via a single flush
> > > diff --git a/qapi/net.json b/qapi/net.json
> > > index 8f99fd9..04a9de9 100644
> > > --- a/qapi/net.json
> > > +++ b/qapi/net.json
> > > @@ -683,3 +683,47 @@
> > >   ##
> > >   { 'event': 'NIC_RX_FILTER_CHANGED',
> > >     'data': { '*name': 'str', 'path': 'str' } }
> > > +
> > > +##
> > > +# @FAILOVER_PLUG_PRIMARY:
> > > +#
> > > +# Emitted when the guest successfully loads the driver after the STA=
NDBY
> > > +# feature bit is negotiated.
> > > +#
> > > +# @device: Indicates the virtio_net device.
> > > +#
> > > +# @path: Indicates the device path.
> > > +#
> > > +# Since: 3.0
> > > +#
> > > +# Example:
> > > +#
> > > +# <- {"timestamp": {"seconds": 1432121972, "microseconds": 744001},
> > > +#     "event": "FAILOVER_PLUG_PRIMARY",
> > > +#     "data": {"device": "net0", "path": "/machine/peripheral/net0/v=
irtio-backend"} }
> > > +#
> > > +##
> > > +{ 'event': 'FAILOVER_PLUG_PRIMARY',
> > > +  'data': {'*device': 'str', 'path': 'str'} }
> > > +
> > > +##
> > > +# @FAILOVER_UNPLUG_PRIMARY:
> > > +#
> > > +# Emitted when the guest resets the virtio_net driver.
> > > +# The reset can be the result of either unloading the driver or a re=
boot.
> > > +#
> > > +# @device: Indicates the virtio_net device.
> > > +#
> > > +# @path: Indicates the device path.
> > > +#
> > > +# Since: 3.0
> > > +#
> > > +# Example:
> > > +#
> > > +# <- {"timestamp": {"seconds": 1432121972, "microseconds": 744001},
> > > +#     "event": "FAILOVER_UNPLUG_PRIMARY",
> > > +#     "data": {"device": "net0", "path": "/machine/peripheral/net0/v=
irtio-backend"} }
> > > +#
> > > +##
> > > +{ 'event': 'FAILOVER_UNPLUG_PRIMARY',
> > > +  'data': {'*device': 'str', 'path': 'str'} }

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

