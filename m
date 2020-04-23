Return-Path: virtio-dev-return-7147-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8A9E3985F87
	for <virtio-dev@lists.oasis-open.org>; Thu, 23 Apr 2020 07:58:45 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Thu, 23 Apr 2020 09:56:21 +0200
Message-Id: <20200423075620.644668-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2] virtio-iommu: Add PAGE_SIZE_MASK property
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: eric.auger@redhat.com, bbhushan2@marvell.com, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Add a PROBE property to declare the mapping granularity per endpoint.
The virtio-iommu device already has to declare a granule in its config
space, but when endpoints are behind different physical IOMMUs (for
example some pass-through and some PV endpoints), they may have
different mapping granules. This new property allows to override the
global page_size_mask for each endpoint. When the property isn't
reported for an endpoint, the global page size mask applies. The device
checks page alignment during MAP requests.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1: https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg06035.h=
tml
v2 clarifies how overriding the global property works.
---
 virtio-iommu.tex | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/virtio-iommu.tex b/virtio-iommu.tex
index 08b358a..05f4fd6 100644
--- a/virtio-iommu.tex
+++ b/virtio-iommu.tex
@@ -216,6 +216,9 @@ \subsection{Device operations}\label{sec:Device Types /=
 IOMMU Device / Device op
   Creating mappings aligned on large page sizes can improve performance
   since they require fewer page table and TLB entries.
=20
+  The mask can be overriden for an endpoint by the PAGE_SIZE_MASK PROBE
+  property.
+
 \item If the VIRTIO_IOMMU_F_DOMAIN_RANGE feature is offered,
   \field{domain_range} describes the values supported in a \field{domain}
   field. If the feature is not offered, any \field{domain} value is valid.
@@ -664,7 +667,8 @@ \subsubsection{PROBE request}\label{sec:Device Types / =
IOMMU Device / Device ope
 \subsubsection{PROBE properties}\label{sec:Device Types / IOMMU Device / D=
evice operations / PROBE properties}
=20
 \begin{lstlisting}
-#define VIRTIO_IOMMU_PROBE_T_RESV_MEM   1
+#define VIRTIO_IOMMU_PROBE_T_RESV_MEM         1
+#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK   2
 \end{lstlisting}
=20
 \paragraph{Property RESV_MEM}\label{sec:Device Types / IOMMU Device / Devi=
ce operations / PROBE properties / RESVMEM}
@@ -727,6 +731,38 @@ \subsubsection{PROBE properties}\label{sec:Device Type=
s / IOMMU Device / Device
 The device SHOULD NOT allow accesses from the endpoint to RESV_MEM regions
 to affect any other component than the endpoint and the driver.
=20
+\paragraph{Property PAGE_SIZE_MASK}\label{sec:Device Types / IOMMU Device =
/ Device operations / PROBE properties / PAGESIZEMASK}
+
+The PAGE_SIZE_MASK property overrides the global \field{page_size_mask}
+configuration for an endpoint.
+
+\begin{lstlisting}
+struct virtio_iommu_probe_page_size_mask {
+  struct virtio_iommu_probe_property head;
+  u8    reserved[4];
+  le64  page_size_mask;
+};
+\end{lstlisting}
+
+The \field{page_size_mask} field behaves in the same way as the global
+\field{page_size_mask} field. The least significant bit describes the
+mapping granularity, and additional bits are hints (see \ref{sec:Device
+Types / IOMMU Device / Device operations}). When no PAGE_SIZE_MASK
+property is available for an endpoint, the global \field{page_size_mask}
+applies.
+
+\drivernormative{\subparagraph}{Property PAGE_SIZE_MASK}{Device Types / IO=
MMU Device / Device operations / PROBE properties / PAGESIZEMASK}
+
+The driver MUST ignore \field{reserved}.
+
+\devicenormative{\subparagraph}{Property PAGE_SIZE_MASK}{Device Types / IO=
MMU Device / Device operations / PROBE properties / PAGESIZEMASK}
+
+The device SHOULD set \field{reserved} to zero.
+
+The device MUST set at least one bit in \field{page_size_mask}, describing
+the page granularity. The device MAY set more than one bit in
+\field{page_size_mask}.
+
 \subsubsection{Fault reporting}\label{sev:Device Types / IOMMU Device / De=
vice operations / Fault reporting}
=20
 The device can report translation faults and other significant
--=20
2.26.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

