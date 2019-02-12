Return-Path: virtio-dev-return-5414-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 56AF7985D23
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Feb 2019 18:58:29 +0000 (UTC)
Date: Tue, 12 Feb 2019 13:58:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190212135541-mutt-send-email-mst@kernel.org>
References: <501110004.11631.1549031044295@oodm23.prod.google.com>
 <CAJPjb1LF0x6AJ3vgvudURwhJ_OYkNHG0sG-ZfD7H-n7PcN1uBA@mail.gmail.com>
 <20190204053628.GD29758@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204053628.GD29758@stefanha-x1.localdomain>
Subject: Re: [virtio-dev] RFC: Doorbell suppression, packed-ring mode and
 hardware offload
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Rob Miller <rob.miller@broadcom.com>, David Riddoch <driddoch@solarflare.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 04, 2019 at 01:36:28PM +0800, Stefan Hajnoczi wrote:
> On Fri, Feb 01, 2019 at 09:43:02AM -0800, Rob Miller wrote:
> > Agreed that this is needed.
> > 
> > I would also like to suggest splitting the F_IN_ORDER into
> > F_RX_IN_ORDER and F_TX_IN_ORDER to support hw LRO implementations,
> > which can be more of a scatter/gather than tx. This would allow
> > batchmode for tx at least in packed rings.
> > 
> > Finally, i would suggest a means to specify a given rings ring mode
> > and packed leans more towards TX, whilst split can be either really
> > depending upon LRO, jumbo, rx buff size, ect.. just like F_IN_ORDER,
> > we can have RX & TX, split out.
> 
> Device types beside virtio-net might also want per-virtqueue F_IN_ORDER
> and other features,

Do you know that they will? Now that we already have implementations,
how about a prototype patch showing the performance gains?

> so let's find a way to make it independent of
> virtio-net concepts like rx/tx.

Add another field along with VQ PA. It's not rocket science.

> The per-virtqueue in-order flag could live in struct
> pvirtq_event_suppress (VIRTIO 1.1 2.7.14 Event Suppression Structure
> Format).

That's for dynamic things though.

> Or a new structure could be used for per-virtqueue configuration.  Doing
> this is a little tricky if you want to select split vs packed ring
> layout on a per-virtqueue basis, since this structure is part of the
> split/packed ring layout.  It would probably be necessary to add vring
> mode selection to the transport (PCI, MMIO, CCW) instead.
> 
> Stefan

Yes.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

