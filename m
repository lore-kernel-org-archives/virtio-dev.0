Return-Path: virtio-dev-return-5319-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 81E78984378
	for <virtio-dev@lists.oasis-open.org>; Mon, 14 Jan 2019 13:46:38 +0000 (UTC)
Date: Mon, 14 Jan 2019 13:46:27 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190114134627.GG7038@stefanha-x1.localdomain>
References: <20181212152754.12285-1-stefanha@redhat.com>
 <20190111161807-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E69HUUNAyIJqGpVn"
Content-Disposition: inline
In-Reply-To: <20190111161807-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] [PATCH] content: reserve virtio device ID for file
 system devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--E69HUUNAyIJqGpVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2019 at 04:19:24PM -0500, Michael S. Tsirkin wrote:
> On Wed, Dec 12, 2018 at 03:27:54PM +0000, Stefan Hajnoczi wrote:
> > Reserve device ID 26 for virtio-fs devices.
> >=20
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/31
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Stefan, could you please comment on
> - Is 25 used? No one on this list seems to know ...

virtio-pmem:
https://lkml.org/lkml/2019/1/9/544

> - should we start voting on this?

Yes, please.

Stefan

--E69HUUNAyIJqGpVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcPJKzAAoJEJykq7OBq3PI0+UH/io7YJKFTUvLkfujwXQ86FYL
LbbLBVAb7GIg942v6bstlD0enNkHPddic+Xy727lz442gxOxZBBvnKWq48e/fVKT
yZthqI1EBbwxHy65NwoiiCKOHkLAGnuW28KtMadrOyuLnERjyirmeIgFO4kVcy2Y
zS00LUaYA/EdldsokJBYX9GVzTBDFcSlTNXDzqkky9/CUgTESwUhb51QGSlxdLuO
icfAi/FixGAWfH2rI/jLof4ORJpjf/CsN/sqg09cRhP6q3dQnxSYvoHWg0QOnBQG
PH+qyopqQeXPN/fHPCbTlonqaHsd3b7imcHQkFrCR4f/PUiLx9i253zOD2wrp5A=
=Urjc
-----END PGP SIGNATURE-----

--E69HUUNAyIJqGpVn--
