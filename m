Return-Path: <virtio-dev-return-12535-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019E8C77B7F
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:30:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0A8952CAF7
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:30:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 03E2D9866B3
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:30:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ED1879862A9; Thu,  4 May 2023 02:30:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 809429866A4;
	Thu,  4 May 2023 02:30:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gy+wUfBa5mt2Bh+c5aC9iZFlVZLrU7zoFDPXx6ruo0YrYRA0X2jN9rNsgKkNo6Garnnuz+sk836uyNptW32BvZkgfGnSolBHlA+jC17Z5e/CYg2HHHZS+SvxWGjh6oClzpm62QdynfcVdrWvDeVTtQjZInVonlz9nDlM/fH5sDPgbhcfNNyW5JdOajRjkGszZdFbHpgxiD+KrOrdr3+WGcHr4klso+OQKZBjEItAs99ZsrtBBbG4n2iSKB6y8MuO0icB/fZiP8ssA3eadsLR2Wk9p4twYbd1euWSJrDAVsmPznxAKwYX4blOrhu50aQ0n2CS+Zq5TdRO6EDZ0Q6rnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyo1DqDEshpt6q5+Uzidmbm2oRPO7HWFPkEQn13eUuI=;
 b=Qqmj82QRlRESFSLI5llxTSd9VyHfHGqMACwLPtr8RzBH8CArzle7FVAM+pMuYULqlVpBS+bBeAbH3opMij54BxMPznEc7dCfRxm7E+LS8rJT30jNQbcLO0GQcFURQGVyBi/EQMVZxX/KnAINuWaonPe0a7QzKucQo/ExJyBCNynIcwsDkML2G+m2hZJdAkpA2jkZf7xjslzqzgEotcHRxsUDdBLmZzIOXT2U5etpjfZ0R0Clfs8hKQvVgQW/95L5THrFQnCL45xuF9BRG80rnmsS4mM9YhV8p4YUDQXnMoZn5qvf18CBl+R5N5/dr10SGKXl5uo3xkwJXTXOHYBxbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <sgarzare@redhat.com>, <pasic@linux.ibm.com>,
	<david.edmondson@oracle.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Thu, 4 May 2023 05:29:51 +0300
Message-ID: <20230504022959.547025-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230504022959.547025-1-parav@nvidia.com>
References: <20230504022959.547025-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT087:EE_|BL1PR12MB5288:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd71c7c-75ec-4f15-43f0-08db4c4787c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x3Uvhv6WiwqmKVd5pXTn8pq/+vPA8sR9aoqLe91JpvtsTjnI37WcpGNO8yOZBv6Q2KDzE7vwplF+yyof3LlPIg8ju7nn6MDmdF0Lj2O9GV39yoUQSRjesUY2NO2z5VoZxwhSULZyyD35Z1FPOxz5/z5ty5fQbYuTptSocfTVIM0ztEgwrBiheA1c0HN0ew02r6YlXV+1iTcwKjI3ZzmmmofrXHltdvgZmXGp/QQ2j7Ab98ZX4LhX85nV+rmVXVzl891T2R1QlHslHNA8Xvj8792lYp3bub9ge02nnCil1UTNFTirJntFfy1PMQ6/7oR3I8rsWTL3T67m105XZa6yUqFRHW+bjOawSt4zxCO8HDH1Kqb/cuTJfcl9P1PjLhLZqROrGOA/nMc9f5yq9DcKYVz54Mi31Yxcg9P3DXqeHlDpPrUxiEQndNXfKMnYtHnWUpYeb9Zwkw4/0FfaTTmMDzwtZAsQM35Ve1fQA6k98/mss+1aHLc2ToOyimNrWqk7PLJOCUhh2LYcreoLsy9CWdHrjSU3fCGfLGhbRlCKoDRl9BgoJa/5QBcbY+hoBSdZvteyExOyCWKRDqqwWULK041V2Nq2JxOaayUBhx6MY/pvwBGnCT/0Ud5d0Vm+aHIcfQ5Vu1M81FZGA3P8+iVkoep5kjt3ZZezp6Ra/i345w2XkwjP5FoIQAm3oCt/Nwxey69rx8i4KsOnHws/YUsV7B23PXHIWSEpLmj3Yjx23AAW/SPNAtauMPbrvP2+drui
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(7636003)(82740400003)(356005)(30864003)(40460700003)(8936002)(2906002)(5660300002)(8676002)(36756003)(82310400005)(86362001)(40480700001)(36860700001)(6666004)(966005)(47076005)(478600001)(110136005)(54906003)(186003)(1076003)(26005)(16526019)(336012)(426003)(2616005)(107886003)(83380400001)(41300700001)(70206006)(70586007)(4326008)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 02:30:30.6401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd71c7c-75ec-4f15-43f0-08db4c4787c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
Subject: [virtio-dev] [PATCH v16 03/11] content: Rename confusing queue_notify_data and vqn names

Currently queue_notify_data register indicates the device
internal queue notification content. This register is
meaningful only when feature bit VIRTIO_F_NOTIF_CONFIG_DATA is
negotiated.

However, above register name often get confusing association with
very similar feature bit VIRTIO_F_NOTIFICATION_DATA.

When VIRTIO_F_NOTIFICATION_DATA feature bit is negotiated,
notification really involves sending additional queue progress
related information (not queue identifier or index).

Hence
1. to avoid any misunderstanding and association of
queue_notify_data with similar name VIRTIO_F_NOTIFICATION_DATA,

and
2. to reflect that queue_notify_data is the actual device
internal virtqueue identifier/index/data/cookie,

a. rename queue_notify_data to queue_notif_config_data.

b. rename ambiguous vqn to a union of vq_index and vq_config_data

c. The driver notification section assumes that queue notification contains
vq index always. CONFIG_DATA feature bit introduction missed to
update the driver notification section. Hence, correct it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v15->v16:
- fixed adding article
- replaced is with was
- fixed incorrect type of 'not'
v14->v15:
- fixed white spaces at the end of lines
- fixed next listed comments from Michael and Halil
- renamed notifications-pci-le.c to notifications-data-le.c
- removed unwanted \item tag
v13->v14:
- added pci transport specific union structure
- added normative lines for case when VIRTIO_F_NOTIF_CONFIG_DATA
  is not negotiated.
- added normataive lines for clarify bit-width for driver notification
- replace left over _id with _config_data
- use _notif_config_data name to align to feature name
v12->v13:
- replace _id with _config_data
- dropped vq identifier
- dropped the idea of union as description is for config data feature
v11->v12:
- new patch
---
 content.tex             | 11 +++++--
 notifications-be.c      |  2 +-
 notifications-data-le.c |  8 +++++
 notifications-le.c      |  2 +-
 transport-pci.tex       | 71 ++++++++++++++++++++++++++++++-----------
 5 files changed, 70 insertions(+), 24 deletions(-)
 create mode 100644 notifications-data-le.c

diff --git a/content.tex b/content.tex
index 9cf938c..8c5b07a 100644
--- a/content.tex
+++ b/content.tex
@@ -405,8 +405,12 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
 notification to the device.
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
-this notification involves sending the
-virtqueue index to the device (method depending on the transport).
+this notification contains either a virtqueue index if
+VIRTIO_F_NOTIF_CONFIG_DATA is not negotiated or device supplied virtqueue
+notification config data if VIRTIO_F_NOTIF_CONFIG_DATA is negotiated.
+
+The notification method and suppling any such virtqueue notification config data
+is transport specific.
 
 However, some devices benefit from the ability to find out the
 amount of available data in the queue without accessing the virtqueue in memory:
@@ -417,7 +421,8 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
 the following information:
 
 \begin{description}
-\item [vqn] VQ number to be notified.
+\item [vq_index_config_data] Either virtqueue index or device supplied
+      queue notification config data corresponding to a virtqueue.
 \item [next_off] Offset
       within the ring where the next available ring entry
       will be written.
diff --git a/notifications-be.c b/notifications-be.c
index 5be947e..bf6d1cd 100644
--- a/notifications-be.c
+++ b/notifications-be.c
@@ -1,5 +1,5 @@
 be32 {
-	vqn : 16;
+	vq_index: 16; /* previously known as vqn */
 	next_off : 15;
 	next_wrap : 1;
 };
diff --git a/notifications-data-le.c b/notifications-data-le.c
new file mode 100644
index 0000000..3ee80e4
--- /dev/null
+++ b/notifications-data-le.c
@@ -0,0 +1,8 @@
+le32 {
+	union {
+		vq_index: 16; /* Used if VIRTIO_F_NOTIF_CONFIG_DATA not negotiated */
+		vq_notif_config_data: 16; /* Used if VIRTIO_F_NOTIF_CONFIG_DATA negotiated */
+	};
+	next_off : 15;
+	next_wrap : 1;
+};
diff --git a/notifications-le.c b/notifications-le.c
index fe51267..8a19389 100644
--- a/notifications-le.c
+++ b/notifications-le.c
@@ -1,5 +1,5 @@
 le32 {
-	vqn : 16;
+	vq_index: 16; /* previously known as vqn */
 	next_off : 15;
 	next_wrap : 1;
 };
diff --git a/transport-pci.tex b/transport-pci.tex
index 524bfff..aa9842f 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -319,7 +319,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         le64 queue_desc;                /* read-write */
         le64 queue_driver;              /* read-write */
         le64 queue_device;              /* read-write */
-        le16 queue_notify_data;         /* read-only for driver */
+        le16 queue_notif_config_data;   /* read-only for driver */
         le16 queue_reset;               /* read-write */
 };
 \end{lstlisting}
@@ -388,17 +388,21 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 \item[\field{queue_device}]
         The driver writes the physical address of Device Area here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
 
-\item[\field{queue_notify_data}]
+\item[\field{queue_notif_config_data}]
         This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
-        The driver will use this value to put it in the 'virtqueue number' field
-        in the available buffer notification structure.
+        The driver will use this value when driver sends available buffer
+        notification to the device.
         See section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}.
         \begin{note}
         This field provides the device with flexibility to determine how virtqueues
         will be referred to in available buffer notifications.
-        In a trivial case the device can set \field{queue_notify_data}=vqn. Some devices
-        may benefit from providing another value, for example an internal virtqueue
-        identifier, or an internal offset related to the virtqueue number.
+        In a trivial case the device can set \field{queue_notif_config_data} to
+        the virtqueue index. Some devices may benefit from providing another value,
+        for example an internal virtqueue identifier, or an internal offset
+        related to the virtqueue index.
+        \end{note}
+        \begin{note}
+        This field was previously known as queue_notify_data.
         \end{note}
 
 \item[\field{queue_reset}]
@@ -468,7 +472,9 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 
 \drivernormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
 
-The driver MUST NOT write to \field{device_feature}, \field{num_queues}, \field{config_generation}, \field{queue_notify_off} or \field{queue_notify_data}.
+The driver MUST NOT write to \field{device_feature}, \field{num_queues},
+\field{config_generation}, \field{queue_notify_off} or
+\field{queue_notif_config_data}.
 
 If VIRTIO_F_RING_PACKED has been negotiated,
 the driver MUST NOT write the value 0 to \field{queue_size}.
@@ -1035,13 +1041,22 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 the driver sends an available buffer notification to the device by writing
-the 16-bit virtqueue index
-of this virtqueue to the Queue Notify address.
+only the 16-bit notification value to the Queue Notify address of the
+virtqueue. A notification value depends on the negotiation of
+VIRTIO_F_NOTIF_CONFIG_DATA.
 
-When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
-the driver sends an available buffer notification to the device by writing
-the following 32-bit value to the Queue Notify address:
-\lstinputlisting{notifications-le.c}
+If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver sends an
+available buffer notification to the device by writing the following 32-bit
+value to the Queue Notify address:
+\lstinputlisting{notifications-data-le.c}
+
+\begin{itemize}
+\item When VIRTIO_F_NOTIF_CONFIG_DATA is not negotiated \field{vq_index} is set
+to the virtqueue index.
+
+\item When VIRTIO_F_NOTIFICATION_DATA is negotiated,
+\field{vq_notif_config_data} is set to \field{queue_notif_config_data}.
+\end{itemize}
 
 See \ref{sec:Basic Facilities of a Virtio Device / Driver notifications}~\nameref{sec:Basic Facilities of a Virtio Device / Driver notifications}
 for the definition of the components.
@@ -1050,12 +1065,30 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 for how to calculate the Queue Notify address.
 
 \drivernormative{\paragraph}{Available Buffer Notifications}{Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}
-If VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
+
+If VIRTIO_F_NOTIFICATION_DATA is not negotiated, the driver notification
+MUST be a 16-bit notification.
+
+If VIRTIO_F_NOTIFICATION_DATA is negotiated, the driver notification
+MUST be a 32-bit notification.
+
+If VIRTIO_F_NOTIF_CONFIG_DATA is not negotiated:
+\begin{itemize}
+\item If VIRTIO_F_NOTIFICATION_DATA is not negotiated, the driver MUST set the
+notification value to the virtqueue index.
+
+\item If VIRTIO_F_NOTIFICATION_DATA is negotiated, the driver MUST set the
+\field{vq_index} to the virtqueue index.
+
+\end{itemize}
+
+If VIRTIO_F_NOTIF_CONFIG_DATA is negotiated:
 \begin{itemize}
-\item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the driver MUST use the
-\field{queue_notify_data} value instead of the virtqueue index.
-\item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver MUST set the
-\field{vqn} field to the \field{queue_notify_data} value.
+\item If VIRTIO_F_NOTIFICATION_DATA is not negotiated, the driver MUST set
+the notification value to \field{queue_notif_config_data}.
+
+\item If VIRTIO_F_NOTIFICATION_DATA is negotiated, the driver MUST set the
+\field{vq_notify_config_data} to the \field{queue_notif_config_data} value.
 \end{itemize}
 
 \subsubsection{Used Buffer Notifications}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Used Buffer Notifications}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

