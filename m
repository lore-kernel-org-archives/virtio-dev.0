Return-Path: <virtio-dev-return-11607-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD95C6FD1F
	for <virtio-dev@archiver.kernel.org>; Sun, 12 Mar 2023 12:46:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F02B726A26
	for <virtio-dev@archiver.kernel.org>; Sun, 12 Mar 2023 12:46:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E3BDB9861F9
	for <virtio-dev@archiver.kernel.org>; Sun, 12 Mar 2023 12:46:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D765B9860BE; Sun, 12 Mar 2023 12:46:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C0E2B9860AD;
	Sun, 12 Mar 2023 12:46:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vdd4Ugi_1678625188;
From: Heng Qi <hengqi@linux.alibaba.com>
To: virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Parav Pandit <parav@nvidia.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	David Edmondson <david.edmondson@oracle.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Sun, 12 Mar 2023 20:46:28 +0800
Message-Id: <20230312124628.8527-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v12] virtio-net: support the virtqueue coalescing moderation

Currently, coalescing parameters are grouped for all transmit and receive
virtqueues. This patch supports setting or getting the parameters for a
specified virtqueue, and a typical application of this function is netdim[1].

When the traffic between virtqueues is unbalanced, for example, one virtqueue
is busy and another virtqueue is idle, then it will be very useful to
control coalescing parameters at the virtqueue granularity.

[1] https://docs.kernel.org/networking/net_dim.html

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
---
v11->v12:
       1. Use virtqueue having vqn N instead of virtqueueN. @Parav Pandit
       2. Some minor modifications. @Parav Pandit, @Michael S . Tsirkin
       3. Add Parav's Reviewed-by tag (Thanks!).

v10->v11:
       1. Describe read and write attributes for the structure. @Parav Pandit
       2. Some minor modifications. @Parav Pandit

v9->v10:
       1. Remove the "global values". @Parav Pandit
       2. Avoid multiple interpretations of command behavior. @Alvaro Karsz

v8->v9:
       1. Declare the commands that can be sent for each feature. @Alvaro Karsz
       2. Add information about "global values" in the command's explanation. @Alvaro Karsz

v7->v8:
       1. Use "best-effort" in Alvaro's patch instead of "the device may set the parameter to a value close to 2". @Michael S . Tsirkin, @David Edmondson

v6->v7:
       1. Clarify the relationship of VIRTIO_NET_CTRL_NOTF_COAL_TX/RX_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET. @Alvaro Karsz, @Michael S. Tsirkin
       2. Remove the formula for vqn range. @Parav Pandit
       3. Some expressions are clearer. @Parav Pandit, @Michael S. Tsirkin

v5->v6:
       1. Explain that the device may set a different value than the one passed in by the driver. @David Edmondson

v4->v5:
       1. Add the correspondence between virtio_net_ctrl_coal and virtio_net_ctrl_coal_vq and control commands. @Michael S. Tsirkin
       2. Add read and write attributes for each field. @Michael S. Tsirkin
       3. A clearer description of how to set coalescing parameters for vq reset. @Michael S. Tsirkin
       4. Fix some syntax errors. @Michael S. Tsirkin, @David Edmondson

v3->v4:
       1. Include virtio_net_ctrl_coal in the virtio_net_ctrl_coal_vq structure. @Alvaro Karsz
       2. Add consideration of vq reset. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
       3. Avoid too many examples by giving a comprehensive example. @Michael S. Tsirkin
       4. Fix typos and streamline clarifications. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz

v2->v3:
       1. Add the netdim link. @Parav Pandit
       2. VIRTIO_NET_F_VQ_NOTF_COAL no longer depends on VIRTIO_NET_F_NOTF_COAL. @Michael S. Tsirkin, @Alvaro Karsz
       3. _VQ_GET is explained more. @Michael S. Tsirkin
       4. Add more examples to avoid misunderstandings. @Michael S. Tsirkin
       5. Clarify some statements. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
       6. Adjust the virtio_net_ctrl_coal_vq structure. @Michael S. Tsirkin
       7. Fix some typos. @Michael S. Tsirkin

v1->v2:
       1. Rename VIRTIO_NET_F_PERQUEUE_NOTF_COAL to VIRTIO_NET_F_VQ_NOTF_COAL. @Michael S. Tsirkin
       2. Use the \field{vqn} instead of the qid. @Michael S. Tsirkin
       3. Unify tx and rx control structures into one structure virtio_net_ctrl_coal_vq. @Michael S. Tsirkin
       4. Add a new control command VIRTIO_NET_CTRL_NOTF_COAL_VQ. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
       5. The special value 0xFFF is removed because VIRTIO_NET_CTRL_NOTF_COAL can be used. @Alvaro Karsz
       6. Clarify some special scenarios. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz

 device-types/net/description.tex | 80 ++++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 10 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index e71e33b..c6ab806 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -83,6 +83,8 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.
 
+\item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue notification coalescing.
+
 \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
 
 \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
@@ -139,6 +141,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
 \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
 \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
+\item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
 \end{description}
 
 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
@@ -1506,12 +1509,12 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 \paragraph{Notifications Coalescing}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
 
 If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
-send control commands for dynamically changing the coalescing parameters.
+send commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET
+for notification coalescing.
 
-\begin{note}
-The behavior of the device in response to these commands is best-effort:
-the device may generate notifications more or less frequently than specified.
-\end{note}
+If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated, the driver can
+send commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET
+for virtqueue notification coalescing.
 
 \begin{lstlisting}
 struct virtio_net_ctrl_coal {
@@ -1519,25 +1522,63 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
     le32 max_usecs;
 };
 
+struct virtio_net_ctrl_coal_vq {
+    le16 vqn;
+    le16 reserved;
+    struct virtio_net_ctrl_coal coal;
+};
+
 #define VIRTIO_NET_CTRL_NOTF_COAL 6
  #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
  #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
+ #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2
+ #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
 \end{lstlisting}
 
 Coalescing parameters:
 \begin{itemize}
+\item \field{vqn}: The virtqueue number of an enabled transmit or receive virtqueue.
 \item \field{max_usecs} for RX: Maximum number of microseconds to delay a RX notification.
 \item \field{max_usecs} for TX: Maximum number of microseconds to delay a TX notification.
 \item \field{max_packets} for RX: Maximum number of packets to receive before a RX notification.
 \item \field{max_packets} for TX: Maximum number of packets to send before a TX notification.
 \end{itemize}
 
-The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
+\field{reserved} is reserved and it is ignored by a device.
+
+Read/Write attributes for coalescing parameters:
+\begin{itemize}
+\item For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, the structure virtio_net_ctrl_coal is write-only for a driver.
+\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, the structure virtio_net_ctrl_coal_vq is write-only for a driver.
+\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vqn} and \field{reserved} are write-only
+      for a driver, and the structure virtio_net_ctrl_coal is read-only for the driver.
+\end{itemize}
+
+The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
 \begin{enumerate}
-\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and \field{max_packets} parameters for all transmit virtqueues.
-\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and \field{max_packets} parameters for all receive virtqueues.
+\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: use the structure virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets} parameters for all transmit virtqueues.
+\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: use the structure virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets} parameters for all receive virtqueues.
+\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: use the structure virtio_net_ctrl_coal_vq to set the \field{max_usecs} and \field{max_packets} parameters
+                                        for an enabled transmit/receive virtqueue whose number is \field{vqn}.
+\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: use the structure virtio_net_ctrl_coal_vq to get the \field{max_usecs} and \field{max_packets} parameters
+                                        for an enabled transmit/receive virtqueue whose number is \field{vqn}.
 \end{enumerate}
 
+The device may generate notifications more or less frequently than specified by set commands of the VIRTIO_NET_CTRL_NOTF_COAL class.
+
+If coalescing parameters are being set, the device applies the last coalescing parameters set for a
+virtqueue, regardless of the command used to set the parameters. Use the following command sequence
+with 2 pairs of virtqueues as an example:
+Each of the following commands sets \field{max_usecs} and \field{max_packets} parameters for virtqueues.
+\begin{itemize}
+\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing parameters for virtqueues having vqn 0 and vqn 2. Virtqueues having vqn 1 and vqn 3 retain their previous parameters.
+\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} = 0 sets coalescing parameters for virtqueue having vqn 0. Virtqueue having vqn 2 retains the parameters from command1.
+\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} = 0, the device responds with coalescing parameters of vqn 0 set by command2.
+\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} = 1 sets coalescing parameters for virtqueue having vqn 1. Virtqueue having vqn 3 retains its previous parameters.
+\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets coalescing parameters for virtqueues having vqn 1 and vqn 3, and overrides the parameters set by command4.
+\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} = 1, the device responds with coalescing parameters of vqn 1 set by command5.
+\end{itemize}
+
 \subparagraph{Operation}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / Operation}
 
 The device sends a used buffer notification once the notification conditions are met and if the notifications are not suppressed as explained in \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}.
@@ -1585,14 +1626,33 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 
 \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
 
-If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
+A driver MUST negotiate the VIRTIO_NET_F_NOTF_COAL feature before issuing commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRIO_NET_CTRL_NOTF_COAL_RX_SET.
+
+A driver MUST negotiate the VIRTIO_NET_F_VQ_NOTF_COAL feature before issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRIO_NET_CTRL_NOTF_COAL_VQ_GET.
+
+A driver MUST ignore the values of coalescing parameters received from the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if a device responds with VIRTIO_NET_ERR.
 
 \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
 
-A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with VIRTIO_NET_ERR if it was not able to change the parameters.
+A device MUST ignore \field{reserved}.
+
+A device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it was not able to change the parameters.
+
+A device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with VIRTIO_NET_ERR if it was not able to change the parameters.
+
+A device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with VIRTIO_NET_ERR if the given virtqueue is disabled.
+
+Upon disabling and re-enabling the transmit virtqueue, the device MUST set the coalescing parameters of the virtqueue
+to those configured through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver did not set any TX coalescing parameters, to 0.
+
+Upon disabling and re-enabling the receive virtqueue, the device MUST set the coalescing parameters of the virtqueue
+to those configured through the VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or, if the driver did not set any RX coalescing parameters, to 0.
 
 A device SHOULD NOT send used buffer notifications to the driver if the notifications are suppressed, even if the notification conditions are met.
 
+The behavior of the device in response to set commands of the VIRTIO_NET_CTRL_NOTF_COAL class is best-effort:
+the device MAY generate notifications more or less frequently than specified.
+
 Upon reset, a device MUST initialize all coalescing parameters to 0.
 
 \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
-- 
2.19.1.6.gb485710b


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

