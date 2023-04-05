Return-Path: <virtio-dev-return-11991-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482C4C76188
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:07:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CE00B42A81
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:07:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4635098672C
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:07:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D713398661E; Wed,  5 Apr 2023 01:07:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7DED99865AB;
	Wed,  5 Apr 2023 01:07:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acKYxBjfF1GJo2cS09dLbw2eb0TRsnTb7weWMoRdmaGzS1l1OvmNfTZcG7tSgjJuprVivhOOpVBkgPmJ2BKl3g7D6dkZTSVPjc1t53qrvaI3uYMOWruLencNMxph3Yi09XN0YjVNPO7mGspBYb1amaWaClXCx+lwQNNvF3ZYMty/QCFC6P0dEmSAhROOUS4m6Kz36QzTdsOqVWmKacs5MlFIDP4EahpzhF2IVdEWbemz8AOh8dE4BI0MR5s/IzZJOcKPH+81WtaI8v/6iBdrjhIMnUYvwUZ6CScpSMazx+3TZtziyF9I2pH6utWHAnJ+2wmWLnimFazHtAq+PssyVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ik8pXQCMk+zQygmZPkJn6HZKdYWlsBWOyDfS2KncmWA=;
 b=O7MMVJUjcRtAfMeVT4mWNv67yUj/qqLH2OBl1F1vKE/YTJYakpMnzk7asswii2LHh9qNx1T9DpPj/rUFuHNG6JB4oxy/A0KCdoOSEjlWow/4XoMJv/A7PCLkrORnIoUA3topicssodplve4v7Xrc3DgGRThuxeorPWHSr2dhuxfQbq6ULTMw6n0I7MVUyFiuFRFr+F0cGO5iDhiKmLU4azYl9KO0oDEF18t7TTqPHCDlL+vGfVQNVY5PCi/NRlvS9Z7z40R5Wp4qG/SVe/EWuuFUERnjdNByqMBaJUpWtXkhyoSerKsm9pfttn+kT8HxSdh4NO+UG5WX2ltSKEYapQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <sgarzare@redhat.com>, <pasic@linux.ibm.com>,
	<virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Wed, 5 Apr 2023 04:06:50 +0300
Message-ID: <20230405010657.612529-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230405010657.612529-1-parav@nvidia.com>
References: <20230405010657.612529-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT042:EE_|MN2PR12MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e3478f-9441-4b9d-9bbf-08db35721e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zS6PQphDEl+cFa+yHAd0uU4NEG/KNcEgOu7vL8MMiAfG2vnNu6eyIVArYDafmN3GipwUxacfsWWqFmM3AvZXEQ3TWmVZplW/6vy8UPHWi76SQavzplVdDkZvDuUU/Jdli/bOJ7R9olvExfDsGzPCUddTpEJZ0PE50ERAtLzMuKH4j6niKiPLsv3AaM6STkLPfUSYSl+HhFQLwVaP775uJ0MG2p2zGMFugmkoWJ8sHobx+2dIZ79MBoUzM695MVxyJd+6XJ2DitCmJJDetObwSfTsRKoGbaWb2+frWCiMWTZgq//QzO5K5BaFn9jCqJPUxHIiKKbSkZ+U1iPIezVMmxCc6vz3sdkBEGjuQF5INtRvYrH7aul59cC4QflGimWznUtXwbLQq21e0AYfoFZt4FVS2JOTFK1G+zc3vmu3695+wWCF4SgmUCEOQrfiC5IDzAViH92/O9BSaSMmpDj5FiYTnPdA5iX6eqekOL02m2G5sqdNs9399oxaHn7ey/o3yDVJVa6JrH3aUAgFa6oN0IA1IcYzXKPyxd0+h9+GUcZ0rNwGTVPp3Osx6N1xwpKYsZeYsk0Xi9Y5G5L4zTCfSRK9/MbswTag2cWpC+/2jGIFnr/XOPxveN9+vObC3NIs+CfR8U0KGWdFa+X5kyUz3wj2rdTxGJfWvcOMOi9a4TWMi5X8wONjmWjzERAziaShIIPN3xwQBJy2NMytd6O2yi7WnadgzCcTeSsrBNlZqrOZtaGQ2TiYLwqL6972PRfd
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(478600001)(110136005)(54906003)(70586007)(316002)(70206006)(8676002)(16526019)(336012)(1076003)(26005)(186003)(36756003)(40480700001)(40460700003)(2616005)(47076005)(83380400001)(2906002)(4326008)(82310400005)(107886003)(6666004)(36860700001)(7636003)(356005)(86362001)(426003)(41300700001)(8936002)(82740400003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 01:07:25.0293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e3478f-9441-4b9d-9bbf-08db35721e31
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
Subject: [virtio-dev] [PATCH v12 03/10] content: Rename confusing queue_notify_data and vqn names

Currently queue_notify_data register indicates the device
internal queue notification identifier. This register is
meaningful only when feature bit VIRTIO_F_NOTIF_CONFIG_DATA is
negotiated.

However, above register name often get confusing association with
very similar feature bit VIRTIO_F_NOTIFICATION_DATA.

When VIRTIO_F_NOTIFICATION_DATA feature bit is negotiated,
notification really involves sending additional queue progress
related information (not queue identifier).

Hence
1. to avoid any misunderstanding and association of
queue_notify_data with similar name VIRTIO_F_NOTIFICATION_DATA,

and
2. to reflect that queue_notify_data is the actual device
internal vq identifier, rename it to queue_notify_id.

Reflect vq identifier in the driver notification structure by renaming
ambiguous vqn to vq_notify_id.

The driver notification section assumes that queue notification contains
vq index always. CONFIG_DATA feature bit introduction missed to
update the driver notification section. Hence, correct it.

Signed-off-by: Parav Pandit <parav@nvidia.com>

---
Some side notes:
renaming vqn to vqnd is even more confusing because data is really the
queue identifier.

And NOTIFICATION_DATA really contains queue progress info (data).

(vqn - n is number or notification?, notification word in the
notification structure does not make sense).

Hence above renaming.

---
changelog:
v11->v12:
- new patch
---
 content.tex        | 17 ++++++++++++++---
 notifications-be.c |  2 +-
 notifications-le.c |  2 +-
 transport-pci.tex  | 24 ++++++++++++++----------
 4 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/content.tex b/content.tex
index cd93db2..d5f8026 100644
--- a/content.tex
+++ b/content.tex
@@ -405,8 +405,18 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
 notification to the device.
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
-this notification involves sending the
-virtqueue index to the device (method depending on the transport).
+this notification involves sending only the 16-bit virtqueue notification
+identifier (notification method depends on the transport).
+
+\begin{itemize}
+\item When VIRTIO_F_NOTIF_CONFIG_DATA is not negotiated, virtqueue
+notification identifier is a 16-bit vq index.
+
+\item When VIRTIO_F_NOTIF_CONFIG_DATA is negotiated, virtqueue
+notification identifier is a device supplied virtqueue identifier. A method
+to supply such virtqueue notification identifier is transport
+specific.
+\end{itemize}
 
 However, some devices benefit from the ability to find out the
 amount of available data in the queue without accessing the virtqueue in memory:
@@ -417,7 +427,8 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
 the following information:
 
 \begin{description}
-\item [vqn] VQ number to be notified.
+\item [vq_notify_id] VQ notification identifier of a
+      corresponding virtqueue.
 \item [next_off] Offset
       within the ring where the next available ring entry
       will be written.
diff --git a/notifications-be.c b/notifications-be.c
index 5be947e..0a7cbf1 100644
--- a/notifications-be.c
+++ b/notifications-be.c
@@ -1,5 +1,5 @@
 be32 {
-	vqn : 16;
+	vq_notify_id : 16; /* previously known as vqn */
 	next_off : 15;
 	next_wrap : 1;
 };
diff --git a/notifications-le.c b/notifications-le.c
index fe51267..6cca8fb 100644
--- a/notifications-le.c
+++ b/notifications-le.c
@@ -1,5 +1,5 @@
 le32 {
-	vqn : 16;
+	vq_notify_id : 16; /* previously known as vqn */
 	next_off : 15;
 	next_wrap : 1;
 };
diff --git a/transport-pci.tex b/transport-pci.tex
index 5d98467..6bbf61c 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -319,7 +319,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         le64 queue_desc;                /* read-write */
         le64 queue_driver;              /* read-write */
         le64 queue_device;              /* read-write */
-        le16 queue_notify_data;         /* read-only for driver */
+        le16 queue_notify_id;           /* read-only for driver */
         le16 queue_reset;               /* read-write */
 };
 \end{lstlisting}
@@ -388,17 +388,21 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 \item[\field{queue_device}]
         The driver writes the physical address of Device Area here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
 
-\item[\field{queue_notify_data}]
+\item[\field{queue_notify_id}]
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
+        In a trivial case the device can set \field{queue_notify_id} to
+        vq index. Some devices may benefit from providing another value,
+        for example an internal virtqueue identifier, or an internal offset
+        related to the virtqueue index.
+        \end{note}
+        \begin{note}
+        This field is previously known as queue_notify_id.
         \end{note}
 
 \item[\field{queue_reset}]
@@ -468,7 +472,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 
 \drivernormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
 
-The driver MUST NOT write to \field{device_feature}, \field{num_queues}, \field{config_generation}, \field{queue_notify_off} or \field{queue_notify_data}.
+The driver MUST NOT write to \field{device_feature}, \field{num_queues}, \field{config_generation}, \field{queue_notify_off} or \field{queue_notify_id}.
 
 If VIRTIO_F_RING_PACKED has been negotiated,
 the driver MUST NOT write the value 0 to \field{queue_size}.
@@ -1053,9 +1057,9 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
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

