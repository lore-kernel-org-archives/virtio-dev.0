Return-Path: virtio-dev-return-7327-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EBE2B985F08
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 May 2020 16:37:24 +0000 (UTC)
References: <1589276501-16026-1-git-send-email-teawater@gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0e7c29be-dd2c-dd95-6f2e-a009c530ffb1@redhat.com>
Date: Wed, 13 May 2020 18:37:09 +0200
MIME-Version: 1.0
In-Reply-To: <1589276501-16026-1-git-send-email-teawater@gmail.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC v3 for QEMU] virtio-balloon: Add option cont-pages to set
 VIRTIO_BALLOON_VQ_INFLATE_CONT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Hui Zhu <teawater@gmail.com>, mst@redhat.com, jasowang@redhat.com, akpm@linux-foundation.org, xdeguillard@vmware.com, namit@vmware.com, gregkh@linuxfoundation.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: wei.guo.simon@linux.alibaba.com, qixuan.wu@linux.alibaba.com, Hui Zhu <teawaterz@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 12.05.20 11:41, Hui Zhu wrote:

This description needs an overhaul, it's hard to parse.

> If the guest kernel has many fragmentation pages, use virtio_balloon
> will split THP of QEMU when it calls MADV_DONTNEED madvise to release
> the balloon pages.

This is very unclear and confusing. You will *always* split THPs when
inflating 4k pages and there are THPs around. This is completely
independent of any fragmentation in the guest. The thing you are trying
to achieve here is trying to *minimize* the number of split THPs in the
hypervisor *after* the balloon was completely inflated.

> Set option cont-pages to on will open flags VIRTIO_BALLOON_VQ_INFLATE_CON=
T
> and set default continuous pages order to THP order.

... and what you implement here is very x86 specific, hard-coding the
"9" as THP order.

"Set option cont-pages to on" -> 'Once the feature is enabled via
"cont-pages=3Don"'
"open flags" -> "unlock VIRTIO_BALLOON_VQ_INFLATE_CONT".


> Then It will get continuous pages PFN that its order is current_pages_ord=
er
> from VQ ivq use use madvise MADV_DONTNEED release the page.

I fail to parse this sentence. I assume something like

"current_pages_order is set by the guest and configures the size of the
pages communicated via the inflate/deflate queue by the guest. It
defaults to 0, which corresponds to the legacy handling without
VIRTIO_BALLOON_VQ_INFLATE_CONT - 4k pages."

Why is "max_pages_order" necessary *at all*? You never check against that.

I have to say, I really dislike that interface. I would much rather
prefer new inflate/deflate queues that eat variable sizes (not orders!)
- similar to the free page reporting interface - and skip things like
the pbp. Not sure if this interface is really what MST asked for.

> This will handle the THP split issue.
>=20
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
> ---
>  hw/virtio/virtio-balloon.c                      | 77 +++++++++++++++++--=
------
>  include/hw/virtio/virtio-balloon.h              |  2 +
>  include/standard-headers/linux/virtio_balloon.h |  5 ++
>  3 files changed, 60 insertions(+), 24 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index a4729f7..84d47d3 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -34,6 +34,7 @@
>  #include "hw/virtio/virtio-access.h"
> =20
>  #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
> +#define CONT_PAGES_ORDER   9
> =20
>  typedef struct PartiallyBalloonedPage {
>      ram_addr_t base_gpa;
> @@ -72,6 +73,8 @@ static void balloon_inflate_page(VirtIOBalloon *balloon=
,
>      RAMBlock *rb;
>      size_t rb_page_size;
>      int subpages;
> +    size_t inflate_size =3D BALLOON_PAGE_SIZE << balloon->current_pages_=
order;
> +    int pages_num;

reverse christmas tree please. squash same types into a single line if
possible.

> =20
>      /* XXX is there a better way to get to the RAMBlock than via a
>       * host address? */
> @@ -81,7 +84,7 @@ static void balloon_inflate_page(VirtIOBalloon *balloon=
,
>      if (rb_page_size =3D=3D BALLOON_PAGE_SIZE) {
>          /* Easy case */
> =20
> -        ram_block_discard_range(rb, rb_offset, rb_page_size);
> +        ram_block_discard_range(rb, rb_offset, inflate_size);
>          /* We ignore errors from ram_block_discard_range(), because it
>           * has already reported them, and failing to discard a balloon
>           * page is not fatal */
> @@ -99,32 +102,38 @@ static void balloon_inflate_page(VirtIOBalloon *ball=
oon,
> =20
>      rb_aligned_offset =3D QEMU_ALIGN_DOWN(rb_offset, rb_page_size);
>      subpages =3D rb_page_size / BALLOON_PAGE_SIZE;
> -    base_gpa =3D memory_region_get_ram_addr(mr) + mr_offset -
> -               (rb_offset - rb_aligned_offset);
> =20
> -    if (pbp->bitmap && !virtio_balloon_pbp_matches(pbp, base_gpa)) {
> -        /* We've partially ballooned part of a host page, but now
> -         * we're trying to balloon part of a different one.  Too hard,
> -         * give up on the old partial page */
> -        virtio_balloon_pbp_free(pbp);
> -    }
> +    for (pages_num =3D inflate_size / BALLOON_PAGE_SIZE;
> +         pages_num > 0; pages_num--) {
> +        base_gpa =3D memory_region_get_ram_addr(mr) + mr_offset -
> +                   (rb_offset - rb_aligned_offset);
> =20
> -    if (!pbp->bitmap) {
> -        virtio_balloon_pbp_alloc(pbp, base_gpa, subpages);
> -    }
> +        if (pbp->bitmap && !virtio_balloon_pbp_matches(pbp, base_gpa)) {
> +            /* We've partially ballooned part of a host page, but now
> +            * we're trying to balloon part of a different one.  Too hard=
,
> +            * give up on the old partial page */
> +            virtio_balloon_pbp_free(pbp);
> +        }
> =20
> -    set_bit((rb_offset - rb_aligned_offset) / BALLOON_PAGE_SIZE,
> -            pbp->bitmap);
> +        if (!pbp->bitmap) {
> +            virtio_balloon_pbp_alloc(pbp, base_gpa, subpages);
> +        }
> =20
> -    if (bitmap_full(pbp->bitmap, subpages)) {
> -        /* We've accumulated a full host page, we can actually discard
> -         * it now */
> +        set_bit((rb_offset - rb_aligned_offset) / BALLOON_PAGE_SIZE,
> +                pbp->bitmap);
> =20
> -        ram_block_discard_range(rb, rb_aligned_offset, rb_page_size);
> -        /* We ignore errors from ram_block_discard_range(), because it
> -         * has already reported them, and failing to discard a balloon
> -         * page is not fatal */
> -        virtio_balloon_pbp_free(pbp);
> +        if (bitmap_full(pbp->bitmap, subpages)) {
> +            /* We've accumulated a full host page, we can actually disca=
rd
> +            * it now */
> +
> +            ram_block_discard_range(rb, rb_aligned_offset, rb_page_size)=
;
> +            /* We ignore errors from ram_block_discard_range(), because =
it
> +            * has already reported them, and failing to discard a balloo=
n
> +            * page is not fatal */
> +            virtio_balloon_pbp_free(pbp);
> +        }
> +
> +        mr_offset +=3D BALLOON_PAGE_SIZE;
>      }
>  }
> =20
> @@ -345,7 +354,7 @@ static void virtio_balloon_handle_output(VirtIODevice=
 *vdev, VirtQueue *vq)
>              offset +=3D 4;
> =20
>              section =3D memory_region_find(get_system_memory(), pa,
> -                                         BALLOON_PAGE_SIZE);
> +                                BALLOON_PAGE_SIZE << s->current_pages_or=
der);
>              if (!section.mr) {
>                  trace_virtio_balloon_bad_addr(pa);
>                  continue;
> @@ -618,9 +627,12 @@ static size_t virtio_balloon_config_size(VirtIOBallo=
on *s)
>      if (s->qemu_4_0_config_size) {
>          return sizeof(struct virtio_balloon_config);
>      }
> -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
> +    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_CONT_PAGES=
)) {
>          return sizeof(struct virtio_balloon_config);
>      }
> +    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
> +        return offsetof(struct virtio_balloon_config, current_pages_orde=
r);
> +    }
>      if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>          return offsetof(struct virtio_balloon_config, poison_val);
>      }
> @@ -646,6 +658,11 @@ static void virtio_balloon_get_config(VirtIODevice *=
vdev, uint8_t *config_data)
>                         cpu_to_le32(VIRTIO_BALLOON_CMD_ID_DONE);
>      }
> =20
> +    if (virtio_has_feature(dev->host_features, VIRTIO_BALLOON_F_CONT_PAG=
ES)) {
> +        config.max_pages_order =3D cpu_to_le32(CONT_PAGES_ORDER);
> +        config.current_pages_order =3D cpu_to_le32(dev->current_pages_or=
der);
> +    }
> +
>      trace_virtio_balloon_get_config(config.num_pages, config.actual);
>      memcpy(config_data, &config, virtio_balloon_config_size(dev));
>  }
> @@ -693,6 +710,9 @@ static void virtio_balloon_set_config(VirtIODevice *v=
dev,
> =20
>      memcpy(&config, config_data, virtio_balloon_config_size(dev));
>      dev->actual =3D le32_to_cpu(config.actual);
> +    if (virtio_has_feature(dev->host_features, VIRTIO_BALLOON_F_CONT_PAG=
ES)) {
> +        dev->current_pages_order =3D le32_to_cpu(config.current_pages_or=
der);
> +    }
>      if (dev->actual !=3D oldactual) {
>          qapi_event_send_balloon_change(vm_ram_size -
>                          ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_=
SHIFT));
> @@ -816,6 +836,13 @@ static void virtio_balloon_device_realize(DeviceStat=
e *dev, Error **errp)
>              virtio_error(vdev, "iothread is missing");
>          }
>      }
> +
> +    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_CONT_PAGES=
)) {
> +        s->current_pages_order =3D CONT_PAGES_ORDER;
> +    } else {
> +        s->current_pages_order =3D 0;
> +    }
> +
>      reset_stats(s);
>  }
> =20
> @@ -916,6 +943,8 @@ static Property virtio_balloon_properties[] =3D {
>                      VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
>      DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
>                      VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
> +    DEFINE_PROP_BIT("cont-pages", VirtIOBalloon, host_features,
> +                    VIRTIO_BALLOON_F_CONT_PAGES, false),
>      /* QEMU 4.0 accidentally changed the config size even when free-page=
-hint
>       * is disabled, resulting in QEMU 3.1 migration incompatibility.  Th=
is
>       * property retains this quirk for QEMU 4.1 machine types.
> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virti=
o-balloon.h
> index d1c968d..e0dce0d 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -70,6 +70,8 @@ typedef struct VirtIOBalloon {
>      uint32_t host_features;
> =20
>      bool qemu_4_0_config_size;
> +
> +    uint32_t current_pages_order;
>  } VirtIOBalloon;
> =20
>  #endif
> diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/st=
andard-headers/linux/virtio_balloon.h
> index 9375ca2..b5386ce 100644
> --- a/include/standard-headers/linux/virtio_balloon.h
> +++ b/include/standard-headers/linux/virtio_balloon.h
> @@ -36,6 +36,7 @@
>  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM=092 /* Deflate balloon on OOM */
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT=093 /* VQ to report free pages *=
/
>  #define VIRTIO_BALLOON_F_PAGE_POISON=094 /* Guest is using page poisonin=
g */
> +#define VIRTIO_BALLOON_F_CONT_PAGES=096 /* VQ to report continuous pages=
 */
> =20
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> @@ -51,6 +52,10 @@ struct virtio_balloon_config {
>  =09uint32_t free_page_report_cmd_id;
>  =09/* Stores PAGE_POISON if page poisoning is in use */
>  =09uint32_t poison_val;
> +=09/* Max pages order if VIRTIO_BALLOON_F_CONT_PAGES is set */
> +=09uint32_t max_pages_order;
> +=09/* Current pages order if VIRTIO_BALLOON_F_CONT_PAGES is set */
> +=09uint32_t current_pages_order;
>  };
> =20
>  #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
>=20


--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

