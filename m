Return-Path: virtio-comment-return-720-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Date: Tue, 30 Apr 2019 14:56:48 +0100
Message-Id: <20190430135648.38369-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-comment] [PATCH v3] Add virtio-iommu device specification
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: joro@8bytes.org, tnowicki@caviumnetworks.com, eric.auger@redhat.com, kevin.tian@intel.com, lorenzo.pieralisi@arm.com, bharat.bhushan@nxp.com, mst@redhat.com, bauerman@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

The IOMMU device allows a guest to manage DMA mappings for physical,
emulated and paravirtualized endpoints. Add device description for the
virtio-iommu device and driver. Introduce PROBE, ATTACH, DETACH, MAP and
UNMAP requests, as well as translation error reporting.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/37
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
Since v2 I rebased onto virtio v1.1-wd02, fixing a conflict in
conformance.tex and using the new \conformance command.

A PDF version is available at
https://jpbrucker.net/virtio-iommu/spec/virtio-v1.1-wd02-iommu-0.11-draft.pdf
---
 conformance.tex  |  40 ++-
 content.tex      |   1 +
 virtio-iommu.tex | 850 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 889 insertions(+), 2 deletions(-)
 create mode 100644 virtio-iommu.tex

diff --git a/conformance.tex b/conformance.tex
index 42f702a..79a3e7d 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -15,14 +15,14 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
   \begin{itemize}
     \item Clause \ref{sec:Conformance / Driver Conformance}.
     \item One of clauses \ref{sec:Conformance / Driver Conformance / PCI Driver Conformance}, \ref{sec:Conformance / Driver Conformance / MMIO Driver Conformance} or \ref{sec:Conformance / Driver Conformance / Channel I/O Driver Conformance}.
-    \item One of clauses \ref{sec:Conformance / Driver Conformance / Network Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Block Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Console Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Entropy Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Traditional Memory Balloon Driver Conformance}, \ref{sec:Conformance / Driver Conformance / SCSI Host Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Input Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Crypto Driver Conformance} or \ref{sec:Conformance / Driver Conformance / Socket Driver Conformance}.
+    \item One of clauses \ref{sec:Conformance / Driver Conformance / Network Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Block Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Console Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Entropy Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Traditional Memory Balloon Driver Conformance}, \ref{sec:Conformance / Driver Conformance / SCSI Host Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Input Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Crypto Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Socket Driver Conformance} or \ref{sec:Conformance / Driver Conformance / IOMMU Driver Conformance}.
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
 \item[Device] A device MUST conform to four conformance clauses:
   \begin{itemize}
     \item Clause \ref{sec:Conformance / Device Conformance}.
     \item One of clauses \ref{sec:Conformance / Device Conformance / PCI Device Conformance}, \ref{sec:Conformance / Device Conformance / MMIO Device Conformance} or \ref{sec:Conformance / Device Conformance / Channel I/O Device Conformance}.
-    \item One of clauses \ref{sec:Conformance / Device Conformance / Network Device Conformance}, \ref{sec:Conformance / Device Conformance / Block Device Conformance}, \ref{sec:Conformance / Device Conformance / Console Device Conformance}, \ref{sec:Conformance / Device Conformance / Entropy Device Conformance}, \ref{sec:Conformance / Device Conformance / Traditional Memory Balloon Device Conformance}, \ref{sec:Conformance / Device Conformance / SCSI Host Device Conformance}, \ref{sec:Conformance / Device Conformance / Input Device Conformance}, \ref{sec:Conformance / Device Conformance / Crypto Device Conformance} or \ref{sec:Conformance / Device Conformance / Socket Device Conformance}.
+    \item One of clauses \ref{sec:Conformance / Device Conformance / Network Device Conformance}, \ref{sec:Conformance / Device Conformance / Block Device Conformance}, \ref{sec:Conformance / Device Conformance / Console Device Conformance}, \ref{sec:Conformance / Device Conformance / Entropy Device Conformance}, \ref{sec:Conformance / Device Conformance / Traditional Memory Balloon Device Conformance}, \ref{sec:Conformance / Device Conformance / SCSI Host Device Conformance}, \ref{sec:Conformance / Device Conformance / Input Device Conformance}, \ref{sec:Conformance / Device Conformance / Crypto Device Conformance}, \ref{sec:Conformance / Device Conformance / Socket Device Conformance} or \ref{sec:Conformance / Device Conformance / IOMMU Device Conformance}.
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
 \end{description}
@@ -183,6 +183,24 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Device Types / Socket Device / Device Operation / Device Events}
 \end{itemize}
 
+\conformance{\subsection}{IOMMU Driver Conformance}\label{sec:Conformance / Driver Conformance / IOMMU Driver Conformance}
+
+An IOMMU driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / IOMMU Device / Feature bits}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device configuration layout}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device Initialization}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations / ATTACH request}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations / DETACH request}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations / MAP request}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations / UNMAP request}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations / PROBE request}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations / PROBE properties / RESVMEM}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations / Fault reporting}
+\end{itemize}
+
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
 
 A device MUST conform to the following normative statements:
@@ -336,6 +354,24 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Device Types / Socket Device / Device Operation / Receive and Transmit}
 \end{itemize}
 
+\conformance{\subsection}{IOMMU Device Conformance}\label{sec:Conformance / Device Conformance / IOMMU Device Conformance}
+
+An IOMMU device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / IOMMU Device / Feature bits}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device configuration layout}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device Initialization}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations / ATTACH request}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations / DETACH request}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations / MAP request}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations / UNMAP request}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations / PROBE request}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations / PROBE properties / RESVMEM}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations / Fault reporting}
+\end{itemize}
+
 \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
 non-transitional, see \ref{intro:Legacy
diff --git a/content.tex b/content.tex
index 193b6e1..5449a46 100644
--- a/content.tex
+++ b/content.tex
@@ -5594,6 +5594,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 \input{virtio-input.tex}
 \input{virtio-crypto.tex}
 \input{virtio-vsock.tex}
+\input{virtio-iommu.tex}
 
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
diff --git a/virtio-iommu.tex b/virtio-iommu.tex
new file mode 100644
index 0000000..be3dcd3
--- /dev/null
+++ b/virtio-iommu.tex
@@ -0,0 +1,850 @@
+\section{IOMMU device}\label{sec:Device Types / IOMMU Device}
+
+The virtio-iommu device manages Direct Memory Access (DMA) from one or
+more endpoints. It may act both as a proxy for physical IOMMUs managing
+devices assigned to the guest, and as virtual IOMMU managing emulated and
+paravirtualized devices.
+
+The driver first discovers endpoints managed by the virtio-iommu device
+using standard firmware mechanisms. It then sends requests to create
+virtual address spaces and virtual-to-physical mappings for these
+endpoints. In its simplest form, the virtio-iommu supports four request
+types:
+
+\begin{enumerate}
+\item Create a domain and attach an endpoint to it.  \\
+  \texttt{attach(endpoint = 0x8, domain = 1)}
+\item Create a mapping between a range of guest-virtual and guest-physical
+  address. \\
+  \texttt{map(domain = 1, virt_start = 0x1000, virt_end = 0x1fff,
+          phys = 0xa000, flags = READ)}
+
+  Endpoint 0x8, for example a hardware PCI endpoint with BDF 00:01.0, can
+  now read at addresses 0x1000-0x1fff. These accesses are translated
+  into system-physical addresses by the IOMMU.
+
+\item Remove the mapping.\\
+  \texttt{unmap(domain = 1, virt_start = 0x1000, virt_end = 0x1fff)}
+
+  Any access to addresses 0x1000-0x1fff by endpoint 0x8 would now be
+  rejected.
+\item Detach the device and remove the domain.\\
+  \texttt{detach(endpoint = 0x8, domain = 1)}
+\end{enumerate}
+
+\subsection{Device ID}\label{sec:Device Types / IOMMU Device / Device ID}
+
+23
+
+\subsection{Virtqueues}\label{sec:Device Types / IOMMU Device / Virtqueues}
+
+\begin{description}
+\item[0] requestq
+\item[1] eventq
+\end{description}
+
+\subsection{Feature bits}\label{sec:Device Types / IOMMU Device / Feature bits}
+
+\begin{description}
+\item[VIRTIO_IOMMU_F_INPUT_RANGE (0)]
+  Available range of virtual addresses is described in \field{input_range}
+
+\item[VIRTIO_IOMMU_F_DOMAIN_BITS (1)]
+  The number of domains supported is described in \field{domain_bits}
+
+\item[VIRTIO_IOMMU_F_MAP_UNMAP (2)]
+  Map and unmap requests are available.\footnote{Future extensions may add
+  different modes of operations. At the moment, only
+  VIRTIO_IOMMU_F_MAP_UNMAP is supported.}
+
+\item[VIRTIO_IOMMU_F_BYPASS (3)]
+  When not attached to a domain, endpoints downstream of the IOMMU
+  can access the guest-physical address space.
+
+\item[VIRTIO_IOMMU_F_PROBE (4)]
+  The PROBE request is available.
+\end{description}
+
+\drivernormative{\subsubsection}{Feature bits}{Device Types / IOMMU Device / Feature bits}
+
+The driver SHOULD accept any of the VIRTIO_IOMMU_F_INPUT_RANGE,
+VIRTIO_IOMMU_F_DOMAIN_BITS, VIRTIO_IOMMU_F_MAP_UNMAP and
+VIRTIO_IOMMU_F_PROBE feature bits if offered by the device.
+
+\devicenormative{\subsubsection}{Feature bits}{Device Types / IOMMU Device / Feature bits}
+
+If the device offers any of VIRTIO_IOMMU_F_INPUT_RANGE,
+VIRTIO_IOMMU_F_DOMAIN_BITS, VIRTIO_IOMMU_F_PROBE or
+VIRTIO_IOMMU_F_MAP_UNMAP feature bits, and if the driver did not accept
+this feature bit, then the device MAY signal failure by failing to set
+FEATURES_OK \field{device status} bit when the driver writes it.
+
+\subsection{Device configuration layout}\label{sec:Device Types / IOMMU Device / Device configuration layout}
+
+The \field{page_size_mask} field is always present. Availability of the
+others depend on various feature bits as indicated above.
+
+\begin{lstlisting}
+struct virtio_iommu_config {
+  u64 page_size_mask;
+  struct virtio_iommu_range {
+    u64 start;
+    u64 end;
+  } input_range;
+  u8  domain_bits;
+  u8  padding[3];
+  u32 probe_size;
+};
+\end{lstlisting}
+
+\drivernormative{\subsubsection}{Device configuration layout}{Device Types / IOMMU Device / Device configuration layout}
+
+The driver MUST NOT write to device configuration fields.
+
+\devicenormative{\subsubsection}{Device configuration layout}{Device Types / IOMMU Device / Device configuration layout}
+
+The device SHOULD set \field{padding} to zero.
+
+The device MUST set at least one bit in \field{page_size_mask}, describing
+the page granularity. The device MAY set more than one bit in
+\field{page_size_mask}.
+
+\subsection{Device initialization}\label{sec:Device Types / IOMMU Device / Device initialization}
+
+When the device is reset, endpoints are not attached to any domain.
+If the VIRTIO_IOMMU_F_BYPASS feature is negotiated, all endpoints can
+access guest-physical addresses ("bypass mode"). If the feature is not
+negotiated, then any memory access from endpoints will fault. Upon
+attaching an endpoint in bypass mode to a new domain, any memory access
+from the endpoint will fault, since the domain does not contain any
+mapping.
+
+The driver chooses operating mode depending on its capabilities. In this
+version of the virtio-iommu device, the only supported mode is
+VIRTIO_IOMMU_F_MAP_UNMAP.
+
+\drivernormative{\subsubsection}{Device Initialization}{Device Types / IOMMU Device / Device Initialization}
+
+The driver MUST NOT negotiate VIRTIO_IOMMU_F_MAP_UNMAP if it is incapable
+of sending VIRTIO_IOMMU_T_MAP and VIRTIO_IOMMU_T_UNMAP requests.
+
+If the VIRTIO_IOMMU_F_PROBE feature is negotiated, the driver SHOULD send a
+VIRTIO_IOMMU_T_PROBE request for each endpoint before attaching the
+endpoint to a domain.
+
+\devicenormative{\subsubsection}{Device Initialization}{Device Types / IOMMU Device / Device Initialization}
+
+If the driver does not accept the VIRTIO_IOMMU_F_BYPASS feature, the
+device SHOULD NOT let endpoints access the guest-physical address space.
+
+\subsection{Device operations}\label{sec:Device Types / IOMMU Device / Device operations}
+
+Driver send requests on the request virtqueue, notifies the device and
+waits for the device to return the request with a status in the used ring.
+All requests are split in two parts: one device-readable, one device-
+writable.
+
+\begin{lstlisting}
+struct virtio_iommu_req_head {
+  u8   type;
+  u8   reserved[3];
+};
+
+struct virtio_iommu_req_tail {
+  u8   status;
+  u8   reserved[3];
+};
+\end{lstlisting}
+
+Type may be one of:
+
+\begin{lstlisting}
+#define VIRTIO_IOMMU_T_ATTACH     1
+#define VIRTIO_IOMMU_T_DETACH     2
+#define VIRTIO_IOMMU_T_MAP        3
+#define VIRTIO_IOMMU_T_UNMAP      4
+#define VIRTIO_IOMMU_T_PROBE      5
+\end{lstlisting}
+
+A few general-purpose status codes are defined here. Unless explicitly
+described in a \textbf{Requirements} section, these values are hints to
+make troubleshooting easier.
+
+When the device fails to parse a request, for instance if a request seems
+too small for its type and the device cannot find the tail, then it will
+be unable to set \field{status}. In that case, it should return the
+buffers without writing in them.
+
+\begin{lstlisting}
+/* All good! Carry on. */
+#define VIRTIO_IOMMU_S_OK         0
+/* Virtio communication error */
+#define VIRTIO_IOMMU_S_IOERR      1
+/* Unsupported request */
+#define VIRTIO_IOMMU_S_UNSUPP     2
+/* Internal device error */
+#define VIRTIO_IOMMU_S_DEVERR     3
+/* Invalid parameters */
+#define VIRTIO_IOMMU_S_INVAL      4
+/* Out-of-range parameters */
+#define VIRTIO_IOMMU_S_RANGE      5
+/* Entry not found */
+#define VIRTIO_IOMMU_S_NOENT      6
+/* Bad address */
+#define VIRTIO_IOMMU_S_FAULT      7
+\end{lstlisting}
+
+Range limits of some request fields are described in the device
+configuration:
+
+\begin{itemize}
+\item \field{page_size_mask} contains the bitmask of all page sizes that
+  can be mapped. The least significant bit set defines the page
+  granularity of IOMMU mappings. Other bits in the mask are hints
+  describing page sizes that the IOMMU can merge into a single mapping
+  (page blocks).
+
+  The smallest page granularity supported by the IOMMU is one byte. It is
+  legal for the driver to map one byte at a time if bit 0 of
+  \field{page_size_mask} is set.
+
+\item If the VIRTIO_IOMMU_F_DOMAIN_BITS feature is offered,
+  \field{domain_bits} contains the number of bits supported in a domain
+  ID, the identifier used in most requests. A value of 0 is valid, it
+  means that a single domain is supported and endpoints can only be
+  attached to domain 0.
+
+  If the feature is not offered, domain identifiers can use up to 32 bits.
+
+\item If the VIRTIO_IOMMU_F_INPUT_RANGE feature is offered,
+  \field{input_range} contains the virtual address range that the IOMMU is
+  able to translate. Any mapping request to virtual addresses outside of
+  this range will fail.
+
+  If the feature is not offered, virtual mappings span over the whole
+  64-bit address space (\texttt{start = 0, end = 0xffffffff ffffffff})
+\end{itemize}
+
+\drivernormative{\subsubsection}{Device operations}{Device Types / IOMMU Device / Device operations}
+
+The driver SHOULD set field \field{reserved} of
+\verb+struct virtio_iommu_req_head+ to zero.
+
+When a device returns a complete request in the used queue without having
+written to it, the driver SHOULD interpret it as a failure from the device
+to parse the request.
+
+If the VIRTIO_IOMMU_F_INPUT_RANGE feature is negotiated, the driver SHOULD
+NOT send requests with \field{virt_start} less than
+\field{input_range.start} or \field{virt_end} greater than
+\field{input_range.end}.
+
+If the VIRTIO_IOMMU_F_DOMAIN_BITS feature is negotiated, the driver SHOULD
+NOT send requests with \field{domain} greater than the size described by
+\field{domain_bits}.
+
+The driver SHOULD NOT use multiple descriptor chains for a single request.
+
+\devicenormative{\subsubsection}{Device operations}{Device Types / IOMMU Device / Device operations}
+
+The device SHOULD NOT set \field{status} to VIRTIO_IOMMU_S_OK if a request
+didn't succeed.
+
+If a request \field{type} is not recognized, the device SHOULD return the
+buffers on the used ring and set the \field{len} field of the used element
+to zero.
+
+The device SHOULD ignore field \field{reserved} of
+\verb+struct virtio_iommu_req_head+ and SHOULD set field \field{reserved}
+of \verb+struct virtio_iommu_req_tail+ to zero.
+
+If the VIRTIO_IOMMU_F_INPUT_RANGE feature is negotiated and the range
+described by fields \field{virt_start} and \field{virt_end} doesn't fit in
+the range described by \field{input_range}, the device MAY set
+\field{status} to VIRTIO_IOMMU_S_RANGE and ignore the request.
+
+If the VIRTIO_IOMMU_F_DOMAIN_BITS is negotiated and bits above
+\field{domain_bits} are set in field \field{domain}, the device MAY set
+\field{status} to VIRTIO_IOMMU_S_RANGE and ignore the request.
+
+\subsubsection{ATTACH request}\label{sec:Device Types / IOMMU Device / Device operations / ATTACH request}
+
+\begin{lstlisting}
+struct virtio_iommu_req_attach {
+  struct virtio_iommu_req_head head;
+  le32 domain;
+  le32 endpoint;
+  u8   reserved[8];
+  struct virtio_iommu_req_tail tail;
+};
+\end{lstlisting}
+
+Attach an endpoint to a domain. \field{domain} is an identifier unique to
+the virtio-iommu device. The \field{domain} number doesn't have a meaning
+outside of virtio-iommu. If the domain doesn't exist in the device, it is
+created. \field{endpoint} is an identifier unique to the virtio-iommu
+device. The host communicates these unique endpoint IDs to the guest using
+methods outside the scope of this specification, but the following rules
+apply:
+
+\begin{itemize}
+\item The endpoint ID is unique from the virtio-iommu point of view.
+  Multiple endpoints whose DMA transactions are not translated by the same
+  virtio-iommu may have the same endpoint ID. Endpoints whose DMA
+  transactions may be translated by the same virtio-iommu must have
+  different endpoint IDs.
+
+\item Sometimes the host cannot completely isolate two endpoints from each
+  others. For example on a legacy PCI bus, endpoints can snoop DMA
+  transactions from their neighbours. In this case, the host must
+  communicate to the guest that it cannot isolate these endpoints from
+  each others, or that the physical IOMMU cannot distinguish transactions
+  coming from these endpoints. The method used to communicate this is
+  outside the scope of this specification.
+\end{itemize}
+
+Multiple endpoints may be attached to the same domain. An endpoint cannot
+be attached to multiple domains at the same time.
+
+\drivernormative{\paragraph}{ATTACH request}{Device Types / IOMMU Device / Device operations / ATTACH request}
+
+The driver SHOULD set \field{reserved} to zero.
+
+The driver SHOULD ensure that endpoints that cannot be isolated by the
+host are attached to the same domain.
+
+\devicenormative{\paragraph}{ATTACH request}{Device Types / IOMMU Device / Device operations / ATTACH request}
+
+If the \field{reserved} field of an ATTACH request is not zero, the device
+SHOULD set the request \field{status} to VIRTIO_IOMMU_S_INVAL and SHOULD
+NOT attach the endpoint to the domain. \footnote{The device should
+validate input of ATTACH requests in case the driver attempts to attach in
+a mode that is unimplemented by the device, and would be incompatible with
+the modes implemented by the device.}
+
+If the endpoint identified by \field{endpoint} doesn't exist, then the
+device SHOULD set the request \field{status} to VIRTIO_IOMMU_S_NOENT.
+
+If another endpoint is already attached to the domain identified by
+\field{domain}, then the device MAY attach the endpoint identified by
+\field{endpoint} to the domain. If it cannot do so, the device
+MUST set the request \field{status} to VIRTIO_IOMMU_S_UNSUPP.
+
+If the endpoint identified by \field{endpoint} is already attached to
+another domain, then the device SHOULD first detach it from that domain
+and attach it to the one identified by \field{domain}. In that case the
+device behaves as if the driver issued a DETACH request with this
+\field{endpoint}, followed by the ATTACH request. If the device cannot do
+so, it MUST set the request \field{status} to VIRTIO_IOMMU_S_UNSUPP.
+
+If properties of the endpoint (obtained with a PROBE request) are
+incompatible with properties of other endpoints already attached to the
+requested domain, the device MAY attach the endpoint. If it cannot do so, the
+device SHOULD set the request \field{status} to VIRTIO_IOMMU_S_UNSUPP.
+\footnote{In general it is simpler and safer to reject attach when two devices
+have differing values in a property, for example two reserved regions of
+different types that would overlap. Depending on the property, device
+implementation can try to merge them and accept the attach.}
+
+\subsubsection{DETACH request}
+
+\begin{lstlisting}
+struct virtio_iommu_req_detach {
+  struct virtio_iommu_req_head head;
+  le32 domain;
+  le32 endpoint;
+  u8   reserved[8];
+  struct virtio_iommu_req_tail tail;
+};
+\end{lstlisting}
+
+Detach an endpoint from a domain. When this request completes, the
+endpoint cannot access any mapping from that domain anymore. If feature
+VIRTIO_IOMMU_F_BYPASS has been negotiated, then the endpoint accesses the
+guest-physical address space once this request completes.
+
+After all endpoints have been successfully detached from a domain, it
+ceases to exist and its ID can be reused by the driver for another domain.
+
+\drivernormative{\paragraph}{DETACH request}{Device Types / IOMMU Device / Device operations / DETACH request}
+
+The driver SHOULD set \field{reserved} to zero.
+
+\devicenormative{\paragraph}{DETACH request}{Device Types / IOMMU Device / Device operations / DETACH request}
+
+If the \field{reserved} field of a DETACH request is not zero, the device
+MAY set the request \field{status} to VIRTIO_IOMMU_S_INVAL, in which case
+the device MAY still perform the DETACH operation.
+
+If the endpoint identified by \field{endpoint} doesn't exist, then the
+device SHOULD set the request \field{status} to VIRTIO_IOMMU_S_NOENT.
+
+If the domain identified by \field{domain} doesn't exist, or if the
+endpoint identified by \field{endpoint} isn't attached to this domain,
+then the device MAY set the request \field{status} to
+VIRTIO_IOMMU_S_INVAL.
+
+The device MUST ensure that after being detached from a domain, the
+endpoint cannot access any mapping from that domain.
+
+\subsubsection{MAP request}\label{sec:Device Types / IOMMU Device / Device operations / MAP request}
+
+\begin{lstlisting}
+struct virtio_iommu_req_map {
+  struct virtio_iommu_req_head head;
+  le32  domain;
+  le64  virt_start;
+  le64  virt_end;
+  le64  phys_start;
+  le32  flags;
+  struct virtio_iommu_req_tail tail;
+};
+
+/* Flags are: */
+#define VIRTIO_IOMMU_MAP_F_READ   (1 << 0)
+#define VIRTIO_IOMMU_MAP_F_WRITE  (1 << 1)
+#define VIRTIO_IOMMU_MAP_F_EXEC   (1 << 2)
+#define VIRTIO_IOMMU_MAP_F_MMIO   (1 << 3)
+\end{lstlisting}
+
+Map a range of virtually-contiguous addresses to a range of
+physically-contiguous addresses of the same size. After the request
+succeeds, all endpoints attached to this domain can access memory in the
+range $[virt\_start; virt\_end]$ (inclusive). For example, if an endpoint
+accesses address $VA \in [virt\_start; virt\_end]$, the device (or the
+physical IOMMU) translates the address: $PA = VA - virt\_start +
+phys\_start$. If the access parameters are compatible with \field{flags}
+(for instance, the access is write and \field{flags} are
+VIRTIO_IOMMU_MAP_F_READ | VIRTIO_IOMMU_MAP_F_WRITE) then the IOMMU allows
+the access to reach $PA$.
+
+The range defined by \field{virt_start} and \field{virt_end} should be
+within the limits specified by \field{input_range}. Given $phys\_end =
+phys\_start + virt\_end - virt\_start$, the range defined by
+\field{phys_start} and phys_end should be within the guest-physical
+address space. This includes upper and lower limits, as well as any
+carving of guest-physical addresses for use by the host. Guest physical
+boundaries are set by the host using a firmware mechanism outside the
+scope of this specification.
+
+Availability and allowed combinations of \field{flags} depend on the
+underlying IOMMU architectures. VIRTIO_IOMMU_MAP_F_READ and
+VIRTIO_IOMMU_MAP_F_WRITE are usually implemented, although READ is
+sometimes implied by WRITE. VIRTIO_IOMMU_MAP_F_EXEC might not be
+available. In addition combinations such as "WRITE and not READ" or "WRITE
+and EXEC" might not be supported.
+
+The VIRTIO_IOMMU_MAP_F_MMIO flag is a memory type rather than a protection
+flag. It may be used, for example, to map Message Signaled Interrupt
+doorbells when a VIRTIO_IOMMU_RESV_MEM_T_MSI region isn't available. To
+trigger interrupts the endpoint performs a direct memory write to another
+peripheral, the IRQ chip. Since it is a signal, the write must not be
+buffered, elided, or combined with other writes by the memory
+interconnect. The precise meaning of the MMIO flag depends on the
+underlying memory architecture (for example on Armv8-A it corresponds to
+the "Device-nGnRE" memory type). Unless needed by mapped MSIs, the device
+isn't required to support the MMIO flag.
+
+This request is only available when VIRTIO_IOMMU_F_MAP_UNMAP has been
+negotiated.
+
+\drivernormative{\paragraph}{MAP request}{Device Types / IOMMU Device / Device operations / MAP request}
+
+The driver SHOULD set undefined \field{flags} bits to zero.
+
+\field{virt_end} MUST be strictly greater than \field{virt_start}.
+
+The driver SHOULD set the VIRTIO_IOMMU_MAP_F_MMIO flag when the physical
+range corresponds to memory-mapped device registers. The physical range
+SHOULD have a single memory type: either normal memory or memory-mapped
+I/O.
+
+\devicenormative{\paragraph}{MAP request}{Device Types / IOMMU Device / Device operations / MAP request}
+
+If \field{virt_start}, \field{phys_start} or (\field{virt_end} + 1) is
+not aligned on the page granularity, the device SHOULD set the request
+\field{status} to VIRTIO_IOMMU_S_RANGE and SHOULD NOT create the mapping.
+
+If a mapping already exists in the requested range, the device SHOULD set
+the request \field{status} to VIRTIO_IOMMU_S_INVAL and SHOULD NOT change
+any mapping.
+
+If the device doesn't recognize a \field{flags} bit, it SHOULD set the
+request \field{status} to VIRTIO_IOMMU_S_INVAL. In this case the device
+SHOULD NOT create the mapping. \footnote{Validating the input is important
+here, because the driver might be attempting to map with special flags
+that the device doesn't recognize. Creating the mapping with incompatible
+flags may result in loss of coherency and security hazards.}
+
+If a flag or combination of flag isn't supported, the device MAY set the
+request \field{status} to VIRTIO_IOMMU_S_UNSUPP.
+
+The device MUST NOT allow writes to a range mapped without the
+VIRTIO_IOMMU_MAP_F_WRITE flag. However, if the underlying architecture
+does not support write-only mappings, the device MAY allow reads to a
+range mapped with VIRTIO_IOMMU_MAP_F_WRITE but not
+VIRTIO_IOMMU_MAP_F_READ.
+
+If \field{domain} does not exist, the device SHOULD set the request
+\field{status} to VIRTIO_IOMMU_S_NOENT.
+
+\subsubsection{UNMAP request}\label{sec:Device Types / IOMMU Device / Device operations / UNMAP request}
+
+\begin{lstlisting}
+struct virtio_iommu_req_unmap {
+  struct virtio_iommu_req_head head;
+  le32  domain;
+  le64  virt_start;
+  le64  virt_end;
+  u8    reserved[4];
+  struct virtio_iommu_req_tail tail;
+};
+\end{lstlisting}
+
+Unmap a range of addresses mapped with VIRTIO_IOMMU_T_MAP. We define here
+a mapping as a virtual region created with a single MAP request. All
+mappings covered by the range $[virt\_start; virt\_end]$ (inclusive) are
+removed.
+
+The semantics of unmapping are specified in \ref{drivernormative:Device
+Types / IOMMU Device / Device operations / UNMAP request} and
+\ref{devicenormative:Device Types / IOMMU Device / Device operations /
+UNMAP request}, and illustrated with the following requests, assuming each
+example sequence starts with a blank address space. We define two
+pseudocode functions \texttt{map(virt_start, virt_end) -> mapping} and
+\texttt{unmap(virt_start, virt_end)}.
+
+\begin{lstlisting}
+(1) unmap(virt_start=0,
+          virt_end=4)            -> succeeds, doesn't unmap anything
+
+(2) a = map(virt_start=0,
+            virt_end=9);
+    unmap(0, 9)                  -> succeeds, unmaps a
+
+(3) a = map(0, 4);
+    b = map(5, 9);
+    unmap(0, 9)                  -> succeeds, unmaps a and b
+
+(4) a = map(0, 9);
+    unmap(0, 4)                  -> faults, doesn't unmap anything
+
+(5) a = map(0, 4);
+    b = map(5, 9);
+    unmap(0, 4)                  -> succeeds, unmaps a
+
+(6) a = map(0, 4);
+    unmap(0, 9)                  -> succeeds, unmaps a
+
+(7) a = map(0, 4);
+    b = map(10, 14);
+    unmap(0, 14)                 -> succeeds, unmaps a and b
+\end{lstlisting}
+
+This request is only available when VIRTIO_IOMMU_F_MAP_UNMAP has been
+negotiated.
+
+\drivernormative{\paragraph}{UNMAP request}{Device Types / IOMMU Device / Device operations / UNMAP request}
+
+The driver SHOULD set the \field{reserved} field to zero.
+
+The range, defined by \field{virt_start} and \field{virt_end}, SHOULD
+cover one or more contiguous mappings created with MAP requests. The range
+MAY spill over unmapped virtual addresses.
+
+The first address of a range SHOULD either be the first address of a
+mapping or be outside any mapping. The last address of a range SHOULD
+either be the last address of a mapping or be outside any mapping.
+
+\devicenormative{\paragraph}{UNMAP request}{Device Types / IOMMU Device / Device operations / UNMAP request}
+
+If the \field{reserved} field of an UNMAP request is not zero, the device
+MAY set the request \field{status} to VIRTIO_IOMMU_S_INVAL, in which case
+the device MAY perform the UNMAP operation.
+
+If \field{domain} does not exist, the device SHOULD set the request
+\field{status} to VIRTIO_IOMMU_S_NOENT.
+
+If a mapping affected by the range is not covered in its entirety by the
+range (the UNMAP request would split the mapping), then the device SHOULD
+set the request \field{status} to VIRTIO_IOMMU_S_RANGE, and SHOULD NOT
+remove any mapping.
+
+If part of the range or the full range is not covered by an existing
+mapping, then the device SHOULD remove all mappings affected by the range
+and set the request \field{status} to VIRTIO_IOMMU_S_OK.
+
+\subsubsection{PROBE request}\label{sec:Device Types / IOMMU Device / Device operations / PROBE request}
+
+If the VIRTIO_IOMMU_F_PROBE feature bit is present, the driver sends a
+VIRTIO_IOMMU_T_PROBE request for each endpoint that the virtio-iommu
+device manages. This probe is performed before attaching the endpoint to
+a domain.
+
+\begin{lstlisting}
+struct virtio_iommu_req_probe {
+  struct virtio_iommu_req_head head;
+  /* Device-readable */
+  le32  endpoint;
+  u8    reserved[64];
+
+  /* Device-writable */
+  u8    properties[probe_size];
+  struct virtio_iommu_req_tail tail;
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{endpoint}] has the same meaning as in ATTACH and DETACH
+  requests.
+
+\item[\field{reserved}] is used as padding, so that future extensions can
+  add fields to the device-readable part.
+
+\item[\field{properties}] contains a list of properties of the
+  \field{endpoint}, filled by the device. The length of the
+  \field{properties} field is \field{probe_size} bytes. Each property is
+  described with a \verb+struct virtio_iommu_probe_property+ header, which
+  may be followed by a value of size \field{length}.
+
+\begin{lstlisting}
+#define VIRTIO_IOMMU_PROBE_T_MASK 0xfff
+
+struct virtio_iommu_probe_property {
+  le16  type;
+  le16  length;
+};
+\end{lstlisting}
+
+\end{description}
+
+The driver allocates a buffer of adequate size for the probe request,
+writes \field{endpoint} and adds the buffer to the request queue. The
+device fills the \field{properties} field with a list of properties for
+this endpoint.
+
+The driver parses the first property by reading \field{type}, then
+\field{length}. If the driver recognizes \field{type}, it reads and
+handles the rest of the property. The driver then reads the next property,
+that is located $(\field{length} + 4)$ bytes after the beginning of the
+first one, and so on. The driver parses all properties until it reaches a
+NONE property or the end of \field{properties}.
+
+The upper nibble of \field{type} is reserved for future extensions.
+Therefore only 4096 types are available. The actual type of a property is
+extracted like this:
+
+\begin{lstlisting}
+u16 type = le16_to_cpu(property.type) & VIRTIO_IOMMU_PROBE_T_MASK;
+\end{lstlisting}
+
+Available property types are described in section
+\ref{sec:Device Types / IOMMU Device / Device operations / PROBE properties}.
+
+\drivernormative{\paragraph}{PROBE request}{Device Types / IOMMU Device / Device operations / PROBE request}
+
+The size of \field{properties} MUST be \field{probe_size} bytes.
+
+The driver SHOULD set \field{reserved} to zero.
+
+If the driver doesn't recognize the \field{type} of a property, it SHOULD
+ignore the property and continue parsing the list.
+
+The driver SHOULD NOT deduce the property length from \field{type}.
+
+The driver SHOULD ignore bits[15:12] of \field{type}.
+
+\devicenormative{\paragraph}{PROBE request}{Device Types / IOMMU Device / Device operations / PROBE request}
+
+If the \field{reserved} field of a PROBE request is not zero, the device
+MAY set the request \field{status} to VIRTIO_IOMMU_S_INVAL.
+
+If the endpoint identified by \field{endpoint} doesn't exist, then the
+device SHOULD set the request \field{status} to VIRTIO_IOMMU_S_NOENT.
+
+If the device does not offer the VIRTIO_IOMMU_F_PROBE feature, and if the
+driver sends a VIRTIO_IOMMU_T_PROBE request, then the device SHOULD return
+the buffers on the used ring and set the \field{len} field of the used
+element to zero.
+
+The device SHOULD set bits [15:12] of property \field{type} to zero.
+
+The device MUST write the size of the property without the
+\verb+struct virtio_iommu_probe_property+ header, in bytes, into
+\field{length}.
+
+When two properties follow each others, the device MUST put the second
+property exactly $(\field{length} + 4)$ bytes after the beginning of the
+first one.
+
+If the \field{properties} list is smaller than \field{probe_size}, then
+the device SHOULD NOT write any property and SHOULD set the request
+\field{status} to VIRTIO_IOMMU_S_INVAL.
+
+If the device doesn't fill all \field{probe_size} bytes with properties,
+it SHOULD fill the remaining bytes of \field{properties} with zeroes.
+
+\subsubsection{PROBE properties}\label{sec:Device Types / IOMMU Device / Device operations / PROBE properties}
+
+\begin{lstlisting}
+#define VIRTIO_IOMMU_PROBE_T_NONE       0
+#define VIRTIO_IOMMU_PROBE_T_RESV_MEM   1
+\end{lstlisting}
+
+\paragraph{Property NONE}\label{sec:Device Types / IOMMU Device / Device operations / PROBE properties / NONE}
+
+Marks the end of the property list. This property doesn't have any value,
+and should have \field{length} 0.
+
+\paragraph{Property RESV_MEM}\label{sec:Device Types / IOMMU Device / Device operations / PROBE properties / RESVMEM}
+
+The RESV_MEM property describes a chunk of reserved virtual memory. It may
+be used by the device to describe virtual address ranges that shouldn't be
+allocated by the driver, or that are special.
+
+\begin{lstlisting}
+struct virtio_iommu_probe_resv_mem {
+  struct virtio_iommu_probe_property head;
+  u8    subtype;
+  u8    reserved[3];
+  le64  start;
+  le64  end;
+};
+\end{lstlisting}
+
+Fields \field{start} and \field{end} describe the range of reserved virtual
+addresses. \field{subtype} may be one of:
+
+\begin{description}
+  \item[VIRTIO_IOMMU_RESV_MEM_T_RESERVED (0)]
+    Accesses to virtual addresses in this region have undefined behavior.
+    They may be aborted by the device, bypass it, or never even reach it.
+    The region may also be used for host mappings, for example Message
+    Signaled Interrupts.
+
+    The guest should neither use these virtual addresses in a MAP request
+    nor instruct endpoints to perform DMA on them.
+
+  \item[VIRTIO_IOMMU_RESV_MEM_T_MSI (1)]
+    This region is a doorbell for Message Signaled Interrupts (MSIs). It
+    is similar to VIRTIO_IOMMU_RESV_MEM_T_RESERVED, in that the driver
+    should not map virtual addresses described by the property.
+
+    In addition it tells the guest how to handle MSI doorbells. If the
+    endpoint doesn't have a VIRTIO_IOMMU_RESV_MEM_T_MSI property
+    corresponding to the doorbell of a virtual MSI controller, then the
+    guest should create a mapping for it.
+\end{description}
+
+\drivernormative{\subparagraph}{Property RESV_MEM}{Device Types / IOMMU Device / Device operations / PROBE properties / RESVMEM}
+
+The driver SHOULD NOT map any virtual address described by a
+VIRTIO_IOMMU_RESV_MEM_T_RESERVED or VIRTIO_IOMMU_RESV_MEM_T_MSI property.
+
+The driver SHOULD ignore \field{reserved}.
+
+The driver SHOULD treat any \field{subtype} it doesn't recognize as if it
+was VIRTIO_IOMMU_RESV_MEM_T_RESERVED.
+
+\devicenormative{\subparagraph}{Property RESV_MEM}{Device Types / IOMMU Device / Device operations / PROBE properties / RESVMEM}
+
+The device SHOULD set \field{reserved} to zero.
+
+The device SHOULD NOT present more than one VIRTIO_IOMMU_RESV_MEM_T_MSI
+property per endpoint.
+
+The device SHOULD NOT present RESV_MEM properties that overlap each others
+for the same endpoint.
+
+\subsubsection{Fault reporting}\label{sev:Device Types / IOMMU Device / Device operations / Fault reporting}
+
+The device can report translation faults and other significant asynchronous
+events on the event virtqueue. The driver initially populates the queue with
+empty report buffers. When the device needs to report an event, it fills a
+buffer and notifies the driver with an interrupt. The driver consumes the
+report and moves the buffer back onto the queue.
+
+If no buffer is available, the device may either wait for one to be consumed,
+or drop the event.
+
+\begin{lstlisting}
+struct virtio_iommu_fault {
+  u8    reason;
+  u8    reserved[3];
+  le32  flags;
+  le32  endpoint;
+  le32  reserved1;
+  le64  address;
+};
+
+#define VIRTIO_IOMMU_FAULT_F_READ     (1 << 0)
+#define VIRTIO_IOMMU_FAULT_F_WRITE    (1 << 1)
+#define VIRTIO_IOMMU_FAULT_F_EXEC     (1 << 2)
+#define VIRTIO_IOMMU_FAULT_F_ADDRESS  (1 << 8)
+\end{lstlisting}
+
+\begin{description}
+  \item[\field{reason}] The reason for this report. It may have the
+    following values:
+    \begin{description}
+      \item[VIRTIO_IOMMU_FAULT_R_UNKNOWN (0)] An internal error happened, or
+        an error that cannot be described with the following reasons.
+      \item[VIRTIO_IOMMU_FAULT_R_DOMAIN (1)] The endpoint attempted to
+        access \field{address} without being attached to a domain.
+      \item[VIRTIO_IOMMU_FAULT_R_MAPPING (2)] The endpoint attempted to
+        access \field{address}, which wasn't mapped in the domain or
+        didn't have the correct protection flags.
+    \end{description}
+  \item[\field{flags}] Information about the fault context.
+  \item[\field{endpoint}] The endpoint causing the fault.
+  \item[\field{reserved} and \field{reserved1}] Should be zero.
+  \item[\field{address}] If VIRTIO_IOMMU_FAULT_F_ADDRESS is set, the
+    address causing the fault.
+\end{description}
+
+These faults are not recoverable\footnote{This means that the PRI
+extension to PCI, for example, that allows recoverable faults, isn't
+supported for the moment.}. The guest has to do its best to
+prevent any future fault from happening, by stopping or resetting the
+endpoint.
+
+When the fault is reported by a physical IOMMU, the fault reasons may not
+match exactly the reason of the original fault report. The device should
+try its best to find the closest match.
+
+If the device encounters a fault that wasn't caused by a specific
+endpoint, it is unlikely that the driver would be able to do anything else
+than print the fault and stop using the device, so reporting the fault on
+the event queue isn't useful. In that case, we recommend using the
+DEVICE_NEEDS_RESET status bit.
+
+\drivernormative{\paragraph}{Fault reporting}{Device Types / IOMMU Device / Device operations / Fault reporting}
+
+If the \field{reserved} field is not zero, the driver SHOULD ignore the
+fault report.\footnote{A future format may implement events that are not
+faults, which would be differentiated by a type field in place of
+\field{reserved}.}
+
+The driver SHOULD ignore undefined \field{flags}.
+
+If the driver doesn't recognize \field{reason}, it SHOULD treat the fault
+as if it was VIRTIO_IOMMU_FAULT_R_UNKNOWN.
+
+\devicenormative{\paragraph}{Fault reporting}{Device Types / IOMMU Device / Device operations / Fault reporting}
+
+The device SHOULD set \field{reserved} and \field{reserved1} to zero.
+
+The device SHOULD set undefined \field{flags} to zero.
+
+The device SHOULD write a valid endpoint ID in \field{endpoint}.
+
+The device MAY omit setting VIRTIO_IOMMU_FAULT_F_ADDRESS and writing
+\field{address} in any fault report, regardless of the \field{reason}.
+
+If a buffer is too small to contain the fault report\footnotemark, the
+device SHOULD NOT use multiple buffers to describe it. The device MAY fall
+back to using an older fault report format that fits in the buffer.
+
+\footnotetext{This would happen for example if the device implements a
+more recent version of this specification, whose fault report contains
+additional fields.}
-- 
2.21.0



This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

