Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH 3/3] transport-pci: Relocate common config legacy interface
Date: Sun, 26 Feb 2023 00:30:01 +0200
Message-ID: <20230225223001.430522-4-parav@nvidia.com>
In-Reply-To: <20230225223001.430522-1-parav@nvidia.com>
References: <20230225223001.430522-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Relocate legacy interface section of common configuration structure near
where 1.x based common configuration structure is defined.

This aligns the spec to follow rest of the other Legacy interfaces
section.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/164
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 conformance.tex   |   3 +-
 transport-pci.tex | 186 +++++++++++++++++++++++-----------------------
 2 files changed, 95 insertions(+), 94 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index 0d3616f..b654fe0 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -262,8 +262,7 @@ \section{Conformance Targets}\label{sec:Conformance / C=
onformance Targets}
 \item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / =
Message Framing / Legacy Interface: Message Framing}
 \item Section \ref{sec:General Initialization And Device Operation / Devic=
e Initialization / Legacy Interface: Device Initialization}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PC=
I Device Discovery / Legacy Interfaces: A Note on PCI Device Discovery}
-\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus/ Vir=
tio Structure PCI Capabilities / Legacy Interfaces: A Note on Common
-configuration Layout}
+\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Vi=
rtio Structure PCI Capabilities / Common configuration structure layout / L=
egacy Interfaces: A Note on Common configuration Layout}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Vi=
rtio Structure PCI Capabilities / Legacy Interface: A Note on feature bits}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PC=
I-specific Initialization And Device Operation / Device Initialization / Vi=
rtio Device Configuration Layout Detection / Legacy Interface: A Note on De=
vice Layout Detection}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PC=
I-specific Initialization And Device Operation / Device Initialization / Vi=
rtqueue Configuration / Legacy Interface: A Note on Virtqueue Configuration=
}
diff --git a/transport-pci.tex b/transport-pci.tex
index 9d4c713..19375d0 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -494,6 +494,100 @@ \subsubsection{Common configuration structure layout}=
\label{sec:Virtio Transport
 were used before the queue reset.
 (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue=
 Reset}).
=20
+\paragraph{Legacy Interfaces: A Note on Common configuration
+Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus
+/ Virtio Structure PCI Capabilities / Common configuration
+structure layout / Legacy Interfaces: A Note on Common
+configuration Layout}
+
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
+
+\begin{tabularx}{\textwidth}{ |X||X|X|X|X|X|X|X|X| }
+\hline
+ Bits & 32 & 32 & 32 & 16 & 16 & 16 & 8 & 8 \\
+\hline
+ Read / Write & R & R+W & R+W & R & R+W & R+W & R+W & R \\
+\hline
+ Purpose & Device Features bits 0:31 & Driver Features bits 0:31 &
+  Queue Address & \field{queue_size} & \field{queue_select} & Queue Notify=
 &
+  Device Status & ISR \newline Status \\
+\hline
+\end{tabularx}
+
+When MSI-X capability is enabled on the device, the device MUST
+present two additional fields immediately following the above fields:
+
+\begin{tabular}{ |l||l|l| }
+\hline
+Bits       & 16             & 16     \\
+\hline
+Read/Write & R+W            & R+W    \\
+\hline
+Purpose (MSI-X) & \field{config_msix_vector}  & \field{queue_msix_vector} =
\\
+\hline
+\end{tabular}
+
+The device configuration structure is optional. Its existence
+is decided by each device type. The transitional device MUST
+present the device-specific configuration structure if any at an
+offset immediately following the legacy common configuration structure.
+
+The device configuration structure:
+
+\begin{tabular}{|l||l|l|}
+\hline
+Bits & Device Specific & \multirow{3}{*}{\ldots} \\
+\cline{1-2}
+Read / Write & Device Specific & \\
+\cline{1-2}
+Purpose & Device Specific & \\
+\hline
+\end{tabular}
+
+Note: The device configuration structure byte offset is
+calculated dynamically; when MSI-X capability is enabled, the
+device configuration structure is located at byte offset 24,
+when MSI-X capability is disabled, the device configuration
+structure is located at byte offset 20.
+
+As legacy devices had no \field{config_generation} field,
+see \ref{sec:Basic Facilities of a Virtio Device / Device
+Configuration Space / Legacy Interface: Device Configuration
+Space}~\nameref{sec:Basic Facilities of a Virtio Device / Device Configura=
tion Space / Legacy Interface: Device Configuration Space} for workarounds.
+
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
+The transitional driver when using the legacy interface MUST
+the device-specific configuration structure at an offset
+immediately following the legacy common configuration structure.
+
+
 \subsubsection{Notification structure layout}\label{sec:Virtio Transport O=
ptions / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
=20
 The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
@@ -767,98 +861,6 @@ \subsubsection{PCI configuration access capability}\la=
bel{sec:Virtio Transport O
 specified by some other Virtio Structure PCI Capability
 of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
=20
-\subsubsection{Legacy Interfaces: A Note on Common configuration
-Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus
-/ Virtio Structure PCI Capabilities / Legacy Interfaces: A Note on Common
-configuration Layout}
-
-The transitional device MUST present part of the configuration
-registers in a legacy configuration structure in BAR0 in the
-first I/O region of the PCI Device.
-
-The legacy configuration structure is described below.
-It consists of two parts.
-\begin{enumerate}
-  \item Legacy common configuration structure
-  \item Device configuration structure (optional)
-\end{enumerate}
-
-When used through the legacy interface, the legacy common
-configuration structure has the following layout:
-
-\begin{tabularx}{\textwidth}{ |X||X|X|X|X|X|X|X|X| }
-\hline
- Bits & 32 & 32 & 32 & 16 & 16 & 16 & 8 & 8 \\
-\hline
- Read / Write & R & R+W & R+W & R & R+W & R+W & R+W & R \\
-\hline
- Purpose & Device Features bits 0:31 & Driver Features bits 0:31 &
-  Queue Address & \field{queue_size} & \field{queue_select} & Queue Notify=
 &
-  Device Status & ISR \newline Status \\
-\hline
-\end{tabularx}
-
-When MSI-X capability is enabled on the device, the device MUST
-present two additional fields immediately following the above fields:
-
-\begin{tabular}{ |l||l|l| }
-\hline
-Bits       & 16             & 16     \\
-\hline
-Read/Write & R+W            & R+W    \\
-\hline
-Purpose (MSI-X) & \field{config_msix_vector}  & \field{queue_msix_vector} =
\\
-\hline
-\end{tabular}
-
-The device configuration structure is optional. Its existence
-is decided by each device type. The transitional device MUST
-present the device-specific configuration structure if any at an
-offset immediately following the legacy common configuration structure.
-
-The device configuration structure:
-
-\begin{tabular}{|l||l|l|}
-\hline
-Bits & Device Specific & \multirow{3}{*}{\ldots} \\
-\cline{1-2}
-Read / Write & Device Specific & \\
-\cline{1-2}
-Purpose & Device Specific & \\
-\hline
-\end{tabular}
-
-Note: The device configuration structure byte offset is
-calculated dynamically; when MSI-X capability is enabled, the
-device configuration structure is located at byte offset 24,
-when MSI-X capability is disabled, the device configuration
-structure is located at byte offset 20.
-
-As legacy devices had no \field{config_generation} field,
-see \ref{sec:Basic Facilities of a Virtio Device / Device
-Configuration Space / Legacy Interface: Device Configuration
-Space}~\nameref{sec:Basic Facilities of a Virtio Device / Device Configura=
tion Space / Legacy Interface: Device Configuration Space} for workarounds.
-
-When using the legacy interface, the transitional driver MUST
-use the legacy configuration structure in BAR0 in the first
-I/O region of the PCI device.
-
-When using the legacy interface, the driver MAY access
-the device-specific configuration structure using any width
-accesses and the transitional device MUST present the driver with
-the same results as when accessed using the ``natural'' access
-method (i.e. 32-bit accesses for 32-bit fields, etc).
-
-Note that this is possible because while the legacy common
-configuration structure is PCI (i.e. little) endian, when using
-the legacy interface the device-specific configuration structure
-is encoded in the native endian of the guest (where such
-distinction is applicable).
-
-The transitional driver when using the legacy interface MUST
-the device-specific configuration structure at an offset
-immediately following the legacy common configuration structure.
-
 \subsubsection{Legacy Interface: A Note on feature
 bits}\label{sec:Virtio Transport Options / Virtio Over PCI Bus /
 Virtio Structure PCI Capabilities / Legacy Interface: A Note on feature bi=
ts}
--=20
2.26.2

