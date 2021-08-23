Return-Path: <virtio-dev-return-8588-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6CB40986072
	for <virtio-dev@lists.oasis-open.org>; Mon, 23 Aug 2021 08:27:39 +0000 (UTC)
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Mon, 23 Aug 2021 16:27:33 +0800
Message-Id: <20210823082733.128899-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2] virtio-net: support device stats
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch allows the driver to obtain some statistics from the device.

In the back-end implementation, we can count a lot of such information,
which can be used for debugging and judging the running status of the
back-end. We hope to directly display it to the user through ethtool.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v2: All keys define by this patch. Not defined by each backend.

 content.tex | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/content.tex b/content.tex
index 70a9765..b9fd10a 100644
--- a/content.tex
+++ b/content.tex
@@ -2978,6 +2978,9 @@ \subsection{Feature bits}\label{sec:Device Types / Ne=
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
@@ -3023,6 +3026,7 @@ \subsubsection{Feature bit requirements}\label{sec:De=
vice Types / Network Device
 \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
+\item[VIRTIO_NET_F_CTRL_STATS] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_=
F_HOST_TSO6.
 \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
 \end{description}
@@ -3901,6 +3905,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Ty=
pes / Network Device / Devi
         u8 command;
         u8 command-specific-data[];
         u8 ack;
+        u8 command-specific-data-reply[];
 };

 /* ack values */
@@ -3912,6 +3917,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Ty=
pes / Network Device / Devi
 driver, and the device sets the \field{ack} byte. There is little it can
 do except issue a diagnostic if \field{ack} is not
 VIRTIO_NET_OK.
+\field{command-specific-data-reply} is alloced by driver, then pass to dev=
ice.
+It is filled by the device. It is optional. These commands need to get som=
e
+information from the device.

 \paragraph{Packet Receive Filtering}\label{sec:Device Types / Network Devi=
ce / Device Operation / Control Virtqueue / Packet Receive Filtering}
 \label{sec:Device Types / Network Device / Device Operation / Control Virt=
queue / Setting Promiscuous Mode}%old label for latexdiff
@@ -4390,6 +4398,115 @@ \subsubsection{Legacy Interface: Framing Requiremen=
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
+            \item dev_freeze: The number of device freezes.
+            \item dev_restore: The number of device restore.
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
+            \item rx[N]_lro_packets: The number of lro packets received by=
 rx.
+            \item rx[N]_lro_bytes: The number of lro bytes received by rx.
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
+            \item tx[N]_tso_packets: The number of TSO packets transmitted=
.
+            \item tx[N]_tso_bytes: The number of TSO bytes transmitted.
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
+le64 version;
+le64 dev_stats_num;
+le64 rx_num;
+le64 tx_num;
+le64 rx_stats_num;
+le64 tx_stats_num;
+\end{lstlisting}
+
+\field{command-specific-data-reply}
+\begin{lstlisting}
+le64 dev_stats_num;
+le64 rx_num;
+le64 tx_num;
+le64 rx_stats_num;
+le64 tx_stats_num;
+le64 dev_stats[dev_stats_num];
+le64 rx_stats[rx_stats_num][rx_num];
+le64 tx_stats[tx_stats_num][tx_num];
+\end{lstlisting}
+
+The command VIRTIO_NET_CTRL_STATS_GET is used to obtain this information.
+
+Regarding the variables in \field{command-specific-data}:
+\begin{itemize}
+    \item \field{version}: This is used to specify the version of the layo=
ut used. The current value MUST been 0.
+    \item \field{dev_stats_num}: Indicates the number of dev stats support=
ed by the driver.
+    \item \field{rx_num}: Indicates how many rx queue information the driv=
er wants to receive.
+    \item \field{tx_num}: Indicates how many tx queue information the driv=
er wants to receive.
+    \item \field{rx_stats_num}: Indicates the number of stats information =
the driver wants for each rx queue.
+    \item \field{tx_stats_num}: Indicates the number of stats information =
the driver wants for each tx queue.
+\end{itemize}
+
+When the driver allocates \field{command-specific-data-reply}, it should s=
et the
+size of \field{command-specific-data-reply} based on the above values.
+
+\begin{lstlisting}
+size =3D 5 * 8 + 8 * dev_stats_num + 8 * rx_num * rx_stats_num + 8 * tx_nu=
m * tx_stats_num;
+\end{lstlisting}
+
+Regarding the variables in \field{command-specific-data-reply},
+these variables(\field{dev_stats_num}, \field{rx_num}, \field{tx_num},
+\field{rx_stats_num}, \field{tx_stats_num}) are set by the device and MUST=
 be
+less than or equal to the variables with the same name in
+\field{command-specific-data}.  These values indicate the amount actually =
filled
+in. And the number of these implementations in
+\field{command-specific-data-reply} is used as the size of the array dev_s=
tats
+and rx_stats and tx_stats.
+
+\field{command-specific-data-reply} is meaningful only when \field{ack} is=
 equal to VIRTIO_NET_OK.
+
+\subparagraph{Legacy Interface: Device stats}\label{sec:Device Types / Net=
work Device / Device Operation / Control Virtqueue / Device stats / Legacy =
Interface: Device stats}
+When using the legacy interface, transitional devices and drivers
+MUST format the all variables according to the native endian of the guest =
rather
+than (necessarily when not using the legacy interface) little-endian.
+
 \section{Block Device}\label{sec:Device Types / Block Device}

 The virtio block device is a simple virtual block device (ie.
--
2.31.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

