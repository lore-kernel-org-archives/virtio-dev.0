Return-Path: virtio-dev-return-5045-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A833D985B92
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Nov 2018 10:16:41 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 27 Nov 2018 10:16:32 +0000
Message-Id: <20181127101632.11978-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v9] vsock: add vsock device
To: virtio-dev@lists.oasis-open.org
Cc: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Ian Campbell <ian.campbell@docker.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The virtio vsock device is a zero-configuration socket communications
device.  It is designed as a guest<->host management channel suitable
for communicating with guest agents.

vsock is designed with the sockets API in mind and the driver is
typically implemented as an address family (at the same level as
AF_INET).  Applications written for the sockets API can be ported with
minimal changes (similar amount of effort as adding IPv6 support to an
IPv4 application).

Unlike the existing console device, which is also used for guest<->host
communication, multiple clients can connect to a server at the same time
over vsock.  This limitation requires console-based users to arbitrate
access through a single client.  In vsock they can connect directly and
do not have to synchronize with each other.

Unlike network devices, no configuration is necessary because the device
comes with its address in the configuration space.

The vsock device was prototyped by Gerd Hoffmann and Asias He.  I picked
the code and design up from them.

VIRTIO-151

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v9:
 * There was no discussion on the last revision so I've rebased and
   intend to raise an issue to merge this on GitHub.
 * Moved content to virtio-vsock.tex

v8:
 * Rebased
 * This version is up-to-date with the Linux drivers

v7:
 * Add virtqueue flow control section to explain how deadlock is avoided
   when rings are full [Ian]

v6:
 * Make CIDs 64-bits but reserve upper 32 bits for now [Michael]
 * Specify SHUTDOWN -> RST clean disconnect process [Ian]

v5:
 * Switch to new, unused Device ID 19 [Ian]
 * Drop unused ctrl virtqueue, no need to reserve last virtqueue [Ian]
 * Document that VIRTIO_VSOCK_OP_CREDIT_UPDATE packets are valid even if
   no VIRTIO_VSOCK_OP_CREDIT_REQUEST was previously received. [Ian]
 * Document that only payload bytes are counted for buffer space
   management, not header bytes [Ian]
 * List the reserved CIDs [Ian]

v4:
 * Add event virtqueue and "Device Events" device operation section that
   explains how transport reset works for migration.
 * Reorder virtqueues with rx/tx first, then ctrl/event (similar to
   virtio-net)
 * __le32/16 -> le32/16 for consistency with existing code snippets
 * Add missing conformance.tex subsections for socket device entry in
   table of contents

v3:
 * "VSock device" -> "Virtio socket device" in free text [Michael]
 * Extract normative statements and add references from conformance
   chapter [Michael]
v2:
 * Document guest_cid field
 * Use MAY/MUST/CAN according to RFC 2119
 * Remove datagram socket type for the time being.  This can be added in
   the future but there are currently no applications.
 * Drop 3-way handshake for stream sockets.  It is not needed since
   virtio-vsock is reliable, in-order delivery and spoofing source
   addresses is impossible.
 * Drop max_virtqueue_pairs configuration space field.  This field was
   never defined and Linux code does not support multiqueue.  It can be
   added back later, if necessary.
---
 content.tex      |   1 +
 virtio-vsock.tex | 279 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 280 insertions(+)
 create mode 100644 virtio-vsock.tex

diff --git a/content.tex b/content.tex
index c346183..3bb21c0 100644
--- a/content.tex
+++ b/content.tex
@@ -5431,6 +5431,7 @@ descriptor for the \field{sense_len}, \field{residual},
 
 \input{virtio-gpu.tex}
 \input{virtio-crypto.tex}
+\input{virtio-vsock.tex}
 
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
diff --git a/virtio-vsock.tex b/virtio-vsock.tex
new file mode 100644
index 0000000..87183ad
--- /dev/null
+++ b/virtio-vsock.tex
@@ -0,0 +1,279 @@
+\section{Socket Device}\label{sec:Device Types / Socket Device}
+
+The virtio socket device is a zero-configuration socket communications device.
+It facilitates data transfer between the guest and device without using the
+Ethernet or IP protocols.
+
+\subsection{Device ID}\label{sec:Device Types / Socket Device / Device ID}
+  19
+
+\subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
+\begin{description}
+\item[0] rx
+\item[1] tx
+\item[2] event
+\end{description}
+
+\subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
+
+\begin{description}
+There are currently no feature bits defined for this device.
+\end{description}
+
+\subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
+
+\begin{lstlisting}
+struct virtio_vsock_config {
+	le64 guest_cid;
+};
+\end{lstlisting}
+
+The \field{guest_cid} field contains the guest's context ID, which uniquely
+identifies the device for its lifetime.  The upper 32 bits of the CID are
+reserved and zeroed.
+
+The following CIDs are reserved and cannot be used as the guest's context ID:
+
+\begin{tabular}{|l|l|}
+\hline
+CID    & Notes \\
+\hline \hline
+0                 & Reserved \\
+\hline
+1                 & Reserved \\
+\hline
+2                 & Well-known CID for the host \\
+\hline
+0xffffffff        & Reserved \\
+\hline
+0xffffffffffffffff        & Reserved \\
+\hline
+\end{tabular}
+
+\subsection{Device Initialization}\label{sec:Device Types / Socket Device / Device Initialization}
+
+\begin{enumerate}
+\item The guest's cid is read from \field{guest_cid}.
+
+\item Buffers are added to the event virtqueue to receive events from the device.
+
+\item Buffers are added to the rx virtqueue to start receiving packets.
+\end{enumerate}
+
+\subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Operation}
+
+Packets transmitted or received contain a header before the payload:
+
+\begin{lstlisting}
+struct virtio_vsock_hdr {
+	le64 src_cid;
+	le64 dst_cid;
+	le32 src_port;
+	le32 dst_port;
+	le32 len;
+	le16 type;
+	le16 op;
+	le32 flags;
+	le32 buf_alloc;
+	le32 fwd_cnt;
+};
+\end{lstlisting}
+
+The upper 32 bits of src_cid and dst_cid are reserved and zeroed.
+
+Most packets simply transfer data but control packets are also used for
+connection and buffer space management.  \field{op} is one of the following
+operation constants:
+
+\begin{lstlisting}
+enum {
+	VIRTIO_VSOCK_OP_INVALID = 0,
+
+	/* Connect operations */
+	VIRTIO_VSOCK_OP_REQUEST = 1,
+	VIRTIO_VSOCK_OP_RESPONSE = 2,
+	VIRTIO_VSOCK_OP_RST = 3,
+	VIRTIO_VSOCK_OP_SHUTDOWN = 4,
+
+	/* To send payload */
+	VIRTIO_VSOCK_OP_RW = 5,
+
+	/* Tell the peer our credit info */
+	VIRTIO_VSOCK_OP_CREDIT_UPDATE = 6,
+	/* Request the peer to send the credit info to us */
+	VIRTIO_VSOCK_OP_CREDIT_REQUEST = 7,
+};
+\end{lstlisting}
+
+\subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
+
+The tx virtqueue carries packets initiated by applications and replies to
+received packets.  The rx virtqueue carries packets initiated by the device and
+replies to previously transmitted packets.
+
+If both rx and tx virtqueues are filled by the driver and device at the same
+time then it appears that a deadlock is reached.  The driver has no free tx
+descriptors to send replies.  The device has no free rx descriptors to send
+replies either.  Therefore neither device nor driver can process virtqueues
+since that may involve sending new replies.
+
+This is solved using additional resources outside the virtqueue to hold
+packets.  With additional resources, it becomes possible to process incoming
+packets even when outgoing packets cannot be sent.
+
+Eventually even the additional resources will be exhausted and further
+processing is not possible until the other side processes the virtqueue that
+it has neglected.  This stop to processing prevents one side from causing
+unbounded resource consumption in the other side.
+
+\drivernormative{\paragraph}{Device Operation: Virtqueue Flow Control}{Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
+
+The rx virtqueue MUST be processed even when the tx virtqueue is full so long as there are additional resources available to hold packets outside the tx virtqueue.
+
+\devicenormative{\paragraph}{Device Operation: Virtqueue Flow Control}{Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
+
+The tx virtqueue MUST be processed even when the rx virtqueue is full so long as there are additional resources available to hold packets outside the rx virtqueue.
+
+\subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Operation / Addressing}
+
+Flows are identified by a (source, destination) address tuple.  An address
+consists of a (cid, port number) tuple. The header fields used for this are
+\field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
+
+Currently only stream sockets are supported. \field{type} is 1 for stream
+socket types.
+
+Stream sockets provide in-order, guaranteed, connection-oriented delivery
+without message boundaries.
+
+\subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
+\field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
+stream sockets. The guest and the device publish how much buffer space is
+available per socket. Only payload bytes are counted and header bytes are not
+included. This facilitates flow control so data is never dropped.
+
+\field{buf_alloc} is the total receive buffer space, in bytes, for this socket.
+This includes both free and in-use buffers. \field{fwd_cnt} is the free-running
+bytes received counter. The sender calculates the amount of free receive buffer
+space as follows:
+
+\begin{lstlisting}
+/* tx_cnt is the sender's free-running bytes transmitted counter */
+u32 peer_free = peer_buf_alloc - (tx_cnt - peer_fwd_cnt);
+\end{lstlisting}
+
+If there is insufficient buffer space, the sender waits until virtqueue buffers
+are returned and checks \field{buf_alloc} and \field{fwd_cnt} again. Sending
+the VIRTIO_VSOCK_OP_CREDIT_REQUEST packet queries how much buffer space is
+available. The reply to this query is a VIRTIO_VSOCK_OP_CREDIT_UPDATE packet.
+It is also valid to send a VIRTIO_VSOCK_OP_CREDIT_UPDATE packet without
+previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
+communicating updates any time a change in buffer space occurs.
+
+\drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
+VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
+sufficient free buffer space for the payload.
+
+All packets associated with a stream flow MUST contain valid information in
+\field{buf_alloc} and \field{fwd_cnt} fields.
+
+\devicenormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
+VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
+sufficient free buffer space for the payload.
+
+All packets associated with a stream flow MUST contain valid information in
+\field{buf_alloc} and \field{fwd_cnt} fields.
+
+\subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / Device Operation / Receive and Transmit}
+The driver queues outgoing packets on the tx virtqueue and incoming packet
+receive buffers on the rx virtqueue. Packets are of the following form:
+
+\begin{lstlisting}
+struct virtio_vsock_packet {
+    struct virtio_vsock_hdr hdr;
+    u8 data[];
+};
+\end{lstlisting}
+
+Virtqueue buffers for outgoing packets are read-only. Virtqueue buffers for
+incoming packets are write-only.
+
+\drivernormative{\paragraph}{Device Operation: Receive and Transmit}{Device Types / Socket Device / Device Operation / Receive and Transmit}
+
+The \field{guest_cid} configuration field MUST be used as the source CID when
+sending outgoing packets.
+
+A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
+unknown \field{type} value.
+
+\devicenormative{\paragraph}{Device Operation: Receive and Transmit}{Device Types / Socket Device / Device Operation / Receive and Transmit}
+
+The \field{guest_cid} configuration field MUST NOT contain a reserved CID as listed in \ref{sec:Device Types / Socket Device / Device configuration layout}.
+
+A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
+unknown \field{type} value.
+
+\subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device Operation / Stream Sockets}
+
+Connections are established by sending a VIRTIO_VSOCK_OP_REQUEST packet. If a
+listening socket exists on the destination a VIRTIO_VSOCK_OP_RESPONSE reply is
+sent and the connection is established.  A VIRTIO_VSOCK_OP_RST reply is sent if
+a listening socket does not exist on the destination or the destination has
+insufficient resources to establish the connection.
+
+When a connected socket receives VIRTIO_VSOCK_OP_SHUTDOWN the header
+\field{flags} field bit 0 indicates that the peer will not receive any more
+data and bit 1 indicates that the peer will not send any more data.  These
+hints are permanent once sent and successive packets with bits clear do not
+reset them.
+
+The VIRTIO_VSOCK_OP_RST packet aborts the connection process or forcibly
+disconnects a connected socket.
+
+Clean disconnect is achieved by one or more VIRTIO_VSOCK_OP_SHUTDOWN packets
+that indicate no more data will be sent and received, followed by a
+VIRTIO_VSOCK_OP_RST response from the peer.  If no VIRTIO_VSOCK_OP_RST response
+is received within an implementation-specific amount of time, a
+VIRTIO_VSOCK_OP_RST packet is sent to forcibly disconnect the socket.
+
+The clean disconnect process ensures that neither peer reuses the (source,
+destination) address tuple for a new connection while the other peer is still
+processing the old connection.
+
+\subsubsection{Device Events}\label{sec:Device Types / Socket Device / Device Operation / Device Events}
+
+Certain events are communicated by the device to the driver using the event
+virtqueue.
+
+The event buffer is as follows:
+
+\begin{lstlisting}
+enum virtio_vsock_event_id {
+        VIRTIO_VSOCK_EVENT_TRANSPORT_RESET = 0,
+};
+
+struct virtio_vsock_event {
+        le32 id;
+};
+\end{lstlisting}
+
+The VIRTIO_VSOCK_EVENT_TRANSPORT_RESET event indicates that communication has
+been interrupted.  This usually occurs if the guest has been physically
+migrated.  The driver shuts down established connections and the
+\field{guest_cid} configuration field is fetched again.  Existing listen
+sockets remain but their CID is updated to reflect the current
+\field{guest_cid}.
+
+\drivernormative{\paragraph}{Device Operation: Device Events}{Device Types / Socket Device / Device Operation / Device Events}
+
+Event virtqueue buffers SHOULD be replenished quickly so that no events are
+missed.
+
+The \field{guest_cid} configuration field MUST be fetched to determine the
+current CID when a VIRTIO_VSOCK_EVENT_TRANSPORT_RESET event is received.
+
+Existing connections MUST be shut down when a
+VIRTIO_VSOCK_EVENT_TRANSPORT_RESET event is received.
+
+Listen connections MUST remain operational with the current CID when a
+VIRTIO_VSOCK_EVENT_TRANSPORT_RESET event is received.
-- 
2.19.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

