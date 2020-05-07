Return-Path: virtio-dev-return-7255-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B72C4985E09
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 May 2020 10:47:43 +0000 (UTC)
Date: Thu, 7 May 2020 06:47:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200507064709-mutt-send-email-mst@kernel.org>
References: <20200507103119.11219-1-david@redhat.com>
 <20200507103119.11219-11-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200507103119.11219-11-david@redhat.com>
Subject: [virtio-dev] Re: [PATCH v3 10/15] MAINTAINERS: Add myself as virtio-mem maintainer
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, May 07, 2020 at 12:31:14PM +0200, David Hildenbrand wrote:
> Let's make sure patches/bug reports find the right person.
>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Make this patch 2 in the series, or even squash into patch 1.

> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4d43ea5468b5..ad2b34f4dd66 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18037,6 +18037,13 @@ S:=09Maintained
>  F:=09drivers/iommu/virtio-iommu.c
>  F:=09include/uapi/linux/virtio_iommu.h
> =20
> +VIRTIO MEM DRIVER
> +M:=09David Hildenbrand <david@redhat.com>
> +L:=09virtualization@lists.linux-foundation.org
> +S:=09Maintained
> +F:=09drivers/virtio/virtio_mem.c
> +F:=09include/uapi/linux/virtio_mem.h
> +
>  VIRTUAL BOX GUEST DEVICE DRIVER
>  M:=09Hans de Goede <hdegoede@redhat.com>
>  M:=09Arnd Bergmann <arnd@arndb.de>
> --=20
> 2.25.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

