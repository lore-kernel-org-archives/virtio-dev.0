Return-Path: virtio-dev-return-8112-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 52189986314
	for <virtio-dev@lists.oasis-open.org>; Mon, 15 Mar 2021 15:53:05 +0000 (UTC)
Date: Mon, 15 Mar 2021 15:52:59 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YE+C2+QeBzhuDvN1@stefanha-x1.localdomain>
References: <20210215095410.85607-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210215095410.85607-1-stefanha@redhat.com>
Subject: [virtio-dev] Re: [PATCH v2 0/2] virtio-fs: add notification queue
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eivTWBeNwnf46J1R"
Content-Disposition: inline
To: virtio-dev@lists.oasis-open.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, vgoyal@redhat.com, mszeredi@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

--eivTWBeNwnf46J1R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 15, 2021 at 09:54:08AM +0000, Stefan Hajnoczi wrote:
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

Ping?

--eivTWBeNwnf46J1R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBPgtsACgkQnKSrs4Gr
c8hTOAf/Y6jCqMzsvPFqBW5yqqG4Yl6F/1ZiCyt7Yn5aUuVxHHBL6WNzAAeP/M+J
Ncr3kfanxDsUu463lkdkdjFtJdJ4Tz2Nszdwi/l0EjUwyzHwfvTKSDyyRr/McjXd
49peSsnT3QWjARTaP5i8BGvGULPbD0+So+8jkUl0Hp4ZHTts/gt9tlyf8OvX5Xnw
FyXlVNKUx6XKCuu/DdffDzIlw7YprhYCaFcfKG1IulgsBZVllJM3uQ0pyl7Owqgv
HzWf5BXnJtO979kxXq6/mPaoKBJ+eOmmeh1MZRMvi3mzSKSPskjEnDGMdkH0P3LZ
9MIQ5TtSt/Wk2XLPULPOZRx0c+ffRg==
=lmah
-----END PGP SIGNATURE-----

--eivTWBeNwnf46J1R--

