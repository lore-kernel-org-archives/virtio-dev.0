Return-Path: <virtio-dev-return-12684-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0310C7EE26
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:05:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3F7872AFF1
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:05:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 37776986602
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:05:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 278B0986510; Mon, 15 May 2023 15:05:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 13E3D986509;
	Mon, 15 May 2023 15:05:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2IX2LYpbm7w1N8WZUCyj92zEXbypZ4JPm8+4Q5lMuPUeBo5YMODwpGBNO02np9cAdi2N3cxLLmMXtuaqe5kODcO5lFjrJik5blvMl+1dURt9Evg8lCM834NeQwu46p7o3Zst9wGQBZtuNYi2u5UbCzf2OoNzJLcHI75zm+0ynPbiWS3eoHhvtODXgzdSydLgwF+be/3JSMRCZKDgEDk7nMpBJ11YGOI+PweM9E2i/wroK6qReKVNz3lvQ7d/sfkqs8LMQ+i4MejmiU255x/F9SrW1gO0qumrauilQJ1ZZl15S2sEo2MOj5zom+iE8s+sQYKId0ZDZ1jybnOf3WHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ybfgmACHvIEm/vBfOdL4AU3Z8hGieEp1Qb/hxLnI1U=;
 b=n+lS7PHPDArcYU6kFayIXFc6SPQo8UERSy+wlK7eSLDzKiJoveBHSuDw6gxua3h0v330Gx8+EUMBlYclaEUypyDBB8wymuzTtMAwlNPtHc+2qE4cdFc/axPxVRJr2d71uwGDHNyruO3IxT6JvgvKlRfBmRJc2oi++fLavF5TxnV8ozCsFMtNYViTOpgGfSqgswU79qJp3NgrGkYGc1JbEozxYWVyO3bjn+Y3bgirbHgam3aoLFOQakNlF61L5bNgpk0jSxrNyiR1zvja2jL+KlYZru3GUcgKfe0sJScJUuxVRBMd6CelaVPZ4KbnPMqL2gYPC5Y6m8TxJFLD+ue2DA==
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
To: <mst@redhat.com>, <cohuck@redhat.com>,
	<virtio-comment@lists.oasis-open.org>
CC: <virtio-dev@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Mon, 15 May 2023 18:04:57 +0300
Message-ID: <20230515150457.760478-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT005:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: b44138cb-afc6-412a-67be-08db5555d285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hsd/HGBEuZX1uz4xynUC+CPe6cjh+AAE9CAgLqa7IvfkHSCEC2eo21P1qpqWhI2Ih9E2XzPxQMUl4Bn4fGD6Me/77JiYg4WXE2xHsuKFyvs09/SMO86PPOchb38c8k8XP4cF+yY4W2iqZ+OEISPdX3kNgK5FVOuDDAwRhmukzX7zJJOnQAUPPfVabmlVwqnV5g3wpsfMmew858xowZ0ZQX4/Y60YG1Tj87dJyUMTiuPtQHMvcfA429CoEaOnxD75JMGn32msikpPit7Fzu/Ds7Qn0Vijr4kTqLUfY7Ils+nVnTsqDPJyKO3R4ztC9wC3GUxYQeKaMv2GrhqjloA6788NsAuaKx1ww3ZfChWWtc9Aa+jdqGOpChm3+lZBmSlc/+AWnacb8bFG3nTqV4XcqNVzpbF6cDbdnpNFcdjoaKNcT28kPcILshVJGzzKJnz7a8kkThYw7uvW96BTpuR87uAtDEWrT7q3QpN9Dkmd2RIPOP5kDD+kgOgtQMUlXccfUahv+R1WgXFVxU0t/Y4oHc/weD7nscpap0Kxs6yUl0wKYb6FBIOcvK1NfIcxQyryDSIj51LdbMtnLEAzUVt/nitpbKb5B3NY3MYHOHt197ap+0Zu+7Q0HpUWzj/9Zht4QF4ptbmAUFMV4mduyJQvYPRrzp/2iPU5dOdSPLprLAx+Qe3RseFiLH4CVBjfYzcv22s/fo3hfgiIeCoRATb4S+PoVjCNRll+LCNA4fe/Sy4jJuqv9MH9gkl2NGkMXWfaxOFho7dGsSoycMe8uCWeZhGHvCRlY70OOO65/R1XtMM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(54906003)(110136005)(478600001)(4326008)(70206006)(70586007)(6666004)(316002)(966005)(82310400005)(8936002)(40480700001)(2906002)(8676002)(41300700001)(5660300002)(26005)(1076003)(82740400003)(107886003)(7636003)(356005)(86362001)(40460700003)(2616005)(336012)(426003)(83380400001)(186003)(16526019)(47076005)(36860700001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:05:29.4034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b44138cb-afc6-412a-67be-08db5555d285
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284
Subject: [virtio-dev] [PATCH] content: Fix type error

Fix spelling error from suppling to supplying.

This is on top of [1].

[1] https://lists.oasis-open.org/archives/virtio-comment/202305/msg00101.html

Reported-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 content.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/content.tex b/content.tex
index 327926f..9df81b8 100644
--- a/content.tex
+++ b/content.tex
@@ -409,8 +409,8 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
 VIRTIO_F_NOTIF_CONFIG_DATA is not negotiated or device supplied virtqueue
 notification config data if VIRTIO_F_NOTIF_CONFIG_DATA is negotiated.
 
-The notification method and suppling any such virtqueue notification config data
-is transport specific.
+The notification method and supplying any such virtqueue notification config
+data is transport specific.
 
 However, some devices benefit from the ability to find out the
 amount of available data in the queue without accessing the virtqueue in memory:
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

