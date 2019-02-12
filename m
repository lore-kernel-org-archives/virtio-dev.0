Return-Path: virtio-dev-return-5413-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F3BC9985D23
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Feb 2019 18:55:22 +0000 (UTC)
Date: Tue, 12 Feb 2019 13:55:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190212134959-mutt-send-email-mst@kernel.org>
References: <501110004.11631.1549031044295@oodm23.prod.google.com>
 <CAJPjb1LF0x6AJ3vgvudURwhJ_OYkNHG0sG-ZfD7H-n7PcN1uBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJPjb1LF0x6AJ3vgvudURwhJ_OYkNHG0sG-ZfD7H-n7PcN1uBA@mail.gmail.com>
Subject: Re: [virtio-dev] RFC: Doorbell suppression, packed-ring mode and
 hardware offload
To: Rob Miller <rob.miller@broadcom.com>
Cc: David Riddoch <driddoch@solarflare.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Feb 01, 2019 at 09:43:02AM -0800, Rob Miller wrote:
> Agreed that this is needed.
> 
> I would also like to suggest splitting the F_IN_ORDER into
> F_RX_IN_ORDER and F_TX_IN_ORDER to support hw LRO implementations,
> which can be more of a scatter/gather than tx. This would allow
> batchmode for tx at least in packed rings.

I'm not sure what does this buy us. Are you interested in
out of order tx with in order rx then?

> Finally, i would suggest a means to specify a given rings ring mode
> and packed leans more towards TX, whilst split can be either really
> depending upon LRO, jumbo, rx buff size, ect.. just like F_IN_ORDER,
> we can have RX & TX, split out.
> 
> Sent from my iPhone

Before we jump there a bit more justification would be nice.


E.g. doing this change in software isn't a lot of work. How about
a software patch with some performance gains measured?
Failing that, some back of the napkin calculations showing
the potential gains and costs?


> > On Feb 1, 2019, at 9:23 AM, David Riddoch <driddoch@solarflare.com> wrote:
> >
> > All,
> >
> > I'd like to propose a small extension to the packed virtqueue mode.  My
> > proposal is to add an offset/wrap field, written by the driver,
> > indicating how many available descriptors have been added to the ring.
> >
> > The reason for wanting this is to improve performance of hardware
> > devices.  Because of high read latency over a PCIe bus, it is important
> > for hardware devices to read multiple ring entries in parallel.  It is
> > desirable to know how many descriptors are available prior to issuing
> > these reads, else you risk fetching descriptors that are not yet
> > available.  As well as wasting bus bandwidth this adds complexity.
> >
> > I'd previously hoped that VIRTIO_F_NOTIFICATION_DATA would solve this
> > problem, but we still have a problem.  If you rely on doorbells to tell
> > you how many descriptors are available, then you have to keep doorbells
> > enabled at all times.  This can result in a very high rate of doorbells
> > with some drivers, which can become a severe bottleneck (because x86
> > CPUs can't emit MMIOs at very high rates).
> >
> > The proposed offset/wrap field allows devices to disable doorbells when
> > appropriate, and determine the latest fill level via a PCIe read.
> >
> > I suggest the best place to put this would be in the driver area,
> > immediately after the event suppression structure.
> >
> > Presumably we would like this to be an optional feature, as
> > implementations of packed mode already exist in the wild.  How about
> > VIRTIO_F_RING_PACKED_AVAIL_IDX?
> >
> > If I prepare a patch to the spec is there still time to get this into v1.1?
> >
> > Best,
> > David
> >
> > --
> > David Riddoch  <driddoch@solarflare.com> -- Chief Architect, Solarflare
> >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

