Return-Path: virtio-dev-return-4201-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 918DF5818F45
	for <virtio-dev@lists.oasis-open.org>; Wed, 30 May 2018 05:29:55 -0700 (PDT)
Date: Wed, 30 May 2018 13:29:40 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180530122940.GI14623@stefanha-x1.localdomain>
References: <20180530085521.26583-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cf0hFtnykp6aONGL"
Content-Disposition: inline
In-Reply-To: <20180530085521.26583-1-tiwei.bie@intel.com>
Subject: Re: [virtio-dev] [PATCH] virtio_pci: support enabling VFs
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, bhelgaas@google.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org, dan.daly@intel.com, mark.d.rustad@intel.com, alexander.h.duyck@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--cf0hFtnykp6aONGL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 30, 2018 at 04:55:21PM +0800, Tiwei Bie wrote:
> There is a new feature bit allocated in virtio spec to
> support SR-IOV (Single Root I/O Virtualization):
>=20
> https://github.com/oasis-tcs/virtio-spec/issues/11
>=20
> This patch enables the support for this feature bit in
> virtio driver.
>=20
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
> This patch depends on below proposal:
> https://lists.oasis-open.org/archives/virtio-dev/201805/msg00154.html
>=20
> This patch depends on below patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=
=3Dpci/virtualization&id=3D8effc395c2097e258fcedfc02ed4a66d45fb4238
>=20
>  drivers/virtio/virtio_pci_common.c | 20 ++++++++++++++++++++
>  drivers/virtio/virtio_pci_modern.c | 14 ++++++++++++++
>  include/uapi/linux/virtio_config.h |  7 ++++++-
>  3 files changed, 40 insertions(+), 1 deletion(-)

Looks good and matches the virtio spec change, but I'm not familiar with
PCI SR-IOV details, so not a full Reviewed-by.

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--cf0hFtnykp6aONGL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbDpk0AAoJEJykq7OBq3PI/a8IAMXdX7W1thOJsCpPYJN/TuyS
wPDyYhx5+Xs35iJreLG2AIQ73SnLOgfdz/OGzHhpe+yAbH3P+JyWjmAPCXXVHDwu
S01KRyn8xp60ZYqGhAxbCnmynOLGZS69h5PhnQgiQmr85+B/7O2k+6M6RHTKGE0k
HwcB8kIid3ixIxjMlH9MiC8GKL5H/VWQ/nCwMTl1YRRvzb2e/9vB+JdyJo/+S/Ni
/YAyP2hYSkbxRaKJM/GPuDkWt5oDsnfGFWyxlihwccTlI7e3eA2fIDxLz+9bIHO6
NzhcNg/4WC28wenhr+F+jeP8NKtIKnwh+vDs1GSKXa94mj/nvHF3z7Ypcya8PdQ=
=E2BM
-----END PGP SIGNATURE-----

--cf0hFtnykp6aONGL--
