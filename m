Return-Path: virtio-dev-return-4939-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E34B9985D98
	for <virtio-dev@lists.oasis-open.org>; Thu,  8 Nov 2018 01:39:36 +0000 (UTC)
Date: Thu, 8 Nov 2018 09:38:00 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20181108013759.GA20591@debian>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180711022711.7090-4-tiwei.bie@intel.com>
 <20181107123933-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181107123933-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH net-next v2 3/5] virtio_ring: add packed ring support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org, wexu@redhat.com, jfreimann@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Nov 07, 2018 at 12:48:46PM -0500, Michael S. Tsirkin wrote:
> On Wed, Jul 11, 2018 at 10:27:09AM +0800, Tiwei Bie wrote:
> > This commit introduces the support (without EVENT_IDX) for
> > packed ring.
> > 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 495 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 487 insertions(+), 8 deletions(-)
[...]
> >  
> > +static void vring_unmap_state_packed(const struct vring_virtqueue *vq,
> > +				     struct vring_desc_state_packed *state)
> > +{
> > +	u16 flags;
> > +
> > +	if (!vring_use_dma_api(vq->vq.vdev))
> > +		return;
> > +
> > +	flags = state->flags;
> > +
> > +	if (flags & VRING_DESC_F_INDIRECT) {
> > +		dma_unmap_single(vring_dma_dev(vq),
> > +				 state->addr, state->len,
> > +				 (flags & VRING_DESC_F_WRITE) ?
> > +				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > +	} else {
> > +		dma_unmap_page(vring_dma_dev(vq),
> > +			       state->addr, state->len,
> > +			       (flags & VRING_DESC_F_WRITE) ?
> > +			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > +	}
> > +}
> > +
> > +static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
> > +				   struct vring_packed_desc *desc)
> > +{
> > +	u16 flags;
> > +
> > +	if (!vring_use_dma_api(vq->vq.vdev))
> > +		return;
> > +
> > +	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
> 
> BTW this stuff is only used on error etc. Is there a way to
> reuse vring_unmap_state_packed?

It's also used by the INDIRECT path. We don't allocate desc
state for INDIRECT descriptors to save DMA addr/len etc.

> 
> > +
> > +	if (flags & VRING_DESC_F_INDIRECT) {
> > +		dma_unmap_single(vring_dma_dev(vq),
> > +				 virtio64_to_cpu(vq->vq.vdev, desc->addr),
> > +				 virtio32_to_cpu(vq->vq.vdev, desc->len),
> > +				 (flags & VRING_DESC_F_WRITE) ?
> > +				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > +	} else {
> > +		dma_unmap_page(vring_dma_dev(vq),
> > +			       virtio64_to_cpu(vq->vq.vdev, desc->addr),
> > +			       virtio32_to_cpu(vq->vq.vdev, desc->len),
> > +			       (flags & VRING_DESC_F_WRITE) ?
> > +			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > +	}
> > +}
[...]
> > @@ -766,47 +840,449 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> >  				       void *ctx,
> >  				       gfp_t gfp)
> >  {
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	struct vring_packed_desc *desc;
> > +	struct scatterlist *sg;
> > +	unsigned int i, n, descs_used, uninitialized_var(prev), err_idx;
> > +	__virtio16 uninitialized_var(head_flags), flags;
> > +	u16 head, avail_wrap_counter, id, curr;
> > +	bool indirect;
> > +
> > +	START_USE(vq);
> > +
> > +	BUG_ON(data == NULL);
> > +	BUG_ON(ctx && vq->indirect);
> > +
> > +	if (unlikely(vq->broken)) {
> > +		END_USE(vq);
> > +		return -EIO;
> > +	}
> > +
> > +#ifdef DEBUG
> > +	{
> > +		ktime_t now = ktime_get();
> > +
> > +		/* No kick or get, with .1 second between?  Warn. */
> > +		if (vq->last_add_time_valid)
> > +			WARN_ON(ktime_to_ms(ktime_sub(now, vq->last_add_time))
> > +					    > 100);
> > +		vq->last_add_time = now;
> > +		vq->last_add_time_valid = true;
> > +	}
> > +#endif
> > +
> > +	BUG_ON(total_sg == 0);
> > +
> > +	head = vq->next_avail_idx;
> > +	avail_wrap_counter = vq->avail_wrap_counter;
> > +
> > +	if (virtqueue_use_indirect(_vq, total_sg))
> > +		desc = alloc_indirect_packed(_vq, total_sg, gfp);
> > +	else {
> > +		desc = NULL;
> > +		WARN_ON_ONCE(total_sg > vq->vring_packed.num && !vq->indirect);
> > +	}
> > +
> > +	if (desc) {
> > +		/* Use a single buffer which doesn't continue */
> > +		indirect = true;
> > +		/* Set up rest to use this indirect table. */
> > +		i = 0;
> > +		descs_used = 1;
> > +	} else {
> > +		indirect = false;
> > +		desc = vq->vring_packed.desc;
> > +		i = head;
> > +		descs_used = total_sg;
> > +	}
> > +
> > +	if (vq->vq.num_free < descs_used) {
> > +		pr_debug("Can't add buf len %i - avail = %i\n",
> > +			 descs_used, vq->vq.num_free);
> > +		/* FIXME: for historical reasons, we force a notify here if
> > +		 * there are outgoing parts to the buffer.  Presumably the
> > +		 * host should service the ring ASAP. */
> 
> I don't think we have a reason to do this for packed ring.
> No historical baggage there, right?

Based on the original commit log, it seems that the notify here
is just an "optimization". But I don't quite understand what does
the "the heuristics which KVM uses" refer to. If it's safe to drop
this in packed ring, I'd like to do it.

commit 44653eae1407f79dff6f52fcf594ae84cb165ec4
Author: Rusty Russell <rusty@rustcorp.com.au>
Date:   Fri Jul 25 12:06:04 2008 -0500

    virtio: don't always force a notification when ring is full
    
    We force notification when the ring is full, even if the host has
    indicated it doesn't want to know.  This seemed like a good idea at
    the time: if we fill the transmit ring, we should tell the host
    immediately.
    
    Unfortunately this logic also applies to the receiving ring, which is
    refilled constantly.  We should introduce real notification thesholds
    to replace this logic.  Meanwhile, removing the logic altogether breaks
    the heuristics which KVM uses, so we use a hack: only notify if there are
    outgoing parts of the new buffer.
    
    Here are the number of exits with lguest's crappy network implementation:
    Before:
            network xmit 7859051 recv 236420
    After:
            network xmit 7858610 recv 118136
    
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 72bf8bc09014..21d9a62767af 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -87,8 +87,11 @@ static int vring_add_buf(struct virtqueue *_vq,
 	if (vq->num_free < out + in) {
 		pr_debug("Can't add buf len %i - avail = %i\n",
 			 out + in, vq->num_free);
-		/* We notify *even if* VRING_USED_F_NO_NOTIFY is set here. */
-		vq->notify(&vq->vq);
+		/* FIXME: for historical reasons, we force a notify here if
+		 * there are outgoing parts to the buffer.  Presumably the
+		 * host should service the ring ASAP. */
+		if (out)
+			vq->notify(&vq->vq);
 		END_USE(vq);
 		return -ENOSPC;
 	}


> 
> > +		if (out_sgs)
> > +			vq->notify(&vq->vq);
> > +		if (indirect)
> > +			kfree(desc);
> > +		END_USE(vq);
> > +		return -ENOSPC;
> > +	}
> > +
[...]

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

