Return-Path: virtio-dev-return-8108-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 66EDD98651C
	for <virtio-dev@lists.oasis-open.org>; Wed, 10 Mar 2021 11:17:17 +0000 (UTC)
Date: Wed, 10 Mar 2021 11:17:11 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YEiqt2xtdz0VIH9R@stefanha-x1.localdomain>
References: <CAPR809sesHT9M+5jmQho-4m1L1QufPgE6A_RGWmYqbnM52qSkQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPR809sesHT9M+5jmQho-4m1L1QufPgE6A_RGWmYqbnM52qSkQ@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v5] Add lifetime metrics to virtio-blk
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RCJxvTGzlMwEfVf7"
Content-Disposition: inline
To: Enrico Granata <egranata@google.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--RCJxvTGzlMwEfVf7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 09, 2021 at 02:20:14PM -0700, Enrico Granata wrote:
> In many embedded systems, virtio-blk implementations are
> backed by eMMC or UFS storage devices, which are subject to
> predictable and measurable wear over time due to repeated write
> cycles.
>=20
> For such systems, it can be important to be able to track
> accurately the amount of wear imposed on the storage over
> time and surface it to applications. In a native deployments
> this is generally handled by the physical block device driver
> but no such provision is made in virtio-blk to expose these
> metrics for devices where it makes sense to do so.
>=20
> This patch adds support to virtio-blk for lifetime and wear
> metrics to be exposed to the guest when a deployment of
> virtio-blk is done over compatible eMMC or UFS storage.
>=20
> Signed-off-by: Enrico Granata <egranata@google.com>
> Fixes: https://github.org/oasis-tcs/virtio-spec/issues/97
> ---
>  content.tex | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--RCJxvTGzlMwEfVf7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBIqrcACgkQnKSrs4Gr
c8iZjAf8Df9QbFDpw2dM0ACTMJp3X1mLxA52fVyepRf44gWnXaNVOenD6CV2kpik
K3X04/49c5FKrflarfPMWbOd+Z+V/PJD1JVRkPA/YeHnnmNt1PDcWcEeuyfSdlQD
A+Xd7ef6004t0hGCoCinIqqYT8ZIL7vlpFAUa86r9YPtpkJTlrh/mgcOsNVzmk/C
zgz4r28Xy0mVnFcucvy34B8OSpZUrZagEuthlDkddoCC8JFke/k4o+HXQs6IWAPW
RIX5Y5VPhG4GDZr00+9ZvmJppZ+7n7gEs6YqKwah18KsrX69HbOfrS6Nyh8qgoEm
PYY0xVEi+8ddXi522nI8PfR58X/BMg==
=BtY5
-----END PGP SIGNATURE-----

--RCJxvTGzlMwEfVf7--

