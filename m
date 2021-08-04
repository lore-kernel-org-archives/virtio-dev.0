Return-Path: <stefanha@redhat.com>
Date: Wed, 4 Aug 2021 13:36:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-dev] [PATCH RESEND] virtio-pmem: PMEM device spec
Message-ID: <YQqJsy49sEXRD8dl@stefanha-x1.localdomain>
References: <20210728150435.264551-1-pankaj.gupta.linux@gmail.com>
 <YQp1D+Ece28livMx@stefanha-x1.localdomain>
 <CAM9Jb+gQwz5x4=iVxrv2OHRs24h=NA+hyhq7c-PsH7MZqWKJmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BmenJTjbLevmMzFY"
Content-Disposition: inline
In-Reply-To: <CAM9Jb+gQwz5x4=iVxrv2OHRs24h=NA+hyhq7c-PsH7MZqWKJmA@mail.gmail.com>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Taylor Stark <tstark@linux.microsoft.com>, Pankaj Gupta <pankaj.gupta@ionos.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--BmenJTjbLevmMzFY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 04, 2021 at 01:28:39PM +0200, Pankaj Gupta wrote:
> > > +\subsection{Device Initialization}\label{sec:Device Types / PMEM Dev=
ice / Device Initialization}
> > > +
> > > +Device hotplugs physical memory to guest address space. Persistent m=
emory device
> > > +is emulated with file backed memory at host side.
> >
> > This paragraph can be dropped. The device could be implemented in a
> > number of ways and it's beyond the scope of the specification.
>=20
> But spec is for current implementation?  As we have more devices or ways,=
 we
> can amend this.

The spec defines the driver/device interface, not the implementation. By
focussing on the interface rather than implementation, we leave room for
multiple implementations and avoid baking in assumptions about one
particular implementation (e.g. file-backed MAP_SHARED host memory).

Stefan

--BmenJTjbLevmMzFY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEKibMACgkQnKSrs4Gr
c8i1HQf9FTmI120KYT3FQiGOcm4TrFQhreuGtLoAskld5wFl0OFbJ3Wbr/j5Cv2o
hIGf1pHxsB4T+vaLlSRcSGn/kDKfiQOnrsPZolQH62fugOnsN3nUosHSzUus9D1x
OIJC1m3WqBJjm6oKKX1ZyeZ0OiUwdTngBmqb+9oOgANa4/UitQovNGFzqQyp5WwH
6wF6oOGkomiMAvjoapwoBzCQX/jNjbl+k82Wb03So6/VXuMLvk5D8P3bEy4Jw0gm
rrwTvoBDJfP6GRq1kyezqa/2HTskAXjNVNs/VvaFRFtnsL+nSUeYwDUIzj2hE1jV
+8GP4f3jOd5THb8pZP/rvqBEVqAb3g==
=Uj9d
-----END PGP SIGNATURE-----

--BmenJTjbLevmMzFY--

