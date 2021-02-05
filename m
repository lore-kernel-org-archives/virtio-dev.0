Return-Path: virtio-dev-return-7981-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 21682986621
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 Feb 2021 18:02:41 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri,  5 Feb 2021 18:58:20 +0100
Message-Id: <20210205175812.143886-5-jean-philippe@linaro.org>
In-Reply-To: <20210205175812.143886-1-jean-philippe@linaro.org>
References: <20210205175812.143886-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 4/4] virtio-iommu: Add Arm 64-bit page tables
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
Cc: eric.auger@redhat.com, kevin.tian@intel.com, vivek.gautam@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Allow a driver to detect support for Arm page tables and attach a set of
tables.

When the host IOMMU is an Arm SMMUv2, a single address space per
endpoint is supported. The driver detects the Arm LPAE page table format
in a PROBE request and sends an ATTACH_TABLE request with a pointer to
the page directory.

When the host IOMMU is an Arm SMMUv3, an intermediate "Context
Descriptor" (CD) table has to be attached. That table is indexed by
PASID and contains multiple pointers to page directories:

                 CD table          Page directory
                +-------+   ,------->+-------+
                :       :   |        :       :
                +-------+   |        +-------+
         PASID->|  CD   |---'    VA->|  PTE  |--> GPA
                +-------+            +-------+
                :       :            :       :
                +-------+            +-------+

The driver detects support for both table formats in a PROBE request and
sends an ATTACH_TABLE request with a pointer to the context descriptor
table.

These features are voluntarily omitted:
* Stall, which cannot be supported without recoverable page faults. I do
  plan to implement this once we get to the I/O Page fault extensions.
* Big endian page tables.
* AArch32 LPAE format and per-armv8 short descriptor format.
* Page-based Hardware Attributes (PBHA), Auxiliary Memory Attributes
  (AMAIR)
* Memory Partioning And Monitoring (MPAM)

Support for any of these could easily be added later, by adding flags to
the PROBE property and fields in the ATTACH_TABLE config. However, most
of these extensions might never be needed.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 introduction.tex |   6 ++
 virtio-iommu.tex | 180 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 186 insertions(+)

diff --git a/introduction.tex b/introduction.tex
index bc0217f..1603726 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -76,6 +76,12 @@ \section{Normative References}\label{sec:Normative Refer=
ences}
 =09\phantomsection\label{intro:I2C}\textbf{[I2C]} &
 =09I2C-bus specification and user manual,
 =09\newline\url{https://www.nxp.com/docs/en/user-guide/UM10204.pdf}\\
+=09\phantomsection\label{intro:SMMUv3}\textbf{[SMMUv3]} &
+=09Arm System Memory Management Unit version 3
+=09\newline\url{https://developer.arm.com/documentation/ihi0070/latest} \\
+=09\phantomsection\label{intro:Armv8-A}\textbf{[ARMv8-A]} &
+=09Armv8-A Architecture Reference Manual
+=09\newline\url{https://developer.arm.com/documentation/ddi0487/latest} \\
=20
 \end{longtable}
=20
diff --git a/virtio-iommu.tex b/virtio-iommu.tex
index e14bd67..bc18342 100644
--- a/virtio-iommu.tex
+++ b/virtio-iommu.tex
@@ -1176,3 +1176,183 @@ \subsubsection{Fault reporting}\label{sec:Device Ty=
pes / IOMMU Device / Device o
 \footnotetext{This would happen for example if the device implements a
 more recent version of this specification, whose fault report contains
 additional fields.}
+
+\subsection{Table formats}\label{sec:Device Types / IOMMU Device / Table F=
ormats}
+
+Supported table formats in PROBE properties and ATTACH_TABLE
+requests are:
+\begin{description}
+  \item[VIRTIO_IOMMU_PST_ARM_SMMU3 (1)] Arm SMMUv3 Context
+    Descriptor Tables.
+  \item[VIRTIO_IOMMU_PGT_ARM64 (2)] Arm VMSAv8-64 page tables.
+\end{description}
+
+\subsubsection{Arm SMMUv3 Context Descriptor table}\label{sec:Device Types=
 / IOMMU Device / Table Formats / Arm SMMUv3 Context Descriptor}
+
+Attach Context Descriptor tables (PASID tables) in the format
+described in the \hyperref[intro:SMMUv3]{Arm System Memory
+Management Unit v3 specification}. The table contains context
+descriptors indexed by PASID, each pointing to a page directory.
+
+\paragraph{PROBE properties for Arm SMMUv3 Context Descriptor tables}\labe=
l{sec:Device Types / IOMMU Device / Table Formats / Arm SMMUv3 Context Desc=
riptor / PROBE}
+
+\begin{lstlisting}
+struct virtio_iommu_probe_pst_arm_smmu3 {
+  struct virtio_iommu_probe_property head;
+  le16  format;
+  u8    reserved[2];
+  le64  flags;
+};
+
+#define VIRTIO_IOMMU_PST_ARM_SMMU3_F_BTM    (1ULL << 0)
+\end{lstlisting}
+
+Supported flags are:
+\begin{description}
+  \item[VIRTIO_IOMMU_PST_ARM_SMMU3_F_BTM] Broadcast TLB
+    maintenance is supported. INVALIDATE requests for
+    \field{caches} VIRTIO_IOMMU_INVAL_C_TLB can be replaced by
+    broadcast TLBI instructions. INVALIDATE requests for
+    \field{caches} VIRTIO_IOMMU_INVAL_C_EP_TLB, if the endpoint
+    has PCIe ATS enabled, are still necessary.
+\end{description}
+
+\paragraph{ATTACH_TABLE request for Arm SMMUv3 Context Descriptor tables}\=
label{sec:Device Types / IOMMU Device / Table Formats / Arm SMMUv3 Context =
Descriptor / ATTACH_TABLE}
+
+\begin{lstlisting}
+struct virtio_iommu_req_attach_pst_arm_smmu3 {
+  struct virtio_iommu_req_head head;
+  le32  domain;
+  le32  endpoint;
+  le16  format;
+  u8    s1fmt;
+  u8    s1dss;
+  le64  s1contextptr;
+  u8    s1cdmax;
+  u8    reserved[51];
+  struct virtio_iommu_req_tail tail;
+};
+
+/* Stage-1 format */
+#define VIRTIO_IOMMU_PST_ARM_SMMU3_LINEAR     0x0
+#define VIRTIO_IOMMU_PST_ARM_SMMU3_4KL2       0x1
+#define VIRTIO_IOMMU_PST_ARM_SMMU3_64KL2      0x2
+
+/* Stage-1 default substream */
+#define VIRTIO_IOMMU_PST_ARM_SMMU3_DSS_TERM   0x0
+#define VIRTIO_IOMMU_PST_ARM_SMMU3_DSS_BYPASS 0x1
+#define VIRTIO_IOMMU_PST_ARM_SMMU3_DSS_0      0x2
+\end{lstlisting}
+
+\begin{description}
+  \item[\field{s1fmt}] The layout used for the context descriptor
+    table:
+    \begin{description}
+      \item{LINEAR} Single table level,
+      \item{4KL2} Two-level tables with 4KB leaf tables,
+      \item{64KL2} Two-level tables with 64KB leaf tables.
+    \end{description}
+  \item[\field{s1dss}] Default substream (PASID) behavior:
+    \begin{description}
+      \item{DSS_TERM} Transactions without a substream are
+        terminated.
+      \item{DSS_BYPASS} Transactions without a substream bypass
+        translation.
+      \item{DSS_0} Transactions without a substream use entry 0
+        of the table. Substream 0 is invalid.
+    \end{description}
+  \item[\field{s1contextptr}] Address of the context descriptor
+    table, in guest-physical address space.
+  \item[\field{s1cdmax}] Size of the table. $2^\field{s1cdmax}$
+    is the number of context descriptors.
+\end{description}
+
+\drivernormative{\subparagraph}{ATTACH_TABLE request for Arm SMMUv3 Contex=
t Descriptor tables}{Device Types / IOMMU Device / Table Formats / Arm SMMU=
v3 Context Descriptor / ATTACH_TABLE}
+
+\field{s1contextptr} MUST be aligned on 64 bytes.
+
+\field{s1cdmax} MUST be less than or equal to \field{bits_count}
+in the VIRTIO_IOMMU_PROBE_T_PASID_SIZE property.
+
+\subsubsection{Arm 64-bit page tables}\label{sec:Device Types / IOMMU Devi=
ce / Table Formats / Arm64}
+
+Attach page tables in the Arm VMSAv8-64 format, as described by
+the \hyperref[intro:Armv8-A]{Armv8-A Architecture Reference
+Manual}. The descriptors are little-endian.
+
+\paragraph{PROBE properties for Arm 64-bit page tables}\label{sec:Device T=
ypes / IOMMU Device / Table Formats / Arm64 / PROBE}
+
+\begin{lstlisting}
+struct virtio_iommu_probe_pgt_arm64 {
+  struct virtio_iommu_probe_property head;
+  le16  format;
+  u8    reserved[2];
+  le64  flags;
+};
+
+#define VIRTIO_IOMMU_PGT_ARM64_F_ASID16     (1ULL << 1)
+#define VIRTIO_IOMMU_PGT_ARM64_F_HW_ACCESS  (1ULL << 2)
+#define VIRTIO_IOMMU_PGT_ARM64_F_HW_DIRTY   (1ULL << 3)
+\end{lstlisting}
+
+\begin{description}
+  \item[VIRTIO_IOMMU_PGT_ARM64_F_ASID16] ASIDs can be up to 16
+    bits. When unset, ASID are only 8 bits.
+  \item[VIRTIO_IOMMU_PGT_ARM64_F_HW_ACCESS] Hardware management
+    of the access bit. The device can write the access bit in page
+    table entries.
+  \item[VIRTIO_IOMMU_PGT_ARM64_F_HW_DIRTY] Hardware management of
+    the dirty bit. The device can set the dirty bit in page table
+    entries.
+\end{description}
+
+\paragraph{ATTACH_TABLE request for Arm 64-bit page tables}\label{sec:Devi=
ce Types / IOMMU Device / Table Formats / Arm64 / ATTACH_TABLE}
+
+Attach a single set of page tables to an endpoint.
+
+\begin{lstlisting}
+struct virtio_iommu_req_attach_pgt_arm64 {
+  struct virtio_iommu_req_head head;
+  le32  domain;
+  le32  endpoint;
+  le16  format;
+  u8    reserved[2]
+  le64  tcr;
+  le64  ttbr0;
+  le64  ttbr1;
+  le64  mair;
+  u8    reserved1[32];
+  struct virtio_iommu_req_tail tail;
+};
+\end{lstlisting}
+
+\begin{description}
+  \item[\field{tcr}] Translation Control Registers, corresponding
+    to TCR_EL1 described in the Armv8-A Architecture Reference
+    Manual.
+  \item[\field{ttbr0}] Translation Table Base Register
+    corresponding to TTBR0_EL1.
+  \item[\field{ttbr1}] Translation Table Base Register
+    corresponding to TTBR1_EL1.
+  \item[\field{mair}] Memory Attribute Index Register
+    corresponding to MAIR_EL1.
+\end{description}
+
+\drivernormative{\subparagraph}{ATTACH_TABLE request for Arm 64-bit page t=
ables}{Device Types / IOMMU Device / Table Formats / Arm64 / ATTACH_TABLE}
+
+The driver SHOULD set fields \field{reserved} and
+\field{reserved1} to zero.
+
+If the endpoint supports a Context Descriptor table format, the
+driver SHOULD NOT send an ATTACH_TABLE request with Arm 64-bit
+tables. It SHOULD instead attach a Context Descriptor table.
+
+\devicenormative{\subparagraph}{ATTACH_TABLE request for Arm 64-bit page t=
ables}{Device Types / IOMMU Device / Table Formats / Arm64 / ATTACH_TABLE}
+
+The device MUST ignore fields \field{reserved} and
+\field{reserved1}.
+
+\paragraph{INVALIDATE request for Arm 64-bit page tables}\label{sec:Device=
 Types / IOMMU Device / Table Formats / Arm64 / INVALIDATE}
+
+Bits [15:0] of \field{id} in an INVALIDATE request correspond to
+the address space ID (ASID) of the page directory.
--=20
2.30.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

