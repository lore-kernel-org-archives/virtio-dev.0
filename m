Return-Path: <stefanha@redhat.com>
Date: Thu, 2 Sep 2021 16:15:35 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3] virtio-pmem: PMEM device spec
Message-ID: <YTDql6wICevfv3bv@stefanha-x1.localdomain>
References: <20210902054033.75455-1-pankaj.gupta.linux@gmail.com>
 <YTCUamWUA24yt3g0@stefanha-x1.localdomain>
 <CAM9Jb+hqv-WRrhSObpaTvKwWE+bEgdHC_ck85wdj=guYjFUssw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HrTPCYDNtNsfVdkz"
Content-Disposition: inline
In-Reply-To: <CAM9Jb+hqv-WRrhSObpaTvKwWE+bEgdHC_ck85wdj=guYjFUssw@mail.gmail.com>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Taylor Stark <tstark@linux.microsoft.com>, Pankaj Gupta <pankaj.gupta@ionos.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--HrTPCYDNtNsfVdkz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 02, 2021 at 11:18:39AM +0200, Pankaj Gupta wrote:
> > > +Requests have the following format:
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_pmem_req {
> > > +        le32 type;
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +\field{type} is the request command type.
> >
> > Where are the type constants defined? I was expecting a flush request
> > type constant:
> >
> >   /* Request types */
> >   #define VIRTIO_PMEM_REQ_T_FLUSH 0
>=20
> Removed this in current version. Thinking this might be driver specific d=
etail.
> Will add again.

Constant values that the driver places into the "type" field need to be
defined in the specification. Otherwise there's a risk that drivers
place different values into the field and we cannot add new types of
requests in the future.

Stefan

--HrTPCYDNtNsfVdkz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEw6pcACgkQnKSrs4Gr
c8jMaQf+OiTo+NvYJh+agY40CvU1uKQXMNwR7xKdkq+E28xdoD2QOZkIphsFW4UD
UMdpu5gNkVHuWZLt+3xovwsXUvYOIWqOeHHtvWb4ZJ4gIXlELiRHgK+C54m/I/2C
sA8lRHVySFGj+KndJGiXIxhazXeaazPLT4WERaRqdlmRFUK3NMirjtNoHGV6jSDz
AoO1QJ3UdrHVU3S6ZW01Yn3FQ0G1K+DwAIq3bqb71tYHGnRpK1XIWGJ9Rqa9Sdj4
N1XgGTjYIAhhDc7Agwr6y6Ch1CeCqKLHreiP8cT44CXA3T/kqGRr5fvStmn5PiBX
T52vRG7ZfyWUDHo2vNTZNRL9Ck12OQ==
=7iDK
-----END PGP SIGNATURE-----

--HrTPCYDNtNsfVdkz--

