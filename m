Return-Path: virtio-return-2887-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 12 Feb 2018 13:22:09 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180212132209.GC4913@stefanha-x1.localdomain>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
 <1516665617-30748-10-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
In-Reply-To: <1516665617-30748-10-git-send-email-mst@redhat.com>
Subject: Re: [virtio] [PATCH v7 10/11] packed-ring: add in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2018 at 02:01:09AM +0200, Michael S. Tsirkin wrote:
> Support in-order requests for packed rings.
> This allows selective write-out of used descriptors.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  packed-ring.tex | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJagZUBAAoJEJykq7OBq3PImVoH/3i2YjQ3A+LuEg2M/MOgXL4v
rCJMVzGxxBnIMkZtW+RniuJ8MsFUpRWI3LSmWIBoIprcH44ZojwKrez+fI6LpPcc
lVb68egOova1jvshuvC1LR+ha3xxoNNKGBKppIkcrk18o9+amBqLVPgm5OYWXoTn
aP8dkNAy89IHDyk0wCA7fsnaQhQ5IMuRxsZWZgRq+wLN5D5FVgW56iC84AuD9xoB
UfihBdxxkqpCK4t7do5rvONRWOJ44JuBJjmT7x5+FW2oOR1rF/4KmEnh9L7VPy1R
f5/yGkhgNzRCqCzJ2BRKd+VqYJxjYJbeetOhL5AHPm+95qruujvyJRJZo/AjYu4=
=vANK
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
