Return-Path: <virtio-dev-return-12288-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E9DC77B7E
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3CD357DD82
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 375BA986615
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2804998641F; Wed, 19 Apr 2023 01:47:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 14645986413;
	Wed, 19 Apr 2023 01:47:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKtrCtUtB2ERJjX82QgJpOnMUEiKfQZlWonyf2sznicADYUMIogU/hUJljIdoN4ojXQX2FX9sBQhLo9ZI7cnEdkPhBsQeWUYnxAHwdrQT+NQMKlWq/DiR83dsz7aXawB41TfXoT8vqB0rDcnrpTyz9RppOENMUWQisLlaJQrGPUXsZplaByJ3rFgbjV5Iv3mj9UbFOj08F/N/4xmgxz433W4z2XgWHQUWowgKQtk/2vhDHS07bjxaaIQJvGavqpcXeMOLOdQq5X80eucP7+noJUhRRaGYlN1LOre9WB7DCdgEf/N3XmMizGcHEwlx02oeAnaNZcBKMUQHalKZiLukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChoYYDpdeV1HrVZFZ9nN/yAUQ0Ob0bxPkE5OOsSa7TE=;
 b=kQHdgCQgpR/oG7YRGuQC/VSeb4EYBVMZpVPnDH6EdPZCkZZQdAFjdJrvufgMNkBmf6BFYE6IxkaN5WXzXjxchgGKPt0nG/oXAB3i0edhbv+0MrP4Fe396EML0CEg6Zle2+vZH9/c0Okk3p07D6lhxuuDbBrOenEKYQjADg98shHpxnARf9AhANV8vA6Rj6sHWN+pOT9WxPlQdMUDkKvBH9QaaCH4yiATg6hAPWlNWiUhc3RZ5p7/CfRCLDhEQX+Te9hTwyhBpWcrLVFkAMKkudwaVSaLIANXQWCi0KqPYsV+v/Sab6PVoK3p8n48QaPwMHHteKTsoqFbhGhRk59Ckw==
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
Date: Wed, 19 Apr 2023 04:46:31 +0300
Message-ID: <20230419014639.919458-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230419014639.919458-1-parav@nvidia.com>
References: <20230419014639.919458-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|SN7PR12MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b210d1-55c5-4572-aa0e-08db4077fa5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3eI4qG/6K0YtnghPn2m8xVEmuXnFQ0XeAYID4MggysXGG58GoKbZ6lX9Qxb9q5fTUxJS/bLjP9Ib7k6t/TEXz8/+bnP7+37OPzswnyaYlZBnBmV+cIhjD8BLGF3lPe27IUULMyX1ZopmrPdo6f0qNK3+F3MpfX2sMaprfYJrGjQZNSVZlqWf0FdHXdcgMjjxZLgOQ37vF/QfF0pmzHiJIMac0RtJGqLBl3YfWd5ngSo84r20tTTEHFpw2o/R5JdK33jDKPKXsVWsw7g+0sohh77sxyxTVQrgVPU2VH2Wd3HMpKQR0043LIly3vloBVhADO1neG9Es+0WbQ4v0qgppMkkLArI4I4Utx4rNbNL6j3MhQkMjgZpmpYLqUpBUKojBbDz0XLS7WC7waAtBAIe7YX/9rBZzY2o4VbL+SpPmdZraVPvRWd5RGAsOakpmEkMrjPVr1ZZ10z4Vfb0EygDJ3yZLg8hSB8eAmyYF5quSHiAeDYLukcc5R9f1sAH1ar9CA7anPodqVHbw3eEJ9h/PmYUA41HZLyOzZDHDpD5tP3eScr4YujyBRRXKRKWwnHi5aBt/WNDyFq+s4/7A86FmeDsqitSx7IfBqpyrzbpY+HOJbq9CfLXid13FkUjiPWLQjg+1FI1EqxjTHd49FyMlIgQO2nG31CU/ELS66q3/dWwg0Pxb0C4BjgQpSZ9UBT5rJ3nIkzqw/UGUxTkujFuzc2bV0cBHG4TKA9LXgxQIlNOtJupBrIWzW9wri44b37r9z6+rTMFHTCQ3AOpW/NCvB8jGEDuHAFmaOyTwLPMYk2Bvs5zMMCKKWFAFIMjhma2MLZHy7VukrI6ngFOsW8NwQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(26005)(107886003)(1076003)(186003)(40460700003)(110136005)(82310400005)(16526019)(41300700001)(34070700002)(54906003)(426003)(40480700001)(86362001)(336012)(2616005)(47076005)(83380400001)(4326008)(316002)(70206006)(70586007)(36860700001)(8676002)(8936002)(2906002)(6666004)(966005)(7636003)(356005)(36756003)(82740400003)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 01:47:04.7354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b210d1-55c5-4572-aa0e-08db4077fa5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7883
Subject: [virtio-dev] [PATCH v14 03/11] content: Rename confusing queue_notify_data and vqn names

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
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
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
 content.tex            | 11 +++++--
 notifications-be.c     |  2 +-
 notifications-le.c     |  2 +-
 notifications-pci-le.c |  8 +++++
 transport-pci.tex      | 72 +++++++++++++++++++++++++++++++-----------
 5 files changed, 71 insertions(+), 24 deletions(-)
 create mode 100644 notifications-pci-le.c

diff --git a/content.tex b/content.tex
index e79d722..e1345ea 100644
--- a/content.tex
+++ b/content.tex
@@ -404,8 +404,12 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
 notification to the device.
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
-this notification involves sending the
-virtqueue index to the device (method depending on the transport).
+this notification contains either virtqueue index if VIRTIO_F_NOTIF_CONFIG_DATA
+is not negotiated or device supplied virtqueue notification config data if
+VIRTIO_F_NOTIF_CONFIG_DATA is negotiated.
+
+A notification method and suppling such virtqueue notification config data is
+transport specific.
 
 However, some devices benefit from the ability to find out the
 amount of available data in the queue without accessing the virtqueue in memory:
@@ -416,7 +420,8 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
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
diff --git a/notifications-pci-le.c b/notifications-pci-le.c
new file mode 100644
index 0000000..ef60d15
--- /dev/null
+++ b/notifications-pci-le.c
@@ -0,0 +1,8 @@
+le32 {
+	union {
+		vq_index: 16; /* Used if VIRTIO_F_NOTIF_CONFIG_DATA not negotiated */
+		vq_notif_config_data: 16; /* Used if VIRTIO_F_NOTIF_CONFIG_DATA negotiated */ 
+	};
+	next_off : 15;
+	next_wrap : 1;
+};
diff --git a/transport-pci.tex b/transport-pci.tex
index 5d98467..04a9a80 100644
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
+\item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver sends an
+available buffer notification to the device by writing the following 32-bit
+value to the Queue Notify address:
+\lstinputlisting{notifications-pci-le.c}
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
@@ -1050,12 +1065,31 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
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
+notification value to virtqueue index.
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
+\item If VIRTIO_F_NOTIFICATION_DATA is not negotiated, the driver MUST set the
+\field{vq_notify_config_data} to the \field{queue_notif_config_data}
+value.
 \end{itemize}
 
 \subsubsection{Used Buffer Notifications}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Used Buffer Notifications}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

