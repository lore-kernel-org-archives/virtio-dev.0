Return-Path: virtio-dev-return-5001-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9EDAB984180
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Nov 2018 12:20:36 +0000 (UTC)
Date: Wed, 21 Nov 2018 07:20:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181121071308-mutt-send-email-mst@kernel.org>
References: <20181121100330.24846-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121100330.24846-1-tiwei.bie@intel.com>
Subject: [virtio-dev] Re: [PATCH net-next v3 00/13] virtio: support packed ring
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org, wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Nov 21, 2018 at 06:03:17PM +0800, Tiwei Bie wrote:
> Hi,
> 
> This patch set implements packed ring support in virtio driver.
> 
> A performance test between pktgen (pktgen_sample03_burst_single_flow.sh)
> and DPDK vhost (testpmd/rxonly/vhost-PMD) has been done, I saw
> ~30% performance gain in packed ring in this case.

Thanks a lot, this is very exciting!
Dave, given the holiday, attempts to wrap up the 1.1 spec and the
patchset size I would very much appreciate a bit more time for
review. Say until Nov 28?

> To make this patch set work with below patch set for vhost,
> some hacks are needed to set the _F_NEXT flag in indirect
> descriptors (this should be fixed in vhost):
> 
> https://lkml.org/lkml/2018/7/3/33

Could you pls clarify - do you mean it doesn't yet work with vhost
because of a vhost bug, and to test it with the linked patches
you had to hack in _F_NEXT? Because I do not see _F_NEXT
in indirect descriptors in this patch (which is fine).
Or did I miss it?

> v2 -> v3:
> - Use leXX instead of virtioXX (MST);
> - Refactor split ring first (MST);
> - Add debug helpers (MST);
> - Put split/packed ring specific fields in sub structures (MST);
> - Handle normal descriptors and indirect descriptors differently (MST);
> - Track the DMA addr/len related info in a separate structure (MST);
> - Calculate AVAIL/USED flags only when wrap counter wraps (MST);
> - Define a struct/union to read event structure (MST);
> - Define a macro for wrap counter bit in uapi (MST);
> - Define the AVAIL/USED bits as shifts instead of values (MST);
> - s/_F_/_FLAG_/ in VRING_PACKED_EVENT_* as they are values (MST);
> - Drop the notify workaround for QEMU's tx-timer in packed ring (MST);
> 
> v1 -> v2:
> - Use READ_ONCE() to read event off_wrap and flags together (Jason);
> - Add comments related to ccw (Jason);
> 
> RFC v6 -> v1:
> - Avoid extra virtio_wmb() in virtqueue_enable_cb_delayed_packed()
>   when event idx is off (Jason);
> - Fix bufs calculation in virtqueue_enable_cb_delayed_packed() (Jason);
> - Test the state of the desc at used_idx instead of last_used_idx
>   in virtqueue_enable_cb_delayed_packed() (Jason);
> - Save wrap counter (as part of queue state) in the return value
>   of virtqueue_enable_cb_prepare_packed();
> - Refine the packed ring definitions in uapi;
> - Rebase on the net-next tree;
> 
> RFC v5 -> RFC v6:
> - Avoid tracking addr/len/flags when DMA API isn't used (MST/Jason);
> - Define wrap counter as bool (Jason);
> - Use ALIGN() in vring_init_packed() (Jason);
> - Avoid using pointer to track `next` in detach_buf_packed() (Jason);
> - Add comments for barriers (Jason);
> - Don't enable RING_PACKED on ccw for now (noticed by Jason);
> - Refine the memory barrier in virtqueue_poll();
> - Add a missing memory barrier in virtqueue_enable_cb_delayed_packed();
> - Remove the hacks in virtqueue_enable_cb_prepare_packed();
> 
> RFC v4 -> RFC v5:
> - Save DMA addr, etc in desc state (Jason);
> - Track used wrap counter;
> 
> RFC v3 -> RFC v4:
> - Make ID allocation support out-of-order (Jason);
> - Various fixes for EVENT_IDX support;
> 
> RFC v2 -> RFC v3:
> - Split into small patches (Jason);
> - Add helper virtqueue_use_indirect() (Jason);
> - Just set id for the last descriptor of a list (Jason);
> - Calculate the prev in virtqueue_add_packed() (Jason);
> - Fix/improve desc suppression code (Jason/MST);
> - Refine the code layout for XXX_split/packed and wrappers (MST);
> - Fix the comments and API in uapi (MST);
> - Remove the BUG_ON() for indirect (Jason);
> - Some other refinements and bug fixes;
> 
> RFC v1 -> RFC v2:
> - Add indirect descriptor support - compile test only;
> - Add event suppression supprt - compile test only;
> - Move vring_packed_init() out of uapi (Jason, MST);
> - Merge two loops into one in virtqueue_add_packed() (Jason);
> - Split vring_unmap_one() for packed ring and split ring (Jason);
> - Avoid using '%' operator (Jason);
> - Rename free_head -> next_avail_idx (Jason);
> - Add comments for virtio_wmb() in virtqueue_add_packed() (Jason);
> - Some other refinements and bug fixes;
> 
> 
> Tiwei Bie (13):
>   virtio: add packed ring types and macros
>   virtio_ring: add _split suffix for split ring functions
>   virtio_ring: put split ring functions together
>   virtio_ring: put split ring fields in a sub struct
>   virtio_ring: introduce debug helpers
>   virtio_ring: introduce helper for indirect feature
>   virtio_ring: allocate desc state for split ring separately
>   virtio_ring: extract split ring handling from ring creation
>   virtio_ring: cache whether we will use DMA API
>   virtio_ring: introduce packed ring support
>   virtio_ring: leverage event idx in packed ring
>   virtio_ring: disable packed ring on unsupported transports
>   virtio_ring: advertize packed ring layout
> 
>  drivers/misc/mic/vop/vop_main.c        |   13 +
>  drivers/remoteproc/remoteproc_virtio.c |   13 +
>  drivers/s390/virtio/virtio_ccw.c       |   14 +
>  drivers/virtio/virtio_ring.c           | 1811 +++++++++++++++++++++++++-------
>  include/uapi/linux/virtio_config.h     |    3 +
>  include/uapi/linux/virtio_ring.h       |   52 +
>  6 files changed, 1530 insertions(+), 376 deletions(-)
> 
> -- 
> 2.14.5

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

