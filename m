Return-Path: <virtio-dev-return-11846-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8054CC6FD18
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 21DA68748F
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 459B8986745
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CBC77986826; Wed, 29 Mar 2023 21:24:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A71579864EB;
	Wed, 29 Mar 2023 21:24:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1kKia+SBn/73pZKpZZ1kvI3mTMEntBjzhinRvDy1YH2QLao0FJF++0/DP8V+vCG9bSNy2XnXy33r67oIo/G9rKa7vgn2QumjxIYthIMQchLMm9nQDcDfjR9GAF4Qr8jOsPWH0JA8NZ2D4pG6I/49GjSt/6odbP/KPjIlRDsI8Agjdpm1+FgsEAL4X3P+PNrTt4T7ghPqp9R04JVZz2G42LaNRKrVsDfbRX8TVmHVyAhBSZsIw4cbR41RkCot7gBqt+8G7ldnBLUMnRI/Wj5xPPXcm+AencNSgjvwZ4OhwM2PKDYIFW9hSp5D1U95N2CroFRVkhG7pLQJiRAGgjQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5jDM/zBgLmG03A1xOMI1j7pa2ZgEQZZgg991+/1x0E=;
 b=YouAddifN8ugUrJ5+z1izVpjTmYMiDvA7FPcIkVjRcoEuU1j2P+xMXFG6OfWSbGbXmBxUkeAwN7dXVQN0X7t8AcXybdK8RP8TUard9tj/eAYd33AkEAbAhTWVPKuYZdbL6HNDgdVfSPxEm7u95ZF7xlv+ysyTuHjsQo1QaUefo1Gdufs59dUX3NnIH8PsmeQdcMhjj3O4sQ3gdDz3Fo/VkLwo9D7BdUite4f2kXArXJ8xfomaew2CJml3z44WQLjqot0nNwhpw3YH+U8WPHWcSRagDYGgYjGgP8/ezl9UD3pGlKWUzMNpDYLKvgMk1fqGZxF3HNUnpIzJFP1MkG91w==
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
Date: Thu, 30 Mar 2023 00:23:34 +0300
Message-ID: <20230329212341.465843-2-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4e5375-6e48-423f-1386-08db309bee2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+EcxDXxfcQtK32i6zNv/zFlxz65Yzb+REdV0n+gJaX0Yna6Am0py+NYmRjwoCCICc5YrcZBrC5tvfit94PKAFz960ybJ0QpXFc+4sB5GoWJGYX9oixzc1SokmlYlOjo14qFpCyCsTcf6rwvDc10DfqWlGGFm2PGeLzhA1yZo+vCe/q5p+BX4ldW+NK7lJxiS4Fpk+3QNEZRujAYrAspUUGGfLJKhqL1GtSOsL9WIklEg4Ywfy09mibRXZkjJ/Tkrh9k4XTpKGIfWAtcZycXBZdsKa4mq8EOdNsd6PksLQ6CkHuCgErMZP1Yb0QQGaEZcXDpxPPU1m5PzNIkp+aFDUWr1H4FmsB+apwJXYLWFq+GzA9IK30nHSXraha0QK5Yap1UKZ1CKPxvnNzH0SCCVkmFvY22QCE3+Pa371+DdBPe2Fag08j8RfVQzA+byVQQ8sx5pMSMt08OG35sGxqu8txPNgHPoDemgSNS3pVen3kamG5oJsGV4DHPahX+Sie8w6u+7hfd5C9NO+8FUC+tBEDRrg0qQQBPJSPlyE3cZgYp5DzrawMp3iOFb1bvSxljm12XTd3ruv85AwNWlem5ZjxJCpWc6H5B5faxgsVmv3a9KL9VLkPEAxFmprEsOIPFoKviUO0JLTaQSPpAdrOTwXSxnQy7TiyAng1q30jjDmyOfl1kUIcHVcGGr1ujWaAb1l0e5/7yVjSBkA2VfVeipp1hZ041jOVJCbVmANt9mFHIEv5qEKndX+aa68+mQscfVcrV7vU5a5kpNr220QiYPgHysi8oBnql4Low4goYkB6+B4Dpl0LfviKbshMqvE8E9
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(1076003)(36860700001)(336012)(7636003)(40460700003)(47076005)(54906003)(2906002)(40480700001)(2616005)(426003)(83380400001)(26005)(34020700004)(186003)(6666004)(316002)(36756003)(8936002)(478600001)(70586007)(356005)(82310400005)(4326008)(82740400003)(5660300002)(41300700001)(86362001)(8676002)(70206006)(16526019)(966005)(110136005)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 21:24:07.5021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4e5375-6e48-423f-1386-08db309bee2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840
Subject: [virtio-dev] [PATCH v10 1/8] content: Add vq number text

Introduce vq number and its range so that subsequent patches can refer
to it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v9->v10:
- added braces around vq number wording
- added vqn as another term for vq number
v8->v9:
- added inclusive when describing the vq number range
- skipped comment to put virtqueue number wording first because we
  prefer to use shorter vq number as much as possible
v5->v6:
- moved description close to introduction, it was in middle of
  queue data transfer description
v2->v3:
- new patch
---
 content.tex | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/content.tex b/content.tex
index cff548a..7bac167 100644
--- a/content.tex
+++ b/content.tex
@@ -298,6 +298,10 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
 virtqueues\footnote{For example, the simplest network device has one virtqueue for
 transmit and one for receive.}.
 
+Each virtqueue is identified by a vq number (also referred
+to as a virtqueue number or vqn); vq number range is from 0 to 65535
+inclusive.
+
 Driver makes requests available to device by adding
 an available buffer to the queue, i.e., adding a buffer
 describing the request to a virtqueue, and optionally triggering
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

