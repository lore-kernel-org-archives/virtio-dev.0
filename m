Return-Path: virtio-dev-return-5151-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 99650984027
	for <virtio-dev@lists.oasis-open.org>; Sun,  9 Dec 2018 14:33:49 +0000 (UTC)
Date: Sun, 9 Dec 2018 09:33:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181209093222-mutt-send-email-mst@kernel.org>
References: <20181207084842.13133-1-tiwei.bie@intel.com>
 <20181207084842.13133-4-tiwei.bie@intel.com>
 <20181207130822-mutt-send-email-mst@kernel.org>
 <20181208134728.GC29772@dpdk-tbie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208134728.GC29772@dpdk-tbie>
Subject: [virtio-dev] Re: [RFC 3/3] virtio_ring: use new vring flags
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org, wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Dec 08, 2018 at 09:47:29PM +0800, Tiwei Bie wrote:
> On Fri, Dec 07, 2018 at 01:10:48PM -0500, Michael S. Tsirkin wrote:
> > On Fri, Dec 07, 2018 at 04:48:42PM +0800, Tiwei Bie wrote:
> > > Switch to using the _SPLIT_ and _PACKED_ variants of vring flags
> > > in split ring and packed ring respectively.
> > > 
> > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > ---
> > > @@ -502,7 +505,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > >  		}
> > >  	}
> > >  	/* Last one doesn't continue. */
> > > -	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> > > +	desc[prev].flags &= cpu_to_virtio16(_vq->vdev,
> > > +				(u16)~BIT(VRING_SPLIT_DESC_F_NEXT));
> > >  
> > >  	if (indirect) {
> > >  		/* Now that the indirect table is filled in, map it. */
> > 
> > I kind of dislike it that this forces use of a cast here.
> > Kind of makes it more fragile. Let's use a temporary instead?
> 
> I tried something like this:
> 
> u16 mask = ~BIT(VRING_SPLIT_DESC_F_NEXT);
> 
> And it will still cause the warning:
> 
> warning: large integer implicitly truncated to unsigned type [-Woverflow]
>   u16 mask = ~BIT(VRING_SPLIT_DESC_F_NEXT);
> 
> If the cast isn't wanted, maybe use ~(1 << VRING_SPLIT_DESC_F_NEXT)
> directly?

What I'd like to see is a macro that warns/errors out if the shift is
too large. I'll think it over on the weekend.


> 
> > 
> > > -- 
> > > 2.17.1

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

