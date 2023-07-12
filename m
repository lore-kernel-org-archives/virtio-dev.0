Return-Path: <virtio-dev-return-13358-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56442EB64DA
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:24:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DF06F1CA24B
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:24:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BEE469867E2
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:24:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B3E869867B8; Wed, 12 Jul 2023 22:24:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 962A39867BF;
	Wed, 12 Jul 2023 22:24:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcdIXAMDCC9xpzHc8M45+NKSK9cendwzqaoSix5Rd67o9YSU3oqyMSdxhYEiecdlvpVNzBzCfNG3lho9f7U9n4q2Q5gSmdP9BqJcl3i6OLUXx8B8d1gWhitgvFSCFbJqAduWfbjCJJdV0dTAbaju/iQbXx1RwYFED0zK7ZIdtsUwyI9mxIWigvaJIHJbEomxn3BsVXLLFeuFQtqjqzJK0TFx3eUqYvyrT6SyxIQBRXH+MYuQ8uQZ6dGzueJu8aRxfWxPmt789KCU73Uv392TpLgW1n9wJI/dt65aCcvp1yyiPvElexIRhdKirdjfqlZyMgMzvWLKftgcLHeWqsAAbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZMujk5InFmEfuilWUhY0gwg1oSwgu/rVCgRBWApzCc=;
 b=LUYXmZGTFJX30/a3YLiDrrqIlDrfg2MiLtuCCJZlhxB1VTPaVNJa1vcb7aTF2XnwiuBk4WI2Wp2uwgwWt5ksTUExHX925wmd8NQRAVkvmlcRS1xDzV7EAG+rVSg8O7TG58HNwviDMtZvRnt3ZfqIVv1vNoJRuVNAIi13En+CPBL+zZYwHzG9fbXhHwPVoCRqbZpivhiwTTDYa1nsnUS/maZ+jtMeAhUERT9RRNFPeNdRZ6vw1KF9p3OnWw2kiLjXYV6/uLyaSLkSPrcLo/U+XfhjN6215ZcQ4noZuim9aVR9DsYuk7QZ5RKBb+Uwc7ugZpdaTIU9DkaVE2poQRMzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.oasis-open.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <virtio-comment@lists.oasis-open.org>, <mst@redhat.com>,
	<cohuck@redhat.com>
CC: <virtio-dev@lists.oasis-open.org>, <hengqi@linux.alibaba.com>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Thu, 13 Jul 2023 01:24:01 +0300
Message-ID: <20230712222405.455201-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|SA3PR12MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: addec0ea-35d9-4b94-c6a1-08db8326c1bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iJjZTPBtqNAtxk+N34DkhQhDCiM12uRqnyonnLMRTAPNf7vD6+VkEVIOn8KXdbquPncuBcVf63/UcHI/nflaId+NfGz/DSI8nAO4ObA1wYVxMcR0S/dMyEafmX/bipa2HpwkcaaiShV0UcPXKfEumuM+PuOZ9NuqQW12theD/MySpyDuDanudZwVM5PYYFXko30Vj4hyQf7FV7ZYzvbio1ulW3xEMqCaeIRbYFggqf8mQuNyoqhJA5oC2vZBRWb0AMaBXd+VV6wepexdHzgM6EUKbiCVPTM0qqKrzfHDKwqOgdrIU7Tg1h4uHBVaZ8ltMIoPFO7oaIGWIPt/0Ny58t1x8NFoay2csa1O+4yEovFtTHFYfQVSGXSLajt8NOcf4ht9fsSxLVPP+Esku4VAdqSRqJThiL9Po4gNlCjuJ5YUCjEz2lmryPpbeEfVdXJg2ENJeQFQGK/wbeLTT9zjtRvzinU4VqAdtoCeyO581iKxXzv57shQPb4D7tqnIZrMznrbsq4ll4bnzJWexa4JSyNp2Cn3P1p/V2udOe6booDr2EPCBUWZJhe9XZxshiyP/Chx9FN0ehcW3Jh11U9WjGlXZBQlGRpPBjpRaM3j6dYDABs1QDrhEYqSi9pjjNN0tWc6FBjW6/vVYQAi+0t05sUY3A1EmwpzRj8WB34kFJRLSOefXCKWs6seOCXngCwyXAk1EVZX53Z8QtIZ0nCJOOm+C2gBG+zi7v0RWOQppVJ2H1zrYdr7UZQNP3Mp6erQTR7GqnDQQqZttw1xjJxnPWH5CW45duC8/FsvCWLWPKJI4073KfuCHQbPL501QABl
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(4326008)(70206006)(70586007)(316002)(2906002)(4744005)(41300700001)(478600001)(8676002)(8936002)(110136005)(54906003)(5660300002)(36860700001)(6666004)(40460700003)(966005)(107886003)(40480700001)(1076003)(186003)(16526019)(36756003)(426003)(83380400001)(336012)(47076005)(7636003)(82740400003)(356005)(26005)(82310400005)(2616005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 22:24:28.4217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: addec0ea-35d9-4b94-c6a1-08db8326c1bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9158
Subject: [virtio-dev] [PATCH 0/4] Short document fixes to inner hash feature

This short patches fixes the editing errors that stops the pdf and html
generation.

These 3 fixes are for the patch [1] for the github issue [2].

[1] https://lists.oasis-open.org/archives/virtio-comment/202307/msg00024.html
[2] https://github.com/oasis-tcs/virtio-spec/issues/173

Patch summary:
patch-1 place C code under listing
patch-2 avoid hyphen and extra braces
patch-3 use table as hyperlink do not work well in C code listing
patch-4 refer 'advice' as 'note'

Patch 1 to 3 appears to be must in the testing.
Patch 4 is not a fix and can be done later if it requires discussion.

Parav Pandit (4):
  virtio-net: Place C code under listing
  virtio-net: Avoid hyphen and extra braces
  virtio-net: Use table to describe inner hash to rfc mapping
  virtio-net: Use note instead of advice

 device-types/net/description.tex | 45 ++++++++++++++++++++++----------
 introduction.tex                 | 15 +++++------
 2 files changed, 38 insertions(+), 22 deletions(-)

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

