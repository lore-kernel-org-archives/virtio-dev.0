Return-Path: virtio-dev-return-3243-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B4FC658191F8
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Feb 2018 08:56:53 -0800 (PST)
Date: Tue, 20 Feb 2018 16:56:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180220165634.GA12161@stefanha-x1.localdomain>
References: <12c223afbafb402d6e6602a5888e5dca2953dbfc.1519044214.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <12c223afbafb402d6e6602a5888e5dca2953dbfc.1519044214.git.tgolembi@redhat.com>
Subject: Re: [virtio-dev] [PATCH] docs: document virtio-balloon stats
To: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, Wei Wang <wei.w.wang@intel.com>, Jonathan Helman <jonathan.helman@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2018 at 01:43:44PM +0100, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD=
 wrote:
> Document statistics added in commits
>=20
>     commit a0d06486b445985b8d128df172daefbae205bffd
>     Author: Denis V. Lunev <den@openvz.org>
>     Date:   Wed Feb 24 10:50:48 2016 +0300
>=20
>         virtio-balloon: add 'available' counter
>=20
> and
>=20
>     commit bf1e7140ef0b3a149860ab9f05b36665133238f6
>     Author: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
>     Date:   Tue Dec 5 13:14:46 2017 +0100
>=20
>         virtio-balloon: include statistics of disk/file caches
>=20
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  docs/virtio-balloon-stats.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJajFNBAAoJEJykq7OBq3PIYmoIAJCqyVBCOddyRe7A+xIDRaoh
enFTqfHEJ82tLaq4Tebw/aONy2UdklNg43kdVjUFHOmk4aELRq1psQhOmPvSq/Wb
/2v/KuySJaigGGrbjzeQ0YjJcqWLdgTXvoBvEyCP999/3FHx6vJvH4zlVcc68i8g
BU+RfjZMGqjs1l9WcMwkco4bNmVhL6AohBozJK6TPyN2gn/UZwPnneqdOP0ysL2W
uTzo4uqekm4n9wZhmT4WlkhIcA7g54G7vkHkBScbM/QhiFRSj2Bq7olBjygQqfZW
nv8x6LCOaK5ZRD5CfyIH3iSYvMLCPbwryteYQAIfwf43rxWvN4C8Sa8vSFycxfM=
=cmwu
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
