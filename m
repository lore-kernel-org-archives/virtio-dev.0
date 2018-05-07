Return-Path: virtio-dev-return-4044-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A735658191A2
	for <virtio-dev@lists.oasis-open.org>; Mon,  7 May 2018 04:25:20 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon,  7 May 2018 14:24:54 +0300
Message-Id: <20180507112457.14134-2-sameeh@daynix.com>
In-Reply-To: <20180507112457.14134-1-sameeh@daynix.com>
References: <20180507112457.14134-1-sameeh@daynix.com>
Subject: [virtio-dev] [PATCH v5 1/4] content: net: Add VIRTIO_NET_F_CTRL_STEERING_MODE feature
To: virtio-dev@lists.oasis-open.org
Cc: Amnon Ilan <ailan@redhat.com>, Yan Vugenfirer <yan@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Sameeh Jubran <sameeh.j@gmail.com>

This commit introduces steering mode into network device. Steering
mode is a general infrastructure for various steering modes that can
be implemented on top of it such as Automatic and RSS.

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
---
 content.tex | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/content.tex b/content.tex
index c840588..850844e 100644
--- a/content.tex
+++ b/content.tex
@@ -3115,6 +3115,9 @@ features.
 
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.
+
+\item[VIRTIO_NET_F_CTRL_STEERING_MODE(60)] Device supports configurable steering
+    mode.
 \end{description}
 
 \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device / Feature bits / Feature bit requirements}
@@ -3317,6 +3320,7 @@ struct virtio_net_hdr {
         le16 csum_start;
         le16 csum_offset;
         le16 num_buffers;
+        le64 hash;
 };
 \end{lstlisting}
 
@@ -4013,6 +4017,59 @@ MUST format \field{virtqueue_pairs}
 according to the native endian of the guest rather than
 (necessarily when not using the legacy interface) little-endian.
 
+\paragraph{Steering mode}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Steering mode}
+
+\begin{lstlisting}
+// steering mode flags
+#define STEERING_MODE_AUTO          0x1
+
+// Used by the devide for returning to the driver the supported steering modes
+struct virtio_net_steering_modes {
+le32 steering_modes;
+};
+
+struct virtio_net_steering_mode {
+le32 steering_mode;
+le32 command;
+
+// A union which can be used for passing structures to one of the sub modes
+    union {
+    }
+};
+
+#define VIRTIO_NET_F_CTRL_STEERING_MODE     60
+
+#define VIRTIO_NET_CTRL_STEERING_MODE                7
+#define VIRTIO_NET_CTRL_SM_GET_SUPPORTED_MODES        0
+#define VIRTIO_NET_CTRL_SM_CONTROL                    1
+\end{lstlisting}
+
+If the VIRTIO_NET_F_CTRL_STEERING_MODE is negotiated the driver can send control commands for the
+configuring the steering mode. There are multiple steering modes and they can be configured using
+the VIRTIO_NET_CTRL_SM_CONTROL command. Each mode has it's own set of commands.
+
+The auto steering mode is the default mode if nothing else has been configured by the driver
+and the VIRTIO_NET_F_CTRL_STEERING_MODE feature is acked by the driver.
+
+The class VIRTIO_NET_CTRL_STEERING_MODE has two commands:
+
+\begin{enumerate}
+
+\item VIRTIO_NET_CTRL_SM_GET_SUPPORTED_MODES is used for getting the supported steering modes by the device.
+	The command SHOULD be executed by the driver before attempting to configure the steering mode. Once the device
+	receives this command it SHOULD fill the virtio_net_steering_modes structure with the supported steering mode
+	flags.
+
+\item The command VIRTIO_NET_CTRL_SM_CONTROL is used for controlling the different steering modes. Each steering mode
+	has its own set of commands. When executing this command the structure virtio_net_steering_mode SHOULD be used as follows:
+	the \field{steering_mode} SHOULD be filled with one of the supported steering mode flags along with an appropriate command
+	from the chosen steering mode. The union of virtio_net_steering_mode SHOULD be used and filled as the mode's command suggests.
+\end{enumerate}
+
+\subparagraph{Automatic Receive Steering}{Device Types / Network Device / Device Operation / Control Virtqueue / Steering mode / Automatic Receive Steering}
+
+This is the default steering mode, please refer to the "Automatic receive steering in multiqueue mode" section.
+
 \paragraph{Offloads State Configuration}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Offloads State Configuration}
 
 If the VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature is negotiated, the driver can
-- 
2.13.6


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

