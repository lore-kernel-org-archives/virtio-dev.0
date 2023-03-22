Return-Path: <virtio-dev-return-11726-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F874C6FD1C
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5957277B4E
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DEA629865CF
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7FAC59865D9; Wed, 22 Mar 2023 21:53:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 09F8298656B;
	Wed, 22 Mar 2023 21:53:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5IpNTpBwPgdqORcgn0d51IaYs5ag+41l60+ZFLJNjZegUsXQgtPvuJn9C+KfZNqW7oX/yd8LK0dEyCSSaF093QvOreGgELvzDk8IC6GyHH8oSolKhMQM2Cxu+qNknT/8qAXwAL7i9ymWH2DPXFkG0dn1LWaYQJWyOHp82MvlVGhHCiUAcQ+Z7EQmDLfj3lrnag2JHVjdxoyx+DNH8e/rNf56QJ1WVSNHMfy2RlbOdcbxVoUnPX38ChzvkuuEaLh2C4Ede9KjdrgSoTeHt6+vr6XXrLFc7mTfPcrRDLyGYQRd2mpvVkuYOTtSRJ6RzhEz9EbTo8NbPWjNa7ICdt1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqyEd8lonfi7og9+CsLWpyfuv0WPDMLnqtmJk7bV5b4=;
 b=Zz4k4WTzjpP62kjqvu8dNuCbrU9zp26JUwQYqLG+GCe3ar6/2E2zweskW7UWC7/ypbE3X7Fl5upJQ4v/5vTH7u5NQsG3KCZIXWuBJdvJTv+r1gpEhQNwgZloEZwmiP2waqH6lgcJQ2habGK8I5VLMPJYAAyJvkpdAnzBrn81+b7oGAijGEmHMOUkAmV/tcbFSS8BcGrquvjZjC5wyNLLpqk0gJeTJqFpymB38mABpZ9RtToPt3CRAXWTp2C0amcc5GnLVzKf684JR/CE2HbVQBvSZGMJ+ApuaZRbdQRgF0iMaaySN9mh6WBgbDxDf9rs7Ii8q7GahRX1a+u8qCMs2Q==
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
Date: Wed, 22 Mar 2023 23:52:37 +0200
Message-ID: <20230322215243.249524-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230322215243.249524-1-parav@nvidia.com>
References: <20230322215243.249524-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 234c0402-2c35-44b8-2e28-08db2b1fd240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w/qg7fWQjseXst8LniEj5F17y9EUExJmbbHEt72k3YisJ3RpzyGoGw5qqKU0oNtTA5fHEPRFq98DjXeUyTyV9+tFO1MFRGMUbyMCZ+R1e+b+xFi7s+fuwMKQ+PGOP3He6GOiM0nkeZF3+874DcGmooqBBcK7ox5gmY5yh0+rBJ2ThkbYzju0Dh+Aqw4RvnI6NMVXPoUgAN3dj2bn3Na5JLNE0pW0mm/IZI5otaVnLTl9znwEF4sW7ZQuFRgaT8YTeVdxmXqRGi6DbYsjphRlVgFBTqVxFjWkac3SKn6UJvvHwK+6c3Hl7zPBKkT5gW/gu3fAU1RyFejSI9XiGrX6GHKjNilAMzZatATbmbXHZ8HHeVhWauV/IarjSEsvHu8hmbIemz2O95721p3290PPZh2pgZRzZ71gunKKdUDL2p94Wvdyls9zh0aKjjNjIj6PZ7lxMc/HkNU/PVr3+lebLh92W3zTHtRfkCb6Q6UcXbslcHDQZkiM+oZ2OLskB2/atlHBHDEyb9kCOAgl7JnmxfvjtaZQb918Iz1UoEmBsVbKS/86Gjlb6e7szdmU9Mo8bmiskVw7OTpOOrc/UPgOLBkcDeKs6RCm9ASqShYLtUS0rEeOpRdxwFD31qVsUPNaqe5BrNiLi+KNO7j9mEIcyQP4bd+oxcd0wPA7WJEMliW7BkrN1ZGGNtuQEwawi9hjmuVLf9KSyBIXN1tFWS3rq5Yr8LnTegC2riBwDHJNgwuuEYefMO+Qy3rk0z5xLEibvwzAXuFwJMNvjaUcRiMfiDplSfSxDb+emwt0v9YwHwN4ddCdt6X0PtTUGQAfSn6YUfdsdOjiBxYUMl6GMmO6ew==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199018)(40470700004)(36840700001)(46966006)(966005)(426003)(2616005)(54906003)(47076005)(82310400005)(16526019)(316002)(478600001)(1076003)(5660300002)(107886003)(6666004)(83380400001)(186003)(356005)(110136005)(26005)(86362001)(70206006)(40460700003)(7636003)(336012)(36860700001)(82740400003)(70586007)(40480700001)(41300700001)(8676002)(2906002)(8936002)(36756003)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 21:53:07.3053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 234c0402-2c35-44b8-2e28-08db2b1fd240
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118
Subject: [virtio-dev] [PATCH v4 2/8] transport-pci: Refer to the vq by its number

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

