Return-Path: virtio-dev-return-7359-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8A115985F3B
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 May 2020 17:57:48 +0000 (UTC)
MIME-Version: 1.0
References: <20200508212719.26071.94248.stgit@localhost.localdomain> <20200508213010.26071.6318.stgit@localhost.localdomain>
In-Reply-To: <20200508213010.26071.6318.stgit@localhost.localdomain>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 18 May 2020 10:57:35 -0700
Message-ID: <CAKgT0UcT5yhv-yvTZDvgX_uBjRz3oKAqBpc4y899b1xdAQZ6aw@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v24 QEMU 3/3] virtio-balloon: Provide an interface for
 free page reporting
Content-Type: text/plain; charset="UTF-8"
To: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, May 8, 2020 at 2:30 PM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>
> Add support for free page reporting. The idea is to function very similar
> to how the balloon works in that we basically end up madvising the page as
> not being used. However we don't really need to bother with any deflate
> type logic since the page will be faulted back into the guest when it is
> read or written to.
>
> This provides a new way of letting the guest proactively report free
> pages to the hypervisor, so the hypervisor can reuse them. In contrast to
> inflate/deflate that is triggered via the hypervisor explicitly.
>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>


I just realized that the patch below added the code to add the
reporting_vq but I never cleaned it up. I will submit a v25 in the
next couple of days that contains a fix for that.

> ---
>  hw/virtio/virtio-balloon.c         |   69 ++++++++++++++++++++++++++++++++++++
>  include/hw/virtio/virtio-balloon.h |    2 +
>  2 files changed, 70 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 1666132a24c1..53abba290274 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -321,6 +321,67 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
>      balloon_stats_change_timer(s, 0);
>  }
>
> +static void virtio_balloon_handle_report(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
> +    VirtQueueElement *elem;
> +
> +    while ((elem = virtqueue_pop(vq, sizeof(VirtQueueElement)))) {
> +        unsigned int i;
> +
> +        /*
> +         * When we discard the page it has the effect of removing the page
> +         * from the hypervisor itself and causing it to be zeroed when it
> +         * is returned to us. So we must not discard the page if it is
> +         * accessible by another device or process, or if the guest is
> +         * expecting it to retain a non-zero value.
> +         */
> +        if (qemu_balloon_is_inhibited() || dev->poison_val) {
> +            goto skip_element;
> +        }
> +
> +        for (i = 0; i < elem->in_num; i++) {
> +            void *addr = elem->in_sg[i].iov_base;
> +            size_t size = elem->in_sg[i].iov_len;
> +            ram_addr_t ram_offset;
> +            RAMBlock *rb;
> +
> +            /*
> +             * There is no need to check the memory section to see if
> +             * it is ram/readonly/romd like there is for handle_output
> +             * below. If the region is not meant to be written to then
> +             * address_space_map will have allocated a bounce buffer
> +             * and it will be freed in address_space_unmap and trigger
> +             * and unassigned_mem_write before failing to copy over the
> +             * buffer. If more than one bad descriptor is provided it
> +             * will return NULL after the first bounce buffer and fail
> +             * to map any resources.
> +             */
> +            rb = qemu_ram_block_from_host(addr, false, &ram_offset);
> +            if (!rb) {
> +                trace_virtio_balloon_bad_addr(elem->in_addr[i]);
> +                continue;
> +            }
> +
> +            /*
> +             * For now we will simply ignore unaligned memory regions, or
> +             * regions that overrun the end of the RAMBlock.
> +             */
> +            if (!QEMU_IS_ALIGNED(ram_offset | size, qemu_ram_pagesize(rb)) ||
> +                (ram_offset + size) > qemu_ram_get_used_length(rb)) {
> +                continue;
> +            }
> +
> +            ram_block_discard_range(rb, ram_offset, size);
> +        }
> +
> +skip_element:
> +        virtqueue_push(vq, elem, 0);
> +        virtio_notify(vdev, vq);
> +        g_free(elem);
> +    }
> +}
> +
>  static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>  {
>      VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
> @@ -841,6 +902,12 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>              virtio_error(vdev, "iothread is missing");
>          }
>      }
> +
> +    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)) {
> +        s->reporting_vq = virtio_add_queue(vdev, 32,
> +                                           virtio_balloon_handle_report);
> +    }
> +
>      reset_stats(s);
>  }
>
> @@ -945,6 +1012,8 @@ static Property virtio_balloon_properties[] = {
>                      VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
>      DEFINE_PROP_BIT("page-poison", VirtIOBalloon, host_features,
>                      VIRTIO_BALLOON_F_PAGE_POISON, true),
> +    DEFINE_PROP_BIT("free-page-reporting", VirtIOBalloon, host_features,
> +                    VIRTIO_BALLOON_F_REPORTING, false),
>      /* QEMU 4.0 accidentally changed the config size even when free-page-hint
>       * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
>       * property retains this quirk for QEMU 4.1 machine types.
> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
> index 3ca2a78e1aca..28fd2b396087 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -42,7 +42,7 @@ enum virtio_balloon_free_page_hint_status {
>
>  typedef struct VirtIOBalloon {
>      VirtIODevice parent_obj;
> -    VirtQueue *ivq, *dvq, *svq, *free_page_vq;
> +    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *reporting_vq;
>      uint32_t free_page_hint_status;
>      uint32_t num_pages;
>      uint32_t actual;
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

