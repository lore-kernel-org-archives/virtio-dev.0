Return-Path: <hengqi@linux.alibaba.com>
From: Heng Qi <hengqi@linux.alibaba.com>
Subject: [PATCH v4] virtio_net: support inner header hash
Date: Wed, 21 Dec 2022 18:39:09 +0800
Message-Id: <20221221103909.127529-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

If the tunnel is used to encapsulate the packets, the hash calculated
using the outer header of the receive packets is always fixed for the
same flow packets, i.e. they will be steered to the same receive queue.

We add a tunnel feature bit VIRTIO_NET_F_HASH_TUNNEL and related bitmasks
in \field{hash_types}, which instructs the device to calculate the
hash using the inner headers of tunnel-encapsulated packets. Besides,
values in \field{hash_report_tunnel} are added to report tunnel types.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v3:
	1. Rename VIRTIO_NET_F_HASH_GRE_VXLAN_GENEVE_INNER to VIRTIO_NET_F_HASH_TUNNEL. @Jason Wang
	2. Make things clearer. @Jason Wang @Michael S. Tsirkin
	3. Keep the possibility to use inner hash for automatic receive steering. @Jason Wang
	4. Add the "Tunnel packet" paragraph to avoid repeating the GRE etc. many times. @Michael S. Tsirkin

v2:
	1. Add a feature bit for GRE/VXLAN/GENEVE inner hash. @Jason Wang
	2. Chang \field{hash_tunnel} to \field{hash_report_tunnel}. @Jason Wang, @Michael S. Tsirkin

v1:
	1. Remove the patch for the bitmask fix. @Michael S. Tsirkin
	2. Clarify some paragraphs. @Jason Wang
	3. Add \field{hash_tunnel} and VIRTIO_NET_HASH_REPORT_GRE. @Yuri Benditovich

 content.tex | 198 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 191 insertions(+), 7 deletions(-)

diff --git a/content.tex b/content.tex
index e863709..dac21f1 100644
--- a/content.tex
+++ b/content.tex
@@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.
 
+\item[VIRTIO_NET_F_HASH_TUNNEL(52)] Device supports inner
+    header hash for GRE, VXLAN and GENEVE-encapsulated packets.
+
 \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
 
 \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
@@ -3095,7 +3098,8 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
  to several segments when each of these smaller packets has UDP header.
 
 \item[VIRTIO_NET_F_HASH_REPORT(57)] Device can report per-packet hash
-    value and a type of calculated hash.
+    value, a type of calculated hash and a tunnel packet type if
+    VIRTIO_NET_F_HASH_TUNNEL is negotiated.
 
 \item[VIRTIO_NET_F_GUEST_HDRLEN(59)] Driver can provide the exact \field{hdr_len}
     value. Device benefits from knowing the exact header length.
@@ -3140,6 +3144,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
 \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
 \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
+\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ.
 \end{description}
 
 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
@@ -3386,7 +3391,8 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
         le16 num_buffers;
         le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
         le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
-        le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
+        le8 hash_report_tunnel; (Only if both VIRTIO_NET_F_HASH_REPORT and VIRTIO_NET_F_HASH_TUNNEL are negotiated)
+        le8 padding_reserved;   (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
 };
 \end{lstlisting}
 
@@ -3837,7 +3843,8 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 A device attempts to calculate a per-packet hash in the following cases:
 \begin{itemize}
 \item The feature VIRTIO_NET_F_RSS was negotiated. The device uses the hash to determine the receive virtqueue to place incoming packets.
-\item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device reports the hash value and the hash type with the packet.
+\item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device reports the hash value and the hash type. The tunnel type can only
+be reported when both VIRTIO_NET_F_HASH_REPORT and VIRTIO_NET_F_HASH_TUNNEL are negotiated.
 \end{itemize}
 
 If the feature VIRTIO_NET_F_RSS was negotiated:
@@ -3863,6 +3870,42 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
  \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Hash calculation}.
 \end{itemize}
 
+\subparagraph{Tunnel packet}
+\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Tunnel packet}
+The tunnel packet is encapsulated from the original packet based on the
+tunneling protocol, and it contains an outer header and an inner header.
+The processing of the tunnel packets requires that the device has the
+capability of identifying and parsing the tunnel packets, for example,
+the type of the tunnel packets can be obtained.
+
+If the tunnel-related type is set in \field{hash_types}, then the
+corresponding tunnel packet calculates the hash over the inner header.
+Tunnel hash types are listed in \ref{sec:Device Types / Network Device /
+Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets /
+Supported/enabled hash types}.
+
+Besides, if both VIRTIO_NET_F_REPORT and the tunnel feature (e.g.
+VIRTIO_NET_F_HASH_TUNNEL) are negotiated, \field{hash_report} reports the hash
+types and \field{hash_report_tunnel} reports the corresponging tunnel type.
+
+If the tunnel feature is not negotiated, the device calculates the hash over
+the default outer header. Also, if the feature VIRTIO_NET_F_REPORT is negotiated,
+\field{hash_report} reports the hash types, but \field{hash_report_tunnel} is set
+to VIRTIO_NET_HASH_REPORT_TUNNEL_NONE.
+
+If the tunnel feature VIRTIO_NET_F_HASH_TUNNEL is negotiated, the device
+supports inner hash calculation for GRE, VXLAN and GENEVE tunnel packets,
+and the corresponding tunnel type in \field{hash_types} is
+VIRTIO_NET_HASH_TYPE_{GRE, VXLAN, GENEVE}_INNER. Besides, the value in
+\field{hash_report_tunnel} is VIRTIO_NET_HASH_REPORT_{GRE, VXLAN, GENEVE}.
+
+The relevant tunnel type links are documented below:
+\begin{itemize}
+\item GRE type link: https://datatracker.ietf.org/doc/rfc2784/
+\item VXLAN type link: https://datatracker.ietf.org/doc/rfc7348/
+\item GENEVE type link: https://datatracker.ietf.org/doc/rfc8926/
+\end{itemize}
+
 \subparagraph{Supported/enabled hash types}
 \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}
 Hash types applicable for IPv4 packets:
@@ -3884,6 +3927,22 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 #define VIRTIO_NET_HASH_TYPE_UDP_EX            (1 << 8)
 \end{lstlisting}
 
+If the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated, the tunnel hash
+types below indicates that the hash can be calculated over the inner
+header of the tunnel packet:
+Hash types applicable to inner payloads of GRE-encapsulated packets
+\begin{lstlisting}
+#define VIRTIO_NET_HASH_TYPE_GRE_INNER         (1 << 9)
+\end{lstlisting}
+Hash types applicable to inner payloads of VXLAN-encapsulated packets
+\begin{lstlisting}
+#define VIRTIO_NET_HASH_TYPE_VXLAN_INNER       (1 << 10)
+\end{lstlisting}
+Hash types applicable to inner payloads of GENEVE-encapsulated packets
+\begin{lstlisting}
+#define VIRTIO_NET_HASH_TYPE_GENEVE_INNER      (1 << 11)
+\end{lstlisting}
+
 \subparagraph{IPv4 packets}
 \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv4 packets}
 The device calculates the hash on IPv4 packets according to 'Enabled hash types' bitmask as follows:
@@ -3975,15 +4034,124 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 (see \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv6 packets without extension header}).
 \end{itemize}
 
+\subparagraph{Inner payloads of tunnel-encapsulated packets}
+\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Inner payloads of tunnel-encapsulated packets}
+If the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated and the corresponding
+tunnel hash type is set in \field{hash_types}, the device calculates the
+inner header hash on tunnel packets as below
+(See \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Tunnel packet}):
+
+If inner payloads of the tunnel packets are IPv4 packets according to
+'Enabled hash types' bitmasks as follows:
+\begin{itemize}
+  \item If VIRTIO_NET_HASH_TYPE_TCPv4 is set and the tunnel packet has an inner
+	TCPv4 header, the hash is calculated over the following fields:
+        \begin{itemsize}
+          \item inner Source IP address
+          \item inner Destination IP address
+          \item inner Source TCP port
+          \item inner Destination TCP port
+        \end{itemsize}
+  \item Else if VIRTIO_NET_HASH_TYPE_UDPv4 is set and the tunnel packet has an
+	inner UDPv4 header, the hash is calculated over the following fields:
+        \begin{itemsize}
+          \item inner Source IP address
+          \item inner Destination IP address
+          \item inner Source UDP port
+          \item inner Destination UDP port
+        \end{itemize}
+  \item Else if VIRTIO_NET_HASH_TYPE_IPv4 is set, the hash is calculated over the
+	following fields:
+        \begin{itemsize}
+          \item inner Source IP address
+          \item inner Destination IP address
+        \end{itemsize}
+  \item Else the device does not calculate the hash
+\end{itemize}
+
+If inner payloads of the tunnel packets are IPv6 packets without extension
+headers according to 'Enabled hash types' bitmasks as follows:
+\begin{itemize}
+  \item If VIRTIO_NET_HASH_TYPE_TCPv6 is set and the tunnel packet has an inner
+	TCPv6 header, the hash is calculated over the following fields:
+        \begin{itemsize}
+          \item inner Source IPv6 address
+          \item inner Destination IPv6 address
+          \item inner Source TCP port
+          \item inner Destination TCP port
+        \end{itemsize}
+  \item Else if VIRTIO_NET_HASH_TYPE_UDPv6 is set and the tunnel packet has an
+	inner UDPv6 header, the hash is calculated over the following fields:
+        \begin{itemsize}
+          \item inner Source IPv6 address
+          \item inner Destination IPv6 address
+          \item inner Source UDP port
+          \item inner Destination UDP port
+        \end{itemize}
+  \item Else if VIRTIO_NET_HASH_TYPE_IPv6 is set, the hash is calculated over the
+	following fields:
+        \begin{itemsize}
+          \item inner Source IPv6 address
+          \item inner Destination IPv6 address
+        \end{itemsize}
+  \item Else the device does not calculate the hash
+\end{itemize}
+
+If inner payloads of the tunnel packets are IPv6 packets with extension headers
+according to 'Enabled hash types' bitmasks as follows:
+\begin{itemsize}
+  \item If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the tunnel packet has an inner
+	TCPv6 header, the hash is calculated over the following fields:
+        \begin{itemize}
+          \item Home address from the home address option in the inner IPv6 destination
+              options header. If the inner extension header is not present, use the
+              inner Source IPv6 address.
+          \item IPv6 address that is contained in the Routing-Header-Type-2 from the
+              associated inner extension header. If the inner extension header is not
+              present, use the inner Destination IPv6 address.
+          \item inner Source TCP port
+          \item inner Destination TCP port
+        \end{itemize}
+  \item Else if VIRTIO_NET_HASH_TYPE_UDP_EX is set and the tunnel packet has an inner
+	UDPv6 header, the hash is calculated over the following fields:
+        \begin{itemsize}
+          \item Home address from the home address option in the inner IPv6 destination
+              options header. If the inner extension header is not present, use the
+              inner Source IPv6 address.
+          \item IPv6 address that is contained in the Routing-Header-Type-2 from the
+              associated inner extension header. If the inner extension header is not
+              present, use the inner Destination IPv6 address.
+          \item inner Source UDP port
+          \item inner Destination UDP port
+        \end{itemize}
+  \item Else if VIRTIO_NET_HASH_TYPE_IP_EX is set, the hash is calculated over the
+	following fields:
+        \begin{itemsize}
+          \item Home address from the home address option in the inner IPv6 destination
+              options header. If the inner extension header is not present, use the
+              inner Source IPv6 address.
+          \item IPv6 address that is contained in the Routing-Header-Type-2 from the
+              associated inner extension header. If the inner extension header is not
+              present, use the inner Destination IPv6 address.
+        \end{itemize}
+  \item Else skip inner IPv6 extension headers and calculate the inner header hash as
+	defined for a tunnel packet whose inner payload is an IPv6 packet without
+	extension headers.
+\end{itemsize}
+
 \paragraph{Hash reporting for incoming packets}
 \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash reporting for incoming packets}
 
-If VIRTIO_NET_F_HASH_REPORT was negotiated and
- the device has calculated the hash for the packet, the device fills \field{hash_report} with the report type of calculated hash
-and \field{hash_value} with the value of calculated hash.
+If VIRTIO_NET_F_HASH_REPORT was negotiated and the device has calculated the
+hash for the packet, the device fills \field{hash_report} with the report type
+of calculated hash, and \field{hash_value} with the value of calculated hash.
+Also, if VIRTIO_NET_F_HASH_TUNNEL was negotiated, the device needs to fill
+\field{hash_report_tunnel} with the report type of the tunnel packet, and it
+is set to VIRTIO_NET_HASH_REPORT_TUNNEL_NONE for the unencapsulated packet.
 
 If VIRTIO_NET_F_HASH_REPORT was negotiated but due to any reason the
-hash was not calculated, the device sets \field{hash_report} to VIRTIO_NET_HASH_REPORT_NONE.
+hash was not calculated, the device sets \field{hash_report} to VIRTIO_NET_HASH_REPORT_NONE,
+and sets \field{hash_report_tunnel} to VIRTIO_NET_HASH_REPORT_TUNNEL_NONE.
 
 Possible values that the device can report in \field{hash_report} are defined below.
 They correspond to supported hash types defined in
@@ -4005,6 +4173,22 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
 \end{lstlisting}
 
+If \field{hash_report} differs from VIRTIO_NET_HASH_REPORT_NONE,
+\field{hash_report_tunnel} can report the type of the tunnel-encapsulated
+packet to the driver over the inner header hash calculation.
+Possible values that the device can report in \field{hash_report_tunnel}
+are defined below:
+
+\begin{lstlisting}
+#define VIRTIO_NET_HASH_REPORT_TUNNEL_NONE     0
+#define VIRTIO_NET_HASH_REPORT_GRE             1
+#define VIRTIO_NET_HASH_REPORT_VXLAN           2
+#define VIRTIO_NET_HASH_REPORT_GENEVE          3
+\end{lstlisting}
+
+They correspond to supported hash types defined in
+\ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}.
+
 \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue}
 
 The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is
-- 
2.19.1.6.gb485710b

