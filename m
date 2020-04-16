Return-Path: virtio-dev-return-7092-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AF8CD986074
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Apr 2020 22:13:23 +0000 (UTC)
Date: Thu, 16 Apr 2020 18:13:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200416180845-mutt-send-email-mst@kernel.org>
References: <20200416192809.8763.19308.stgit@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200416192809.8763.19308.stgit@localhost.localdomain>
Subject: [virtio-dev] Re: [PATCH] virtio-balloon: Disable free page hinting/reporting if
 page poison is disabled
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: jasowang@redhat.com, david@redhat.com, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Apr 16, 2020 at 12:30:38PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>=20
> If we have free page hinting or page reporting enabled we should disable =
it
> if the pages are poisoned or initialized on free and we cannot notify the
> hypervisor.
>=20
> Fixes: 5d757c8d518d ("virtio-balloon: add support for providing free page=
 reports to host")
>=20
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>


Why not put this logic in the hypervisor?
We don't know what hypervisor uses the hints for.
Yes you can not just drop them but you can maybe do
other things such as MADV_SOFT_OFFLINE.

Finally, VIRTIO_BALLOON_F_FREE_PAGE_HINT does nothing
at all unless guest gets the command from hypervisor,
so there isn't even any overhead.



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


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

