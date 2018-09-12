Return-Path: virtio-dev-return-4844-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A392985D24
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Sep 2018 16:22:27 +0000 (UTC)
Date: Wed, 12 Sep 2018 12:22:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180912121650-mutt-send-email-mst@kernel.org>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180711022711.7090-4-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711022711.7090-4-tiwei.bie@intel.com>
Subject: [virtio-dev] Re: [PATCH net-next v2 3/5] virtio_ring: add packed ring support
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org, wexu@redhat.com, jfreimann@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 11, 2018 at 10:27:09AM +0800, Tiwei Bie wrote:
> This commit introduces the support (without EVENT_IDX) for
> packed ring.
> 
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
>  drivers/virtio/virtio_ring.c | 495 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 487 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c4f8abc7445a..f317b485ba54 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -55,12 +55,21 @@
>  #define END_USE(vq)
>  #endif
>  
> +#define _VRING_DESC_F_AVAIL(b)	((__u16)(b) << 7)
> +#define _VRING_DESC_F_USED(b)	((__u16)(b) << 15)
> +
>  struct vring_desc_state {
>  	void *data;			/* Data for callback. */
>  	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
>  };
>  
>  struct vring_desc_state_packed {
> +	void *data;			/* Data for callback. */
> +	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
> +	int num;			/* Descriptor list length. */
> +	dma_addr_t addr;		/* Buffer DMA addr. */
> +	u32 len;			/* Buffer length. */
> +	u16 flags;			/* Descriptor flags. */
>  	int next;			/* The next desc state. */
>  };
>  

Idea: how about using data to chain these descriptors?
You can validate it's pointing within an array to distinguish
e.g. on detach.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

