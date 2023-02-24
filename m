Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v5 4/6] transport-pci: Fix spellings and white spaces
Date: Sat, 25 Feb 2023 00:22:13 +0200
Message-ID: <20230224222215.339715-5-parav@nvidia.com>
In-Reply-To: <20230224222215.339715-1-parav@nvidia.com>
References: <20230224222215.339715-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Now that we have individual files, fix reported spelling errors.

While at it, remove trailing white spaces.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/157
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v0->v1:
- removed many trailing white spaces
---
 transport-pci.tex | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 9c820f9..01fb652 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -5,7 +5,7 @@ \section{Virtio Over PCI Bus}\label{sec:Virtio Transport Op=
tions / Virtio Over P
 A Virtio device can be implemented as any kind of PCI device:
 a Conventional PCI device or a PCI Express
 device.  To assure designs meet the latest level
-requirements, see=20
+requirements, see
 the PCI-SIG home page at \url{http://www.pcisig.com} for any
 approved changes.
=20
@@ -14,7 +14,7 @@ \section{Virtio Over PCI Bus}\label{sec:Virtio Transport =
Options / Virtio Over P
 guest an interface that meets the specification requirements of
 the appropriate PCI specification: \hyperref[intro:PCI]{[PCI]}
 and \hyperref[intro:PCIe]{[PCIe]}
-respectively.=20
+respectively.
=20
 \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Vir=
tio Over PCI Bus / PCI Device Discovery}
=20
@@ -586,7 +586,7 @@ \subsubsection{ISR status capability}\label{sec:Virtio =
Transport Options / Virti
=20
 \devicenormative{\paragraph}{ISR status capability}{Virtio Transport Optio=
ns / Virtio Over PCI Bus / PCI Device Layout / ISR status capability}
=20
-The device MUST present at least one VIRTIO_PCI_CAP_ISR_CFG capability. =
=20
+The device MUST present at least one VIRTIO_PCI_CAP_ISR_CFG capability.
=20
 The device MUST set the Device Configuration Interrupt bit
 in \field{ISR status} before sending a device configuration
@@ -945,7 +945,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio =
Transport Options / Virti
 \end{lstlisting}
=20
 Note that mapping an event to vector might require device to
-allocate internal device resources, and thus could fail.=20
+allocate internal device resources, and thus could fail.
=20
 \devicenormative{\subparagraph}{MSI-X Vector Configuration}{Virtio Transpo=
rt Options / Virtio Over PCI Bus / PCI-specific Initialization And Device O=
peration / Device Initialization / MSI-X Vector Configuration}
=20
@@ -973,7 +973,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio =
Transport Options / Virti
 unless it is impossible for the device to satisfy the mapping
 request.  Devices MUST report mapping
 failures by returning the NO_VECTOR value when the relevant
-\field{config_msix_vector}/\field{queue_msix_vector} field is read.=20
+\field{config_msix_vector}/\field{queue_msix_vector} field is read.
=20
 \drivernormative{\subparagraph}{MSI-X Vector Configuration}{Virtio Transpo=
rt Options / Virtio Over PCI Bus / PCI-specific Initialization And Device O=
peration / Device Initialization / MSI-X Vector Configuration}
=20
@@ -981,7 +981,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio =
Transport Options / Virti
 Driver MAY fall back on using INT\#x interrupts for a device
 which only supports one MSI-X vector (MSI-X Table Size =3D 0).
=20
-Driver MAY intepret the Table Size as a hint from the device
+Driver MAY interpret the Table Size as a hint from the device
 for the suggested number of MSI-X vectors to use.
=20
 Driver MUST NOT attempt to map an event to a vector
--=20
2.26.2

