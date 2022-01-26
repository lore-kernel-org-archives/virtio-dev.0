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
 <CACGkMEs76Yz5CUPDWs0x6Wo7Qh0oVYtRGEyUDjeeqJ8tnDfnfw@mail.gmail.com>
 <PH0PR12MB54818EA664CD2E89BD262E53DC209@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuH6tqD0uXpixev7cFJFvmMc0RJ-CF9n92XXLbwYRP-iA@mail.gmail.com> <PH0PR12MB54810131D028210D5633B338DC209@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54810131D028210D5633B338DC209@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Jan 2022 17:07:01 +0800
Message-ID: <CACGkMEt8eg4wvEZJPM9_FuQJMs_kBXo127K7JKgtSPoOeH8S9w@mail.gmail.com>
Subject: Re: [PATCH 2/5] Introduce VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 26, 2022 at 4:09 PM Parav Pandit <parav@nvidia.com> wrote:
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, January 26, 2022 12:24 PM
> >
> > > >
> > > > 1) the vendor and transport that doesn't want to use admin virtqueu=
e
> > > It is not the choice of vendor to use admin virtqueue or not. It is t=
he spec
> > definition.
> >
> > We are discussing the proposal which hasn't been a part of the spec rig=
ht now.
> > It doesn't mean we can't do better.
> Sure. It=E2=80=99s the proposal we are discussing, but I fail to understa=
nd why a vendor doesn=E2=80=99t want to use a admin queue due to which it n=
eeds to be detached.

What do you mean by "detached"?

>
> > >
> > > Why a transport doesn=E2=80=99t want to use admin queue?
> >
> > The answer is simple and straightforward, each transport had already ha=
d its
> > transport specific way to configure the device.
> Each transport uses transport agnostic way to communicate the requests an=
d response to the device by means of virtqueue descriptors.
>
> And that is done through virtqueue.
>
> A descriptor in a virtqueue represents wide range of things.
> 1. Sometime sending packet,
> 2. sometimes configuring vlan,
> 3. sometime configuring adding mac to table.
> 4. sometime adding crypto session
> 5. and now sometime managing a managed VF or SF device
>
> Item #5 is no different than #1 to #4.
> Managed device configuration !=3D "generic configure the device".

Well, I think then you need to explain this well in the patch.

>
> >
> > > I don=E2=80=99t follow why virtio fs device wants to use something ot=
her than request
> > queue to transport virtio_fs_req.
> >
> > See my previous reply, I didn't mean we need to change any device speci=
fic
> > operation like virtio_fs_req.
> >
> You imply that virtio_fs_req must be carried on the request queue, but so=
me other request like to use other than virtqueue even though its explained=
 several times that why virtqueue is used.
> Doesn't make sense at all.

So a virtqueue is needed only when DMA is required. That is the case
for virtio_fs_req.

For other cases that DMA is not a must, it could or not be a queue interfac=
e.

>
> > What I meant is, let's take MSI as an example
> >
> > 1) PCI has MSI table
> > 2) MMIO doesn't support MSI
> >
> > It looks to me you want to mandate admin virtqueue to MMIO in order to
> > configure MSI?
> >
> If you want to attribute it as "mandate" than yes, it is no different tha=
n,
> virtio_fs_req is mandated on request vq.
> virtio_crypto_op_ctrl_req ia mandated on control vq.
>
> What prevents both above examples to used AQ in generic manner?

Nothing, but for simple features like MSI I don't think we can exclude
the possibility of using dedicated registers. For a simple setup like
a guest that is using an MMIO device, using new virtqueue just for MSI
seems an odd burden.

>
> > >
> > > > 2) a more simple interface for L1
> > > I don=E2=80=99t see virtqueue as complicated object which exists for =
10+ years now
> > and in use by 18 devices in L1 and also in L2.
> > > And it is something to be used for multiple commands.
> >
> > So again, there's misunderstanding. It's all about the "control plane"
> > but not "dataplane". A simple example is to configure the vq address.
> >
> > 1) For PCI it was done via common_cfg structure
> > 2) For MMIO it was done via dedicated registers
> > 3) For CCW, it was done via dedicated commands
>
> We discussed already and you ignored the scale, on-die and other comments=
.

Looks not, it's the IMS discussion that confuses the thread probably.

> And low level self-device configuration is compared with managing device =
configuration.
> This comparison simply isn't right.
>
> data plane =3D> vq
> control plane =3D> cq + transport specific cfg
> mgmt plane =3D> aq (this proposal)
>
> mgmt plane !=3D device on vq configuration.

To clarify, we need to define what exactly did management mean? E.g is
IMS considered to be mgmt or control?

> Device on vq configuration doesn't block with other device VQ configurati=
on.
>
> >
> > And we know we need dedicated commands for the admin virtqueue.
> Not sure I follow you. AQ carries admin queue commands like any other que=
ues.
>
> > Since we
> > had a transport specific interface, guest drivers can still configure t=
he virtqueue
> > address in L1 via the transport specific interface. So the hypervisor c=
an hide the
> > admin virtqueue. Let's say we introduce a new feature X for the admin
> > virtqueue only. How can a guest driver to use that feature?
> As the patch-1, and patch-4 clearly shows the purpose of the AQ, AQ is of=
 the virtio device located in the HV is not for the consumption in the gues=
t driver.
>
> > Do we want to hide
> > or assign the admin virtqueue to L1?
> A virtio device in guest may have its own admin queue. But again, until n=
ow there is no concrete example discussed that demands an admin queue in th=
e guest driver.
> IMS vector enable/disable was the closest one we discussed and we agreed =
that AQ cannot be used for that.

Ok.

>
> >
> > I understand that for things like provisioning which might not be neede=
d for L1,
> > but how about others?
> Others?

Well, I'd say if you limit the admin virtuqueue for provisioning, it
should be fine.

>
> > > >
> > > Shahaf and I already explained in this thread that this capability do=
esn=E2=80=99t scale
> > to your question about "I do not understand scale ..".
> > > So a device that wants to do above can simply do this with AQ with si=
ngle VQ
> > depth and still achieve the simplicity.
> >
> > I thought it was for SF but not SR-IOV.
> Ah, that was the misunderstanding you had. It applies to SF and SR-IOV bo=
th.
>
> >
> > I think we all know SR-IOV doesn't scale in many ways and if I understa=
nd this
> > series correctly, the main goal is not to address the scalability issue=
s.
> You are mixing many things here. Do not mix SR-IOV VF scaling with PF res=
ource scaling.
> Please keep it focused.
>
> The goal as constantly repeated, is to have a interface between driver an=
d device to carry multiple commands in scalable way without consuming on-ch=
ip resources.
>
> >
> > It's good to consider the scalability but there could be cases that don=
't need to
> > be scaled.
> Sure, in that case AQ of single entry is just fine.
>
> >
> > >
> > > Michael also responded that device configuration will not end at msix
> > configuration.
> > > So adding more and more tiny capabilities for each configuration does=
n't
> > scale either.
> > >
> You need to ack above point otherwise we will keep discussing this even 2=
 weeks from now. :)

I think I've acknowledged in another thread about the idea of using
admin virtqueue.

Thanks

>
> > > > >
> > > > > Or you mean, a guest driver of VF or SF is configuring its IMS to
> > > > > later
> > > > consume for the VQ?
> > > > > If its this, than I explained that admin queue is not the vehicle
> > > > > to do so, and
> > > > we discussed the other structure yday.
> > > >
> > > > Yes, I guess that's the nesting case I mentioned above.
> > > >
> > > > >
> > > > > > 1) transport independent way: e.g admin virtqueue (which will b=
e
> > > > > > eventually became another transport)
> > > > > >
> > > > > IMS by guest driver cannot be configured by AQ.
> > > >
> > > > Yes, that's one point.
> > > >
> > > Ok. cool. We sync here too. :)
> >
> > So I guess you know what I meant for the L1 interface?
> With your last question, let me double check my understanding. :)
>
> My understanding of L1 interface is virtio device in hypervisor. Is that =
right?
>

