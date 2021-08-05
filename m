Return-Path: <stefanha@redhat.com>
Date: Thu, 5 Aug 2021 16:22:33 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-dev] [PATCH RESEND] virtio-pmem: PMEM device spec
Message-ID: <YQwCOXqbUUYnDR3b@stefanha-x1.localdomain>
References: <20210728150435.264551-1-pankaj.gupta.linux@gmail.com>
 <YQp1D+Ece28livMx@stefanha-x1.localdomain>
 <dee2aab6-c0a7-3af6-4d4a-f0be75e2a92b@redhat.com>
 <YQqJAVa/qjy+NOrN@stefanha-x1.localdomain>
 <20210804225849.GA23364@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z2y8GhCk8lEIxu+4"
Content-Disposition: inline
In-Reply-To: <20210804225849.GA23364@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
To: Taylor Stark <tstark@linux.microsoft.com>
Cc: David Hildenbrand <david@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, virtio-dev@lists.oasis-open.org, dan.j.williams@intel.com, mst@redhat.com, cohuck@redhat.com, pankaj.gupta@ionos.com, tstark@microsoft.com
List-ID: <virtio-dev.lists.oasis-open.org>


--Z2y8GhCk8lEIxu+4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 04, 2021 at 03:58:49PM -0700, Taylor Stark wrote:
> On Wed, Aug 04, 2021 at 01:33:05PM +0100, Stefan Hajnoczi wrote:
> > On Wed, Aug 04, 2021 at 01:11:52PM +0200, David Hildenbrand wrote:
> > > On 04.08.21 13:07, Stefan Hajnoczi wrote:
> > > > On Wed, Jul 28, 2021 at 05:04:35PM +0200, Pankaj Gupta wrote:
> > > > > +\subsection{Device configuration layout}\label{sec:Device Types =
/ PMEM Device / Device configuration layout}
> > > > > +
> > > > > +\begin{lstlisting}
> > > > > +struct virtio_pmem_config {
> > > > > +	le64 start;
> > > > > +	le64 size;
> > > > > +};
> > > > > +\end{lstlisting}
> > > > > +
> > > > > +\begin{description}
> > > > > +\item[\field{start}] contains the start address from the guest p=
hysical address range
> > > > > +to be hotplugged into the guest address space using the pmem API.
> > > > > +
> > > > > +\item[\field{size}] contains the length of this address range.
> > > > > +\end{description}
> > > >=20
> > > > Please use a Shared Memory Region instead. This is a relatively new
> > > > addition to the VIRTIO device model that seems like a good fit for =
this
> > > > device:
> > > > https://github.com/oasis-tcs/virtio-spec/blob/master/shared-mem.tex
> > >=20
> > > Note that virtio-pmem is already upstream in QEMU and in Linux using =
this
> > > model. There is a proposal to optionally use shared memory for exposi=
ng the
> > > area, to be unlocked with a feature bit.
> >=20
> > Please incorporate the proposal into this patch. A feature bit is a good
> > way of handling this case.
> >=20
> > Although the difference between configuration space parameters and a
> > shared memory region might seem trivial, I think using the shared memory
> > region is worthwhile because it makes the memory region a first-class
> > concept in the VIRTIO device model that is supported by the driver and
> > device emulation infrastructure.
> >=20
> > Stefan
>=20
> For what it's worth, here's the proposal to add support for shared memory=
 regions:
> https://lists.oasis-open.org/archives/virtio-comment/202107/msg00169.html
>=20
> The original plan was to have the base spec go in first, and then conside=
r the
> proposal. Do you think it's better to include the shared memory region pr=
oposal
> from the start?

Talyor and Pankaj,
I hadn't seen Taylor's patch. Since it's small and has already had some
review it can probably be merged quickly after the main virtio-pmem spec
change.

Feel free to keep it as a separate series!

Stefan

--Z2y8GhCk8lEIxu+4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEMAjkACgkQnKSrs4Gr
c8hdNAgArLSeXQWQHyJvIuEF8TCNQ233FgV+wgvarjFMBFqckcxqtodurEY6BDP9
52uyX/axMuZsrXVXgS1zSlKruB303nkBcXq8UqyJF7L8M9o0d7AZrJ+8jLTjGibw
UDysuckQbVHeJuBwBIR6VEskYQLERTv0r/yiK1WnOy3O/ibjgTeXhg0h0CSgVtaU
ti7FgDYROSnV4n6xqZG4nDnCfjfyJIO+fQT+lhMKev4Jh9q0e+b6CrGBGAiS1X3e
evr6m7KeCaouyCHk7xJ75EGSlClYdeBLwwvGSma8YhNSl4rxHubtxjusVfztgUsV
Wwov1R8h3H4fqy8aI1vBOq8YdPi3fQ==
=I2ni
-----END PGP SIGNATURE-----

--Z2y8GhCk8lEIxu+4--

