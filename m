Return-Path: virtio-dev-return-8040-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D28F986184
	for <virtio-dev@lists.oasis-open.org>; Thu, 25 Feb 2021 17:56:01 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Thu, 25 Feb 2021 18:53:15 +0100
Message-Id: <20210225175314.1987932-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] virtio-iommu: Add VIRTIO_IOMMU_F_BOOT_BYPASS
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
Cc: eric.auger@redhat.com, mst@redhat.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Specify the behavior of the device before feature negotiation.
Implementations that allow DMA to bypass the IOMMU during boot inform
the driver by setting the VIRTIO_IOMMU_F_BOOT_BYPASS feature.
Negotiating the feature doesn't have any effect.

Clarify the description for VIRTIO_IOMMU_F_BYPASS while we're at it,
because "downstream of the IOMMU" is confusing.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 virtio-iommu.tex | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/virtio-iommu.tex b/virtio-iommu.tex
index 08b358a..4f34a14 100644
--- a/virtio-iommu.tex
+++ b/virtio-iommu.tex
@@ -59,7 +59,7 @@ \subsection{Feature bits}\label{sec:Device Types / IOMMU =
Device / Feature bits}
   VIRTIO_IOMMU_F_MAP_UNMAP is supported.}
=20
 \item[VIRTIO_IOMMU_F_BYPASS (3)]
-  When not attached to a domain, endpoints downstream of the IOMMU
+  When not attached to a domain, endpoints managed by the IOMMU
   can access the guest-physical address space.
=20
 \item[VIRTIO_IOMMU_F_PROBE (4)]
@@ -67,6 +67,10 @@ \subsection{Feature bits}\label{sec:Device Types / IOMMU=
 Device / Feature bits}
=20
 \item[VIRTIO_IOMMU_F_MMIO (5)]
   The VIRTIO_IOMMU_MAP_F_MMIO flag is available.
+
+\item[VIRTIO_IOMMU_F_BOOT_BYPASS (6)]
+  Before feature negotiation, endpoints managed by the IOMMU
+  can access the guest-physical address space.
 \end{description}
=20
 \drivernormative{\subsubsection}{Feature bits}{Device Types / IOMMU Device=
 / Feature bits}
@@ -114,12 +118,15 @@ \subsection{Device initialization}\label{sec:Device T=
ypes / IOMMU Device / Devic
=20
 When the device is reset, endpoints are not attached to any domain.
=20
-If the VIRTIO_IOMMU_F_BYPASS feature is negotiated, all accesses from
-unattached endpoints are allowed and translated by the IOMMU using the
-identity function. If the feature is not negotiated, any memory access
-from an unattached endpoint fails. Upon attaching an endpoint in
-bypass mode to a new domain, any memory access from the endpoint fails,
-since the domain does not contain any mapping.
+Memory accesses from an endpoint bypass the IOMMU, that is all
+accesses are allowed and translated using the identity function,
+in the following cases:
+\begin{itemize}
+\item If the VIRTIO_IOMMU_F_BOOT_BYPASS feature is offered and
+  the FEATURES_OK status bit is not set.
+\item If the VIRTIO_IOMMU_F_BYPASS feature is negotiated and the
+  endpoint is not attached to a domain.
+\end{itemize}
=20
 Future devices might support more modes of operation besides MAP/UNMAP.
 Drivers verify that devices set VIRTIO_IOMMU_F_MAP_UNMAP and fail
@@ -136,8 +143,13 @@ \subsection{Device initialization}\label{sec:Device Ty=
pes / IOMMU Device / Devic
=20
 \devicenormative{\subsubsection}{Device Initialization}{Device Types / IOM=
MU Device / Device Initialization}
=20
+If the device does not offer the VIRTIO_IOMMU_F_BOOT_BYPASS
+feature, it SHOULD NOT let endpoints access the guest-physical
+address space before feature negotiation is complete.
+
 If the driver does not accept the VIRTIO_IOMMU_F_BYPASS feature, the
-device SHOULD NOT let endpoints access the guest-physical address space.
+device SHOULD NOT let endpoints access the guest-physical address space
+after feature negotiation is complete.
=20
 \subsection{Device operations}\label{sec:Device Types / IOMMU Device / Dev=
ice operations}
=20
--=20
2.30.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

