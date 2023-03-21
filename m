Return-Path: <virtio-dev-return-11695-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F6FC76195
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 22:00:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A51E429FC2
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 98CD5986471
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8E0D2986450; Tue, 21 Mar 2023 21:59:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 31BBA98660F;
	Tue, 21 Mar 2023 21:59:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4GVvIiRo++0kqQaUn2AsPV5qjS3x4/MgRcoFlF5F3mOR/3HY/JtDEfIN7rG6iKQu5THJ4xhRaFHNPhJzggpUuPCxHyiGgGj1Rl04CIQ6IEjSxlo4IxA2uUqMctcLjkly1OztSSJ4ZzAf7ZKkZuy1typqHCn2hhrFJsT8qiSViHHG1rd3ey8YknC8H6b7gQoCohJNqSyMRtUa6iXY4YQBT8/ETeuLgi/iBxoyB9ebT1/QIDzFb151JN3VrVqxHJI3OwvfetWl1xQdCLmVqctagh5WO7FEqKQsh7qlwcTqPQ6ThGCIZsOmG2eg5O/Iv6ALG6pBhqbYvDWvmCfsSZB7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0tJSfDEoZ2yO9IH/oK9m1O4XzzhcvEm5b61T+BmDw0=;
 b=AAhfo+VKFgnYFHC6UbKZALFOBkEUOGbuH1k+6srOi5zajmMag3lcLkA7cnS/Ejl4wcDPVV3EapAagGrnFNm0AEbPX2X2S5hAtrg9vVZIlVxBP0lUUaN5TlQxU1DndJWg9vHLqVVZRoUqlNANAdta6QDBpaPRNozHhZuBDf+KvE5Xccv03uwMCf6uxP2ZNqg/oStGjsNu/LAYBM6YOD9nNpe/ayduf+LqkLv3Ud0amrccM46x6hnEKwHAyIxNs1GQEXkJJBMPT/WaKt5k0ioyyXPU87Is3yGNtj5YVlCMdwBTAA/xgx0rHxhc0619iEirO9ZFT2/0WmLboOKYRwVBiA==
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
	<parav@nvidia.com>
Date: Tue, 21 Mar 2023 23:58:34 +0200
Message-ID: <20230321215834.225856-9-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230321215834.225856-1-parav@nvidia.com>
References: <20230321215834.225856-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT019:EE_|CH0PR12MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: eb33e5a8-84cd-481c-03dc-08db2a5781cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LuKXq33ENEq69nqvzwLwml8IGsMLapTHHy4IerhLF6r4JLrjcg4c9lLAW8tYcZV+zfFd3oQOXtRXvQpBzagpGjsGVt23SBpyi4l+FH0JwV4+4gU+0C++CFu/fe8tUBbAt51VD2dy51pOBX0euEXTzqvRM4/UakRCnjni2Ts5Kcr1fUNC+JsKQMVNNgdlrmrHgI5/O4nT1piZYCMeaHvuf1S9+51Bx7u7NIX8iiktmAYnAx3END/BAubYBGyFGq92imm2Torrqga38i3Qf2pPS3onmdTO8HqOYlHw0BN7l96t8EedadvktMhnJYNQOjwqebkr2mt0zKmld5s4SlcR8RJsZEZd2AhIhFsnTDYJH1ITJABJPtRlEaif83U/VLGRcrI3NjXkGbGTBa4TkouSPFJklbW+Y5SkTY4azHcJiXO7PpUQ919fjCaHvWuIXeMkG6yCCqYSsRux/CJ0sL4BDe6HmvBqgCw2fJs1srWgad+zCbsOdjiq2eiaXvozzQ/PXYtiC3FPHknI7AEFEZeuV1QKGuSFOectphG+HMgQtULGWkYz2Y+n9M+AU/ZC22v3lHGNgy05EoNS7kaOA+BtmUoLdy6QdZaqqC+y9gf8+lRdR1yAoB7+tRIK2o3gVMSb/W8zdjEGhAuiGxzjVNHKBJZu5kb65l7qn0tQQt8EfrJJVwiXhLMeepsObJ4zaACjtnu4Kp8xkNBlJpF2g6YfycEUDE6aF1iEQ4YUUGxmwDyWG7O9CTa0iC24w6lHgQSYPthZL+Z00MEF/wlPJaCDhfd6oDXyZVQthvZhlaRSVaU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199018)(46966006)(40470700004)(36840700001)(8936002)(5660300002)(36860700001)(356005)(82310400005)(40480700001)(86362001)(2906002)(82740400003)(40460700003)(36756003)(7636003)(4326008)(47076005)(426003)(966005)(336012)(83380400001)(478600001)(6666004)(107886003)(2616005)(41300700001)(16526019)(186003)(26005)(1076003)(54906003)(110136005)(316002)(8676002)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 21:59:12.9491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb33e5a8-84cd-481c-03dc-08db2a5781cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8486
Subject: [virtio-dev] [PATCH v3 8/8] virtio-net: Describe RSS using receive queue handle

The content of indirection table and unclassified_queue which are
based on math calculation historically. To better describe this, to
avoid intermixing array index with virtqueue index and to use virtqueue
number

introduce a field rq_handle (receive queue handle) and refer them
to describe unclassified_queue and indirection_table fields.

As part of it, have the example that uses non zero virtqueue
number which helps to have better mapping between receiveX
object with virtqueue number and the actual value in the
indirection table.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v2->v3:
- moved rq_handle definition before using it
- removed duplicate example as rq_handle is now described first
v0->v1:
- new patch suggested by Michael Tsirkin
---
 device-types/net/description.tex | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index 435c1fc..3de8994 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1442,10 +1442,19 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 \field{indirection_table} array.
 Number of entries in \field{indirection_table} is (\field{indirection_table_mask} + 1).
 
-Field \field{unclassified_queue} contains the 0-based index of
-the receive virtqueue to place unclassified packets in. Index 0 corresponds to receiveq1.
+\begin{lstlisting}
+le16 rq_handle;
+\end{lstlisting}
+
+\field{rq_handle} is a receive virtqueue handle. It is calculated as
+virtqueue number divided by two. For example a receive virtqueue handle
+value of 3 corresponds to virtqueue number 6 maps to receiveq4.
+
+Field \field{unclassified_queue} contains the receive queue
+handle \field{rq_handle} described above.
 
-Field \field{indirection_table} contains an array of 0-based indices of receive virtqueues. Index 0 corresponds to receiveq1.
+Field \field{indirection_table} contains an array of receive
+queue handles described above in \field{rq_handle}.
 
 A driver sets \field{max_tx_vq} to inform a device how many transmit virtqueues it may use (transmitq1\ldots transmitq \field{max_tx_vq}).
 
@@ -1455,7 +1464,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 
 A driver MUST NOT send the VIRTIO_NET_CTRL_MQ_RSS_CONFIG command if the feature VIRTIO_NET_F_RSS has not been negotiated.
 
-A driver MUST fill the \field{indirection_table} array only with indices of enabled queues. Index 0 corresponds to receiveq1.
+A driver MUST fill the \field{indirection_table} array only with
+the \field{rq_handle} corresponding to the enabled receive virtqueues.
 
 The number of entries in \field{indirection_table} (\field{indirection_table_mask} + 1) MUST be a power of two.
 
@@ -1468,7 +1478,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 \begin{itemize}
 \item Calculate the hash of the packet as defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets}.
 \item If the device did not calculate the hash for the specific packet, the device directs the packet to the receiveq specified by \field{unclassified_queue} of virtio_net_rss_config structure.
-\item Apply \field{indirection_table_mask} to the calculated hash and use the result as the index in the indirection table to get 0-based number of destination receiveq.
+\item Apply \field{indirection_table_mask} to the calculated hash
+and use the result as the index in the indirection table to get
+\field{rq_handle}.
 \item If the destination receive queue is being reset (See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the device MUST drop the packet.
 \end{itemize}
 
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

