Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH 2/5] Introduce
 VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
Date: Tue, 18 Jan 2022 06:32:50 +0000
Message-ID: <PH0PR12MB54816DB30F23511266B8F35EDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-3-mgurtovoy@nvidia.com>
 <20220113102218-mutt-send-email-mst@kernel.org>
 <eaf88f9c-8b51-7758-90c0-c1a92df35061@nvidia.com>
 <20220113121203-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B90FF747D56377A0A850DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220117170442-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818033A0BD96EA9493C51ADC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118011731-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220118011731-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, January 18, 2022 11:54 AM
>=20
> On Tue, Jan 18, 2022 at 04:44:36AM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, January 18, 2022 3:44 AM
> >
> > > > > It's a control queue. Why do we worry?
> > > > It is used to control/manage the resource of a VF which is
> > > > deployed usually
> > > to a VM.
> > > > So higher the latency, higher the time it takes to deploy start the=
 VM.
> > >
> > > What are the savings here, in real terms? Boot times for smallest
> > > VMs are in 10s of milliseconds. Is reordering of a queue somehow
> > > going to save more than microseconds?
> > >
> > It is probably better not to pick on a specific vendor implementation.
> > But for real numbers, I see that an implementation takes 54usec to 500 =
usec
> range for simple configuration.
> >
> > It is better to not small VM 4 vector configuration to take longer beca=
use
> there was previous AQ command for 64 vectors.
>=20
> So virtio discovery on boot includes multiple of vmexits, each costs ~100=
0
> cycles.  And people do not seem to worry about it.
It is not the vector configuration by guest VM.
It is the AQ command that provisions number of msix vectors for the VF that=
 takes tens to hundreds of usecs.
These are the command in patch-5 in this proposal.

> You want a compelling argument for working on performance of config.
> I frankly think it's not really useful but I especially think you should =
cut this out
> of the current proposal, it's too big as it is.
>=20
Ok. We can do follow on proposal after AQ.
We already see need of out of order AQ in internal performance tests we are=
 running.
But fine, we can differ.

> > > > Hence, it is better to have this basic functionality in place,
> > > > being useful
> > > beyond MSI-X config.
> > > > It is not functionally must. But riding AQ command ordering on
> > > VIRTIO_F_IN_ORDER for now and later on driving based on new field
> > > requires dual handling.
> > > > Better to start with its AQ's own ordering and one scheme.
> > >
> > > Sorry I'm still scratching my head.
> >
> > if (DEV.IN_ORDER_NEGOTIATED /*current */ ||
> >     AQ.IN_ORDERED_NEGOTIATED /* new */) {
> > =09/* handle AQ descriptors in-order way */ } else {
> > =09/* handle AQ desc out-of order way */ }
> >
> > By always doing AQ commands out of order, we simplify the driver and
> device to avoid in-order execution.
>=20
> No idea what this means. Needs much more motivational discussion, and
> more thought about using generic infrastructure.
> How about making this a separate proposal?
>
Got it. Will drive it in follow on separate proposal.
=20
>=20
> > > > > >
> > > > > > And also the other way around.
> > > > >
> > > > > what exactly does this mean?
> > > > >
> > > > IO commands out of order (for say block device), but AQ commands in
> order.
> > > > May be AQ command execution can be always treated as out of order,
> > > > even
> > > when VIRTIO_F_IN_ORDER is negotiated.
> > > > This way it will be even more simpler design for driver and device.
> > > >
> > > > > > IO cmds and admin cmds have different considerations in many ca=
ses.
> > > > >
> > > > > That's still pretty vague.  so do other types of VQ, such as RX/T=
X.
> > > > >
> > > > > E.g. I can see how a hardware vendor might want to avoid
> > > > > supporting indirect with RX for virtio net with mergeable
> > > > > buffers, but still support it for
> > > TX.
> > > > >
> > > > >
> > > > > I can vaguely see the usefulness of VIRTIO_F_ADMIN_VQ_IN_ORDER.
> > > > I agree. It only helps driver to ensure that AQ commands are
> > > > processed in
> > > order, so it doesn't need to serialize it.
> > > > But yes, driver can always serialize it if needed when AQ is
> > > > always out of
> > > order.
> > > > I think we should word it that AQ is always out of order.
> > > >
> > > > > I think you want to reorder admin commands dealing with
> > > > > unrelated VFs but keep io vqs in order for speed.
> > > > > Just guessing, you should spell the real motivation out.
> > > > > However, I think a better way to do that is with finalizing the
> > > > > VIRTIO_F_PARTIAL_ORDER proposal from august.
> > > > I read the partial order proposal at [1].
> > > > It still appears IN_ORDER from driver POV.
> > > > So I am not sure if driver can complete AQ commands out of order. C=
an
> it?
> > >
> > > complete commands =3D=3D use buffers?
> > Complete descriptors out of order.
> > I used term command as AQ descriptor used commands.
> > Will rephase.
>=20
> So in that case just work on VIRTIO_F_PARTIAL_ORDER please. I think there=
's a
> way to make it work for your usecase.
>=20
> > > drivers do not use buffers.
> > >
> >
> > > > I think data path needs more plumbing that just PARTIAL_ORDER
> > > > flag, for
> > > descriptor processing differently on tx and rx side.
> > > > Not sure merging AQ to it is useful, given that we agree that AQ
> > > > should
> > > always behave as out of order from beginning.
> > > >
> > > > [1]
> > > > https://lists.oasis-open.org/archives/virtio-dev/202008/msg00001.h
> > > > tml
> > >
> > > You mean *device*. Driver does not control the order.
> > Data path I meant device and driver both.
> > Driver doesn't control the order, but should be ready to handle used
> descriptors out of order when PARTIAL is negotiated.
> >
> > > The point of PARTIAL_ORDER is basically that some descriptors are in
> > > order some out of order and its up to device. So it is even finer res=
olution.
> > >
> > >
> > > > > Pls review and let me know. If there's finally a use for it I'll
> > > > > prioritize finalizing that idea.
> > > > > Don't see much point in tweaking INDIRECT at all.
> > > > Common negotiation of INDIRECT on AQ and other queues forces data
> > > > path
> > > also to handle that.
> > >
> > > I don't see why admin queue needs indirect descriptors.
> > >
> > Probably yes. the simple idea is, not to impose indirect descriptors on=
 AQ
> because txq/rxq prefers to use it.
> > Not that AQ needs it.
> > At the same time, you don't want AQ object in spec to be limited to alw=
ays
> operate without indirect descriptor.
> >
> > > > It is better to not impact the device to handler indirect
> > > > descriptors on non
> > > AQ queues, just because AQ prefers to handle it.
> > > > Often AQ and data path queues are not handled by same set of
> > > > processing
> > > engines given they both do different tasks.
> > >
> > > so for example, many guests want to use indirect for tx but not for r=
x.
> > > if you are worrying about things like that, maybe a per-vq control
> > > over indirect support makes sense.
> > > adding complexity like that should really be much better motivated,
> > > and maybe have some PoC code or back of the napkin math showing the
> > > expected gains.
> > I do not have gains handy for tx vs rx q. It was in your example of par=
tial
> order page fault thread.
> > So may be you can share those results and/or poc code?
> >
> > The motivation for AQ is simple as I explained about, i.e. txq/rxq indi=
rect
> descriptor capability should not be imposed on AQ.
>=20
>=20
> If I were you I would defer this, the AQ patch is already too big.
o.k. we can differ.
But if you see on the other side, AQ always following INDIRECT_DESC feature=
 bit, forces device implementation to support indirect descriptors.
Isn't that make device implementation big from beginning, even though it ma=
y not be needed?

