Return-Path: <virtio-dev-return-14180-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69AFC3DA6E
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Dec 2023 14:26:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 12B19217A9
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Dec 2023 14:26:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A96A986581
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Dec 2023 14:26:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F23C3986546; Wed, 20 Dec 2023 14:26:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DFDC8986547;
	Wed, 20 Dec 2023 14:26:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VyuiLbf_1703082362;
From: Heng Qi <hengqi@linux.alibaba.com>
To: virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Parav Pandit <parav@nvidia.com>
Date: Wed, 20 Dec 2023 22:26:02 +0800
Message-Id: <d3ec06513a9ab1512aaaea3c46e8e4b55e3c150f.1703082056.git.hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH] virtio-net: support setting coalescing params for multiple vqs

Currently, when each time the driver attempts to update the coalescing parameters
for a vq, it needs to kick the device and wait for the ctrlq response to return.

If a command can only update one vq parameters, when the parameters are updated
frequently (such as netdim), ctrlq on the device is kicked frequently, which will
increase the device CPU scheduling overhead, and the number and overhead of device
DMA will also increase.

Merging multiple vq updated parameters into one command can effectively reduce
the number of kick devices and device DMA times.

Test results show that this greatly improves the efficiency of the ctrlq in
responding to multiple vq coalescing parameter updates issued by the driver.

I try this as an update to the VIRTIO_NET_F_VQ_NOTF_COAL feature, but not sure
if it's timely at the moment. If not in time, a new feature bit is needed?

Suggested-by: Xiaoming Zhao <zxm377917@alibaba-inc.com>
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 device-types/net/description.tex | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index aff5e08..239fe1c 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1667,8 +1667,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 for notification coalescing.
 
 If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated, the driver can
-send commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET
-for virtqueue notification coalescing.
+send commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET and
+VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET for virtqueue notification coalescing.
 
 \begin{lstlisting}
 struct virtio_net_ctrl_coal {
@@ -1682,11 +1682,17 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
     struct virtio_net_ctrl_coal coal;
 };
 
+struct virtio_net_ctrl_mrg_coal_vq {
+        le16 num_entries; /* indicates number of valid entries */
+        struct virtio_net_ctrl_coal_vq entries[];
+};
+
 #define VIRTIO_NET_CTRL_NOTF_COAL 6
  #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
  #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
  #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2
  #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
+ #define VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET 4
 \end{lstlisting}
 
 Coalescing parameters:
@@ -1706,6 +1712,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 \item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, the structure virtio_net_ctrl_coal_vq is write-only for the driver.
 \item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vq_index} and \field{reserved} are write-only
       for the driver, and the structure virtio_net_ctrl_coal is read-only for the driver.
+\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET, the structure virtio_net_ctrl_mrg_coal_vq is write-only for the driver.
 \end{itemize}
 
 The class VIRTIO_NET_CTRL_NOTF_COAL has the following commands:
@@ -1716,6 +1723,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
                                         for an enabled transmit/receive virtqueue whose index is \field{vq_index}.
 \item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: use the structure virtio_net_ctrl_coal_vq to get the \field{max_usecs} and \field{max_packets} parameters
                                         for an enabled transmit/receive virtqueue whose index is \field{vq_index}.
+\item VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET: use the structure virtio_net_ctrl_mrg_coal_vq to set the \field{max_usecs} and \field{max_packets} parameters
+                                         for \field{num_entries} enabled transmit/receive virtqueues. The corresponding index value
+                                         of each configured virtqueue is \field{vq_index}.
 \end{enumerate}
 
 The device may generate notifications more or less frequently than specified by set commands of the VIRTIO_NET_CTRL_NOTF_COAL class.
@@ -1792,6 +1802,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 
 The device MUST ignore \field{reserved}.
 
+The device MUST set \field{num_entries} to a non-zero value and MUST NOT set \field{num_entries} to
+a value greater than the number of enabled transmit and receive virtqueues.
+
 The device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it was not able to change the parameters.
 
 The device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with VIRTIO_NET_ERR if it was not able to change the parameters.
-- 
2.19.1.6.gb485710b


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

