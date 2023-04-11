Return-Path: <virtio-dev-return-12135-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A33C76196
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 131EB68496
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F2E60986656
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E6ABB9863A4; Tue, 11 Apr 2023 19:24:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CEEB99865F5;
	Tue, 11 Apr 2023 19:24:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C88tABUAEZljp1qLZDi9k54MAZ4yPCYbQ2Bf9gKEeR0ULcLNqP5uuKHsAgI45CdB0o+f+8NzDVoAU2Sff40yiXFEvmsqr00CiaEp/YBxlk3ihn59qAvR3kB+id5DbUrBfRPUpOUmYadQx3jIDmAsuAVJKYxBlM8aFAhvEiko5/LI5uyUkK6vcvoW8NATSZuuGwcfUHAHiV51cr61lonAVPjl4P9wkambpDyLwVmi9OoloVjdn4Nmqvq2KRddYXQcu8gRYCZo2qYlcRVf60321zcIm5WPmoxL904v0mLwDrByb97rCELKf/Qb65iJR7WPUYY7jzEv//2h2al/kePjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsHn0Q73aaYyPZeGZBS/OCdv9JoeHl0Q4BWPx/ykhvI=;
 b=BAhunyswdlkNNjRCovOgTG9SzuJbHDBgDZwtUS9Ws7bp6aHZCxPbhtYn/u7w+Cx9AtEghlnU1VSUIGY9l7YAMqSSWuujI0bhp2+TC+ZbPxVS9EPj4hFOMjqQc+p0uF4237qIF/ZDBytVjkxNiJ9JB57hKrFf6YxCkjuNg7z/Q4vvkeq0UgRhUMktWL3bZrt8Iw9wuxG1GuY1BCHRp9/Fgc6r7ia0nhH6iIGgYNrPeh+Re22hSOxvLeMX5egVGvseFqxf9D0+bljJ3DVqRJ1+aK+ZGPeSo7KfrIwUDBRAS1z3anhXI/Ac5H3yH+6LlyshCP5rGS0zGsSBAJ553m1tDw==
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
	<virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Tue, 11 Apr 2023 22:23:33 +0300
Message-ID: <20230411192341.751841-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230411192341.751841-1-parav@nvidia.com>
References: <20230411192341.751841-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT098:EE_|MN0PR12MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2dbecf-967d-4346-e88f-08db3ac25192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gRRCHswdAFeHMXmrG1noRz4u+l1lm9ffyaNW4bwFZq7K3oJfXTmPD+M92Mj62i+TuT9OL+amGNWkz60UCzkMOH4xtp4/k3mU8jn+U4YUTDPvrQLnQWm/Ee7ef1+vNVEnZDLGNzhdtlfVMwyLInP6i8seY+dZJKDZE8gSopcnepBTvZNEnJy679rJ67Z853sRnINwBRsZrEPrUx9kCoZIC6DOM2pVqktj3uwGXh0XG9+t1Nwwq8MgkB/cJTOUsoL43l01J4oORXr7MSNTmS/0sy52+c6rX7SOwKfHBIn9JzH8IWQejsILq5or6lxIGpvntw4JPDkzhLUCBgAf/Hjl39jQIlPmIYlCXdDjPFv762ra4yWCXzXgSJ9dnTROi/yaaz9MqWnWRj4+oqus9B3giaqagkoEfsPRsCTiOK/aUCLCQQ7HHXqgBm2rjIDWHuEomkltj5ybBstphcUVLlGoHUHX9mYs9R+Bc+SVVjhDxIFegiMuq24YXq8OdBFdK0M4uOUBKQjuBaJMsbi1YlWnMU7ZQTT0moF7Z4ybetj4SMjd/y6Da/iXbCj6BRi5haizVGVkRSJLECenVbDPMftnVppu/1MRRytr6uM4jj0RHma3vMzWuFObKi/S3itDIdPqKQed2OXvsKArMBzj9vMoVUbftMNMv36O6nGPyYbVLVv3BlLo3odzvfOUQvyHP5DL5jH0W4PKdcg89NYb1Zi3hW9Yfn/jvao0gpPZwdk/3OBU06CZMYtRhyVuMDm7sCBzrPzY5XbfFViupLp8z5wLfvun+6MxSE7ltlkmWwNfRCc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(36756003)(86362001)(110136005)(316002)(41300700001)(8676002)(70206006)(70586007)(4326008)(54906003)(478600001)(82310400005)(5660300002)(40480700001)(2906002)(8936002)(36860700001)(34070700002)(7636003)(82740400003)(356005)(16526019)(186003)(6666004)(1076003)(107886003)(26005)(336012)(2616005)(426003)(47076005)(83380400001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 19:24:06.8768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2dbecf-967d-4346-e88f-08db3ac25192
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
Subject: [virtio-dev] [PATCH v13 03/11] content: Rename confusing queue_notify_data and vqn names

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

a. rename queue_notify_data to queue_notify_config_data.
queue_notify_config_data.

b. rename ambiguous vqn to a union of vq_index and vq_config_data

c. The driver notification section assumes that queue notification contains
vq index always. CONFIG_DATA feature bit introduction missed to
update the driver notification section. Hence, correct it.

Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v12->v13:
- replace _id with _config_data
- dropped vq identifier
- dropped the idea of union as description is for config data feature
v11->v12:
- new patch
---
 content.tex        | 11 ++++++++---
 notifications-be.c |  2 +-
 notifications-le.c |  2 +-
 transport-pci.tex  | 26 ++++++++++++++++----------
 4 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/content.tex b/content.tex
index e79d722..601c069 100644
--- a/content.tex
+++ b/content.tex
@@ -404,8 +404,12 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
 notification to the device.
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
-this notification involves sending the
-virtqueue index to the device (method depending on the transport).
+this notification contains either virtqueue
+index if VIRTIO_F_NOTIF_CONFIG_DATA is not negotiated or device
+supplied virtqueue notification data if
+VIRTIO_F_NOTIF_CONFIG_DATA is negotiated.
+
+A method to supply such virtqueue notification data is transport specific.
 
 However, some devices benefit from the ability to find out the
 amount of available data in the queue without accessing the virtqueue in memory:
@@ -416,7 +420,8 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
 the following information:
 
 \begin{description}
-\item [vqn] VQ number to be notified.
+\item [vq_index_config_data] either virtqueue index or device supplied
+      queue notification config data corresponding to a virtqueue.
 \item [next_off] Offset
       within the ring where the next available ring entry
       will be written.
diff --git a/notifications-be.c b/notifications-be.c
index 5be947e..02f0624 100644
--- a/notifications-be.c
+++ b/notifications-be.c
@@ -1,5 +1,5 @@
 be32 {
-	vqn : 16;
+	vq_config_data: 16; /* previously known as vqn */
 	next_off : 15;
 	next_wrap : 1;
 };
diff --git a/notifications-le.c b/notifications-le.c
index fe51267..f73c6a5 100644
--- a/notifications-le.c
+++ b/notifications-le.c
@@ -1,5 +1,5 @@
 le32 {
-	vqn : 16;
+	vq_config_data: 16; /* previously known as vqn */
 	next_off : 15;
 	next_wrap : 1;
 };
diff --git a/transport-pci.tex b/transport-pci.tex
index 5d98467..53c8ee6 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -319,7 +319,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         le64 queue_desc;                /* read-write */
         le64 queue_driver;              /* read-write */
         le64 queue_device;              /* read-write */
-        le16 queue_notify_data;         /* read-only for driver */
+        le16 queue_notify_config_data;  /* read-only for driver */
         le16 queue_reset;               /* read-write */
 };
 \end{lstlisting}
@@ -388,17 +388,21 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 \item[\field{queue_device}]
         The driver writes the physical address of Device Area here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
 
-\item[\field{queue_notify_data}]
+\item[\field{queue_notify_config_data}]
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
+        In a trivial case the device can set \field{queue_notify_config_data} to
+        virtqueue index. Some devices may benefit from providing another value,
+        for example an internal virtqueue identifier, or an internal offset
+        related to the virtqueue index.
+        \end{note}
+        \begin{note}
+        This field is previously known as queue_notify_data.
         \end{note}
 
 \item[\field{queue_reset}]
@@ -468,7 +472,9 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 
 \drivernormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
 
-The driver MUST NOT write to \field{device_feature}, \field{num_queues}, \field{config_generation}, \field{queue_notify_off} or \field{queue_notify_data}.
+The driver MUST NOT write to \field{device_feature}, \field{num_queues},
+\field{config_generation}, \field{queue_notify_off} or
+\field{queue_notify_config_data}.
 
 If VIRTIO_F_RING_PACKED has been negotiated,
 the driver MUST NOT write the value 0 to \field{queue_size}.
@@ -1053,9 +1059,9 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 If VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
 \begin{itemize}
 \item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the driver MUST use the
-\field{queue_notify_data} value instead of the virtqueue index.
+\field{queue_notify_id} value instead of the virtqueue index.
 \item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver MUST set the
-\field{vqn} field to the \field{queue_notify_data} value.
+\field{vq_notify_id} field to the \field{queue_notify_id} value.
 \end{itemize}
 
 \subsubsection{Used Buffer Notifications}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Used Buffer Notifications}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

