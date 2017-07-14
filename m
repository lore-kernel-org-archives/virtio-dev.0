Return-Path: virtio-return-2771-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 14 Jul 2017 12:28:19 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170714112819.GJ27446@stefanha-x1.localdomain>
References: <20170712095016.9926-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1BdFSKqAqVdu8k/"
Content-Disposition: inline
In-Reply-To: <20170712095016.9926-1-cohuck@redhat.com>
Subject: [virtio] Re: [virtio-dev] [PATCH v2] virtio-net: fix virtqueue numbering error
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--k1BdFSKqAqVdu8k/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2017 at 11:50:16AM +0200, Cornelia Huck wrote:
> receiveq(n) is at position 2(n-1), not 2n. Same error for transmitq(n)
> and controlq.
>=20
> VIRTIO-161
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> v1->v2: fix description
>         use 2N for controlq [Stefan]
> ---
>  content.tex | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--k1BdFSKqAqVdu8k/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZaKrTAAoJEJykq7OBq3PIF7EH/jkJIFsNP9BqSE0Uc46ByyFB
rxDP1IeJemsz683SvKkSrY/t61GuKeaVuYjMKaTIHgQ3chpkeh0CwEs9s8hxs2bM
BBwYAQraft4YNG4tvecX5ngiQ5yxFQ9llMOpAPuCi01fZTJBJN00/Z2v65uBwJjr
HfOADXHlUMuitLx33LxZSLB2PxqaTz2w8wrh/qWHPS22xQgfcBRd/kXvAcQH1MON
Ir8RCOdIyVNQ8DKTNuWQ2OsrDhnz1R4cV+k0V60NjA7z1uj83OHZOzBIDc9bBL0w
c65bkqR6WIm1rt4cuLLJx2s3iRU6c5HxSvktA5N6orqVrBkDWkkL8js/JrDO7sA=
=XTk6
-----END PGP SIGNATURE-----

--k1BdFSKqAqVdu8k/--
