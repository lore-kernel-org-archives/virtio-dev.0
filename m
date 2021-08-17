Return-Path: <virtio-dev-return-8534-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4039B9863B9
	for <virtio-dev@lists.oasis-open.org>; Tue, 17 Aug 2021 03:37:18 +0000 (UTC)
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Tue, 17 Aug 2021 11:37:13 +0800
Message-Id: <20210817033713.40001-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] virtio-net: support device stats
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch allows the driver to obtain some statistics from the device,
such as:

1. queue_N_rx_drops: Rx packets not passed to the driver.
2. queue_N_tx_drops: The tx packet that the device did not send out
3. queue_N_tx_inter: The number of interrupts initiated by device for tx
4. queue_N_rx_inter: The number of interrupts initiated by device for rx
5. queue_N_rx_bad_csum: The number of the csum abnormal packages
......

In the back-end implementation, we can count a lot of such information,
which can be used for debugging and judging the running status of the
back-end. We hope to directly display it to the user through ethtool.

There is no fixed keys, all keys are defined by the backend itself.
Finally it can be directly displayed to the user.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 content.tex | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/content.tex b/content.tex
index 70a9765..bcadded 100644
--- a/content.tex
+++ b/content.tex
@@ -2978,6 +2978,9 @@ \subsection{Feature bits}\label{sec:Device Types / Ne=
twork Device / Feature bits
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.
=20
+\item[VIRTIO_NET_F_CTRL_STATS (55)] Device can provide device-level statis=
tics
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
=20
 /* ack values */
@@ -3912,6 +3917,10 @@ \subsubsection{Control Virtqueue}\label{sec:Device T=
ypes / Network Device / Devi
 driver, and the device sets the \field{ack} byte. There is little it can
 do except issue a diagnostic if \field{ack} is not
 VIRTIO_NET_OK.
+\field{command-specific-data-reply} is alloced by driver, then pass
+ to device.  It is filled by the device.  It is optional.
+ These commands need to get some information from the device.
+
=20
 \paragraph{Packet Receive Filtering}\label{sec:Device Types / Network Devi=
ce / Device Operation / Control Virtqueue / Packet Receive Filtering}
 \label{sec:Device Types / Network Device / Device Operation / Control Virt=
queue / Setting Promiscuous Mode}%old label for latexdiff
@@ -4390,6 +4399,96 @@ \subsubsection{Legacy Interface: Framing Requirement=
s}\label{sec:Device
 See \ref{sec:Basic
 Facilities of a Virtio Device / Virtqueues / Message Framing}.
=20
+\paragraph{Device stats}\label{sec:Device Types / Network Device / Device =
Operation / Control Virtqueue / Device stats}
+
+If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the driver can
+send control commands to get device stats.
+
+To get the stats, the following definitions are used:
+\begin{lstlisting}
+#define VIRTIO_NET_CTRL_STATS        6
+#define VIRTIO_NET_CTRL_STATS_NUM    0 // get device stats num
+#define VIRTIO_NET_CTRL_STATS_KEYS   1 // get device stats keys
+#define VIRTIO_NET_CTRL_STATS_VALUES 2 // get device stats values
+
+#define VIRTIO_NET_STATS_KEY_LEN 32
+\end{lstlisting}
+
+The class is VIRTIO_NET_CTRL_STATS.
+
+\subparagraph{Device stats num}\label{sec:device types / network device / =
device operation / control virtqueue / Device stats / Device stats num}
+
+Get the number of stats supported by the device from the device. After the
+device is initialized, this value MUST remain unchanged.
+
+The following layout structure are used as \field{command-specific-data-re=
ply}:
+
+\begin{lstlisting}
+le64 num;
+\end{lstlisting}
+
+The command VIRTIO_NET_CTRL_STATS_NUM is used to obtain this information. =
The
+device fills \field{num} as reply. \field{num} is meaningful only when
+\field{ack} is equal to VIRTIO_NET_OK.
+
+\subparagraph{Device stats keys}\label{sec:Device Types / Network Device /=
 Device Operation / Control Virtqueue / Device stats keys / Device stats ke=
ys}
+
+Get the keys of stats supported by the device from the device. After the
+device is initialized, these keys and their order MUST not change.
+
+The maximum length of each key is VIRTIO_NET_STATS_KEY_LEN - 1, the size o=
f
+the key buf allocated by the driver is VIRTIO_NET_STATS_KEY_LEN. Each key =
filled
+by the device ends with NULL.
+
+The following layout structure are used:
+
+\field{command-specific-data}
+\begin{lstlisting}
+le64 alloc_num;
+\end{lstlisting}
+
+\field{command-specific-data-reply}
+\begin{lstlisting}
+le64 real_num;
+u8 keys[VIRTIO_NET_STATS_KEY_LEN][alloc_num]
+\end{lstlisting}
+
+The command VIRTIO_NET_CTRL_STATS_KEYS is used to obtain the stats keys. T=
he
+driver setting \field{alloc_num} specifies the number of keys allocated in=
 the
+reply. The device fills \field{real_num} as the number of keys actually fi=
lled.
+
+When \field{ack} is equal to VIRTIO_NET_OK, reply is meaningful.
+
+\subparagraph{Device stats values}\label{sec:Device Types / Network Device=
 / Device Operation / Control Virtqueue / Device stats / Device stats value=
s}
+
+Get the values of stats supported by the device from the device. After the
+device is initialized, these values and their order MUST not change.
+
+The following layout structure are used:
+
+\field{command-specific-data}
+\begin{lstlisting}
+le64 alloc_num;
+\end{lstlisting}
+
+\field{command-specific-data-reply}
+\begin{lstlisting}
+le64 real_num;
+le64 values[alloc_num]
+\end{lstlisting}
+
+The command VIRTIO_NET_CTRL_STATS_VALUES is used to obtain this informatio=
n. The
+driver setting \field{alloc_num} specifies the number of values allocated =
in the
+reply. The device fills real_num as the number of values actually filled.
+
+When \field{ack} is equal to VIRTIO_NET_OK, reply is meaningful.
+
+\subparagraph{Legacy Interface: Device stats}\label{sec:Device Types / Net=
work Device / Device Operation / Control Virtqueue / Device stats / Legacy =
Interface: Device stats}
+When using the legacy interface, transitional devices and drivers
+MUST format the \field{num}, \field{alloc_num},\field{real_num},\field{val=
ues}
+according to the native endian of the guest rather than
+(necessarily when not using the legacy interface) little-endian.
+
 \section{Block Device}\label{sec:Device Types / Block Device}
=20
 The virtio block device is a simple virtual block device (ie.
--=20
2.31.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

