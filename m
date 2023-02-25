Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH 2/3] transport-pci: Split notes of PCI Device Layout
Date: Sun, 26 Feb 2023 00:30:00 +0200
Message-ID: <20230225223001.430522-3-parav@nvidia.com>
In-Reply-To: <20230225223001.430522-1-parav@nvidia.com>
References: <20230225223001.430522-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Currently single legacy interface section describes PCI common
configuration layout and feature bits operation for the
legacy interface.
Secondly common configuration structure description of legacy interface
is not adjacent to the the respective normal device requirements for
same.

Hence, split PCI Device Layout legacy interface section into two
parts. First subsection for common configuration and second
subsection for feature bits.

Subsequent patch relocates common configuration legacy interface to
appropriate matching location.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/164
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 conformance.tex   |  4 +++-
 transport-pci.tex | 19 ++++++++++++-------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index 01ccd69..0d3616f 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -262,7 +262,9 @@ \section{Conformance Targets}\label{sec:Conformance / C=
onformance Targets}
 \item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / =
Message Framing / Legacy Interface: Message Framing}
 \item Section \ref{sec:General Initialization And Device Operation / Devic=
e Initialization / Legacy Interface: Device Initialization}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PC=
I Device Discovery / Legacy Interfaces: A Note on PCI Device Discovery}
-\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PC=
I Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
+\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus/ Vir=
tio Structure PCI Capabilities / Legacy Interfaces: A Note on Common
+configuration Layout}
+\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Vi=
rtio Structure PCI Capabilities / Legacy Interface: A Note on feature bits}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PC=
I-specific Initialization And Device Operation / Device Initialization / Vi=
rtio Device Configuration Layout Detection / Legacy Interface: A Note on De=
vice Layout Detection}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PC=
I-specific Initialization And Device Operation / Device Initialization / Vi=
rtqueue Configuration / Legacy Interface: A Note on Virtqueue Configuration=
}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legac=
y interface}
diff --git a/transport-pci.tex b/transport-pci.tex
index 9ee37ba..9d4c713 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -767,7 +767,10 @@ \subsubsection{PCI configuration access capability}\la=
bel{sec:Virtio Transport O
 specified by some other Virtio Structure PCI Capability
 of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
=20
-\subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:V=
irtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy =
Interfaces: A Note on PCI Device Layout}
+\subsubsection{Legacy Interfaces: A Note on Common configuration
+Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus
+/ Virtio Structure PCI Capabilities / Legacy Interfaces: A Note on Common
+configuration Layout}
=20
 The transitional device MUST present part of the configuration
 registers in a legacy configuration structure in BAR0 in the
@@ -852,13 +855,15 @@ \subsubsection{Legacy Interfaces: A Note on PCI Devic=
e Layout}\label{sec:Virtio
 is encoded in the native endian of the guest (where such
 distinction is applicable).
=20
-When accessing the device-specific configuration structure
-using the legacy interface, transitional drivers MUST access
-the device-specific configuration structure
-at an offset immediately following the legacy common
-configuration structure.
+The transitional driver when using the legacy interface MUST
+the device-specific configuration structure at an offset
+immediately following the legacy common configuration structure.
=20
-Note that only Feature Bits 0 to 31 are accessible through the
+\subsubsection{Legacy Interface: A Note on feature
+bits}\label{sec:Virtio Transport Options / Virtio Over PCI Bus /
+Virtio Structure PCI Capabilities / Legacy Interface: A Note on feature bi=
ts}
+
+Only Feature Bits 0 to 31 are accessible through the
 Legacy Interface. When used through the Legacy Interface,
 the transitional device MUST assume that Feature Bits 32 to 63
 are not acknowledged by the driver.
--=20
2.26.2

