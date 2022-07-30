Return-Path: <virtio-comment-return-3251-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sat, 30 Jul 2022 13:21:20 +0000
Message-ID: <PH0PR12MB54812685041A59D642227920DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220705095514-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D9416A601E6F2D4A32FFDC819@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220706061051-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817E0D45D613834A3C42A4DC809@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220724170744-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481269E252B7DD8EFE2109DDC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220724191530-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548127CD9F333F8F92580531DC959@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220725030303-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220725030303-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [virtio-dev] RE: [PATCH v5 0/7] Introduce device group and device
 management
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, July 25, 2022 3:44 AM
> > >
> > How did you calculate the cost being negligible?
>=20
> For sure each VF needs at least 2 VQs plus the AQ. Each one is 3 64 bit
> pointers, plus some flags and counters, plus at least one MSI vector abou=
t
> 200-300 bit.
> We are talking each feature taking up a single bit per VF right now.
> That's below 1%.
>
Because you assumed that new feature bits in this area will never be added.
The AQ and its capabilities are not limited to PF even though first version=
 of the spec has only few bits.

And these 1% at scale results in several Kbytes.
=20
>=20
> > > > So better to start using AQ for new functionalities.
> > > > What is stopping us to adapt to this modern and optimized way?
> > >
> > > The cost/benefit tradeoff. The benefit is a theorectical gain of a
> > > few bits per VF. The cost is very real engineering time spent.
> > >
> > How is it theoretical? I provided the calculation few times in previous
> emails.
>=20
> It's theoretical because we don't know whether anyone will ever add AQ to
> VFs as opposed to a PF.
>
Isnt the scope of AQ now more than just msix+features+livemigration?
Such as managing siov and more?

Things like queue_reset, query counters and other things can be done more e=
fficiently through a vq than some burned bits regardless of SIOV.
So in my view looking at AQ for msix, LM purpose is narrow view to stay on =
the PF.
=20
> > > I can keep poking holes and finding underspecified behaviour in the
> > > proposal.
> > We should fix the wording.
> > > But I don't really see why would anyone spend the time duplicating
> > > what virtio spec is already doing decently.
> > >
> > > > Why cant we keep features bits limited to device startup
> > > > negotiation
> > > scheme?
> > >
> > > Well they are already used for much more. So sure, maybe work on
> > > changing that, but IMO trying it all in a single huge project is just=
 not a
> great idea.
> > >
> > Why would you recommend on changing something historic like this?
>=20
> Because that will bring a much bigger gain.
>
That also breaks existing backward compatibility for existing devices.
So it has to be something additional and optional.

=20
> > The ask here to improve the new features.
>=20
> Let's just improve everything, a much bigger gain.  Simply put, pci trans=
port
> was never designed with saving per device memory in mind.
Hence, new addition shouldn't make it worse when the new optimized methods =
are available.

> Adding complexity to save a couple of bytes per device will just create b=
ugs
> without solving that.=20
I disagree that it creates bugs.
When done right, we have seen in multiple projects (nvme, mlx5 and more) th=
at it doesn't create bugs.

> AQ is already trying to solve grouping devices and that's
> a big project, let's finish that and then decide whether we want to work =
on
> migration or work on saving memory next.
>=20
I assume migration means live migration and not migration from pci to somet=
hing else.
If its former, it is not either-or project.
Saving memory is attributed as project and it doesn't have to be for the sm=
all piece being added here.

> > > > Other unrelated bits are added in past to feature bits  But lets
> > > > follow the
> > > good examples instead when the new choice is already proposed and
> > > defined.
> > >
> > > So IMHO saving a few bits here and there when we are spending tens
> > > of bytes on state makes no sense.
> > >
You missed the multiply factor of VFs. :)

It is not only saving bits, it also enforces certain aspects of how a devic=
e is being composed that must expose these bits pretty early.

> > Not a good reason to introduce something inferior.
>=20
> Avoiding duplication and focusing on low hanging fruit are all sound
> engineering principles.
>=20
It is not a duplication.
I iterate again. The bits we asked to put in the Aq commands are the one th=
at does not need to be negotiated early.
Feature bits were mis-used to put all things in there because in past a gen=
eric AQ didn't exists.
And there is no reason for that past decision to influence current proposal=
.

Feature bits that are so basic for device bring up stage, stays in feature =
bits area defined today.
Hence, its not a duplication.

>=20
> > > Something like transport over AQ (or the transport vq proposal) or
> > > some other concerted effort to save per device memory would be
> > > needed for SIOV, and maybe it's useful for SRIOV too.
> > >
> > AQ proposal is already doing it.
> > Some of the things seems to be lately duplicated in transport vq propos=
al.
> > We should possibly rename both the queues to mgmt_queue that serves
> both the purposes.
>=20
> Quite possibly - transport VQ seems to handle a group of devices from one
> device which seems similar to what AQ does, and you guys should probably
> work together.
>
Yes.
=20
> But whether we do or do not unify transport and admin vq, with transport
Without unification, I don't see how SIOV proposal can ever make to the spe=
c.
Once AQ is merged SIOV can use AQ.
I would like to see SIOV to refer to the AQ proposal commands and extend it=
. Not as separate proposal.

> vq existing feature mechanism stops taking up space in the VQ and this
> opens up possibility to just use that mechanism to discover supported
> commands without paying memory penalty.
>=20
This only helps any new SIOV beast which is not even fully defined at vario=
us layers of platform.

>=20
> > Transport VQ proposal is tunneling some SIOV device feature bits.
> > Here AQ is negotiating its own feature bits. Both are orthogonal.
>=20
> I thought the discussion was about dropping the get features command and
> using features instead.=20

> The Transport VQ proposal seems to show how we
> can do that and still make things scale.  Yes it's orthogonal to using AQ=
 for
> grouping, and using features is exactly what will keep it orthogonal.
>=20
> > And suggesting to some newer RFC to discuss current one doesn't make
> much sense to tangent the discussion at all.
>=20
>=20
> The reason I bring it up is that it seems like a better solution to savin=
g device
> memory than adding a get capabilities command. And it let you just use
> features for now, and assume whatever we spend will be saved back by
> using vq as transport.
>=20
Even for non SIOV devices?

>=20
> > Since there is zero technical short comings of negotiating AQ features =
via
> AQ command, lets please conclude to proceed with it.
>=20
> Not 100% sure what you are saing here, so I think you should post a new
> version, yes. Generally iterating faster is a good idea. If you feel you =
didn't
> get enough feedback on a given version and some time passed try pinging
> people.
Without closing the discussion, I have seen same topic come up again and ag=
ain in future version.
So even though new series is up for posting, we better close the discussion=
.


This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

