Return-Path: <mst@redhat.com>
Date: Tue, 8 Feb 2022 10:26:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 1/4] Add virtio Admin virtqueue
Message-ID: <20220208102341-mutt-send-email-mst@kernel.org>
References: <20220203075716.11684-1-mgurtovoy@nvidia.com>
 <20220203075716.11684-2-mgurtovoy@nvidia.com>
 <20220207052843-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548164CFE929F59EEDBD3557DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208014039-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548104AB80FA36544DB3D7D0DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <878rulv6kq.fsf@redhat.com>
 <PH0PR12MB54816EBF061770CC91E0435DDC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208084022-mutt-send-email-mst@kernel.org>
 <875yppv1z2.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <875yppv1z2.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 08, 2022 at 03:59:13PM +0100, Cornelia Huck wrote:
> On Tue, Feb 08 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, Feb 08, 2022 at 01:32:12PM +0000, Parav Pandit wrote:
> >> 
> >> > From: Cornelia Huck <cohuck@redhat.com>
> >> > Sent: Tuesday, February 8, 2022 6:50 PM
> >> > 
> >> > On Tue, Feb 08 2022, Parav Pandit <parav@nvidia.com> wrote:
> >> > 
> >> > >> From: Michael S. Tsirkin <mst@redhat.com>
> >> > >> Sent: Tuesday, February 8, 2022 12:13 PM
> >> > >
> >> > >> On Tue, Feb 08, 2022 at 06:25:41AM +0000, Parav Pandit wrote:
> >> > >> >
> >> > >> > > From: Michael S. Tsirkin <mst@redhat.com>
> >> > >> > > Sent: Monday, February 7, 2022 4:09 PM
> >> > >> > >
> >> > >> > > Next, trying to think about scalable iov extensions. So we will
> >> > >> > > have groups of VFs and then SFs as the next level.
> >> > >> > > How does one differentiate between the two?
> >> > >> > > Maybe reserve a field for "destination type"?
> >> > >> > >
> >> > >> > We already discussed this in v2.
> >> > >> > SF will have different identification than 16-bits. And no one
> >> > >> > knows what
> >> > >> that would be.
> >> > >> > We just cannot reserve some arbitrary bytes for unknown.
> >> > >> > You suggested in v2 to reserve 4 bytes for sf_id, and I explained
> >> > >> > you that 4
> >> > >> bytes may not be enough.
> >> > >> >
> >> > >> > Whether SFs are on top of VFs or SFs are on top of PFs or both is
> >> > >> > completely
> >> > >> different spec.
> >> > >> > Whether PF will manage SFs of the VFs or it will be done nested
> >> > >> > manner by
> >> > >> VF etc is a completely different discussion than what is being proposed here.
> >> > >> > Whether PF will manage the SF is yet another big question. We work
> >> > >> > with
> >> > >> users and they dislike this.
> >> > >> > To address it, some OS has a different management interface (not
> >> > >> > visible to
> >> > >> PF) for SF life cycle even though SFs are anchored on a PF.
> >> > >> >
> >> > >> > So SF/iov extension discussion has long way to go for community to
> >> > >> > first
> >> > >> understand the use cases before crafting some extension.
> >> > >> >
> >> > >> > So lets not complicate and mix things here for a blurry definition
> >> > >> > of scalable
> >> > >> iov/sf extension.
> >> > >>
> >> > >> Some reserved bytes won't hurt. 2 bytes for type gives us 64k types,
> >> > >> sounds like that should be enough.
> >> > > It doesn't stop there.
> >> > > Mentioning some destination type, interrupt type, etc also requires reserving
> >> > bytes for different device id type, interrupt type and more.
> >> > > We past this stage long ago after discussing this in v1 at [1].
> >> > > It is just better and cleaner to define a different structure to describe SF/iov
> >> > and its configuration.
> >> > 
> >> > I have the feeling that we might be overcomplicating this. We have some
> >> > groups of targets (a device, a group, that more complicated SF thingy), and we
> >> > want to distinguish between them. That's easy enough to cover via some kind of
> >> > enum-equivalent (0 == same dev, 1 == target a dev id, 2 == target a group id, 3
> >> > == multi-layer target) and some spec how 1 and 2 should look like (as I'd expect
> >> > them to be common for many different things). 
> >> Do we have a concrete example of a command that can be targeted for same device and a target device, which requires differentiating their destination? If so, lets discuss and then it make sense to add for the well-defined use case.
> >
> > So e.g. things like controlling NIC's MAC can reasonably be part of
> > the same device.
> 
> Yes, that would be an example.
> 
> I might have been a bit too vague about what I had been thinking
> about. Let's do a sketch (intentionally without concrete sizes):
> 
> +-------------------------------------------------------+
> | command                                               |
> +-------------------------------------------------------+
> | target type (0 - self, 1 - dev id, 2 - group id, ...  |
> +-------------------------------------------------------+
> | dev id                                                |
> +-------------------------------------------------------+
> | group id                                              |
> +-------------------------------------------------------+
> | command-specific data                                 |
> +-------------------------------------------------------+
> | response part                                         |
> +-------------------------------------------------------+
> 
> 'dev id' would be valid for 'target type' == 1, 'group id' would be
> valid for 'target type' == 2. Alternatively, 'dev id' and 'group id'
> could be a single 'target id' field; if there's nothing better to use,
> it can simply contain a uuid.

I am not sure why do we have both dev id and group id.
They are never used together right?
Maybe just have an id length field if we can't agree on
how much space to reserve.

> >
> >> > The SF thingy can be covered
> >> > by 3, and we'll probably want to make that one command-specific, as the whole
> >> > setup does not have enough things we can standardize on.
> >> This comment has underlying assumption that there are nested layers. And that assumption may not be true at all.
> >> At least for iov extension of intel and SF of Mellanox (already open source for 1+ year) doesn't have the nested layers as today as far as I understand.
> >> > 
> >> > Does that make sense? This standardizes the simpler setups, and gives enough
> >> > flexibility for the more complicated ones. If we have another simpler setup in
> >> > the future, it can become type 4, 5, etc.
> >> I feel that without a use case we are over complicating the commands by introducing group/target id etc.
> >> 
> >> So better to first come up with a valid use case and a device that supports it, which needs a group.
> >> Otherwise a target id can be a long string of PCI device = 0000:03:00.0 or a BDF or a VF number or a VF of a different PCI PF or a SF number 32-bit or SF UUID or a VF on a remote DPU system or PCI device on transparent bridge or something else.
> >
> > Well PASID is IIRC just 20 bit on express. I find it unlikely that we'll
> > need more than 64 bit. Yes, it's hard to predict the future but just
> > doing 16 bit here seems frankly like a premature optimization. UUID for
> > a transient thing such as SF just seems unnecessary. 32 or 64 bit seem
> > both acceptable.
> 
> However, if we want to be able to accommodate targets we have no idea
> about yet (and that may have nothing to do with PCI at all), we should
> maybe standardize on something that can fit a uuid -- if all else fails,
> you can identify anything with a uuid.
> 
> 64 bits might be enough in practice, 32 bit seems a bit short.

Ok, 64 sounds reasonable, not too much.


> >
> >> Without knowing the grouping and a nonexistence device we shouldn't complicate the commands.
> >> 
> >> There are enough opcodes (64K) that can define new structure for more complex devices.
> >
> > I think you are asking for a bit much frankly, it's up to you to build
> > the interface. Just like with code, if the design does not feel robust
> > the bar is much higher even if one can not prove there's a locking
> > problem.  Same here, this interface design does not yet feel very robust
> > yet - so either we build it in a way that seems robust based
> > basically on our gut feeling, or actually spend time predicting and
> > addressing future use-cases to prove they can be addressed.
> > I dare say we've developed some intuition about what makes
> > an extensible interface and where things are likely to go here at the
> > TC, so I wouldn't discard all feedback as unnecessary complication even
> > if it does not always come with concrete use-case examples.
> 
> Indeed. I'm not saying that my ideas are the right way to go, but we
> definitely need something that (a) covers the use cases we already know
> about, and (b) can accommodate future use cases with some
> confidence. Now there's always the chance that we have a requirement
> down the road that's so odd that our attempts to make this extensible
> are not enough, but we really need to be able to cover at least things
> we can imagine. Especially as the use cases in (a) are very specific
> (essentially PCI-specific), we need to at least answer the question "how
> could this work for things that are not PCI?"
> 
> (And shoving everything into command-specific data seems too
> underspecified to me.)

