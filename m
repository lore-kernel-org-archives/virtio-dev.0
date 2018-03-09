Return-Path: virtio-dev-return-3487-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id F12A65818F65
	for <virtio-dev@lists.oasis-open.org>; Fri,  9 Mar 2018 01:53:47 -0800 (PST)
Date: Fri, 9 Mar 2018 09:53:35 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180309095335.GB9668@stefanha-x1.localdomain>
References: <1520563463-27504-1-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <1520563463-27504-1-git-send-email-changpeng.liu@intel.com>
Subject: [virtio-dev] Re: [PATCH v4] virtio-blk: add discard and write zeroes features to
 specification
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: virtio-dev@lists.oasis-open.org, cavery@redhat.com, pbonzini@redhat.com, pawelx.wodkowski@intel.com, james.r.harris@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 10:44:23AM +0800, Changpeng Liu wrote:
> Existing virtio-blk protocol doesn't have DISCARD/WRITE ZEROES support,
> this will impact the performance when using SSD backend over file systems.
>=20
> Here is the proposal to extend existing virtio-blk protocol to support
> DISCARD/WRITE ZEROES commands.
>=20
> Basic idea here is using 16 Bytes payload to support 1 descriptor, users
> can put several segments together with 1 DISCARD/WRITE ZEROES command.
>=20
> struct virtio_blk_discard_write_zeroes {
>        le64 sector;
>        le32 num_sectors;
>        struct {
>                le32 unmap:1;
>                le32 reserved:31;
>        } flags;
> };
>=20
> For the purpose to support such feature, we need to introduce 2 new featu=
re
> flags: VIRTIO_BLK_F_DISCARD/VIRTIO_BLK_F_WRITE_ZEROES, and 2 new command
> types: VIRTIO_BLK_T_DISCARD/VIRTIO_BLK_T_WRITE_ZEROES. Also we introduce
> several new parameters in the configuration space of virtio-blk:
> max_discard_sectors/max_discard_seg/max_write_zeroes_sectors.
> These parameters will tell the OS what's the granularity when
> issuing such commands.
>=20
> If both DISCARD and WRITE ZEROES are supported, unmap flag bit maybe used
> for WRITE ZEROES command with DISCARD bit enabled.
>=20
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  content.tex | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 81 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaolmfAAoJEJykq7OBq3PIUEEH/2bl0N7KwDKnA8txnBEnON59
zfAQHVkHLQ/tH+xd9/zqkTpVM3by50J3vQFd1dNj1WVBHJck2D+BlyWBkY/J2CtQ
mjKoYODFXOfWvvJghd+OyCmfInSP8S2ESssLTnlQaQLTBBDkGFvnekqowYHJnYof
uQRlKQXfHm7EqzuGlDCZXeY+V8C74A4/wjkIvRUwYZSBHqKfHk/kurQL9X4eF+Ov
0jEDy6tRseBJQlKtk9mihN2InRxZZBedAWHgLhpG/1poQlqv1Qz5wyTQjPGI93aM
DcI64Rf2rdlwbbVlcgScpleELLcfG+oSCAYiEKYzthwLlTLhu7Ad+tR1FsLYgx4=
=VAjS
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
