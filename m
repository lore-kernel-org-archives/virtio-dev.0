Return-Path: <mst@redhat.com>
Date: Wed, 27 Apr 2022 11:29:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] [PATCH v2] virtio: Improve queue_reset polarity to
 match to default reset state
Message-ID: <20220427111713-mutt-send-email-mst@kernel.org>
References: <20220427102559.305669-1-parav@nvidia.com>
 <CACGkMEsDEJS0awDfFzR7a1aOr3+TQ6iDse5R=LRAYGxgNs4bpQ@mail.gmail.com>
 <PH0PR12MB5481FA61532231E61C96F692DCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481FA61532231E61C96F692DCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Apr 27, 2022 at 02:51:36PM +0000, Parav Pandit wrote:
> 
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, April 27, 2022 7:30 AM
> > 
> > On Wed, Apr 27, 2022 at 6:26 PM Parav Pandit <parav@nvidia.com> wrote:
> > >
> > > example flow:
> > > a) 0,0 -> device init time value
> > > b) 1,0 -> vq is enabled by driver and working
> > 
> > Did you see my reply in V1? What's the reason for using write to clear
> > behavior that is different from the device status?
> > 
> > We can simply make this as 1, 1 here and let the driver write to 0 to reset the
> > virtqueue.
> > 
> > And if we do this, the queue_enable and queue_reset are always the same,
> > then we can simply reuse queue_enable.
> > 
> Yes, I know we can make this work using new feature bit + single queue_enable register.
> I replied that in v0 to Michael.

A bigger question in my eyes is that down the road we might want to
be able to stop the ring without having it lose state.
The natural interface for that seems to be writing 0 to queue enable.

> I was not sure how drastic that would be at this point in the spec release cycle that Michael highlighted.
> Hence, I proposed a minimal change fix to queue_reset register given timeline.

Well if accepted this proposal is going to delay the release anyway.  If
we are doing a new feature then that can love alongside the one that is
already in the spec.



-- 
MST

