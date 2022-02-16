Return-Path: <virtio-dev-return-9299-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 61596986449
	for <virtio-dev@lists.oasis-open.org>; Wed, 16 Feb 2022 03:01:09 +0000 (UTC)
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Wed, 16 Feb 2022 11:01:03 +0800
Message-Id: <20220216030103.60893-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] virtio_net: support split header
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The purpose of this feature is to write the payload of the packet to a
specified location in the receive buffer after the device receives the
packet.

|                    receive buffer                             |
|                       offset                     |            |
| virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->|   payload  |

Based on this feature, we can obtain two benefits.

1. We can use a buffer of size "offset" plus a separate page when
   allocating the receive buffer. In this way, we can ensure that all
   payloads can be independently in a page, which is very beneficial for
   the zerocopy implemented by the upper layer.

2. We can include SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) when
   setting the offset, so that in the linux implementation, we can
   construct skb very efficiently based on build_skb(). No need to copy
   the network header.

   For MRG_RX, we require that all payloads are placed in the position
   specified by offset in each receive buffer. So we can also use
   build_skb() without wasting memory. Because we can reuse the
   "offset" parts that are not used.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 conformance.tex |  2 ++
 content.tex     | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/conformance.tex b/conformance.tex
index 42f8537..e5d2ca8 100644
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
n / Control Virtqueue / Split Header}
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
n / Control Virtqueue / Split Header}
 \end{itemize}
=20
 \conformance{\subsection}{Block Device Conformance}\label{sec:Conformance =
/ Device Conformance / Block Device Conformance}
diff --git a/content.tex b/content.tex
index c6f116c..02cde55 100644
--- a/content.tex
+++ b/content.tex
@@ -3092,6 +3092,9 @@ \subsection{Feature bits}\label{sec:Device Types / Ne=
twork Device / Feature bits
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.
=20
+\item[VIRTIO_NET_F_SPLIT_HEADER (55)] Device can separate the header and t=
he
+    payload. The payload will be placed at the specified offset.
+
 \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets. Unlike U=
FO
  (fragmenting the packet) the USO splits large UDP packet
  to several segments when each of these smaller packets has UDP header.
@@ -3139,6 +3142,7 @@ \subsubsection{Feature bit requirements}\label{sec:De=
vice Types / Network Device
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_=
F_HOST_TSO6.
 \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
+\item[VIRTIO_NET_F_SPLIT_HEADER] Requires VIRTIO_NET_F_CTRL_VQ.
 \end{description}
=20
 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Ne=
twork Device / Feature bits / Legacy Interface: Feature bits}
@@ -3370,6 +3374,7 @@ \subsection{Device Operation}\label{sec:Device Types =
/ Network Device / Device O
 #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
 #define VIRTIO_NET_HDR_F_DATA_VALID    2
 #define VIRTIO_NET_HDR_F_RSC_INFO      4
+#define VIRTIO_NET_HDR_F_SPLIT_HEADER  8
         u8 flags;
 #define VIRTIO_NET_HDR_GSO_NONE        0
 #define VIRTIO_NET_HDR_GSO_TCPV4       1
@@ -4471,6 +4476,60 @@ \subsubsection{Control Virtqueue}\label{sec:Device T=
ypes / Network Device / Devi
 according to the native endian of the guest rather than
 (necessarily when not using the legacy interface) little-endian.
=20
+\paragraph{Split Header}\label{sec:Device Types / Network Device / Device =
Operation / Control Virtqueue / Split Header}
+
+If the VIRTIO_NET_F_SPLIT_HEADER feature is negotiated, the device can sep=
arate
+the header and the payload. The payload will be placed at the specified of=
fset.
+
+\subparagraph{Split Header}\label{sec:Device Types / Network Device / Devi=
ce Operation / Control Virtqueue / Split Header / Setting Split Header}
+
+To configure the split header, the following layout structure and definiti=
ons
+are used:
+
+\begin{lstlisting}
+struct virtio_net_split_header_config {
+#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCPv4     1
+#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCPv6     2
+#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDPv4     4
+#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDPv6     8
+    le64 type
+    le64 offset;
+};
+
+#define VIRTIO_NET_CTRL_SPLIT_HEADER       6
+ #define VIRTIO_NET_CTRL_SPLIT_HEADER_SET   0
+\end{lstlisting}
+
+The class VIRTIO_NET_CTRL_SPLIT_HEADER has one command:
+VIRTIO_NET_CTRL_SPLIT_HEADER_SET applies the new split header configuratio=
n.
+
+\field{type} passed as command data is a bitmask, bits set define
+packet types to split header, bits cleared - split header to be disabled.
+
+\field{offset}(from the beginning of the receive buffer) specifies where t=
he
+payload is placed.
+
+\devicenormative{\subparagraph}{Setting Split Header}{Device Types / Netwo=
rk Device / Device Operation / Control Virtqueue / Split Header}
+
+Split header MUST be disabled after device initialization.
+
+If the packet header plus virtnet hdr exceeds \field{offset}, the device d=
oes
+not need to split the header for this packet.
+
+If the size of the payload is greater than the size of the receive buffer =
minus
+\field{offset}, the device does not need to split the header for this pack=
et.
+
+If the packet is successfully split header, then the type of virtnet hdr M=
UST
+contains VIRTIO_NET_HDR_F_SPLIT_HEADER.
+
+If VIRTIO_NET_F_MRG_RXBUF is negotiated and the device is to use multiple
+receive buffers, each subsequent receive buffer MUST skip the beginning of
+offset.
+
+\drivernormative{\subparagraph}{Setting Split Header}{Device Types / Netwo=
rk Device / Device Operation / Control Virtqueue / Split Header}
+
+If VIRTIO_NET_F_SPLIT_HEADER negotiation is successful, the driver MUST be=
 able
+to properly handle packets containing VIRTIO_NET_HDR_F_SPLIT_HEADER.
=20
 \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 Types / Network Device / Legacy Interface: Framing Requirements}
--=20
2.31.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

