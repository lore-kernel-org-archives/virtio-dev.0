Return-Path: <virtio-dev-return-11944-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81521C761AF
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:51:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E82B342A7C
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:51:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2B2598658C
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:51:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D73A79863ED; Mon,  3 Apr 2023 22:51:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 46EC5986652;
	Mon,  3 Apr 2023 22:51:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6bK93+E6wK2QLqRZOpyCLtxkUbiInSGHjlMHwptWPFhNhPxJ7fketlicUQnNFozUXmKmo8y8uNYdBa/M4x35fCve0j8eL4M6zPPwYZPNjljkZEpsPK/RLFtQta0z4jRaC5kVTX/v5+VohDgNSrZxYLIyw1GuApxH5LY77ekCRJJ99IqQzYao+9ro+sO1+zAnwpa/W3zTzWPxr60tYY7YbOEa3H47MiD4HDUb4H7WpLw4z/ewnT83HjPbIH81yYqooNUgLWiB8c+JCAJr7MyW1gFnlDH0FB8MvOSOcMcafrTinwR0KOgyStaWxW4Xk2YLalouZkl2zoZ8kjky1lwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5yzW3jc6X13b0m59miospBpOj5X6WhfnZElVzmGSbU=;
 b=IwNUDI0nr1AjyIdcV4uNc20kWpw2Bl1OkyE1EXSu8CzAc+XR87Q7/M9bFc/p/zh8LIxTmLJLK4vr9qCmEXr750l9y3K3V1lb1kEqs65/g/PgyyGXkQ0IOt5qFopbhWWgrp7TidF76SbP35xe0a7eQ2ZLxq2uyUmF0YWp+txAGQe1hZ0Tx+Ocb3olxCpLyCbD5qkgGv/G6l3UtdFwZiBLZwIzjNNI0hngDPNZRkFNH3xRPsGvSG7Zld0FBMDF3aiDpVKiMjpSLu4xGJX9OO+gDIO3wVWPERRIJokFz4k8UVaI1+o8gI4v/navQRBMxY2ONrMnbJ2y66GuZMIExmfoNQ==
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
Date: Tue, 4 Apr 2023 01:50:46 +0300
Message-ID: <20230403225052.585498-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230403225052.585498-1-parav@nvidia.com>
References: <20230403225052.585498-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|SJ0PR12MB5424:EE_
X-MS-Office365-Filtering-Correlation-Id: c1984ebd-5c9b-4336-7dbe-08db3495f434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Wi2gtRhAoXj3wKBSuvszXHVtTsMF0qwGFHlB3tNlWKFi03GAout2v/u3aAvkrKBwiQXQnD8T/e7S6BTbhoq6+WOlsicsjcfDamjGaCEJMzmNtqyha3ndyEYYO9H6o0+W4BztOWNJXNJpqx02emshxfxC2Mc5vjsTTa7eFQU35K8LgHpKJhUrv/FbW0tRiHdm+FnjVSdZCD2izadl+QckbL03RPJ3JfBacqQZqHdRbLdV/HrUoqcYv2gQ2RWO8FtdKvnBWuwfUAOatUo4gNoZ+kwGwWqLqsESVhOtIFERXFqavCQRestqL7gxs1D76V1KUQ3s36GrMjdIebfSLMTt5/8KnKoH5EORxLXeKXw/I8i8bu8uJCuSR6GBqafEwD3HyfQUTRDyVZgKIOKGbq+yzywE6VlmXbLm3TPXvTpRJ7y6CRpKi1Rv+tFy90cfoLNM1sYSQeTCHA09C3icqkk07dBoub9VsDRejbolNs2bJ7zfEvHJAVdozAqGeCrc6rpYL5/8uwc7U3GV6TNo61QxTA33pZngEnpxDr+brrp/5wrVtjw/ts0gRuxd33jGuB/39WA2L2lUDT0TsUEnarWyh3bIk5PGf13xCqH5GQbvBpJAwVrxI6lIz45JNilsXIPI4vb+F//IogLKzr3dlHaupJ8S1MsHNHAuPmY2zz2TjM1khY5wzGCDxVAS9xdEVoarauuV1Gvl+IhfFg0xV9sDkUhOpLAbVCFDarK+hAnrtrNKdMdQpZntwRYCqOIG/pNfQgWAuaYqBcC+Ge4fO8nnLKIzYcxhZm2ftor95jOkI/c=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(86362001)(82310400005)(2906002)(36756003)(40480700001)(2616005)(966005)(426003)(186003)(16526019)(83380400001)(336012)(47076005)(26005)(1076003)(6666004)(107886003)(110136005)(70206006)(36860700001)(70586007)(40460700003)(478600001)(8676002)(4326008)(82740400003)(356005)(5660300002)(41300700001)(7636003)(316002)(8936002)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 22:51:25.2878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1984ebd-5c9b-4336-7dbe-08db3495f434
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5424
Subject: [virtio-dev] [PATCH v11 2/8] transport-pci: Refer to the vq by its number

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v9->v10:
- updated commit log to drop reference to old patch
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

