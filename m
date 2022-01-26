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
In-Reply-To: <PH0PR12MB54810CAE9F2E25D5C60B1116DC209@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Jan 2022 13:45:15 +0800
Message-ID: <CACGkMEu7j6mXO-bWxTq+-HQOzeMQ0WoMnPgEYbd6kf+U_aEY3Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] Introduce VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 26, 2022 at 1:26 PM Parav Pandit <parav@nvidia.com> wrote:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, January 26, 2022 10:35 AM
> >
> > =E5=9C=A8 2022/1/25 =E4=B8=8A=E5=8D=8811:52, Parav Pandit =E5=86=99=E9=
=81=93:
> > > Hi Jason,
> > >
> > >> From: Jason Wang <jasowang@redhat.com>
> > >> Sent: Tuesday, January 25, 2022 8:59 AM
> > >>
> > >> =E5=9C=A8 2022/1/19 =E4=B8=8B=E5=8D=8812:48, Parav Pandit =E5=86=99=
=E9=81=93:
> > >>>> From: Jason Wang <jasowang@redhat.com>
> > >>>> Sent: Wednesday, January 19, 2022 9:33 AM
> > >>>>
> > >>>>
> > >>>> It it means IMS, there's already a proposal[1] that introduce MSI
> > >>>> commands via the admin virtqueue. And we had similar requirement
> > >>>> for virtio-MMIO[2] and managed device or SF [3], so I would rather
> > >>>> to introduce IMS (need a better name though) as a basic facility
> > >>>> instead of tie it to any specific transport.
> > >>>>
> > >>> IMS of [1] is a interrupt configuration by the virtio driver for th=
e
> > >>> device is it
> > >> driving, which needs a queue.
> > >>> So regardless of the device type as PCI PF/VF/SF/ADI, there is
> > >>> desire to have a
> > >> generic admin queue not attached to device type.
> > >>> And AQ in this proposal exactly serves this purpose.
> > >>>
> > >>> Device configuring its own IMS vector vs PCI PF configuring VF's
> > >>> MSI-X max
> > >> vector count are two different functionality.
> > >>> Both of these commands can ride on a generic queue.
> > >>> However the queue is not same, because PF owns its own admin queue
> > >>> (for vf msix config), VF or SF operates its own admin queue (for IM=
S
> > >>> config).
> > >>
> > >> So I think in the next version we need to clarify:
> > >>
> > >> 1) is there a single admin virtqueue shared by all the VFs and PF
> > >>
> > >> or
> > >>
> > >> 2) per VF/PF admin virtqueue, and how does the driver know how to
> > >> find the corresponding admin virtqueue
> > >>
> > > Admin queue is not per VF.
> > > Lets take concrete examples.
> > > 1. So for example, PCI PF can have one AQ.
> > > This AQ carries command to query/config MSI-X vector of VFs.
> > >
> > > 2. In second example, PCI PF is creating/destroying SFs. This is agai=
n done by
> > using the AQ of the PCI PF.
> > >
> > > 3. A PCI VF has its own AQ to configure some of its own generic attri=
bute,
> > don't know which is that today.
> >
> >
> > So this could be useful if we can create SF on top of VF. But as discus=
sed we'd
> > better to generalize the concept (management device vs managed device).
> >
> It does not matter if the SF is created over PCI PF or VF. Its on top of =
PCI virtio device.
> When/if someone creates SF over PCI VF, PCI VF is management device, and =
PCI SF is managed device.
>
> When/if SF is created over PCI PF, PCI PF is managed device, and PCI SF i=
s managed device.
>
> In either case the AQ on the PCI device is transporting SF create/destroy=
 commands.

That's exactly what I meant.

>
> > > AQ inherently allows out of order commands execution.
> > > It shouldn't face contention. For example 1K depth AQ should be servi=
ng
> > hundreds of descriptors commands in parallel for SF creation, VF MSI-X =
config
> > and more.
> > >
> > > Which area/commands etc you think can lead to the contention?
> >
> >
> > Unless the we have self-conainted descriptor which contains per descrip=
tor
> > writeback address. Even if we have OOO, the enqueue and dequeue still n=
eeds
> > to be serialized?
> >
> No. we don't need to define any behavior.
> When VIRTIO_F_IN_ORDER is not negotiated, the way a VQ behaves, AQ always=
 behaves this way.
> And any synchronization to be done is done in the driver like today. Usua=
lly when posting descriptors it needs to hold lock for short internal.
> And this cannot lead to contention, due to the fact that descriptor posti=
ng time is very short.

Probably but it really depends on the magnitude of the objects that
you want to manage via the admin virtqueue. 1K queue size may work for
1K objects but not for 10K or 100K.

The lock is not the only thing that needs to care, the (busy) waiting
for the completion of the command may still take time.

>
> >
> > >
> > >> 2) if we have per vf admin virtqueue, it still doesn't scale since i=
t
> > >> occupies more hardware resources
> > >>
> > > That is too heavy, and doesn=E2=80=99t scale. Proposal is to not have=
 per vf admin
> > queue.
> > > Proposal is to have one admin queue in a virtio device.
> >
> >
> > Ok.
> >
> >
> > >
> > >>>> I do see one advantage is that the admin virtqueue is transport
> > >> independent
> > >>>> (or it could be used as a transport).
> > >>>>
> > >>> I am yet to read the transport part from [1].
> > >>
> > >> Yes, the main goal is to be compatible with SIOV.
> > >>
> > > Admin queue is a command interface transport where higher layer servi=
ces
> > can be buit.
> > > This includes SR-IOV config, SIOV config.
> > > And v2 enables SIOV commands implementation whenever they are ready.
> > >
> > >>>>> 4. Improve documentation around msix config to link to sriov
> > >>>>> section of
> > >> virtio
> > >>>> spec
> > >>>>> 5. Describe error that if VF is bound to the device, admin
> > >>>>> commands
> > >>>> targeting VF can fail, describe this error code
> > >>>>> Did I miss anything?
> > >>>>>
> > >>>>> Yet to receive your feedback on group, if/why is it needed and,
> > >>>>> why/if it
> > >> must
> > >>>> be in this proposal, what pieces prevents it do as follow-on.
> > >>>>> Cornelia, Jason,
> > >>>>> Can you please review current proposal as well before we revise v=
2?
> > >>>> If I understand correctly, most of the features (except for the
> > >>>> admin virtqueue in_order stuffs) are not specific to the admin
> > >>>> virtqueue. As discussed in the previous versions, I still think it=
's better:
> > >>>>
> > >>>> 1) adding sections in the basic device facility or data structure
> > >>>> for provisioning and MSI
> > >>>> 2) introduce admin virtqueue on top as an device interface for
> > >>>> those features
> > >>>>
> > >>> I didn't follow your suggestion. Can you please explain?
> > >>> Specifically "data structure for provisioning and MSI"..
> > >>
> > >> I meant:
> > >>
> > >> There's a chapter "Basic Facilities of a Virtio Device", we can
> > >> introduce the concepts there like:
> > >>
> > >> 1) Managed device and Management device (terminology proposed by
> > >> Michael), and can use PF and VF as a example
> > >>
> > >> 2) Managed device provisioning (the data structure to specify the
> > >> attributes of a managed device (VF))
> > >>
> > >> 3) MSI
> > >>
> > > Above is good idea. Will revisit v2, if it is not arranged this way.
> > >
> > >> And then we can introduced admin virtqueue in either
> > >>
> > >> 1) transport part
> > >>
> > >> or
> > >>
> > >> 2) PCI transport
> > >>
> > > It is not specific to PCI transport, and currently it is not a transp=
ort either.
> >
> >
> > Kind of, it allows to configure some basic attributes somehow. I think =
we'd
> > better try not to couple any features to admin virtqueue.
> >
> I am fine by defining virtio_mgmt_cmd that somehow can be issued without =
the admin queue.
> For example, struct virtio_fs_req is detached from the request queue, but=
 only way it can be issued today is with request queue.
> So we can draft the specification this way.
>
> But I repeatedly miss to see an explanation why is that needed.
> Where in the recent spec a new queue is added that has request structure =
detached from queue.
> I would like to see reference to the spec that indicates that
> a. struct virtio_fs_req can be issued by other means other than request q=
ueue.
> b. Currently the negotiation is done by so and so feature bit to do so vi=
a a request queue.
> c. "hence down the road something else can be used to carry struct virtio=
_fs_req instead of request queue".
>
> And that will give good explanation why admin queue should follow some re=
cently added queue which has structure detached from the queue.
> (not just in form of structure name, but also in form on feature negotiat=
ion plumbing etc).
>
> Otherwise detach mgmt. cmd from admin queue is vague requirement to me, t=
hat doesn=E2=80=99t require detachment.

So what I meant is not specific to any type of device. Device specific
operations should be done via virtqueue.

What I see is, we should not limit the interface for the device
independent basic device facility to be admin virtqueue only:

E.g for IMS, we should allow it to be configured with various ways

1) transport independent way: e.g admin virtqueue (which will be
eventually became another transport)

or

2) transport specific way, E.g a simple PCI(e) capability or MMIO registere=
s.

>
> > > Certainly. Admin queue is transport independent.
> > > PCI MSI-X configuration is PCI transport specific command, so structu=
res are
> > defined it accordingly.
> > > It is similar to struct virtio_pci_cap, struct virtio_pci_common_cfg =
etc.
> > >
> > > Any other transport will have transport specific interrupt configurat=
ion. So it
> > will be defined accordingly whenever that occurs.
> > > For example, IMS for VF or IMS for SF.
> >
> >
> > I don't think IMS is PCI specific stuffs, we had similar requests for M=
MIO.
> Sure, but even for that there will be SF specific command for IMS configu=
ration.
> This command will have main difference from VF will be the SF identifier =
vs VF identifier.

I think it's not hard to have a single identifier and just say it's
transport specific? Or simply reserving IDs for VF.

Thanks

