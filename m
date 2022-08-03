Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20220731154354.15698-1-mgurtovoy@nvidia.com> <20220731154354.15698-2-mgurtovoy@nvidia.com>
 <20220802092302-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220802092302-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Aug 2022 12:44:38 +0800
Message-ID: <CACGkMEtgghEpPk=eE4z=5QiGTW42768i4729KR0-+ThHaQE3bA@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] Introduce device group
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, virtio-comment@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Parav Pandit <parav@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Ariel Adam <aadam@redhat.com>, virtio@lists.oasis-open.org, eperezma <eperezma@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Aug 2, 2022 at 9:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> I feel some of my latest review opened some questions that I don't have
> good answers for and might have felt a bit rambling.
> So to focus the discussion:
>
> On Sun, Jul 31, 2022 at 06:43:50PM +0300, Max Gurtovoy wrote:
> > +A device can be a member of one or more device groups.
>
> Presumably this is so we can e.g. create subfunctions inside a VF.

Then VF should have its own transport virtqueue. And subfunctions need
to be created there. If we don't all thing in PF, we may end up with
nesting issue when assign VF to the guest.

> A VF now is a member of a SRIOV and SIOV type groups and we
> can use type to distinguish between these.
>
> We should probably be explicit that each of these groups has to
> have a distinct group type then.
>
> And this raises the question: different types have different
> capabilities. So let's say admin queue is used to both
> control features for SRIOV VFs and to create SIOV SFs.

I don't get how the admin queue can be used to control VF features
considering VF has its capabilities. (SR-IOV lacks the ability to
provision a single VF).

> I guess we'll have a feature bit to say "command to create
> SIOV SFs is supported" but how do we say that this command
> is only supported for VFs not SFs?

I think we should first answer if having VF and SF to be dealt with a
single type of virtqueue is a good idea. They have something in common
but they distinguish each other:

- SF requires per virtual device lifecycle management
- SF requires a transport other than PCI
- SF requires more mediation in the software layer for presenting a
virtual device

Using a single type of virtqueue may end up with complex design.
Having a dedicated queue for SF might be a better choice.

>
> Do we just make features list a superset of what is supported and simply
> say in the spec which commands are legal with which group types?
>
>
> Jason Cornelia what do you think?

It looks to me it would be much more simpler if we use separated
virtqueues for SRIOV and SIOV.

Thanks

>
>
>
> > +\item Self type (group identifier = 0) - this group has only one device in the group. Each virtio device is a member of at least one device group, the Self type group.
>
> Presumably, this is here so we can send commands that refer to the
> device itself as opposed to a group member (e.g. to
> PF as opposed to VF). Is that right?
>
> It's handy but again the problem here is, this refers to
> device as part of which group? Let's just drop this type?
>
>
> --
> MST
>

