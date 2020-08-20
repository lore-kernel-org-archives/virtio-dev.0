Return-Path: virtio-dev-return-7691-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9BE6E985E55
	for <virtio-dev@lists.oasis-open.org>; Thu, 20 Aug 2020 13:32:17 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Thu, 20 Aug 2020 15:29:21 +0200
Message-Id: <20200820132920.2041932-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH virtio v2] virtio-iommu: Add built-in topology description
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, joro@8bytes.org, eric.auger@redhat.com, sebastien.boeuf@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Add a simple method to describe the IOMMU topology in the config space,
guarded by a new feature bit. A list of capabilities in the config space
describes the devices managed by the IOMMU and their endpoint IDs.

As outlined in paragraph #1 below, the method used to describe I/O
topology depends on the platform. Device-Tree based platforms use the
"iommus" and "iommu-map" DT properties, while ACPI based platforms will
use the VIOT table (whose format is compatible with this built-in
description, but is under discussion). This adds a method for
lightweight platforms that don't use either DT or ACPI.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v2:
* Precise what \field{length} should contain (Eric)
* Rename num_items -> count
v1: https://lists.oasis-open.org/archives/virtio-dev/202007/msg00023.html
---
 virtio-iommu.tex | 102 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/virtio-iommu.tex b/virtio-iommu.tex
index 08b358a..82254b1 100644
--- a/virtio-iommu.tex
+++ b/virtio-iommu.tex
@@ -67,6 +67,9 @@ \subsection{Feature bits}\label{sec:Device Types / IOMMU =
Device / Feature bits}
=20
 \item[VIRTIO_IOMMU_F_MMIO (5)]
   The VIRTIO_IOMMU_MAP_F_MMIO flag is available.
+
+\item[VIRTIO_IOMMU_F_TOPOLOGY (6)]
+  Topology description is available at \field{topo_config}.
 \end{description}
=20
 \drivernormative{\subsubsection}{Feature bits}{Device Types / IOMMU Device=
 / Feature bits}
@@ -97,6 +100,10 @@ \subsection{Device configuration layout}\label{sec:Devi=
ce Types / IOMMU Device /
     le32 end;
   } domain_range;
   le32 probe_size;
+  struct virtio_iommu_topo_config {
+    le16 count;
+    le16 offset;
+  } topo_config;
 };
 \end{lstlisting}
=20
@@ -139,6 +146,101 @@ \subsection{Device initialization}\label{sec:Device T=
ypes / IOMMU Device / Devic
 If the driver does not accept the VIRTIO_IOMMU_F_BYPASS feature, the
 device SHOULD NOT let endpoints access the guest-physical address space.
=20
+\subsubsection{Built-in topology description}\label{sec:Device Types / IOM=
MU Device / Device initialization / topology}
+
+The device manages memory accesses from endpoints, identified by endpoint
+IDs. The driver can discover which endpoint ID corresponds to an endpoint
+using a method specific to the platform. Platforms described with device
+tree use the \texttt{iommus} and \texttt{iommu-map} properties embedded
+into device nodes for this purpose. Platforms described with ACPI use a
+table such as the Virtual I/O Translation Table (VIOT). Platforms that do
+not support either device tree or ACPI may embed a minimalistic
+description in the device configuration space, declared by the
+VIRTIO_IOMMU_F_TOPOLOGY feature.
+
+A disadvantage of describing the topology from within the device is the
+lack of initialization ordering information. Out-of-band descriptions such
+as device tree and ACPI let the operating system know about device
+dependencies so that it can initialize supplier devices (IOMMUs) before
+their consumers (endpoints). Platforms using the VIRTIO_IOMMU_F_TOPOLOGY
+feature have to communicate the device dependency in another way.
+
+If the VIRTIO_IOMMU_F_TOPOLOGY feature is negotiated, \field{topo_config}
+describes the topology description array. \field{topo_config.offset} is
+the offset between the beginning of the device-specific configuration
+space (struct virtio_iommu_config) and the array. The array is composed of
+\field{topo_config.count} topology structures. A topology structure
+defines the endpoint ID of one or more endpoints managed by the
+virtio-iommu device. Each structure has a \field{length} field, which
+defines the offset from the beginning of the structure to the beginning of
+the next one. Each structure starts with a \field{type} byte:
+
+\begin{description}
+  \item[VIRTIO_IOMMU_TOPO_PCI_RANGE (1)] struct virtio_iommu_topo_pci_rang=
e
+  \item[VIRTIO_IOMMU_TOPO_MMIO (2)] struct virtio_iommu_topo_mmio
+\end{description}
+
+To stay binary compatible with ACPI VIOT, types 3 and 4 are currently
+reserved.
+
+\paragraph{PCI range}\label{sec:Device Types / IOMMU Device / Device initi=
alization / topology / PCI range}
+
+\begin{lstlisting}
+struct virtio_iommu_topo_pci_range {
+  u8 type;
+  u8 reserved;
+  le16 length;
+  le32 endpoint_start;
+  le16 segment;
+  le16 bdf_start;
+  le16 bdf_end;
+  le16 padding;
+};
+\end{lstlisting}
+
+The PCI range structure describes the endpoint IDs of a series of PCI
+devices identified by their BDF (Bus-Device-Function) number.
+
+\begin{description}
+  \item[\field{type}] VIRTIO_IOMMU_TOPO_PCI_RANGE.
+  \item[\field{length}] Length of the structure in bytes.
+  \item[\field{endpoint_start}] First endpoint ID.
+  \item[\field{segment}] Identifier of the PCI hierarchy. Sometimes called
+    domain number.
+  \item[\field{bdf_start}] First BDF in the range.
+  \item[\field{bdf_end}] Last BDF in the range.
+\end{description}
+
+The correspondence between a PCI BDF in the range
+[ bdf_start; bdf_end ] and its endpoint IDs is a linear transformation:
+endpoint_id =3D bdf - bdf_start + endpoint_start.
+
+\paragraph{Single endpoint}\label{sec:Device Types / IOMMU Device / Device=
 initialization / topology / Single endpoint}
+
+\begin{lstlisting}
+struct virtio_iommu_topo_mmio {
+  u8 type;
+  u8 reserved;
+  le16 length;
+  le32 endpoint;
+  le64 address;
+};
+\end{lstlisting}
+
+This structure describes a single endpoint.
+
+\begin{description}
+  \item[\field{type}] VIRTIO_IOMMU_TOPO_MMIO.
+  \item[\field{length}] Length of the structure in bytes.
+  \item[\field{endpoint}] The endpoint ID.
+  \item[\field{address}] The first MMIO address in the physical address
+    space.
+\end{description}
+
+\devicenormative{\paragraph}{Built-in topology description}{Device Types /=
 IOMMU Device / Device initialization / topology}
+
+\field{topo_config.offset} SHOULD be aligned on 8 bytes.
+
 \subsection{Device operations}\label{sec:Device Types / IOMMU Device / Dev=
ice operations}
=20
 Driver send requests on the request virtqueue, notifies the device and
--=20
2.28.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

