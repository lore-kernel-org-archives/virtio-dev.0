Return-Path: virtio-dev-return-7063-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 53407985F90
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Apr 2020 08:08:58 +0000 (UTC)
References: <20200410033729.24738.22879.stgit@localhost.localdomain>
 <20200410034129.24738.36022.stgit@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b6f97131-89dc-064a-5b87-2bf68437176d@redhat.com>
Date: Wed, 15 Apr 2020 10:08:46 +0200
MIME-Version: 1.0
In-Reply-To: <20200410034129.24738.36022.stgit@localhost.localdomain>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v19 QEMU 1/4] virtio-balloon: Implement support for page
 poison tracking feature
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>, pbonzini@redhat.com, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 10.04.20 05:41, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>=20
> We need to make certain to advertise support for page poison tracking if
> we want to actually get data on if the guest will be poisoning pages. So
> if free page hinting is active we should add page poisoning support and
> let the guest disable it if it isn't using it.
>=20
> Page poisoning will result in a page being dirtied on free. As such we
> cannot really avoid having to copy the page at least one more time since
> we will need to write the poison value to the destination. As such we can
> just ignore free page hinting if page poisoning is enabled as it will
> actually reduce the work we have to do.
>=20
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  hw/virtio/virtio-balloon.c         |   26 ++++++++++++++++++++++----
>  include/hw/virtio/virtio-balloon.h |    1 +
>  2 files changed, 23 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index a4729f7fc930..1c6d36a29a04 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -531,6 +531,15 @@ static void virtio_balloon_free_page_start(VirtIOBal=
loon *s)
>          return;
>      }
> =20
> +    /*
> +     * If page poisoning is enabled then we probably shouldn't bother wi=
th
> +     * the hinting since the poisoning will dirty the page and invalidat=
e
> +     * the work we are doing anyway.
> +     */
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {

Why not check for the poison value instead? (as you do in patch #3) ?

> +        return;
> +    }
> +
>      if (s->free_page_report_cmd_id =3D=3D UINT_MAX) {
>          s->free_page_report_cmd_id =3D
>                         VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;

We should rename all "free_page_report" stuff we can to
"free_page_hint"/"free_page_hinting" to avoid confusion (e.g., on my
side :) ) before adding free page reporting .

(looking at the virtio-balloon linux header, it's also confusing but
we're stuck with that - maybe we should add better comments)


> @@ -618,12 +627,10 @@ static size_t virtio_balloon_config_size(VirtIOBall=
oon *s)
>      if (s->qemu_4_0_config_size) {
>          return sizeof(struct virtio_balloon_config);
>      }
> -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
> +    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON) ||
> +        virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>          return sizeof(struct virtio_balloon_config);
>      }
> -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> -        return offsetof(struct virtio_balloon_config, poison_val);
> -    }

I am not sure this change is completely sane. Why is that necessary at all?

>      return offsetof(struct virtio_balloon_config, free_page_report_cmd_i=
d);
>  }
> =20
> @@ -634,6 +641,7 @@ static void virtio_balloon_get_config(VirtIODevice *v=
dev, uint8_t *config_data)
> =20
>      config.num_pages =3D cpu_to_le32(dev->num_pages);
>      config.actual =3D cpu_to_le32(dev->actual);
> +    config.poison_val =3D cpu_to_le32(dev->poison_val);
> =20
>      if (dev->free_page_report_status =3D=3D FREE_PAGE_REPORT_S_REQUESTED=
) {
>          config.free_page_report_cmd_id =3D
> @@ -697,6 +705,9 @@ static void virtio_balloon_set_config(VirtIODevice *v=
dev,
>          qapi_event_send_balloon_change(vm_ram_size -
>                          ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_=
SHIFT));
>      }
> +    dev->poison_val =3D virtio_vdev_has_feature(vdev,
> +                                              VIRTIO_BALLOON_F_PAGE_POIS=
ON) ?
> +                      le32_to_cpu(config.poison_val) : 0;

Can we just do a


dev->poison_val =3D 0;
if (virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
=09dev->poison_val =3D le32_to_cpu(config.poison_val);
}

instead?


>      trace_virtio_balloon_set_config(dev->actual, oldactual);
>  }
> =20
> @@ -706,6 +717,9 @@ static uint64_t virtio_balloon_get_features(VirtIODev=
ice *vdev, uint64_t f,
>      VirtIOBalloon *dev =3D VIRTIO_BALLOON(vdev);
>      f |=3D dev->host_features;
>      virtio_add_feature(&f, VIRTIO_BALLOON_F_STATS_VQ);
> +    if (virtio_has_feature(f, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> +        virtio_add_feature(&f, VIRTIO_BALLOON_F_PAGE_POISON);
> +    }
> =20
>      return f;
>  }
> @@ -854,6 +868,8 @@ static void virtio_balloon_device_reset(VirtIODevice =
*vdev)
>          g_free(s->stats_vq_elem);
>          s->stats_vq_elem =3D NULL;
>      }
> +
> +    s->poison_val =3D 0;
>  }
> =20
>  static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status=
)
> @@ -916,6 +932,8 @@ static Property virtio_balloon_properties[] =3D {
>                      VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
>      DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
>                      VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
> +    DEFINE_PROP_BIT("x-page-poison", VirtIOBalloon, host_features,
> +                    VIRTIO_BALLOON_F_PAGE_POISON, false),

Just curious, why an x- feature?


--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

