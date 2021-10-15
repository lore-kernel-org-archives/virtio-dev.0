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
 <CACGkMEs7gAipdbkj4DrpWLsxViHK_qicFVjy6Dy4qP7argih4g@mail.gmail.com> <PH0PR12MB548105873DCFFDE8FD95D0A6DCB99@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548105873DCFFDE8FD95D0A6DCB99@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Oct 2021 15:02:47 +0800
Message-ID: <CACGkMEthjkX3pV+1L9Eg-nJOArSUfmDRY8UCK_2LJ7-oxO6SpQ@mail.gmail.com>
Subject: Re: [virtio-dev] RE: [PATCH v2] Add device reset timeout field
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Oct 15, 2021 at 2:48 PM Parav Pandit <parav@nvidia.com> wrote:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Friday, October 15, 2021 12:12 PM
> >
> > On Fri, Oct 15, 2021 at 1:20 PM Parav Pandit <parav@nvidia.com> wrote:
> > >
> > >
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Friday, October 15, 2021 10:46 AM
> > > >
> > > >
> > > > =E5=9C=A8 2021/10/15 =E4=B8=8B=E5=8D=8812:36, Parav Pandit =E5=86=
=99=E9=81=93:
> > > > >
> > > > >> From: Michael S. Tsirkin <mst@redhat.com>
> > > > >> Sent: Friday, October 15, 2021 3:59 AM
> > > > >>
> > > > >> On Thu, Oct 14, 2021 at 05:35:37PM +0000, Parav Pandit wrote:
> > > > >>> Hi Michael, Cornelia,
> > > > >>>
> > > > >>>> From: Parav Pandit
> > > > >>>> Sent: Tuesday, October 12, 2021 2:42 PM
> > > > >>>>
> > > > >>>>> From: Michael S. Tsirkin <mst@redhat.com>
> > > > >>>>> Sent: Tuesday, October 12, 2021 2:32 PM
> > > > >>>>>
> > > > >>>>> On Tue, Oct 12, 2021 at 08:51:34AM +0000, Parav Pandit wrote:
> > > > >>>>>>
> > > > >>>>>>> From: Michael S. Tsirkin <mst@redhat.com>
> > > > >>>>>>> Sent: Monday, October 11, 2021 9:30 PM
> > > > >>>>>>>
> > > > >>>>>>> On Mon, Oct 11, 2021 at 03:44:14PM +0000, Parav Pandit wrot=
e:
> > > > >>>>>>>>>> This is unlikely to work the reset is completed. Because
> > > > >>>>>>>>>> a real device
> > > > >>>>>>>>> implementing this would prefer to do this in fw for 1000
> > > > >>>>>>>>> virtio devices sitting on the physical card.
> > > > >>>>>>>>>> And it is very much driven by such implementation at
> > > > >>>>>>>>>> device
> > > > >> devel.
> > > > >>>>>>>>>> So it cannot update the counter value if reset is not
> > > > >>>>>>>>>> completed for the
> > > > >>>>>>> device.
> > > > >>>>>>>>>> I think read only device reset timeout is most elegant
> > > > >>>>>>>>>> option during device
> > > > >>>>>>>>> initialization phase that eliminates infinite loop of tod=
ay.
> > > > >>>>>>>>>
> > > > >>>>>>>>> Why can't a driver just go ahead and do a timeout regardl=
ess?
> > > > >>>>>>>> o.k. lets consider this thought exercise. What is the
> > > > >>>>>>>> timeout value that driver
> > > > >>>>>>> will choose if device doesn't specify one?
> > > > >>>>>>>> I explained in previous thread and you acked that actual f=
w
> > > > >>>>>>>> based device
> > > > >>>>>>> may take longer to initialize than pure sw implementation
> > backend.
> > > > >>>>>>>> In second example a pre-boot device can take even longer
> > > > >>>>>>>> initialization
> > > > >>>>> time.
> > > > >>>>>>>> Sriov VF device may initialize lot faster.
> > > > >>>>>>>> Instead of driver having such transport, and device
> > > > >>>>>>>> specific checks, (or some
> > > > >>>>>>> very short or very long timeout), we propose, that let
> > > > >>>>>>> device mention such timeout value.
> > > > >>>>>>>
> > > > >>>>>>> Parav I think you are conflating reset with initialization =
time.
> > > > >>>>>>> initialization is just for host boot which takes seconds
> > > > >>>>>>> anyway
> > > > >>>>>>> - but no, minutes is not reasonable their, either.
> > > > >>>>>>> reset affects guest boot. This needs to complete in millise=
conds.
> > > > >>>>>>>
> > > > >>>>>> I cannot promise, but with newer generation devices usually
> > > > >>>>>> functionality
> > > > >>>>> improves.
> > > > >>>>>> Enforcing in milliseconds doesn't look practical for type of=
 devices.
> > > > >>>>>> Some of the block devices may need to establish TCP
> > > > >>>>>> connections in the
> > > > >>>>> backend.
> > > > >>>>>> It is more useful to wait for few more seconds to initialize
> > > > >>>>>> device after power
> > > > >>>>> on the system, instead of giving up booting the server comple=
tely.
> > > > >>>>>> For example, a nvme block device starts with a minimum
> > > > >>>>>> timeout of
> > > > >>>>> 500msec.
> > > > >>>>>> Yes, I agree to your point that a device given to a guest VM
> > > > >>>>>> will likely have
> > > > >>>>> very short reset time that should complete in milliseconds.
> > > > >>>>>>> This conflation is IMHO one of the problems with this propo=
sal.
> > > > >>>>>> Device initialization consist of device reset from the spec =
section
> > 3.1.1.
> > > > >>>>> It does. But maybe we need to create a way for driver to
> > > > >>>>> distinguish between the two. When under reset, use a driver
> > > > >>>>> supplied
> > > > >> timeout.
> > > > >>>> This make sense, because as we discussed when device undergo a
> > > > >>>> reset with active DMA, after timeout expires, driver still can=
not
> > cleanup.
> > > > >>>> So this can be short driver decided value as longer timeout is=
 not
> > useful.
> > > > >>>>
> > > > >>>>> When powering up, use a longer device supplied one.
> > > > >>>> In v0, v1 I initially considered only the powering up case of
> > > > >>>> the device initialization. There was text around that.
> > > > >>>> And v2 I removed the initialization text, and I totally missed
> > > > >>>> the above case with active DMA.
> > > > >>>> This should work.
> > > > >>>> We should word this part of the spec accordingly.
> > > > >>> Below changes are good for v3?
> > > > >>> 1. driver should use device reset time during initialization
> > > > >>> stage
> > > > >> How does driver identify this though?
> > > > > Existence of device_reset_timeout field in struct
> > > > > virtio_pci_common_cfg
> > > > indicates that this field exists.
> > > > > If device support it, it will place non zero value and driver
> > > > > knows that this
> > > > field should be used.
> > > > >
> > > > >>> 2. remove feature bit as feature bits are only readable after
> > > > >>> reset is completed 3. device reset timeout field of zero
> > > > >>> indicates that device doesn't
> > > > >> support it.
> > > > >>
> > > > >> I'm not sure about 3. I think each transport will need its own w=
ay to do it.
> > > > >>
> > > > > For pci a value of zero indicates it isn't supported.
> > > > > For mmio DeviceResetTimeout at offset 0x04c indicates same.
> > > > > Currently only these 2 transports have the use.
> > > > >
> > > > >> So I propose: maybe a capability like this, with a timeout field=
?
> > > > > Do you mean a new capability like say VIRTIO_PCI_DEVICE_TIMEOUT
> > > > > like
> > > > VIRTIO_PCI_CAP_COMMON_CFG?
> > > > > This will contain one or more timeout? For example with his
> > > > > proposal it
> > > > contains only device reset timeout.
> > > > > Later same capability will be further extended to contains comman=
d
> > > > > timeout
> > > > too? Yes?
> > > > >
> > > > >> And within VMs, we can just do without, since it got out of rese=
t
> > > > >> once it will surely get out of reset again...
> > > > > Yes, VM might not need it. It is really the HV's choice to
> > > > > implement and not
> > > > part of the virtio spec.
> > > >
> > > >
> > > > Well, this will break the migration between HW virtio and SW virtio=
.
> > > >
> > > How does it break? Can you please explain?
> > > SW virtio will emulate what HW virtio does. This field is exposing on=
ly read-
> > only field to driver to not wait infinitely.
> >
> > As discussed previously, can we use transport level reset in this case?
> >
> Do you have pointer to it? I do not understand transport level reset.

https://lore.kernel.org/virtualization/7ebb9ba0-69a0-2279-9b9e-60c50db06e94=
@redhat.com/

> If you are asking can PCI reset can be used to reset the device? Yes.

Yes, I meant PCI reset.

> But here what we are talking about is, when virtio layer issue the device=
 reset, how long should it wait for that reset to complete.

A question is that what do we expect the driver to do if there's a
timeout on the device reset?

> Typical example is virtio driver loading on physical virtio device agnost=
ic of the transport and waiting for the device to come out of reset.

I'm not sure how hard we can meet a device/transport agnostic timeout.
E.g how can we know the timeout satisfy for the requirement of all the
transport?

>
> > > If src is hw and dst is sw, sw will likely have similar capabilities =
as hw, not just
> > this particular one but many other. Isn't it?
> >
> > The problem is the when src is software backend without this capability=
.
>
> It isn=E2=80=99t any different than any other RW field of the device.
> For example sw did virtio pci device emulation with 30 msix vectors and h=
w has only 2.

In the case of MSI-X, the migration can't be done directly from src to
dest. The only choice is some kind of software mediation.

In the case of timeout, the mediation won't even help, since we don't
even present the timeout to guest. Even if the hypervisor can see the
timeout interface.

Thanks

