Return-Path: virtio-dev-return-4682-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B051985B2B
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Jul 2018 02:52:57 +0000 (UTC)
References: <20180711022711.7090-1-tiwei.bie@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f1438d58-db71-4a5c-e8fc-b4408d59e172@redhat.com>
Date: Wed, 11 Jul 2018 10:52:49 +0800
MIME-Version: 1.0
In-Reply-To: <20180711022711.7090-1-tiwei.bie@intel.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v2 0/5] virtio: support packed ring
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: wexu@redhat.com, jfreimann@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 2018年07月11日 10:27, Tiwei Bie wrote:
> Hello everyone,
>
> This patch set implements packed ring support in virtio driver.
>
> Some functional tests have been done with Jason's
> packed ring implementation in vhost:
>
> https://lkml.org/lkml/2018/7/3/33
>
> Both of ping and netperf worked as expected.
>
> v1 -> v2:
> - Use READ_ONCE() to read event off_wrap and flags together (Jason);
> - Add comments related to ccw (Jason);
>
> RFC (v6) -> v1:
> - Avoid extra virtio_wmb() in virtqueue_enable_cb_delayed_packed()
>    when event idx is off (Jason);
> - Fix bufs calculation in virtqueue_enable_cb_delayed_packed() (Jason);
> - Test the state of the desc at used_idx instead of last_used_idx
>    in virtqueue_enable_cb_delayed_packed() (Jason);
> - Save wrap counter (as part of queue state) in the return value
>    of virtqueue_enable_cb_prepare_packed();
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
> Thanks!
>
> Tiwei Bie (5):
>    virtio: add packed ring definitions
>    virtio_ring: support creating packed ring
>    virtio_ring: add packed ring support
>    virtio_ring: add event idx support in packed ring
>    virtio_ring: enable packed ring
>
>   drivers/s390/virtio/virtio_ccw.c   |   14 +
>   drivers/virtio/virtio_ring.c       | 1365 ++++++++++++++++++++++------
>   include/linux/virtio_ring.h        |    8 +-
>   include/uapi/linux/virtio_config.h |    3 +
>   include/uapi/linux/virtio_ring.h   |   43 +
>   5 files changed, 1157 insertions(+), 276 deletions(-)
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks!


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

