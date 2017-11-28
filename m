Return-Path: virtio-dev-return-2711-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 783FF5818CB1
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Nov 2017 06:36:40 -0800 (PST)
Date: Tue, 28 Nov 2017 16:36:35 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171128155148-mutt-send-email-mst@kernel.org>
References: <20171108141659-mutt-send-email-mst@kernel.org>
 <24fcb5e29d8d446fa6a13d262205edc4@napatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24fcb5e29d8d446fa6a13d262205edc4@napatech.com>
Subject: Re: [virtio-dev] [PATCH RFC] packed ring layout spec v5
To: Lars Ganrot <lga@napatech.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Nov 25, 2017 at 07:55:53PM +0000, Lars Ganrot wrote:
> Hi Michael and others,
> 
> Hopefully my question below follows the forum format.
> 
> BR,
> 
> -Lars
> >
> > \subsection{In-order use of descriptors} \label{sec:Packed Virtqueues / In-order
> > use of descriptors}
> >
> > Some devices always use descriptors in the same order in which they have been
> > made available. These devices can offer the VIRTIO_F_IN_ORDER feature. If
> > negotiated, this knowledge allows devices to notify the use of a batch of buffers
> > to the driver by only writing out a single used descriptor with the Buffer ID
> > corresponding to the last descriptor in the batch.
> >
> This VIRTIO_F_IN_ORDER feature bit answers one of my earlier questions, however I'm curious if it couldn't also be usable in the non-ring Virtqueue?

Yes, it could.

> If the device always returns buffers in order, then couldn't the driver skip the step of reading the used.ring for read-only buffers  (e.g. TX for net devices)? The used.idx tells how many buffers were returned, and since they are returned in the same order as the driver sent them, it knows what their indices are. This would then save one cache-miss in the old structure too.

True. That would be another variant to support though.

I doubt it'll outperform this one but I didn't test it
specifically. Care trying to implement it?

> And a follow-up questions would then be: if a device always returns buffers in order, does the v1.0 specification not require drivers to reuse descriptors in the same order as they are returned? I think 3.2.1.1 implies that at least. If so, wouldn't new descriptors always be placed back2back in the descriptor table (contiguous memory)?

You probably mean this:
1. Get the next free descriptor table entry, d

and you interpret "next" here as "next in ring order".

I'm not sure everyone follows this interpretation though.

E.g. Linux does:
static void detach_buf(struct vring_virtqueue *vq, unsigned int head,
                       void **ctx)
{
...
        vq->vring.desc[i].next = cpu_to_virtio16(vq->vq.vdev, vq->free_head);
        vq->free_head = head;

So descriptors are added at head of the free list.  Next is interpreted
as next on this list.  E.g. with a single request in flight, it looks
like a single descriptor will keep getting reused.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

