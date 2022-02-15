Return-Path: <virtio-dev-return-9294-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B4BB0986388
	for <virtio-dev@lists.oasis-open.org>; Tue, 15 Feb 2022 07:47:49 +0000 (UTC)
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Tue, 15 Feb 2022 15:47:43 +0800
Message-Id: <20220215074743.35155-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v9] virtio-net: support device stats
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This patch allows the driver to obtain some statistics from the device.

In the back-end implementation, we can count a lot of such information,
which can be used for debugging and judging the running status of the
back-end. We hope to directly display it to the user through ethtool.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 conformance.tex |   2 +
 content.tex     | 135 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 134 insertions(+), 3 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index 42f8537..950924e 100644
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
n / Control Virtqueue / Device stats}
 \end{itemize}
=20
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
n / Control Virtqueue / Device stats}
 \end{itemize}
=20
 \conformance{\subsection}{Block Device Conformance}\label{sec:Conformance =
/ Device Conformance / Block Device Conformance}
diff --git a/content.tex b/content.tex
index c6f116c..818275d 100644
--- a/content.tex
+++ b/content.tex
@@ -3092,6 +3092,9 @@ \subsection{Feature bits}\label{sec:Device Types / Ne=
twork Device / Feature bits
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.
=20
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
=20
 /* ack values */
@@ -4023,9 +4028,13 @@ \subsubsection{Control Virtqueue}\label{sec:Device T=
ypes / Network Device / Devi
 \end{lstlisting}
=20
 The \field{class}, \field{command} and command-specific-data are set by th=
e
-driver, and the device sets the \field{ack} byte. There is little it can
-do except issue a diagnostic if \field{ack} is not
-VIRTIO_NET_OK.
+driver, and the device sets the \field{ack} byte and optionally
+\field{command-specific-data-reply}. There is little the driver can
+do except issue a diagnostic if \field{ack} is not VIRTIO_NET_OK.
+
+These commands VIRTIO_NET_CTRL_STATS_GET_DEV,
+VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ, and VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAI=
R contain
+\field{command-specific-data-reply}.
=20
 \paragraph{Packet Receive Filtering}\label{sec:Device Types / Network Devi=
ce / Device Operation / Control Virtqueue / Packet Receive Filtering}
 \label{sec:Device Types / Network Device / Device Operation / Control Virt=
queue / Setting Promiscuous Mode}%old label for latexdiff
@@ -4471,6 +4480,126 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
 according to the native endian of the guest rather than
 (necessarily when not using the legacy interface) little-endian.
=20
+\paragraph{Device stats}\label{sec:Device Types / Network Device / Device =
Operation / Control Virtqueue / Device stats}
+
+If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the driver can
+get device stats from the device in \field{command-specific-data-reply}.
+
+To get the stats, the following definitions are used:
+\begin{lstlisting}
+#define VIRTIO_NET_CTRL_STATS                  6
+#define VIRTIO_NET_CTRL_STATS_GET_DEV          0
+#define VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ      1
+#define VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR   2
+\end{lstlisting}
+
+The following layout structures are used:
+
+\field{command-specific-data}
+\begin{lstlisting}
+struct virtio_net_ctrl_stats_queue_pair {
+    le64 queue_pair_index;
+}
+\end{lstlisting}
+
+\field{command-specific-data-reply}
+\begin{lstlisting}
+struct virtio_net_ctrl_reply_stats_dev {
+    le64 mac_unicast_num;   /* The number of unicast mac addresses. */
+    le64 mac_multicast_num; /* The number of multicast mac addresses. */
+    le64 vlan_num;          /* The number of vlan. */
+}
+
+struct virtio_net_ctrl_reply_stats_cvq {
+    le64 command_num;            /* The number of commands, including the =
current command. */
+    le64 ok_num;                 /* The number of commands (including the =
current command) where the ack was VIRTIO_NET_OK. */
+}
+
+struct virtio_net_ctrl_reply_stats_queue_pair {
+    /* rx stats */
+    le64 rx_packets;          /* The number of packets received by device =
(not the packets passed to the guest), including the dropped packets by dev=
ice. */
+    le64 rx_bytes;            /* The number of bytes received by device (n=
ot the packets passed to the guest), including the dropped packets by devic=
e. */
+
+    le64 rx_notification;     /* The number of notifications from driver. =
*/
+    le64 rx_interrupt;        /* The number of interrupts generated by dev=
ice. */
+
+    le64 rx_drop;             /* The number of packets dropped by the rx q=
ueue. Contains all kinds of packet drop. */
+    le64 rx_drop_overruns;    /* The number of packets dropped by the rx q=
ueue when no more descriptors were available. */
+
+    le64 rx_csum_valid;       /* The number of packets with VIRTIO_NET_HDR=
_F_DATA_VALID. */
+    le64 rx_csum_partial;     /* The number of packets with VIRTIO_NET_HDR=
_F_NEEDS_CSUM. */
+    le64 rx_csum_bad;         /* The number of packets with abnormal csum.=
 */
+    le64 rx_csum_none;        /* The number of packets without hardware cs=
um. */
+
+    le64 rx_gso_packets;      /* The number of GSO packets written into th=
e RX VQ buffers. */
+    le64 rx_gso_bytes;        /* The number of bytes(excluding the virtio =
net header) of the GSO packets written into the RX VQ buffers. */
+    le64 rx_reset;            /* The number of queue resets. */
+
+    /* tx stats */
+    le64 tx_packets;          /* The number of packets sent by device (not=
 the packets received from the guest), excluding the dropped packets by dev=
ice. */
+    le64 tx_bytes;            /* The number of bytes sent by device (not t=
he packets received from the guest), excluding the dropped packets by devic=
e. */
+
+    le64 tx_notification;     /* The number of notifications from driver. =
*/
+    le64 tx_interrupt;        /* The number of interrupts generated by dev=
ice. */
+
+    le64 tx_drop;             /* The number of packets dropped by the tx q=
ueue. Contains all kinds of packet drop. */
+    le64 tx_drop_malformed;   /* The number of packets dropped when the de=
scriptor is in an error state. */
+
+    le64 tx_csum_none;        /* The number of packets that doesn't requir=
e hardware csum. */
+    le64 tx_csum_partial;     /* The number of packets that requires hardw=
are csum. */
+
+    le64 tx_gso_packets;      /* The number of GSO packets that the device=
 received from the driver. */
+    le64 tx_gso_bytes;        /* The number of bytes(excluding the virtio =
net header) of GSO packets that the device received from the driver. */
+    le64 tx_reset;            /* The number of queue resets. */
+}
+\end{lstlisting}
+
+See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue =
Reset}
+for more about \field{rx_reset} and \field{tx_reset}.
+
+All device stats are divided into three categories:
+\begin{itemize}
+    \item the stats of the device.
+        \begin{description}
+            \item[command] VIRTIO_NET_CTRL_STATS_GET_DEV
+            \item[command-specific-data-reply] virtio_net_ctrl_reply_stats=
_dev
+        \end{description}
+
+    \item the stats of the controlq.
+        \begin{description}
+            \item[command] VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ
+            \item[command-specific-data-reply] virtio_net_ctrl_reply_stats=
_cvq
+        \end{description}
+
+    \item the stats of the queue pair. This contains the stats of rx and t=
x.
+        \begin{description}
+            \item[command] VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR
+            \item[command-specific-data] virtio_net_ctrl_stats_queue_pair
+            \item[command-specific-data-reply] virtio_net_ctrl_reply_stats=
_queue_pair
+        \end{description}
+\end{itemize}
+
+
+\devicenormative{\subparagraph}{Device stats}{Device Types / Network Devic=
e / Device Operation / Control Virtqueue / Device stats}
+
+If VIRTIO_NET_F_CTRL_STATS has been negotiated, the device MUST support th=
e
+VIRTIO_NET_CTRL_STATS_GET_DEV, VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ and
+VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR commands.
+
+If \field{queue_pair_index} is out of range for a
+VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR command, the device MUST set \field{a=
ck} in
+virtio_net_ctrl to VIRTIO_NET_ERR.
+
+If VIRTIO_NET_F_GUEST_CSUM is not successfully negotiated, all csum relate=
d
+metrics MUST be 0.
+
+GSO packet refers to the packet of gso_type !=3D VIRTIO_NET_HDR_GSO_NONE.
+All statistics on GSO MUST be based on the GSO packets.
+
+\drivernormative{\subparagraph}{Device stats}{Device Types / Network Devic=
e / Device Operation / Control Virtqueue / Device stats}
+
+\field{command-specific-data} MUST be empty for VIRTIO_NET_CTRL_STATS_GET_=
DEV
+and VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ.
=20
 \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 Types / Network Device / Legacy Interface: Framing Requirements}
--=20
2.31.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

