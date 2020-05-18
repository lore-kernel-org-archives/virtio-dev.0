Return-Path: virtio-dev-return-7371-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D1C3A985F40
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 May 2020 20:38:46 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Mon, 18 May 2020 23:37:19 +0300
Message-Id: <20200518203721.7625-9-ndragazis@arrikto.com>
In-Reply-To: <20200518203721.7625-1-ndragazis@arrikto.com>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH v5 08/10] vhost-user: remove the extra PCI capabilities
Content-Type: text/plain; charset=US-ASCII
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Remove the extra PCI capabilities and use the existing virtio registers
instead. This way we obtain portability across transports.

Add a reference to the "Shared Memory Regions" section.

Add some more minor changes (add missing commas, rename sections,
enhance "Device Initialization" section, adjust normative statements).

Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 conformance.tex       |  18 +---
 virtio-vhost-user.tex | 233 ++++++++++++++----------------------------
 2 files changed, 82 insertions(+), 169 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index dcd2199..4f9ce43 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -32,9 +32,8 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \ref{sec:Conformance / Device Conformance / Input Device Conformance}, 
 \ref{sec:Conformance / Device Conformance / Crypto Device Conformance}, 
 \ref{sec:Conformance / Device Conformance / Socket Device Conformance}, 
-\ref{sec:Conformance / Device Conformance / RPMB Device Conformance}, 
-\ref{sec:Conformance / Device Conformance / IOMMU Device Conformance} or 
-\ref{sec:Conformance / Device Conformance / Vhost-user Backend Device Conformance}.
+\ref{sec:Conformance / Device Conformance / RPMB Device Conformance} or 
+\ref{sec:Conformance / Device Conformance / IOMMU Device Conformance}.
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
 \end{description}
@@ -226,7 +225,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 
 \begin{itemize}
 \item \ref{drivernormative:Device Types / Vhost-user Device Backend / Device configuration layout}
-\item \ref{drivernormative:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Notification capability}
+\item \ref{drivernormative:Device Types / Vhost-user Device Backend / Device Initialization}
 \end{itemize}
 
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
@@ -416,17 +415,6 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Device Types / IOMMU Device / Device operations / PROBE properties / RESVMEM}
 \item \ref{devicenormative:Device Types / IOMMU Device / Device operations / Fault reporting}
 \end{itemize}
-\conformance{\subsection}{Vhost-user Backend Device Conformance}\label{sec:Conformance / Device Conformance / Vhost-user Backend Device Conformance}
-
-A vhost-user backend device MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{devicenormative:Device Types / Vhost-user Device Backend / Device Initialization}
-\item \ref{devicenormative:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Doorbell capability}
-\item \ref{devicenormative:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Notification capability}
-\item \ref{devicenormative:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Shared memory capability}
-\end{itemize}
-
 \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
 non-transitional, see \ref{intro:Legacy
diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
index 34f3126..a673526 100644
--- a/virtio-vhost-user.tex
+++ b/virtio-vhost-user.tex
@@ -74,13 +74,13 @@ \subsection{Device configuration layout}\label{sec:Device Types / Vhost-user Dev
     setting VIRTIO_VHOST_USER_STATUS_SLAVE_UP again.
 
     A configuration change notification is sent when the device changes
-    this field unless a write to the field by the driver caused the change.
+    this field, unless a write to the field by the driver caused the change.
 
 \item[\field{max_vhost_queues}] is the maximum number of vhost-user queues
     supported by this device.  This field is always greater than 0.
 
 \item[\field{uuid}] is the Universally Unique Identifier (UUID) for this
-    device.  If the device has no UUID then this field contains the nil
+    device.  If the device has no UUID, then this field contains the nil
     UUID (all zeroes).  The UUID allows vhost-user slave programs to identify a
     specific vhost-user device backend among many without relying on bus
     addresses.
@@ -93,7 +93,13 @@ \subsection{Device configuration layout}\label{sec:Device Types / Vhost-user Dev
 
 The driver MUST NOT set undefined bits in the \field{status} configuration field.
 
-\devicenormative{\subsection}{Device Initialization}{Device Types / Vhost-user Device Backend / Device Initialization}
+\subsection{Device Initialization}\label{sec:Device Types / Vhost-user Device Backend / Device Initialization}
+
+The driver initializes the rxq/txq virtqueues and then it sets
+VIRTIO_VHOST_USER_STATUS_SLAVE_UP to the \field{status} field of the device
+configuration structure.
+
+\drivernormative{\subsubsection}{Device Initialization}{Device Types / Vhost-user Device Backend / Device Initialization}
 
 The driver SHOULD check the \field{max_vhost_queues} configuration field to
 determine how many queues the vhost-user slave will be able to support.
@@ -114,7 +120,7 @@ \subsection{Device Operation}\label{sec:Device Types / Vhost-user Device Backend
 
 Device operation consists of operating request queues and response queues.
 
-\subsubsection{Device Operation: Request Queues}\label{sec:Device Types / Vhost-user Device Backend / Device Operation / Device Operation: Request Queues}
+\subsubsection{Device Operation: RX/TX Queues}\label{sec:Device Types / Vhost-user Device Backend / Device Operation / Device Operation: RX/TX Queues}
 
 The driver receives vhost-user protocol messages from the vhost-user master on
 rxq.  The driver sends responses to the vhost-user master on txq.
@@ -133,7 +139,7 @@ \subsubsection{Device Operation: Request Queues}\label{sec:Device Types / Vhost-
 The appropriate size of rxq buffers is at least as large as the largest message
 defined by the \hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol}
 standard version that the driver supports.  If the vhost-user master sends a
-message that is too large for an rxq buffer then DEVICE_NEEDS_RESET is set and
+message that is too large for an rxq buffer, then DEVICE_NEEDS_RESET is set and
 the driver must reset the device.
 
 File descriptor passing is handled differently by the vhost-user device
@@ -141,12 +147,12 @@ \subsubsection{Device Operation: Request Queues}\label{sec:Device Types / Vhost-
 according to the vhost-user protocol, additional device resources become
 available to the driver.
 
-\subsection{Additional Device Resources over PCI}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI}
+\subsection{Additional Device Resources}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources}
 
-The vhost-user device backend contains additional device resources beyond
-configuration space and virtqueues.  The nature of these resources is
-transport-specific and therefore only virtio transports that provide these
-resources support the vhost-user device backend.
+The vhost-user device backend contains additional device resources, except for
+those specificied in \ref{sec:Basic Facilities of a Virtio Device}. The
+additional device resources allow the vhost-user master and slave to exchange
+notifications and data through the device.
 
 The following additional resources exist:
 \begin{description}
@@ -155,21 +161,26 @@ \subsection{Additional Device Resources over PCI}\label{sec:Device Types / Vhost
   \item[Shared memory] The vhost-user master gives access to memory that can be mapped by the driver.
 \end{description}
 
-\subsubsection{Doorbell Numbering}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Doorbell Numbering}
+\subsubsection{Doorbells}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources / Doorbells}
 
-Doorbells are laid out as follows:
+The vhost-user device backend provides all (or part) of the following doorbells:
 
 \begin{description}
 \item[0] Vring call for vhost-user queue 0
 \item[\ldots]
+\item[N-1] Vring call for vhost-user queue N-1
 \item[N] Vring err for vhost-user queue 0
 \item[\ldots]
+\item[2N-1] Vring err for vhost-user queue N-1
 \item[2N] Log
 \end{description}
 
-\subsubsection{Notifications}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Notifications}
+where N is the number of the vhost-user virtqueues.
 
-Notifications are laid out as follows:
+\subsubsection{Notifications}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources / Notifications}
+
+The vhost-user device backend provides all (or part) of the following
+notifications:
 
 \begin{description}
 \item[0] Vring kick for vhost-user queue 0
@@ -177,28 +188,29 @@ \subsubsection{Notifications}\label{sec:Device Types / Vhost-user Device Backend
 \item[N-1] Vring kick for vhost-user queue N-1
 \end{description}
 
-\subsubsection{Shared Memory Layout}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Shared Memory Layout}
+where N is the number of the vhost-user virtqueues.
+
+\subsubsection{Shared Memory}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources / Shared Memory}
 
-Shared memory is laid out as follows:
+The vhost-user device backend provides all (or part) of the following shared
+memory regions:
 
 \begin{description}
-\item[0] Vhost memory region 0
-\item[SIZE0] Vhost memory region 1
+\item[0] Vhost-user memory region 0
+\item[1] Vhost-user memory region 1
 \item[\ldots]
-\item[SIZE0 + SIZE1 + \ldots] Log
+\item[M-1] Vhost-user memory region M-1
+\item[M] Log memory region
 \end{description}
 
-The size of vhost memory region 0 is \field{SIZE0}, the size of vhost memory
-region 1 is \field{SIZE1}, and so on.
-
-\subsubsection{Availability of Additional Resources}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Availability of Additional Resources}
+\subsubsection{Availability of Additional Resources}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources / Availability of Additional Resources}
 
 The following vhost-user protocol messages convey access to additional device
 resources:
 
 \begin{description}
-\item[VHOST_USER_SET_MEM_TABLE] Contents of vhost memory regions are available to the driver in shared memory.  Region contents are laid out in the same order as the vhost memory region list.
-\item[VHOST_USER_SET_LOG_BASE] Contents of the log are available to the driver in shared memory.
+\item[VHOST_USER_SET_MEM_TABLE] Contents of vhost-user memory regions are available to the driver as device memory. Region contents are laid out in the same order as the vhost-user memory region list.
+\item[VHOST_USER_SET_LOG_BASE] Contents of the log memory region are available to the driver as device memory.
 \item[VHOST_USER_SET_LOG_FD] The log doorbell is available to the driver.  Writes to the log doorbell before this message is received produce no effect.
 \item[VHOST_USER_SET_VRING_KICK] The vring kick notification for this queue is available to the driver.  The first notification may occur before the driver has processed this message.
 \item[VHOST_USER_SET_VRING_CALL] The vring call doorbell for this queue is available to the driver.  Writes to the vring call doorbell before this message is received produce no effect.
@@ -206,147 +218,60 @@ \subsubsection{Availability of Additional Resources}\label{sec:Device Types / Vh
 \item[VHOST_USER_SET_SLAVE_REQ_FD] The driver may send vhost-user protocol slave messages on txq.  Buffers put onto txq before this message is received are discarded by the device.
 \end{description}
 
-Additional resources are configured on the virtio PCI transport by the following \field{struct virtio_pci_cap.cfg_type} values:
+\subsubsection{Doorbell layout}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources / Doorbell layout}
 
-\begin{lstlisting}
-#define VIRTIO_PCI_CAP_DOORBELL_CFG 6
-#define VIRTIO_PCI_CAP_NOTIFICATION_CFG 7
-#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
-\end{lstlisting}
+The device MUST reserve 2N+1 virtqueue indices that can be used by the driver to
+send doorbell notifications. The driver can use these indices to send doorbell
+notifications in the same way that it sends available buffer notifications
+\ref{sec:Basic Facilities of a Virtio Device / Notifications} for a virtqueue.
 
-\subsubsection{Doorbell structure layout}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Doorbell capability}
+Specifically, the driver can find the locations and send notifications on the
+call and err doorbells by using the following special queue indices:
 
-The doorbell location is found using the VIRTIO_PCI_CAP_DOORBELL_CFG
-capability.  This capability is immediately followed by an additional
-field, like so:
+\begin{itemize}
+\item 2i+2: find call doorbell for vhost-user queue i
+\item 2i+3: find err doorbell for vhost-user queue i
+\end{itemize}
 
-\begin{lstlisting}
-struct virtio_pci_doorbell_cap {
-        struct virtio_pci_cap cap;
-        le32 doorbell_off_multiplier;
-};
-\end{lstlisting}
+where i is the vhost-user queue index (defined by the vhost-user master via the
+vhost-user messages). The indices 0 and 1 are reserved for the device's RX/TX
+virtqueues.
 
-The doorbell address within a BAR is calculated as follows:
-
-\begin{lstlisting}
-        cap.offset + doorbell_idx * doorbell_off_multiplier
-\end{lstlisting}
+For the Log doorbell, the driver can use the special queue index 2(N+1), where N
+is the number of vhost-user queues.
 
-The \field{cap.offset} and \field{doorbell_off_multiplier} are taken from the
-doorbell capability structure above, and the \field{doorbell_idx} is the
-doorbell number.
+\subsubsection{Notification layout}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources / Notification layout}
 
-\devicenormative{\paragraph}{Doorbell capability}{Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Doorbell capability}
-The device MUST present at least one doorbell capability.
+If MSI-X is available, the driver can specify an MSI-X vector for a vhost-user
+queue in the same way that it specifies an MSI-X vector for a virtqueue. The
+driver MUST use the special index 2i+2 to specify an MSI-X vector for the
+vhost-user queue with index i. The vhost-user queue indices are defined by the
+vhost-user master via the vhost-user messages.
 
-The \field{cap.offset} MUST be 2-byte aligned.
+If MSI-X is not available, bit 2 (i.e., the third least significant bit) of the
+ISR status register indicates that a notification occured for one of the
+vhost-user queues.
 
-The device MUST either present \field{doorbell_off_multiplier} as an even power of 2,
-or present \field{doorbell_off_multiplier} as 0.
+\subsubsection{Shared Memory layout}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources / Shared Memory layout}
 
-The value \field{cap.length} presented by the device MUST be at least 2
-and MUST be large enough to support doorbell offsets for all supported
-doorbells in all possible configurations.
-
-The value \field{cap.length} presented by the device MUST satisfy:
-\begin{lstlisting}
-cap.length >= num_doorbells * doorbell_off_multiplier + 2
-\end{lstlisting}
-
-The number of doorbells is \field{num_doorbells} and is dependent on the
-device.
-
-\subsubsection{Notification structure layout}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Notification capability}
-
-The notification structure allows MSI-X vectors to be configured for
-notification interrupts.  If MSI-X is not available, bit 2 of the ISR status
-indicates that a notification occurred.
-
-The notification structure is found using the VIRTIO_PCI_CAP_NOTIFICATION_CFG
-capability.
-
-\begin{lstlisting}
-struct virtio_pci_notification_cfg {
-        le16 notification_select;              /* read-write */
-        le16 notification_msix_vector;         /* read-write */
-};
-\end{lstlisting}
+The device exports all memory regions reported by the vhost-user master as a
+single shared memory region \ref{sec:Basic Facilities of a Virtio Device /
+Shared Memory Regions}.
 
-The driver indicates which notification is of interest by writing the
-\field{notification_select} field.  The driver then writes the MSI-X vector or
-\field{VIRTIO_MSI_NO_VECTOR} to \field{notification_msix_vector} to change the
-MSI-X vector for that notification.
+The size of this shared memory region MUST be at least as much as the sum of the
+sizes of all the memory regions reported by the vhost-user master.
 
-\devicenormative{\paragraph}{Notification capability}{Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Notification capability}
+The memory regions MUST be laid out in the same order in which they are reported
+by the master with vhost-user messages.
 
-If MSI-X is available, device MUST support mapping any master queue
-event to any valid vector 0 to MSI-X \field{Table Size}. Here
-\field{Table Size} is the \field{N-1} encoded Table Size stored in the
-Message Control register of the MSI-X capability structure according to
-\hyperref[intro:PCI]{[PCI]}, where \field{N} is the actual MSI-X Table
-Size.
+The offsets in which the memory regions are mapped inside the shared memory
+region MUST be the following:
 
-Device MUST support unmapping any master queue event.
-
-The device MUST return vector mapped to a given master queue event,
-(\field{NO_VECTOR} if unmapped) on read of
-\field{notification_msix_vector}. The device MUST have all master queue
-events unmapped upon reset.
-
-Devices SHOULD NOT cause mapping an event to vector to fail unless it is
-impossible for the device to satisfy the mapping request. Devices MUST
-report mapping failures by returning the \field{NO_VECTOR} value when
-the relevant \field{notification_msix_vector} field is read.
-
-\drivernormative{\paragraph}{Notification capability}{Device Types /
-Vhost-user Device Backend / Additional Device Resources over PCI /
-Notification capability}
-
-Driver MUST support device with any MSI-X Table Size 0 to 0x7FF. Driver
-MAY fall back on using INT\#x interrupts for a device which only
-supports one MSI-X vector (MSI-X Table Size = 0).
-
-Driver MAY intepret the \field{Table Size} as a hint from the device for
-the suggested number of MSI-X vectors to use.
-
-Driver MUST NOT attempt to map an event to a vector outside the MSI-X
-Table supported by the device, as reported by \field{Table Size} in the
-MSI-X Capability.
-
-After mapping an event to vector, the driver MUST verify success by
-reading the Vector field value: on success, the previously written value
-is returned, and on failure, \field{NO_VECTOR} is returned. If a mapping
-failure is detected, the driver MAY retry mapping with fewer vectors,
-disable MSI-X or report device failure.
-
-\subsubsection{Shared memory capability}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Shared Memory capability}
-
-The shared memory location is found using the VIRTIO_PCI_CAP_SHARED_MEMORY_CFG
-capability. Using the additional \field{offset_hi} and \field{length_hi}
-fields following the SHARED_MEMORY_CFG capability structure, the shared
-memory region's 64-bit BAR offset is calculated as follows:
-
-\begin{lstlisting}
-        offset_hi << 32 + cap.offset
-\end{lstlisting}
-
-and the shared memory region's 64-bit length is calculated as follows:
-
-\begin{lstlisting}
-        length_hi << 32 + cap.length
-\end{lstlisting}
-
-The \field{cap.offset} and \field{cap.length} fields are taken from the
-SHARED_MEMORY_CFG capability structure.
-
-\devicenormative{\paragraph}{Shared memory capability}{Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Shared memory capability}
-The device MUST present exactly one shared memory capability.
-
-The device MUST locate shared memory in a Memory Space BAR.
-
-The device SHOULD locate shared memory in a Prefetchable BAR.
-
-The \field{cap.offset} MUST be 4096-byte aligned.
+\begin{description}
+\item[0] Offset for vhost-user memory region 0
+\item[SIZE0] Offset for vhost-user memory region 1
+\item[\ldots]
+\item[SIZE0 + SIZE1 + \ldots] Offset for vhost-user memory region M
+\end{description}
 
-The value \field{cap.length} presented by the device MUST be non-zero and 4096-byte aligned.
+where SIZEi is the size of the vhost-user memory region i.
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

