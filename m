Return-Path: <virtio-dev-return-9657-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E6185986569
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Jul 2022 09:41:45 +0000 (UTC)
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Wed, 20 Jul 2022 17:41:40 +0800
Message-Id: <20220720094140.123106-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v5] virtio_net: support split header
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, hengqi@linux.alibaba.com, Kangjie Xu <kangjie.xu@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The purpose of this feature is to split the header and the payload of
the packet.

|                    receive buffer                                    |
|                       0th descriptor             | 1th descriptor    |
| virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->|   payload         |

We can use a buffer plus a separate page when allocating the receive
buffer. In this way, we can ensure that all payloads can be
independently in a page, which is very beneficial for the zerocopy
implemented by the upper layer.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Kangjie Xu <kangjie.xu@linux.alibaba.com>
---
v5:
    1. Determine when hdr_len is credible in the process of rx
    2. Clean up the use of buffers and descriptors
    3. Clarify the meaning of used lenght if the first descriptor is skippe=
d in the case of merge

v4:
    1. fix typo @Cornelia Huck @Jason Wang
    2. do not split header for IP fragmentation packet. @Jason Wang

v3:
    1. Fix some syntax issues
    2. Fix some terminology issues
    3. It is not unified with ip alignment, so ip alignment is not included
    4. Make it clear that the device must support four types, in the case o=
f
    successful negotiation.



 conformance.tex |  2 +
 content.tex     | 97 +++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index 663e7c3..6f561fb 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -149,6 +149,7 @@ \section{Conformance Targets}\label{sec:Conformance / C=
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

 \conformance{\subsection}{Block Driver Conformance}\label{sec:Conformance =
/ Driver Conformance / Block Driver Conformance}
@@ -411,6 +412,7 @@ \section{Conformance Targets}\label{sec:Conformance / C=
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

 \conformance{\subsection}{Block Device Conformance}\label{sec:Conformance =
/ Device Conformance / Block Device Conformance}
diff --git a/content.tex b/content.tex
index 7508dd1..8d97cd5 100644
--- a/content.tex
+++ b/content.tex
@@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / Ne=
twork Device / Feature bits
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.

+\item[VIRTIO_NET_F_SPLIT_HEADER (55)] Device supports splitting the protoc=
ol
+    header and the payload.
+
 \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets. Unlike U=
FO
  (fragmenting the packet) the USO splits large UDP packet
  to several segments when each of these smaller packets has UDP header.
@@ -3131,6 +3134,7 @@ \subsubsection{Feature bit requirements}\label{sec:De=
vice Types / Network Device
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_=
F_HOST_TSO6.
 \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
+\item[VIRTIO_NET_F_SPLIT_HEADER] Requires VIRTIO_NET_F_CTRL_VQ.
 \end{description}

 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Ne=
twork Device / Feature bits / Legacy Interface: Feature bits}
@@ -3362,6 +3366,7 @@ \subsection{Device Operation}\label{sec:Device Types =
/ Network Device / Device O
 #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
 #define VIRTIO_NET_HDR_F_DATA_VALID    2
 #define VIRTIO_NET_HDR_F_RSC_INFO      4
+#define VIRTIO_NET_HDR_F_SPLIT_HEADER  8
         u8 flags;
 #define VIRTIO_NET_HDR_GSO_NONE        0
 #define VIRTIO_NET_HDR_GSO_TCPV4       1
@@ -3786,7 +3791,8 @@ \subsubsection{Processing of Incoming Packets}\label{=
sec:Device Types / Network
 not set VIRTIO_NET_HDR_F_RSC_INFO bit in \field{flags}.

 If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6 or UFO options have
-been negotiated, the device SHOULD set \field{hdr_len} to a value
+been negotiated and the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags}
+is not set, the device SHOULD set \field{hdr_len} to a value
 not less than the length of the headers, including the transport
 header.

@@ -3807,9 +3813,13 @@ \subsubsection{Processing of Incoming Packets}\label=
{sec:Device Types / Network
 driver MUST NOT use the \field{csum_start} and \field{csum_offset}.

 If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6 or UFO options have
-been negotiated, the driver MAY use \field{hdr_len} only as a hint about t=
he
+been negotiated and the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags}
+is not set, the driver MAY use \field{hdr_len} only as a hint about the
 transport header size.
-The driver MUST NOT rely on \field{hdr_len} to be correct.
+
+If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is not set, the =
driver
+MUST NOT rely on \field{hdr_len} to be correct.
+
 \begin{note}
 This is due to various bugs in implementations.
 \end{note}
@@ -4463,6 +4473,87 @@ \subsubsection{Control Virtqueue}\label{sec:Device T=
ypes / Network Device / Devi
 according to the native endian of the guest rather than
 (necessarily when not using the legacy interface) little-endian.

+\paragraph{Split Header}\label{sec:Device Types / Network Device / Device =
Operation / Control Virtqueue / Split Header}
+
+If the VIRTIO_NET_F_SPLIT_HEADER feature is negotiated,
+the device supports splitting the protocol header and the payload.
+The protocol header and the payload will be separated into different
+descriptors.
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
+#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4     (1 << 0)
+#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCP6     (1 << 1)
+#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4     (1 << 2)
+#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDP6     (1 << 3)
+    le64 type;
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
+The driver can enable or disable split header for different protocols by
+setting or clearing corresponding bits in \field{type}.
+
+\begin{itemize}
+    \item VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4: split after ipv4 tcp header
+    \item VIRTIO_NET_SPLIT_HEADER_TYPE_TCP6: split after ipv6 tcp header
+    \item VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4: split after ipv4 udp header
+    \item VIRTIO_NET_SPLIT_HEADER_TYPE_UDP6: split after ipv6 udp header
+\end{itemize}
+
+\devicenormative{\subparagraph}{Setting Split Header}{Device Types / Netwo=
rk Device / Device Operation / Control Virtqueue / Split Header}
+
+A device MUST initialize \field{type} to 0, and MUST set it to 0
+upon device reset.
+
+If VIRTIO_NET_F_SPLIT_HEADER is negotiated, the device MUST support
+VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4, VIRTIO_NET_SPLIT_HEADER_TYPE_TCP6,
+VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4, VIRTIO_NET_SPLIT_HEADER_TYPE_UDP6.
+
+A device MUST NOT split the header encounter any of the following cases:
+\begin{itemize}
+    \item the device does not recognize the protocol of the packet.
+    \item the packet is an IP fragmentation.
+    \item \field{type} does not include the protocol of the packet.
+    \item the buffer consists of only one descriptor.
+    \item the total size of the virtio net header and the protocol header =
exceeds
+        the size of the first descriptor.
+    \item when VIRTIO_NET_F_MRG_RXBUF is not negotiated and the size of th=
e
+        payload exceeds the size of the descriptor chain starting from the=
 2nd
+        descriptor.
+\end{itemize}
+
+If the header is split by the device, the VIRTIO_NET_HDR_F_SPLIT_HEADER bi=
t
+in \field{flags} MUST be set. The protocol header MUST be on the first
+descriptor, following the virtio net header. The payload MUST start from t=
he
+second descriptor. The device MUST set \field{hdr_len} of structure
+virtio_net_hdr to the length of the protocol header.
+
+If the header is split by the device, VIRTIO_NET_F_MRG_RXBUF is negotiated=
,
+and the received packet is spread over multiple buffers, when the device u=
ses a
+buffer other than the first, if the buffer consists of multiple descriptor=
s, the
+device MUST skip the first descriptor, because the first descriptor is use=
d to
+carry the protocol header. The used length still reports the number of byt=
es it
+has written to memory.
+
+\drivernormative{\subparagraph}{Setting Split Header}{Device Types / Netwo=
rk Device / Device Operation / Control Virtqueue / Split Header}
+
+If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is set, the driv=
er
+MUST treat the contents of \field{hdr_len} as the length of the protocol h=
eader
+inside the first descriptor.
+
+If the split header is enabled, the buffers submitted to receiveq by the
+driver SHOULD be composed of at least two descriptors.

 \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 Types / Network Device / Legacy Interface: Framing Requirements}
--
2.31.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

