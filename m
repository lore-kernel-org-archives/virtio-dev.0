Return-Path: virtio-dev-return-7980-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 70135986629
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 Feb 2021 18:02:30 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri,  5 Feb 2021 18:58:18 +0100
Message-Id: <20210205175812.143886-4-jean-philippe@linaro.org>
In-Reply-To: <20210205175812.143886-1-jean-philippe@linaro.org>
References: <20210205175812.143886-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 3/4] virtio-iommu: Add PROBE properties for tables
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
Cc: eric.auger@redhat.com, kevin.tian@intel.com, vivek.gautam@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Add several PROBE properties required for attaching tables to a domain.
The MAP_UNMAP interface is simple enough that the same global properties
can be used for all endpoints managed by the device. This won't be the
case for the table interface. Hardware and emulated endpoints have
difference properties, which have to be described in PROBE requests.

* PAGE_SIZE_MASK: supported mapping granularity
* INPUT_RANGE: input address size (IOVA)
* OUTPUT_SIZE: output address size (GPA)
* PASID_SIZE: Process Address Space ID size. To know the maximum size of
  a PASID table.
* TABLE_FORMAT: PASID or page table format. These will be described in
  subsequent patches.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 virtio-iommu.tex | 159 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 158 insertions(+), 1 deletion(-)

diff --git a/virtio-iommu.tex b/virtio-iommu.tex
index 1ca2638..e14bd67 100644
--- a/virtio-iommu.tex
+++ b/virtio-iommu.tex
@@ -871,7 +871,12 @@ \subsubsection{PROBE request}\label{sec:Device Types /=
 IOMMU Device / Device ope
 \subsubsection{PROBE properties}\label{sec:Device Types / IOMMU Device / D=
evice operations / PROBE properties}
=20
 \begin{lstlisting}
-#define VIRTIO_IOMMU_PROBE_T_RESV_MEM   1
+#define VIRTIO_IOMMU_PROBE_T_RESV_MEM       1
+#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK 2
+#define VIRTIO_IOMMU_PROBE_T_INPUT_RANGE    3
+#define VIRTIO_IOMMU_PROBE_T_OUTPUT_SIZE    4
+#define VIRTIO_IOMMU_PROBE_T_PASID_SIZE     5
+#define VIRTIO_IOMMU_PROBE_T_TABLE_FORMAT   6
 \end{lstlisting}
=20
 \paragraph{Property RESV_MEM}\label{sec:Device Types / IOMMU Device / Devi=
ce operations / PROBE properties / RESVMEM}
@@ -934,6 +939,158 @@ \subsubsection{PROBE properties}\label{sec:Device Typ=
es / IOMMU Device / Device
 The device SHOULD NOT allow accesses from the endpoint to RESV_MEM regions
 to affect any other component than the endpoint and the driver.
=20
+
+\paragraph{Property PAGE_SIZE_MASK}\label{sec:Device Types / IOMMU Device =
/ Device operations / PROBE properties / PAGE_SIZE_MASK}
+
+\begin{lstlisting}
+struct virtio_iommu_probe_page_size_mask {
+  struct virtio_iommu_probe_property head;
+  u8    reserved[4];
+  le64  page_size_mask;
+};
+\end{lstlisting}
+
+The PAGE_SIZE_MASK property overrides the global
+\field{page_size_mask} configuration for an endpoint.
+
+The \field{page_size_mask} field behaves in the same way as the
+global \field{page_size_mask} field, described in \ref{sec:Device
+Types / IOMMU Device / Device operations}. The least significant
+bit describes the mapping granularity, while additional bits are
+hints.
+
+\drivernormative{\subparagraph}{Property PAGE_SIZE_MASK}{Device Types / IO=
MMU Device / Device operations / PROBE properties / PAGE_SIZE_MASK}
+
+The driver MUST ignore \field{reserved}.
+
+\devicenormative{\subparagraph}{Property PAGE_SIZE_MASK}{Device Types / IO=
MMU Device / Device operations / PROBE properties / PAGE_SIZE_MASK}
+
+The device SHOULD set \field{reserved} to zero.
+
+The device MAY present multiple PAGE_SIZE_MASK property per
+endpoint.
+
+
+\paragraph{Property INPUT_RANGE}\label{sec:Device Types / IOMMU Device / D=
evice operations / PROBE properties / INPUT_RANGE}
+
+\begin{lstlisting}
+struct virtio_iommu_probe_input_range {
+  struct virtio_iommu_probe_property head;
+  u8    reserved[4];
+  le64  start;
+  le64  end;
+};
+\end{lstlisting}
+
+The INPUT_RANGE property overrides the global \field{input_range}
+configuration for an endpoint.
+
+Fields \field{start} and \field{end} behave in the same way as
+the global \field{input_range.start} and \field{input_range.end}
+fields, described in \ref{sec:Device Types / IOMMU Device /
+Device operations}.
+
+\drivernormative{\subparagraph}{Property INPUT_RANGE}{Device Types / IOMMU=
 Device / Device operations / PROBE properties / INPUT_RANGE}
+
+The driver MUST ignore \field{reserved}.
+
+\devicenormative{\subparagraph}{Property INPUT_RANGE}{Device Types / IOMMU=
 Device / Device operations / PROBE properties / INPUT_RANGE}
+
+The device SHOULD set \field{reserved} to zero.
+
+The device SHOULD NOT present more than one INPUT_RANGE property
+per endpoint.
+
+The device MAY present an INPUT_RANGE property even if it does
+not offer the VIRTIO_IOMMU_F_INPUT_RANGE feature.
+
+
+\paragraph{Property OUTPUT_SIZE}\label{sec:Device Types / IOMMU Device / D=
evice operations / PROBE properties / OUTPUT_SIZE}
+
+\begin{lstlisting}
+struct virtio_iommu_probe_output_size {
+  struct virtio_iommu_probe_property head;
+  u8=09bits_count;
+  u8=09reserved[3];
+};
+\end{lstlisting}
+
+The OUTPUT_SIZE property describes the maximum guest-physical
+address that the device supports for this endpoint.
+\field{bits_count} is the number of bits that an address can use.
+
+\drivernormative{\subparagraph}{Property OUTPUT_SIZE}{Device Types / IOMMU=
 Device / Device operations / PROBE properties / OUTPUT_SIZE}
+
+The driver MUST ignore \field{reserved}.
+
+The driver SHOULD NOT use guest-physical addresses larger than
+the size defined by \field{bits_count} in a MAP request or in a
+page table.
+
+\devicenormative{\subparagraph}{Property OUTPUT_SIZE}{Device Types / IOMMU=
 Device / Device operations / PROBE properties / OUTPUT_SIZE}
+
+The device SHOULD set \field{reserved} to zero.
+
+The device SHOULD NOT present more than one OUTPUT_SIZE property
+per endpoint.
+
+
+\paragraph{Property PASID_SIZE}\label{sec:Device Types / IOMMU Device / De=
vice operations / PROBE properties / PASID_SIZE}
+
+\begin{lstlisting}
+struct virtio_iommu_probe_pasid_size {
+  struct virtio_iommu_probe_property head;
+  u8  bits_count;
+  u8  reserved[3];
+};
+\end{lstlisting}
+
+The PASID_SIZE property describes the maximum PASID that the
+device supports for this endpoint. \field{bits_count} is the
+number of PASID bits that the device can receive in a DMA
+transaction from this endpoint. This property is conflated with
+the endpoint PASID size, obtained through a platform specific
+mechanism such as a PCIe PASID capability.
+
+\drivernormative{\subparagraph}{Property PASID_SIZE}{Device Types / IOMMU =
Device / Device operations / PROBE properties / PASID_SIZE}
+
+The driver MUST ignore \field{reserved}.
+
+The driver SHOULD NOT use PASIDs larger than the size defined by
+\field{bits_count} when updating a PASID table, or in an
+INVALIDATE request.
+
+\devicenormative{\subparagraph}{Property PASID_SIZE}{Device Types / IOMMU =
Device / Device operations / PROBE properties / PASID_SIZE}
+
+The device SHOULD set \field{reserved} to zero.
+
+The device SHOULD NOT present more than one PASID_SIZE property
+per endpoint.
+
+
+\paragraph{Property TABLE_FORMAT}\label{sec:Device Types / IOMMU Device / =
Device operations / PROBE properties / TABLE_FORMAT}
+
+\begin{lstlisting}
+struct virtio_iommu_probe_table_format {
+  struct virtio_iommu_probe_property head;
+  le16  format;
+
+  /* Format-specific fields follow */
+};
+\end{lstlisting}
+
+The TABLE_FORMAT property describes a page table or PASID table
+format that the device supports for this endpoint. The format is
+used in ATTACH_TABLE requests. Formats are described in section
+\ref{sec:Device Types / IOMMU Device / Table Formats}.
+
+\devicenormative{\subparagraph}{Property TABLE_FORMAT}{Device Types / IOMM=
U Device / Device operations / PROBE properties / TABLE_FORMAT}
+
+The device MAY present more than one TABLE_FORMAT property. If
+the device presents a PASID table format, it SHOULD also present
+a compatible page table format.
+
+
 \subsubsection{Fault reporting}\label{sec:Device Types / IOMMU Device / De=
vice operations / Fault reporting}
=20
 The device can report translation faults and other significant
--=20
2.30.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

