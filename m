Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20220117170442-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818033A0BD96EA9493C51ADC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118011731-mutt-send-email-mst@kernel.org> <PH0PR12MB54816DB30F23511266B8F35EDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118014737-mutt-send-email-mst@kernel.org> <PH0PR12MB5481B99E351B624A27378BC5DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118020831-mutt-send-email-mst@kernel.org> <PH0PR12MB54817CAD287BCA267504C16FDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118023837-mutt-send-email-mst@kernel.org> <8d6b0158-5747-eb9e-724e-458f1e13cbfc@redhat.com>
 <20220119042740-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220119042740-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jan 2022 11:39:01 +0800
Message-ID: <CACGkMEv9jiWWC7jgbk2UjmGseQZhg-nKmNUwpgvB9m+=-ga7wQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] Introduce VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 19, 2022 at 5:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jan 19, 2022 at 12:21:36PM +0800, Jason Wang wrote:
> >
> > =E5=9C=A8 2022/1/18 =E4=B8=8B=E5=8D=883:40, Michael S. Tsirkin =E5=86=
=99=E9=81=93:
> > > On Tue, Jan 18, 2022 at 07:30:34AM +0000, Parav Pandit wrote:
> > > >
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Tuesday, January 18, 2022 12:42 PM
> > > > >
> > > > > On Tue, Jan 18, 2022 at 07:07:03AM +0000, Parav Pandit wrote:
> > > > > > 1. Use AQ for msix query and config
> > > > > > 2. AQ to follows IN_ORDER and INDIRECT_DESC negotiation like re=
st of
> > > > > > the queues 3. Update commit log to describe why config space is=
 not
> > > > > > chosen (scale, on-die registers, uniform way to handle all aq c=
mds) 4.
> > > > > > Improve documentation around msix config to link to sriov secti=
on of
> > > > > > virtio spec 5. Describe error that if VF is bound to the device=
, admin
> > > > > > commands targeting VF can fail, describe this error code
> > > > > >
> > > > > > Did I miss anything?
> > > > > Better document in spec text just what is the scope for AQ.
> > > > >
> > > > Yes, will improve this spec.
> > > > > > Yet to receive your feedback on group, if/why is it needed and,=
 why/if it must
> > > > > be in this proposal, what pieces prevents it do as follow-on.
> > > > >
> > > > > I think this is related to the subfunction usecase or other futur=
e usecase. In
> > > > > case of PF/VF grouping is implicit through the SRIOV capability. =
It would be
> > > > > nice to have things somewhat generic in most of the text though s=
ince we
> > > > > already know this will be needed.
> > > > > E.g. jason sent a proposal for commands to add/delete subfunction=
s, take a
> > > > > look at it, somehow AQ needs to be extendable to support that fun=
ctionality
> > > > > too.
> > > > I looked briefly to it. AQ can be used for such purpose. Current pr=
oposal adds only msix config piece.
> > > > But more commands can be added in future.
> > > >
> > > > What I wanted to check with you and other is, do we want command op=
code to be 7-bit enough?
> > > > #127 is lot of admin commands. =F0=9F=98=8A
> > > > But given virtio spec diversity of transport and device types, I wa=
s thinking to keep it 15-bit for future proofing.
> > > > What do you think?
> > > I agree, we are not short on bits.
> > >
> > > > An unrelated command to AQ in Jason's proposal [1] is about " The m=
anagement driver MUST create a managed device by allocating".
> > > > We see that creator of the subfunction is often not the only entity=
 managing it.
> > > I think whoever does it can go through the main function driver.
> > >
> > > > They being same in new era finding less and less users.
> > > > So this piece needs more discussion whenever we address that.
> > > >
> > > > [1] https://lists.oasis-open.org/archives/virtio-comment/202108/msg=
00136.html
> >
> >
> > Yes, I do that for dynamic provisioning which seems a requirement (or b=
etter
> > to have) for SIOV spec. We can extend or tweak it for static provisioni=
ng.
> >
> > Thanks
> >
>
> So you are basically saying that since with scalable iov we need
> commands to create subfunctions, let's straight away teach
> people to use them to manage VFs.
> So before a VF can be used, you are asking that people "allocate" it
> through a PF.  Is that right?

Right.

>
> I have to say that addresses one concern I just had, which is that
> it's unclear what is the status of a VF before any commands are
> issued.

I'm not even sure it's possible, my understanding is that most vendors
choose to go with static provisioning via sriov_numvfs. So such
dynamic on demand provisioning might be tricky.

For SR-IOV it has another subtle limitation that mandates all VF to
have the same device type.

Thanks

>
>
> --
> MST
>

