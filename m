Return-Path: <virtio-dev-return-11845-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B40BC6FD18
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B11677C24F
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C80079867B1
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1D16098674A; Wed, 29 Mar 2023 21:24:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 91DD798663C;
	Wed, 29 Mar 2023 21:24:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDsF/NMBK9MjBDCodK6utW7pYxa/yMZebqtKv0F+43dZpZMckkV3kGxBQnokRtOTweLp+ghton4sPT1QEnKY719k8ZpqM/ZxRDGIwwIL0dtwTPjPr6cKcwV2Xl92KYuGA9jUqiqD8ZFnzqOnJ8l1mQfc4IpfQjD+bZMYRoa0t+H0mLOECPC8PeMVuU2gBkhJBGUoUwATT/vmtg1xSlbZFMl8tHkfQY6eaIghwxaE0WhHOS7bIQioAZpYhdii9Y5xYAk87OFudi6+uk2BBa7nWGcZHcV5j/cAnEk49NWdGY+rFduBLPr6bpGw+ybmn8plyX2U70Z67KDddrU530g1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcyMZN0RuyQjhc65CB01H31HgGj7Oro9NQwIVEqgGQk=;
 b=hINKzQpR1hBvdytGIwI6L6cLNwVKfouovl4Srs1LawIsvbBEagi5UCTvCyWPyTbxQGuZEKTLWQfp0DoxvM+9iJ0YLnsVM+EXRbvo2Rq8N3MoGlkaDS9wDzeg4WURwIztyU7FPRV50BDp+YKt0LcEismlLgi5DoBuXJklis5ubcLP/Vd1DhwUyA1yz0HQyd1N+QVWV/XFpqt4ml44W0YVXxCJUO/OQgPHv/xju3BC9MVqSM2cRXrbKhB0yv8M/pRFLXa9vtSpbDIVCuU4jhmkzU911iy/TzzfFQ5prlcxhAqN0ZaDV1Eg6o7qibNI3DBuLep2lQqEj03/gsfOGEHIDw==
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
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Thu, 30 Mar 2023 00:23:40 +0300
Message-ID: <20230329212341.465843-8-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230329212341.465843-1-parav@nvidia.com>
References: <20230329212341.465843-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT087:EE_|CH0PR12MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f9cbc1-1379-41ce-7c89-08db309bf060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ciIQKC8u1Lvd2bloVeLDeSFWScJI8eQ7i84lhyKIjYu3zJMTzpUVkJbBQImYviHV7ODH1fagZJTy0NRM/S+bBoNeCwttDKwcqUyzNZiH4s0N6CzWy8xHeNEea4rK/ZnwatudJY+lSz2LJMW7PfAsDEmZp7WzWBTGtJpRvklTp2Y/UsO9mKkMRiPA1lWSSqeT+aB+oe4CkGK2W5fPs7CT5clfvELzoWpMa+93HCCaam8Gu1eJ4stNeK06Nvx9INCXYl0PSzbPKoBFZhvEE/LO8yjvRL+ByZ1wS8ZYghFA6Iw3r72Ucjnx/jLuH3UAFE0BHmAS9+6xZ+uEEFVYybqDrmzn35enhbb4pUI6RzxQ6B1+yeYsmRNcIonuuOABS6c0NuN9qcNL+zsV1uiiyQdQNQs3hbswDqMV3vM5OXzEEjWwzc04NMak3IizlxiqK5z237k2skH1Eief6Ni55SCZl/1D7tPhLFaMsiUnf4+NKTji/L+tbAUMZr56IONStsDZMnJ0QeOdglKcu29j9q+dZT3Y/4oFxO2Kk0vNDIQFDWCE4fbJv/umkfQeI1uwXrl64FwzOVP8gZnyyqB7Adovc9y7rDHhR/3JEPN6SX+NB6oK/yYTzw22Jy2RLpEy6PBKe4KzjrQNj2yqNGv8+5jGpYD+HIy0asKot9ip+rShu307Ch+fUpK56BW9k3ftleL2tRkLWQnW5fbXTVykq9qtzNdohw3jXZ4xrMfVWndwWZIuZBziNNjowzQegdhYiy/VSX1XefOUygLvuvxVkTjm5iqSpPvxbMsnmJkq9dNVkNyDJZXRWmYZfMH3ua+cXIt0
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(83380400001)(47076005)(8676002)(4326008)(82310400005)(36756003)(40480700001)(5660300002)(86362001)(41300700001)(7636003)(34020700004)(82740400003)(40460700003)(36860700001)(8936002)(356005)(110136005)(70586007)(966005)(26005)(1076003)(6666004)(107886003)(316002)(2906002)(478600001)(2616005)(54906003)(70206006)(336012)(16526019)(426003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 21:24:11.1789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f9cbc1-1379-41ce-7c89-08db309bf060
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5300
Subject: [virtio-dev] [PATCH v10 7/8] virtio-net: Avoid duplicate receive queue example

Receive queue number/index example is duplicate which is already defined
in the Setting RSS parameters section.

Hence, avoid such duplicate example and prepare it for the subsequent
patch to describe using receive queue handle.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 device-types/net/description.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index d7c8b1b..435c1fc 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1467,8 +1467,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
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

