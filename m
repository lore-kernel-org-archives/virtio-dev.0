Return-Path: <mst@redhat.com>
Date: Wed, 6 Jul 2022 07:00:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] RE: [PATCH v5 0/7] Introduce device group and
 device management
Message-ID: <20220706061051-mutt-send-email-mst@kernel.org>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220705095514-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D9416A601E6F2D4A32FFDC819@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481D9416A601E6F2D4A32FFDC819@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jul 05, 2022 at 03:11:43PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, July 5, 2022 9:57 AM
> > 
> > On Wed, Apr 27, 2022 at 01:58:17AM +0300, Max Gurtovoy wrote:
> > > Hi,
> > > A device group definition will help extending the virtio specefication
> > > for various future features that require a notion of grouping devices
> > > together or managing devices inside a group. A device group include one or
> > more virtio devices.
> > > For now, only support for type 1 device group was added.
> > 
> > How about posting a new version? I frankly think between the hardware
> > hack I proposed and the new admin queue transport proposal, we do not
> > need to work hard to save on writeable registers and so for starters at least
> > we can just use feature bits instead of the query capability command.
> 
> Reader and writer via different channel is really a hack.
> It still doesn't help to have efficient hw.
> 
> What is the technical reason to use feature bits which has strong relationships with device initialization sequence?

The reason is it's a reasonably well understood mechanism, already
addressing questions like lifecycle, dependencies, extensibility.  For
example, one might reasonably ask what happens if driver uses commands
to change number of MSI-X vectors, then disables the capability bit
related to relevant commands? Should device forget the allocated
vectors? There's no longer a way to change the allocation...
If the set of allowed commands are locked in place until reset then
it's clearer.

Again I am sure the specific question can be answered. But I would
really just like to see the admin queue proposal get finalized as
quickly as possible, this means making compromizes to reuse as much of
existing functionality as possible. And we can add extensions down the
road.

> The proposed bits are AQ functionality bits and not per_say device feature bits?

Could not parse this sentence.

> This enables to build device in lot more flexible (and frankly simple way).
> Looking at sw guest driver being simple to use existing limited 64-bits is just one part of it.

I'm not sure what does this refers to. What was suggested using
e.g. feature bits 64 to 127, not stealing some of the 64 ones in use.
All existing transports support doing that without adding
any new transport specific interfaces.

Yes adding commands to tweak features might be benefitial.  I just
suggest splitting that out simply because this might or might not make
sense for all features.  For example, a related common request is
modifying feature bits and generally some config space on the device
side to facilitate migration across devices with varying features.
Should that be included in the proposal then?

> And when AQ exists, most of the plumbing comes for free.
> So I fail to see the simplicity benefit of overloading feature bits for things that has no relation to device init sequence.

Well most of feature bits are not *directly* tied to device init sequence.
In this case, one can argue that's at least related. For example,
one can imagine that whether number of MSI vectors is
controllable is relevant to the initialization of the PF driver.

The similicity just comes from reusing an existing mechanism so people
do not need to learn a new one.

Again I don't know what to do with this. I feel if it's put up for vote
in the current form it's likely to fail. I propose cutting out as much
as possible as a first step, so we can make progress. Specifically the
MSI-X commands are clearly PF specific so there's no concern about VF
memory use at all.  We can worry about other types of command down the
road when it becomes relevant.

-- 
MST

