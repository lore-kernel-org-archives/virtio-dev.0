Return-Path: virtio-dev-return-4059-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D11DC5818FAC
	for <virtio-dev@lists.oasis-open.org>; Thu, 10 May 2018 02:50:06 -0700 (PDT)
Date: Thu, 10 May 2018 10:49:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180510094951.GN1296@stefanha-x1.localdomain>
References: <20180504024436.13903-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CaPKgh3XHpq3rEUV"
Content-Disposition: inline
In-Reply-To: <20180504024436.13903-1-tiwei.bie@intel.com>
Subject: Re: [virtio-dev] [PATCH v2] VIRTIO_F_IO_BARRIER: use I/O barriers in
 driver
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--CaPKgh3XHpq3rEUV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 10:44:36AM +0800, Tiwei Bie wrote:
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
> ---
> v1 -> v2:
> - Rebase to the latest spec (MST);
> - Use a smaller textwidth (according to _vimrc);
>=20
> RFC -> v1:
> - Use plural (Stefan);
> - Add more details (Stefan);
>=20
>  content.tex | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--CaPKgh3XHpq3rEUV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9BW/AAoJEJykq7OBq3PI98kIAKFvjjlAqeYs3bAvjat5ZkLT
fUVxk6r9ffIZFYI2/waxhFhQ3I/Ohm5l0HFbSCGHMjkyjrdxufsdg9WUbqtSqIDs
xoathCqjjQxY+/Xt4RhD6lyzwe5tTl3hoDAOR4cuv6aQ93241otbWdaixHRBGJiq
LlpFDo+OGo7iFMWfgIOukQYzut1Wp4Wv8bKYwYj8kRqzqEEb/w7Yt8l5ewyeXaYY
3EsdOKeabhH3OkKKW+fnd9TyiV8Pv7XlyWofaNCHjUIw6a1B3wGKo9PEJ/b0DDin
QJb9hWtjodKwCObJrhPPxq52oSXM6szNlGIlGxJUlMeVnazq6DF5wW7gPSQ74Lc=
=hfgz
-----END PGP SIGNATURE-----

--CaPKgh3XHpq3rEUV--
