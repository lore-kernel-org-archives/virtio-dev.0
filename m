Return-Path: virtio-dev-return-7100-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C6C42986076
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Apr 2020 07:46:39 +0000 (UTC)
References: <20200416192809.8763.19308.stgit@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f85362c1-8e23-36f9-eca7-7a1968b6118b@redhat.com>
Date: Fri, 17 Apr 2020 09:46:28 +0200
MIME-Version: 1.0
In-Reply-To: <20200416192809.8763.19308.stgit@localhost.localdomain>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH] virtio-balloon: Disable free page hinting/reporting if
 page poison is disabled
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>, jasowang@redhat.com, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 16.04.20 21:30, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>=20
> If we have free page hinting or page reporting enabled we should disable =
it
> if the pages are poisoned or initialized on free and we cannot notify the
> hypervisor.
>=20

Please split that up into an actual fix (Fixes:) for free page reporting
and an optimization for free page hinting. Also, please document why we
are doing stuff.

Regarding the free page reporting part, I propose something like this inste=
ad


diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloo=
n.c
index 0ef16566c3f3..9b1e56da1e29 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1107,6 +1107,20 @@ static int virtballoon_restore(struct virtio_device =
*vdev)
=20
 static int virtballoon_validate(struct virtio_device *vdev)
 {
+       /*
+        * Free page reporting relies on the fact that any access after
+        * pages were reported (esp. from the buddy) will result in them ge=
tting
+        * deflated automatically. In case we care about the page content, =
we
+        * need support from the hypervisor to provide us with the same pag=
e
+        * (poisoned) content we originally had in the page. Without
+        * VIRTIO_BALLOON_F_PAGE_POISON, we will receive either the origina=
l
+        * page or a zeroed page.
+        */
+       if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON) &&
+           !IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY) &&
+           page_poisoning_enabled())
+               __virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
+
        /* Tell the host whether we care about poisoned pages. */
        if (!want_init_on_free() &&
            (IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY) ||


> Fixes: 5d757c8d518d ("virtio-balloon: add support for providing free page=
 reports to host")
>=20
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  drivers/virtio/virtio_balloon.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index 95d9c2f0a7be..08bc86a6e468 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -1110,8 +1110,12 @@ static int virtballoon_validate(struct virtio_devi=
ce *vdev)
>  =09/* Tell the host whether we care about poisoned pages. */
>  =09if (!want_init_on_free() &&
>  =09    (IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY) ||
> -=09     !page_poisoning_enabled()))
> +=09     !page_poisoning_enabled())) {
>  =09=09__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
> +=09} else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
> +=09=09__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT);
> +=09=09__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
> +=09}
> =20
>  =09__virtio_clear_bit(vdev, VIRTIO_F_IOMMU_PLATFORM);
>  =09return 0;
>=20


--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

