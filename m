Return-Path: virtio-dev-return-2366-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6789E5818FA6
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Jul 2017 09:27:21 -0700 (PDT)
Date: Mon, 10 Jul 2017 12:27:17 -0400 (EDT)
From: Amnon Ilan <ailan@redhat.com>
Message-ID: <639481407.26244916.1499704037446.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170307223057-mutt-send-email-mst@kernel.org>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com> <240c623b-2d8f-28d9-d349-d01e2c24b93a@redhat.com> <20170208214435-mutt-send-email-mst@kernel.org> <cc075b18-0913-ef89-96a8-a29869abd73e@redhat.com> <20170209171105.075a9d9c.cornelia.huck@de.ibm.com> <20170222181333-mutt-send-email-mst@kernel.org> <20170307165353.00ff80d9.cornelia.huck@de.ibm.com> <20170307223057-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] packed ring layout proposal v2
To: "Michael S. Tsirkin" <mst@redhat.com>, Lior Narkis <liorn@mellanox.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


+Lior

----- Original Message -----
> From: "Michael S. Tsirkin" <mst@redhat.com>
> To: "Cornelia Huck" <cornelia.huck@de.ibm.com>
> Cc: "Paolo Bonzini" <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
> Sent: Tuesday, March 7, 2017 10:33:57 PM
> Subject: Re: [virtio-dev] packed ring layout proposal v2
> 
> On Tue, Mar 07, 2017 at 04:53:53PM +0100, Cornelia Huck wrote:
> > On Wed, 22 Feb 2017 18:43:05 +0200
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Thu, Feb 09, 2017 at 05:11:05PM +0100, Cornelia Huck wrote:
> > > > > >>> * Non power-of-2 ring sizes
> > > > > >>>
> > > > > >>> As the ring simply wraps around, there's no reason to
> > > > > >>> require ring size to be power of two.
> > > > > >>> It can be made a separate feature though.
> > > > > >>
> > > > > >> Power of 2 ring sizes are required in order to ignore the high
> > > > > >> bits of
> > > > > >> the indices.  With non-power-of-2 sizes you are forced to keep the
> > > > > >> indices less than the ring size.
> > > > > > 
> > > > > > Right. So
> > > > > > 
> > > > > > 	if (unlikely(idx++ > size))
> > > > > > 		idx = 0;
> > > > > > 
> > > > > > OTOH ring size that's twice larger than necessary
> > > > > > because of power of two requirements wastes cache.
> > > > > 
> > > > > I don't know.  Power of 2 ring size is pretty standard, I'd rather
> > > > > avoid
> > > > > the complication and the gratuitous difference with 1.0.
> > > > 
> > > > I agree. I don't think dropping the power of 2 requirement buys us so
> > > > much that it makes up for the added complexity.
> > > 
> > > I recalled why I came up with this. The issue is cache associativity.
> > > Recall that besides the ring we have event suppression
> > > structures - if we are lucky and things run at the same speed
> > > everything can work by polling keeping events disabled, then
> > > event suppression structures are never written to, they are read-only.
> > > 
> > > However if ring and event suppression share a cache line ring accesses
> > > have a chance to push the event suppression out of cache, causing
> > > misses on read.
> > > 
> > > This can happen if they are at the same offset in the set.
> > > E.g. with L1 cache 4Kbyte sets are common, so same offset
> > > within a 4K page.
> > > 
> > > We can fix this by making event suppression adjacent in memory, e.g.:
> > > 
> > > 
> > > [interrupt suppress]
> > > [descriptor ring]
> > > [kick suppress]
> > > 
> > > If this whole structure fits in a single set, ring accesses will
> > > not push kick or interrupt suppress out of cache.
> > > Specific layout can be left for drivers, but as set size is
> > > a power of two this might require a non-power of two ring size.
> > > 
> > > I conclude that this is an optimization that needs to be
> > > benchmarked.
> > 
> > This makes sense. But wouldn't the optimum layout not depend on the
> > platform?
> 
> There's generally a tradeoff between performance and portability.
> Whether it's worth it would need to be tested.
> Further, it might be better to have platform-specific optimization
> tied to a given platform rather than a feature bit.
> 
> > > 
> > > I also note that the generic description does not have to force
> > > powers of two *even if devices actually require it*.
> > > I would be inclined to word the text in a way that makes
> > > relaxing the restriction easier.
> > > 
> > > For example, we can say "free running 16 bit index" and this forces a
> > > power of two, but we can also say "free running index wrapping to 0
> > > after (N*queue-size - 1) with N chosen such that the value fits in 16
> > > bit" and this is exactly the same if queue size is a power of 2.
> > > 
> > > So we can add text saying "ring size MUST be a power of two"
> > > and later it will be easy to relax just by adding a feature bit.
> > 
> > A later feature bit sounds good.
> 
> No need to delay benchmarking if someone has the time though :)
> 
> --
> MST
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

