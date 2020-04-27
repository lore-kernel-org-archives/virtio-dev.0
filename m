Return-Path: virtio-dev-return-7172-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC172985BA9
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Apr 2020 08:08:54 +0000 (UTC)
References: <20200424162103.6681.436.stgit@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Message-ID: <31bc73ea-5d33-a79d-5f30-dc91b85f9b63@redhat.com>
Date: Mon, 27 Apr 2020 10:08:41 +0200
MIME-Version: 1.0
In-Reply-To: <20200424162103.6681.436.stgit@localhost.localdomain>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v2] virtio-balloon: Disable free page reporting if page
 poison reporting is not enabled
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>, jasowang@redhat.com, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 24.04.20 18:24, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>=20
> We should disable free page reporting if page poisoning is enabled in the
> kernel but we cannot report it via the balloon interface. This way we can
> avoid the possibility of corrupting guest memory. Normally the page poiso=
n
> reporting feature should always be present when free page reporting is
> enabled on the hypervisor, however this allows us to correctly handle a
> case of the virtio-balloon device being possibly misconfigured.
>=20
> Fixes: 5d757c8d518d ("virtio-balloon: add support for providing free page=
 reports to host")
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>=20
> Changes since v1:
> Originally this patch also modified free page hinting, that has been remo=
ved.
> Updated patch title and description.
> Added a comment explaining reasoning for disabling free page reporting.
>=20
>  drivers/virtio/virtio_balloon.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index 51086a5afdd4..1f157d2f4952 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -1107,11 +1107,18 @@ static int virtballoon_restore(struct virtio_devi=
ce *vdev)
> =20
>  static int virtballoon_validate(struct virtio_device *vdev)
>  {
> -=09/* Tell the host whether we care about poisoned pages. */
> +=09/*
> +=09 * Inform the hypervisor that our pages are poisoned or
> +=09 * initialized. If we cannot do that then we should disable
> +=09 * page reporting as it could potentially change the contents
> +=09 * of our free pages.
> +=09 */
>  =09if (!want_init_on_free() &&
>  =09    (IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY) ||
>  =09     !page_poisoning_enabled()))
>  =09=09__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
> +=09else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
> +=09=09__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
> =20
>  =09__virtio_clear_bit(vdev, VIRTIO_F_IOMMU_PLATFORM);
>  =09return 0;
>=20

Did you see my feedback on v1?

https://www.spinics.net/lists/linux-virtualization/msg42783.html

In case of want_init_on_free(), we don't really need VIRTIO_BALLOON_F_PAGE_=
POISON.


--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

