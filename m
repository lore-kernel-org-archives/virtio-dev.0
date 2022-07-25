Return-Path: <mst@redhat.com>
Date: Mon, 25 Jul 2022 03:44:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] RE: [PATCH v5 0/7] Introduce device group and
 device management
Message-ID: <20220725030303-mutt-send-email-mst@kernel.org>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220705095514-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D9416A601E6F2D4A32FFDC819@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220706061051-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817E0D45D613834A3C42A4DC809@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220724170744-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481269E252B7DD8EFE2109DDC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220724191530-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548127CD9F333F8F92580531DC959@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548127CD9F333F8F92580531DC959@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jul 25, 2022 at 02:53:39AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, July 24, 2022 7:42 PM
> > To: Parav Pandit <parav@nvidia.com>
> > Cc: Max Gurtovoy <mgurtovoy@nvidia.com>; jasowang@redhat.com; virtio-
> > comment@lists.oasis-open.org; cohuck@redhat.com; virtio-dev@lists.oasis-
> > open.org; Oren Duer <oren@nvidia.com>; Shahaf Shuler
> > <shahafs@nvidia.com>; aadam@redhat.com; virtio@lists.oasis-open.org
> > Subject: Re: [virtio-dev] RE: [PATCH v5 0/7] Introduce device group and
> > device management
> > 
> > On Sun, Jul 24, 2022 at 09:25:17PM +0000, Parav Pandit wrote:
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Sunday, July 24, 2022 5:10 PM
> > > >
> > > > I snippet rest of mail - wasn't sure whether you were waiting for an
> > answer.
> > > >
> > > > On Wed, Jul 06, 2022 at 08:45:26PM +0000, Parav Pandit wrote:
> > > > > > Again I don't know what to do with this. I feel if it's put up
> > > > > > for vote in the current form it's likely to fail. I propose
> > > > > > cutting out as much as possible as a first step, so we can make
> > progress.
> > > > > > Specifically the MSI-X commands are clearly PF specific so
> > > > > > there's no concern about VF memory use at all.  We can worry
> > > > > > about other types
> > > > of command down the road when it becomes relevant.
> > > > >
> > > > > Since feature bits proposes are limited to PF, I agree that
> > > > > current short cut
> > > > is fine to place in 64-127 feature bits.
> > > > >
> > > > > When/if similar functionality is needed at scale for the VF or
> > > > > SIOV devices,
> > > > placing them in 64-127 bits area weight way less for sake of "people
> > > > familiarity to feature bits".
> > > > > Do you agree?
> > > >
> > > > I think we can all agree that extensions for scalable IOV will need
> > > > more work if that is what you are saying.
> > > Yes.
> > > Even VFs to negotiate few tens of Kbytes seems waste of resources for one
> > time read/write bits.
> > 
> > It has small a cost for sure, but it's negligeable compared to the current cost
> > of implementing the spec.
> >
> How did you calculate the cost being negligible?

For sure each VF needs at least 2 VQs plus the AQ. Each one
is 3 64 bit pointers, plus some flags and counters, plus at
least one MSI vector about 200-300 bit.
We are talking each feature taking up a single bit per VF right now.
That's below 1%.


> > > So better to start using AQ for new functionalities.
> > > What is stopping us to adapt to this modern and optimized way?
> > 
> > The cost/benefit tradeoff. The benefit is a theorectical gain of a few bits per
> > VF. The cost is very real engineering time spent.
> >
> How is it theoretical? I provided the calculation few times in previous emails.

It's theoretical because we don't know whether anyone will ever add
AQ to VFs as opposed to a PF.

> > I can keep poking holes and finding underspecified behaviour in the
> > proposal. 
> We should fix the wording.
> > But I don't really see why would anyone spend the time
> > duplicating what virtio spec is already doing decently.
> > 
> > > Why cant we keep features bits limited to device startup negotiation
> > scheme?
> > 
> > Well they are already used for much more. So sure, maybe work on changing
> > that, but IMO trying it all in a single huge project is just not a great idea.
> >
> Why would you recommend on changing something historic like this?

Because that will bring a much bigger gain.

> The ask here to improve the new features.

Let's just improve everything, a much bigger gain.  Simply put, pci
transport was never designed with saving per device memory in mind.
Adding complexity to save a couple of bytes per device will just create
bugs without solving that. AQ is already trying to solve grouping
devices and that's a big project, let's finish that and then decide
whether we want to work on migration or work on saving memory next.

> > > Other unrelated bits are added in past to feature bits  But lets follow the
> > good examples instead when the new choice is already proposed and
> > defined.
> > 
> > So IMHO saving a few bits here and there when we are spending tens of
> > bytes on state makes no sense.
> >
> Not a good reason to introduce something inferior.

Avoiding duplication and focusing on low hanging fruit are all
sound engineering principles.


> > Something like transport over AQ (or the transport vq proposal) or some
> > other concerted effort to save per device memory would be needed for
> > SIOV, and maybe it's useful for SRIOV too.
> >
> AQ proposal is already doing it.
> Some of the things seems to be lately duplicated in transport vq proposal.
> We should possibly rename both the queues to mgmt_queue that serves both the purposes.

Quite possibly - transport VQ seems to handle a group of devices from one
device which seems similar to what AQ does, and you guys should
probably work together.

But whether we do or do not unify transport and admin vq,
with transport vq existing feature mechanism stops taking up
space in the VQ and this opens up possibility to just use that mechanism
to discover supported commands without paying memory penalty.


> Transport VQ proposal is tunneling some SIOV device feature bits.
> Here AQ is negotiating its own feature bits. Both are orthogonal.

I thought the discussion was about dropping the get features command and
using features instead. The Transport VQ proposal seems to show how we
can do that and still make things scale.  Yes it's orthogonal to using
AQ for grouping, and using features is exactly what will keep it
orthogonal.

> And suggesting to some newer RFC to discuss current one doesn't make much sense to tangent the discussion at all.


The reason I bring it up is that it seems like a better solution to saving device
memory than adding a get capabilities command. And it let you just use
features for now, and assume whatever we spend will be saved back
by using vq as transport.


> Since there is zero technical short comings of negotiating AQ features via AQ command, lets please conclude to proceed with it.

Not 100% sure what you are saing here, so I think you should post a new
version, yes. Generally iterating faster is a good idea. If you feel
you didn't get enough feedback on a given version and some time passed
try pinging people.

-- 
MST

