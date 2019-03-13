Return-Path: virtio-return-3307-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 13 Mar 2019 15:49:36 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190313154936.GJ22919@stefanha-x1.localdomain>
References: <20190311181809.7970-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdJFN6SSISdF2ksn"
Content-Disposition: inline
In-Reply-To: <20190311181809.7970-1-mst@redhat.com>
Subject: [virtio] Re: [virtio-dev] [PATCH v2] signal start and end of structures
 consistently
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--sdJFN6SSISdF2ksn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 02:18:48PM -0400, Michael S. Tsirkin wrote:
> Make sure all structs have the format:
>=20
> struct X {
> ...
> };
>=20
> VIRTIO-170
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> Changes since v1:
> 	no text changes, fix typo in commit log reported by Cornelia
>=20
>  content.tex    | 11 +++++------
>  virtio-gpu.tex |  2 +-
>  2 files changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--sdJFN6SSISdF2ksn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJciSaQAAoJEJykq7OBq3PItG0H/0qPxMvih+niZUc5pCOWGsGm
fsdHSs20eICQsYDdNmCIsnKbdDxaPqkmLDyc/Sb+ZOaBB0DSB8DcMpE7OK57aR2z
W4jM2gr9KoaXQh5OVIJra6XJ24ItqWfLx1WAc6p2Xs2QelCFiuYQMwTpFxrVXXN8
0Ogy6ItAoh5ihVsyh0qbVJ1rhQWawaU8wPMX3Jt8jPR07SrfkVNr+5kxS7qZfZ7H
lhi6M7Tt8p+KLVGctx0D+Ul9f62V+NaOHZwhlk9GFe5tv52AiMyXwuv5Tp5prnT3
3YQ3V5H9/uj4ThYEDxzzM687M1Y9VmoqfaEPuzp0tjA/EDRR2wSOmvreLbofIGE=
=Bekk
-----END PGP SIGNATURE-----

--sdJFN6SSISdF2ksn--
