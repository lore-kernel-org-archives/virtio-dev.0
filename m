Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH 2/3] transport-pci: Split notes of PCI Device Layout
Date: Mon, 27 Feb 2023 03:05:46 +0000
Message-ID: <PH0PR12MB54811C842A5C55065DABC71BDCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230225223001.430522-1-parav@nvidia.com>
 <20230225223001.430522-3-parav@nvidia.com>
 <20230225180932-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230225180932-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Saturday, February 25, 2023 6:15 PM
>=20
> On Sun, Feb 26, 2023 at 12:30:00AM +0200, Parav Pandit wrote:
> > Currently single legacy interface section describes PCI common
> > configuration layout and feature bits operation for the legacy
> > interface.
> > Secondly common configuration structure description of legacy
> > interface is not adjacent to the the respective normal device
> > requirements for same.
> >
> > Hence, split PCI Device Layout legacy interface section into two
> > parts. First subsection for common configuration and second subsection
> > for feature bits.
> >
> > Subsequent patch relocates common configuration legacy interface to
> > appropriate matching location.
> >
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/164
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
>=20
> I don't care really. However this does much more than move text around as=
 it
> claim to do:
>=20
>=20
> > ---
> >  conformance.tex   |  4 +++-
> >  transport-pci.tex | 19 ++++++++++++-------
> >  2 files changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/conformance.tex b/conformance.tex index 01ccd69..0d3616f
> > 100644
> > --- a/conformance.tex
> > +++ b/conformance.tex
> > @@ -262,7 +262,9 @@ \section{Conformance
> > Targets}\label{sec:Conformance / Conformance Targets}  \item Section
> > \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Message
> > Framing / Legacy Interface: Message Framing}  \item Section
> > \ref{sec:General Initialization And Device Operation / Device
> > Initialization / Legacy Interface: Device Initialization}  \item
> > Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI
> > Device Discovery / Legacy Interfaces: A Note on PCI Device Discovery}
> > -\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus
> > / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
> > +\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI
> > +Bus/ Virtio Structure PCI Capabilities / Legacy Interfaces: A Note on
> > +Common configuration Layout} \item Section \ref{sec:Virtio Transport
> > +Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities /
> > +Legacy Interface: A Note on feature bits}
> >  \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus
> > / PCI-specific Initialization And Device Operation / Device
> > Initialization / Virtio Device Configuration Layout Detection / Legacy
> > Interface: A Note on Device Layout Detection}  \item Section
> > \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific
> > Initialization And Device Operation / Device Initialization /
> > Virtqueue Configuration / Legacy Interface: A Note on Virtqueue
> > Configuration}  \item Section \ref{sec:Virtio Transport Options /
> > Virtio Over MMIO / Legacy interface} diff --git a/transport-pci.tex
> > b/transport-pci.tex index 9ee37ba..9d4c713 100644
> > --- a/transport-pci.tex
> > +++ b/transport-pci.tex
> > @@ -767,7 +767,10 @@ \subsubsection{PCI configuration access
> > capability}\label{sec:Virtio Transport O  specified by some other
> > Virtio Structure PCI Capability  of type other than
> \field{VIRTIO_PCI_CAP_PCI_CFG}.
> >
> > -\subsubsection{Legacy Interfaces: A Note on PCI Device
> > Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI
> > Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
> > +\subsubsection{Legacy Interfaces: A Note on Common configuration
> > +Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus /
> > +Virtio Structure PCI Capabilities / Legacy Interfaces: A Note on
> > +Common configuration Layout}
> >
> >  The transitional device MUST present part of the configuration
> > registers in a legacy configuration structure in BAR0 in the
>=20
>=20
> Please do not split up labels to multiple lines like this, it is hard to =
find and fix
> them if you do.
>=20
Will fix it.

> > @@ -852,13 +855,15 @@ \subsubsection{Legacy Interfaces: A Note on PCI
> > Device Layout}\label{sec:Virtio  is encoded in the native endian of
> > the guest (where such  distinction is applicable).
> >
> > -When accessing the device-specific configuration structure -using the
> > legacy interface, transitional drivers MUST access -the
> > device-specific configuration structure -at an offset immediately
> > following the legacy common -configuration structure.
> > +The transitional driver when using the legacy interface MUST the
> > +device-specific configuration structure at an offset immediately
> > +following the legacy common configuration structure.
>=20
> Oh great and in the process of presumably just moving stuff around you ar=
e
> also losing text - the result is agrammatical, and much less clear than t=
he
> original.
>=20
I missed "access".
While splitting the patch, a hunk got in the wrong patch.
Will fix it.
Thank for the catch.

>=20
> >
> > -Note that only Feature Bits 0 to 31 are accessible through the
> > +\subsubsection{Legacy Interface: A Note on feature
> > +bits}\label{sec:Virtio Transport Options / Virtio Over PCI Bus /
> > +Virtio Structure PCI Capabilities / Legacy Interface: A Note on
> > +feature bits}
> > +
> > +Only Feature Bits 0 to 31 are accessible through the
> >  Legacy Interface. When used through the Legacy Interface,  the
> > transitional device MUST assume that Feature Bits 32 to 63  are not
> > acknowledged by the driver.
>=20
> And you are dropping "Note" here because why? Seems notable in that there
> are more feature bits, someone might miss this fact.
The heading is "A Note ..."
Hence, I dropped the Note from the sentence.
But if you really care, can add it back...

