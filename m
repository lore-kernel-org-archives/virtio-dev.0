Return-Path: <virtio-dev-return-13576-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D246AEE49A8
	for <virtio-dev@archiver.kernel.org>; Mon, 21 Aug 2023 06:43:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2FBC742D91
	for <virtio-dev@archiver.kernel.org>; Mon, 21 Aug 2023 06:43:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 18993986377
	for <virtio-dev@archiver.kernel.org>; Mon, 21 Aug 2023 06:43:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0BA29986238; Mon, 21 Aug 2023 06:43:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ED4C598622C;
	Mon, 21 Aug 2023 06:43:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VqBXR7P_1692600178;
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Parav Pandit <parav@nvidia.com>,
	David Edmondson <david.edmondson@oracle.com>,
	virtio-comment@lists.oasis-open.org
Date: Mon, 21 Aug 2023 14:42:58 +0800
Message-Id: <20230821064258.20608-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
X-Git-Hash: a9a9b43
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v15] virtio-net: support device stats

This patch allows the driver to obtain some statistics from the device.

In the device implementation, we can count a lot of such information,
which can be used for debugging and judging the running status of the
device. We hope to directly display it to the user through ethtool.

To get stats atomically, try to get stats for all/multiple queue pairs
in one command.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
---

v15:
   * query supported types via cvq @Parav
   * fix some problem @David

v14:
   * introduce supported_stats to config space
   * add header(vq_index, size, type) to each reply stats
   * add ref to the tx GSO

 device-types/net/description.tex        | 430 +++++++++++++++++++++++-
 device-types/net/device-conformance.tex |   1 +
 device-types/net/driver-conformance.tex |   1 +
 3 files changed, 429 insertions(+), 3 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index 76585b0..9f55c0d 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -88,6 +88,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.

+\item[VIRTIO_NET_F_DEVICE_STATS(50)] Device can provide device-level statistics
+    to the driver through the control channel.
+
 \item[VIRTIO_NET_F_HASH_TUNNEL(51)] Device supports inner header hash for encapsulated packets.

 \item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue notification coalescing.
@@ -1156,6 +1159,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
         u8 command;
         u8 command-specific-data[];
         u8 ack;
+        u8 command-specific-data-reply[];
 };

 /* ack values */
@@ -1164,9 +1168,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 \end{lstlisting}

 The \field{class}, \field{command} and command-specific-data are set by the
-driver, and the device sets the \field{ack} byte. There is little it can
-do except issue a diagnostic if \field{ack} is not
-VIRTIO_NET_OK.
+driver, and the device sets the \field{ack} byte and optionally
+\field{command-specific-data-reply}. There is little the driver can
+do except issue a diagnostic if \field{ack} is not VIRTIO_NET_OK.
+
+The command VIRTIO_NET_CTRL_STATS_GET contains \field{command-specific-data-reply}.

 \paragraph{Packet Receive Filtering}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Packet Receive Filtering}
 \label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Setting Promiscuous Mode}%old label for latexdiff
@@ -1805,6 +1811,424 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi

 Upon reset, a device MUST initialize all coalescing parameters to 0.

+\paragraph{Device Statistic}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Statistic}
+
+If the VIRTIO_NET_F_DEVICE_STATS feature is negotiated, the driver can obtain
+device stats from the device by using the following command.
+
+Different types of virtqueues have different stats. The stats of the receiveq
+are different from those of the transmitq.
+
+The stats of a certain type of virtqueue are also divided into multiple types
+because different types require different features. This enables the expansion
+of new stats.
+
+At one time, the driver can obtain the stats of one or multiple virtqueues.
+Additionally, the driver can obtain multiple type stats of each virtqueue.
+
+\begin{lstlisting}
+#define VIRTIO_NET_CTRL_STATS         7
+#define VIRTIO_NET_CTRL_STATS_QUERY   0
+#define VIRTIO_NET_CTRL_STATS_GET     1
+\end{lstlisting}
+
+To obtain device stats, use the VIRTIO_NET_CTRL_STATS_GET command with the
+\field{command-specific-data} containing the virtio_net_ctrl_queue_stats
+structure. The result is returned in the \field{command-specific-data-reply}.
+
+The following structure is used in \field{command-specific-data}:
+\begin{lstlisting}
+struct virtio_net_ctrl_queue_stats {
+       struct {
+           le16 vq_index;
+           le16 padding[3];
+           le64 types[1];
+       } stats[];
+};
+\end{lstlisting}
+
+The following structures are used in \field{command-specific-data-reply}:
+\begin{lstlisting}
+struct virtio_net_stats_capabilites {
+
+#define VIRTIO_NET_STATS_TYPE_CVQ       (1 << 0)
+#define VIRTIO_NET_STATS_TYPE_RX_BASIC  (1 << 1)
+#define VIRTIO_NET_STATS_TYPE_RX_CSUM   (1 << 2)
+#define VIRTIO_NET_STATS_TYPE_RX_GSO    (1 << 3)
+#define VIRTIO_NET_STATS_TYPE_TX_BASIC  (1 << 4)
+#define VIRTIO_NET_STATS_TYPE_TX_CSUM   (1 << 5)
+#define VIRTIO_NET_STATS_TYPE_TX_GSO    (1 << 6)
+    le64 supported_stats_types[1];
+}
+
+struct virtio_net_stats_reply_hdr {
+    le16 size;
+    le16 vq_index;
+
+#define VIRTIO_NET_STATS_TYPE_REPLY_CVQ       0
+#define VIRTIO_NET_STATS_TYPE_REPLY_RX_BASIC  1
+#define VIRTIO_NET_STATS_TYPE_REPLY_RX_CSUM   2
+#define VIRTIO_NET_STATS_TYPE_REPLY_RX_GSO    3
+#define VIRTIO_NET_STATS_TYPE_REPLY_TX_BASIC  4
+#define VIRTIO_NET_STATS_TYPE_REPLY_TX_CSUM   5
+#define VIRTIO_NET_STATS_TYPE_REPLY_TX_GSO    6
+    u8 type;
+    u8 padding[3];
+}
+
+struct virtio_net_stats_cvq {
+    struct virtio_net_stats_reply_hdr hdr;
+
+    le64 command_num;
+    le64 ok_num;
+};
+
+struct virtio_net_stats_rx_basic {
+    struct virtio_net_stats_reply_hdr hdr;
+
+    le64 rx_packets;
+    le64 rx_bytes;
+
+    le64 rx_notification;
+    le64 rx_interrupt;
+
+    le64 rx_drop;
+    le64 rx_drop_overruns;
+    le64 rx_drop_busy;
+};
+
+struct virtio_net_stats_rx_csum {
+    struct virtio_net_stats_reply_hdr hdr;
+
+    le64 rx_csum_valid;
+    le64 rx_needs_csum;
+    le64 rx_csum_bad;
+    le64 rx_csum_none;
+};
+
+struct virtio_net_stats_rx_gso {
+    struct virtio_net_stats_reply_hdr hdr;
+
+    le64 rx_gso_packets;
+    le64 rx_gso_bytes;
+    le64 rx_gso_packets_coalesced;
+    le64 rx_gso_bytes_coalesced;
+    le64 rx_gso_segments;
+    le64 rx_gso_segments_bytes;
+};
+
+struct virtio_net_stats_tx_basic {
+    struct virtio_net_stats_reply_hdr hdr;
+
+    le64 tx_packets;
+    le64 tx_bytes;
+
+    le64 tx_notification;
+    le64 tx_interrupt;
+
+    le64 tx_drop;
+    le64 tx_drop_malformed;
+
+    le64 tx_drop_busy;
+};
+
+struct virtio_net_stats_tx_csum {
+    struct virtio_net_stats_reply_hdr hdr;
+
+    le64 tx_csum_none;
+    le64 tx_needs_csum;
+};
+
+struct virtio_net_stats_tx_gso {
+    struct virtio_net_stats_reply_hdr hdr;
+
+    le64 tx_gso_packets;
+    le64 tx_gso_bytes;
+    le64 tx_gso_packets_split;
+    le64 tx_gso_bytes_split;
+    le64 tx_gso_segments;
+    le64 tx_gso_segments_bytes;
+};
+
+\end{lstlisting}
+
+The fields of the \field{struct virtio_net_ctrl_queue_stats}:
+\begin{description}
+    \item [vq_index]
+        The index of the virtqueue to obtain the stats.
+
+    \item [types]
+        This is a bitmask of the types of stats to be obtained. Therefore, a
+        \field{struct stats} inside virtio_net_ctrl_queue_stats may indicate
+        multiple stats replies for the virtqueue.
+\end{description}
+
+The fields of the \field{struct virtio_net_stats_reply_hdr}:
+\begin{description}
+    \item [vq_index]
+        The virtqueue index of the reply stats.
+
+    \item [size]
+        The size of bytes of the reply stats.
+
+    \item [type]
+        The type of the reply stats.
+
+\end{description}
+
+\subparagraph{Controlq Statistic}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Statistic / Controlq Statistic}
+
+The structure corresponding to the controlq stats is virtio_net_stats_cvq.
+The corresponding type is VIRTIO_NET_STATS_TYPE_CVQ. This is just for the
+controlq.
+
+\begin{description}
+    \item [command_num]
+        The number of commands including the current command.
+
+    \item [ok_num]
+        The number of commands (including the current command) where the ack was VIRTIO_NET_OK.
+\end{description}
+
+
+\subparagraph{Receiveq Basic Statistic}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Statistic / Receiveq Basic Statistic}
+
+The structure corresponding to the receiveq basic stats is virtio_net_stats_rx_basic.
+The corresponding type is VIRTIO_NET_STATS_TYPE_RX_BASIC. This is just for the
+receiveq.
+
+Receiveq basic stats does not require any feature. As long as the device supports
+VIRTIO_NET_F_DEVICE_STATS, the following are the receiveq basic stats.
+
+The packets described below were all presented on the specified virtqueue.
+\begin{description}
+    \item [rx_packets]
+        This is the number of packets received by the device (not the packets
+        passed to the guest). The count includes the packets dropped by the
+        device.
+
+    \item [rx_bytes]
+        This is the bytes of packets received by the device (not the packets
+        passed to the guest). The count includes the packets dropped by the
+        device.
+
+    \item [rx_notification]
+        The number of driver notifications received by device for this receiveq.
+
+    \item [rx_interrupt]
+        The number of device interrupts for this receiveq.
+
+    \item [rx_drop]
+        This is the number of packets dropped by the device. The count includes
+        all types of packets dropped by the device.
+
+    \item [rx_drop_overruns]
+        This is the number of packets dropped by the device when no more
+        descriptors were available.
+
+    \item [rx_drop_busy]
+        This is the number of packets dropped by the device when the device is
+        busy.
+
+\end{description}
+
+\subparagraph{Transmitq Basic Statistic}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Statistic / Transmitq Basic Statistic}
+
+The structure corresponding to the transmitq basic stats is virtio_net_stats_tx_basic.
+The corresponding type is VIRTIO_NET_STATS_TYPE_TX_BASIC. This is just for the
+transmitq.
+
+Transmitq basic stats does not require any feature. As long as the device supports
+VIRTIO_NET_F_DEVICE_STATS, the following are the transmitq basic stats.
+
+The packets described below are all from a specific virtqueue.
+\begin{description}
+    \item [tx_packets]
+        This is the number of packets sent by the device (not the packets
+        got from the driver).
+
+    \item [tx_bytes]
+        This is the bytes of packets sent by the device (not the packets
+        got from the driver).
+
+    \item [tx_notification]
+        The number of driver notifications for this transmitq.
+
+    \item [tx_interrupt]
+        The number of device interrupts for this transmitq.
+
+    \item [tx_drop]
+        The number of packets dropped by the device. The count includes all
+        types of packets dropped by the device.
+
+    \item [tx_drop_malformed]
+        The number of packets dropped by the device, when the descriptor is in
+        an error state. For example, the buffer is too short.
+
+    \item [tx_drop_busy]
+        The number of packets dropped by the device, when the device is busy.
+
+\end{description}
+
+\subparagraph{Receiveq CSUM Statistic}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Statistic / Receiveq CSUM Statistic}
+
+The structure corresponding to the receiveq csum stats is virtio_net_stats_rx_csum.
+The corresponding type is VIRTIO_NET_STATS_TYPE_RX_CSUM. This is just for the
+receiveq.
+
+Only after the VIRTIO_NET_F_GUEST_CSUM is negotiated, the receiveq csum stats
+can be obtained.
+
+The packets described below are all steered to a specific virtqueue.
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
+        The number of packets without hardware csum. The packet here refers to
+        the non-TCP/UDP packet that the backend cannot recognize.
+
+\end{description}
+
+\subparagraph{Transmitq CSUM Statistic}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Statistic / Transmitq CSUM Statistic}
+
+The structure corresponding to the transmitq csum stats is virtio_net_stats_tx_csum.
+The corresponding type is VIRTIO_NET_STATS_TYPE_TX_CSUM. This is just for the
+transmitq.
+
+Only after the VIRTIO_NET_F_CSUM is negotiated, the transmitq csum stats can be
+obtained.
+
+The following are the transmitq csum stats:
+
+The packets described below are all from a specific virtqueue.
+\begin{description}
+    \item [tx_csum_none]
+        The number of packets that didn't require hardware csum.
+
+    \item [tx_needs_csum]
+        The number of packets that required hardware csum.
+
+\end{description}
+
+\subparagraph{Receiveq GSO Statistic}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Statistic / Receiveq GSO Statistic}
+
+The structure corresponding to the receivq GSO stats is virtio_net_stats_rx_gso.
+The corresponding type is VIRTIO_NET_STATS_TYPE_RX_GSO. This is just for the
+receiveq.
+
+If one or more of the VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6, or
+VIRTIO_NET_F_GUEST_UFO have been negotiated, the receiveq GSO stats can be
+obtained.
+
+GSO packets refer to packets passed by the device to the driver where
+\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
+
+The packets described below are all steered to a specific virtqueue.
+\begin{description}
+    \item [rx_gso_packets]
+        The number of the GSO packets received by device.
+
+    \item [rx_gso_bytes]
+        The bytes of the GSO packets received by device.
+
+    \item [rx_gso_packets_coalesced]
+        The number of the GSO packets coalesced by device.
+
+    \item [rx_gso_bytes_coalesced]
+        The bytes of the GSO packets coalesced by device.
+
+    \item [rx_gso_segments]
+        The number of the segments that make up GSO packets.
+
+    \item [rx_gso_segments_bytes]
+        The bytes of the segments that make up GSO packets.
+
+\end{description}
+
+\subparagraph{Transmitq GSO Statistic}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Statistic / Transmitq GSO Statistic}
+
+The structure corresponding to the transmitq GSO stats is virtio_net_stats_tx_gso.
+The corresponding type is VIRTIO_NET_STATS_TYPE_TX_GSO. This is just for the
+transmitq.
+
+If one or more of the VIRTIO_NET_F_HOST_TSO4, VIRTIO_NET_F_HOST_TSO6,
+VIRTIO_NET_F_HOST_USO or VIRTIO_NET_F_HOST_UFO options have
+been negotiated, the transmitq GSO stats can be obtained.
+
+GSO packets refer to packets passed by the driver to the device where
+\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
+See more \ref{sec:Device Types / Network Device / Device Operation / Packet
+Transmission}.
+
+The packets described below are all from a specific virtqueue.
+\begin{description}
+    \item [tx_gso_packets]
+        The number of the GSO packets sent by device that are not cut to small
+        packets.
+
+    \item [tx_gso_bytes]
+        The bytes of the GSO packets sent by device that are not cut to small
+        packets.
+
+    \item [tx_gso_packets_split]
+        The number of the GSO packets that been cut into small packets.
+
+    \item [tx_gso_bytes_split]
+        The bytes of the GSO packets that been cut into small packets.
+
+    \item [tx_gso_segments]
+        The number of segments separated from the GSO packets.
+
+    \item [tx_gso_segments_bytes]
+        The bytes of segments separated from the GSO packets.
+\end{description}
+
+\devicenormative{\subparagraph}{Device Statistic}{Device Types / Network Device / Device Operation / Control Virtqueue / Device Statistic}
+The device MUST replies to the command VIRTIO_NET_CTRL_STATS_QUERY with the
+struct virtio_net_stats_capabilites. \field{supported_stats_types} includes all
+the stats types supported by the device.
+
+If virtio_net_ctrl_queue_stats is incorrect (such as the following), the device
+MUST set \field{ack} to VIRTIO_NET_ERR. Even if there is only one error,
+the device MUST fail the entire command.
+\begin{itemize}
+    \item \field{vq_index} exceeds the queue range.
+    \item \field{types} contains unknown types.
+    \item One or more of the bits present in \field{types} is not valid for the
+        specified virtqueue.
+    \item The feature corresponding to the specified \field{types} was not negotiated.
+    \item The size of the buffer allocated by the driver for \field{command-specific-data-reply}
+        is less than the total size of the stats specialed by
+        \field{virtio_net_ctrl_queue_stats}.
+\end{itemize}
+
+The device MUST write the requested stats structures in
+\field{command-specific-data-reply} in the order specified by the structure
+virtio_net_ctrl_queue_stats. If the \field{types} indicates multiple stats, the
+replies order by the type value from small to large.
+
+The device MUST set the actual size of the space occupied by the reply to the
+\field{size} of the \field{hdr}. And the device MUST set the \field{type} and
+the \field{vq_index} of the stats header.
+
+\drivernormative{\subparagraph}{Device Statistic}{Device Types / Network Device / Device Operation / Control Virtqueue / Device Statistic}
+
+The types contained in the \field{types} MUST be queried from the device via
+command VIRTIO_NET_CTRL_STATS_QUERY.
+
+\field{types} in struct virtio_net_ctrl_queue_stats MUST be valid to the vq
+specified by \field{vq_index}.
+
+The \field{command-specific-data-reply} buffer allocated by the driver MUST be
+able to hold all the stats specified by virtio_net_ctrl_queue_stats.
+
 \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 Types / Network Device / Legacy Interface: Framing Requirements}

diff --git a/device-types/net/device-conformance.tex b/device-types/net/device-conformance.tex
index f88f48b..8ce58fe 100644
--- a/device-types/net/device-conformance.tex
+++ b/device-types/net/device-conformance.tex
@@ -15,4 +15,5 @@
 \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
 \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
 \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Inner Header Hash}
+\item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Device Statistic}
 \end{itemize}
diff --git a/device-types/net/driver-conformance.tex b/device-types/net/driver-conformance.tex
index 9d853d9..b6636a2 100644
--- a/device-types/net/driver-conformance.tex
+++ b/device-types/net/driver-conformance.tex
@@ -15,4 +15,5 @@
 \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) }
 \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
 \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Inner Header Hash}
+\item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Device Statistic}
 \end{itemize}
--
2.32.0.3.g01195cf9f


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

