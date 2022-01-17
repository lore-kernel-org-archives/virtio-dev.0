Return-Path: <mst@redhat.com>
Date: Mon, 17 Jan 2022 17:03:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/5] Add virtio Admin Virtqueue specification
Message-ID: <20220117165941-mutt-send-email-mst@kernel.org>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-2-mgurtovoy@nvidia.com>
 <20220113124137-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BAD47AA812DF42811466DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481BAD47AA812DF42811466DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 17, 2022 at 02:12:33PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, January 13, 2022 11:24 PM
> 
> > 
> > We had an off-list meeting where I proposed addressing one device from
> > another or grouping multiple devices as a more specific scope. That would be
> > one way to address this.
> > 
> > Following this idea, all commands would then gain fields for addressing one
> > device from another.
> > 
> Can you please explain your idea more and a need for grouping?
> What do you want to group? VFs of parent pci device?
> How to refer to each VF within a group?

So for example, VFs of a PF are a group right? And they are all
controlled by a PF.

I can think of setups like nesting where we might want to
create a group of VFs and pass them to L1, one of the
VFs to act as an admin for the reset of them for purposes
of L2.  subfunctions with PASID etc are another
example. I am not asking you to add such mechanisms straight away
but the current proposal kind of obscures this to the point
where I don't see how would we extend it with these things
down the road.


> If you have notes of the off-list meeting, it will be useful for us to read through.

Sorry didn't take notes.

-- 
MST

