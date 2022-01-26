Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20220113145103.26894-1-mgurtovoy@nvidia.com> <20220113145103.26894-3-mgurtovoy@nvidia.com>
 <20220113102218-mutt-send-email-mst@kernel.org> <eaf88f9c-8b51-7758-90c0-c1a92df35061@nvidia.com>
 <20220113121203-mutt-send-email-mst@kernel.org> <PH0PR12MB5481B90FF747D56377A0A850DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220117170442-mutt-send-email-mst@kernel.org> <PH0PR12MB54818033A0BD96EA9493C51ADC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118011731-mutt-send-email-mst@kernel.org> <PH0PR12MB54816DB30F23511266B8F35EDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118014737-mutt-send-email-mst@kernel.org> <PH0PR12MB5481B99E351B624A27378BC5DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <15063a94-85ae-fd1a-6ff1-458a039d1def@redhat.com> <PH0PR12MB5481D5BD8BB8CFDEFA218D2FDC599@PH0PR12MB5481.namprd12.prod.outlook.com>
 <56a7bf50-509d-f9d5-df78-858cb1b156c1@redhat.com> <PH0PR12MB548182EBE025ECA44124A11DDC5F9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <622a3ecc-ac21-40ae-7fcd-9667a8fd9540@redhat.com> <PH0PR12MB54810CAE9F2E25D5C60B1116DC209@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu7j6mXO-bWxTq+-HQOzeMQ0WoMnPgEYbd6kf+U_aEY3Q@mail.gmail.com>
 <PH0PR12MB5481AD0731F32FDEE399FE85DC209@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEs76Yz5CUPDWs0x6Wo7Qh0oVYtRGEyUDjeeqJ8tnDfnfw@mail.gmail.com> <PH0PR12MB54818EA664CD2E89BD262E53DC209@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54818EA664CD2E89BD262E53DC209@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Jan 2022 14:54:13 +0800
Message-ID: <CACGkMEuH6tqD0uXpixev7cFJFvmMc0RJ-CF9n92XXLbwYRP-iA@mail.gmail.com>
Subject: Re: [PATCH 2/5] Introduce VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 26, 2022 at 2:25 PM Parav Pandit <parav@nvidia.com> wrote:
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, January 26, 2022 11:36 AM
> >
> > On Wed, Jan 26, 2022 at 1:58 PM Parav Pandit <parav@nvidia.com> wrote:
> > >
> > >
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Wednesday, January 26, 2022 11:15 AM
> > > > > It does not matter if the SF is created over PCI PF or VF. Its on
> > > > > top of PCI virtio
> > > > device.
> > > > > When/if someone creates SF over PCI VF, PCI VF is management
> > > > > device, and
> > > > PCI SF is managed device.
> > > > >
> > > > > When/if SF is created over PCI PF, PCI PF is managed device, and
> > > > > PCI SF is
> > > > managed device.
> > > > >
> > > > > In either case the AQ on the PCI device is transporting SF
> > > > > create/destroy
> > > > commands.
> > > >
> > > > That's exactly what I meant.
> > > Ok. cool. So we are in sync here. :)
> > >
> > > >
> > > > Probably but it really depends on the magnitude of the objects that
> > > > you want to manage via the admin virtqueue. 1K queue size may work
> > > > for 1K objects but not for 10K or 100K.
> > > >
> > > We can have higher queue depth.
> > > Not sure if all 10K will be active at same time, even though total 10=
K or 100K
> > devices are there.
> > > We don=E2=80=99t see the same in current Linux subfunctions users.
> >
> > Not specific to this proposal but we see at least 10K+ requirement.
> >
> > >
> > > > The lock is not the only thing that needs to care, the (busy)
> > > > waiting for the completion of the command may still take time.
> > > There is no need for busy waiting for completion.
> >
> > Yes, that's why I put busy in the brace.
> >
> > > Its admin command issued from the process context, it should be like =
blk
> > request.
> > > When completion arrives, notifier will awake the caller.
> > >
> > > > > I am fine by defining virtio_mgmt_cmd that somehow can be issued
> > > > > without
> > > > the admin queue.
> > > > > For example, struct virtio_fs_req is detached from the request
> > > > > queue, but
> > > > only way it can be issued today is with request queue.
> > > > > So we can draft the specification this way.
> > > > >
> > > > > But I repeatedly miss to see an explanation why is that needed.
> > > > > Where in the recent spec a new queue is added that has request
> > > > > structure
> > > > detached from queue.
> > > > > I would like to see reference to the spec that indicates that a.
> > > > > struct virtio_fs_req can be issued by other means other than requ=
est
> > queue.
> > > > > b. Currently the negotiation is done by so and so feature bit to
> > > > > do so via a
> > > > request queue.
> > > > > c. "hence down the road something else can be used to carry struc=
t
> > > > virtio_fs_req instead of request queue".
> > > > >
> > > > > And that will give good explanation why admin queue should follow
> > > > > some
> > > > recently added queue which has structure detached from the queue.
> > > > > (not just in form of structure name, but also in form on feature
> > > > > negotiation
> > > > plumbing etc).
> > > > >
> > > > > Otherwise detach mgmt. cmd from admin queue is vague requirement
> > > > > to
> > > > me, that doesn=E2=80=99t require detachment.
> > > >
> > > > So what I meant is not specific to any type of device. Device
> > > > specific operations should be done via virtqueue.
> > > >
> > > > What I see is, we should not limit the interface for the device
> > > > independent basic device facility to be admin virtqueue only:
> > > Can you explain, why?
> >
> > For
> >
> > 1) the vendor and transport that doesn't want to use admin virtqueue
> It is not the choice of vendor to use admin virtqueue or not. It is the s=
pec definition.

We are discussing the proposal which hasn't been a part of the spec
right now. It doesn't mean we can't do better.

>
> Why a transport doesn=E2=80=99t want to use admin queue?

The answer is simple and straightforward, each transport had already
had its transport specific way to configure the device.

> I don=E2=80=99t follow why virtio fs device wants to use something other =
than request queue to transport virtio_fs_req.

See my previous reply, I didn't mean we need to change any device
specific operation like virtio_fs_req.

What I meant is, let's take MSI as an example

1) PCI has MSI table
2) MMIO doesn't support MSI

It looks to me you want to mandate admin virtqueue to MMIO in order to
configure MSI?

>
> > 2) a more simple interface for L1
> I don=E2=80=99t see virtqueue as complicated object which exists for 10+ =
years now and in use by 18 devices in L1 and also in L2.
> And it is something to be used for multiple commands.

So again, there's misunderstanding. It's all about the "control plane"
but not "dataplane". A simple example is to configure the vq address.

1) For PCI it was done via common_cfg structure
2) For MMIO it was done via dedicated registers
3) For CCW, it was done via dedicated commands

And we know we need dedicated commands for the admin virtqueue. Since
we had a transport specific interface, guest drivers can still
configure the virtqueue address in L1 via the transport specific
interface. So the hypervisor can hide the admin virtqueue. Let's say
we introduce a new feature X for the admin virtqueue only. How can a
guest driver to use that feature? Do we want to hide or assign the
admin virtqueue to L1?

I understand that for things like provisioning which might not be
needed for L1, but how about others?

>
> >
> > >
> > > >
> > > > E.g for IMS, we should allow it to be configured with various ways
> > > >
> > > IMS configuration is very abstract.
> > > Lets talk specific.
> > > I want to make sure when you say IMS configuration,
> > >
> > > Do you me HV is configuring IMS number of vectors for the VF/SF?
> > > If it's this, than, it is similar to how HV provision MSIX for a VF.
> >
> > It can be done by introducing a capability in the PF?
> >
> > struct msix_provision {
> > u32 device_select;
> > u16 msix_vectors;
> > u16 padding;
> > };
> >
> Shahaf and I already explained in this thread that this capability doesn=
=E2=80=99t scale to your question about "I do not understand scale ..".
> So a device that wants to do above can simply do this with AQ with single=
 VQ depth and still achieve the simplicity.

I thought it was for SF but not SR-IOV.

I think we all know SR-IOV doesn't scale in many ways and if I
understand this series correctly, the main goal is not to address the
scalability issues.

It's good to consider the scalability but there could be cases that
don't need to be scaled.

>
> Michael also responded that device configuration will not end at msix con=
figuration.
> So adding more and more tiny capabilities for each configuration doesn't =
scale either.
>
> > >
> > > Or you mean, a guest driver of VF or SF is configuring its IMS to lat=
er
> > consume for the VQ?
> > > If its this, than I explained that admin queue is not the vehicle to =
do so, and
> > we discussed the other structure yday.
> >
> > Yes, I guess that's the nesting case I mentioned above.
> >
> > >
> > > > 1) transport independent way: e.g admin virtqueue (which will be
> > > > eventually became another transport)
> > > >
> > > IMS by guest driver cannot be configured by AQ.
> >
> > Yes, that's one point.
> >
> Ok. cool. We sync here too. :)

So I guess you know what I meant for the L1 interface?

Thanks

>
> > >
> > > > or
> > > >
> > > > 2) transport specific way, E.g a simple PCI(e) capability or MMIO r=
egisteres.
> > > >
> > > This is practical.
> >
> > Right.
> >
> > >
> > > > >
> > > > > > > Certainly. Admin queue is transport independent.
> > > > > > > PCI MSI-X configuration is PCI transport specific command, so
> > > > > > > structures are
> > > > > > defined it accordingly.
> > > > > > > It is similar to struct virtio_pci_cap, struct virtio_pci_com=
mon_cfg etc.
> > > > > > >
> > > > > > > Any other transport will have transport specific interrupt
> > > > > > > configuration. So it
> > > > > > will be defined accordingly whenever that occurs.
> > > > > > > For example, IMS for VF or IMS for SF.
> > > > > >
> > > > > >
> > > > > > I don't think IMS is PCI specific stuffs, we had similar reques=
ts for
> > MMIO.
> > > > > Sure, but even for that there will be SF specific command for IMS
> > > > configuration.
> > > > > This command will have main difference from VF will be the SF
> > > > > identifier vs
> > > > VF identifier.
> > > >
> > > > I think it's not hard to have a single identifier and just say it's=
 transport
> > specific?
> > > It is hard when SFs are not defined.
> > >
> > > > Or simply reserving IDs for VF.
> > > When SF are not defined, it doesn=E2=80=99t make sense to reserve any=
 bytes for it.
> > > Linux has 4 bytes SF identifier.
> > > Community might go UUID way or some other way.
> > > We cannot define arbitrary bytes that may/may not be enough.
> > >
> > > When SF will be defined, it will anyway have sf identifier and it wil=
l be super
> > easy to define new vector configuration structure for SF.
> > > Let's not overload VF MSI-X configuration proposal to be intermix wit=
h SF.
> >
> > That's fine.
>
> Ok. thanks.

