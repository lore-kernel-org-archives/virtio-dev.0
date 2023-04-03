Return-Path: <virtio-dev-return-11941-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7027C761AF
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:51:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 14AA799178
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:51:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A1619865C8
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:51:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F2EDA9863EF; Mon,  3 Apr 2023 22:51:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 29E419866AC;
	Mon,  3 Apr 2023 22:51:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtQBoe9uRscRdF2wWq74JksNFt5A/yRicLpZiuMp0YHNLCDIBoDB26Ht+8QlRBrZsDxD9FKmZfOyLHdk8wSsKYCF82yL7LAfEMRjh10kMZuBHUQQiJpgptrDnUyPC8jY45vZgeohLNJ7hNJQ7+sj17UVQzxG4guiCZV3vSiFhxVvghXpq+Z0eJZHDDUkFhgnzjxcNXLMjjb4JE7oiM6/RITKwz0knkCZgkJRgt+eCYGECZJOfCu5CD8apKDofJlh/4Prqzi1gF0QU+9G6EPn3PTe4grTIDSg5vwQPmWPbiZVeZcoXRHL9Gs/Zmf0FFPE7EHwzvPPYi2M21wr4OIClg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5llxrsT/P25e98ThXNFtJfuZkECTmlcogp2oQF+P5M=;
 b=RZcCd+vmy1D0y3vgEJ9KfXfn7DlMxdoRsPfzU8YXA/Hnkvp7BoyWC47hSe5MyPwau0o/7DurM3iUBWtSz3aPArpd6DM2ACuNBHvjZVPSFGI3GTx56tAGNde4j0YpjrBtQ+GBDyGsjTUessvOgrhsqEjmP796twBFFCezYQx9zH9HuwIjwuv32a1TrMTBL92pIBG1E9MqP9yos6vXe0hInH1opTapXImC3UB8TR+pT64bOsfCESH21ItEe3Pe6jZp6sp0JG28MSAKMq5SsPiaT89z5Fn7gXcUjGU0qwjmetNB+D6NuE+pI/Z8QLBpprXTUPmEkOPl4pgv66+O2pHYGg==
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
CC: <sgarzare@redhat.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Tue, 4 Apr 2023 01:50:51 +0300
Message-ID: <20230403225052.585498-8-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 320c1407-006b-4b56-8ca9-08db3495f10f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JxAc+2hh2TVd/zuHxK36GpinXbi5XN6u18N/MWuUfRiLHIWUaKCB3R4gtCkDnrQAbhQnTYL3tHXVZ+o5ngPDlaI4Sj0MqNfdXv4f526NnEm9+2kqmGfs/zQCNqITNrOIen7LYd3h2A1bbQFJe9U1MiWGCnslUoND7zFjM7hxxclD7mcFvN+D1r++5K64+e5HlR3hZ7N/uOg8AfRsxv038JrJ8Lbdx9FGiLBqOmnvEwHKAAmFiMltEPiGCI1eCfJ5kxABtpv4/XLAitwMFRIV1fzvwZqH2+1Ui3iapkVD9VPJL1p6SFB2BhlS4XJy6TSe6Nh/c9tDyXMS+IIud7pXhdYnctoDmJQpBWSv1ptdLjajdVJsNLaxawmP/tDGA3biArQQl62Gz6TiIeQb8j7+/hu8Ery1NXyjcEnWUSbCkcyeimmxWUOVhVGDkz8z35dRCCyJwGINgVk+/IbwyUdd6y1qQKYsGpG4sR3YU6Rs0sNWMTu22izQ72Y9ZlivboUw8O4vmUsVnKLAcjvrXeAi4erZWvBv96Mwk2O/HRz7scN7TvdeAzC+oganF7vTDOo4h4QDf5VPIxoKIhHgZKNaAe9OLt1a9miBJrMz/ExNZ+/pE1AD1PTw/hDgy4MVXsMvpiEjsZuFdJ3S7JjQajKZXna2GQPMdw0tDp0KI5DthI1U99XmuyMTwoBCdXOturJRts90sJmeUl2yFIMVkn4aVjZyKOVRUhriU+jqtnQe2UAXnAMCuJb3rDGORarx4AkXzJgU4yjrzxSdiQdJaNpA52JH+Mi6xdcwgsYMMl/mIUk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(86362001)(36756003)(2906002)(82310400005)(40480700001)(966005)(2616005)(47076005)(336012)(16526019)(186003)(426003)(83380400001)(26005)(107886003)(1076003)(6666004)(36860700001)(70206006)(70586007)(4326008)(478600001)(40460700003)(41300700001)(82740400003)(5660300002)(7636003)(8676002)(356005)(54906003)(316002)(110136005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 22:51:20.0750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 320c1407-006b-4b56-8ca9-08db3495f10f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174
Subject: [virtio-dev] [PATCH v11 7/8] virtio-net: Avoid duplicate receive queue example

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

