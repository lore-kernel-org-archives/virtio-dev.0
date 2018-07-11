Return-Path: virtio-dev-return-4674-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B88D985B2A
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Jul 2018 01:09:25 +0000 (UTC)
Date: Wed, 11 Jul 2018 09:09:05 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180711010905.GB28235@debian>
References: <20180709072241.8886-1-tiwei.bie@intel.com>
 <20180709072241.8886-5-tiwei.bie@intel.com>
 <9ee31221-9f4a-f1c5-0f0b-8d178bb536e9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ee31221-9f4a-f1c5-0f0b-8d178bb536e9@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH net-next v1 4/5] virtio_ring: add event
 idx support in packed ring
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org, wexu@redhat.com, jfreimann@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jul 10, 2018 at 01:50:03PM +0800, Jason Wang wrote:
> On 2018年07月09日 15:22, Tiwei Bie wrote:
> > @@ -1059,9 +1059,19 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
> >   	 * suppressions. */
> >   	virtio_mb(vq->weak_barriers);
> > +	old = vq->next_avail_idx - vq->num_added;
> > +	new = vq->next_avail_idx;
> > +	vq->num_added = 0;
> > +
> >   	snapshot = *(u32 *)vq->vring_packed.device;
> 
> I think we should use READ_ONCE() to prevent compiler from re-reading.

I'll do it. Thanks!

Best regards,
Tiwei Bie

> 
> > +	off_wrap = virtio16_to_cpu(_vq->vdev, (__virtio16)(snapshot & 0xffff));
> >   	flags = virtio16_to_cpu(_vq->vdev, (__virtio16)(snapshot >> 16)) & 0x3;
> > +	wrap_counter = off_wrap >> 15;
> > +	event_idx = off_wrap & ~(1 << 15);
> > +	if (wrap_counter != vq->avail_wrap_counter)
> > +		event_idx -= vq->vring_packed.num;
> 
> Thanks
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

