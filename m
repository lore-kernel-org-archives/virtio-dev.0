Return-Path: <mst@redhat.com>
Date: Wed, 27 Apr 2022 15:32:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] [PATCH v2] virtio: Improve queue_reset polarity to
 match to default reset state
Message-ID: <20220427153119-mutt-send-email-mst@kernel.org>
References: <20220427102559.305669-1-parav@nvidia.com>
 <CACGkMEsDEJS0awDfFzR7a1aOr3+TQ6iDse5R=LRAYGxgNs4bpQ@mail.gmail.com>
 <PH0PR12MB5481FA61532231E61C96F692DCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220427111713-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CBB7E506E3DCEB11A7BFDCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220427114055-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AC52975356341A964314DCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB548121654DFF8442593FF26DDCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548121654DFF8442593FF26DDCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Apr 27, 2022 at 04:15:05PM +0000, Parav Pandit wrote:
> 
> > From: Parav Pandit
> > Sent: Wednesday, April 27, 2022 11:58 AM
> > 
> > But this is so basic.
> > It's hard to gaze at this spec for coming years and the code to see, Hey
> > sometimes 0 means disabled, sometime 0 means still enabled, sometime 1
> > means enabled, and sometimes 1 means now disabled...
> > And maintain those weird code in device side and extra state bits burning
> > some expensive chip resource.
> > 
> > Is removing from 1.2 is equal delay to get is fixed in 1.3?
> > If yes, I make humble request to fix this and have errata.
> > Some of the professional standard bodies release the spec and short after
> > that errata/ratification follows the release that resolve such small issues.
> > May be time for virtio spec to take this opportunity now and be bit agile on it.
> > Your call. :)
> 
> 
> I think further, it appears a real bug that requires so special handling in the device for next years to carry.
> 
> Imagine this sequence.
> 1. A virtio device is handed over to guest VM
> 2. A virtio device started queue_reset sequence,
> So register values are:
> queue_enable = 1, q_reset=1
> 2. guest VM poled the q_reset register.
> Queue_enable = 1, q_reset = 0 (because device is doing the resetting the queue)
> 3. HV suspend the VM and queried the VQ state
> VQ state returned 
> q_enable=1, q_reset = 0.
> 
> HV doesn't know what q_reset=0 mean here, is it 0 because it was never reset?
> Or it is 0 because GVM Started the reset, but reset didn't finish?
> 
> When this virtio device is restored on the other side, HV and device doesn't know how to deal with this.
> 
> A WA that all devices will implement is, not returning 0, in step_2, but return say q_reset = 0xa to indicate that its other than 1 and other than 0.
> But hey, the destination side needs to treat this special 0xa and convert to internal q_yet_busy stage.
> 
> And this answer Jason and myself why queue_enable shouldn't be overloaded for this busy_wait register.
> Hence queue_reset register seems the right choice with the fix.
> 
> Starting to think of workaround even before the spec release is not elegant.
> Lets please fix this, bug effect is expanding beyond the primary virtio device itself.

Thanks Parav. Updating the github issue with more motivation would be a
good idea.

-- 
MST

