Return-Path: virtio-dev-return-4827-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7C4C6985C96
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Sep 2018 02:14:23 +0000 (UTC)
Date: Mon, 10 Sep 2018 10:13:22 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180910021322.GA10912@debian>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180711022711.7090-2-tiwei.bie@intel.com>
 <20180907094922-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180907094922-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH net-next v2 1/5] virtio: add packed ring definitions
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org, wexu@redhat.com, jfreimann@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Sep 07, 2018 at 09:51:23AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 11, 2018 at 10:27:07AM +0800, Tiwei Bie wrote:
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > ---
> >  include/uapi/linux/virtio_config.h |  3 +++
> >  include/uapi/linux/virtio_ring.h   | 43 ++++++++++++++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> > 
> > diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> > index 449132c76b1c..1196e1c1d4f6 100644
> > --- a/include/uapi/linux/virtio_config.h
> > +++ b/include/uapi/linux/virtio_config.h
> > @@ -75,6 +75,9 @@
> >   */
> >  #define VIRTIO_F_IOMMU_PLATFORM		33
> >  
> > +/* This feature indicates support for the packed virtqueue layout. */
> > +#define VIRTIO_F_RING_PACKED		34
> > +
> >  /*
> >   * Does the device support Single Root I/O Virtualization?
> >   */
> > diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> > index 6d5d5faa989b..0254a2ba29cf 100644
> > --- a/include/uapi/linux/virtio_ring.h
> > +++ b/include/uapi/linux/virtio_ring.h
> > @@ -44,6 +44,10 @@
> >  /* This means the buffer contains a list of buffer descriptors. */
> >  #define VRING_DESC_F_INDIRECT	4
> >  
> > +/* Mark a descriptor as available or used. */
> > +#define VRING_DESC_F_AVAIL	(1ul << 7)
> > +#define VRING_DESC_F_USED	(1ul << 15)
> > +
> >  /* The Host uses this in used->flags to advise the Guest: don't kick me when
> >   * you add a buffer.  It's unreliable, so it's simply an optimization.  Guest
> >   * will still kick if it's out of buffers. */
> > @@ -53,6 +57,17 @@
> >   * optimization.  */
> >  #define VRING_AVAIL_F_NO_INTERRUPT	1
> >  
> > +/* Enable events. */
> > +#define VRING_EVENT_F_ENABLE	0x0
> > +/* Disable events. */
> > +#define VRING_EVENT_F_DISABLE	0x1
> > +/*
> > + * Enable events for a specific descriptor
> > + * (as specified by Descriptor Ring Change Event Offset/Wrap Counter).
> > + * Only valid if VIRTIO_RING_F_EVENT_IDX has been negotiated.
> > + */
> > +#define VRING_EVENT_F_DESC	0x2
> > +
> >  /* We support indirect buffer descriptors */
> >  #define VIRTIO_RING_F_INDIRECT_DESC	28
> >  
> 
> These are for the packed ring, right? Pls prefix accordingly.

How about something like this:

#define VRING_PACKED_DESC_F_AVAIL	(1u << 7)
#define VRING_PACKED_DESC_F_USED	(1u << 15)

#define VRING_PACKED_EVENT_F_ENABLE	0x0
#define VRING_PACKED_EVENT_F_DISABLE	0x1
#define VRING_PACKED_EVENT_F_DESC	0x2


> Also, you likely need macros for the wrap counters.

How about something like this:

#define VRING_PACKED_EVENT_WRAP_COUNTER_SHIFT	15
#define VRING_PACKED_EVENT_WRAP_COUNTER_MASK	\
			(1u << VRING_PACKED_WRAP_COUNTER_SHIFT)
#define VRING_PACKED_EVENT_OFFSET_MASK	\
			((1u << VRING_PACKED_WRAP_COUNTER_SHIFT) - 1)

> 
> > @@ -171,4 +186,32 @@ static inline int vring_need_event(__u16 event_idx, __u16 new_idx, __u16 old)
> >  	return (__u16)(new_idx - event_idx - 1) < (__u16)(new_idx - old);
> >  }
> >  
> > +struct vring_packed_desc_event {
> > +	/* Descriptor Ring Change Event Offset/Wrap Counter. */
> > +	__virtio16 off_wrap;
> > +	/* Descriptor Ring Change Event Flags. */
> > +	__virtio16 flags;
> > +};
> > +
> > +struct vring_packed_desc {
> > +	/* Buffer Address. */
> > +	__virtio64 addr;
> > +	/* Buffer Length. */
> > +	__virtio32 len;
> > +	/* Buffer ID. */
> > +	__virtio16 id;
> > +	/* The flags depending on descriptor type. */
> > +	__virtio16 flags;
> > +};
> 
> Don't use __virtioXX types, just __leXX ones.

Got it, will do that.

> 
> > +
> > +struct vring_packed {
> > +	unsigned int num;
> > +
> > +	struct vring_packed_desc *desc;
> > +
> > +	struct vring_packed_desc_event *driver;
> > +
> > +	struct vring_packed_desc_event *device;
> > +};
> > +
> >  #endif /* _UAPI_LINUX_VIRTIO_RING_H */
> > -- 
> > 2.18.0

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

