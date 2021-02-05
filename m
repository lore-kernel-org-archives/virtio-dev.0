Return-Path: virtio-dev-return-7979-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 73DA7986621
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 Feb 2021 18:02:24 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri,  5 Feb 2021 18:58:16 +0100
Message-Id: <20210205175812.143886-3-jean-philippe@linaro.org>
In-Reply-To: <20210205175812.143886-1-jean-philippe@linaro.org>
References: <20210205175812.143886-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 2/4] virtio-iommu: Add INVALIDATE request
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
Cc: eric.auger@redhat.com, kevin.tian@intel.com, vivek.gautam@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Add a request that invalidates mappings of a domain attached with table.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 virtio-iommu.tex | 151 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/virtio-iommu.tex b/virtio-iommu.tex
index 840f897..1ca2638 100644
--- a/virtio-iommu.tex
+++ b/virtio-iommu.tex
@@ -169,6 +169,7 @@ \subsection{Device operations}\label{sec:Device Types /=
 IOMMU Device / Device op
 #define VIRTIO_IOMMU_T_UNMAP        4
 #define VIRTIO_IOMMU_T_PROBE        5
 #define VIRTIO_IOMMU_T_ATTACH_TABLE 6
+#define VIRTIO_IOMMU_T_INVALIDATE   7
 \end{lstlisting}
=20
 A few general-purpose status codes are defined here.
@@ -612,6 +613,156 @@ \subsubsection{UNMAP request}\label{sec:Device Types =
/ IOMMU Device / Device ope
 mapping, then the device SHOULD remove all mappings affected by the range
 and set the request \field{status} to VIRTIO_IOMMU_S_OK.
=20
+\subsubsection{INVALIDATE request}\label{sec:Device Types / IOMMU Device /=
 Device operations / INVALIDATE request}
+
+\begin{lstlisting}
+struct virtio_iommu_req_invalidate {
+  struct virtio_iommu_req_head head;
+  u8    scope;
+  u8    caches;
+  le16  flags;
+  le32  domain;
+  le32  pasid;
+  le64  id;
+  le64  virt_start;
+  le64  nr_pages;
+  u8    page_size;
+  u8    reserved[19];
+  struct virtio_iommu_req_tail tail;
+};
+
+#define VIRTIO_IOMMU_INVAL_S_DOMAIN   1
+#define VIRTIO_IOMMU_INVAL_S_PASID    2
+#define VIRTIO_IOMMU_INVAL_S_ADDRESS  3
+
+#define VIRTIO_IOMMU_INVAL_C_PASID    (1 << 0)
+#define VIRTIO_IOMMU_INVAL_C_TLB      (1 << 1)
+#define VIRTIO_IOMMU_INVAL_C_EP_TLB   (1 << 2)
+
+#define VIRTIO_IOMMU_INVAL_F_LEAF     (1 << 0)
+#define VIRTIO_IOMMU_INVAL_F_PASID    (1 << 1)
+#define VIRTIO_IOMMU_INVAL_F_ID       (1 << 2)
+
+\end{lstlisting}
+
+Invalidate a mapping or configuration. When using PASID or page
+tables, the driver sends an INVALIDATE request to signal changes
+to table elements that could have been cached by the device, such
+as a mapping removal.
+
+Field \field{scope} specifies which entries to invalidate:
+\begin{description}
+  \item[VIRTIO_IOMMU_INVAL_S_DOMAIN] invalidates all cached
+    entries for the given \field{domain}.
+  \item[VIRTIO_IOMMU_INVAL_S_PASID] invalidates all cached
+    entries for the given \field{domain} and \field{pasid}.
+  \item[VIRTIO_IOMMU_INVAL_S_ADDRESS] invalidates all cached
+    entries for the given \field{domain}, \field{pasid} and
+    virtual address range.
+\end{description}
+
+Field \field{caches} specifies which caches to invalidate:
+\begin{description}
+  \item[VIRTIO_IOMMU_INVAL_C_PASID] Invalidate entries cached
+    from the PASID table.
+  \item[VIRTIO_IOMMU_INVAL_C_TLB] Invalidate entries from the
+    Translation Lookaside Buffer (TLB).
+  \item[VIRTIO_IOMMU_INVAL_C_EP_TLB] Invalidate entries from the
+    TLB of endpoints attached to the domain. For example when a
+    PCIe endpoint has an Address Translation Cache (ATC),
+    discovered and enabled through the PCIe ATS capability.
+\end{description}
+
+For example, when the driver removes a mapping from a table
+attached to the \field{domain}, it sends an INVALIDATE request
+with \field{scope} VIRTIO_IOMMU_INVAL_S_ADDRESS, \field{caches}
+VIRTIO_IOMMU_INVAL_C_TLB and, if necessary,
+VIRTIO_IOMMU_INVAL_C_EP_TLB. To invalidate the whole address
+space the driver sets the \field{scope} to
+VIRTIO_IOMMU_INVAL_S_DOMAIN, or to VIRTIO_IOMMU_INVAL_S_PASID
+when using a PASID table. When removing a page table directory
+from a PASID table entry, the driver sends an INVALIDATE request
+with \field{scope} VIRTIO_IOMMU_INVAL_S_PASID, and all
+\field{caches} flags set.
+
+Field \field{flags} specifies additional information:
+\begin{description}
+  \item[VIRTIO_IOMMU_INVAL_F_LEAF] Only invalidate TLB entries
+    cached from leaf table entries.
+  \item[VIRTIO_IOMMU_INVAL_F_PASID] The \field{pasid} field is
+    valid.
+  \item[VIRTIO_IOMMU_INVAL_F_ID] The \field{id} field is valid.
+\end{description}
+
+Use of field \field{id} is specific to the table format. Some
+formats use only the PASID to identify address spaces within a
+domain, others use a separate ID for TLB entries.
+
+For a \field{scope} of VIRTIO_IOMMU_INVAL_S_ADDRESS, the
+invalidation affects the range of virtual addresses of size
+$\field{nr\_pages} \times 2^\field{page\_size}$, starting at
+\field{virt_start}. Specifying the range size this way allows the
+device to efficiently remove TLB entries. For example a page
+table format could allow a 2MiB range to be mapped with either
+512 4KiB pages, or a single 2MiB block. In the latter case a
+single TLB entry is used, so the driver specifies a
+\field{page_size} of 21 and the device does not need to iterate
+over all 4KiB multiples to invalidate the range.
+
+The following table describes the restricted set of valid
+\field{caches}, \field{flags} and fields for each \field{scope}:
+
+\begin{tabular}{|l|c|c|c|}
+\hline
+  \field{scope}       & DOMAIN      & PASID               & ADDRESS \\
+\hline
+  \field{caches}      & PASID, TLB  & PASID, TLB, EP_TLB  & TLB, EP_TLB \\
+  \field{flags}       & ID          & LEAF, PASID, ID     & LEAF, PASID, I=
D \\
+  \field{domain}      & Y           & Y                   & Y \\
+  \field{pasid}       & N           & Y                   & Y \\
+  \field{id}          & Y           & Y                   & Y \\
+  \field{virt_start}  & N           & N                   & Y \\
+  \field{nr_pages}    & N           & N                   & Y \\
+  \field{page_size}   & N           & N                   & Y \\
+\hline
+\end{tabular}
+
+\devicenormative{\paragraph}{INVALIDATE request}{Device Types / IOMMU Devi=
ce / Device operations / INVALIDATE request}
+
+After handling an INVALIDATE request, the device SHOULD NOT let
+endpoints attached to \field{domain} access virtual address in
+the invalidated range, unless the range is valid in the table
+attached to the \field{domain}. In other words, the device SHOULD
+access the virtual address through the attached tables instead of
+a cache.
+
+For a \field{scope} of VIRTIO_IOMMU_INVAL_S_DOMAIN, the device
+SHOULD ignore fields \field{pasid}, \field{virt_start},
+\field{nr_pages} and \field{page_size}.
+
+For a \field{scope} of VIRTIO_IOMMU_INVAL_S_PASID, the device
+SHOULD ignore fields \field{virt_start}, \field{nr_pages},
+\field{page_size},
+
+If no cache entry exist for the given parameters, the device
+SHOULD set the \field{status} field to VIRTIO_IOMMU_S_OK. In
+other words, spurious invalidations are allowed.
+
+The device MAY ignore flag VIRTIO_IOMMU_INVAL_F_LEAF.
+
+\drivernormative{\paragraph}{INVALIDATE request}{Device Types / IOMMU Devi=
ce / Device operations / INVALIDATE request}
+
+\field{domain} MUST have been created with an ATTACH_TABLE
+request.
+
+For a \field{scope} of VIRTIO_IOMMU_INVAL_S_DOMAIN, the driver
+SHOULD set fields \field{pasid}, \field{virt_start},
+\field{nr_pages} and \field{page_size} to zero.
+
+For a \field{scope} of VIRTIO_IOMMU_INVAL_S_PASID, the driver
+SHOULD set fields \field{virt_start}, \field{nr_pages},
+\field{page_size} to zero.
+
 \subsubsection{PROBE request}\label{sec:Device Types / IOMMU Device / Devi=
ce operations / PROBE request}
=20
 If the VIRTIO_IOMMU_F_PROBE feature bit is present, the driver sends a
--=20
2.30.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

