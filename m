Return-Path: virtio-dev-return-6968-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DFAE898432E
	for <virtio-dev@lists.oasis-open.org>; Mon, 23 Mar 2020 13:39:42 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Mon, 23 Mar 2020 14:38:31 +0100
Message-Id: <20200323133831.2110014-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC PATCH] virtio-iommu: Add PAGE_SIZE_MASK property
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: bbhushan2@marvell.com, eric.auger@redhat.com, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Add a PROBE property to declare the mapping granularity per endpoint.
The virtio-iommu device already declares a granule in its config space,
but when endpoints are behind different physical IOMMUs, they may have
different mapping granules. This new property allows to override the
global page_size_mask for each endpoint.

In the future it may be useful to describe more than one page_size_mask
for each endpoint, and allow them to negotiate it during ATTACH. For
example two masks could allow the driver to choose between 4k and 64k
granule, along with their respective block mapping sizes. This could be
added by replacing \field{reserved} with an array length, for example.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
I had this change planned for a page-table sharing extension, but it
seems to be useful for the VFIO support in QEMU as well [1].

[1] https://lore.kernel.org/qemu-devel/3da60c1b-6897-7ab1-3a67-bec44fa00a54=
@redhat.com/
---
---
 virtio-iommu.tex | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/virtio-iommu.tex b/virtio-iommu.tex
index 08b358a..d7be13d 100644
--- a/virtio-iommu.tex
+++ b/virtio-iommu.tex
@@ -664,7 +664,8 @@ \subsubsection{PROBE request}\label{sec:Device Types / =
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
@@ -727,6 +728,36 @@ \subsubsection{PROBE properties}\label{sec:Device Type=
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
+Types / IOMMU Device / Device operations})
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
2.25.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

