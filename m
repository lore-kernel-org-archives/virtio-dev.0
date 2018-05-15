Return-Path: virtio-dev-return-4081-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 01372581809C
	for <virtio-dev@lists.oasis-open.org>; Tue, 15 May 2018 02:40:56 -0700 (PDT)
Date: Tue, 15 May 2018 10:40:44 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180515094044.GG14755@stefanha-x1.localdomain>
References: <20180510154126.4062-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GUPx2O/K0ibUojHx"
Content-Disposition: inline
In-Reply-To: <20180510154126.4062-1-tiwei.bie@intel.com>
Subject: Re: [virtio-dev] [PATCH v3] VIRTIO_F_IO_BARRIER: use I/O barriers in
 driver
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--GUPx2O/K0ibUojHx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 10, 2018 at 11:41:26PM +0800, Tiwei Bie wrote:
> There will be hardware virtio devices in the future, which
> require drivers to use the barriers suitable for I/O devices,
> compared with software virtio devices which just require
> drivers to use the barriers suitable for CPU cores.
>=20
> To fix the ordering issue for hardware virtio devices, add
> a new feature: VIRTIO_F_IO_BARRIER. When negotiated, driver
> will use the barriers suitable for I/O devices.
>=20
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2 -> v3:
> - Update the feature bits allocation (Stefan);
>=20
> v1 -> v2:
> - Rebase to the latest spec (MST);
> - Use a smaller textwidth (according to _vimrc);
>=20
> RFC -> v1:
> - Use plural (Stefan);
> - Add more details (Stefan);
>=20
>  content.tex | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)

Thanks for your patience!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--GUPx2O/K0ibUojHx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+qscAAoJEJykq7OBq3PINvMH/iefirz0EN0c00u/XSLgl/t1
xqXLtOXnRIKqR8Nd0Yh49EvuJD7c1S9sLFH1fyg1cuDEULGFbOEx3QvpqFkhnRtP
tDPVgWBMbsVd6v6iOkV8UvLxyMAsjYLAz2BNHdCEkd3+4oBPrG2LhqnCQc4WRFsQ
OMoLP/xMffyn/JoqGauYnYU4Jm8y05+flnUPbDlciS7V/EeB4fsvIaloyh1HRtQy
Vb8Kt3kuQ8MfblkRikkuNcefyDxfc6J03v1lRoqakQ6zpg5IBUVfAPCH/Di0bik1
x/8gjKh6vYzrEk9fis8OzqWlFqCh32BAQN12PAIBq+n09OHIgKs9Yq/EVpe2wJ4=
=fs0L
-----END PGP SIGNATURE-----

--GUPx2O/K0ibUojHx--
