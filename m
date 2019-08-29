Return-Path: virtio-dev-return-6022-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 687CB985CDA
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Aug 2019 13:50:17 +0000 (UTC)
Date: Thu, 29 Aug 2019 14:50:12 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190829135012.GB18693@stefanha-x1.localdomain>
References: <20190823153940.28795-1-stefanha@redhat.com>
 <20190823153940.28795-3-stefanha@redhat.com>
 <20190826152852.02d00c3e.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <20190826152852.02d00c3e.cohuck@redhat.com>
Subject: Re: [virtio-dev] [PATCH v7 2/2] virtio-fs: add DAX window
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Sage Weil <sweil@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2019 at 03:28:52PM +0200, Cornelia Huck wrote:
> On Fri, 23 Aug 2019 16:39:40 +0100
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> > Describe how shared memory region ID 0 is the DAX window and how
> > FUSE_SETUPMAPPING maps file ranges into the window.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > The FUSE_SETUPMAPPING message is part of the virtio-fs Linux patches:
> > https://gitlab.com/virtio-fs/linux/blob/virtio-fs/include/uapi/linux/fu=
se.h
> >=20
> > v7:
> >  * Clarify that the DAX Window is optional and can be used together with
> >    FUSE_READ/FUSE_WRITE requests [Cornelia]
> > v6:
> >  * Document timing side-channel attacks [Michael]
> > ---
> >  virtio-fs.tex | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 66 insertions(+)=20
>=20
> (...)
>=20
> > +\drivernormative{\paragraph}{Device Operation: DAX Window}{Device Type=
s / File System Device / Device Operation / Device Operation: DAX Window}
> > +
> > +The driver SHOULD be prepared to find shared memory region ID 0 absent=
 and fall back to FUSE\_READ and FUSE\_WRITE requests.
> > +
> > +The driver MAY use FUSE\_READ and FUSE\_WRITE requests and also access=
 file contents through the DAX Window.
>=20
> "The driver MAY both use FUSE_READ and FUSE_WRITE requests and access
> file contents through the DAX Window." ?
>=20
> Not sure whether that makes it clearer that it is fine to use a
> combination of both methods.

Thanks, I'll tweak the wording slightly to make it clearer.

Stefan

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1n2BQACgkQnKSrs4Gr
c8jz5Af/QqnXCcFJohlGVHZT189Nn+1bAYbD7jHANnG8Pp3OcGIJrKL/KwzaWhN5
XYYP6U+ckHiMoj8E4vthN6naTdnBEI7i8URRKb8YN8MDQuYxPVgiFZceUCluXKGa
vd8jG/gSnj7yp2qYZJI7yRfESMoi7IQR1X9P6AWx59WEzhTifXzWh18KX/vBwpf6
N/hjTXcbgDeM5MuYx+4Mm8pppEqbywqnYx54YLCa75E9ctAW4L0WR2s/e/eLNbzo
2MHdbgvsvPcMOkUgmYKvVcx0S+8gEBq7r/I4jeDemMtZ9veiwhnsyUd1VcMkDqu8
NLZ1aAoj957obUBbxvVxnbCqFTE1Pw==
=sQM9
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
