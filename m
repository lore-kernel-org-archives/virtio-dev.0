Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <PH0PR12MB54816AD1011E3806A4A26B27DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008185926-mutt-send-email-mst@kernel.org> <PH0PR12MB54814DF6BE5016FB4D941847DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <871r4ry5do.fsf@redhat.com> <PH0PR12MB5481502C480B6A7C1B61DFD6DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211011115716-mutt-send-email-mst@kernel.org> <PH0PR12MB548198414B1F64D5F7A149C8DCB69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211012045448-mutt-send-email-mst@kernel.org> <PH0PR12MB5481DB5D0F4F3EAAEB26B047DCB69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481C5C0EB93191416E36D4EDCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211014182437-mutt-send-email-mst@kernel.org> <DM8PR12MB54806B9EEECE8920F450F86BDCB99@DM8PR12MB5480.namprd12.prod.outlook.com>
 <047032b5-6b39-98cb-8517-2b02e5fb1560@redhat.com> <PH0PR12MB5481E5C62AD72F75792FC9B6DCB99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEs7gAipdbkj4DrpWLsxViHK_qicFVjy6Dy4qP7argih4g@mail.gmail.com>
 <PH0PR12MB548105873DCFFDE8FD95D0A6DCB99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEthjkX3pV+1L9Eg-nJOArSUfmDRY8UCK_2LJ7-oxO6SpQ@mail.gmail.com> <DM8PR12MB548048016A0311F809BF0E67DCB99@DM8PR12MB5480.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB548048016A0311F809BF0E67DCB99@DM8PR12MB5480.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Oct 2021 16:42:20 +0800
Message-ID: <CACGkMEuP6nZCSyz8piHYdMzwSKGgZbn65SBx486C-Lm2jbw5TA@mail.gmail.com>
Subject: Re: [virtio-dev] RE: [PATCH v2] Add device reset timeout field
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Oct 15, 2021 at 4:21 PM Parav Pandit <parav@nvidia.com> wrote:
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Friday, October 15, 2021 12:33 PM
> > > >
> > > Do you have pointer to it? I do not understand transport level reset.
> >
> > https://lore.kernel.org/virtualization/7ebb9ba0-69a0-2279-9b9e-
> > 60c50db06e94@redhat.com/
> >
> I read it. PCI level reset to recover a faulty device is useful.
> But we are not talking about resetting a PCI level here.
>
> It is very straight forward. A virtio level is reseting the device and in=
finitely waiting for it to come up.
> Instead of doing so, device is providing hint to let it wait for the time=
 driver should.

See the question below. But what I want to say is something like:

1) transport driver may have a transport specific timeout
2) if the transport driver meet that timeout during virtio reset,
perform the transport specific reset

It looks to me it will guarantee the success of the reset?

>
> > > If you are asking can PCI reset can be used to reset the device? Yes.
> >
> > Yes, I meant PCI reset.
> >
> > > But here what we are talking about is, when virtio layer issue the de=
vice
> > reset, how long should it wait for that reset to complete.
> >
> > A question is that what do we expect the driver to do if there's a time=
out on the
> > device reset?
> Oh ok. I understand your question now.
>
> As described in this proposal, when timeout expires during initialization=
 probe time, this device cannot be operated by the virtio layer,
> So it simply aborts further initialization sequence of the spec in sectio=
n 3.1.1 after step_1.
>
> Device probe has failed. So HV has several options to act on it.
> For example, do device specific debug, or do transport specific reset, re=
create the device.

But how about the device removal?

>
> >
> > > Typical example is virtio driver loading on physical virtio device ag=
nostic of
> > the transport and waiting for the device to come out of reset.
> >
> > I'm not sure how hard we can meet a device/transport agnostic timeout.
> > E.g how can we know the timeout satisfy for the requirement of all the
> > transport?
> >
> > >
> > > > > If src is hw and dst is sw, sw will likely have similar
> > > > > capabilities as hw, not just
> > > > this particular one but many other. Isn't it?
> > > >
> > > > The problem is the when src is software backend without this capabi=
lity.
> > >
> > > It isn=E2=80=99t any different than any other RW field of the device.
> > > For example sw did virtio pci device emulation with 30 msix vectors a=
nd hw
> > has only 2.
> >
> > In the case of MSI-X, the migration can't be done directly from src to =
dest. The
> > only choice is some kind of software mediation.
> >
> > In the case of timeout, the mediation won't even help, since we don't e=
ven
> > present the timeout to guest. Even if the hypervisor can see the timeou=
t
> > interface.
> Since sw didn=E2=80=99t presented the timeout to the guest, it will find =
a HW device with similar capability (without timeout).
> Or may be it can find a device that already passed the device reset state=
 and attach such device.
> HV has its options.
>
> Still not any different than rest of the RW capabilities/registers.

So the timeout doesn't work if we can enforce that. Seems sub optimal
than doing a transport reset if possible.

Thanks

