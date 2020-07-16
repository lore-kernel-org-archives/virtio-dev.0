Return-Path: virtio-dev-return-7565-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 80A1D986079
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Jul 2020 06:39:49 +0000 (UTC)
Date: Thu, 16 Jul 2020 02:39:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200716023910-mutt-send-email-mst@kernel.org>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
 <1594867315-8626-6-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1594867315-8626-6-git-send-email-teawater@gmail.com>
Subject: [virtio-dev] Re: [RFC for qemu v4 2/2] virtio_balloon: Add dcvq to deflate
 continuous pages
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Hui Zhu <teawater@gmail.com>
Cc: david@redhat.com, jasowang@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, Hui Zhu <teawaterz@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jul 16, 2020 at 10:41:55AM +0800, Hui Zhu wrote:
> This commit adds a vq dcvq to deflate continuous pages.
> When VIRTIO_BALLOON_F_CONT_PAGES is set, try to get continuous pages
> from icvq and use madvise MADV_WILLNEED with the pages.
> 
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>

This is arguably something to benchmark. Does guest benefit
from MADV_WILLNEED or loose performance?

> ---
>  hw/virtio/virtio-balloon.c         | 14 +++++++++-----
>  include/hw/virtio/virtio-balloon.h |  2 +-
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index d36a5c8..165adf7 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -138,7 +138,8 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
>  }
>  
>  static void balloon_deflate_page(VirtIOBalloon *balloon,
> -                                 MemoryRegion *mr, hwaddr mr_offset)
> +                                 MemoryRegion *mr, hwaddr mr_offset,
> +                                 size_t size)
>  {
>      void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
>      ram_addr_t rb_offset;
> @@ -153,10 +154,11 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
>      rb_page_size = qemu_ram_pagesize(rb);
>  
>      host_addr = (void *)((uintptr_t)addr & ~(rb_page_size - 1));
> +    size &= ~(rb_page_size - 1);
>  
>      /* When a page is deflated, we hint the whole host page it lives
>       * on, since we can't do anything smaller */
> -    ret = qemu_madvise(host_addr, rb_page_size, QEMU_MADV_WILLNEED);
> +    ret = qemu_madvise(host_addr, size, QEMU_MADV_WILLNEED);
>      if (ret != 0) {
>          warn_report("Couldn't MADV_WILLNEED on balloon deflate: %s",
>                      strerror(errno));
> @@ -354,7 +356,7 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>              pa = (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
>              offset += 4;
>  
> -            if (vq == s->icvq) {
> +            if (vq == s->icvq || vq == s->dcvq) {
>                  uint32_t psize_ptr;
>                  if (iov_to_buf(elem->out_sg, elem->out_num, offset, &psize_ptr, 4) != 4) {
>                      break;
> @@ -383,8 +385,9 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>                      balloon_inflate_page(s, section.mr,
>                                           section.offset_within_region,
>                                           psize, &pbp);
> -                } else if (vq == s->dvq) {
> -                    balloon_deflate_page(s, section.mr, section.offset_within_region);
> +                } else if (vq == s->dvq || vq == s->dcvq) {
> +                    balloon_deflate_page(s, section.mr, section.offset_within_region,
> +                                         psize);
>                  } else {
>                      g_assert_not_reached();
>                  }
> @@ -838,6 +841,7 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>  
>      if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_CONT_PAGES)) {
>          s->icvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
> +        s->dcvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
>      }
>  
>      reset_stats(s);
> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
> index 6a2514d..848a7fb 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -42,7 +42,7 @@ enum virtio_balloon_free_page_report_status {
>  
>  typedef struct VirtIOBalloon {
>      VirtIODevice parent_obj;
> -    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq;
> +    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq, *dcvq;
>      uint32_t free_page_report_status;
>      uint32_t num_pages;
>      uint32_t actual;
> -- 
> 2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

