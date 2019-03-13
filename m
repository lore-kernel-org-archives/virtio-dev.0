Return-Path: virtio-return-3303-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 13 Mar 2019 15:40:13 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190313154013.GE22919@stefanha-x1.localdomain>
References: <20190311155947.29822-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BQPnanjtCNWHyqYD"
Content-Disposition: inline
In-Reply-To: <20190311155947.29822-1-mst@redhat.com>
Subject: Re: [virtio] [PATCH] editorial: explain each structure before use
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 11:59:50AM -0400, Michael S. Tsirkin wrote:
> Several structures are listed before they are
> introduced in some way. Add a sentence before each one
> so they don't appear prior to any prose.
>=20
> VIRTIO-166
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex       |  3 +++
>  split-ring.tex    |  4 ++++
>  virtio-crypto.tex |  2 ++
>  virtio-gpu.tex    | 10 ++++++++--
>  virtio-vsock.tex  |  2 ++
>  5 files changed, 19 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--BQPnanjtCNWHyqYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJciSRdAAoJEJykq7OBq3PIZPYH+wfY/pVHt7OAKm36UZJFEGuV
i2Q9DGaEqwvRhFph3wpO7qqea8OrhrLBFZkSCD9NJnCJU5XQH41lQLanzMuCFqTY
N7D/659p+J63K0Avp6cFBrBuDObq+sq2wBUeV3SC7M4zai02qI8zssl3Bm9lgt9i
ENKjb0Lz4zyzuVrTJSlh2Oq6hPyDRt7MbdgWD9IIVYIQBd1B7XjAPRy6/9xd+gu3
F0eJAoZ8gphZhE4zTUuqUqTJS0JNoyA44dXbN6XfCxVovFSr+2dj3RcNcFI3B14s
sDPl94MeuOH1h5rzlNm/XTV7LmMY00VaWSzgGAMynmhebfzUN34N5ic/drLIXkU=
=dfXM
-----END PGP SIGNATURE-----

--BQPnanjtCNWHyqYD--
