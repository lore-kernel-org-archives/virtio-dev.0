Return-Path: virtio-dev-return-5669-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 31864985A62
	for <virtio-dev@lists.oasis-open.org>; Mon, 15 Apr 2019 13:54:45 +0000 (UTC)
Date: Mon, 15 Apr 2019 14:54:39 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190415135439.GF29134@stefanha-x1.localdomain>
References: <20190412050306.31874-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pql/uPZNXIm1JCle"
Content-Disposition: inline
In-Reply-To: <20190412050306.31874-1-pagupta@redhat.com>
Subject: [virtio-dev] Re: [PATCH] content: reserve device ID for virtio-pmem devices
To: Pankaj Gupta <pagupta@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

--Pql/uPZNXIm1JCle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2019 at 10:33:06AM +0530, Pankaj Gupta wrote:
> We need a device ID for virtio-pmem devices. As 25 is =20
> requested by audio device, so requesting next available(26).
> Also, updated the previously requested github issue[1] for
> voting.
>=20
> [1] https://github.com/oasis-tcs/virtio-spec/issues/38
>=20
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Pql/uPZNXIm1JCle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJctI0fAAoJEJykq7OBq3PIp34H/REuU/a0NiP41JeG7wnSqGUa
n6lqc3B7vH7JGS9388NO/F37KPSD2i9sgd8qEvcG3CBUMy2Yu6EDJbI6eZRmYomz
JM4AwVcrZMbBi4rHm6DuGQDF5IYw/7x5ZYSwRCWMeYVH/dqGZe9vaL3aXj23ZtIj
VLucSbPWaunfkW+gst/HAyaEWjGqyb1Uaa2lzz9sMGfC8ZdcUaf6ZUTTCb17zBio
PqMdFw+k6OLeotuS8ZsEGcNUj0JUHnavIwHmV0vJjKIspRrfihyVKJokuGVXGJEX
nSPgYsDvNoSWp2bDC63E4pIkIOtke4dGhPIrnIEQ994HyDFKD9sO02Tzb8+kYMI=
=sg25
-----END PGP SIGNATURE-----

--Pql/uPZNXIm1JCle--
