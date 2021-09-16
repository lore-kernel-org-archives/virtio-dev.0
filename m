Return-Path: <virtio-dev-return-8671-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A00B9863D0
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Sep 2021 09:33:38 +0000 (UTC)
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Thu, 16 Sep 2021 17:33:33 +0800
Message-Id: <20210916093333.7494-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3] virtio-net: support device stats
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch allows the driver to obtain some statistics from the device.

In the back-end implementation, we can count a lot of such information,
which can be used for debugging and judging the running status of the
back-end. We hope to directly display it to the user through ethtool.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---

v3 changes:
1. add dev_version
2. use queue_pair_index replace rx_num, tx_num
3. Explain the processing when the device and driver support different numb=
ers
of stats

 content.tex | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/content.tex b/content.tex
index 7cec1c3..2e45a55 100644
--- a/content.tex
+++ b/content.tex
@@ -2972,6 +2972,9 @@ \subsection{Feature bits}\label{sec:Device Types / Ne=
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
@@ -3017,6 +3020,7 @@ \subsubsection{Feature bit requirements}\label{sec:De=
vice Types / Network Device
 \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
+\item[VIRTIO_NET_F_CTRL_STATS] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_=
F_HOST_TSO6.
 \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
 \end{description}
@@ -3895,6 +3899,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Ty=
pes / Network Device / Devi
         u8 command;
         u8 command-specific-data[];
         u8 ack;
+        u8 command-specific-data-reply[];
 };

 /* ack values */
@@ -3906,6 +3911,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Ty=
pes / Network Device / Devi
 driver, and the device sets the \field{ack} byte. There is little it can
 do except issue a diagnostic if \field{ack} is not
 VIRTIO_NET_OK.
+\field{command-specific-data-reply} is alloced by driver, then pass to dev=
ice.
+It is filled by the device. It is optional. Some commands need to get some
+information from the device.

 \paragraph{Packet Receive Filtering}\label{sec:Device Types / Network Devi=
ce / Device Operation / Control Virtqueue / Packet Receive Filtering}
 \label{sec:Device Types / Network Device / Device Operation / Control Virt=
queue / Setting Promiscuous Mode}%old label for latexdiff
@@ -4384,6 +4392,113 @@ \subsubsection{Legacy Interface: Framing Requiremen=
ts}\label{sec:Device
 See \ref{sec:Basic
 Facilities of a Virtio Device / Virtqueues / Message Framing}.

+\paragraph{Device stats}\label{sec:Device Types / Network Device / Device =
Operation / Control Virtqueue / Device stats}
+
+If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the driver can
+get device stats from the device by \field{command-specific-data-reply}.
+
+\subparagraph{Device stats keys}\label{sec:Device Types / Network Device /=
 Device Operation / Control Virtqueue / Device stats keys / Device stats ke=
ys}
+
+The keys of the device stats are defined as follows. When the device fills=
 in
+\field{command-specific-data-reply}, it MUST be written in the following o=
rder.
+Subsequent newly added keys MUST be added at the end of each category.
+These keys will eventually be shown to the user.
+
+All stats are divided into three categories:
+
+\begin{itemize}
+    \item dev stats: the stats of the device
+        \begin{itemize}
+            \item dev_version: The number of device version.
+            \item dev_reset: The number of device reset.
+        \end{itemize}
+
+    \item rx stats: the stats of the rx queue
+        \begin{itemize}
+            \item rx[N]_inter: The number of interrupts sent by the rx que=
ue.
+            \item rx[N]_drop: The number of packets dropped by the rx queu=
e. Contains all kinds of packet loss.
+            \item rx[N]_drop_overruns: The number of packets dropped by th=
e rx queue when no more avail desc.
+            \item rx[N]_csum_bad: The number of packets with abnormal csum=
 in the rx queue.
+            \item rx[N]_gso_packets: The number of gso packets received by=
 rx.
+            \item rx[N]_gso_bytes: The number of gso bytes received by rx.
+            \item rx[N]_oversize_pkts: The number of oversized packets rec=
eived by the rx queue.
+        \end{itemize}
+
+    \item tx stats: the stats of the tx queue
+        \begin{itemize}
+            \item tx[N]_inter: The number of interrupts sent by the tx que=
ue.
+            \item tx[N]_drop: The number of packets dropped by the tx queu=
e. Contains all kinds of packet loss.
+            \item tx[N]_csum: The number of packets that completes csum by=
 the device.
+            \item tx[N]_gso_packets: The number of gso packets transmitted=
.
+            \item tx[N]_gso_bytes: The number of gso bytes transmitted.
+        \end{itemize}
+\end{itemize}
+
+\subparagraph{Device stats get}\label{sec:Device Types / Network Device / =
Device Operation / Control Virtqueue / Device stats keys / Device stats get=
}
+
+To get the stats, the following definitions are used:
+\begin{lstlisting}
+#define VIRTIO_NET_CTRL_STATS        6
+#define VIRTIO_NET_CTRL_STATS_GET    0
+\end{lstlisting}
+
+The following layout structure are used:
+
+\field{command-specific-data}
+\begin{lstlisting}
+le64 queue_pair_index
+le64 dev_stats_num;
+le64 rx_stats_num;
+le64 tx_stats_num;
+\end{lstlisting}
+
+\field{command-specific-data-reply}
+\begin{lstlisting}
+le64 queue_pair_index
+le64 dev_stats_num;
+le64 rx_stats_num;
+le64 tx_stats_num;
+le64 dev_stats[dev_stats_num];
+le64 rx_stats[rx_stats_num];
+le64 tx_stats[tx_stats_num];
+\end{lstlisting}
+
+The command VIRTIO_NET_CTRL_STATS_GET is used to obtain this information.
+
+Regarding the variables in \field{command-specific-data}:
+\begin{itemize}
+    \item \field{queue_pair_index}: Specify the queue pair index of the qu=
eue that the driver wants to get stats.
+    \item \field{dev_stats_num}: Indicates the number of dev stats support=
ed by the driver.
+    \item \field{rx_stats_num}: Indicates the number of stats information =
the driver wants for rx queue.
+    \item \field{tx_stats_num}: Indicates the number of stats information =
the driver wants for tx queue.
+\end{itemize}
+
+Regarding the variables in \field{command-specific-data-reply}:
+\begin{itemize}
+    \item All variables of \field{command-specific-data-reply} are set by =
the device.
+    \item \field{queue_pair_index} MUST be equal to the variable with the =
same name in \field{command-specific-data}.
+    \item These variables(\field{dev_stats_num}, \field{rx_stats_num}, \fi=
eld{tx_stats_num}) MUST be
+            less than or equal to the variables with the same name in \fie=
ld{command-specific-data}.
+            These values indicate the amount of stats actually filled in.
+    \item \field{command-specific-data-reply} is meaningful only when \fie=
ld{ack} is equal to VIRTIO_NET_OK.
+\end{itemize}
+
+The variables \field{dev_stats_num}, \field{rx_stats_num}, \field{tx_stats=
_num} in \field{command-specific-data}
+specify which stats the driver wants to get, but in fact the device may su=
pport
+more or fewer stats.
+
+If the actual number of stats supported by the device is equal to or less =
than
+the number that the driver wants to obtain, then the device MUST write all=
 the
+stats to the corresponding position of \field{command-specific-data-reply}=
.
+
+And if the number of stats actually supported by the device is more than t=
he
+driver requires, then the device MUST only write the number supported by t=
he
+driver.
+
+If the some of the variables \field{dev_stats_num}, \field{rx_stats_num}, =
\field{tx_stats_num} in \field{command-specific-data} are 0,
+that means that the driver does not want to obtain this type of stats,
+then the device MUST set the same name field in \field{command-specific-da=
ta-reply} to 0, and skip this type of stats.
+
 \section{Block Device}\label{sec:Device Types / Block Device}

 The virtio block device is a simple virtual block device (ie.
--
2.31.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

