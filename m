Return-Path: <virtio-dev-return-9026-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 292619864E5
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Jan 2022 10:19:54 +0000 (UTC)
Date: Thu, 13 Jan 2022 10:19:35 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <Yd/8t234EzNkz+9i@stefanha-x1.localdomain>
References: <20220112055755.41011-1-jasowang@redhat.com>
 <20220112055755.41011-2-jasowang@redhat.com>
 <Yd6o/rFvyFFhR3+2@stefanha-x1.localdomain>
 <CACGkMEshBONdayoxYaA4LWY0_azztqW_2zAoe2tXCkJrLdoT+w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEshBONdayoxYaA4LWY0_azztqW_2zAoe2tXCkJrLdoT+w@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH V2 1/2] virtio-pci: introduce virtio structure PCI
 Extended Capability
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cvZvA8YR6ySi8Jgn"
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, mst <mst@redhat.com>, eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--cvZvA8YR6ySi8Jgn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 13, 2022 at 08:55:18AM +0800, Jason Wang wrote:
> On Wed, Jan 12, 2022 at 6:10 PM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> >
> > On Wed, Jan 12, 2022 at 01:57:54PM +0800, Jason Wang wrote:
> > > We're already out of the configuration space if there's a device that
> > > supports all kinds of the virtio structure via PCI capability. This
> > > prevents us from adding new capabilities in the future.
> > >
> > > So the patch adds the support for virtio structure via PCI Extended
> > > Capability via the vendor specific extended capability.
> > >
> > > Only MMIO bar is allowed now.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  content.tex | 127 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 127 insertions(+)
> > >
> > > diff --git a/content.tex b/content.tex
> > > index cf20570..00a75f2 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -1476,6 +1476,129 @@ \subsubsection{Non-transitional Device With L=
egacy Driver: A Note
> > >     of BAR0 by presenting zeroes on every BAR and ignoring writes.
> > >  \end{enumerate}
> > >
> > > +\subsection{Virtio Structure PCI Extended Capabilities}\label{sec:Vi=
rtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Extende=
d Capabilities}
> > > +
> > > +The location of the virtio structures that depend on the PCI Express
> > > +capability are specified using a vendor-specific extended capabiliti=
es
> > > +on the extended capabilities list in PCI Express extended
> > > +configuration space of the device.
> >
> > I can't parse this sentence. Can you rephrase it and/or split it into
> > multiple sentences?
>=20
> Sure, how about something like:
>=20
> There could be virtio structures that depend on the PCI express
> capability. The location of those structures are specified using a
> vendor-specific extended capabilities on the extended capabilities
> list.

"virtio structures" -> "Virtio device configuration structures" (same as
in "4.1.4 Virtio Structure PCI Capabilities")

"PCI express capability" -> "PCI Express Extended Capability" or did you
mean that more generally (PCI Express features)?

Here is the edited sentence:

  Virtio device configuration structures that depend on PCI Express
  Extended Capabilities are specified using vendor-specific PCI Express
  Extended Capabilities located on the PCI Express Extended Capabilities
  list.

> > > @@ -1488,6 +1611,10 @@ \subsubsection{Device Initialization}\label{se=
c:Virtio Transport Options / Virti
> > >  PCI capability list, detecting virtio configuration layout using Vir=
tio
> > >  Structure PCI capabilities as detailed in \ref{sec:Virtio Transport =
Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}
> > >
> > > +Optionally, if the device is a PCIe device, the driver scans the PCI
> > > +Extended capability list, detecting virtio configuration layout usin=
g
> > > +Virtio Struct PCI Extended capabilities as detailed in \ref{sec:Virt=
io Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Extended =
Capabilities}
> >
> > If the same structure is present in both the PCI Capabilities and PCI
> > Extended Capabilities lists, which one has a higher priority?
>=20
> This is not allowed in this proposal where only the structure that
> depends on the PCI Express capability is allowed. E.g the PASID
> configuration structure depends on the PASID extended capability.
>=20
> This is much more simpler than allowing existing virtio structures to
> be presented on both PCI and PCIe capability list.

Ah, I think I misunderstood the point of this patch. I thought you were
defining it because devices were running out of PCI Configuration Space
and PCI Extended Capabilities allow the device to use more space (PCI
Express Extended Configuration Space).

But now I think you're adding this to the spec in order to define VIRTIO
features that depend on PCI Extended Capabilities like PASID support? Is
it really necessary or just cleaner to use PCI Extended Capabilities
instead of VIRTIO's existing vendor-specific PCI Capabilities?

Stefan

--cvZvA8YR6ySi8Jgn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmHf/LcACgkQnKSrs4Gr
c8jJ2wf+K1vnL+2t19QxDk5DOLVCJm7vSuN6GorOLywQX5opXfMzOUtkFIoNyaxl
6eJ6KWayfOpM5RozF5uVCmZRH5bnpmh+YSFzd+Pga5nUs6Qv8g7DK0UblU8U310x
wy44DWkXgyFhIsWIkeZ+5ioXMh+nlioBrAWFoPQ97bx5pah1fDukWI5IE3+M2vuq
slQS+6W4dgDR6mZ92t2tmEOFUaMDZrz4avC7RDvCFD/pUmd+73lz0iZ5Az0qFx2E
pRWvUFKTkKDgvKq/7okp9FzYkPbuUEJjpc0yI4lnqRUuIdFkFQD8UfLNC2qFJ6RC
08MwFki1Wa0Knx2TuYkAr1/QprEngg==
=byw+
-----END PGP SIGNATURE-----

--cvZvA8YR6ySi8Jgn--

