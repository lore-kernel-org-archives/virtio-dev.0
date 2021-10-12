Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2] Add device reset timeout field
Date: Tue, 12 Oct 2021 09:12:28 +0000
Message-ID: <PH0PR12MB5481DB5D0F4F3EAAEB26B047DCB69@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <87lf33ybz7.fsf@redhat.com>
 <PH0PR12MB5481270F843DEC30A49972F3DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008085134-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816AD1011E3806A4A26B27DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008185926-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814DF6BE5016FB4D941847DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <871r4ry5do.fsf@redhat.com>
 <PH0PR12MB5481502C480B6A7C1B61DFD6DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211011115716-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548198414B1F64D5F7A149C8DCB69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211012045448-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211012045448-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, October 12, 2021 2:32 PM
>=20
> On Tue, Oct 12, 2021 at 08:51:34AM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Monday, October 11, 2021 9:30 PM
> > >
> > > On Mon, Oct 11, 2021 at 03:44:14PM +0000, Parav Pandit wrote:
> > > > > > This is unlikely to work the reset is completed. Because a
> > > > > > real device
> > > > > implementing this would prefer to do this in fw for 1000 virtio
> > > > > devices sitting on the physical card.
> > > > > > And it is very much driven by such implementation at device dev=
el.
> > > > > > So it cannot update the counter value if reset is not
> > > > > > completed for the
> > > device.
> > > > > >
> > > > > > I think read only device reset timeout is most elegant option
> > > > > > during device
> > > > > initialization phase that eliminates infinite loop of today.
> > > > >
> > > > > Why can't a driver just go ahead and do a timeout regardless?
> > > > o.k. lets consider this thought exercise. What is the timeout
> > > > value that driver
> > > will choose if device doesn't specify one?
> > > > I explained in previous thread and you acked that actual fw based
> > > > device
> > > may take longer to initialize than pure sw implementation backend.
> > > > In second example a pre-boot device can take even longer initializa=
tion
> time.
> > > > Sriov VF device may initialize lot faster.
> > > > Instead of driver having such transport, and device specific
> > > > checks, (or some
> > > very short or very long timeout), we propose, that let device
> > > mention such timeout value.
> > >
> > > Parav I think you are conflating reset with initialization time.
> > > initialization is just for host boot which takes seconds anyway -
> > > but no, minutes is not reasonable their, either.
> > > reset affects guest boot. This needs to complete in milliseconds.
> > >
> > I cannot promise, but with newer generation devices usually functionali=
ty
> improves.
> > Enforcing in milliseconds doesn't look practical for type of devices.
> > Some of the block devices may need to establish TCP connections in the
> backend.
> > It is more useful to wait for few more seconds to initialize device aft=
er power
> on the system, instead of giving up booting the server completely.
> > For example, a nvme block device starts with a minimum timeout of
> 500msec.
> >
> > Yes, I agree to your point that a device given to a guest VM will likel=
y have
> very short reset time that should complete in milliseconds.
> >
> > > This conflation is IMHO one of the problems with this proposal.
> >
> > Device initialization consist of device reset from the spec section 3.1=
.1.
>=20
> It does. But maybe we need to create a way for driver to distinguish betw=
een
> the two. When under reset, use a driver supplied timeout.
This make sense, because as we discussed when device undergo a reset with a=
ctive DMA, after timeout expires, driver still cannot cleanup.
So this can be short driver decided value as longer timeout is not useful.

> When powering up, use a longer device supplied one.
In v0, v1 I initially considered only the powering up case of the device in=
itialization. There was text around that.
And v2 I removed the initialization text, and I totally missed the above ca=
se with active DMA.
This should work.
We should word this part of the spec accordingly.

> migration is not a problem for baremetal so all's good from that point of=
 view.
> And power up seems irrelevant for ccw/mmio since these are always within
> VMs. So it's a pci only thing.
>
I am not 100% sure for MMIO.
There may be future MMIO device similar to PCI, not sure.
I thought someone else too (Qualcomm?) had MMIO device that took bit longer=
 to initialize in past discussion?
=20
> --
> MST

