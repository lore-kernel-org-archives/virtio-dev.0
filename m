Return-Path: virtio-dev-return-5095-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8AB8A985D72
	for <virtio-dev@lists.oasis-open.org>; Fri, 30 Nov 2018 13:52:47 +0000 (UTC)
Date: Fri, 30 Nov 2018 08:52:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181130084722-mutt-send-email-mst@kernel.org>
References: <20181121100330.24846-1-tiwei.bie@intel.com>
 <20181121100330.24846-2-tiwei.bie@intel.com>
 <1928ac96-3684-45c4-1e8c-09dff03bf308@redhat.com>
 <20181130095339.GA11984@debian>
 <20181130074720-mutt-send-email-mst@kernel.org>
 <13593b5c-c1dc-3ab3-a843-d62908e0c7e0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13593b5c-c1dc-3ab3-a843-d62908e0c7e0@redhat.com>
Subject: [virtio-dev] Re: [PATCH net-next v3 01/13] virtio: add packed ring types and
 macros
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org, wexu@redhat.com, jfreimann@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Nov 30, 2018 at 02:01:06PM +0100, Maxime Coquelin wrote:
> 
> 
> On 11/30/18 1:47 PM, Michael S. Tsirkin wrote:
> > On Fri, Nov 30, 2018 at 05:53:40PM +0800, Tiwei Bie wrote:
> > > On Fri, Nov 30, 2018 at 04:10:55PM +0800, Jason Wang wrote:
> > > > 
> > > > On 2018/11/21 下午6:03, Tiwei Bie wrote:
> > > > > Add types and macros for packed ring.
> > > > > 
> > > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > > > ---
> > > > >    include/uapi/linux/virtio_config.h |  3 +++
> > > > >    include/uapi/linux/virtio_ring.h   | 52 ++++++++++++++++++++++++++++++++++++++
> > > > >    2 files changed, 55 insertions(+)
> > > > > 
> > > > > diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> > > > > index 449132c76b1c..1196e1c1d4f6 100644
> > > > > --- a/include/uapi/linux/virtio_config.h
> > > > > +++ b/include/uapi/linux/virtio_config.h
> > > > > @@ -75,6 +75,9 @@
> > > > >     */
> > > > >    #define VIRTIO_F_IOMMU_PLATFORM		33
> > > > > +/* This feature indicates support for the packed virtqueue layout. */
> > > > > +#define VIRTIO_F_RING_PACKED		34
> > > > > +
> > > > >    /*
> > > > >     * Does the device support Single Root I/O Virtualization?
> > > > >     */
> > > > > diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> > > > > index 6d5d5faa989b..2414f8af26b3 100644
> > > > > --- a/include/uapi/linux/virtio_ring.h
> > > > > +++ b/include/uapi/linux/virtio_ring.h
> > > > > @@ -44,6 +44,13 @@
> > > > >    /* This means the buffer contains a list of buffer descriptors. */
> > > > >    #define VRING_DESC_F_INDIRECT	4
> > > > > +/*
> > > > > + * Mark a descriptor as available or used in packed ring.
> > > > > + * Notice: they are defined as shifts instead of shifted values.
> > > > 
> > > > 
> > > > This looks inconsistent to previous flags, any reason for using shifts?
> > > 
> > > Yeah, it was suggested to use shifts, as _F_ should be a bit
> > > number, not a shifted value:
> > > 
> > > https://patchwork.ozlabs.org/patch/942296/#1989390
> > 
> > But let's add a _SPLIT_ variant that uses shifts consistently.
> 
> Maybe we could avoid adding SPLIT and PACKED, but define as follow:
> 
> #define VRING_DESC_F_INDIRECT_SHIFT 2
> #define VRING_DESC_F_INDIRECT (1ull <<  VRING_DESC_F_INDIRECT_SHIFT)
> 
> #define VRING_DESC_F_AVAIL_SHIFT 7
> #define VRING_DESC_F_AVAIL (1ull << VRING_DESC_F_AVAIL_SHIFT)
> 
> I think it would be better for consistency.

I don't think that will help. the problem is that
most of the existing virtio code consistently uses _F_ as shifts.
So we just need to do something about these 5 being inconsistent:

include/uapi/linux/virtio_ring.h:#define VRING_DESC_F_NEXT      1
include/uapi/linux/virtio_ring.h:#define VRING_DESC_F_WRITE     2
include/uapi/linux/virtio_ring.h:#define VRING_DESC_F_INDIRECT  4
include/uapi/linux/virtio_ring.h:#define VRING_USED_F_NO_NOTIFY 1
include/uapi/linux/virtio_ring.h:#define VRING_AVAIL_F_NO_INTERRUPT     1

I do not want all of virtio to become verbose with _SHIFT, ergo
we need to change the above 5 to have names which are with _F_ and
have the bit number.



> > 
> > 
> > > > 
> > > > 
> > > > > + */
> > > > > +#define VRING_PACKED_DESC_F_AVAIL	7
> > > > > +#define VRING_PACKED_DESC_F_USED	15
> > > > > +
> > > > >    /* The Host uses this in used->flags to advise the Guest: don't kick me when
> > > > >     * you add a buffer.  It's unreliable, so it's simply an optimization.  Guest
> > > > >     * will still kick if it's out of buffers. */
> > > > > @@ -53,6 +60,23 @@
> > > > >     * optimization.  */
> > > > >    #define VRING_AVAIL_F_NO_INTERRUPT	1
> > > > > +/* Enable events in packed ring. */
> > > > > +#define VRING_PACKED_EVENT_FLAG_ENABLE	0x0
> > > > > +/* Disable events in packed ring. */
> > > > > +#define VRING_PACKED_EVENT_FLAG_DISABLE	0x1
> > > > > +/*
> > > > > + * Enable events for a specific descriptor in packed ring.
> > > > > + * (as specified by Descriptor Ring Change Event Offset/Wrap Counter).
> > > > > + * Only valid if VIRTIO_RING_F_EVENT_IDX has been negotiated.
> > > > > + */
> > > > > +#define VRING_PACKED_EVENT_FLAG_DESC	0x2
> > > > 
> > > > 
> > > > Any reason for using _FLAG_ instead of _F_?
> > > 
> > > Yeah, it was suggested to not use _F_, as these are values,
> > > should not have _F_:
> > > 
> > > https://patchwork.ozlabs.org/patch/942296/#1989390
> > > 
> > > Regards,
> > > Tiwei
> > > 
> > > > 
> > > > Thanks
> > > > 
> > > > 
> > > > > +
> > > > > +/*
> > > > > + * Wrap counter bit shift in event suppression structure
> > > > > + * of packed ring.
> > > > > + */
> > > > > +#define VRING_PACKED_EVENT_F_WRAP_CTR	15
> > > > > +
> > > > >    /* We support indirect buffer descriptors */
> > > > >    #define VIRTIO_RING_F_INDIRECT_DESC	28
> > > > > @@ -171,4 +195,32 @@ static inline int vring_need_event(__u16 event_idx, __u16 new_idx, __u16 old)
> > > > >    	return (__u16)(new_idx - event_idx - 1) < (__u16)(new_idx - old);
> > > > >    }
> > > > > +struct vring_packed_desc_event {
> > > > > +	/* Descriptor Ring Change Event Offset/Wrap Counter. */
> > > > > +	__le16 off_wrap;
> > > > > +	/* Descriptor Ring Change Event Flags. */
> > > > > +	__le16 flags;
> > > > > +};
> > > > > +
> > > > > +struct vring_packed_desc {
> > > > > +	/* Buffer Address. */
> > > > > +	__le64 addr;
> > > > > +	/* Buffer Length. */
> > > > > +	__le32 len;
> > > > > +	/* Buffer ID. */
> > > > > +	__le16 id;
> > > > > +	/* The flags depending on descriptor type. */
> > > > > +	__le16 flags;
> > > > > +};
> > > > > +
> > > > > +struct vring_packed {
> > > > > +	unsigned int num;
> > > > > +
> > > > > +	struct vring_packed_desc *desc;
> > > > > +
> > > > > +	struct vring_packed_desc_event *driver;
> > > > > +
> > > > > +	struct vring_packed_desc_event *device;
> > > > > +};
> > > > > +
> > > > >    #endif /* _UAPI_LINUX_VIRTIO_RING_H */

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

