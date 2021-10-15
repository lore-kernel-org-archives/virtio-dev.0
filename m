Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2] Add device reset timeout field
Date: Fri, 15 Oct 2021 04:36:38 +0000
Message-ID: <DM8PR12MB54806B9EEECE8920F450F86BDCB99@DM8PR12MB5480.namprd12.prod.outlook.com>
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
In-Reply-To: <20211014182437-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, October 15, 2021 3:59 AM
>=20
> On Thu, Oct 14, 2021 at 05:35:37PM +0000, Parav Pandit wrote:
> > Hi Michael, Cornelia,
> >
> > > From: Parav Pandit
> > > Sent: Tuesday, October 12, 2021 2:42 PM
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Tuesday, October 12, 2021 2:32 PM
> > > >
> > > > On Tue, Oct 12, 2021 at 08:51:34AM +0000, Parav Pandit wrote:
> > > > >
> > > > >
> > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Sent: Monday, October 11, 2021 9:30 PM
> > > > > >
> > > > > > On Mon, Oct 11, 2021 at 03:44:14PM +0000, Parav Pandit wrote:
> > > > > > > > > This is unlikely to work the reset is completed. Because
> > > > > > > > > a real device
> > > > > > > > implementing this would prefer to do this in fw for 1000
> > > > > > > > virtio devices sitting on the physical card.
> > > > > > > > > And it is very much driven by such implementation at devi=
ce
> devel.
> > > > > > > > > So it cannot update the counter value if reset is not
> > > > > > > > > completed for the
> > > > > > device.
> > > > > > > > >
> > > > > > > > > I think read only device reset timeout is most elegant
> > > > > > > > > option during device
> > > > > > > > initialization phase that eliminates infinite loop of today=
.
> > > > > > > >
> > > > > > > > Why can't a driver just go ahead and do a timeout regardles=
s?
> > > > > > > o.k. lets consider this thought exercise. What is the
> > > > > > > timeout value that driver
> > > > > > will choose if device doesn't specify one?
> > > > > > > I explained in previous thread and you acked that actual fw
> > > > > > > based device
> > > > > > may take longer to initialize than pure sw implementation backe=
nd.
> > > > > > > In second example a pre-boot device can take even longer
> > > > > > > initialization
> > > > time.
> > > > > > > Sriov VF device may initialize lot faster.
> > > > > > > Instead of driver having such transport, and device specific
> > > > > > > checks, (or some
> > > > > > very short or very long timeout), we propose, that let device
> > > > > > mention such timeout value.
> > > > > >
> > > > > > Parav I think you are conflating reset with initialization time=
.
> > > > > > initialization is just for host boot which takes seconds
> > > > > > anyway - but no, minutes is not reasonable their, either.
> > > > > > reset affects guest boot. This needs to complete in millisecond=
s.
> > > > > >
> > > > > I cannot promise, but with newer generation devices usually
> > > > > functionality
> > > > improves.
> > > > > Enforcing in milliseconds doesn't look practical for type of devi=
ces.
> > > > > Some of the block devices may need to establish TCP connections
> > > > > in the
> > > > backend.
> > > > > It is more useful to wait for few more seconds to initialize
> > > > > device after power
> > > > on the system, instead of giving up booting the server completely.
> > > > > For example, a nvme block device starts with a minimum timeout
> > > > > of
> > > > 500msec.
> > > > >
> > > > > Yes, I agree to your point that a device given to a guest VM
> > > > > will likely have
> > > > very short reset time that should complete in milliseconds.
> > > > >
> > > > > > This conflation is IMHO one of the problems with this proposal.
> > > > >
> > > > > Device initialization consist of device reset from the spec secti=
on 3.1.1.
> > > >
> > > > It does. But maybe we need to create a way for driver to
> > > > distinguish between the two. When under reset, use a driver supplie=
d
> timeout.
> > > This make sense, because as we discussed when device undergo a reset
> > > with active DMA, after timeout expires, driver still cannot cleanup.
> > > So this can be short driver decided value as longer timeout is not us=
eful.
> > >
> > > > When powering up, use a longer device supplied one.
> > > In v0, v1 I initially considered only the powering up case of the
> > > device initialization. There was text around that.
> > > And v2 I removed the initialization text, and I totally missed the
> > > above case with active DMA.
> > > This should work.
> > > We should word this part of the spec accordingly.
> >
> > Below changes are good for v3?
> > 1. driver should use device reset time during initialization stage
>=20
> How does driver identify this though?
Existence of device_reset_timeout field in struct virtio_pci_common_cfg ind=
icates that this field exists.
If device support it, it will place non zero value and driver knows that th=
is field should be used.

>=20
> > 2. remove feature bit as feature bits are only readable after reset is
> > completed 3. device reset timeout field of zero indicates that device d=
oesn't
> support it.
>=20
> I'm not sure about 3. I think each transport will need its own way to do =
it.
>=20
For pci a value of zero indicates it isn't supported.
For mmio DeviceResetTimeout at offset 0x04c indicates same.
Currently only these 2 transports have the use.

> So I propose: maybe a capability like this, with a timeout field?
Do you mean a new capability like say VIRTIO_PCI_DEVICE_TIMEOUT like VIRTIO=
_PCI_CAP_COMMON_CFG?
This will contain one or more timeout? For example with his proposal it con=
tains only device reset timeout.
Later same capability will be further extended to contains command timeout =
too? Yes?

> And within VMs, we can just do without, since it got out of reset once it=
 will
> surely get out of reset again...
Yes, VM might not need it. It is really the HV's choice to implement and no=
t part of the virtio spec.
Our internal cloud passthrough a PF to the VM.
It is probably better to let HV to choose if they want to do ctrl+c or have=
 timeout.

