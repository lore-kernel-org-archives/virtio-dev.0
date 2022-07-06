Return-Path: <mst@redhat.com>
Date: Wed, 6 Jul 2022 06:10:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] RE: [PATCH v5 0/7] Introduce device group and
 device management
Message-ID: <20220706060642-mutt-send-email-mst@kernel.org>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220705095514-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D9416A601E6F2D4A32FFDC819@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtxLP+6Y2NhekjKLe0T28JVcdE0g+_d1-wO_T9cLGCZQw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtxLP+6Y2NhekjKLe0T28JVcdE0g+_d1-wO_T9cLGCZQw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Weird, I see Jason's reply in the archives:

https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg08603.html

but not the original message by Parav.


Prav, I will send an email to OASIS tech support, it's important
that communication is archived.




On Wed, Jul 06, 2022 at 10:54:08AM +0800, Jason Wang wrote:
> On Tue, Jul 5, 2022 at 11:11 PM Parav Pandit <parav@nvidia.com> wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, July 5, 2022 9:57 AM
> > >
> > > On Wed, Apr 27, 2022 at 01:58:17AM +0300, Max Gurtovoy wrote:
> > > > Hi,
> > > > A device group definition will help extending the virtio specefication
> > > > for various future features that require a notion of grouping devices
> > > > together or managing devices inside a group. A device group include one or
> > > more virtio devices.
> > > > For now, only support for type 1 device group was added.
> > >
> > > How about posting a new version? I frankly think between the hardware
> > > hack I proposed and the new admin queue transport proposal, we do not
> > > need to work hard to save on writeable registers and so for starters at least
> > > we can just use feature bits instead of the query capability command.
> >
> > Reader and writer via different channel is really a hack.
> > It still doesn't help to have efficient hw.
> 
> So having 2 or 4 32bit registers just for PF doesn't seem expensive to
> me. Another 64/128 bit should be sufficient for the future 5 or 10
> years.
> 
> >
> > What is the technical reason to use feature bits which has strong relationships with device initialization sequence?
> 
> Using admin virtqueue may suffer from bootstrapping issues. Especially
> the features that may affect the vring itself.
> 
> E.g we may want to have
> 
> 1) new vring layouts (similar to packed virtqueue)
> 2) new way to coalesce/suppress notification (similar to event index)
> 3) new way to notify the device (similar to notification data)
> 
> Those features can't be negotiated by admin virtqueue.
> 
> Thanks
> 
> > The proposed bits are AQ functionality bits and not per_say device feature bits?
> >
> > This enables to build device in lot more flexible (and frankly simple way).
> > Looking at sw guest driver being simple to use existing limited 64-bits is just one part of it.
> >
> > And when AQ exists, most of the plumbing comes for free.
> > So I fail to see the simplicity benefit of overloading feature bits for things that has no relation to device init sequence.
> >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >

