Return-Path: virtio-dev-return-7978-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 48636986621
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 Feb 2021 18:02:08 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri,  5 Feb 2021 18:58:14 +0100
Message-Id: <20210205175812.143886-2-jean-philippe@linaro.org>
In-Reply-To: <20210205175812.143886-1-jean-philippe@linaro.org>
References: <20210205175812.143886-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 1/4] virtio-iommu: Add ATTACH_TABLE request
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
Cc: eric.auger@redhat.com, kevin.tian@intel.com, vivek.gautam@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Add a way to attach page tables to a domain. Only introduces the feature
bit and the ATTACH_TABLE request. We'll also need new PROBE properties
and INVALIDATE requests.

I chose ATTACH_TABLE request rather than ATTACH followed by SET_TABLE
because it leads to fewer domain states. With ATTACH_TABLE a domain can
be free, attached-with-map or attached-with-pgtable. With
ATTACH+SET_TABLE, a domain can be free, attached, attached-with-map or
attached-with-pgtable. I believe managing state transitions for
ATTACH_TABLE is simpler.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 virtio-iommu.tex | 74 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 9 deletions(-)

diff --git a/virtio-iommu.tex b/virtio-iommu.tex
index efa735b..840f897 100644
--- a/virtio-iommu.tex
+++ b/virtio-iommu.tex
@@ -54,9 +54,7 @@ \subsection{Feature bits}\label{sec:Device Types / IOMMU =
Device / Feature bits}
   The number of domains supported is described in \field{domain_range}.
=20
 \item[VIRTIO_IOMMU_F_MAP_UNMAP (2)]
-  Map and unmap requests are available.\footnote{Future extensions may add
-  different modes of operations. At the moment, only
-  VIRTIO_IOMMU_F_MAP_UNMAP is supported.}
+  Map and unmap requests are available.
=20
 \item[VIRTIO_IOMMU_F_BYPASS (3)]
   When not attached to a domain, endpoints downstream of the IOMMU
@@ -67,6 +65,9 @@ \subsection{Feature bits}\label{sec:Device Types / IOMMU =
Device / Feature bits}
=20
 \item[VIRTIO_IOMMU_F_MMIO (5)]
   The VIRTIO_IOMMU_MAP_F_MMIO flag is available.
+
+\item[VIRTIO_IOMMU_F_ATTACH_TABLE (6)]
+  The ATTACH_TABLE and INVALIDATE requests are available.
 \end{description}
=20
 \drivernormative{\subsubsection}{Feature bits}{Device Types / IOMMU Device=
 / Feature bits}
@@ -77,7 +78,8 @@ \subsection{Feature bits}\label{sec:Device Types / IOMMU =
Device / Feature bits}
=20
 \devicenormative{\subsubsection}{Feature bits}{Device Types / IOMMU Device=
 / Feature bits}
=20
-The device SHOULD offer feature bit VIRTIO_IOMMU_F_MAP_UNMAP.
+The device MUST offer at least one of the
+VIRTIO_IOMMU_F_MAP_UNMAP or VIRTIO_IOMMU_F_ATTACH_TABLE features.
=20
 \subsection{Device configuration layout}\label{sec:Device Types / IOMMU De=
vice / Device configuration layout}
=20
@@ -161,11 +163,12 @@ \subsection{Device operations}\label{sec:Device Types=
 / IOMMU Device / Device op
 Type may be one of:
=20
 \begin{lstlisting}
-#define VIRTIO_IOMMU_T_ATTACH     1
-#define VIRTIO_IOMMU_T_DETACH     2
-#define VIRTIO_IOMMU_T_MAP        3
-#define VIRTIO_IOMMU_T_UNMAP      4
-#define VIRTIO_IOMMU_T_PROBE      5
+#define VIRTIO_IOMMU_T_ATTACH       1
+#define VIRTIO_IOMMU_T_DETACH       2
+#define VIRTIO_IOMMU_T_MAP          3
+#define VIRTIO_IOMMU_T_UNMAP        4
+#define VIRTIO_IOMMU_T_PROBE        5
+#define VIRTIO_IOMMU_T_ATTACH_TABLE 6
 \end{lstlisting}
=20
 A few general-purpose status codes are defined here.
@@ -301,6 +304,10 @@ \subsubsection{ATTACH request}\label{sec:Device Types =
/ IOMMU Device / Device op
 The driver SHOULD ensure that endpoints that cannot be isolated from each
 other are attached to the same domain.
=20
+The driver SHOULD NOT create the \field{domain} with an ATTACH
+request if the VIRTIO_IOMMU_F_MAP_UNMAP feature was not
+negotiated. In this case the ATTACH_TABLE request is used.
+
 \devicenormative{\paragraph}{ATTACH request}{Device Types / IOMMU Device /=
 Device operations / ATTACH request}
=20
 If the \field{reserved} field of an ATTACH request is not zero, the device
@@ -330,6 +337,49 @@ \subsubsection{ATTACH request}\label{sec:Device Types =
/ IOMMU Device / Device op
=20
 A device that does not reject the request MUST attach the endpoint.
=20
+\subsubsection{ATTACH_TABLE request}\label{ref:Device Types / IOMMU Device=
 / Device operations / ATTACH_TABLE request}
+
+\begin{lstlisting}
+struct virtio_iommu_req_attach_table {
+=09struct virtio_iommu_req_head head;
+=09le32 domain;
+=09le32 endpoint;
+=09le16 format;
+=09u8   descriptor[62];
+=09struct virtio_iommu_req_tail tail;
+};
+\end{lstlisting}
+
+Attach an endpoint to a domain, in the same way as an ATTACH
+request. In addition, provide a pointer to a table describing the
+mappings. Instead of using MAP and UNMAP requests, the driver
+creates and removes mappings by writing into the tables. When a
+mapping that may have been cached in a TLB is removed, the driver
+sends an INVALIDATE request.
+
+The driver discovers with a PROBE request the table formats
+supported by the device. The device can support multiple page
+tables and PASID table formats. A PASID table contains pointers
+to one or more page tables. The driver chooses a format it
+recognises, and sends the ATTACH_TABLE request.
+
+Apart from \field{domain}, \field{endpoint} and \field{format},
+each table format uses different parameters in field
+\field{descriptor}. Table formats and their associated parameters
+are described in section \ref{sec:Device Types / IOMMU Device /
+Table Formats}.
+
+\drivernormative{\paragraph}{ATTACH_TABLE request}{Device Types / IOMMU De=
vice / Device operations / ATTACH_TABLE request}
+
+The driver SHOULD NOT send ATTACH_TABLE requests if the
+VIRTIO_IOMMU_F_ATTACH_TABLE feature was not negotiated.
+
+The driver SHOULD NOT send ATTACH_TABLE requests with an existing
+\field{domain}. To attach additional endpoints to a domain
+created with ATTACH_DOMAIN, the driver SHOULD send an ATTACH
+request. All endpoints attached to a domain MUST support the same
+table formats.
+
 \subsubsection{DETACH request}
=20
 \begin{lstlisting}
@@ -446,6 +496,9 @@ \subsubsection{MAP request}\label{sec:Device Types / IO=
MMU Device / Device opera
 If the VIRTIO_IOMMU_F_MMIO feature isn't negotiated, the driver MUST NOT
 use the VIRTIO_IOMMU_MAP_F_MMIO flag.
=20
+\field{domain} SHOULD NOT have been created with an ATTACH_TABLE
+request.
+
 \devicenormative{\paragraph}{MAP request}{Device Types / IOMMU Device / De=
vice operations / MAP request}
=20
 If \field{virt_start}, \field{phys_start} or (\field{virt_end} + 1) is
@@ -538,6 +591,9 @@ \subsubsection{UNMAP request}\label{sec:Device Types / =
IOMMU Device / Device ope
 or be outside any mapping. The last address of a range MUST either be the
 last address of a mapping or be outside any mapping.
=20
+\field{domain} SHOULD NOT have been created with an ATTACH_TABLE
+request.
+
 \devicenormative{\paragraph}{UNMAP request}{Device Types / IOMMU Device / =
Device operations / UNMAP request}
=20
 If the \field{reserved} field of an UNMAP request is not zero, the device
--=20
2.30.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

