Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH 1/3] transport-pci: Improve PCI legacy device layout description
Date: Sun, 26 Feb 2023 00:29:59 +0200
Message-ID: <20230225223001.430522-2-parav@nvidia.com>
In-Reply-To: <20230225223001.430522-1-parav@nvidia.com>
References: <20230225223001.430522-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Legacy interface PCI Device layout description has following issues.

1. repeated 'structure' word
2. virtio header was defined the 0.9.5 spec. In a legacy interface
   section it is referred with different keywards
   as (a) virtio header, (b) general headers, (c) legacy configuration
   structure, (d) virtio common configuration structure and
   (e) other fields.
3. Driver and device requirements listing is intermixed.
4. spelling error of structure

Hence, rewrite the description to eliminate above issues as below.

1. Removed repeated structure word
2. Fix spelling of structure
3. Place all device requirements toegether
3. Define legacy configuration structure that consist of
   a. legacy common configuration structure and
   b. device specific configuration structure
4. Rewrite section around above changes

This is only an editorial change.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/164
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-pci.tex | 93 ++++++++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 41 deletions(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 5d22e6f..9ee37ba 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -769,25 +769,19 @@ \subsubsection{PCI configuration access capability}\l=
abel{sec:Virtio Transport O
=20
 \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:V=
irtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy =
Interfaces: A Note on PCI Device Layout}
=20
-Transitional devices MUST present part of configuration
-registers in a legacy configuration structure in BAR0 in the first I/O
-region of the PCI device, as documented below.
-When using the legacy interface, transitional drivers
-MUST use the legacy configuration structure in BAR0 in the first
-I/O region of the PCI device, as documented below.
-
-When using the legacy interface the driver MAY access
-the device-specific configuration region using any width accesses, and
-a transitional device MUST present driver with the same results as
-when accessed using the ``natural'' access method (i.e.
-32-bit accesses for 32-bit fields, etc).
-
-Note that this is possible because while the virtio common configuration s=
tructure is PCI
-(i.e. little) endian, when using the legacy interface the device-specific
-configuration region is encoded in the native endian of the guest (where s=
uch distinction is
-applicable).
-
-When used through the legacy interface, the virtio common configuration st=
ructure looks as follows:
+The transitional device MUST present part of the configuration
+registers in a legacy configuration structure in BAR0 in the
+first I/O region of the PCI Device.
+
+The legacy configuration structure is described below.
+It consists of two parts.
+\begin{enumerate}
+  \item Legacy common configuration structure
+  \item Device configuration structure (optional)
+\end{enumerate}
+
+When used through the legacy interface, the legacy common
+configuration structure has the following layout:
=20
 \begin{tabularx}{\textwidth}{ |X||X|X|X|X|X|X|X|X| }
 \hline
@@ -801,8 +795,8 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device =
Layout}\label{sec:Virtio
 \hline
 \end{tabularx}
=20
-If MSI-X is enabled for the device, two additional fields
-immediately follow this header:
+When MSI-X capability is enabled on the device, the device MUST
+present two additional fields immediately following the above fields:
=20
 \begin{tabular}{ |l||l|l| }
 \hline
@@ -814,14 +808,12 @@ \subsubsection{Legacy Interfaces: A Note on PCI Devic=
e Layout}\label{sec:Virtio
 \hline
 \end{tabular}
=20
-Note: When MSI-X capability is enabled, device-specific configuration star=
ts at
-byte offset 24 in virtio common configuration structure structure. When MS=
I-X capability is not
-enabled, device-specific configuration starts at byte offset 20 in virtio
-header.  ie. once you enable MSI-X on the device, the other fields move.
-If you turn it off again, they move back!
+The device configuration structure is optional. Its existence
+is decided by each device type. The transitional device MUST
+present the device-specific configuration structure if any at an
+offset immediately following the legacy common configuration structure.
=20
-Any device-specific configuration space immediately follows
-these general headers:
+The device configuration structure:
=20
 \begin{tabular}{|l||l|l|}
 \hline
@@ -833,25 +825,44 @@ \subsubsection{Legacy Interfaces: A Note on PCI Devic=
e Layout}\label{sec:Virtio
 \hline
 \end{tabular}
=20
-When accessing the device-specific configuration space
-using the legacy interface, transitional
-drivers MUST access the device-specific configuration space
-at an offset immediately following the general headers.
-
-When using the legacy interface, transitional
-devices MUST present the device-specific configuration space
-if any at an offset immediately following the general headers.
-
-Note that only Feature Bits 0 to 31 are accessible through the
-Legacy Interface. When used through the Legacy Interface,
-Transitional Devices MUST assume that Feature Bits 32 to 63
-are not acknowledged by Driver.
+Note: The device configuration structure byte offset is
+calculated dynamically; when MSI-X capability is enabled, the
+device configuration structure is located at byte offset 24,
+when MSI-X capability is disabled, the device configuration
+structure is located at byte offset 20.
=20
 As legacy devices had no \field{config_generation} field,
 see \ref{sec:Basic Facilities of a Virtio Device / Device
 Configuration Space / Legacy Interface: Device Configuration
 Space}~\nameref{sec:Basic Facilities of a Virtio Device / Device Configura=
tion Space / Legacy Interface: Device Configuration Space} for workarounds.
=20
+When using the legacy interface, the transitional driver MUST
+use the legacy configuration structure in BAR0 in the first
+I/O region of the PCI device.
+
+When using the legacy interface, the driver MAY access
+the device-specific configuration structure using any width
+accesses and the transitional device MUST present the driver with
+the same results as when accessed using the ``natural'' access
+method (i.e. 32-bit accesses for 32-bit fields, etc).
+
+Note that this is possible because while the legacy common
+configuration structure is PCI (i.e. little) endian, when using
+the legacy interface the device-specific configuration structure
+is encoded in the native endian of the guest (where such
+distinction is applicable).
+
+When accessing the device-specific configuration structure
+using the legacy interface, transitional drivers MUST access
+the device-specific configuration structure
+at an offset immediately following the legacy common
+configuration structure.
+
+Note that only Feature Bits 0 to 31 are accessible through the
+Legacy Interface. When used through the Legacy Interface,
+the transitional device MUST assume that Feature Bits 32 to 63
+are not acknowledged by the driver.
+
 \subsubsection{Non-transitional Device With Legacy Driver: A Note
 on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio
 Over PCI Bus / PCI Device Layout / Non-transitional Device With
--=20
2.26.2

