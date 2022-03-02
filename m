Return-Path: <virtio-dev-return-9343-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 69F409864BC
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Mar 2022 08:52:23 +0000 (UTC)
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Wed,  2 Mar 2022 16:52:17 +0800
Message-Id: <20220302085217.16546-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v11] virtio-net: support device stats
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
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
---
v11:
1. Use michael's advice to introduce virtio_net_ctrl_queue_stats to get vq =
stats
   based on vq num and type
2. split stats structure

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
 content.tex     | 391 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 390 insertions(+), 3 deletions(-)

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
index c6f116c..5746f49 100644
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
@@ -4023,9 +4028,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device T=
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
+The command VIRTIO_NET_CTRL_STATS_GET contains \field{command-specific-dat=
a-reply}.

 \paragraph{Packet Receive Filtering}\label{sec:Device Types / Network Devi=
ce / Device Operation / Control Virtqueue / Packet Receive Filtering}
 \label{sec:Device Types / Network Device / Device Operation / Control Virt=
queue / Setting Promiscuous Mode}%old label for latexdiff
@@ -4471,6 +4478,384 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
 according to the native endian of the guest rather than
 (necessarily when not using the legacy interface) little-endian.

+\paragraph{Device Stats}\label{sec:Device Types / Network Device / Device =
Operation / Control Virtqueue / Device Stats}
+
+If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the driver can
+get the device stats from the device in \field{command-specific-data-reply=
}.
+
+To get the stats, the following definitions are used:
+\begin{lstlisting}
+#define VIRTIO_NET_CTRL_STATS         6
+#define VIRTIO_NET_CTRL_STATS_GET     0
+
+#define VIRTIO_NET_STATS_TYPE_CVQ      0
+#define VIRTIO_NET_STATS_TYPE_RX_BASIC 1
+#define VIRTIO_NET_STATS_TYPE_RX_CSUM  2
+#define VIRTIO_NET_STATS_TYPE_RX_GSO   3
+#define VIRTIO_NET_STATS_TYPE_RX_RESET 4
+#define VIRTIO_NET_STATS_TYPE_TX_BASIC 5
+#define VIRTIO_NET_STATS_TYPE_TX_CSUM  6
+#define VIRTIO_NET_STATS_TYPE_TX_GSO   7
+#define VIRTIO_NET_STATS_TYPE_TX_RESET 8
+
+\end{lstlisting}
+
+The following layout structures are used:
+
+\field{command-specific-data}
+\begin{lstlisting}
+struct virtio_net_ctrl_queue_stats {
+=09u16 nstats;
+=09struct {
+=09    u16 queue_num;
+=09    u16 type;
+=09    u16 length;
+=09} stats[];
+};
+\end{lstlisting}
+
+\field{command-specific-data-reply}
+\begin{lstlisting}
+struct virtio_net_stats_cvq {
+    le64 command_num;
+    le64 ok_num;
+};
+
+struct virtio_net_stats_rx_basic {
+    le64 rx_packets;
+    le64 rx_bytes;
+
+    le64 rx_notification;
+    le64 rx_interrupt;
+
+    le64 rx_drop;
+    le64 rx_drop_overruns;
+};
+
+struct virtio_net_stats_rx_csum {
+    le64 rx_csum_valid;
+    le64 rx_needs_csum;
+    le64 rx_csum_bad;
+    le64 rx_csum_none;
+};
+
+struct virtio_net_stats_rx_gso {
+    le64 rx_gso_packets;
+    le64 rx_gso_bytes;
+};
+
+struct virtio_net_stats_rx_reset {
+    le64 rx_reset;
+};
+
+struct virtio_net_stats_tx_basic {
+    le64 tx_packets;
+    le64 tx_bytes;
+
+    le64 tx_notification;
+    le64 tx_interrupt;
+
+    le64 tx_drop;
+    le64 tx_drop_malformed;
+};
+
+struct virtio_net_stats_tx_csum {
+    le64 tx_csum_none;
+    le64 tx_needs_csum;
+};
+
+struct virtio_net_stats_tx_gso {
+    le64 tx_gso_packets;
+    le64 tx_gso_bytes;
+};
+
+struct virtio_net_stats_tx_reset {
+    le64 tx_reset;
+};
+
+\end{lstlisting}
+
+Use the command VIRTIO_NET_CTRL_STATS_GET and \field{command-specific-data=
}
+containing struct virtio_net_ctrl_queue_stats to get the device stats.
+The result is returned by \field{command-specific-data-reply}.
+
+\begin{description}
+    \item [nstats]
+        The number of \field{stats}.
+
+    \item [queue_num]
+        The queue num of the vq to be obtained. The vq can be receiveq,
+        transmitq or controlq.
+
+    \item [type]
+        The type of the stats to be obtained.
+
+    \item [length]
+        Limits the size of the memory space occupied by the returned stats=
.
+
+\end{description}
+
+Correspondence between the vq type, the stats type, the stats structure an=
d the
+required features.
+\begin{tabular}{ |l|l|l|l| }
+    \hline
+    VQ Type                  & Stats Type                     & Stats Stru=
cture           & Features \\ \hline
+
+    controlq                 & VIRTIO_NET_STATS_TYPE_CVQ      & virtio_net=
_stats_cvq      & \\ \hline
+
+    \multirow{4}*{receiveq}  & VIRTIO_NET_STATS_TYPE_RX_BASIC & virtio_net=
_stats_rx_basic & \\ \cline{2-4}
+                             & VIRTIO_NET_STATS_TYPE_RX_CSUM  & virtio_net=
_stats_rx_csum  & VIRTIO_NET_F_GUEST_CSUM \\ \cline{2-4}
+                             & VIRTIO_NET_STATS_TYPE_RX_GSO   & virtio_net=
_stats_rx_gso   & VIRTIO_NET_F_GUEST_TSO4, TSO6, or UFO \\ \cline{2-4}
+                             & VIRTIO_NET_STATS_TYPE_RX_RESET & virtio_net=
_stats_rx_reset & VIRTIO_F_RING_RESET \\ \hline
+
+    \multirow{4}*{transmitq} & VIRTIO_NET_STATS_TYPE_TX_BASIC & virtio_net=
_stats_tx_basic & \\ \cline{2-4}
+                             & VIRTIO_NET_STATS_TYPE_TX_CSUM  & virtio_net=
_stats_tx_csum  & VIRTIO_NET_F_CSUM \\ \cline{2-4}
+                             & VIRTIO_NET_STATS_TYPE_TX_GSO   & virtio_net=
_stats_tx_gso   & VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO \\ \cline{2-4}
+                             & VIRTIO_NET_STATS_TYPE_TX_RESET & virtio_net=
_stats_tx_reset & VIRTIO_F_RING_RESET \\
+    \hline
+\end{tabular}
+
+
+\subparagraph{Controlq Stats}\label{sec:Device Types / Network Device / De=
vice Operation / Control Virtqueue / Device Stats / Controlq Stats}
+
+The structure corresponding to the controlq stats is virtio_net_stats_cvq.
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
+
+\subparagraph{Receiveq Basic Stats}\label{sec:Device Types / Network Devic=
e / Device Operation / Control Virtqueue / Device Stats / Receiveq Basic St=
ats}
+
+The structure corresponding to the receiveq basic stats is virtio_net_stat=
s_rx_basic.
+
+Receiveq basic stats doesn't need any features, as long as the device supp=
orts
+VIRTIO_NET_F_CTRL_STATS. The following are the receiveq basic stats.
+
+\begin{description}
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
+        The number of packets dropped by the receiveq. Contains all kinds =
of
+        packet drop.
+
+    \item [rx_drop_overruns]
+        The number of packets dropped by the receiveq when no more descrip=
tors
+        were available.
+
+\end{description}
+
+\subparagraph{Transmitq Basic Stats}\label{sec:Device Types / Network Devi=
ce / Device Operation / Control Virtqueue / Device Stats / Transmitq Basic =
Stats}
+
+The structure corresponding to the transmitq basic stats is virtio_net_sta=
ts_tx_basic.
+
+Transmitq basic stats doesn't need any features, as long as the device sup=
ports
+VIRTIO_NET_F_CTRL_STATS. The following are the transmitq basic stats.
+
+\begin{description}
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
+        The number of packets dropped by the transmitq. Contains all kinds=
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
+\subparagraph{Receiveq CSUM Stats}\label{sec:Device Types / Network Device=
 / Device Operation / Control Virtqueue / Device Stats / Receiveq CSUM Stat=
s}
+
+The structure corresponding to the receiveq csum stats is virtio_net_stats=
_rx_csum.
+
+Only after the VIRTIO_NET_F_GUEST_CSUM negotiation is successful, the rece=
iveq
+csum stats can be obtained.
+
+The following are the receiveq csum stats:
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
+\subparagraph{Transmitq CSUM Stats}\label{sec:Device Types / Network Devic=
e / Device Operation / Control Virtqueue / Device Stats / Transmitq CSUM St=
ats}
+
+The structure corresponding to the transmitq csum stats is virtio_net_stat=
s_tx_csum.
+
+Only after the VIRTIO_NET_F_CSUM negotiation is successful, the transmitq =
csum
+stats can be obtained.
+
+The following are the transmitq csum stats:
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
+\subparagraph{Receiveq GSO Stats}\label{sec:Device Types / Network Device =
/ Device Operation / Control Virtqueue / Device Stats / Receiveq GSO Stats}
+
+The structure corresponding to the receiveq gso stats is virtio_net_stats_=
rx_gso.
+
+If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, or UFO options have
+been negotiated, the receiveq gso stats can be obtained.
+
+Rx gso packets refer to packets passed by the device to the driver where
+\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
+
+The statistics of the following receiveq gso stats are based on the rx gso
+packet. The device may receive multiple small packets, and finally combine=
 them
+into one rx gso packet and pass it to the driver. It is also possible to r=
eceive
+a gso packet and pass it directly to the driver. We should count the infor=
mation
+of the rx gso packet that is finally passed to the driver (such as number =
and
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
+\subparagraph{Transmitq GSO Stats}\label{sec:Device Types / Network Device=
 / Device Operation / Control Virtqueue / Device Stats / Transmitq GSO Stat=
s}
+
+The structure corresponding to the receiveq gso stats is virtio_net_stats_=
tx_gso.
+
+If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have
+been negotiated, the transmitq gso stats can be obtained.
+
+Tx gso packets refer to packets passed by the driver to the device where
+\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
+
+The statistics of the following transmitq gso stats are based on the tx gs=
o
+packet. The device may receive a tx gso packet from the driver, and then m=
ay split
+it into multiple small packets or send the tx gso packet directly. But the=
 device
+counts the information of the gso packet received from the driver (such as=
 the
+number and bytes). Instead of the packet information after splitting.
+
+\begin{description}
+    \item [tx_gso_packets]
+        The number of the tx gso packets.
+
+    \item [tx_gso_bytes]
+        The number of bytes(excluding the virtio net header) of the tx gso=
 packets.
+\end{description}
+
+\subparagraph{Receiveq Reset Stats}\label{sec:Device Types / Network Devic=
e / Device Operation / Control Virtqueue / Device Stats / Receiveq Reset St=
ats}
+
+The structure corresponding to the receiveq reset stats is virtio_net_stat=
s_rx_reset.
+
+Only when VIRTIO_F_RING_RESET is successfully negotiated, the receiveq res=
et stats
+can be obtained.
+
+See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue =
Reset}
+for more about \field{rx_reset}.
+
+\begin{description}
+    \item [rx_reset]
+        The number of queue resets.
+\end{description}
+
+\subparagraph{Transmitq Reset Stats}\label{sec:Device Types / Network Devi=
ce / Device Operation / Control Virtqueue / Device Stats / Transmitq Reset =
Stats}
+
+The structure corresponding to the transmitq reset stats is virtio_net_sta=
ts_tx_reset.
+
+Only when VIRTIO_F_RING_RESET is successfully negotiated, the transmitq re=
set stats
+can be obtained.
+
+See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue =
Reset}
+for more about \field{tx_reset}.
+
+\begin{description}
+    \item [tx_reset]
+        The number of queue resets.
+\end{description}
+
+\devicenormative{\subparagraph}{Device Stats}{Device Types / Network Devic=
e / Device Operation / Control Virtqueue / Device Stats}
+
+If virtio_net_ctrl_queue_stats is incorrect (such as the following), the d=
evice
+MUST set \field{ack} to VIRTIO_NET_ERR.
+\begin{itemize}
+    \item \field{queue_num} exceeds the queue range.
+    \item \field{type} is not a known value.
+    \item The type of vq does not match \field{type}.
+    \item The feature corresponding to the specified \field{type} was not =
successfully
+        negotiated.
+    \item The size of \field{command-specific-data-reply} is less than the=
 sum
+        of \field{length}.
+\end{itemize}
+
+The device MUST write the requested stats structures in
+\field{command-specific-data-reply} in the order specified by the structur=
e
+virtio_net_ctrl_queue_stats.
+
+The size of each stats MUST be less than or equal to the corresponding
+\field{length}, but the space it occupies MUST be equal to the correspondi=
ng
+\field{length}.
+
+\drivernormative{\subparagraph}{Device Stats}{Device Types / Network Devic=
e / Device Operation / Control Virtqueue / Device Stats}
+
+When a driver tries to obtain a certain stats, it MUST confirm that the re=
levant
+feature negotiation is successful.
+
+\field{type} in struct virtio_net_ctrl_queue_stats MUST correspond to the =
vq
+specified by \field{queue_num}.
+
+\field{length} in struct virtio_net_ctrl_queue_stats MUST be greater than =
or
+equal to the size of the structure corresponding to \field{type}. It MUST =
be a
+multiple of 8.
+
+The size of \field{command-specific-data-reply} allocated by the driver MU=
ST be
+greater than or equal to the sum of \field{legnth} in struct
+virtio_net_ctrl_queue_stats.
+
+When the driver reads the response, it MUST read
+\field{command-specific-data-reply} one by one based on the set \field{len=
gth}
+and \field{type}.

 \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 Types / Network Device / Legacy Interface: Framing Requirements}
--
2.31.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

