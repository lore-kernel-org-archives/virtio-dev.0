Return-Path: <hengqi@linux.alibaba.com>
From: Heng Qi <hengqi@linux.alibaba.com>
Subject: [PATCH v8] virtio-net: support inner header hash
Date: Wed,  8 Feb 2023 17:08:36 +0800
Message-Id: <20230208090836.74355-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

If the tunnel is used to encapsulate the packets, the hash calculated
using the outer header of the receive packets is always fixed for the
same flow packets, i.e. they will be steered to the same receive queue.

We add a feature bit VIRTIO_NET_F_HASH_TUNNEL and related bitmasks
in \field{hash_tunnel_types}, which instructs the device to calculate the
hash using the inner headers of tunnel-encapsulated packets. Besides,
values in \field{hash_report_tunnel_types} are added to report tunnel types.

Note that VIRTIO_NET_F_HASH_TUNNEL only indicates the ability of the inner
header hash, and does not give the device the ability to use the hash value
to select a receiving queue to place the packet.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/151

Reviewed-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v7->v8:
	1. Add supported_hash_tunnel_types. @Jason Wang, @Parav Pandit
	2. Change hash_report_tunnel to hash_report_tunnel_types. @Parav Pandit
	3. Removed re-definition for inner packet hashing. @Parav Pandit
	4. Fix some typos. @Michael S . Tsirkin
	5. Clarify some sentences. @Michael S . Tsirkin

v6->v7:
	1. Modify the wording of some sentences for clarity. @Michael S. Tsirkin
	2. Fix some syntax issues. @Michael S. Tsirkin

v5->v6:
	1. Fix some syntax and capitalization issues. @Michael S. Tsirkin
	2. Use encapsulated/encaptulation uniformly. @Michael S. Tsirkin
	3. Move the links to introduction section. @Michael S. Tsirkin
	4. Clarify some sentences. @Michael S. Tsirkin

v4->v5:
	1. Clarify some paragraphs. @Cornelia Huck
	2. Fix the u8 type. @Cornelia Huck

v3->v4:
	1. Rename VIRTIO_NET_F_HASH_GRE_VXLAN_GENEVE_INNER to VIRTIO_NET_F_HASH_TUNNEL. @Jason Wang
	2. Make things clearer. @Jason Wang @Michael S. Tsirkin
	3. Keep the possibility to use inner hash for automatic receive steering. @Jason Wang
	4. Add the "Tunnel packet" paragraph to avoid repeating the GRE etc. many times. @Michael S. Tsirkin

v2->v3:
	1. Add a feature bit for GRE/VXLAN/GENEVE inner hash. @Jason Wang
	2. Chang \field{hash_tunnel} to \field{hash_report_tunnel}. @Jason Wang, @Michael S. Tsirkin

v1->v2:
	1. Remove the patch for the bitmask fix. @Michael S. Tsirkin
	2. Clarify some paragraphs. @Jason Wang
	3. Add \field{hash_tunnel} and VIRTIO_NET_HASH_REPORT_GRE. @Yuri Benditovich

 content.tex      | 135 ++++++++++++++++++++++++++++++++++++++++++-----
 introduction.tex |  19 +++++++
 2 files changed, 140 insertions(+), 14 deletions(-)

diff --git a/content.tex b/content.tex
index e863709..2598d96 100644
--- a/content.tex
+++ b/content.tex
@@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.
 
+\item[VIRTIO_NET_F_HASH_TUNNEL(52)] Device supports inner header hash
+	for tunnel-encapsulated packets.
+
 \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
 
 \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
@@ -3095,7 +3098,8 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
  to several segments when each of these smaller packets has UDP header.
 
 \item[VIRTIO_NET_F_HASH_REPORT(57)] Device can report per-packet hash
-    value and a type of calculated hash.
+    value, a type of calculated hash, and, if VIRTIO_NET_F_HASH_TUNNEL
+    is negotiated, an encapsulation packet type.
 
 \item[VIRTIO_NET_F_GUEST_HDRLEN(59)] Driver can provide the exact \field{hdr_len}
     value. Device benefits from knowing the exact header length.
@@ -3140,6 +3144,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
 \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
 \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
+\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ.
 \end{description}
 
 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
@@ -3199,20 +3204,27 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
         u8 rss_max_key_size;
         le16 rss_max_indirection_table_length;
         le32 supported_hash_types;
+        le32 supported_tunnel_hash_types;
 };
 \end{lstlisting}
-The following field, \field{rss_max_key_size} only exists if VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT is set.
+The following field, \field{rss_max_key_size} only exists if VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT or VIRTIO_NET_F_HASH_TUNNEL is set.
 It specifies the maximum supported length of RSS key in bytes.
 
 The following field, \field{rss_max_indirection_table_length} only exists if VIRTIO_NET_F_RSS is set.
 It specifies the maximum number of 16-bit entries in RSS indirection table.
 
 The next field, \field{supported_hash_types} only exists if the device supports hash calculation,
-i.e. if VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT is set.
+i.e. if VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT or VIRTIO_NET_F_HASH_TUNNEL is set.
 
 Field \field{supported_hash_types} contains the bitmask of supported hash types.
 See \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types} for details of supported hash types.
 
+The next field, \field{supported_tunnel_hash_types} only exists if the device
+supports inner hash calculation, i.e. if VIRTIO_NET_F_HASH_TUNNEL is set.
+
+Field \field{supported_tunnel_hash_types} contains the bitmask of supported tunnel hash types.
+See \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled tunnel hash types} for details of supported tunnel hash types.
+
 \devicenormative{\subsubsection}{Device configuration layout}{Device Types / Network Device / Device configuration layout}
 
 The device MUST set \field{max_virtqueue_pairs} to between 1 and 0x8000 inclusive,
@@ -3236,7 +3248,7 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
 negotiated.
 
 The device MUST set \field{rss_max_key_size} to at least 40, if it offers
-VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT.
+VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT or VIRTIO_NET_F_HASH_TUNNEL.
 
 The device MUST set \field{rss_max_indirection_table_length} to at least 128, if it offers
 VIRTIO_NET_F_RSS.
@@ -3384,9 +3396,10 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
         le16 csum_start;
         le16 csum_offset;
         le16 num_buffers;
-        le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
-        le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
-        le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
+        le32 hash_value;              (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
+        le16 hash_report;             (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
+        u8 hash_report_tunnel_types;  (Only if VIRTIO_NET_F_HASH_REPORT negotiated, only valid if VIRTIO_NET_F_HASH_TUNNEL negotiated, otherwise reserved)
+        u8 padding_reserved;          (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
 };
 \end{lstlisting}
 
@@ -3838,11 +3851,15 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 \begin{itemize}
 \item The feature VIRTIO_NET_F_RSS was negotiated. The device uses the hash to determine the receive virtqueue to place incoming packets.
 \item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device reports the hash value and the hash type with the packet.
+	If additionally VIRTIO_NET_F_HASH_TUNNEL was negotiated, the device reports the encapsulation type as well.
+\item The feature VIRTIO_NET_F_HASH_TUNNEL was negotiated. The device supports inner hash calculation.
 \end{itemize}
 
 If the feature VIRTIO_NET_F_RSS was negotiated:
 \begin{itemize}
 \item The device uses \field{hash_types} of the virtio_net_rss_config structure as 'Enabled hash types' bitmask.
+	If additionally VIRTIO_NET_F_HASH_TUNNEL was negotiated, the device uses \field{hash_tunnel_types} of the
+	virtio_net_rss_config structure as 'Enabled hash tunnel types' bitmask.
 \item The device uses a key as defined in \field{hash_key_data} and \field{hash_key_length} of the virtio_net_rss_config structure (see
 \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / Setting RSS parameters}).
 \end{itemize}
@@ -3850,11 +3867,13 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 If the feature VIRTIO_NET_F_RSS was not negotiated:
 \begin{itemize}
 \item The device uses \field{hash_types} of the virtio_net_hash_config structure as 'Enabled hash types' bitmask.
+	If additionally VIRTIO_NET_F_HASH_TUNNEL was negotiated, the device uses \field{hash_tunnel_types} of the
+	virtio_net_hash_config structure as 'Enabled hash tunnel types' bitmask.
 \item The device uses a key as defined in \field{hash_key_data} and \field{hash_key_length} of the virtio_net_hash_config structure (see
 \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Hash calculation}).
 \end{itemize}
 
-Note that if the device offers VIRTIO_NET_F_HASH_REPORT, even if it supports only one pair of virtqueues, it MUST support
+Note that if the device offers VIRTIO_NET_F_HASH_REPORT or VIRTIO_NET_F_HASH_TUNNEL, even if it supports only one pair of virtqueues, it MUST support
 at least one of commands of VIRTIO_NET_CTRL_MQ class to configure reported hash parameters:
 \begin{itemize}
 \item If the device offers VIRTIO_NET_F_RSS, it MUST support VIRTIO_NET_CTRL_MQ_RSS_CONFIG command per
@@ -3863,8 +3882,37 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
  \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Hash calculation}.
 \end{itemize}
 
+\subparagraph{Tunnel/Encapsulated packet}
+\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Tunnel/Encapsulated packet}
+A tunnel packet is encapsulated from the original packet based on the tunneling
+protocol (only a single level of encapsulation is currently supported). The
+encapsulated packet contains an outer header and an inner header, and the device
+calculates the hash over either the inner header or the outer header.
+
+When the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated and the corresponding
+encapsulation type is set in \field{hash_tunnel_types}, the hash for a specific
+type of encapsulated packet is calculated over the inner as opposed to outer header.
+Supported encapsulation types are listed in \ref{sec:Device Types / Network Device /
+Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets /
+Supported/enabled hash tunnel types}.
+
+If both VIRTIO_NET_F_HASH_REPORT and VIRTIO_NET_F_HASH_TUNNEL are negotiated,
+and the corresponding encapsulation type is set in \field{hash_tunnel_types},
+the device supports inner hash calculation for the encapsulated packet,
+For example, if the encapsulated packets \hyperref[intro:GRE]{[GRE]},
+\hyperref[intro:VXLAN]{[VXLAN]} and \hyperref[intro:GENEVE]{[GENEVE]} are hashed in inner
+headers, then \field{hash_tunnel_types} should be set to VIRTIO_NET_HASH_TUNNEL_TYPE_{GRE, VXLAN, GENEVE}
+respectively, and \field{hash_report_tunnel_types} should be respectively set to
+VIRTIO_NET_HASH_TUNNEL_REPORT_{GRE, VXLAN, GENEVE}.
+
+If VIRTIO_NET_F_HASH_REPORT is negotiated but VIRTIO_NET_F_HASH_TUNNEL is not
+negotiated, the device calculates the hash over the outer header, and \field{hash_report}
+reports the hash type. \field{hash_report_tunnel_types} is no longer valid.
+
 \subparagraph{Supported/enabled hash types}
 \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}
+This paragraph relies on definitions from \hyperref[intro:IP]{[IP]},
+\hyperref[intro:UDP]{[UDP]} and \hyperref[intro:TCP]{[TCP]}.
 Hash types applicable for IPv4 packets:
 \begin{lstlisting}
 #define VIRTIO_NET_HASH_TYPE_IPv4              (1 << 0)
@@ -3884,6 +3932,24 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 #define VIRTIO_NET_HASH_TYPE_UDP_EX            (1 << 8)
 \end{lstlisting}
 
+\subparagraph{Supported/enabled tunnel hash types}
+\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled tunnel hash types}
+If the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated, the encapsulation
+hash type indicates that the hash is calculated over the inner header of
+the encapsulated packet:
+Hash type applicable for inner payload of the gre-encapsulated packet
+\begin{lstlisting}
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE         (1 << 0)
+\end{lstlisting}
+Hash type applicable for inner payload of the vxlan-encapsulated packet
+\begin{lstlisting}
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 1)
+\end{lstlisting}
+Hash type applicable for inner payload of the geneve-encapsulated packet
+\begin{lstlisting}
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 2)
+\end{lstlisting}
+
 \subparagraph{IPv4 packets}
 \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv4 packets}
 The device calculates the hash on IPv4 packets according to 'Enabled hash types' bitmask as follows:
@@ -3975,15 +4041,26 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 (see \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv6 packets without extension header}).
 \end{itemize}
 
+\subparagraph{Inner hash calculation of an encapsulated packet}
+If the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated and the corresponding
+encapsulation hash type is set in \field{hash_tunnel_types}, the device calculates the
+hash on the inner header of an encapsulated packet (See \ref{sec:Device Types
+/ Network Device / Device Operation / Processing of Incoming Packets /
+Hash calculation for incoming packets / Tunnel/Encapsulated packet}), and
+\field{hash_report_tunnel_types} contains the valid outer tunnel type.
+
 \paragraph{Hash reporting for incoming packets}
 \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash reporting for incoming packets}
-
-If VIRTIO_NET_F_HASH_REPORT was negotiated and
- the device has calculated the hash for the packet, the device fills \field{hash_report} with the report type of calculated hash
-and \field{hash_value} with the value of calculated hash.
+If VIRTIO_NET_F_HASH_REPORT was negotiated and the device has calculated the
+hash for the packet, the device fills \field{hash_report} with the report type
+of calculated hash, and \field{hash_value} with the value of calculated hash.
+Also, if VIRTIO_NET_F_HASH_TUNNEL was negotiated, the device needs to fill
+\field{hash_report_tunnel_types} with the report type of the encapsulated packet,
+and it is set to VIRTIO_NET_HASH_TUNNEL_REPORT_NONE for the unencapsulated packet.
 
 If VIRTIO_NET_F_HASH_REPORT was negotiated but due to any reason the
-hash was not calculated, the device sets \field{hash_report} to VIRTIO_NET_HASH_REPORT_NONE.
+hash was not calculated, the device sets \field{hash_report} to VIRTIO_NET_HASH_REPORT_NONE,
+and sets \field{hash_report_tunnel_types} to VIRTIO_NET_HASH_TUNNEL_REPORT_NONE.
 
 Possible values that the device can report in \field{hash_report} are defined below.
 They correspond to supported hash types defined in
@@ -4005,6 +4082,26 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
 \end{lstlisting}
 
+\field{hash_report_tunnel} can report the type of the encapsulated
+packet to the driver when the inner header hash is calculated.
+Possible values that the device can report in \field{hash_report_tunnel_types}
+are defined below.
+They correspond to supported hash tunnel types defined in
+\ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash tunnel types}
+as follows:
+
+VIRTIO_NET_HASH_TUNNEL_TYPE_XXX = 1 << (VIRTIO_NET_HASH_TUNNEL_REPORT_XXX -1)
+
+\begin{lstlisting}
+#define VIRTIO_NET_HASH_TUNNEL_REPORT_NONE     0
+#define VIRTIO_NET_HASH_TUNNEL_REPORT_GRE      1
+#define VIRTIO_NET_HASH_TUNNEL_REPORT_VXLAN    2
+#define VIRTIO_NET_HASH_TUNNEL_REPORT_GENEVE   3
+\end{lstlisting}
+
+They correspond to supported hash types defined in
+\ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}.
+
 \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue}
 
 The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is
@@ -4364,6 +4461,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 \begin{lstlisting}
 struct virtio_net_hash_config {
     le32 hash_types;
+    le32 hash_tunnel_types;
     le16 reserved[4];
     u8 hash_key_length;
     u8 hash_key_data[hash_key_length];
@@ -4372,7 +4470,12 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 Field \field{hash_types} contains a bitmask of allowed hash types as
 defined in
 \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}.
-Initially the device has all hash types disabled and reports only VIRTIO_NET_HASH_REPORT_NONE.
+
+Field \field{hash_tunnel_types} contains a bitmask of allowed hash tunnel types as
+defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash tunnel types}.
+
+Initially the device has all hash types and hash tunnel types disabled and reports only
+VIRTIO_NET_HASH_REPORT_NONE and VIRTIO_NET_HASH_TUNNEL_REPORT_NONE respectively.
 
 Field \field{reserved} MUST contain zeroes. It is defined to make the structure to match the layout of virtio_net_rss_config structure,
 defined in \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS)}.
@@ -4390,6 +4493,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 \begin{lstlisting}
 struct virtio_net_rss_config {
     le32 hash_types;
+    le32 hash_tunnel_types;
     le16 indirection_table_mask;
     le16 unclassified_queue;
     le16 indirection_table[indirection_table_length];
@@ -4402,6 +4506,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 defined in
 \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}.
 
+Field \field{hash_tunnel_types} contains a bitmask of allowed hash tunnel types as
+defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash tunnel types}.
+
 Field \field{indirection_table_mask} is a mask to be applied to
 the calculated hash to produce an index in the
 \field{indirection_table} array.
diff --git a/introduction.tex b/introduction.tex
index 287c5fc..ff01a9b 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -98,6 +98,25 @@ \section{Normative References}\label{sec:Normative References}
 	\phantomsection\label{intro:SEC1}\textbf{[SEC1]} &
     Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic Cureve Cryptography'', Version 1.0, September 2000.
 	\newline\url{https://www.secg.org/sec1-v2.pdf}\\
+	\phantomsection\label{intro:GRE}\textbf{[GRE]} &
+	Generic Routing Encapsulation
+	\newline\url{https://datatracker.ietf.org/doc/rfc2784/}\\
+	\phantomsection\label{intro:VXLAN}\textbf{[VXLAN]} &
+	Virtual eXtensible Local Area Network
+	\newline\url{https://datatracker.ietf.org/doc/rfc7348/}\\
+	\phantomsection\label{intro:GENEVE}\textbf{[GENEVE]} &
+	Generic Network Virtualization Encapsulation
+	\newline\url{https://datatracker.ietf.org/doc/rfc8926/}\\
+	\phantomsection\label{intro:IP}\textbf{[IP]} &
+	INTERNET PROTOCOL
+	\newline\url{https://www.rfc-editor.org/rfc/rfc791}\\
+	\phantomsection\label{intro:UDP}\textbf{[UDP]} &
+	User Datagram Protocol
+	\newline\url{https://www.rfc-editor.org/rfc/rfc768}\\
+	\phantomsection\label{intro:TCP}\textbf{[TCP]} &
+	TRANSMISSION CONTROL PROTOCOL
+	\newline\url{https://www.rfc-editor.org/rfc/rfc793}\\
+
 
 \end{longtable}
 
-- 
2.19.1.6.gb485710b

