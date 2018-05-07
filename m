Return-Path: virtio-dev-return-4046-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 227FD58191B2
	for <virtio-dev@lists.oasis-open.org>; Mon,  7 May 2018 04:25:24 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon,  7 May 2018 14:24:57 +0300
Message-Id: <20180507112457.14134-5-sameeh@daynix.com>
In-Reply-To: <20180507112457.14134-1-sameeh@daynix.com>
References: <20180507112457.14134-1-sameeh@daynix.com>
Subject: [virtio-dev] [PATCH v5 4/4] content: net: steering mode: Add RSS
To: virtio-dev@lists.oasis-open.org
Cc: Amnon Ilan <ailan@redhat.com>, Yan Vugenfirer <yan@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Sameeh Jubran <sjubran@redhat.com>

This commit introduces the RSS feature into virtio-net. It is introduced
as a sub mode for a general command which configures the steering mode.

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
 content.tex | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/content.tex b/content.tex
index c8add9b..cd97196 100644
--- a/content.tex
+++ b/content.tex
@@ -4045,6 +4045,7 @@ device MUST supply the hash value for each packet in the \field{hash} field.
 \begin{lstlisting}
 // steering mode flags
 #define STEERING_MODE_AUTO          0x1
+#define STEERING_MODE_RSS           0x2
 
 // Used by the devide for returning to the driver the supported steering modes
 struct virtio_net_steering_modes {
@@ -4057,6 +4058,7 @@ le32 command;
 
 // A union which can be used for passing structures to one of the sub modes
     union {
+    struct virtio_net_rss rss_conf;
     }
 };
 
@@ -4093,6 +4095,119 @@ The class VIRTIO_NET_CTRL_STEERING_MODE has two commands:
 
 This is the default steering mode, please refer to the "Automatic receive steering in multiqueue mode" section.
 
+\subparagraph{Receive Side Scaling}{Device Types / Network Device / Device Operation / Control Virtqueue / Steering mode / Receive Side Scaling}
+
+\begin{lstlisting}
+#define RSS_HASH_FUNCTION_TOEPLITZ  0x1
+#define RSS_HASH_FUNCTION_SYMMETRIC 0x2
+
+// Hash function fields
+#define RSS_HASH_FIELDS_IPV4          0x00000100
+#define RSS_HASH_FIELDS_TCP_IPV4      0x00000200
+#define RSS_HASH_FIELDS_IPV6          0x00000400
+#define RSS_HASH_FIELDS_IPV6_EX       0x00000800
+#define RSS_HASH_FIELDS_TCP_IPV6      0x00001000
+#define RSS_HASH_FIELDS_TCP_IPV6_EX   0x00002000
+
+struct virtio_net_rss_supported_hash{
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
+#define VIRTIO_NET_SM_CTRL_RSS_GET_SUPPORTED_FUNCTIONS   0
+#define VIRTIO_NET_SM_CTRL_RSS_SET                       1
+\end{lstlisting}
+
+If the VIRTIO_NET_F_CTRL_STEERING_MODE feature bit is negotiated, the driver
+can send steering mode control command, VIRTIO_NET_CTRL_SM_CONTROL, with the
+STEERING_MODE_RSS flag for configuring RSS provided it is one of the supported
+modes. The supported steering modes returned by the device in responce to
+VIRTIO_NET_CTRL_SM_GET_SUPPORTED_MODES command issued by the driver. The
+virtio_net_steering_mode SHOULD be filled. For configuring particulars of RSS
+steering mode, the various fields of virtio_net_steering_mode should be filled
+by the driver.  This includes \field{steering_mode} with  STEERING_MODE_RSS
+flag along with one of the VIRTIO_NET_SM_CTRL_RSS commands in the
+\field{command} field in addition to union \field{rss_conf} field members.
+
+The class VIRTIO_NET_CTRL_RSS has two commands:
+
+\begin{enumerate}
+\item VIRTIO_NET_SM_CTRL_RSS_GET_SUPPORTED_FUNCTIONS returns the hash functions
+	supported by the device to the driver.
+\item VIRTIO_NET_SM_CTRL_RSS_SET applies the new RSS configuration. The command is
+	used by the driver for setting RSS hash function, hash key and
+	indirection table in the device.
+\end{enumerate}
+
+\devicenormative{\subparagraph}{Receive Side Scaling}{Device Types / Network Device / Device Operation / Control Virtqueue / Steering mode / Receive Side Scaling}
+
+The device MUST fill the virtio_net_rss_supported_hash structure with the hash
+functions it supports and return the structure to the driver. One or more
+flags of the RSS_HASH_FUNCTION flags MUST be used to fill the \field{hash_function}
+field.
+
+The device MUST drop all previous RSS configuration upon receiving
+VIRTIO_NET_SM_CTRL_RSS_SET command.
+
+The device MUST set the RSS configuration according to the settings provided as
+follows, once the configuration process is completed the device SHOULD apply
+the hash function to each of the incoming packets with regards to the flags in
+the \field{hash_function_flags} fields and distribute the packets through the
+virqueues using the calculated hash and the indirection table that were earlier
+provided by the driver.
+
+Setting RSS configuration
+\begin{enumerate}
+\item The driver fills all of the fields and passes them through the control
+	queue to the device.
+
+\item The device sets the RSS configuration as provided by the driver.
+
+\item If the device successfully applied the configuration, on each packet
+	received the device MUST calculate the hash for the packet using
+	the fields specified in \field{hash_function_flags}.
+	If the feature VIRTIO_NET_F_HASH_OFFLOAD has been negotiated, the
+	device MUST store the hash value in the virtio-net header in the
+	\field{hash} field.
+\end{enumerate}
+
+\drivernormative{\subparagraph}{Receive Side Scaling}{Device Types / Network Device / Device Operation / Control Virtqueue / Steering mode / Receive Side Scaling}
+
+If the driver wants to set RSS hash it SHOULD fill the RSS structure fields
+as follows:
+
+\begin{itemize}
+\item The driver SHOULD choose the hash function that SHOULD be used and fill
+	it in the \field{hash_function} field along with the appropriate flags
+	in the \field{hash_function_flags} field. These flags indicate to the
+	device which packet fields MUST be used in the calculation process of
+	the hash.
+\item Once the hash function has been chosen a hash key SHOULD also be set by
+	the driver in the \field{hash_key} field, the length of the key SHOULD
+	be stored in the \field{hash_key_length} field.
+\item Lastly the driver SHOULD fill the indirection table array in the
+	\field{indirection_table} field while setting the array length in
+	\field{indirection_table_length}. This structure is used by the device
+	for determining in which RX virt queue the packet SHOULD be placed.
+\end{itemize}
+Once the configuration phase is over successfully and if the feature
+VIRTIO_NET_F_HASH_OFFLOAD has been negotiated, the packets SHOULD have the
+\field{hash} field with the hash value that was calculated by the device.
+
+Whenever the driver wants to stop performing RSS, it can switch back to
+Automatic Steering Mode using the VIRTIO_NET_CTRL_SM_CONTROL command along with
+the STEERING_MODE_AUTO flag.
+
 \paragraph{Offloads State Configuration}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Offloads State Configuration}
 
 If the VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature is negotiated, the driver can
-- 
2.13.6


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

