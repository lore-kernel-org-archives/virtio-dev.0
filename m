Return-Path: <virtio-dev-return-12143-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B3AC76196
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:25:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C96219EEC8
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B9088986639
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AE71B98636E; Tue, 11 Apr 2023 19:24:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9B74D9865F0;
	Tue, 11 Apr 2023 19:24:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrnBKQgFI8+aTdVvPjVLDDgcPW7H8SSO9D1hsmOyUuXtrrQFHQfWVB0ywyCNneU/U7EbrFxdMYX15OZDEiH9JWoY0SJ+BGaGRs75vLDudk0HpmACaM5f1315FyrSwy/cUS7oku75wO6D7oPrH3He+YjaavgCXWcZRxxA276O0H+iGokZvmMfQsPzy1jcLjRBbS0/KcjQ9HBgfnvPRSYTNHYXhbT6tK2oZqObsWpBrgCNkwqU1EHpD39I6ueIuei9KyHenMvmHqUMkkDiQ4qcXCLSrzJQaspuakUyPyvvMyjaOsLfCF+cRU0rHcQNHjYy008IK7PNkljFVcITTlaIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=te4Hc5Rl0s9hzd5GnJLQkqRPFY7D4crERYFvW7XRDFc=;
 b=KJ9yyiTY8GaVkm/uY/6G8ltUkGOYmYDeg/pKGNtFpubL4Optyuu9cbhdRWGo3YYoFsn35991VHyG/82DAx2fIyjeD3sDSJr0OT72oNdTdkUnf3iew23UmfeS3Vc/81QWynedvX/I7t+MevgXmZpXpfPn7zxSBU8Tfmvky+nvx8H5TMypXrjVTW7NuWMQFy6aw5Fw+buU15YE2wF/XiVvSDsdVUydVn/MH4NJT2PjR2+VbJs17lIaudzGZyIjFxdIAjKAJbjgJuBR57Zp0IMrzEfiP/S/UsttY9nFMiX93bLNU7hahg/gojx/IsUD0qlYZFy+SMrrXby4iputZzgcxA==
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
Date: Tue, 11 Apr 2023 22:23:39 +0300
Message-ID: <20230411192341.751841-10-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF000145BA:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: a1bb3c81-189f-44ab-f1ca-08db3ac258ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u3a3Xjn/K6amp47Sejq3ErjKdIm/6mRBrIle0Few3egxo/sxgocQkEy7Wnegdmrj6aih3fQGIwbl1smG4Q60FpnDwL2P5nEa5E3rD7kU8jaHO1SL2cTu5CjgYi7HmikSeaVzue5fRfKjw1YJyxpedXX9KUV2FDTlcfXsg+yh0YUkrqbWTATdmnc/MOiNRMxGFWIrDpggbVeJ2V2oMKCE2ie+y+RDyy8Ai5BdBW7qKG5sIWTpbd29HtW+mamxnlmZPfW1kcyj0VVVecwYBkovHPhRxxB6V/6yjdk3aAxhppoRjzrqoMsxpGbn78m3MSn77bFO7Ldlq8y9t/gCWZYvLlee9m96qiI15OXZbMmYALUmailkEk7SNCQ2hXjaeBFXh+m/DiiXMP/3T9SYn6yzZnhLf39hg9IcKjQWj06NN9lzhyo3RakpLfgiogEIpMZQxtKB8yOi3KZjAgup4JePmLjCY2D7fpl4D5rehmLNEJXwT1bBDuvhQV59K0IpjqNF2jwUd4Gmsz+wfS6Kcq77PMxpSS67fZ0CVLFzk4Fcu75t2pQVijjMWYDE4nlV1EpZvIUGYgDk+5xxXFJ8TeqMBB5ZFJOafL/MIYh7HHvhYRkJ6uB6cHuR1jUD76Bm6CWHeyuV390G0tDLc1FKJAcc/yvRHcvI953wZU/9kyHxtytpo9OW5zLrWtB/sLKQIidvQcekdOzLz8OywX02YA+kPGy1yY/O/pO+GYp/2l5PNnoNvoYKnaQN3CBUkXi8sWaEGySj/QlbTIlFilWBFzWV8unQN1C5TQY71ibzX0Cr+VU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(6666004)(40480700001)(107886003)(8936002)(40460700003)(966005)(5660300002)(47076005)(478600001)(7636003)(70206006)(54906003)(82740400003)(316002)(82310400005)(110136005)(16526019)(356005)(86362001)(83380400001)(70586007)(36860700001)(186003)(4326008)(2616005)(8676002)(426003)(336012)(41300700001)(1076003)(26005)(36756003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 19:24:18.6755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bb3c81-189f-44ab-f1ca-08db3ac258ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF000145BA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613
Subject: [virtio-dev] [PATCH v13 09/11] virtio-net: Avoid duplicate receive queue example

Receive queue number/index example is duplicate which is already defined
in the Setting RSS parameters section.

Hence, avoid such duplicate example and prepare it for the subsequent
patch to describe using receive queue handle.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 device-types/net/description.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index 875c4e6..f3f9f1d 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1478,8 +1478,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 The device MUST determine the destination queue for a network packet as follows:
 \begin{itemize}
 \item Calculate the hash of the packet as defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets}.
-\item If the device did not calculate the hash for the specific packet, the device directs the packet to the receiveq specified by \field{unclassified_queue} of virtio_net_rss_config structure (value of 0 corresponds to receiveq1).
-\item Apply \field{indirection_table_mask} to the calculated hash and use the result as the index in the indirection table to get 0-based number of destination receiveq (value of 0 corresponds to receiveq1).
+\item If the device did not calculate the hash for the specific packet, the device directs the packet to the receiveq specified by \field{unclassified_queue} of virtio_net_rss_config structure.
+\item Apply \field{indirection_table_mask} to the calculated hash and use the result as the index in the indirection table to get 0-based number of destination receiveq.
 \item If the destination receive queue is being reset (See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the device MUST drop the packet.
 \end{itemize}
 
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

