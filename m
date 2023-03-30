Return-Path: <virtio-dev-return-11857-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274BBC761A6
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 17:12:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 85B9B2B00D
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 17:12:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 72D5098655C
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 17:12:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 62A48986542; Thu, 30 Mar 2023 17:12:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 50554986546;
	Thu, 30 Mar 2023 17:12:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Thu, 30 Mar 2023 19:11:14 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Parav Pandit <parav@nvidia.com>
Cc: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>,
        <sgarzare@redhat.com>, <virtio-comment@lists.oasis-open.org>,
        <shahafs@nvidia.com>, Halil Pasic
 <pasic@linux.ibm.com>
Message-ID: <20230330191114.77acd860.pasic@linux.ibm.com>
In-Reply-To: <20230329212341.465843-1-parav@nvidia.com>
References: <20230329212341.465843-1-parav@nvidia.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nQRSfi2ou-A976mjqT3HbT2Y7T_8qhKt
X-Proofpoint-GUID: sZTECIQnevm1b523G0kr7uHJZ1w1tp8f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_10,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303300135
Subject: Re: [virtio-dev] [PATCH v10 0/8] Rename queue index to queue number

On Thu, 30 Mar 2023 00:23:33 +0300
Parav Pandit <parav@nvidia.com> wrote:

> 1. Currently, virtqueue is identified between driver and device
> interchangeably using either number or index terminology.
> 
> 2. Between PCI and MMIO transport the queue size (depth) is
> defined as queue_size and QueueNum respectively.
> 
> To avoid confusion and to have consistency, unify them to use Number.
> 
> Solution:
> a. Use virtqueue number description, and rename MMIO register as QueueSize.

I'm in favor of replacing number with size where appropriate.

> b. Replace virtqueue index with virtqueue number

I don't see the benefit of replacing virtqueue index with virtqueue
number.

Currently virtqueue number is only used in the parts that describe
notifications (Guest->Host), the rest of the spec uses virtqueue index.

I argue that using a different term in that context than in the rest
of the specification makes sense, because in the context of notifications
the virtqueue isn't always identified by its index.

More precisely: if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated in the
context of notifications the virtqueue is identified by the
so called "queue_notify_data"; if VIRTIO_F_NOTIF_CONFIG_DATA has been
negotiated in the context of notifications the virtqueue is identified by
the virtqueue index (as usual, for example in queue_select, or in
the ccws).

As I've pointed out in my comment to patch 2, I believe replacing
virtqueue index with virtqueue number is detrimental to clarity.

Thus please find a counter-proposal below. If there is interest
I can make a series out of it, and prettify it. If I can't convince
you guys, then I will have to get used to vqn and virtqueue number.

AFAIR the other problem with index was the RSS for virtio-net. But there
we are currently heading down a direction of introducing a new
abstraction. This approach avoids confusion around the term 'virtqueue
index' as much as it avoids confusion around the term 'virtqueue nuber'.


> c. RSS area of virtio net has inherited some logic, describe it
> using abstract rss_rq_id.

-------------------------8<--------------------------------------
From: Halil Pasic <pasic@linux.ibm.com>
Date: Thu, 30 Mar 2023 17:57:53 +0200
Subject: [PATCH 1/1] content: clarify how virtques are identified

Clarify how virtqueues are identified in the context of
available notifications and in the context of RSS for
virtio-net .

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 content.tex                      | 15 ++++++++++-----
 device-types/net/description.tex | 30 ++++++++++++++++++++++--------
 transport-ccw.tex                |  2 +-
 transport-pci.tex                |  7 ++++---
 4 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/content.tex b/content.tex
index cff548a..a376232 100644
--- a/content.tex
+++ b/content.tex
@@ -298,6 +298,9 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
 virtqueues\footnote{For example, the simplest network device has one virtqueue for
 transmit and one for receive.}.
 
+If not otherwise stated, each virtqueue is identified by a so called virtqueue
+index. Valid virtqueue indexes range from 0 up to 65535.
+
 Driver makes requests available to device by adding
 an available buffer to the queue, i.e., adding a buffer
 describing the request to a virtqueue, and optionally triggering
@@ -402,7 +405,7 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 this notification involves sending the
-virtqueue number to the device (method depending on the transport).
+virtqueue index to the device (method depending on the transport).
 
 However, some devices benefit from the ability to find out the
 amount of available data in the queue without accessing the virtqueue in memory:
@@ -413,7 +416,9 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
 the following information:
 
 \begin{description}
-\item [vqn] VQ number to be notified.
+\item [vqn] Identifies the virtqueueue to be notified. If VIRTIO_F_NOTIF_CONFIG_DATA has been
+      negotiateted, the value of \field{vqn} is the notify data suplied by the device
+      (by transport specific means). Otherwise it is the virtqueue index.
 \item [next_off] Offset
       within the ring where the next available ring entry
       will be written.
@@ -786,13 +791,13 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
   buffer notifications.
   As mentioned in section \ref{sec:Basic Facilities of a Virtio Device / Driver notifications}, when the
   driver is required to send an available buffer notification to the device, it
-  sends the virtqueue number to be notified. The method of delivering
+  sends the virtqueue index of the virtqueue to be notified. The method of delivering
   notifications is transport specific.
   With the PCI transport, the device can optionally provide a per-virtqueue value
-  for the driver to use in driver notifications, instead of the virtqueue number.
+  for the driver to use in driver notifications, instead of the virtqueue index.
   Some devices may benefit from this flexibility by providing, for example,
   an internal virtqueue identifier, or an internal offset related to the
-  virtqueue number.
+  virtqueue index.
 
   This feature indicates the availability of such value. The definition of the
   data to be provided in driver notification and the delivery method is
diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index d7c8b1b..7678a57 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1421,18 +1421,33 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 
 \subparagraph{Setting RSS parameters}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / Setting RSS parameters}
 
+
 Driver sends a VIRTIO_NET_CTRL_MQ_RSS_CONFIG command using the following format for \field{command-specific-data}:
 \begin{lstlisting}
+
+struct rss_rq_id {
+   le16 value; /* virtqueue index divided by two */
+};
+
 struct virtio_net_rss_config {
     le32 hash_types;
     le16 indirection_table_mask;
-    le16 unclassified_queue;
-    le16 indirection_table[indirection_table_length];
+    struct rss_rq_id unclassified_queue;
+    struct rss_rq_id indirection_table[indirection_table_length];
     le16 max_tx_vq;
     u8 hash_key_length;
     u8 hash_key_data[hash_key_length];
 };
 \end{lstlisting}
+
+The type struct rss\_rq\_id is introduced to better distinguish receive queue
+ids form other integral fields.
+
+A receive queue id is only defined for receive queues, as the virtqueue index
+of the receive virtqueue divided by two (the virtqueue index of a receive
+queue is always even). For example receiveq4 is identified by the virtqueue
+index 6 and the receive queue id 3.
+
 Field \field{hash_types} contains a bitmask of allowed hash types as
 defined in
 \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}.
@@ -1442,10 +1457,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 \field{indirection_table} array.
 Number of entries in \field{indirection_table} is (\field{indirection_table_mask} + 1).
 
-Field \field{unclassified_queue} contains the 0-based index of
-the receive virtqueue to place unclassified packets in. Index 0 corresponds to receiveq1.
+Field \field{unclassified_queue} contains the receive queue id of the receive virtqueue to place unclassified packets in.
 
-Field \field{indirection_table} contains an array of 0-based indices of receive virtqueues. Index 0 corresponds to receiveq1.
+Field \field{indirection_table} contains an array of 0-based indices of receive queue ids.
 
 A driver sets \field{max_tx_vq} to inform a device how many transmit virtqueues it may use (transmitq1\ldots transmitq \field{max_tx_vq}).
 
@@ -1455,7 +1469,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 
 A driver MUST NOT send the VIRTIO_NET_CTRL_MQ_RSS_CONFIG command if the feature VIRTIO_NET_F_RSS has not been negotiated.
 
-A driver MUST fill the \field{indirection_table} array only with indices of enabled queues. Index 0 corresponds to receiveq1.
+A driver MUST fill the \field{indirection_table} array only with receive queue ids of enabled queues.
 
 The number of entries in \field{indirection_table} (\field{indirection_table_mask} + 1) MUST be a power of two.
 
@@ -1467,8 +1481,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 The device MUST determine the destination queue for a network packet as follows:
 \begin{itemize}
 \item Calculate the hash of the packet as defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets}.
-\item If the device did not calculate the hash for the specific packet, the device directs the packet to the receiveq specified by \field{unclassified_queue} of virtio_net_rss_config structure (value of 0 corresponds to receiveq1).
-\item Apply \field{indirection_table_mask} to the calculated hash and use the result as the index in the indirection table to get 0-based number of destination receiveq (value of 0 corresponds to receiveq1).
+\item If the device did not calculate the hash for the specific packet, the device directs the packet to the receiveq specified by \field{unclassified_queue} of virtio_net_rss_config structure.
+\item Apply \field{indirection_table_mask} to the calculated hash and use the result as the index in the indirection table to receive queue id of the destination receiveq.
 \item If the destination receive queue is being reset (See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the device MUST drop the packet.
 \end{itemize}
 
diff --git a/transport-ccw.tex b/transport-ccw.tex
index c492cb9..bc05639 100644
--- a/transport-ccw.tex
+++ b/transport-ccw.tex
@@ -544,7 +544,7 @@ \subsubsection{Guest->Host Notification}\label{sec:Virtio Transport Options / Vi
 \end{tabular}
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
-the \field{Notification data} contains the Virtqueue number.
+the \field{Notification data} contains the virtque index.
 
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
 the value has the following format:
diff --git a/transport-pci.tex b/transport-pci.tex
index b07a822..9b71c05 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -390,15 +390,16 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 
 \item[\field{queue_notify_data}]
         This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
-        The driver will use this value to put it in the 'virtqueue number' field
+        The driver will use this value to put it in the \field{vqn} field
         in the available buffer notification structure.
         See section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}.
         \begin{note}
         This field provides the device with flexibility to determine how virtqueues
         will be referred to in available buffer notifications.
-        In a trivial case the device can set \field{queue_notify_data}=vqn. Some devices
+        In a trivial case the device can set \field{queue_notify_data} to the virtqueue index,
+        that is the value in \field{queue\_select}. Some devices
         may benefit from providing another value, for example an internal virtqueue
-        identifier, or an internal offset related to the virtqueue number.
+        identifier, or an internal offset related to the virtqueue index.
         \end{note}
 
 \item[\field{queue_reset}]
-- 
2.31.1




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

