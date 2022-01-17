Return-Path: <virtio-dev-return-9066-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A28EA986367
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Jan 2022 10:15:36 +0000 (UTC)
Date: Mon, 17 Jan 2022 10:15:27 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YeVBvyxbq+eBWQUI@stefanha-x1.localdomain>
References: <87lezrhd8p.fsf@linaro.org>
 <YdwBGYBdzfYxOvp4@stefanha-x1.localdomain>
 <87r19a8jub.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87r19a8jub.fsf@linaro.org>
Subject: Re: [virtio-dev] Some thoughts on zero-copy between VM domains for
 discussion
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eqvRtAvSR/NxaRLg"
Content-Disposition: inline
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: stratos-dev@op-lists.linaro.org, virtio-dev@lists.oasis-open.org, Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <john.stultz@linaro.org>, Tom Gall <tom.gall@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Christopher Clark <christopher.w.clark@gmail.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, Mike Holmes <mike.holmes@linaro.org>, Trilok Soni <tsoni@quicinc.com>, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Anmar Oueja <anmar.oueja@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--eqvRtAvSR/NxaRLg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 14, 2022 at 02:28:11PM +0000, Alex Benn=E9e wrote:
>=20
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > [[PGP Signed Part:Undecided]]
> > On Thu, Jan 06, 2022 at 05:03:38PM +0000, Alex Benn=E9e wrote:
> >>=20
> >> Hi,
> >>=20
> >> To start the new year I thought would dump some of my thoughts on
> >> zero-copy between VM domains. For project Stratos we've gamely avoided
> >> thinking too hard about this while we've been concentrating on solving
> >> more tractable problems. However we can't put it off forever so lets
> >> work through the problem.
> >>=20
> >> Memory Sharing
> <snip>
> >> Buffer Allocation
> <snip>
> >> Transparent fallback and scaling
> <snip>
> >>=20
> >>  - what other constraints we need to take into account?
> >>  - can we leverage existing sub-systems to build this support?
> >>=20
> >> I look forward to your thoughts ;-)
> >
> > (Side note: Shared Virtual Addressing (https://lwn.net/Articles/747230/=
)
> > is an interesting IOMMU feature. It would be neat to have a CPU
> > equivalent where loads and stores from/to another address space could b=
e
> > done cheaply with CPU support. I don't think this is possible today and
> > that's why software IOMMUs are slow for per-transaction page protection=
.
> > In other words, a virtio-net TX VM would set up a page table allowing
> > read access only to the TX buffers and vring and the virtual network
> > switch VM would have the capability to access the vring and buffers
> > through the TX VM's dedicated address space.)
>=20
> Does binding a device to an address space mean the driver allocations
> will be automatically done from the address space or do the drivers need
> modifying to take advantage of that? Jean-Phillipe?
>=20
> > Some storage and networking applications use buffered I/O where the
> > guest kernel owns the DMA buffer while others use zero-copy I/O where
> > guest userspace pages are pinned for DMA. I think both cases need to be
> > considered.
> >
> > Are guest userspace-visible API changes allowed (e.g. making the
> > userspace application aware at buffer allocation time)?
>=20
> I assume you mean enhanced rather than breaking APIs here? I don't see
> why not. Certainly for the vhost-user backends we are writing we aren't
> beholden to sticking to an old API.

I was thinking about guest applications. Is the goal to run umodified
guest applications or is it acceptable to require new APIs (e.g. for
buffer allocation)?

> > Ideally the
> > requirement would be that zero-copy must work for unmodified
> > applications, but I'm not sure if that's realistic.
> >
> > By the way, VIRTIO 1.2 introduces Shared Memory Regions. These are
> > memory regions (e.g. PCI BAR ranges) that the guest driver can map. If
> > the host pages must come from a special pool then Shared Memory Regions
> > would be one way to configure the guest to use this special zero-copy
> > area for data buffers and even vrings. New VIRTIO feature bits and
> > transport-specific information may need to be added to do this.
>=20
> Are these fixed sizes or could be accommodate a growing/shrinking region?

Shared Memory Regions are currently static although it may be possible
to extend the spec. The virtio-pci transport represents Shared Memory
Regions using PCI Capabilities and I'm not sure if the PCI Capabilities
list is allowed to change at runtime.

Stefan

--eqvRtAvSR/NxaRLg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmHlQb8ACgkQnKSrs4Gr
c8g1Mwf9ERtVXE9wui9tkEn6EWloi7/N4nOkZtFOdxiGJPRr0FqJO7uKKdgmr8OS
cpx80aFgV/6TvrmMyv/Y91umzufJTkV3erqCBJosGArYAKwhltOhOaUB3CWgphJx
yaQ5ONe+eRuvr1NkhIkAT9r8MvMn00ONPk1Jb4WdGTALSnstaCO81CgxGpaTHaCh
lXeud0YSibjnbu5NgD10g8hjBsTVaPMGM5SU9uLlQpjQw5H5cQCtO3Kk3EZ2guyH
ldrM+kRsu/wlKJbR5i2oaVksnFH89lNffjUYeJFq+ExhAiJ0WOg793e39GPVqkH3
CxgqGXctEqwT4vPN/kHxEXc0J+wRTQ==
=UqXj
-----END PGP SIGNATURE-----

--eqvRtAvSR/NxaRLg--

