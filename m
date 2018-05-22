Return-Path: virtio-dev-return-4115-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 96F2E581803B
	for <virtio-dev@lists.oasis-open.org>; Tue, 22 May 2018 06:07:32 -0700 (PDT)
Date: Tue, 22 May 2018 10:42:48 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180522094248.GI21655@stefanha-x1.localdomain>
References: <20180518044106.31357-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="54ZiyWcDhi/7bWb8"
Content-Disposition: inline
In-Reply-To: <20180518044106.31357-1-pagupta@redhat.com>
Subject: Re: [virtio-dev] [PATCH] content: reserve device ID for virtio-pmem
 devices
To: Pankaj Gupta <pagupta@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--54ZiyWcDhi/7bWb8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2018 at 10:11:06AM +0530, Pankaj Gupta wrote:
> We need a device ID for virtio-pmem devices. As 24 is already=20
> requested by virtio-mem, so requesting next available(25)
>=20
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)

virtio-mem is designed for hotplug.  Does it make sense to merge
virtio-pmem into virtio-mem since you'll need hotplug too?

Stefan

--54ZiyWcDhi/7bWb8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbA+YYAAoJEJykq7OBq3PI/qwH/iZruKMBS3UOkrHrJcVMt6KT
LAn8ds70WF6W7auoMB+tUbeB7UxVoNWEV7Mmloi6DNLdvEHYC2DRvU8M6152hW70
FDGnfmVahezZmLJQQM2d4ecPXQd1xpB35qzqhrtW1WBHqAZBmWTw4y5L7/F7P1jP
d0gds2oxKIjRQ2wivRjLiCgv3HEAK0sAGgIgY1jadRFgU9/39RxIB4RpEz1Xy48W
OMwKRXTUDgwiKfNXzeJOkXbXTnNU8EVof0/ZOHsWVj29N+GX+wJVuieZzBARCs1F
yOtXiq2K5K5zkwNuQYpJ5ZkRQEaJVRjtWKOKFaRnx42+sjOdgqMPI9u2icVis9M=
=wzIe
-----END PGP SIGNATURE-----

--54ZiyWcDhi/7bWb8--
