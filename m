Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2] Add device reset timeout field
Date: Fri, 22 Oct 2021 06:29:30 +0000
Message-ID: <PH0PR12MB5481DD8E43D3991A1C0CF21EDC809@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB54816AD1011E3806A4A26B27DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008185926-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814DF6BE5016FB4D941847DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <871r4ry5do.fsf@redhat.com>
 <PH0PR12MB5481502C480B6A7C1B61DFD6DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211011115716-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548198414B1F64D5F7A149C8DCB69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211012045448-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DB5D0F4F3EAAEB26B047DCB69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481C5C0EB93191416E36D4EDCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211014182437-mutt-send-email-mst@kernel.org>
 <DM8PR12MB54806B9EEECE8920F450F86BDCB99@DM8PR12MB5480.namprd12.prod.outlook.com>
 <87czo6vkza.fsf@redhat.com>
 <DM8PR12MB5480C1A24131E23A5568AAA5DCB99@DM8PR12MB5480.namprd12.prod.outlook.com>
 <87a6javdul.fsf@redhat.com>
In-Reply-To: <87a6javdul.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Cornelia,

I wasn't able to respond last few days.
Sorry for the delayed response below.

> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Friday, October 15, 2021 2:56 PM

> On Fri, Oct 15 2021, Parav Pandit <parav@nvidia.com> wrote:
>=20
> >> From: Cornelia Huck <cohuck@redhat.com>
> >> Sent: Friday, October 15, 2021 12:22 PM
> >>
> >> On Fri, Oct 15 2021, Parav Pandit <parav@nvidia.com> wrote:
> >>
> >> >> From: Michael S. Tsirkin <mst@redhat.com>
> >> >> Sent: Friday, October 15, 2021 3:59 AM
> >> >>
> >> >> On Thu, Oct 14, 2021 at 05:35:37PM +0000, Parav Pandit wrote:
> >> >> > Below changes are good for v3?
> >> >> > 1. driver should use device reset time during initialization
> >> >> > stage
> >> >>
> >> >> How does driver identify this though?
> >> > Existence of device_reset_timeout field in struct
> >> > virtio_pci_common_cfg
> >> indicates that this field exists.
> >> > If device support it, it will place non zero value and driver knows
> >> > that this
> >> field should be used.
> >>
> >> But how does the driver know? The very first step in the
> >> initialization sequence is "reset the device", before it may read the =
config
> space.
> > PCI configuration space is always accessible when a PCI device exists a=
t PCI
> level even before virtio layer can operate it.
> > So struct virtio_pci_common_cfg is accessible to the virtio transport l=
ayer
> before resetting the device.
> > It needs to contains what the timeout is, just like reset of the fields=
.
> >
> > I made mistake in understanding last time between virtio config space s=
uch
> as (struct virtio_net_config) vs PCI config space.
> > So want to double check, did you mean pci config space and struct
> virtio_pci_common_cfg or something else when you mentioned
> _config_space_?
> > Virtio_net_config certainly accessible only after reset.
> > But transport level pci capabilities are accessible before reset by the=
 PCI
> spec.
>=20
> So, how does that work for non-pci? Can mmio access its config space like
> that?
Yes. MMIO device initialization starts in transport layer.
This device init starts by reading the magicvalue and version registers fro=
m the MMIO config space.
After this is done, it follows the device init flow described in the spec s=
ection 4.2.3.1.1.

>=20
> My point is: don't make it harder for future transports than really necce=
ssary. If
> you look at today's transports, ccw is already substantially different fr=
om pci in
> many ways, and yet both are functional virtio transports. Take the concep=
t of
> "config space": ccw devices do not have such a thing. I created two chann=
el
> commands to basically emulate that concept for *virtio* *only*. Should we
> want to introduce the timeout value for ccw (which is not likely, but let=
's go for
> it for the sake of the argument), we cannot put it into a non-existing co=
nfig
> space; it needs to use something else, like a command to retrieve the val=
ue. A
> future transport might be in a similar position, and "put it into the con=
fig
> space" may simply not be possible.
>=20
> Look at it that way: You come from the PCI perspective, and you have an i=
dea
> how to model things there. I come from a channel I/O background, and I ha=
ve
> an idea how to model things there. Both are quite different; if we can co=
me up
> with something that can work for both transports, chances are good that a
> future transport can also work with it.=20

In this proposal, for pci and mmio transports, the new timeout register is =
located in the transport specific device config space.
This is because these two transports initialization is based on this config=
 space.
Both the transport clearly describe that they follow the spec 3.1 device in=
itialization flow.

For ccw as you well described above and as part of the spec there is no lin=
k to spec 3.1 device initialization flow.

> If we say that the driver retrieves that
> information in a transport-specific way without any mention of config spa=
ces,
> we should be fine.
Yes. I totally agree with you.
Its transport specific way.
In the current proposal, in the device reset timeout description section 2.=
4.1, 2.4.2, there is no mention of config space.
Each transport (pci, mmio) extends their own config space and describes wha=
t is the transport specific extension it is to interact with device.

So if new non config space based transport or ccw wants to do this in futur=
e, they will use their transport specific way (as you described channel com=
mand interface).

I didn't muddy the device reset description for ccw exceptions because for =
rest the device reset piece, it doesn't have any link to ccw differences.

