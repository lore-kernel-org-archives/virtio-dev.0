Return-Path: virtio-dev-return-3068-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 213B05818120
	for <virtio-dev@lists.oasis-open.org>; Thu, 25 Jan 2018 08:27:29 -0800 (PST)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Thu, 25 Jan 2018 18:27:09 +0200
Message-Id: <20180125162709.370-2-sameeh@daynix.com>
In-Reply-To: <20180125162709.370-1-sameeh@daynix.com>
References: <20180125162709.370-1-sameeh@daynix.com>
Subject: [virtio-dev] [RFC virtio-net 1/1] content: net: Add VIRTIO_NET_F_CTRL_RSS feature
To: virtio-dev@lists.oasis-open.org
Cc: Amnon Ilan <ailan@redhat.com>, Yan Vugenfirer <yan@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Sameeh Jubran <sameeh.j@gmail.com>

Most modern high end network devices today support configurable hash functions,
this commit introduces RSS - Receive Side Scaling - [1] to virtio net device.

The RSS is a technology from Microsoft that boosts network device performance
by efficiently distributing the traffic among the CPUs in a multiprocessor
system.

This feature is supported in most of the modern network cards as well as most
modern OSes including Linux and Windows. It is worth mentioning that both DPDK
and Hyper-v support RSS too.

[1] https://docs.microsoft.com/en-us/windows-hardware/drivers/network/ndis-receive-side-scaling2

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
---
 content.tex | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/content.tex b/content.tex
index c840588..5969b28 100644
--- a/content.tex
+++ b/content.tex
@@ -3115,6 +3115,9 @@ features.
 
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.
+
+\item[VIRTIO_NET_F_CTRL_RSS(24)] Device supports configurable RSS hash
+    functions.
 \end{description}
 
 \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device / Feature bits / Feature bit requirements}
@@ -3138,6 +3141,8 @@ Some networking feature bits require other networking feature bits
 \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
+
+\item[VIRTIO_NET_F_CTRL_RSS] Requires VIRTIO_NET_F_MQ.
 \end{description}
 
 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
@@ -3308,6 +3313,7 @@ struct virtio_net_hdr {
         u8 flags;
 #define VIRTIO_NET_HDR_GSO_NONE        0
 #define VIRTIO_NET_HDR_GSO_TCPV4       1
+#define VIRTIO_NET_HDR_GSO_RSS         2
 #define VIRTIO_NET_HDR_GSO_UDP         3
 #define VIRTIO_NET_HDR_GSO_TCPV6       4
 #define VIRTIO_NET_HDR_GSO_ECN      0x80
@@ -3317,6 +3323,8 @@ struct virtio_net_hdr {
         le16 csum_start;
         le16 csum_offset;
         le16 num_buffers;
+// Only if RSS hash offload has been negotiated
+        le64 rss_hash_value;
 };
 \end{lstlisting}
 
@@ -4007,6 +4015,131 @@ VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command.
 The device MUST NOT queue packets on receive queues greater than
 \field{virtqueue_pairs} once it has placed the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command in the used ring.
 
+\paragraph{RSS hash offload}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / RSS hash offload}
+
+\begin{lstlisting}
+#define RSS_HASH_FUNCTION_NONE      1
+#define RSS_HASH_FUNCTION_TOEPLITZ  2
+#define RSS_HASH_FUNCTION_SYMMETRIC 3
+
+// Hash function fields
+#define RSS_HASH_FIELDS_IPV4          0x00000100
+#define RSS_HASH_FIELDS_TCP_IPV4      0x00000200
+#define RSS_HASH_FIELDS_IPV6          0x00000400
+#define RSS_HASH_FIELDS_IPV6_EX       0x00000800
+#define RSS_HASH_FIELDS_TCP_IPV6      0x00001000
+#define RSS_HASH_FIELDS_TCP_IPV6_EX   0x00002000
+
+struct virtio_net_ctrl_rss_hash{
+le32 hash_function;
+}
+
+struct virtio_net_rss {
+le32 hash_function;
+le32 hash_function_flags;
+le32 hash_key_length;
+le32 indirection_table_length;
+	struct {
+		le32 hash_key[hash_key_length];
+		le32 indirection_table[indirection_table_length];
+	}
+};
+
+#define VIRTIO_NET_F_CTRL_RSS     24
+
+#define VIRTIO_NET_CTRL_RSS                           6
+#define VIRTIO_NET_CTRL_RSS_GET_SUPPORTED_FUNCTIONS   0
+#define VIRTIO_NET_CTRL_RSS_DISABLE                   1
+#define VIRTIO_NET_CTRL_RSS_SET                       2
+\end{lstlisting}
+
+If the VIRTIO_NET_F_CTRL_RSS is negotiated the driver can send control
+commands for the RSS configuration.
+
+The class VIRTIO_NET_CTRL_RSS has three commands:
+
+\begin{enumerate}
+\item VIRTIO_NET_CTRL_RSS_GET_SUPPLIED_FUNCTIONS returns the hash functions
+	supported by the device to the driver.
+\item VIRTIO_NET_CTRL_RSS_DISABLE Instructs the device that RSS hashing is no
+	longer required.
+\item VIRTIO_NET_CTRL_RSS_SET applies the new RSS configuration. The command is
+	used by the driver for setting RSS hash function, hash key and
+	indirection table in the device.
+\end{enumerate}
+
+If this feaure has been negotiated, the virtio header has an additional
+field{rss_hash_value} field attached to it.
+
+\devicenormative{\subparagraph}{RSS hash offload}{Device Types / Network Device / Device Operation / Control Virtqueue / RSS hash offload}
+
+The device MUST fill the virtio_net_ctrl_rss_hash structure with the hash
+functions it supports and return the structure to the driver. Zero or more
+flags of the RSS_HASH_FUNCTION flags MUST be used to fill the \field{hash_function}
+field.
+
+Upon recieving VIRTIO_NET_CTRL_DISABLE the device SHOULD stop calculating and
+attaching hashes for the packets as well as stop setting the VIRTIO_NET_HDR_GSO_RSS
+in the \field{gso_type} field, however the \field{hash_function} field is kept
+as a part of the header.
+
+The device MUST drop all previous RSS configuration upon receiving
+VIRTIO_NET_CTRL_RSS_SET command.
+
+The device MUST set the RSS configuration according to the settings provided as
+follows, once the configuration process is completed the device SHOULD apply
+the hash function to each of the incoming packets and distribute the packets
+through the virqueues using the calculated hash and the indirection table
+that were earlier provided by the driver.
+
+Setting RSS configuration
+\begin{enumerate}
+\item The driver fills all of the fields and passes them through the control
+	queue to the device.
+
+\item The device sets the RSS configuration as provided by the driver.
+
+\item If the device successfully applied the configuration, on each packet
+	recieved the device MUST calculate the hashing for the packet and
+	store it in the virtio-net header in rss_hash_value and the hash
+	fields used in the calculation in rss_hash_type.
+\end{enumerate}
+
+In case of any unexpected values/ unsupported hash function the driver
+MUST return VIRTIO_NET_ERR in the \field{ack} field.
+
+\drivernormative{\subparagraph}{RSS hash offload}{Device Types / Network Device / Device Operation / Control Virtqueue / RSS hash offload}
+
+If the driver negotiates the feature VIRTIO_NET_F_CTRL_RSS the driver SHOULD
+send VIRTIO_NET_CTRL_RSS_SET command to the device along with the RSS structure
+filled. The RSS structure fields should be filled as follows:
+
+\begin{itemize}
+\item The driver SHOULD choose the hash function that SHOULD be used and fill
+	it in the \field{hash_function} field along with the approperiate flags
+	in the \field{hash_function_flags} field. These flags inidicate to the
+	device which packet fields MUST be used in the calculation process of
+	the hash.
+\item Once the hash function has been chosen a suitable hash key should be set
+	in the \field{hash_key} field, the length of the key should be stored
+	in the \field{hash_key_length} field.
+\item Lastly the driver should fill the indirection table array in the
+	\field{indirection_table} field while setting the array length in
+	\field{indirection_table_length}. This structure is used by the device
+	for determining in which RX virt queue the packet should be placed.
+\end{itemize}
+Once the configuration phase is over successfully, the packets SHOULD have the
+\field{rss_hash_value} field with the hash value that was calculated by the
+device.
+
+Whenever the driver wants to discard the current RSS settings, it can send an
+VIRTIO_NET_CTRL_RSS_SET command along with rss structure that has
+RSS_HASH_FUNCTION_NONE the \field{hash_function} field.
+
+The driver MUST check the \field{ack} field value provided by the device, in
+case the value is not VIRTIO_NET_OK then the driver MUST hanlde faliure and
+retry another hash function or else give up.
+
 \subparagraph{Legacy Interface: Automatic receive steering in multiqueue mode}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Legacy Interface: Automatic receive steering in multiqueue mode}
 When using the legacy interface, transitional devices and drivers
 MUST format \field{virtqueue_pairs}
-- 
2.13.6


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

