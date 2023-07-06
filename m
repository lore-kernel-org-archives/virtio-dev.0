Return-Path: <virtio-dev-return-13248-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B10EB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 04:21:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 59D4D7C6AD
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 04:20:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 982EB986821
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 04:20:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 58FA79868A3; Thu,  6 Jul 2023 04:20:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 119D1986724;
	Thu,  6 Jul 2023 04:19:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGz4EnlnsswIVnswo7nr2srea6yMRmFBgvgxZOT0h0xVv/N+TVLKX+IClABL2qERN35uhje4+TNz2mNI1Zmfv5ld+wEGIfd7ULdwBnBMPZ8KNZEkQAiv1e3/uOBV9INCObzN/kUBN93gOvzUHW60GA61kAf2gv9LziScf9UrNCGKpjzGKQDGsdRwGp5dZMg7llbsCkT/ecAWYCMwBglMPzs6AV6Ueoaua2b7/WzQRgwQk2wQMgUEmOdlTsN6+d6ln4WQUfV0bmmb0yqlNDV8Fv+IbDwDBwt8U5k6tL2tqdKYFP9dIZwQI5HOn+V5zuWoa7xEgiHdRE9W44ou0n+O6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3020rDvIbSD+Pm6taRKcYkS9JZq1yRciqD1CZ7wTRXg=;
 b=Wu7Li9Ql2oYEfNUB4BvplMM+eo0Iv0qSytK4awW1StuO47S0zxg0wZLRirwS543oGKBTJ9LsH3kkZIjhgawP1YZ19/hTPK2Er8yonN2iMTv6GDedSh9TVEp6U/skpzvV/8cN9vWFKFAX1o4F5iju3BTj5C84N8a1qx4j5vAKUq36IfEw5vX+vcPDdO1nnT89gm9+KK6VrSGGEK5hoJ3cSkgBhZEiXOfJ3lcipgfCSKN2Ykmqy0Xy78BEq6sXUFkEVbwPPsDuitVuC4/F2ciiI7Bu/vZX4TwQYrka7uIFKESoYn+RvZNguSGVyeSiGR8+hPZK2kd9oYUWd1MeV/2YwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.oasis-open.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <virtio-comment@lists.oasis-open.org>, <mst@redhat.com>,
	<cohuck@redhat.com>, <david.edmondson@oracle.com>
CC: <virtio-dev@lists.oasis-open.org>, <sburla@marvell.com>,
	<jasowang@redhat.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Thu, 6 Jul 2023 07:17:11 +0300
Message-ID: <20230706041714.65600-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230706041714.65600-1-parav@nvidia.com>
References: <20230706041714.65600-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|PH7PR12MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 06725a55-f600-4194-7a71-08db7dd820c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aEMu26FyXx1qnKCWrMh634nB6rj8GSrve1WgoqeaYybtWWccVpgZ0gSB6mEXUnlxsFuluN89DTv4T2aSwy5IBIbm6aOn8PySYqjaSIQN4hyGXM2nJzMnNw4651Y/tU3saF2YJ2tLANpV0Clyu8YSbyfHDCTzcuOqevO88vNP15vnELzufarMmrJuCNCMhI90kVagX8nRyQA2LZDQF8f1xPRl++XLISYoLeJ9L5cEnyj0a+Co9rXfLhvPiSx//qpSE1PdcLtOzDQbGGsGy1uQHhlCFCVL2oHL9VWvRZmF4dY8xV1Aor8D8tSfUDl/txvRhNCveFBvGJ8fmVzp3kpDX3pGb95GtAVaNMOawrZpMsVQl6c6N/zw4cjKuixmPUjmFBDJ10j73FbNwrZmW9VZTSLbrdopDmwP7xr1pq/Gd9IKsT0fSUxqGdXiYQqbMYT3wJNSt2OfqSdw4kizABrMaxtCeTbI8rxBRLWrpBgRNUbF/u77DPzxUpZRx2Q/ZETEzTx5fx1bqYqZRieoV5i/BCM/MNpVJ6usC3CLUoq+NqSmgknhlD97Qqj90kvfs4edRaOZQ1xXpagXheyiZXWBoo1zjgoVuO5kVNxzdjxy1URQjMTFioD3YAnsPa2nFFjauE3zeMpdnbzLdTtzjWv3bzDa9ymWfwPSF6/INzKRDgdFIN4+uuUYBEfeAsS1gwbTYwKIB88Q7e8Nof9IpWmVKpyjNuHwjqnEVOQXPFhPEQ1+gJWfKk/hE58ZbiF8dtsn
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(70206006)(4326008)(70586007)(7636003)(40480700001)(356005)(82740400003)(2616005)(16526019)(186003)(86362001)(6666004)(36756003)(107886003)(1076003)(54906003)(26005)(478600001)(110136005)(40460700003)(82310400005)(36860700001)(8676002)(8936002)(4744005)(5660300002)(2906002)(47076005)(336012)(41300700001)(316002)(83380400001)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:19:01.7246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06725a55-f600-4194-7a71-08db7dd820c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6977
Subject: [virtio-dev] [PATCH v10 1/4] admin: Split opcode table rows with a line

Currently all opcode appears to be in a single row.
Separate them with a line similar to other tables.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---
changelog:
v2->v3:
- new patch
---
 admin.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/admin.tex b/admin.tex
index 2efd4d7..e51f9e6 100644
--- a/admin.tex
+++ b/admin.tex
@@ -114,7 +114,9 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 opcode & Name & Command Description \\
 \hline \hline
 0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands supported for this group type    \\
+\hline
 0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
+\hline
 0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
 \hline
 0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

