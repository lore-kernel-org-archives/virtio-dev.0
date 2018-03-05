Return-Path: virtio-return-2962-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 5 Mar 2018 11:14:44 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180305111444.GG7910@stefanha-x1.localdomain>
References: <1519845375-28741-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t4apE7yKrX2dGgJC"
Content-Disposition: inline
In-Reply-To: <1519845375-28741-1-git-send-email-mst@redhat.com>
Subject: Re: [virtio] [PATCH] introduction: document bitfield notation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

--t4apE7yKrX2dGgJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2018 at 09:16:32PM +0200, Michael S. Tsirkin wrote:
> Bitfields are a useful and familiar way to specify sub-byte structure
> layout. The only issue is that bitfield order isn't portable across
> architectures.  Document that we list bitfields from least to
> most significant one, and warn about portability issues.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  introduction.tex | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--t4apE7yKrX2dGgJC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJanSakAAoJEJykq7OBq3PIIFQH/j3BEd571cPj9UIcZw8LnPhR
uGynNsH0/gd8w3m6ZQwayXYnCK44MghItLhC9vxzpw7Rpz/UobtPMW1/UhQFj+hf
T8Qf0/YLuV5R1gPcKJk2/HbPHZXSokoHIvzWaV/WAAIG2e/BQdMcpg9HCpn8vS29
it0+lDaWppUBD6QrtnVgJ83mSVKpi1vE58U2rT1SRHTyYc7tyMn+vGZVD6y/NlsH
t7YNDhCPhFH9XLfSYtuwZZzek0JTyub+H8fEddq6LWsuoKYVTgrKk1+UdeZ8DX7m
yra0nco0m7JbKnn/DQsCrgqiWsj/cEMxfw+Nt9v8amz+TsIYGGRaN7fW8T65T3w=
=ipZe
-----END PGP SIGNATURE-----

--t4apE7yKrX2dGgJC--
