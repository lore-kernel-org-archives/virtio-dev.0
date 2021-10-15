Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2] Add device reset timeout field
Date: Fri, 15 Oct 2021 08:09:41 +0000
Message-ID: <DM8PR12MB5480C1A24131E23A5568AAA5DCB99@DM8PR12MB5480.namprd12.prod.outlook.com>
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
In-Reply-To: <87czo6vkza.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Friday, October 15, 2021 12:22 PM
>=20
> On Fri, Oct 15 2021, Parav Pandit <parav@nvidia.com> wrote:
>=20
> >> From: Michael S. Tsirkin <mst@redhat.com>
> >> Sent: Friday, October 15, 2021 3:59 AM
> >>
> >> On Thu, Oct 14, 2021 at 05:35:37PM +0000, Parav Pandit wrote:
> >> > Below changes are good for v3?
> >> > 1. driver should use device reset time during initialization stage
> >>
> >> How does driver identify this though?
> > Existence of device_reset_timeout field in struct virtio_pci_common_cfg
> indicates that this field exists.
> > If device support it, it will place non zero value and driver knows tha=
t this
> field should be used.
>=20
> But how does the driver know? The very first step in the initialization s=
equence
> is "reset the device", before it may read the config space.
PCI configuration space is always accessible when a PCI device exists at PC=
I level even before virtio layer can operate it.
So struct virtio_pci_common_cfg is accessible to the virtio transport layer=
 before resetting the device.
It needs to contains what the timeout is, just like reset of the fields.

I made mistake in understanding last time between virtio config space such =
as (struct virtio_net_config) vs PCI config space.
So want to double check, did you mean pci config space and struct virtio_pc=
i_common_cfg or something else when you mentioned _config_space_?
Virtio_net_config certainly accessible only after reset.
But transport level pci capabilities are accessible before reset by the PCI=
 spec.

>=20
> >
> >>
> >> > 2. remove feature bit as feature bits are only readable after reset
> >> > is completed 3. device reset timeout field of zero indicates that
> >> > device doesn't
> >> support it.
> >>
> >> I'm not sure about 3. I think each transport will need its own way to =
do it.
> >>
> > For pci a value of zero indicates it isn't supported.
> > For mmio DeviceResetTimeout at offset 0x04c indicates same.
> > Currently only these 2 transports have the use.
>=20
> I don't think we want to force all transports, including not yet existing=
 ones, to
> use that mechanism. They might as well use a command to retrieve the valu=
e
> and fail the command, for example.
>=20
ok. it is interesting for me to understand that virtio spec care for even a=
n undefined transport.

So when such undefined transport gets defined in virtio spec, a spec will g=
et updated anyway to describes that new_transport performs reset via cmd in=
terface.

Though I do not well understand how driver can reset a device via a command=
 without establishing a command channel.
A device usually needs to respond/accept the command channel bits to accept=
 the command.
But there may be some transport that behave differently that I didn't antic=
ipate yet.

So let's define such transport specific changes when such transport will be=
 done for real in virtio spec.

> >
> >> So I propose: maybe a capability like this, with a timeout field?
> > Do you mean a new capability like say VIRTIO_PCI_DEVICE_TIMEOUT like
> VIRTIO_PCI_CAP_COMMON_CFG?
> > This will contain one or more timeout? For example with his proposal it
> contains only device reset timeout.
> > Later same capability will be further extended to contains command time=
out
> too? Yes?
> >
> >> And within VMs, we can just do without, since it got out of reset
> >> once it will surely get out of reset again...
> > Yes, VM might not need it. It is really the HV's choice to implement an=
d not
> part of the virtio spec.
> > Our internal cloud passthrough a PF to the VM.
> > It is probably better to let HV to choose if they want to do ctrl+c or =
have
> timeout.
>=20
> But you want it in the spec, don't you? Confused.
It is a SHOULD area of the proposal that recommends to honor the timeout ho=
nored.
What I meant to say, that I agree to Michaels point that "VM can do without=
 timeout" -> that a HV can build a device or pass a device to the VM withou=
t device reset timeout functionality.

