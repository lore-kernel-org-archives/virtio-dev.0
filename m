Return-Path: virtio-dev-return-7156-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B454C9860A0
	for <virtio-dev@lists.oasis-open.org>; Fri, 24 Apr 2020 11:20:25 +0000 (UTC)
References: <20200422181649.12258.37077.stgit@localhost.localdomain>
 <20200422182127.12258.26300.stgit@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a2183a2f-e10d-1e19-52d9-a9cd71fa2655@redhat.com>
Date: Fri, 24 Apr 2020 13:20:16 +0200
MIME-Version: 1.0
In-Reply-To: <20200422182127.12258.26300.stgit@localhost.localdomain>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v21 QEMU 5/5] virtio-balloon: Provide an interface for
 free page reporting
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 22.04.20 20:21, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>=20
> Add support for free page reporting. The idea is to function very similar
> to how the balloon works in that we basically end up madvising the page a=
s
> not being used. However we don't really need to bother with any deflate
> type logic since the page will be faulted back into the guest when it is
> read or written to.
>=20
> This provides a new way of letting the guest proactively report free
> pages to the hypervisor, so the hypervisor can reuse them. In contrast to
> inflate/deflate that is triggered via the hypervisor explicitly.
>=20
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  hw/virtio/virtio-balloon.c         |   70 ++++++++++++++++++++++++++++++=
++++++
>  include/hw/virtio/virtio-balloon.h |    2 +
>  2 files changed, 71 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 5effc8b4653b..b473ff7f4b88 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -321,6 +321,60 @@ static void balloon_stats_set_poll_interval(Object *=
obj, Visitor *v,
>      balloon_stats_change_timer(s, 0);
>  }
> =20
> +static void virtio_balloon_handle_report(VirtIODevice *vdev, VirtQueue *=
vq)
> +{
> +    VirtIOBalloon *dev =3D VIRTIO_BALLOON(vdev);
> +    VirtQueueElement *elem;
> +
> +    while ((elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement)))) {
> +        unsigned int i;
> +

Maybe add a comment like

/*
 * As discarded pages will be zero when re-accessed, all pages either
 * have the old value, or were zeroed out. In case the guest expects
 * another value, make sure to never discard.
 */

Whatever you think is best.

> +        if (qemu_balloon_is_inhibited() || dev->poison_val) {
> +            goto skip_element;
> +        }
> +
> +        for (i =3D 0; i < elem->in_num; i++) {
> +            void *addr =3D elem->in_sg[i].iov_base;
> +            size_t size =3D elem->in_sg[i].iov_len;
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
> +            rb =3D qemu_ram_block_from_host(addr, false, &ram_offset);
> +            if (!rb) {
> +                trace_virtio_balloon_bad_addr(elem->in_addr[i]);
> +                continue;
> +            }
> +
> +            /*
> +             * For now we will simply ignore unaligned memory regions, o=
r
> +             * regions that overrun the end of the RAMBlock.
> +             */
> +            if (!QEMU_IS_ALIGNED(ram_offset | size, qemu_ram_pagesize(rb=
)) ||
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
>  static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *=
vq)
>  {
>      VirtIOBalloon *s =3D VIRTIO_BALLOON(vdev);
> @@ -782,6 +836,16 @@ static void virtio_balloon_device_realize(DeviceStat=
e *dev, Error **errp)
>      VirtIOBalloon *s =3D VIRTIO_BALLOON(dev);
>      int ret;
> =20
> +    /*
> +     * Page reporting is dependant on page poison to make sure we can
> +     * report a page without changing the state of the internal data.
> +     * We need to set the flag before we call virtio_init as it will
> +     * affect the config size of the vdev.
> +     */
> +    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)=
) {
> +        s->host_features |=3D 1 << VIRTIO_BALLOON_F_PAGE_POISON;
> +    }
> +

As discussed, this hunk would go away. With that, this patch is really
minimal, which is good :)

>      virtio_init(vdev, "virtio-balloon", VIRTIO_ID_BALLOON,
>                  virtio_balloon_config_size(s));
> =20
> @@ -798,6 +862,10 @@ static void virtio_balloon_device_realize(DeviceStat=
e *dev, Error **errp)
>      s->dvq =3D virtio_add_queue(vdev, 128, virtio_balloon_handle_output)=
;
>      s->svq =3D virtio_add_queue(vdev, 128, virtio_balloon_receive_stats)=
;
> =20
> +    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)=
) {
> +        s->rvq =3D virtio_add_queue(vdev, 32, virtio_balloon_handle_repo=
rt);
> +    }
> +
>      if (virtio_has_feature(s->host_features,
>                             VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>          s->free_page_vq =3D virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
> @@ -923,6 +991,8 @@ static Property virtio_balloon_properties[] =3D {
>                      VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
>      DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
>                      VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
> +    DEFINE_PROP_BIT("free-page-reporting", VirtIOBalloon, host_features,
> +                    VIRTIO_BALLOON_F_REPORTING, true),

I think you'll have to similarly disable it via compat machines if you
want to default enable. Otherwise, backward migration would be broken.

Also, I do wonder if we want to default-enable it. It can still have a
negative performance impact and some people might not want that.

Apart from that, looks good to me. Nothing else we have to migrate AFAIKs.

--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

