Return-Path: <virtio-dev-return-13209-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3024FEB64DD
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Jul 2023 15:27:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 65FCB77051
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Jul 2023 15:27:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 470AE986597
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Jul 2023 15:27:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 37440986533; Mon,  3 Jul 2023 15:27:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F4DD986553;
	Mon,  3 Jul 2023 15:27:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VmZ0Ggx_1688398031;
From: Heng Qi <hengqi@linux.alibaba.com>
To: virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Parav Pandit <parav@nvidia.com>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>
Date: Mon,  3 Jul 2023 23:27:11 +0800
Message-Id: <20230703152711.106008-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v21] virtio-net: support inner header hash

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

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/173
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
---
v20->v21:
	1. Some English tweaks and minor revisions. @Michael S . Tsirkin

v19->v20:
	1. Remove the GET command.
	2. Use the virtnet_hash_tunnel structure.

v18->v19:
	1. Have a single structure instead of two. @Michael S . Tsirkin
	2. Some small rewrites. @Michael S . Tsirkin
	3. Rebase to master.

v17->v18:
	1. Some rewording suggestions from Michael (Thanks!).
	2. Use 0 to disable inner header hash and remove
	   VIRTIO_NET_HASH_TUNNEL_TYPE_NONE.
v16->v17:
	1. Some small rewrites. @Parav Pandit
	2. Add Parav's Reviewed-by tag (Thanks!).

v15->v16:
	1. Remove the hash_option. In order to delimit the inner header hash and RSS
	   configuration, the ability to configure the outer src udp port hash is given
	   to RSS. This is orthogonal to inner header hash, which will be done in the
	   RSS capability extension topic (considered as an RSS extension together
	   with the symmetric toeplitz hash algorithm, etc.). @Parav Pandit @Michael S . Tsirkin
	2. Fix a 'field' typo. @Parav Pandit

v14->v15:
	1. Add tunnel hash option suggested by @Michael S . Tsirkin
	2. Adjust some descriptions.

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

 device-types/net/description.tex        | 108 ++++++++++++++++++++++++
 device-types/net/device-conformance.tex |   1 +
 device-types/net/driver-conformance.tex |   1 +
 introduction.tex                        |  39 +++++++++
 4 files changed, 149 insertions(+)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index 3030222..206020d 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -88,6 +88,8 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.
 
+\item[VIRTIO_NET_F_HASH_TUNNEL(51)] Device supports inner header hash for encapsulated packets.
+
 \item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue notification coalescing.
 
 \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
@@ -147,6 +149,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
 \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
 \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
+\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ along with VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT.
 \end{description}
 
 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
@@ -175,6 +178,7 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
         u8 rss_max_key_size;
         le16 rss_max_indirection_table_length;
         le32 supported_hash_types;
+        le32 supported_tunnel_types;
 };
 \end{lstlisting}
 
@@ -225,6 +229,12 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
 Field \field{supported_hash_types} contains the bitmask of supported hash types.
 See \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types} for details of supported hash types.
 
+Field \field{supported_tunnel_types} only exists if the device supports inner header hash, i.e. if VIRTIO_NET_F_HASH_TUNNEL is set.
+
+Field \field{supported_tunnel_types} contains the bitmask of encapsulation types supported by the device for inner header hash.
+Encapsulation types are defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets /
+Hash calculation for incoming packets / Encapsulation types supported/enabled for inner header hash}.
+
 \devicenormative{\subsubsection}{Device configuration layout}{Device Types / Network Device / Device configuration layout}
 
 The device MUST set \field{max_virtqueue_pairs} to between 1 and 0x8000 inclusive,
@@ -869,6 +879,8 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 If the feature VIRTIO_NET_F_RSS was negotiated:
 \begin{itemize}
 \item The device uses \field{hash_types} of the virtio_net_rss_config structure as 'Enabled hash types' bitmask.
+\item If additionally the feature VIRTIO_NET_F_HASH_TUNNEL was negotiated, the device uses \field{enabled_tunnel_types} of the
+      virtnet_hash_tunnel structure as 'Encapsulation types enabled for inner header hash' bitmask.
 \item The device uses a key as defined in \field{hash_key_data} and \field{hash_key_length} of the virtio_net_rss_config structure (see
 \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / Setting RSS parameters}).
 \end{itemize}
@@ -876,6 +888,8 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 If the feature VIRTIO_NET_F_RSS was not negotiated:
 \begin{itemize}
 \item The device uses \field{hash_types} of the virtio_net_hash_config structure as 'Enabled hash types' bitmask.
+\item If additionally the feature VIRTIO_NET_F_HASH_TUNNEL was negotiated, the device uses \field{enabled_tunnel_types} of the
+      virtnet_hash_tunnel structure as 'Encapsulation types enabled for inner header hash' bitmask.
 \item The device uses a key as defined in \field{hash_key_data} and \field{hash_key_length} of the virtio_net_hash_config structure (see
 \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Hash calculation}).
 \end{itemize}
@@ -889,6 +903,9 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
  \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Hash calculation}.
 \end{itemize}
 
+The per-packet hash calculation can depend on the IP packet type. See
+\hyperref[intro:IP]{[IP]}, \hyperref[intro:UDP]{[UDP]} and \hyperref[intro:TCP]{[TCP]}.
+
 \subparagraph{Supported/enabled hash types}
 \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}
 Hash types applicable for IPv4 packets:
@@ -1001,6 +1018,97 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 (see \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv6 packets without extension header}).
 \end{itemize}
 
+\paragraph{Inner Header Hash}
+\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Inner Header Hash}
+
+If VIRTIO_NET_F_HASH_TUNNEL has been negotiated, the driver can send the command
+VIRTIO_NET_CTRL_HASH_TUNNEL_SET to configure the calculation of the inner header hash.
+
+struct virtnet_hash_tunnel {
+    le32 enabled_tunnel_types;
+};
+
+#define VIRTIO_NET_CTRL_HASH_TUNNEL 7
+ #define VIRTIO_NET_CTRL_HASH_TUNNEL_SET 0
+
+Field \field{enabled_tunnel_types} contains the bitmask of encapsulation types enabled for inner header hash.
+See \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets /
+Hash calculation for incoming packets / Encapsulation types supported/enabled for inner header hash}.
+
+The class VIRTIO_NET_CTRL_HASH_TUNNEL has one command:
+VIRTIO_NET_CTRL_HASH_TUNNEL_SET sets \field{enabled_tunnel_types} for the device using the
+virtnet_hash_tunnel structure, which is read-only for the device.
+
+Inner header hash is disabled by VIRTIO_NET_CTRL_HASH_TUNNEL_SET with \field{enabled_tunnel_types} set to 0.
+
+Initially (before the driver sends any VIRTIO_NET_CTRL_HASH_TUNNEL_SET command) all
+encapsulation types are disabled for inner header hash.
+
+\subparagraph{Encapsulated packet}
+\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Encapsulated packet}
+
+Multiple tunneling protocols allow encapsulating an inner, payload packet in an outer, encapsulated packet.
+The encapsulated packet thus contains an outer header and an inner header, and the device calculates the
+hash over either the inner header or the outer header.
+
+If VIRTIO_NET_F_HASH_TUNNEL is negotiated and a received encapsulated packet's outer header matches one of the
+encapsulation types enabled in \field{enabled_tunnel_types}, then the device uses the inner header for hash
+calculations (only a single level of encapsulation is currently supported).
+
+If VIRTIO_NET_F_HASH_TUNNEL is negotiated and a received packet's (outer) header does not match any encapsulation
+types enabled in \field{enabled_tunnel_types}, then the device uses the outer header for hash calculations.
+
+\subparagraph{Encapsulation types supported/enabled for inner header hash}
+\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets /
+Hash calculation for incoming packets / Encapsulation types supported/enabled for inner header hash}
+
+Encapsulation types applicable for inner header hash:
+\begin{lstlisting}
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2784    (1 << 0) /* \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]} */
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2890    (1 << 1) /* \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]} */
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_7676    (1 << 2) /* \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]} */
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_UDP     (1 << 3) /* \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]} */
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 4) /* \hyperref[intro:vxlan]{[VXLAN]} */
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN_GPE   (1 << 5) /* \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]} */
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 6) /* \hyperref[intro:geneve]{[GENEVE]} */
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 7) /* \hyperref[intro:ipip]{[IPIP]} */
+#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 8) /* \hyperref[intro:nvgre]{[NVGRE]} */
+\end{lstlisting}
+
+\subparagraph{Advice}
+Example uses of the inner header hash:
+\begin{itemize}
+\item Legacy tunneling protocols, lacking the outer header entropy, can use RSS with the inner header hash to
+      distribute flows with identical outer but different inner headers across various queues, improving performance.
+\item Identify an inner flow distributed across multiple outer tunnels.
+\end{itemize}
+
+As using the inner header hash completely discards the outer header entropy, care must be taken
+if the inner header is controlled by an adversary, as the adversary can then intentionally create
+configurations with insufficient entropy.
+
+Besides disabling the inner header hash, mitigations would depend on how the hash is used. When the hash
+use is limited to the RSS queue selection, the inner header hash may have quality of service (QoS) limitations.
+
+\devicenormative{\subparagraph}{Inner Header Hash}{Device Types / Network Device / Device Operation / Control Virtqueue / Inner Header Hash}
+
+If the (outer) header of the received packet does not match any encapsulation types enabled
+in \field{enabled_tunnel_types}, the device MUST calculate the hash on the outer header.
+
+If the device receives any bits in \field{enabled_tunnel_types} which are not set in \field{supported_tunnel_types},
+it SHOULD respond to the VIRTIO_NET_CTRL_HASH_TUNNEL_SET command with VIRTIO_NET_ERR.
+
+If the driver sets \field{enabled_tunnel_types} to 0 through VIRTIO_NET_CTRL_HASH_TUNNEL_SET or upon the device reset,
+the device MUST disable the inner header hash for all encapsulation types.
+
+\drivernormative{\subparagraph}{Inner Header Hash}{Device Types / Network Device / Device Operation / Control Virtqueue / Inner Header Hash}
+
+The driver MUST have negotiated the VIRTIO_NET_F_HASH_TUNNEL feature when issuing the VIRTIO_NET_CTRL_HASH_TUNNEL_SET command.
+
+The driver MUST NOT set any bits in \field{enabled_tunnel_types} which are not set in \field{supported_tunnel_types}.
+
+The driver MUST ignore bits in \field{supported_tunnel_types} which are not documented in this specification.
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
index b7155bf..81f07a4 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -102,6 +102,45 @@ \section{Normative References}\label{sec:Normative References}
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
+    This protocol is specified for IPv4 and IPv6, and used as either the payload or delivery protocol.
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

