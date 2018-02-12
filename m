Return-Path: virtio-return-2886-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 12 Feb 2018 13:23:24 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180212132324.GD4913@stefanha-x1.localdomain>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
 <1516665617-30748-11-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Content-Disposition: inline
In-Reply-To: <1516665617-30748-11-git-send-email-mst@redhat.com>
Subject: Re: [virtio] [PATCH v7 11/11] split-ring: in order feature
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2018 at 02:01:09AM +0200, Michael S. Tsirkin wrote:
> For a split ring, require that drivers use descriptors in order too.
> This allows devices to skip reading the available ring.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  split-ring.tex | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJagZVMAAoJEJykq7OBq3PIhocH/0R/kOQ50D5qWStwiIccoo19
VfmI4DMbvthy6bZO30VYK203S8Z5hdSxqrNDhWethw2cEERX7Eagvh/XpTlETCuw
bcJgkQYZNVSBxBGhMGev4oPAPOEmtQEGMpwj2iK2czvsXV1Yx/BnEPap7gxSPcx3
arnvDJ1TySMBh/bqkSHTAlBn5hGP5PRBvgF9pSPNRKqbBkm7VYjQgvYvJCfEuu8g
BVnMEQE1J6C7bj9g9hXORB4KQ4bMdNQelS2uQrrCQiysXYtDrvm20O54FcpqaHDo
DXJJcHBhY/7w6Vds+wPbQ1OfOlctgHMZ/HDcb+iUHA3afyi6hIWAQv93K1yNQKY=
=YY/9
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
