Return-Path: <virtio-dev-return-11737-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9170AC6FD1C
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:00:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 311EA157F1C
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:00:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 87B399864D2
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:00:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1A98F986767; Thu, 23 Mar 2023 01:00:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6588F986460;
	Thu, 23 Mar 2023 01:00:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k917NIAaYepwPM2JJbKtiAb58fGZGpCCNqEoS+zqVqWFCchluzC47zCZ51CQDIG3hutRCYKj8spY8g0PI1IuP1o5fBFE8zXXwz4thpNsZr3YUfr7cwhCvb/MHFGzSw173LZcDasSHXmbWmC8Q59tVpour2X9+XJjoBTQjpJOT0tGvn2PiyX2/l0iLYI52aM72RdBhe4VVSVCRqlz3sabGClk4IddHH5p/Z7K6/fcQhB7QOKGJOsf2me2kIzQAoOZU8CYVQdhs81yX6x7MH2/pK0DgXS4SgrorVWX+TlcLm0d0aJ1FO4rQ+ycxmSj+Hf8Bve5xuOnjO37Gwd9ZYFfkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqyEd8lonfi7og9+CsLWpyfuv0WPDMLnqtmJk7bV5b4=;
 b=fdHgzT1VL4SCWhPL2jltrLNICn/MfOF606MZkmEX7TDsjQ7h37Zst1uTWy0d992uKkDmpFGH3XP7LWUkkVqWqj6v6fJU5WdHceFUK3ARE84aPMhwxlmQxlmjc9jN6imulwY4vBcVETPIcSvbufwVa/MZqRFvbvLt9yi/lZKoKV5QYv4Z0reEh3MYuByghG672cq6ZJnIIl9Ci8kJPv03Eq9tdnM9vwNLH1/XIsVwwBAJIKfmoW+PjOc2IsBlUSjDe7I47wVtvgtefpqLG75D3Yf0X4HvWtBETrVHAzo6u41Q2+re6m0i5J5wysKVAg4AHIAnqpkL4MQSicViTMmVAA==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Date: Thu, 23 Mar 2023 02:59:38 +0200
Message-ID: <20230323005944.262738-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230323005944.262738-1-parav@nvidia.com>
References: <20230323005944.262738-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C983:EE_|BL1PR12MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3b38e6-f9ea-4597-7cc7-08db2b39fda5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A72NUo/Vl+CWIFFraLTZ1ghE1bZv8xhOgyfLnu4nnHtTeqJZvgTtFdIQ6NcorurnOFshM7Zqesc6UiFdNkjOn9l7SVIb+7i2cr38yzSe/cY0/BbykGb0iTorP1D5jnd2LgA9vlev3H74Bn1/BtMJXbcVigl9oIyAS8GzmrQjFa+WB4WhyOLiLt3NtwB46oeeVUX4YCbbnHOMEfZugldPTxhPXGbwcL7L0AKF6kIXLdxRNDX5i0r/o7U8xcBah9xwovSba3gPaFt7RKX5clQoWDhc+B0wNHAyrUxk33yq+ihQIqQLU3arWVspEfQIJpJ8LBfBhDlpNujEkW3DLBsxwmM+U69xw7g1Fah1dDw+SsttKlGN3L039kywTbwTNnuHgFRjqiWG9uyHE85GejpIOE62et9XtJM5Vffpw850CoCkUwFZKjsNtDRTi5tKyWARyXx/AZxhLbEpECclHh4wlK913OrCCYOmis+OTb7no2Vf5/CcDBlqGWWzOkzn73ym3WyLOvKQ1nnMcs9Lp3xHBYSxloK83yPN7FBp67QgPDLp621kJkQeJ6EPu+j45fzZ6MpGSsiroiVZhK2mmS6u2fzSRmGqHd2F7lDc/dGJS/9vBsLOEaQJVUYEnofqsXO26f9DIz5GiDdyqo2EZ5Lvs/CSa6poFUkfw8TOrgHs/vth/WPXrDV6OB3fDH/HfMl5Cvb0QG3PfPXhwOoso6dSfZka8aakd2kBZXmZ6+G7RVImu3FwVrFaMU9TklM4zjrT8E131m9IA8j7yVpiKawc27mCxqVxJ24Znwlw/xGlu26ecbB5y1+FvRfwxmLo3A0XIr9vAr8rhVeP1NW6v1HFlQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199018)(46966006)(36840700001)(40470700004)(1076003)(26005)(82310400005)(336012)(6666004)(107886003)(36756003)(426003)(47076005)(40460700003)(16526019)(186003)(40480700001)(316002)(7636003)(2906002)(110136005)(356005)(54906003)(41300700001)(36860700001)(8936002)(8676002)(4326008)(70586007)(70206006)(2616005)(82740400003)(5660300002)(83380400001)(966005)(86362001)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 01:00:27.0573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3b38e6-f9ea-4597-7cc7-08db2b39fda5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C983.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5190
Subject: [virtio-dev] [PATCH v5 2/8] transport-pci: Refer to the vq by its number

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

This patch is on top of [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v2->v3:
- addressed comments from Michael
- changed vqn to virtqueue number in the Note
- refer to vqn field instead of virtqueue number
---
 content.tex       |  2 +-
 transport-pci.tex | 14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/content.tex b/content.tex
index 1ab7794..0f634ac 100644
--- a/content.tex
+++ b/content.tex
@@ -321,7 +321,7 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
 VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge
 might allow optimizations or simplify driver and/or device code.
 
-Each virtqueue is identified as vq number or also referred
+Each virtqueue is identified by a vq number or also referred
 to as a virtqueue number; vq number range is from 0 to 65535.
 
 Each virtqueue can consist of up to 3 parts:
diff --git a/transport-pci.tex b/transport-pci.tex
index b07a822..044c085 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -390,13 +390,15 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 
 \item[\field{queue_notify_data}]
         This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
-        The driver will use this value to put it in the 'virtqueue number' field
-        in the available buffer notification structure.
+        The driver will use this value to put it in the field
+        \field{vqn} in the available buffer notification
+        structure.
         See section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}.
         \begin{note}
         This field provides the device with flexibility to determine how virtqueues
         will be referred to in available buffer notifications.
-        In a trivial case the device can set \field{queue_notify_data}=vqn. Some devices
+        In a trivial case the device can set
+        \field{queue_notify_data}=vq number. Some devices
         may benefit from providing another value, for example an internal virtqueue
         identifier, or an internal offset related to the virtqueue number.
         \end{note}
@@ -1005,7 +1007,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 The driver typically does this as follows, for each virtqueue a device has:
 
 \begin{enumerate}
-\item Write the virtqueue index (first queue is 0) to \field{queue_select}.
+\item Write the virtqueue number (first queue is 0) to \field{queue_select}.
 
 \item Read the virtqueue size from \field{queue_size}. This controls how big the virtqueue is
   (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues}). If this field is 0, the virtqueue does not exist.
@@ -1035,7 +1037,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 the driver sends an available buffer notification to the device by writing
-the 16-bit virtqueue index
+the 16-bit virtqueue number
 of this virtqueue to the Queue Notify address.
 
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
@@ -1053,7 +1055,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 If VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
 \begin{itemize}
 \item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the driver MUST use the
-\field{queue_notify_data} value instead of the virtqueue index.
+\field{queue_notify_data} value instead of the virtqueue number.
 \item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver MUST set the
 \field{vqn} field to the \field{queue_notify_data} value.
 \end{itemize}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

