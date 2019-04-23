Return-Path: virtio-dev-return-5685-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2038C985CFE
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Apr 2019 15:18:37 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Tue, 23 Apr 2019 18:18:16 +0300
Message-Id: <1556032699-22135-2-git-send-email-ndragazis@arrikto.com>
In-Reply-To: <1556032699-22135-1-git-send-email-ndragazis@arrikto.com>
References: <1556032699-22135-1-git-send-email-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH 1/4] vhost-user: add vhost-user device type
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Vangelis Koukis <vkoukis@arrikto.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

The vhost-user device backend facilitates vhost-user device emulation
through vhost-user protocol exchanges and access to shared memory.
Software-defined networking, storage, and other I/O appliances can
provide services through this device.

This device is based on Wei Wang's vhost-pci work.  The virtio
vhost-user device differs from vhost-pci because it is a single virtio
device type that exposes the vhost-user protocol instead of a family of
new virtio device types, one for each vhost-user device type.

This device supports vhost-user slave and vhost-user master
reconnection.  It also contains a UUID so that vhost-user slave programs
can identify a specific device among many without using bus addresses.

It is somewhat unconventional for a virtio device because it makes use
of additional resources called doorbells, notifications, and shared
memory.  A mapping of these resources to the virtio PCI transport is
provided.  Other transports, such as CCW may not be able to support
this device.

Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 content.tex           |   3 +
 introduction.tex      |   1 +
 virtio-vhost-user.tex | 292 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 296 insertions(+)
 create mode 100644 virtio-vhost-user.tex

diff --git a/content.tex b/content.tex
index 193b6e1..a0bd978 100644
--- a/content.tex
+++ b/content.tex
@@ -2634,6 +2634,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 24         &   Memory device \\
 \hline
+25         &   vhost-user device backend \\
+\hline
 \end{tabular}
 
 Some of the devices above are unspecified by this document,
@@ -5594,6 +5596,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 \input{virtio-input.tex}
 \input{virtio-crypto.tex}
 \input{virtio-vsock.tex}
+\input{virtio-vhost-user.tex}
 
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
diff --git a/introduction.tex b/introduction.tex
index c96acf9..f4bb047 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -60,6 +60,7 @@ \section{Normative References}\label{sec:Normative References}
 	\phantomsection\label{intro:SCSI MMC}\textbf{[SCSI MMC]} &
         SCSI Multimedia Commands,
         \newline\url{http://www.t10.org/cgi-bin/ac.pl?t=f&f=mmc6r00.pdf}\\
+	\phantomsection\label{intro:Vhost-user Protocol}\textbf{[Vhost-user Protocol]} & Vhost-user Protocol, \newline\url{https://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/interop/vhost-user.txt;hb=HEAD}, and any future revisions\\
 
 \end{longtable}
 
diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
new file mode 100644
index 0000000..48be7e7
--- /dev/null
+++ b/virtio-vhost-user.tex
@@ -0,0 +1,292 @@
+\section{Vhost-user Device Backend}\label{sec:Device Types / Vhost-user Device Backend}
+
+The vhost-user device backend facilitates vhost-user device emulation through
+vhost-user protocol exchanges and access to shared memory.  Software-defined
+networking, storage, and other I/O appliances can provide services through this
+device.
+
+This section relies on definitions from the \hyperref[intro:Vhost-user
+Protocol]{Vhost-user Protocol}.  Knowledge of the vhost-user protocol is a
+prerequisite for understanding this device.
+
+The \hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol} was originally
+designed for processes on a single system communicating over UNIX domain
+sockets.  The virtio vhost-user device backend allows the vhost-user slave to
+communicate with the vhost-user master over the device instead of a UNIX domain
+socket.  This allows the slave and master to run on two separate systems such
+as a virtual machine and a hypervisor.
+
+The vhost-user slave program exchanges vhost-user protocol messages with the
+vhost-user master through this device.  How the device implementation
+communicates with the vhost-user master is beyond the scope of this
+specification.  One possible device implementation uses a UNIX domain socket to
+relay messages to a vhost-user master process running on the same host.
+
+Existing vhost-user slave programs that communicate over UNIX domain sockets
+can support the virtio vhost-user device backend without invasive changes
+because the pre-existing vhost-user wire protocol is used.
+
+\subsection{Device ID}\label{sec:Device Types / Vhost-user Device Backend / Device ID}
+  25
+
+\subsection{Virtqueues}\label{sec:Device Types / Vhost-user Device Backend / Virtqueues}
+
+\begin{description}
+\item[0] rxq (device-to-driver vhost-user protocol messages)
+\item[1] txq (driver-to-device vhost-user protocol messages)
+\end{description}
+
+\subsection{Feature bits}\label{sec:Device Types / Vhost-user Device Backend / Feature bits}
+
+No feature bits are defined at this time.
+
+\subsection{Device configuration layout}\label{sec:Device Types / Vhost-user Device Backend / Device configuration layout}
+
+  All fields of this configuration are always available.
+
+\begin{lstlisting}
+struct virtio_vhost_user_config {
+        le32 status;
+#define VIRTIO_VHOST_USER_STATUS_SLAVE_UP 0
+#define VIRTIO_VHOST_USER_STATUS_MASTER_UP 1
+        le32 max_vhost_queues;
+        u8 uuid[16];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{status}] contains the vhost-user operational status.  The default
+    value of this field is 0.
+
+    The driver sets VIRTIO_VHOST_USER_STATUS_SLAVE_UP to indicate readiness for
+    the vhost-user master to connect.  The vhost-user master cannot connect
+    unless the driver has set this bit first.
+
+    When the driver clears VIRTIO_VHOST_USER_SLAVE_UP while the vhost-user
+    master is connected, the vhost-user master is disconnected.
+
+    When the vhost-user master disconnects, both
+    VIRTIO_VHOST_USER_STATUS_SLAVE_UP and VIRTIO_VHOST_USER_STATUS_MASTER_UP
+    are cleared by the device.  Communication can be restarted by the driver
+    setting VIRTIO_VHOST_USER_STATUS_SLAVE_UP again.
+
+    A configuration change notification is sent when the device changes
+    this field unless a write to the field by the driver caused the change.
+
+\item[\field{max_vhost_queues}] is the maximum number of vhost-user queues
+    supported by this device.  This field is always greater than 0.
+
+\item[\field{uuid}] is the Universally Unique Identifier (UUID) for this
+    device.  If the device has no UUID then this field contains the nil
+    UUID (all zeroes).  The UUID allows vhost-user slave programs to identify a
+    specific vhost-user device backend among many without relying on bus
+    addresses.
+\end{description}
+
+\drivernormative{\subsubsection}{Device configuration layout}{Device Types / Vhost-user Device Backend / Device configuration layout}
+
+The driver MUST NOT write to device configuration fields other than
+\field{status}.
+
+The driver MUST NOT set undefined bits in the \field{status} configuration field.
+
+\devicenormative{\subsection}{Device Initialization}{Device Types / Vhost-user Device Backend / Device Initialization}
+
+The driver SHOULD check the \field{max_vhost_queues} configuration field to
+determine how many queues the vhost-user slave will be able to support.
+
+The driver SHOULD fetch the \field{uuid} configuration field to allow
+vhost-user slave programs to identify a specific device among many.
+
+The driver SHOULD place at least one buffer in rxq before setting the
+VIRTIO_VHOST_USER_SLAVE_UP bit in the \field{status} configuration field.
+
+The driver MUST handle rxq virtqueue notifications that occur before the
+configuration change notification.  It is possible that a vhost-user protocol
+message from the vhost-user master arrives before the driver has seen the
+configuration change notification for the VIRTIO_VHOST_USER_STATUS_MASTER_UP
+\field{status} change.
+
+\subsection{Device Operation}\label{sec:Device Types / Vhost-user Device Backend / Device Operation}
+
+Device operation consists of operating request queues and response queues.
+
+\subsubsection{Device Operation: Request Queues}\label{sec:Device Types / Vhost-user Device Backend / Device Operation / Device Operation: Request Queues}
+
+The driver receives vhost-user protocol messages from the vhost-user master on
+rxq.  The driver sends responses to the vhost-user master on txq.
+
+The driver sends slave-initiated requests on txq.  The driver receives
+responses from the vhost-user master on rxq.
+
+All virtqueues offer in-order guaranteed delivery semantics for vhost-user
+protocol messages.
+
+Each buffer is a vhost-user protocol message as defined by the
+\hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol}.  In order to enable
+cross-endian communication, all message fields are little-endian instead of the
+native byte order normally used by the protocol.
+
+The appropriate size of rxq buffers is at least as large as the largest message
+defined by the \hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol}
+standard version that the driver supports.  If the vhost-user master sends a
+message that is too large for an rxq buffer then DEVICE_NEEDS_RESET is set and
+the driver must reset the device.
+
+File descriptor passing is handled differently by the vhost-user device
+backend.  When a message is received that carries one or more file descriptors
+according to the vhost-user protocol, additional device resources become
+available to the driver.
+
+\subsection{Additional Device Resources over PCI}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI}
+
+The vhost-user device backend contains additional device resources beyond
+configuration space and virtqueues.  The nature of these resources is
+transport-specific and therefore only virtio transports that provide these
+resources support the vhost-user device backend.
+
+The following additional resources exist:
+\begin{description}
+  \item[Doorbells] The driver signals the vhost-user master through doorbells.  The signal does not carry any data, it is purely an event.
+  \item[Notifications] The vhost-user master signals the driver for events besides virtqueue activity and configuration changes by sending notifications.
+  \item[Shared memory] The vhost-user master gives access to memory that can be mapped by the driver.
+\end{description}
+
+\subsubsection{Doorbell Numbering}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Doorbell Numbering}
+
+Doorbells are laid out as follows:
+
+\begin{description}
+\item[0] Vring call for vhost-user queue 0
+\item[\ldots]
+\item[N] Vring err for vhost-user queue 0
+\item[\ldots]
+\item[2N] Log
+\end{description}
+
+\subsubsection{Notifications}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Notifications}
+
+Notifications are laid out as follows:
+
+\begin{description}
+\item[0] Vring kick for vhost-user queue 0
+\item[\ldots]
+\item[N-1] Vring kick for vhost-user queue N-1
+\end{description}
+
+\subsubsection{Shared Memory Layout}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Shared Memory Layout}
+
+Shared memory is laid out as follows:
+
+\begin{description}
+\item[0] Vhost memory region 0
+\item[SIZE0] Vhost memory region 1
+\item[\ldots]
+\item[SIZE0 + SIZE1 + \ldots] Log
+\end{description}
+
+The size of vhost memory region 0 is \field{SIZE0}, the size of vhost memory
+region 1 is \field{SIZE1}, and so on.
+
+\subsubsection{Availability of Additional Resources}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Availability of Additional Resources}
+
+The following vhost-user protocol messages convey access to additional device
+resources:
+
+\begin{description}
+\item[VHOST_USER_SET_MEM_TABLE] Contents of vhost memory regions are available to the driver in shared memory.  Region contents are laid out in the same order as the vhost memory region list.
+\item[VHOST_USER_SET_LOG_BASE] Contents of the log are available to the driver in shared memory.
+\item[VHOST_USER_SET_LOG_FD] The log doorbell is available to the driver.  Writes to the log doorbell before this message is received produce no effect.
+\item[VHOST_USER_SET_VRING_KICK] The vring kick notification for this queue is available to the driver.  The first notification may occur before the driver has processed this message.
+\item[VHOST_USER_SET_VRING_CALL] The vring call doorbell for this queue is available to the driver.  Writes to the vring call doorbell before this message is received produce no effect.
+\item[VHOST_USER_SET_VRING_ERR] The vring err doorbell for this queue is available to the driver.  Writes to the vring err doorbell before this message is received produce no effect.
+\item[VHOST_USER_SET_SLAVE_REQ_FD] The driver may send vhost-user protocol slave messages on txq.  Buffers put onto txq before this message is received are discarded by the device.
+\end{description}
+
+Additional resources are configured on the virtio PCI transport by the following \field{struct virtio_pci_cap.cfg_type} values:
+
+\begin{lstlisting}
+#define VIRTIO_PCI_CAP_DOORBELL_CFG 6
+#define VIRTIO_PCI_CAP_NOTIFICATION_CFG 7
+#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
+\end{lstlisting}
+
+\subsubsection{Doorbell structure layout}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Doorbell capability}
+
+The doorbell location is found using the VIRTIO_PCI_CAP_DOORBELL_CFG
+capability.  This capability is immediately followed by an additional
+field, like so:
+
+\begin{lstlisting}
+struct virtio_pci_doorbell_cap {
+        struct virtio_pci_cap cap;
+        le32 doorbell_off_multiplier;
+};
+\end{lstlisting}
+
+The doorbell address within a BAR is calculated as follows:
+
+\begin{lstlisting}
+        cap.offset + doorbell_idx * doorbell_off_multiplier
+\end{lstlisting}
+
+The \field{cap.offset} and \field{doorbell_off_multiplier} are taken from the
+notification capability structure above, and the \field{doorbell_idx} is the
+doorbell number.
+
+\devicenormative{\paragraph}{Doorbell capability}{Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Doorbell capability}
+The device MUST present at least one doorbell capability.
+
+The \field{cap.offset} MUST be 2-byte aligned.
+
+The device MUST either present \field{doorbell_off_multiplier} as an even power of 2,
+or present \field{doorbell_off_multiplier} as 0.
+
+The value \field{cap.length} presented by the device MUST be at least 2
+and MUST be large enough to support doorbell offsets for all supported
+doorbells in all possible configurations.
+
+The value \field{cap.length} presented by the device MUST satisfy:
+\begin{lstlisting}
+cap.length >= num_doorbells * doorbell_off_multiplier + 2
+\end{lstlisting}
+
+The number of doorbells is \field{num_doorbells} and is dependent on the
+device.
+
+\subsubsection{Notification structure layout}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Notification capability}
+
+The notification structure allows MSI-X vectors to be configured for
+notification interrupts.  If MSI-X is not available, bit 2 of the ISR status
+indicates that a notification occurred.
+
+The notification structure is found using the VIRTIO_PCI_CAP_DOORBELL_CFG
+capability.
+
+\begin{lstlisting}
+struct virtio_pci_notification_cfg {
+        le16 notification_select;              /* read-write */
+        le16 notification_msix_vector;         /* read-write */
+};
+\end{lstlisting}
+
+The driver indicates which notification is of interest by writing the
+\field{notification_select} field.  The driver then writes the MSI-X vector or
+\field{VIRTIO_MSI_NO_VECTOR} to \field{notification_msix_vector} to change the
+MSI-X vector for that notification.
+
+\subsubsection{Shared memory capability}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Shared Memory capability}
+
+The shared memory location is found using the VIRTIO_PCI_CAP_SHARED_MEMORY_CFG
+capability.
+
+\devicenormative{\paragraph}{Shared Memory capability}{Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Shared Memory capability}
+The device MUST present exactly one shared memory capability.
+
+The device MUST locate shared memory in a Memory Space BAR.
+
+The device SHOULD locate shared memory in a Prefetchable BAR.
+
+The \field{cap.offset} MUST be 4096-byte aligned.
+
+The value \field{cap.length} presented by the device MUST be non-zero and 4096-byte aligned.
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

