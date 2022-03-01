Return-Path: <virtio-dev-return-9339-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 212F798647B
	for <virtio-dev@lists.oasis-open.org>; Tue,  1 Mar 2022 13:42:29 +0000 (UTC)
Date: Tue, 1 Mar 2022 13:42:15 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <Yh4it+8MroTwbnlz@stefanha-x1.localdomain>
References: <20220301120021.147070-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="we1Skot5OkLJD/Qt"
Content-Disposition: inline
In-Reply-To: <20220301120021.147070-1-stefanha@redhat.com>
Subject: [virtio-dev] Re: [PATCH] virtio-blk: document that the capacity field can change
To: virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--we1Skot5OkLJD/Qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2022 at 12:00:21PM +0000, Stefan Hajnoczi wrote:
> Block devices can change size during operation. A configuration change
> notification is sent by the device and the driver detects that the field
> has changed. Document this behavior that has already been implemented in
> Linux and QEMU since 2011.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  content.tex | 7 +++++++
>  1 file changed, 7 insertions(+)

Requesting a vote.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/136

--we1Skot5OkLJD/Qt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmIeIrcACgkQnKSrs4Gr
c8gElAf/YYL1tuicnGNN8n7cbMiuRjyM3XYmKxMuCgSGFWHu7LYu16vY/mOb3/ZP
z+T/p70npkGyOBJ7McP9ZORGgQP00yuY98aEst3+9k937Y72BivJYUP5TrXBbpjc
p7MfyPTgmwN9EnyGe2ic7m/Qb+3S1I2cfaRTZwVbRXZ4YMycTQ3mUUeyHQdgickd
G8vPYvQnVCPGAypGD5YUj0MpS0Z5+xYEf9Ta61Mpd0+ZQlduHo5pUXc3zITwpDXh
VTVrN7Lw/+/0Y6TEyUnzOnZBNC8zro0/TMfp4zpM3RTh/WoWv9+RCrgOeem09QkG
vtkgTHOalRu02bLx0Lg9fWLPAoCeKw==
=PWnH
-----END PGP SIGNATURE-----

--we1Skot5OkLJD/Qt--

