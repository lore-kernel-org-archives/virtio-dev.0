Return-Path: <virtio-dev-return-12774-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640C5C7EE23
	for <virtio-dev@archiver.kernel.org>; Mon, 22 May 2023 05:02:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C6BCF2B057
	for <virtio-dev@archiver.kernel.org>; Mon, 22 May 2023 05:02:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B6766986384
	for <virtio-dev@archiver.kernel.org>; Mon, 22 May 2023 05:02:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AB8279862FF; Mon, 22 May 2023 05:02:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 94D579862FE;
	Mon, 22 May 2023 05:02:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vj7P-yr_1684731756;
From: Heng Qi <hengqi@linux.alibaba.com>
To: virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Parav Pandit <parav@nvidia.com>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Mon, 22 May 2023 13:02:36 +0800
Message-Id: <20230522050236.49433-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v14] virtio-net: support inner header hash

1. Currently, a received encapsulated packet has an outer and an inner header, but
the virtio device is unable to calculate the hash for the inner header. The same
flow can traverse through different tunnels, resulting in the encapsulated
packets being spread across multiple receive queues (refer to the figure below).
However, in certain scenarios, we may need to direct these encapsulated packets of
the same flow to a single receive queue. This facilitates the processing
of the flow by the same CPU to improve performance (warm caches, less locking, etc.).

               client1                    client2
                  |        +-------+         |
                  +------->|tunnels|<--------+
                           +-------+
                              |  |
                              v  v
                      +-----------------+
                      | monitoring host |
                      +-----------------+

To achieve this, the device can calculate a symmetric hash based on the inner headers
of the same flow.

2. For legacy systems, they may lack entropy fields which modern protocols have in
the outer header, resulting in multiple flows with the same outer header but
different inner headers being directed to the same receive queue. This results in
poor receive performance.

To address this limitation, inner header hash can be used to enable the device to advertise
the capability to calculate the hash for the inner packet, regaining better receive performance.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v13->v14:
	1. Move supported_hash_tunnel_types from config space into cvq command. @Parav Pandit
	2. Rebase to master branch.
	3. Some minor modifications.
	
v12->v13:
	1. Add a GET command for hash_tunnel_types. @Parav Pandit
	2. Add tunneling protocol explanation. @Jason Wang
	3. Add comments on some usage scenarios for inner hash.

v11->v12:
	1. Add a command VIRTIO_NET_CTRL_MQ_TUNNEL_CONFIG.
	2. Refine the commit log. @Michael S . Tsirkin
	3. Add some tunnel types.

v10->v11:
	1. Revise commit log for clarity for readers.
	2. Some modifications to avoid undefined terms. @Parav Pandit
	3. Change VIRTIO_NET_F_HASH_TUNNEL dependency. @Parav Pandit
	4. Add the normative statements. @Parav Pandit

v9->v10:
	1. Removed hash_report_tunnel related information. @Parav Pandit
	2. Re-describe the limitations of QoS for tunneling.
	3. Some clarification.

v8->v9:
	1. Merge hash_report_tunnel_types into hash_report. @Parav Pandit
	2. Add tunnel security section. @Michael S . Tsirkin
	3. Add VIRTIO_NET_F_HASH_REPORT_TUNNEL.
	4. Fix some typos.
	5. Add more tunnel types. @Michael S . Tsirkin

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

 device-types/net/description.tex        | 159 ++++++++++++++++++++++++
 device-types/net/device-conformance.tex |   1 +
 device-types/net/driver-conformance.tex |   1 +
 introduction.tex                        |  44 +++++++
 4 files changed, 205 insertions(+)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index 3030222..0d2684c 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -88,6 +88,8 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.
 
+\item[VIRTIO_NET_F_HASH_TUNNEL(51)] Device supports inner header hash for tunnel-encapsulated packets.
+
 \item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue notification coalescing.
 
 \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
@@ -147,6 +149,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
 \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
 \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
+\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ along with VIRTIO_NET_F_RSS and/or VIRTIO_NET_F_HASH_REPORT.
 \end{description}
 
 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
@@ -869,6 +872,7 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 If the feature VIRTIO_NET_F_RSS was negotiated:
 \begin{itemize}
 \item The device uses \field{hash_types} of the virtio_net_rss_config structure as 'Enabled hash types' bitmask.
+\item The device uses \field{hash_tunnel_types} of the virtnet_hash_tunnel_config_get structure as 'Enabled encapsulation hash types' bitmask if VIRTIO_NET_F_HASH_TUNNEL was negotiated.
 \item The device uses a key as defined in \field{hash_key_data} and \field{hash_key_length} of the virtio_net_rss_config structure (see
 \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / Setting RSS parameters}).
 \end{itemize}
@@ -876,6 +880,7 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 If the feature VIRTIO_NET_F_RSS was not negotiated:
 \begin{itemize}
 \item The device uses \field{hash_types} of the virtio_net_hash_config structure as 'Enabled hash types' bitmask.
+\item The device uses \field{hash_tunnel_types} of the virtnet_hash_tunnel_config_get structure as 'Enabled encapsulation hash types' bitmask if VIRTIO_NET_F_HASH_TUNNEL was negotiated.
 \item The device uses a key as defined in \field{hash_key_data} and \field{hash_key_length} of the virtio_net_hash_config structure (see
 \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Hash calculation}).
 \end{itemize}
@@ -891,6 +896,7 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 
 \subparagraph{Supported/enabled hash types}
 \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}
+This paragraph relies on definitions from \hyperref[intro:IP]{[IP]}, \hyperref[intro:UDP]{[UDP]} and \hyperref[intro:TCP]{[TCP]}.
 Hash types applicable for IPv4 packets:
 \begin{lstlisting}
 #define VIRTIO_NET_HASH_TYPE_IPv4              (1 << 0)
@@ -1001,6 +1007,159 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 (see \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv6 packets without extension header}).
 \end{itemize}
 
+\paragraph{Inner Header Hash}
+\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Inner Header Hash}
+
+If VIRTIO_NET_F_HASH_TUNNEL has been negotiated, the driver can send commands VIRTIO_NET_CTRL_TUNNEL_HASH_SET
+and VIRTIO_NET_CTRL_TUNNEL_HASH_GET for the inner header hash configuration.
+
+struct virtnet_hash_tunnel_config_set {
+    le32 hash_tunnel_types;
+};
+struct virtnet_hash_tunnel_config_get {
+    le32 supported_hash_tunnel_types;
+    le32 hash_tunnel_types;
+};
+
+#define VIRTIO_NET_CTRL_TUNNEL_HASH 7
+ #define VIRTIO_NET_CTRL_TUNNEL_HASH_SET 0
+ #define VIRTIO_NET_CTRL_TUNNEL_HASH_GET 1
+
+Filed \field{supported_hash_tunnel_types} provided by the device indicates that the device is capable of supporting inner header hash for these encapsulation types.
+\field{supported_hash_tunnel_types} contains the bitmask of supported tunnel hash types. See \ref{sec:Device Types / Network Device / Device Operation / Processing
+of Incoming Packets / Hash calculation for incoming packets / Supported/enabled encapsulation hash types}.
+
+Filed \field{hash_tunnel_types} contains the bitmask of configured hash tunnel types.
+See \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled encapsulation hash types}.
+
+The class VIRTIO_NET_CTRL_TUNNEL_HASH has the following commands:
+\begin{itemize}
+\item VIRTIO_NET_CTRL_TUNNEL_HASH_SET: use the virtnet_hash_tunnel_config_set structure to set \field{hash_tunnel_types} for inner header hash configuration.
+\item VIRTIO_NET_CTRL_TUNNEL_HASH_GET: use the virtnet_hash_tunnel_config_get structure to get \field{hash_tunnel_types} and \field{supported_hash_tunnel_types} from the device.
+\end{itemize}
+
+For the VIRTIO_NET_CTRL_TUNNEL_HASH_SET command, the virtnet_hash_tunnel_config_set structure is write-only for the driver.
+For the VIRTIO_NET_CTRL_TUNNEL_HASH_GET command, the virtnet_hash_tunnel_config_get structure is read-only for the driver.
+
+\subparagraph{Tunnel/Encapsulated packet}
+\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Tunnel/Encapsulated packet}
+
+A tunnel packet is encapsulated from the original packet based on the tunneling protocol (only a single level of
+encapsulation is currently supported). The encapsulated packet contains an outer header and an inner header, and
+the device calculates the hash over either the inner header or the outer header.
+
+If VIRTIO_NET_F_HASH_TUNNEL is negotiated and a received encapsulated packet's outer header matches one of the
+configured \field{hash_tunnel_types}, the hash of the inner header is calculated.
+
+Supported encapsulated packet types:
+\begin{itemize}
+\item \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]}: the outer header is over IPv4 and the inner header is over IPv4. The outer header does not contain the transport protocol.
+\item \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]}: the outer header is over IPv4 and the inner header is over IPv4. The outer header does not contain the transport protocol.
+\item \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]}: the outer header is over IPv4/IPv6 and the inner header is over IPv4/IPv6. The outer header does not contain the transport protocol.
+\item \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]}: the outer header is over IPv4/IPv6 and the inner header is over IPv4/IPv6. The outer header uses UDP as the transport protocol.
+\item \hyperref[intro:vxlan]{[VXLAN]}: the outer header is over IPv4/IPv6 and the inner header is over IPv4/IPv6. The outer header uses UDP as the transport protocol.
+\item \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]}: the outer header is over IPv4/IPv6 and the inner header is over IPv4/IPv6. The outer header uses UDP as the transport protocol.
+\item \hyperref[intro:geneve]{[GENEVE]}: the outer header is over IPv4/IPv6 and the inner header is over IPv4/IPv6. The outer header uses UDP as the transport protocol.
+\item \hyperref[intro:ipip]{[IPIP]}: the outer header is over IPv4 and the inner header is over IPv4. The outer header does not contain the transport protocol.
+\item \hyperref[intro:nvgre]{[NVGRE]}: the outer header is over IPv4/IPv6 and the inner header is over IPv4/IPv6. The outer header does not contain the transport protocol.
+\item \hyperref[intro:sit]{[STT]}: the outer header is over IPv4/IPv6 and the inner header is over IPv4/IPv6. The outer header uses TCP-like as the transport protocol.
+\end{itemize}
+
+If VIRTIO_NET_HASH_TUNNEL_TYPE_NONE is set or the encapsulation type is not included in configured \field{hash_tunnel_types},
+the hash of the outer header is calculated for the received encapsulated packet.
+
+The hash is calculated for the received non-encapsulated packet as if VIRTIO_NET_F_HASH_TUNNEL was not negotiated.
+
+\subparagraph{Supported/enabled encapsulation hash types}
+\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled encapsulation hash types}
+
+\begin{lstlisting}
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_NONE        (1 << 0)
+\end{lstlisting}
+
+Supported encapsulation hash types:
+Hash type applicable for inner payload of the \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]} packet:
+\begin{lstlisting}
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2784    (1 << 1)
+\end{lstlisting}
+Hash type applicable for inner payload of the \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]} packet:
+\begin{lstlisting}
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2890    (1 << 2)
+\end{lstlisting}
+Hash type applicable for inner payload of the \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]} packet:
+\begin{lstlisting}
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_7676    (1 << 3)
+\end{lstlisting}
+Hash type applicable for inner payload of the \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]} packet:
+\begin{lstlisting}
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_UDP     (1 << 4)
+\end{lstlisting}
+Hash type applicable for inner payload of the \hyperref[intro:vxlan]{[VXLAN]} packet:
+\begin{lstlisting}
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 5)
+\end{lstlisting}
+Hash type applicable for inner payload of the \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]} packet:
+\begin{lstlisting}
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN_GPE   (1 << 6)
+\end{lstlisting}
+Hash type applicable for inner payload of the \hyperref[intro:geneve]{[GENEVE]} packet:
+\begin{lstlisting}
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 7)
+\end{lstlisting}
+Hash type applicable for inner payload of the \hyperref[intro:ipip]{[IPIP]} packet:
+\begin{lstlisting}
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 8)
+\end{lstlisting}
+Hash type applicable for inner payload of the \hyperref[intro:nvgre]{[NVGRE]} packet:
+\begin{lstlisting}
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 9)
+\end{lstlisting}
+Hash type applicable for inner payload of the \hyperref[intro:stt]{[STT]} packet:
+\begin{lstlisting}
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_STT         (1 << 10)
+\end{lstlisting}
+
+\subparagraph{Advice}
+Usage scenarios of inner header hash (but not limited to):
+\begin{itemize}
+\item Legacy tunneling protocols that lack entropy in the outer header use inner header hash to hash flows
+      with the same outer header but different inner headers to different queues for better-receiving performance.
+\item In scenarios where the same flow passing through different tunnels is expected to be received in the same queue,
+      warm caches, lessing locking, etc. are optimized to obtain receiving performance.
+\end{itemize}
+
+For scenarios with sufficient outer entropy or no inner header hash requirements, inner header hash may not be needed:
+A tunnel is often expected to isolate the external network from the internal one. By completely ignoring entropy
+in the outer header and replacing it with entropy from the inner header, for hash calculations, this expectation
+might be violated to a certain extent, depending on how the hash is used. When the hash use is limited to RSS queue
+selection, inner header hash may have quality of service (QoS) limitations.
+
+Possible mitigations:
+\begin{itemize}
+\item Use a tool with good forwarding performance to keep the receive queue from filling up.
+\item If the QoS is unavailable, the driver can set \field{hash_tunnel_types} to VIRTIO_NET_HASH_TUNNEL_TYPE_NONE
+      to disable inner header hash for encapsulated packets.
+\item Perform appropriate QoS before packets consume the receive buffers of the receive queues.
+\end{itemize}
+
+\devicenormative{\subparagraph}{Inner Header Hash}{Device Types / Network Device / Device Operation / Control Virtqueue / Inner Header Hash}
+
+The device MUST calculate the hash on the outer header if the type of the received encapsulated packet does not match any value of \field{hash_tunnel_types}.
+
+The device MUST respond to the VIRTIO_NET_CTRL_TUNNEL_HASH_SET command with VIRTIO_NET_ERR if the device received an unrecognized or an unsupported VIRTIO_NET_HASH_TUNNEL_TYPE_ flag.
+
+The device MUST provide the value of \field{supported_tunnel_hash_types} if it offers the VIRTIO_NET_F_HASH_TUNNEL feature.
+
+Upon reset, the device MUST initialize \field{hash_tunnel_type} to 0.
+
+\drivernormative{\subparagraph}{Inner Header Hash}{Device Types / Network Device / Device Operation / Control Virtqueue / Inner Header Hash}
+
+The driver MUST have negotiated the VIRTIO_NET_F_HASH_TUNNEL feature when issuing commands VIRTIO_NET_CTRL_TUNNEL_HASH_SET and VIRTIO_NET_CTRL_TUNNEL_HASH_GET.
+
+The driver MUST ignore the values received from the VIRTIO_NET_CTRL_TUNNEL_HASH_GET command if the device responds with VIRTIO_NET_ERR.
+
+The driver MUST NOT set any VIRTIO_NET_HASH_TUNNEL_TYPE_ flags which are not supported by the device.
+
 \paragraph{Hash reporting for incoming packets}
 \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash reporting for incoming packets}
 
diff --git a/device-types/net/device-conformance.tex b/device-types/net/device-conformance.tex
index 54f6783..f88f48b 100644
--- a/device-types/net/device-conformance.tex
+++ b/device-types/net/device-conformance.tex
@@ -14,4 +14,5 @@
 \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
 \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
 \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
+\item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Inner Header Hash}
 \end{itemize}
diff --git a/device-types/net/driver-conformance.tex b/device-types/net/driver-conformance.tex
index 97d0cc1..9d853d9 100644
--- a/device-types/net/driver-conformance.tex
+++ b/device-types/net/driver-conformance.tex
@@ -14,4 +14,5 @@
 \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Offloads State Configuration / Setting Offloads State}
 \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) }
 \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
+\item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Inner Header Hash}
 \end{itemize}
diff --git a/introduction.tex b/introduction.tex
index b7155bf..7656efa 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -102,6 +102,50 @@ \section{Normative References}\label{sec:Normative References}
     Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic Cureve Cryptography'', Version 1.0, September 2000.
 	\newline\url{https://www.secg.org/sec1-v2.pdf}\\
 
+	\phantomsection\label{intro:gre_rfc2784}\textbf{[GRE_rfc2784]} &
+    Generic Routing Encapsulation. This protocol is only specified for IPv4 and used as either the payload or delivery protocol.
+	\newline\url{https://datatracker.ietf.org/doc/rfc2784/}\\
+	\phantomsection\label{intro:gre_rfc2890}\textbf{[GRE_rfc2890]} &
+    Key and Sequence Number Extensions to GRE \ref{intro:gre_rfc2784}. This protocol describes extensions by which two fields, Key and
+    Sequence Number, can be optionally carried in the GRE Header \ref{intro:gre_rfc2784}.
+	\newline\url{https://www.rfc-editor.org/rfc/rfc2890}\\
+	\phantomsection\label{intro:gre_rfc7676}\textbf{[GRE_rfc7676]} &
+    IPv6 Support for Generic Routing Encapsulation (GRE). This protocol is specified for IPv6 and used as either the payload or
+    delivery protocol. Note that this does not change the GRE header format or any behaviors specified by RFC 2784 or RFC 2890.
+	\newline\url{https://datatracker.ietf.org/doc/rfc7676/}\\
+	\phantomsection\label{intro:gre_in_udp_rfc8086}\textbf{[GRE-in-UDP]} &
+    GRE-in-UDP Encapsulation. This specifies a method of encapsulating network protocol packets within GRE and UDP headers.
+    This GRE-in-UDP encapsulation allows the UDP source port field to be used as an entropy field. This protocol is specified for IPv4 and IPv6,
+    and used as either the payload or delivery protocol.
+	\newline\url{https://www.rfc-editor.org/rfc/rfc8086}\\
+	\phantomsection\label{intro:vxlan}\textbf{[VXLAN]} &
+    Virtual eXtensible Local Area Network.
+	\newline\url{https://datatracker.ietf.org/doc/rfc7348/}\\
+	\phantomsection\label{intro:vxlan-gpe}\textbf{[VXLAN-GPE]} &
+    Generic Protocol Extension for VXLAN. This protocol describes extending Virtual eXtensible Local Area Network (VXLAN) via changes to the VXLAN header.
+	\newline\url{https://www.ietf.org/archive/id/draft-ietf-nvo3-vxlan-gpe-12.txt}\\
+	\phantomsection\label{intro:geneve}\textbf{[GENEVE]} &
+    Generic Network Virtualization Encapsulation.
+	\newline\url{https://datatracker.ietf.org/doc/rfc8926/}\\
+	\phantomsection\label{intro:ipip}\textbf{[IPIP]} &
+    IP Encapsulation within IP.
+	\newline\url{https://www.rfc-editor.org/rfc/rfc2003}\\
+	\phantomsection\label{intro:nvgre}\textbf{[NVGRE]} &
+    NVGRE: Network Virtualization Using Generic Routing Encapsulation
+	\newline\url{https://www.rfc-editor.org/rfc/rfc7637.html}\\
+	\phantomsection\label{intro:stt}\textbf{[STT]} &
+    Stateless Transport Tunneling. STT is particularly useful when some tunnel endpoints are in end-systems, as it utilizes the capabilities
+    of the network interface card to improve performance.
+	\newline\url{https://www.ietf.org/archive/id/draft-davie-stt-08.txt}\\
+	\phantomsection\label{intro:IP}\textbf{[IP]} &
+    INTERNET PROTOCOL
+	\newline\url{https://www.rfc-editor.org/rfc/rfc791}\\
+	\phantomsection\label{intro:UDP}\textbf{[UDP]} &
+    User Datagram Protocol
+	\newline\url{https://www.rfc-editor.org/rfc/rfc768}\\
+	\phantomsection\label{intro:TCP}\textbf{[TCP]} &
+    TRANSMISSION CONTROL PROTOCOL
+	\newline\url{https://www.rfc-editor.org/rfc/rfc793}\\
 \end{longtable}
 
 \section{Non-Normative References}
-- 
2.19.1.6.gb485710b


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

