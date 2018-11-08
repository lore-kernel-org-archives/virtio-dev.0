Return-Path: virtio-dev-return-4943-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3441F985DA1
	for <virtio-dev@lists.oasis-open.org>; Thu,  8 Nov 2018 14:15:03 +0000 (UTC)
Date: Thu, 8 Nov 2018 09:14:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181108091337-mutt-send-email-mst@kernel.org>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180711022711.7090-4-tiwei.bie@intel.com>
 <20181107123933-mutt-send-email-mst@kernel.org>
 <20181108013759.GA20591@debian>
 <2d46a41e-bc00-276a-e19a-105c9dffc75a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d46a41e-bc00-276a-e19a-105c9dffc75a@redhat.com>
Subject: [virtio-dev] Re: [PATCH net-next v2 3/5] virtio_ring: add packed ring support
To: Jason Wang <jasowang@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org, wexu@redhat.com, jfreimann@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 08, 2018 at 04:18:25PM +0800, Jason Wang wrote:
> 
> On 2018/11/8 上午9:38, Tiwei Bie wrote:
> > > > +
> > > > +	if (vq->vq.num_free < descs_used) {
> > > > +		pr_debug("Can't add buf len %i - avail = %i\n",
> > > > +			 descs_used, vq->vq.num_free);
> > > > +		/* FIXME: for historical reasons, we force a notify here if
> > > > +		 * there are outgoing parts to the buffer.  Presumably the
> > > > +		 * host should service the ring ASAP. */
> > > I don't think we have a reason to do this for packed ring.
> > > No historical baggage there, right?
> > Based on the original commit log, it seems that the notify here
> > is just an "optimization". But I don't quite understand what does
> > the "the heuristics which KVM uses" refer to. If it's safe to drop
> > this in packed ring, I'd like to do it.
> 
> 
> According to the commit log, it seems like a workaround of lguest networking
> backend. I agree to drop it, we should not have such burden.
> 
> But we should notice that, with this removed, the compare between packed vs
> split is kind of unfair.

I don't think this ever triggers to be frank. When would it?

> Consider the removal of lguest support recently,
> maybe we can drop this for split ring as well?
> 
> Thanks

If it's helpful, then for sure we can drop it for virtio 1.
Can you see any perf differences at all? With which device?

> 
> > 
> > commit 44653eae1407f79dff6f52fcf594ae84cb165ec4
> > Author: Rusty Russell<rusty@rustcorp.com.au>
> > Date:   Fri Jul 25 12:06:04 2008 -0500
> > 
> >      virtio: don't always force a notification when ring is full
> >      We force notification when the ring is full, even if the host has
> >      indicated it doesn't want to know.  This seemed like a good idea at
> >      the time: if we fill the transmit ring, we should tell the host
> >      immediately.
> >      Unfortunately this logic also applies to the receiving ring, which is
> >      refilled constantly.  We should introduce real notification thesholds
> >      to replace this logic.  Meanwhile, removing the logic altogether breaks
> >      the heuristics which KVM uses, so we use a hack: only notify if there are
> >      outgoing parts of the new buffer.
> >      Here are the number of exits with lguest's crappy network implementation:
> >      Before:
> >              network xmit 7859051 recv 236420
> >      After:
> >              network xmit 7858610 recv 118136
> >      Signed-off-by: Rusty Russell<rusty@rustcorp.com.au>
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 72bf8bc09014..21d9a62767af 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -87,8 +87,11 @@ static int vring_add_buf(struct virtqueue *_vq,
> >   	if (vq->num_free < out + in) {
> >   		pr_debug("Can't add buf len %i - avail = %i\n",
> >   			 out + in, vq->num_free);
> > -		/* We notify*even if*  VRING_USED_F_NO_NOTIFY is set here. */
> > -		vq->notify(&vq->vq);
> > +		/* FIXME: for historical reasons, we force a notify here if
> > +		 * there are outgoing parts to the buffer.  Presumably the
> > +		 * host should service the ring ASAP. */
> > +		if (out)
> > +			vq->notify(&vq->vq);
> >   		END_USE(vq);
> >   		return -ENOSPC;
> >   	}
> > 
> > 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

