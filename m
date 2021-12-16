Return-Path: <virtio-dev-return-8998-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DC166986524
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Dec 2021 07:43:11 +0000 (UTC)
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Thu, 16 Dec 2021 15:43:06 +0800
Message-Id: <20211216074306.1463-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v5] virtio-net: support device stats
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: jasowang@redhat.com
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

This patch allows the driver to obtain some statistics from the device.

In the back-end implementation, we can count a lot of such information,
which can be used for debugging and judging the running status of the
back-end. We hope to directly display it to the user through ethtool.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---

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

 content.tex | 116 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index 899df5f..b3e8081 100644
--- a/content.tex
+++ b/content.tex
@@ -2987,6 +2987,9 @@ \subsection{Feature bits}\label{sec:Device Types / Ne=
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
@@ -3032,6 +3035,7 @@ \subsubsection{Feature bit requirements}\label{sec:De=
vice Types / Network Device
 \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
+\item[VIRTIO_NET_F_CTRL_STATS] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_=
F_HOST_TSO6.
 \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
 \end{description}
@@ -3910,6 +3914,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Ty=
pes / Network Device / Devi
         u8 command;
         u8 command-specific-data[];
         u8 ack;
+        u8 command-specific-data-reply[];
 };

 /* ack values */
@@ -3918,7 +3923,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Ty=
pes / Network Device / Devi
 \end{lstlisting}

 The \field{class}, \field{command} and command-specific-data are set by th=
e
-driver, and the device sets the \field{ack} byte. There is little it can
+driver, and the device sets the \field{ack} byte and optionally
+\field{command-specific-data-reply}. There is little it can
 do except issue a diagnostic if \field{ack} is not
 VIRTIO_NET_OK.

@@ -4399,6 +4405,114 @@ \subsubsection{Legacy Interface: Framing Requiremen=
ts}\label{sec:Device
 See \ref{sec:Basic
 Facilities of a Virtio Device / Virtqueues / Message Framing}.

+\paragraph{Device stats}\label{sec:Device Types / Network Device / Device =
Operation / Control Virtqueue / Device stats}
+
+If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the driver can
+get device stats from the device by \field{command-specific-data-reply}.
+
+To get the stats, the following definitions are used:
+\begin{lstlisting}
+#define VIRTIO_NET_CTRL_STATS                  6
+#define VIRTIO_NET_CTRL_STATS_GET_DEV          0
+#define VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ      1
+#define VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR   2
+\end{lstlisting}
+
+The following layout structure are used:
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
+    le64 dev_reset;         // The number of device reset.
+}
+
+struct virtio_net_ctrl_reply_stats_cvq {
+    le64 request_num; // The number of requests.
+    le64 ok_num;      // The number of ok ack.
+    le64 err_num;     // The number of err ack.
+
+    le64 req_rx_promisc;         // The number of requests with command VI=
RTIO_NET_CTRL_RX_PROMISC.
+    le64 req_rx_allmulti;        // The number of requests with command VI=
RTIO_NET_CTRL_RX_ALLMULTI.
+    le64 req_rx_alluni;          // The number of requests with command VI=
RTIO_NET_CTRL_RX_ALLUNI.
+    le64 req_rx_nomulti;         // The number of requests with command VI=
RTIO_NET_CTRL_RX_NOMULTI.
+    le64 req_rx_nouni;           // The number of requests with command VI=
RTIO_NET_CTRL_RX_NOUNI.
+    le64 req_rx_nobcast;         // The number of requests with command VI=
RTIO_NET_CTRL_RX_NOBCAST.
+    le64 req_mac_table_set;      // The number of requests with command VI=
RTIO_NET_CTRL_MAC_TABLE_SET.
+    le64 req_mac_addr_set;       // The number of requests with command VI=
RTIO_NET_CTRL_MAC_ADDR_SET.
+    le64 req_vlan_add;           // The number of requests with command VI=
RTIO_NET_CTRL_VLAN_ADD.
+    le64 req_vlan_del;           // The number of requests with command VI=
RTIO_NET_CTRL_VLAN_DEL.
+    le64 req_announce_ack;       // The number of requests with command VI=
RTIO_NET_CTRL_ANNOUNCE_ACK.
+    le64 req_mq_vq_pairs_set;    // The number of requests with command VI=
RTIO_NET_CTRL_MQ_VQ_PAIRS_SET.
+    le64 req_mq_rss_config;      // The number of requests with command VI=
RTIO_NET_CTRL_MQ_RSS_CONFIG.
+    le64 req_mq_hash_config;     // The number of requests with command VI=
RTIO_NET_CTRL_MQ_HASH_CONFIG.
+    le64 req_guest_offloads_set; // The number of requests with command VI=
RTIO_NET_CTRL_GUEST_OFFLOADS_SET.
+}
+
+struct virtio_net_ctrl_reply_stats_queue_pair {
+    /* rx stats */
+    le64 rx_packets;
+    le64 rx_bytes;
+
+    le64 rx_kicks;            // The number of kicks from driver.
+    le64 rx_calls;            // The number of calls generated by device.
+
+    le64 rx_drop;             // The number of packets dropped by the rx q=
ueue. Contains all kinds of packet drop.
+    le64 rx_drop_overruns;    // The number of packets dropped by the rx q=
ueue when no more avail desc.
+    le64 rx_drop_oversize;    // The number of oversized packets received =
by the rx queue.
+
+    le64 rx_csum_valid;       // The number of packets with VIRTIO_NET_HDR=
_F_DATA_VALID.
+    le64 rx_csum_partial;     // The number of packets with VIRTIO_NET_HDR=
_F_NEEDS_CSUM.
+    le64 rx_csum_none;        // The number of packets with abnormal csum =
or that not been checked when VIRTIO_NET_F_GUEST_CSUM is not negotiated.
+
+    le64 rx_gso_packets;      // The number of gso packets received by rx.
+    le64 rx_gso_bytes;        // The number of gso bytes received by rx.
+
+    /* tx stats */
+    le64 tx_packets;
+    le64 tx_bytes;
+
+    le64 tx_kicks;            // The number of kicks from driver.
+    le64 tx_calls;            // The number of calls generated by device.
+
+    le64 tx_drop;             // The number of packets dropped by the tx q=
ueue. Contains all kinds of packet drop.
+    le64 tx_drop_desc_err;    // The number of packets dropped when desc i=
s error.
+    le64 tx_drop_flow_limit;  // The number of packets dropped by flow lim=
it.
+
+    le64 tx_csum_none;        // The number of packets with VIRTIO_NET_HDR=
_F_DATA_VALID.
+    le64 tx_csum_partial;     // The number of packets with VIRTIO_NET_HDR=
_F_NEEDS_CSUM.
+
+    le64 tx_gso_packets;      // The number of gso packets transmitted.
+    le64 tx_gso_bytes;        // The number of gso bytes transmitted.
+}
+\end{lstlisting}
+
+All device stats are divided into three categories:
+\begin{itemize}
+    \item the stats of the device. (command: VIRTIO_NET_CTRL_STATS_GET_DEV=
)
+    \item the stats of the controlq. (command: VIRTIO_NET_CTRL_STATS_GET_C=
TRL_VQ)
+    \item the stats of the queue pair. This contains the stats of rx and t=
x.
+        (command: VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR)
+\end{itemize}
+
+When driver sends a VIRTIO_NET_CTRL_STATS_GET_DEV command, \field{command-=
specific-data} MUST be empty.
+The structure \field{virtio_net_ctrl_reply_stats_dev} MUST be used for \fi=
eld{command-specific-data-reply}.
+
+When driver sends a VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ command, \field{comm=
and-specific-data} MUST be empty.
+The structure \field{virtio_net_ctrl_reply_stats_cvq} MUST be used for \fi=
eld{command-specific-data-reply}.
+If VIRTIO_NET_F_CTRL_VQ is not negotiated, device MUST set the ack of \fie=
ld{virtio_net_ctrl} to VIRTIO_NET_ERR;
+
+Driver sends a VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR command using \field{v=
irtio_net_ctrl_stats_queue_pair} for \field{command-specific-data}.
+At the same time, the structure \field{virtio_net_ctrl_reply_stats_queue_p=
air} MUST be used for \field{command-specific-data-reply}.
+\field{queue_pair_index} specify the queue pair index of the queue that th=
e driver wants to get stats.
+If the requested queue_pair_index is out of range, device MUST set the ack=
 of \field{virtio_net_ctrl} to VIRTIO_NET_ERR;
+
 \section{Block Device}\label{sec:Device Types / Block Device}

 The virtio block device is a simple virtual block device (ie.
--
2.31.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

