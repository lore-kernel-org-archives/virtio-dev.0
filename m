Return-Path: <virtio-dev-return-8210-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3EC179861E4
	for <virtio-dev@lists.oasis-open.org>; Wed, 30 Jun 2021 15:49:08 +0000 (UTC)
Date: Wed, 30 Jun 2021 16:49:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YNySbeZFSxpZd6cK@stefanha-x1.localdomain>
References: <20210609153740.262346-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210609153740.262346-1-stefanha@redhat.com>
Subject: [virtio-dev] Re: [PATCH v3 0/2] virtio-fs: add notification queue
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QDdJOrNoBhplqZ6j"
Content-Disposition: inline
To: virtio-dev@lists.oasis-open.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Liu Bo <bo.liu@linux.alibaba.com>, vgoyal@redhat.com, iangelak@redhat.com, mszeredi@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

--QDdJOrNoBhplqZ6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 09, 2021 at 04:37:38PM +0100, Stefan Hajnoczi wrote:
> v3:
>  * Clarify that empty notification vq semantics are documented for all
>    supported notification message types. [Vivek]
>  * Clarify that the device has internal resources for lock requests and w=
hen
>    they are exhausted ENOLCK is returned. [Vivek]
> v2:
>  * Document empty virtqueue behavior for FUSE_NOTIFY_LOCK messages
>=20
> This patch series adds the notification queue to the VIRTIO specification=
.
> This new virtqueue carries device->driver FUSE notify messages.  They are
> currently unused but will be necessary for file locking, which can block =
for an
> unbounded amount of time and therefore needs a asynchronous completion ev=
ent
> instead of a request/response buffer that consumes space in the request
> virtqueue until the operation completes.
>=20
> Patch 1 corrects an oversight I noticed: the file system device was not a=
dded
> to the Conformance chapter.
>=20
> Stefan Hajnoczi (2):
>   virtio-fs: add file system device to Conformance chapter
>   virtio-fs: add notification queue
>=20
>  conformance.tex | 23 ++++++++++++++++
>  virtio-fs.tex   | 71 ++++++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 84 insertions(+), 10 deletions(-)

I am requesting a vote. Thank you!

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/111

Stefan

--QDdJOrNoBhplqZ6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDckm0ACgkQnKSrs4Gr
c8jBRQf+N2SqsTnqrpftodG4JqQcVuD3G5oM0H4yveM6n3TpUBWk+vAZoW/tkmOD
39i/rhz/g2KcWxTVMntL4qsB1YqVvGWJiH2sfbBz/MH4HvOwdmv18D1LX6tbSkxp
1NO0OxGNB0py5OTNETClQj12mFB2wyHZq3MOh3CPjFO9Kr1ZFiasdCaRbip0EuEH
FTGE/e8dKdZ8NoU2yOzrjwO+P7auS3EBHBQv5VosfWjjy0MSNa17WpBk2DWaBE9I
XfxvEzA/5QP1NQ3FdgBmop5VTbw0w3Auc5OgFw9HY231pT/moiUNhgPY7a1374GT
mX9J129V0s7prqDejvwCO3FxpR9wjw==
=J3ky
-----END PGP SIGNATURE-----

--QDdJOrNoBhplqZ6j--

