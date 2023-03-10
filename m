Return-Path: <virtio-dev-return-11602-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A44C64EC4
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 15:05:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5F6933357C
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 15:05:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 55149986766
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 15:05:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 49449986720; Fri, 10 Mar 2023 15:05:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 365F398671E;
	Fri, 10 Mar 2023 15:05:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3vuBhw2zmK70sKhqB9Z11PbtRr0PaOzTrdwhdExyHXKZWyOAWoZhS+XSBfDTq7v5mwBBampcBezZXfGap+dGnatgKX6MVQm6ftjvp7mi039jP1MOwW1aBj5VKmwRHxPT7rZJMS3B21RzWNJ9n/w3cK5qimU2Bc3qbLtFF5kyLJZdaFLmwJqEuUNjaf7fsuC9FiVXTa7c1XqZIoY6OzRcUYIPBxAHkWLXUVEBJ2G0G41gaAG9J2n4P6oqWAJ73Dk8pOCAMnb5F1pWrBCzi614h7xnHyIF2VDDZtd/qBXN62x1Nw+MhOAbzaotbKGWpomgvcOnyHqZDeQUniCjXW39Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ucvy+2zhRTVj2MDETyKta+9iBukvQUq6IR03+1LcvU=;
 b=B1ekruWQUVxQKyBGocCIFdVYDRaBMKFT/ydIajoZX5io/lZXtzQbFyW/yS7uVBDpVqo+hrPME9zCLssppKmXbh5WRzRm0pBo8OVBP32X/HgfPcBf/i5sW1Tq9q2gc1jXFLRce6D0Nas9iIHlLVSqmd0dzMuJVvlZ8Of+shuQ/lDpSoCcuy9Z9CVOFqe0XYKyTMOdBaGuP6fWoYdm8nYIur7kwH3q9kqMFW1vGlMeKw7dss1ZWAVQZ+Cex4CmKaTD5H7VQUJL/r4on+d36oyCRB2025SWJMKfQdhLNKp3zuaSIpnR+erlXpvV4gRSc5f9LB8bR+qozyskMyjwLvVc/A==
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
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Fri, 10 Mar 2023 17:05:19 +0200
Message-ID: <20230310150519.115090-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT110:EE_|PH7PR12MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: ae02d394-7cb3-4441-8e77-08db2178ed10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iRr2Wiz6YAu4crMlmmMTwUHmLPnhkPLxGoAK4I4r1QTxYggHx2yRKoUVH0lFaZVU66b0c8oMXgxUZX1HV9GUo+0ECzs934JiLUIpBe4zs8kHgN02fF4OPeklwTI05RveEk/Modlq/Cc0sdLLFPEAV/U494p8VqU0kuTSn2RxD2sxAN+xkEGETNxbFpod+yn1v1/Ve2VUWS2ixB5Ecp7ZUDqtsjwa/bSwlUFmEusjMLywFdR+G9BmKSFxPCL7q/YbK3O7gaisrM385PJv4VNAXB43DSqyleM/poXNpI3la0Zj2MlUihcZzpb4+QiXm0zp1gG0rfdsI95qr54tebQ4lTuWxRU/gCkOyodZIhwlA/irLHTnckvP7p9V3QIRF9bn9aEVx6JUO+YLAKYTHITp9HlZnc83dk6kIoKYTalsK8PBgUvqmnF+M26KzhZSh+6EIguYStYXp8Vrlqiq/NQyeovLLms5WtNor6VKmJWIO3p50LEJ/0h7tZBzkxrTkGlS/9OarEV3AoUWBRFEJ8EIf9lXaXf2M6f3GPEy0f4mBUty/95whwoodex0dn6eIENEiTA7cXf+wP0/4R4/i3dfX42PpN4JgqbNpPZDh87tbfxBQYY4rV5tpSQbJLghPVVDvufLGPEV3AfFCDUMT7SLDVztUbvfk3nEbXq5QYSBCuQhloJ/8BJHzc2TRCriXTGYfz4W5TUR2Kr7CzJh7Hzeccw4szJK1xYd2j0gFLzacR8iej9/y61v8lWEaOE8gLRt
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199018)(36840700001)(40470700004)(46966006)(82310400005)(426003)(47076005)(336012)(16526019)(54906003)(86362001)(110136005)(316002)(36756003)(40460700003)(356005)(40480700001)(26005)(82740400003)(36860700001)(186003)(1076003)(6666004)(478600001)(83380400001)(107886003)(7636003)(2616005)(8936002)(5660300002)(41300700001)(2906002)(70206006)(4326008)(8676002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 15:05:45.8728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae02d394-7cb3-4441-8e77-08db2178ed10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811
Subject: [virtio-dev] [PATCH] virtio-net: Fix virtqueues spelling error

Correct spelling from virtqueus to virtqueues.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 device-types/net/description.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index 4cd89ca..960a2e4 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1438,7 +1438,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 Field \field{unclassified_queue} contains the 0-based index of
 the receive virtqueue to place unclassified packets in. Index 0 corresponds to receiveq1.
 
-Field \field{indirection_table} contains an array of 0-based indices of receive virtqueus. Index 0 corresponds to receiveq1.
+Field \field{indirection_table} contains an array of 0-based indices of receive virtqueues. Index 0 corresponds to receiveq1.
 
 A driver sets \field{max_tx_vq} to inform a device how many transmit virtqueues it may use (transmitq1\ldots transmitq \field{max_tx_vq}).
 
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

