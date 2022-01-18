Return-Path: <mst@redhat.com>
Date: Tue, 18 Jan 2022 01:17:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/5] Add virtio Admin Virtqueue specification
Message-ID: <20220118011334-mutt-send-email-mst@kernel.org>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-2-mgurtovoy@nvidia.com>
 <20220113124137-mutt-send-email-mst@kernel.org>
 <4946a0fe-70f0-43cc-6730-f8ab0f3d8687@nvidia.com>
 <20220117160951-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819C1FD23F3C5E3FCE9057DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54819C1FD23F3C5E3FCE9057DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 18, 2022 at 03:22:27AM +0000, Parav Pandit wrote:
> > I don't recall discussion about UUID so I can't really say what I think about that.
> > Do we need a UUID? I'm not sure I understand why.
> > It can't hurt to abstract things a bit so it's not all tied to PFs/VFs since we know
> > we'll want subfunctions down the road, too, if that is what you mean.
> >
> I still didn't find any reason in the discussion to find out why grouping device is needed.

VFs are already grouped with their PF. However we should spell this out
as the motivation for the admin queue.

> Current AQ proposal implicitly indicates that VFs of a PF are managed by its parent PF.
> And for some reason this work by one of the VF, this role assignment
> can be certainly a new command on AQ as group command or some other
> command.

> > 
> > 
> > > >
> > > > Following this idea, all commands would then gain fields for
> > > > addressing one device from another.
> > > >
> > > > Not everything maps well to a queue. E.g. it would be great to have
> > > > list of available commands in memory.
> > >
> > > I'm not sure I agree. Why can't it map to a queue ?
> > 
> > You can map it to a queue, yes. But something static and read only such as list
> > of commands maps well to config space. And it's not controlling one device
> > from another, so does not really seem to belong in the admin queue.
> > 
> Aq serves the writing device config too in patch-5 in this patchset.

List of available admin commands does not need to be written.

> > >
> > > > Figuring out max vectors also looks like a good example for memory
> > > > and not through a command.
> > >
> > > Any explanation why is it looks good ? or better ?
> > 
> > why is memory easier to operate than a VQ?
> > It's much simpler and so less error prone.  you can have multiple actors read
> > such a field at the same time without races, so e.g.  there could be a sysfs
> > attribute that reads from device on each access, and not special error handling
> > is needed.
> >
> Writing fields is inherent part of the aq without getting blocked on previous writes.
> I see you acked that AQ is fine in cover letter patch as below, so we are sync on the motivation now.
> Yes, will update the commit log as you suggested.
> 
>  " if the answer is "commands A,B,C do not fit in config space, we placed commands D,E in a VQ for consistency"
> then that is an ok answer, but it's something to be mentioned in the commit log"

