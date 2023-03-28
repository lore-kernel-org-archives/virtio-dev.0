Return-Path: <virtio-dev-return-11825-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C96FC76196
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 20:18:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 17FB067043
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 20:18:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ED9D49864C5
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 20:18:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D36B29865F9; Tue, 28 Mar 2023 20:18:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 417D89864EE;
	Tue, 28 Mar 2023 20:18:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JruMCNNPJY/j0enTsQUg9BtG4c6OUa6VF0zt6wzhwFd9ZYY/h/rTe8p2UImwk8ksaNf54MxVhvI+s5xmL9NWRoSsJVngDPH/YZ4ou1aIC3XcXqDo9ZNNdm3VTXL2ffizZEz3/w9MTygPb48DybHazuHhThQlLGDHy0Eq+K4+75lH3yKsYLuriJVtt0Pjqk/xot+FgkaRRkzelkY+3/egcGio6hA9oWYDqyv3oTJPSIC5NvNsRUVl7/C9/XyujZy/YqdEoS/Re1wXthj9Y6sqg30sn2zYgkpNOnLqE06fu+2GMA74B15INPu8nwhDQ4Pf3sYfweNYgxmWW0xS0YvZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7wrJzYeuSvmVpNOfjDvQxDapmvK7YgZ/ksi5zULXBA=;
 b=LlqdMHDYJeUWrCDqJqz6RC/bEoIQpAdQalpPlblZ5k/srnTDIwSS9Z2715YmbcxdQOJdSYlT2AHAe6p9FdaWYDRAr8FJAzBynubnlvKtpatDVy7OG/QfQSaizmSnwfWe6lPLehBOgSsLTj/yA0Sti0EeFlo/khkVFqukrPpCjaV9n92novbINGOXKkZ04nBClYQuEEgCm74Ak4zWD7sJFivcZGniuHqR+EpvefOfmeHdViyixKxfVfUbuCJSnXVCySYbVXzAC20LchKwOE01wvzhJo/vJQu8QRDnrxycRR7XaSQWxaxcluir4OUnkHrjApV9vmsgZAslHs/iAAATLQ==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <sgarzare@redhat.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Date: Tue, 28 Mar 2023 23:17:48 +0300
Message-ID: <20230328201754.440974-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230328201754.440974-1-parav@nvidia.com>
References: <20230328201754.440974-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97F:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: fd9774b3-8744-4f2c-db2e-08db2fc9955b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8/VoG3CfDMbPBzsZqUO4zTUdaY0wVaj2pffp+A1t0P1Ww08fGQ64AjPwAAoILHCKp2RCYQmWr46c9mLGmVjQ3brSvCqlSeC9GynXgutnqIxLOYftSvPY6WGsz9oavFWYsrDq/V3KFjSkerBBW00tnIoJsoEbPNeqyFPj3FldnL5pUZDyBGTOjgJIQ8awrKtBmgfzUHhDrIdaPXK0s32WReVIukbNJFvoWuXjK+4jmSZZld/D40MlFCH8P909/7dMmJySax7uMACEvDAbvCUDApog1ay3RbMLR++51V/SgcLpestynNptm9sQR4L45QILSglUchd8iGQR5lCbGSLw6H5PsqHJzjV3UilYX3Qw/FBacneKfIhA4m4NiT6n1CgUIKRkADpbOrN6TiXxLclw0iGRCLEa76v0Dlc4OMtpwlHoQ+bYIAnuzE6UpdtfzK0R6CgfnLmgsv5VEtmAd+cqCgCH7+li/H7Owh4uhxMzDk0S0KyfL0mqaQ1XR+YPJLej/p3x4I5Wx++CRgqrQFzP2yiEOR8/2WPJGMwTnHBEP8vD3Sjao5A6UJbmpcyGyNwTBkDxVD9+EX+iG+xt0Q6PIGjm5BHLiVTC6MM2JPpQc5dbgTD2QLutSHoJv5OqZZhOGk9/IDrfjHI6k+Cb/t1bYSrKE4ulXxvPCLufF3hqToeQ3uopTb5Vnb4+qGb3lsYj91dLn8Qz9Igs74ZDIm4pUIjHtJvHWMu1t/EzvINVfUcpKTFLZdmm3d1us3OVwf3IEhsG6NtVzcjuybocZNsEw1QpaYCSmp39Y3hzMZsTcn5zyAhZZuepU9LqHZMesb0iGd+nbke3wbQlz41+soOusQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(36840700001)(46966006)(40470700004)(86362001)(47076005)(426003)(336012)(82740400003)(36756003)(16526019)(83380400001)(82310400005)(186003)(2616005)(5660300002)(26005)(1076003)(8936002)(356005)(7636003)(6666004)(107886003)(2906002)(966005)(70206006)(36860700001)(40460700003)(70586007)(41300700001)(40480700001)(4326008)(54906003)(316002)(478600001)(8676002)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 20:18:24.2095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9774b3-8744-4f2c-db2e-08db2fc9955b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C97F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802
Subject: [virtio-dev] [PATCH v9 2/8] transport-pci: Refer to the vq by its number

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

This patch is on top of [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v8->v9:
- reword the sentence to avoid future tense, like rest of the other
  fields description
- reword the sentence to avoid multiple verbs use and put -> uses
- use shorter name 'vq number' instead of 'virtqueue number'
v7->v8:
- remove note about first virtqueue number
- skipped Max's comment to put word 'structure' in same line as its
  crosses 65 chars limit per line
- reworded queue_notification data set line, as '=' and vq number
  wording was odd
v2->v3:
- addressed comments from Michael
- changed vqn to virtqueue number in the Note
- refer to vqn field instead of virtqueue number
---
 transport-pci.tex | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index b07a822..0f3a48b 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -390,13 +390,14 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 
 \item[\field{queue_notify_data}]
         This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
-        The driver will use this value to put it in the 'virtqueue number' field
+        The driver uses this value in the field \field{vqn}
         in the available buffer notification structure.
         See section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}.
         \begin{note}
         This field provides the device with flexibility to determine how virtqueues
         will be referred to in available buffer notifications.
-        In a trivial case the device can set \field{queue_notify_data}=vqn. Some devices
+        In a trivial case the device can set
+        \field{queue_notify_data} to the vq number. Some devices
         may benefit from providing another value, for example an internal virtqueue
         identifier, or an internal offset related to the virtqueue number.
         \end{note}
@@ -1005,7 +1006,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 The driver typically does this as follows, for each virtqueue a device has:
 
 \begin{enumerate}
-\item Write the virtqueue index (first queue is 0) to \field{queue_select}.
+\item Write the vq number to \field{queue_select}.
 
 \item Read the virtqueue size from \field{queue_size}. This controls how big the virtqueue is
   (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues}). If this field is 0, the virtqueue does not exist.
@@ -1035,8 +1036,8 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 the driver sends an available buffer notification to the device by writing
-the 16-bit virtqueue index
-of this virtqueue to the Queue Notify address.
+the 16-bit vq number of this virtqueue to the Queue Notify
+address.
 
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
 the driver sends an available buffer notification to the device by writing
@@ -1053,7 +1054,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 If VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
 \begin{itemize}
 \item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the driver MUST use the
-\field{queue_notify_data} value instead of the virtqueue index.
+\field{queue_notify_data} value instead of the vq number.
 \item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver MUST set the
 \field{vqn} field to the \field{queue_notify_data} value.
 \end{itemize}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

