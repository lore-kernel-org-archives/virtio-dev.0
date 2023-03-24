Return-Path: <virtio-dev-return-11757-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3021C7619A
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:06:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DB56CEEA39
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:05:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 96EBD986735
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:05:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ED91C986807; Fri, 24 Mar 2023 01:05:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BF57A98646A;
	Fri, 24 Mar 2023 01:05:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PS62Y0+bo3Fx2DzNWINISU9opuy9SiG2I48Kxi8jaAPIz5ue0mElW0D+GSoIufOLhUJ772yW96SWj03PgXUvUqMgnsqOuz8Bp4lIHPJ7zXU6aRDbksYqcYSb+/yg8vAvj8oLNJrFcurfpjJwfizos0VKXo5nh2PcYxrthjhxjURPRJiZxmgqNKA7DyDcpJWpS3PInXL2aL8HzU1k7+a0oiicqK5KkGQJ0cD3y8QNtbSCIE4TJzGaMrZ7/o8Nd9F46Tbs5e27WOjaOd3vx0Mt6H4NS1M1jeAH+wyvscCbFwwfRZcYwG38xsKlKZMnh9ONuAtvOfXuOkO7IV6oSftQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uw/qSgmFdLMPw7nWkuQ7f3PJS2T3aLKWxhau2jjYlkk=;
 b=EOcYwPbuR52ZMXK7oiyrf8HY9JbHuqktDKgk/KAlZMC3oG+GlvvDTqy7vujDMFX5M7m1z8gGz6GqIwzhM2hOla6p6751duw1WmRwfoyNAu4g9VfYrtJDmuh5Odpr7+O8ouoca9pTrZjOj0chwN/biuybLSrMtxoSgWirk4WTp7X9BRzT+tm1Bg/CNY+9VgaaHlF0PqQe1Bo4kIojTctOSWhDrisexWBmXc8f3UNTtvFiGc33kkYP3xygYNeO5V2poP8W+vN9QPZ2X/WUf5xke2YwgevFRg0bP44v6tMZihNFMDMdOyurFLlWxXP58VuItLIGqkhnetjdoDoqnDWjSA==
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
Date: Fri, 24 Mar 2023 04:04:26 +0300
Message-ID: <20230324010432.280330-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230324010432.280330-1-parav@nvidia.com>
References: <20230324010432.280330-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|SJ2PR12MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d2dd31-bd42-4025-3d69-08db2c03c9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dXFSFJBJINqxkt0rr7w1xBOWHc0JKk27zwLkrjyhju1mb8d7hLQ9q+QaMyrAXMGK5kHHdXrdJUzEJHES+DSzSGiGTzhxtWniw6+VQKCO6sdmynicMe4p06d9H5yXW0Cut1eD3h9t5EmHTNrucJJcib7Cb7wFVg5wSMf7Y2ZNRplLsUtJwXsdRZkdG3qTd0qeok8jdQopDP3caC3bHSU74Aw0244AZf+4CmBwxbH0Ie+zsv6OHqzjPf4+8BqPGYLW3+mhhYxbbBTQ8mjud9mX4bN0+6rNT3rYk+sbd7cpPuWi6AGHhhifCRCOvUkDUclTDoKRzCbn9XM0xjEsE/5KvyKxo3c009JSdy2cZtFTOKqToRaqgqOLUfwhoPNWAfi+WPEa9HWrmm6hqDCNWgM3cv3D3HR9CaXDYisp8nKhCe+E3cQi8va+MS7cIe0g7zsxpB4bxlpbov+2KLiP8gE6/vOQHt1Dq8XDxrElQHUQkGSMslwWCNwR94XTi3qoPpwDjaAmPhMVV8IgaWDlTEn8v+eWkWaspRhBwZo4DMBPuKPBkYYSnYlBAv4zBBDDlVD10ZyRlm78DvaTVNNs6vFJbPf00niaZsTlBhFIHo7VRdEb6dwd+apBFqDeHMdht63gVN0Ij50D1c60Q5A9jxe8w08RKg+6PI4p01sThR0twiuArpb3HxiOs4F06xceDwy7oIPRYVEBZReKTiZgSY3obl8P2uIvDit4EBcUJxQxsXrhJdR8HgyvCXer/dCiuEJ8rlkoK6DKWbkAyvEAPKYzPP6tWwUhc44iLHKGtgU3iJn0HnuZrUI5syTiN1ICCn37MqbQ6bVq82Jw5vS8BrnP0A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199018)(40470700004)(46966006)(36840700001)(478600001)(40460700003)(4326008)(8676002)(70586007)(36860700001)(110136005)(70206006)(5660300002)(41300700001)(82740400003)(26005)(8936002)(107886003)(426003)(6666004)(7636003)(47076005)(1076003)(16526019)(186003)(316002)(83380400001)(966005)(336012)(54906003)(36756003)(86362001)(82310400005)(40480700001)(356005)(2906002)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 01:04:58.5948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d2dd31-bd42-4025-3d69-08db2c03c9f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7992
Subject: [virtio-dev] [PATCH v6 2/8] transport-pci: Refer to the vq by its number

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
 transport-pci.tex | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

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

