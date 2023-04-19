Return-Path: <virtio-dev-return-12296-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CC5C6FD18
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:48:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D1AF8154C17
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E936F9867B6
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DF789986809; Wed, 19 Apr 2023 01:47:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 350A998664C;
	Wed, 19 Apr 2023 01:47:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FncOpdrMDydv+jVhUVzWyG7bfLMbdDEGY0/LAGKEYHuzzg5qFolik0f1zQ1LD2Ti0YWrqATqAbTJkME56cLbEABd/d9q4Xa/haDIwnVYugnrN/EEP3FUo7XlUsmsFYuNBpi7VxW9xwcIarhyo9DkIYjaDeW9QLL7ny72atykGXI4rBf//6MhNUWoJX0fg3wxWxqa2fXnw0yks/qt0C+6sQ7BPR0DOoMWLHmyQACIH3X4GO4eUmYTDcYLNC+zJfraPupYV0Oysuq+ZxeKvEi1EXz9bm98AtISHhlUzpfBTTiR+mz0vTRufXsz8FXoBVvevLEGL8NXK1okOmG17X/vXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=te4Hc5Rl0s9hzd5GnJLQkqRPFY7D4crERYFvW7XRDFc=;
 b=kkxplLHlRSWMcH2622WccdfOHs0VdDDV2xj2soim9MjezUcwRvFsoDfAXMceLq8AaHxquJbFx/NBVX1py4SqO18t4MampJITSOF5c1k3hKtBP8ChEju17hkMtp9x6Dv0+pL4g8jY7pz+r+JahEDVO8Pk2oVM7zdVfKXZ4PCLDgRfKMq2C/AFgYAqgBCHXYsg9J7X95cVMxrEJj6zGIpjbiD9Ep/BNiKN+vI4eFo/Q4tuxkLmgBs3G0E2LJaQrzoc5vNBYG604Zt79V9vrOisjL057JhXKw0VzbSB9PXsLnn/ZeXPZvQQ4PqEjWyeTV+KWLByb53+Pr/9ZdCM5OZJRA==
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
Date: Wed, 19 Apr 2023 04:46:37 +0300
Message-ID: <20230419014639.919458-10-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: 22dbc637-ed8e-46ef-6683-08db407800e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xww5RO2wyrYtjtvgv2MXQG5L7AtybZ9fEHdPX/2664S8QBHM8LY5A7tfLK5eC29NNvX68pXXm0YKnCl/qKmbB+RQF5Jewmi55ffAdP/5N6A+mCK9x8VTHiN1hRtd7OACLOwFWzWHKID9FF5D83/ibeWTbvJiKhedr9zbqErwbr64nB/zB9O6JSKnV+geG3IOjWqD3d2UnSOhRliA0vJyTYB7yvYZcgdEVLbVAIuX8A9+C9NE2X+qOpR/G4oRkpe0dd3pmrQDPtDRJMOMS3lFtUHyg1Rq+a+d4G3LR1SGXUeFTBKF7U/yXspZMgRPIzm/yMSEtDAWl64ZAgQZMg4dxvr1szJzOC//+XbIxR+cVkzrtFyrrvb744w1PmUQ7dNv4CRxThSnuYBEW/zw4753YIQvLqwjcjmaj6kzgmJBZzrT/WIms+VoQ6hu4goOC4NZ43WbDSusQOXJ/OwSn1+9/OvcLenoP3w6b0wotLpUzydvPfQzt6xKyA0OK3OxxjbMl2DvDLOIwaV6zdGZ1tUmCRQiUsN/lNIVzvzV/NHdOWyDNf4DI59sQ9uUAAdyaE0+8gdFMKFvrZDfUSTXGNmD0U8J+mQ9X7e+lANsggZIr++xd3CR0niNxGk4CrOakWAd+qrGebP/Mv2xyeHUZCNYLmd2kHHLq4gsm9wn2vkORC5xPGlI/AjBCugSI4Y93bUKxuprqx/65y2TpV4Zrfz6SJq5idG1KnCUPBy8QFHil3SgkKMR3Qw37zR6eED5G7j1tRJAE5PspN/Upv3LVaSSmU8/adc2RQq1VRZ/zkljz+Y=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(478600001)(110136005)(54906003)(426003)(2616005)(336012)(107886003)(41300700001)(966005)(8936002)(8676002)(6666004)(86362001)(186003)(16526019)(2906002)(40460700003)(47076005)(83380400001)(26005)(5660300002)(1076003)(36860700001)(36756003)(70586007)(70206006)(82310400005)(4326008)(316002)(82740400003)(356005)(7636003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 01:47:15.5829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22dbc637-ed8e-46ef-6683-08db407800e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934
Subject: [virtio-dev] [PATCH v14 09/11] virtio-net: Avoid duplicate receive queue example

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

