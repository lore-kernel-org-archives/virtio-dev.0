Return-Path: <virtio-dev-return-9065-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 633AE986367
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Jan 2022 10:03:14 +0000 (UTC)
Date: Mon, 17 Jan 2022 10:03:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YeU+1BXSScJDMdLi@stefanha-x1.localdomain>
References: <20220112055755.41011-1-jasowang@redhat.com>
 <20220112055755.41011-2-jasowang@redhat.com>
 <Yd6o/rFvyFFhR3+2@stefanha-x1.localdomain>
 <CACGkMEshBONdayoxYaA4LWY0_azztqW_2zAoe2tXCkJrLdoT+w@mail.gmail.com>
 <Yd/8t234EzNkz+9i@stefanha-x1.localdomain>
 <8feea104-4602-7cbc-9065-20b9dd66d7e3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8feea104-4602-7cbc-9065-20b9dd66d7e3@redhat.com>
Subject: [virtio-dev] Re: [PATCH V2 1/2] virtio-pci: introduce virtio structure PCI
 Extended Capability
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JqTnS+Pf7qNVnfzT"
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, mst <mst@redhat.com>, eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--JqTnS+Pf7qNVnfzT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 14, 2022 at 11:23:00AM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2022/1/13 =E4=B8=8B=E5=8D=886:19, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > On Thu, Jan 13, 2022 at 08:55:18AM +0800, Jason Wang wrote:
> > > On Wed, Jan 12, 2022 at 6:10 PM Stefan Hajnoczi <stefanha@redhat.com>=
 wrote:
> > > > On Wed, Jan 12, 2022 at 01:57:54PM +0800, Jason Wang wrote:
> > > > > We're already out of the configuration space if there's a device =
that
> > > > > supports all kinds of the virtio structure via PCI capability. Th=
is
> > > > > prevents us from adding new capabilities in the future.
> > > > >=20
> > > > > So the patch adds the support for virtio structure via PCI Extend=
ed
> > > > > Capability via the vendor specific extended capability.
> > > > >=20
> > > > > Only MMIO bar is allowed now.
> > > > >=20
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > >   content.tex | 127 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++
> > > > >   1 file changed, 127 insertions(+)
> > > > >=20
> > > > > diff --git a/content.tex b/content.tex
> > > > > index cf20570..00a75f2 100644
> > > > > --- a/content.tex
> > > > > +++ b/content.tex
> > > > > @@ -1476,6 +1476,129 @@ \subsubsection{Non-transitional Device Wi=
th Legacy Driver: A Note
> > > > >      of BAR0 by presenting zeroes on every BAR and ignoring write=
s.
> > > > >   \end{enumerate}
> > > > >=20
> > > > > +\subsection{Virtio Structure PCI Extended Capabilities}\label{se=
c:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Ext=
ended Capabilities}
> > > > > +
> > > > > +The location of the virtio structures that depend on the PCI Exp=
ress
> > > > > +capability are specified using a vendor-specific extended capabi=
lities
> > > > > +on the extended capabilities list in PCI Express extended
> > > > > +configuration space of the device.
> > > > I can't parse this sentence. Can you rephrase it and/or split it in=
to
> > > > multiple sentences?
> > > Sure, how about something like:
> > >=20
> > > There could be virtio structures that depend on the PCI express
> > > capability. The location of those structures are specified using a
> > > vendor-specific extended capabilities on the extended capabilities
> > > list.
> > "virtio structures" -> "Virtio device configuration structures" (same a=
s
> > in "4.1.4 Virtio Structure PCI Capabilities")
>=20
>=20
> Ok.
>=20
>=20
> >=20
> > "PCI express capability" -> "PCI Express Extended Capability" or did yo=
u
> > mean that more generally (PCI Express features)?
>=20
>=20
> More general PCI Express feature.
>=20
>=20
> >=20
> > Here is the edited sentence:
> >=20
> >    Virtio device configuration structures that depend on PCI Express
> >    Extended Capabilities are specified using vendor-specific PCI Expres=
s
> >    Extended Capabilities located on the PCI Express Extended Capabiliti=
es
> >    list.
>=20
>=20
> That's fine.
>=20
>=20
> > > > > @@ -1488,6 +1611,10 @@ \subsubsection{Device Initialization}\labe=
l{sec:Virtio Transport Options / Virti
> > > > >   PCI capability list, detecting virtio configuration layout usin=
g Virtio
> > > > >   Structure PCI capabilities as detailed in \ref{sec:Virtio Trans=
port Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}
> > > > >=20
> > > > > +Optionally, if the device is a PCIe device, the driver scans the=
 PCI
> > > > > +Extended capability list, detecting virtio configuration layout =
using
> > > > > +Virtio Struct PCI Extended capabilities as detailed in \ref{sec:=
Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Exten=
ded Capabilities}
> > > > If the same structure is present in both the PCI Capabilities and P=
CI
> > > > Extended Capabilities lists, which one has a higher priority?
> > > This is not allowed in this proposal where only the structure that
> > > depends on the PCI Express capability is allowed. E.g the PASID
> > > configuration structure depends on the PASID extended capability.
> > >=20
> > > This is much more simpler than allowing existing virtio structures to
> > > be presented on both PCI and PCIe capability list.
> > Ah, I think I misunderstood the point of this patch. I thought you were
> > defining it because devices were running out of PCI Configuration Space
> > and PCI Extended Capabilities allow the device to use more space (PCI
> > Express Extended Configuration Space).
> >=20
> > But now I think you're adding this to the spec in order to define VIRTI=
O
> > features that depend on PCI Extended Capabilities like PASID support?
>=20
>=20
> Right.
>=20
>=20
> > Is
> > it really necessary or just cleaner to use PCI Extended Capabilities
> > instead of VIRTIO's existing vendor-specific PCI Capabilities?
>=20
>=20
> Not a must, technically we can add them into the common configuration
> structure. But having a dedicated capability seems cleaner: it looks odd =
to
> configure PCIe features via the legacy capability anyhow. And this is mor=
e
> flexible to allow the hypervisor to map or hide the BAR independently.

Thanks for explaining. The purpose of the patch is clearer now.

Stefan

--JqTnS+Pf7qNVnfzT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmHlPtMACgkQnKSrs4Gr
c8jPZgf7BNxlBdtS/bvZs/JyxHi+Lm0lX3KhX27SxXXVXHiNb/BHYPbK3PAx2yN9
+TNdq05ysY2nA+8RI3Y93+7YsKLcyAQwdf0iWf9vb1mELRRhF/yYUxJ4zP6powDl
qnJO/aMSKRjaxBi8TupA1z56sQ2cW3eYQU8fb3FmzUpTa5zM02xjHggBLoZbjCIm
fC63HC+MsF6YtM+nlE9IG/8LmLAvMOhgpHuNG99NbAoonQm6vYcOVGnBhQZd8NTi
LbeWbHPMejoWBvIeuiOq5854iQv47m8rfIrpIspiqhzned/9nWR/nGIen1WrKOvt
12Nv5DIJr19xuCFvSqEO21BTU9x8DA==
=QsoK
-----END PGP SIGNATURE-----

--JqTnS+Pf7qNVnfzT--

