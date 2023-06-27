Return-Path: <virtio-dev-return-13108-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58EDEB64DC
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 21:11:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1F5B8C8DF1
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 21:11:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 89F50986823
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 21:11:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 23F99986864; Tue, 27 Jun 2023 21:11:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A0A7F98650F;
	Tue, 27 Jun 2023 21:11:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqB7fCHUE0jM7GROQ88X1sln4zCBvtxhr2j2zvUrCgpTM8lSag3FlgoM0xq+8X5xHO/xE3UW5307GGhkF4J2dHkY/soS3UcIkH1s4xw2Uhow6nH3csxj/4eBa+ptvAqgBQv24EHmncD2nMl1ptYwhJMevp0w6dkfpEDG41XE5zodVuPliNytrbUha3tDr2AiK0/pI1pGem6CRdGAWkSUZMohUg+FZUd7R0JK0EbKuhxgnGD4azSdbLZcsH1JV6QS5PMo3dm8o11/HxxCtlQd8Aqx6H27+mD0/MTqLe44zoCViNhbeATSDa0KOMOZYR5I56FdWeRyPOpPrSm5UArLKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqevPKxEkTPCChAP37x59otVRoyPWa9+5ZWKgGRrKtY=;
 b=S9QfqwFmwCd6stHJH7Wcfgbb4FOCuahqQamtpG+swPJ6LyrTo3+euV2cf/xmsxHkztI/EBgYwJbD2VfP0TQeG3JjFFl5vgA/044JSpTWQuuJ7yWlZ172LkGo3su5qBd+btSCvkzANm9ujaRaMqSEvwKYkjj9xggc9Wfkg1+6CztjRBkAoBODr4EWFHe9PkXCkmSQf+O5vkzWaFmDyxHO1k09vzP+qmmTM2LZZug+TiXAsFz7N0AMpxk18mrZiugmqIbzlCJJwIZXM92VXBPX2fijhCm0fPBLtaCdYQogb+E/ckZsdx7sEbJJDyDxyljjMVfxvjadybCQX+Mv6VkyTg==
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
Date: Wed, 28 Jun 2023 00:10:48 +0300
Message-ID: <20230627211050.1527507-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230627211050.1527507-1-parav@nvidia.com>
References: <20230627211050.1527507-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT035:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: be01d7d3-fe37-4339-3daf-08db77530d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XXOt3ZCNzbXK/Myi7YoM8BfjP0vcMTZpqhrYTatIzoRDJUY1qmWxU0tPbKUzUK9vaSt8CoyPDvdOodx5hro484gWpJi+Xsv1L830C9K9yzyd3KGaFN8v96sR/OGcOPfNovqwRv1NnS95S7A5nIIti/rq2/HJJlLl19pYmNZ5Z3oTnWwJYmhoRoNeoym1x5Y2R+Sm0uz6QEaj4nLkE5+XpxZK8eTyfq/02dx8emRN+7oYQGVTxzOAdGCtcQ+t7fajNNZNtLMRFiWZFCdxUf7xKwD+Jpq11UijblLR2Sv8lTpnTpwA2dY/M832jsjE2FtfrMojyW3GioiPMJcUcBV3N3WYU0mHrd4OZLBMJBQNWgUsE4upBmg3JxNc/u7y3fnPaOyxafEOSEvXuOX1RfwNOn+8Uzq5GV4gZXeLZyzlgItwai6Ffokxeg1GmoLELG+F6F1bHj/IG+n5oOE4KVBQWu5CWa5/enR2A6/Mqk7NsyEkTPQrxZrpBLLnln1R4T9r59uC52YFLYIp6oYKTZnyV3A9e/30eORNYVvWkCgrw4raXndrzmNSI+YWyeauZ43PtL/DtrBR3WYjbeWZ6mTkqfgd8jsg2Z8U5HP+3D6DdxPH09YChIAvonlcETAsXr+WlxTxtdBcfS5xAHqkxOytrJWp7TBzFRBgZPeaEmMA52b+w5yMlz40Tl4ZuBRqUUB/LPk8Q8dXo2W3ALnn36Ms7tFNOAaHZeJ3IvK0dCIJUm+z+3sFlEeF9FNVEcqkGZsz
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(2906002)(186003)(82310400005)(107886003)(83380400001)(82740400003)(7636003)(2616005)(16526019)(47076005)(6666004)(336012)(426003)(86362001)(26005)(356005)(1076003)(36860700001)(40460700003)(40480700001)(110136005)(41300700001)(54906003)(70206006)(316002)(478600001)(36756003)(4326008)(70586007)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 21:11:18.7047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be01d7d3-fe37-4339-3daf-08db77530d16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072
Subject: [virtio-dev] [PATCH v7 2/4] admin: Fix section numbering

Requirements are put one additional level down. Fix it.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v4->v5:
- new patch
---
 admin.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/admin.tex b/admin.tex
index e51f9e6..fd3b97d 100644
--- a/admin.tex
+++ b/admin.tex
@@ -286,7 +286,7 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 supporting multiple group types, the list of supported commands
 might differ between different group types.
 
-\devicenormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
+\devicenormative{\subsubsection}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
 
 The device MUST validate \field{opcode}, \field{group_type} and
 \field{group_member_id}, and if any of these has an invalid or
@@ -378,7 +378,7 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 \field{VF Enable} refer to registers within the SR-IOV Extended
 Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
 
-\drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
+\drivernormative{\subsubsection}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
 
 The driver MAY discover whether device supports a specific group type
 by issuing VIRTIO_ADMIN_CMD_LIST_QUERY with the matching
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

