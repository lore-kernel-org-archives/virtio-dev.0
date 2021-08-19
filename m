Return-Path: <stefanha@redhat.com>
Date: Thu, 19 Aug 2021 10:38:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v2] virtio-pmem: PMEM device spec
Message-ID: <YR4mq0lXtAWzzQgE@stefanha-x1.localdomain>
References: <20210813095216.487591-1-pankaj.gupta.linux@gmail.com>
 <YRvVFbhQ83kY2xKw@stefanha-x1.localdomain>
 <CAM9Jb+idw-LNTbEekYz9KkuYu4w+T4UbzLJoGfQULU=2Zd97ng@mail.gmail.com>
 <87tujnrviv.fsf@redhat.com>
 <CAM9Jb+hDhck-4zMXOvd5dwVU2Qxu1QU6aVsq=SNvwz=-NjMbfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mKUPemolfe3Zv+gy"
Content-Disposition: inline
In-Reply-To: <CAM9Jb+hDhck-4zMXOvd5dwVU2Qxu1QU6aVsq=SNvwz=-NjMbfw@mail.gmail.com>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Taylor Stark <tstark@linux.microsoft.com>, Pankaj Gupta <pankaj.gupta@ionos.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--mKUPemolfe3Zv+gy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 19, 2021 at 07:53:48AM +0200, Pankaj Gupta wrote:
> > >> > +\drivernormative{\subsubsection}{Driver Initialization: Virtio fl=
ush}{Device Types / PMEM Driver / Driver Initialization / Virtio flush}
> > >> > +
> > >> > +The driver MUST implement a virtio based flushing interface.
> > >>
> > >> I think this can be dropped. The only way to make writes persistent =
is
> > >> by sending flush requests. There is no need to say that the driver h=
as
> > >> to use this interface. It doesn't really have to, but then it won't =
be
> > >> able to guarantee persistence.
> > >
> > > I am not 100 percent sure on this.
> >
> > I don't think we want this in a normative section, but maybe there's a
> > place for it in a section that describes the general operation?
>=20
> I was saying because this is the must property for virtio-pmem device
> which is emulated
> on regular block device. virtio-pmem above real persistent devices
> don't need any explicit flush.
>=20
> This can be enhanced later for real persistent devices which don't
> need explicit flush
> and thus driver writers don't have to worry about it.

A feature bit can be added in the future that hints to the driver that
flushes are not necessary (only CPU cache flushes are required for
persistence).

However, I remember seeing specifications for persistent memory devices
that do require explicit flush operations (not just a CPU cache flush).
Let's keep them in mind too.

Stefan

--mKUPemolfe3Zv+gy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEeJqkACgkQnKSrs4Gr
c8iDMgf+OjkplU5E5kEcS2d3fGu3qpfHpFtVCw0EP+MyzQ4EMFom0a+f3+ZSQZTW
3zvYKsfQSHIOtc5nymn3gFIrvDZ9iVaLWpx04DT0dqwo+4hgiLyC9VLdqLa43wuY
R5Dsqc1+crSd+umYAU0BVPHmHMThx6QZet55HhOpleQfaY9NwD1WA7ZvgCB1EfOQ
IeDPXt0DL2i21U7ClTckw8YDwgNgkFYAKRJF1JMKA/yzWiea1zX0D3V4sN4yio9J
4UM1rl8OR6iGiJxdb/i/9miuQebLQ/3ezwZrPBnXr9lOUaYnZ17yhkp0FQQ1HaA/
uxo/vcQhQCdbHNILSKGdy1t+72FfEg==
=Zaa1
-----END PGP SIGNATURE-----

--mKUPemolfe3Zv+gy--

