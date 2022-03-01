Return-Path: <virtio-dev-return-9331-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6ED3A98642F
	for <virtio-dev@lists.oasis-open.org>; Tue,  1 Mar 2022 08:34:51 +0000 (UTC)
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Tue,  1 Mar 2022 16:34:46 +0800
Message-Id: <20220301083446.55424-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v10] virtio-net: support device stats
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This patch allows the driver to obtain some statistics from the device.

In the back-end implementation, we can count a lot of such information,
which can be used for debugging and judging the running status of the
back-end. We hope to directly display it to the user through ethtool.

To get stats atomically, try to get stats for all queue pairs in one
command.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v10:
1. use description/item for the item of the queue pair
2. use one command to get the stats of all queue pairs

v8:
1. Modified based on comments by Cornelia Huck

v7:
1. add rx_reset, tx_reset
2. add device normative and dirver normative
3. add comments for *_packets, *_bytres

v6:
1. correct the names and descriptions of some stats items

v5:
1. add VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ
2. more item for virtio_net_ctrl_reply_stats_queue_pair

v4:
1. remove dev_stats_num, {rx|tx}_stats_num
2. Use two commands to get the stats of queue pair and dev respectively

v3 changes:
1. add dev_version
2. use queue_pair_index replace rx_num, tx_num
3. Explain the processing when the device and driver support different numb=
ers
of stats

 conformance.tex |   2 +
 content.tex     | 289 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 288 insertions(+), 3 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index 42f8537..c67f877 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -142,6 +142,7 @@ \section{Conformance Targets}\label{sec:Conformance / C=
onformance Targets}
 \item \ref{drivernormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Automatic receive steering in multiqueue mode}
 \item \ref{drivernormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Offloads State Configuration / Setting Offloads Sta=
te}
 \item \ref{drivernormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Receive-side scaling (RSS) }
+\item \ref{drivernormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Device Stats}
 \end{itemize}

 \conformance{\subsection}{Block Driver Conformance}\label{sec:Conformance =
/ Driver Conformance / Block Driver Conformance}
@@ -401,6 +402,7 @@ \section{Conformance Targets}\label{sec:Conformance / C=
onformance Targets}
 \item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Gratuitous Packet Sending}
 \item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Automatic receive steering in multiqueue mode}
 \item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
+\item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Device Stats}
 \end{itemize}

 \conformance{\subsection}{Block Device Conformance}\label{sec:Conformance =
/ Device Conformance / Block Device Conformance}
diff --git a/content.tex b/content.tex
index c6f116c..2363b74 100644
--- a/content.tex
+++ b/content.tex
@@ -3092,6 +3092,9 @@ \subsection{Feature bits}\label{sec:Device Types / Ne=
twork Device / Feature bits
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.

+\item[VIRTIO_NET_F_CTRL_STATS(55)] Device can provide device-level statist=
ics
+    to the driver through the control channel.
+
 \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets. Unlike U=
FO
  (fragmenting the packet) the USO splits large UDP packet
  to several segments when each of these smaller packets has UDP header.
@@ -3137,6 +3140,7 @@ \subsubsection{Feature bit requirements}\label{sec:De=
vice Types / Network Device
 \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
+\item[VIRTIO_NET_F_CTRL_STATS] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_=
F_HOST_TSO6.
 \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
 \end{description}
@@ -4015,6 +4019,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Ty=
pes / Network Device / Devi
         u8 command;
         u8 command-specific-data[];
         u8 ack;
+        u8 command-specific-data-reply[];
 };

 /* ack values */
@@ -4023,9 +4028,13 @@ \subsubsection{Control Virtqueue}\label{sec:Device T=
ypes / Network Device / Devi
 \end{lstlisting}

 The \field{class}, \field{command} and command-specific-data are set by th=
e
-driver, and the device sets the \field{ack} byte. There is little it can
-do except issue a diagnostic if \field{ack} is not
-VIRTIO_NET_OK.
+driver, and the device sets the \field{ack} byte and optionally
+\field{command-specific-data-reply}. There is little the driver can
+do except issue a diagnostic if \field{ack} is not VIRTIO_NET_OK.
+
+These commands VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ and
+VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR contain
+\field{command-specific-data-reply}.

 \paragraph{Packet Receive Filtering}\label{sec:Device Types / Network Devi=
ce / Device Operation / Control Virtqueue / Packet Receive Filtering}
 \label{sec:Device Types / Network Device / Device Operation / Control Virt=
queue / Setting Promiscuous Mode}%old label for latexdiff
@@ -4471,6 +4480,280 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
 according to the native endian of the guest rather than
 (necessarily when not using the legacy interface) little-endian.

+\paragraph{Device Stats}\label{sec:Device Types / Network Device / Device =
Operation / Control Virtqueue / Device Stats}
+
+If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the driver can
+get device stats from the device in \field{command-specific-data-reply}.
+
+To get the stats, the following definitions are used:
+\begin{lstlisting}
+#define VIRTIO_NET_CTRL_STATS                 6
+#define VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ     0
+#define VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR  1
+\end{lstlisting}
+
+The following layout structures are used:
+
+\field{command-specific-data}
+\begin{lstlisting}
+struct virtio_net_ctrl_stats_queue_pair {
+    le64 length;
+}
+\end{lstlisting}
+
+\field{command-specific-data-reply}
+\begin{lstlisting}
+struct virtio_net_ctrl_reply_stats_cvq {
+    le64 command_num;
+    le64 ok_num;
+}
+
+struct virtio_net_stats_queue_pair {
+    le64 queue_pair_index;
+
+    /* rx stats */
+    le64 rx_packets;
+    le64 rx_bytes;
+
+    le64 rx_notification;
+    le64 rx_interrupt;
+
+    le64 rx_drop;
+    le64 rx_drop_overruns;
+
+    /* rx csum stats */
+    le64 rx_csum_valid;
+    le64 rx_needs_csum;
+    le64 rx_csum_bad;
+    le64 rx_csum_none;
+
+    /* rx gso stats */
+    le64 rx_gso_packets;
+    le64 rx_gso_bytes;
+
+    /* rx reset */
+    le64 rx_reset;
+
+    /* tx stats */
+    le64 tx_packets;
+    le64 tx_bytes;
+
+    le64 tx_notification;
+    le64 tx_interrupt;
+
+    le64 tx_drop;
+    le64 tx_drop_malformed;
+
+    /* tx csum stats */
+    le64 tx_csum_none;
+    le64 tx_needs_csum;
+
+    /* rx gso stats */
+    le64 tx_gso_packets;
+    le64 tx_gso_bytes;
+
+    /* rx stats */
+    le64 tx_reset;
+}
+
+struct virtio_net_ctrl_reply_stats_queue_pair {
+    struct virtio_net_stats_queue_pair stats[];
+}
+
+\end{lstlisting}
+
+\subparagraph{Controlq Stats}\label{sec:Device Types / Network Device / De=
vice Operation / Control Virtqueue / Device Stats / Controlq Stats}
+
+To get controlq stats use command VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ.
+The result is returned as struct virtio_net_ctrl_reply_stats_cvq in \field=
{command-specific-data-reply}.
+
+\begin{description}
+    \item [command_num]
+        The number of commands, including the current command.
+
+    \item [ok_num]
+        The number of commands (including the current command) where the a=
ck was VIRTIO_NET_OK.
+\end{description}
+
+\subparagraph{Virtqueue Pair Stats: Get}\label{sec:Device Types / Network =
Device / Device Operation / Control Virtqueue / Device Stats / Virtqueue Pa=
ir Stats: Get}
+
+Get queue pair stats using command VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR an=
d
+\field{command-specific-data} filled by struct virtio_net_ctrl_stats_queue=
_pair.
+
+The result is returned as struct virtio_net_ctrl_reply_stats_queue_pair in=
 \field{command-specific-data-reply}.
+
+The \field{length} in virtio_net_ctrl_stats_queue_pair is used to tell the=
 backend the
+size of the \field{command-specific-data-reply}.
+
+\subparagraph{Virtqueue Pair Stats: Basic}\label{sec:Device Types / Networ=
k Device / Device Operation / Control Virtqueue / Device Stats / Virtqueue =
Pair Stats: Basic}
+
+Basic stats doesn't need any features, as long as the device supports
+VIRTIO_NET_F_CTRL_STATS. The following are the basic stats.
+
+\begin{description}
+    \item [queue_pair_index]
+        The index of the current queue pair.
+
+    \item [rx_packets]
+        The number of packets received by device (not the packets passed t=
o the
+        guest), including the dropped packets by device.
+
+    \item [rx_bytes]
+        The number of bytes received by device (not the packets passed to =
the
+        guest), including the dropped packets by device.
+
+    \item [rx_notification]
+        The number of driver notifications.
+
+    \item [rx_interrupt]
+        The number of device interrupts.
+
+    \item [rx_drop]
+        The number of packets dropped by the rx queue. Contains all kinds =
of
+        packet drop.
+
+    \item [rx_drop_overruns]
+        The number of packets dropped by the rx queue when no more descrip=
tors
+        were available.
+
+    \item [tx_packets]
+        The number of packets sent by device (not the packets received fro=
m the
+        guest), excluding the dropped packets by device.
+
+    \item [tx_bytes]
+        The number of bytes sent by device (not the packets received from =
the
+        guest), excluding the dropped packets by device.
+
+    \item [tx_notification]
+        The number of driver notifications.
+
+    \item [tx_interrupt]
+        The number of device interrupts.
+
+    \item [tx_drop]
+        The number of packets dropped by the tx queue. Contains all kinds =
of
+        packet drop.
+
+    \item [tx_drop_malformed]
+        The number of packets dropped when the descriptor is in an error s=
tate.
+        For example, the buffer is too short.
+
+\end{description}
+
+\subparagraph{Virtqueue Pair Stats: RX CSUM}\label{sec:Device Types / Netw=
ork Device / Device Operation / Control Virtqueue / Device Stats / Virtqueu=
e Pair Stats: RX CSUM}
+
+Only after the VIRTIO_NET_F_GUEST_CSUM negotiation is successful, the rx c=
sum
+counters are meaningful.
+
+The following are the rx csum counters:
+
+\begin{description}
+    \item [rx_csum_valid]
+        The number of packets with VIRTIO_NET_HDR_F_DATA_VALID.
+
+    \item [rx_needs_csum]
+        The number of packets with VIRTIO_NET_HDR_F_NEEDS_CSUM.
+
+    \item [rx_csum_bad]
+        The number of packets with abnormal csum.
+
+    \item [rx_csum_none]
+        The number of packets without hardware csum. The packet here refer=
s to
+        the non-TCP/UDP packet that the backend cannot recognize.
+
+\end{description}
+
+\subparagraph{Virtqueue Pair Stats: TX CSUM}\label{sec:Device Types / Netw=
ork Device / Device Operation / Control Virtqueue / Device Stats / Virtqueu=
e Pair Stats: TX CSUM}
+
+Only after the VIRTIO_NET_F_CSUM negotiation is successful, the tx csum
+counters are meaningful.
+
+The following are the tx csum counters:
+
+\begin{description}
+    \item [tx_csum_none]
+        The number of packets that didn't require hardware csum.
+
+    \item [tx_needs_csum]
+        The number of packets that required hardware csum.
+
+\end{description}
+
+\subparagraph{Virtqueue Pair Stats: RX GSO}\label{sec:Device Types / Netwo=
rk Device / Device Operation / Control Virtqueue / Device Stats / Virtqueue=
 Pair Stats: RX GSO}
+
+If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, or UFO options have
+been negotiated, rx gso counters are meaningful.
+
+Rx gso packets refer to packets passed by the device to the driver where
+\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
+
+The statistics of the following rx gso counters are based on the rx gso pa=
cket.
+The device may receive multiple small packets, and finally combine them in=
to one
+rx gso packet and pass it to the driver. It is also possible to receive a =
gso
+packet and pass it directly to the driver. We should count the information=
 of
+the rx gso packet that is finally passed to the driver (such as number and
+bytes). Instead of the information of the small packet.
+
+\begin{description}
+    \item [rx_gso_packets]
+        The number of the rx gso packets.
+
+    \item [rx_gso_bytes]
+        The number of bytes(excluding the virtio net header) of the rx gso=
 packets.
+\end{description}
+
+\subparagraph{Virtqueue Pair Stats: TX GSO}\label{sec:Device Types / Netwo=
rk Device / Device Operation / Control Virtqueue / Device Stats / Virtqueue=
 Pair Stats: TX GSO}
+
+If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have
+been negotiated, tx gso counters are meaningful.
+
+Rx gso packets refer to packets passed by the driver to the device where
+\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
+
+The statistics of the following tx gso counters are based on the tx gso pa=
cket.
+The device may receive a gso packet from the driver, and then may split it=
 into
+multiple small packets or send the gso packet directly. But the device cou=
nts
+the information of the gso packet received from the driver (such as the nu=
mber
+and bytes). Instead of the packet information after splitting.
+
+\begin{description}
+    \item [tx_gso_packets]
+        The number of the rx gso packets.
+
+    \item [tx_gso_bytes]
+        The number of bytes(excluding the virtio net header) of the rx gso=
 packets.
+\end{description}
+
+\subparagraph{Virtqueue Pair Stats: Queue Reset}\label{sec:Device Types / =
Network Device / Device Operation / Control Virtqueue / Device Stats / Virt=
queue Pair Stats: Queue Reset}
+
+Only when VIRTIO_F_RING_RESET is successfully negotiated, the reset counte=
rs
+are meaningful.
+
+See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue =
Reset}
+for more about \field{rx_reset} and \field{tx_reset}.
+
+\begin{description}
+    \item [rx_reset]
+        The number of queue resets.
+
+    \item [tx_reset]
+        The number of queue resets.
+\end{description}
+
+\devicenormative{\subparagraph}{Device Stats}{Device Types / Network Devic=
e / Device Operation / Control Virtqueue / Device Stats}
+
+For the command VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR, the device MUST fill=
 in
+\field{command-specific-data-reply} starting from the stats of the 0th
+virtuqueue pair.
+
+\drivernormative{\subparagraph}{Device Stats}{Device Types / Network Devic=
e / Device Operation / Control Virtqueue / Device Stats}
+
+\field{command-specific-data} MUST be empty for VIRTIO_NET_CTRL_STATS_GET_=
CTRL_VQ.
+
+For the command VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR, the size of the
+\field{command-specific-data-reply} allocated by the driver SHOULD be the =
size
+of the struct virtio_net_stats_queue_pair times the number of virtqueue pa=
irs
+currently in use.

 \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 Types / Network Device / Legacy Interface: Framing Requirements}
--
2.31.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

