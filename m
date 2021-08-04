Return-Path: <stefanha@redhat.com>
Date: Wed, 4 Aug 2021 13:33:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-dev] [PATCH RESEND] virtio-pmem: PMEM device spec
Message-ID: <YQqJAVa/qjy+NOrN@stefanha-x1.localdomain>
References: <20210728150435.264551-1-pankaj.gupta.linux@gmail.com>
 <YQp1D+Ece28livMx@stefanha-x1.localdomain>
 <dee2aab6-c0a7-3af6-4d4a-f0be75e2a92b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n+DgD4n+4rQlqZIo"
Content-Disposition: inline
In-Reply-To: <dee2aab6-c0a7-3af6-4d4a-f0be75e2a92b@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, virtio-dev@lists.oasis-open.org, dan.j.williams@intel.com, mst@redhat.com, cohuck@redhat.com, tstark@linux.microsoft.com, pankaj.gupta@ionos.com
List-ID: <virtio-dev.lists.oasis-open.org>


--n+DgD4n+4rQlqZIo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 04, 2021 at 01:11:52PM +0200, David Hildenbrand wrote:
> On 04.08.21 13:07, Stefan Hajnoczi wrote:
> > On Wed, Jul 28, 2021 at 05:04:35PM +0200, Pankaj Gupta wrote:
> > > +\subsection{Device configuration layout}\label{sec:Device Types / PM=
EM Device / Device configuration layout}
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_pmem_config {
> > > +	le64 start;
> > > +	le64 size;
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +\begin{description}
> > > +\item[\field{start}] contains the start address from the guest physi=
cal address range
> > > +to be hotplugged into the guest address space using the pmem API.
> > > +
> > > +\item[\field{size}] contains the length of this address range.
> > > +\end{description}
> >=20
> > Please use a Shared Memory Region instead. This is a relatively new
> > addition to the VIRTIO device model that seems like a good fit for this
> > device:
> > https://github.com/oasis-tcs/virtio-spec/blob/master/shared-mem.tex
>=20
> Note that virtio-pmem is already upstream in QEMU and in Linux using this
> model. There is a proposal to optionally use shared memory for exposing t=
he
> area, to be unlocked with a feature bit.

Please incorporate the proposal into this patch. A feature bit is a good
way of handling this case.

Although the difference between configuration space parameters and a
shared memory region might seem trivial, I think using the shared memory
region is worthwhile because it makes the memory region a first-class
concept in the VIRTIO device model that is supported by the driver and
device emulation infrastructure.

Stefan

--n+DgD4n+4rQlqZIo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEKiQEACgkQnKSrs4Gr
c8gGrgf9G+lXQ1iZOiTcIfAMiXRM1jt0BBAqTrTQVzVWNVPNGbb6VtU9SYRJz3JW
Np7LF4BnxswdK5FHRTb6seXJYpen3AiLH5eO82H0krFa2Uebb6Jk0AfNTTLtJvt9
5whSX86S2LWl6szOp2gYT/s4a8IVdO+SVK68t8c1sYEQIYW2YbGrAtHDoswgb41j
a1kDaUvw4rOFyhk2vo/J8jkJ2XUkvV7l9xGoGZ7XH4p2JUvZc0dlwRejFVB6+5Io
2fh2RlERkzBvO/Ysb0NiA/3+ielU3BQ3Ltl/nlNJdokpvjwXxTh1IJX1XmiEVmcP
NI+R+Lif6IEKZqcyGo55Eyq19fU1Og==
=Kwjy
-----END PGP SIGNATURE-----

--n+DgD4n+4rQlqZIo--

