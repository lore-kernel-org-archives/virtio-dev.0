Return-Path: <virtio-dev-return-12947-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2214EEB64D8
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Jun 2023 17:31:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 21D3315AA3A
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Jun 2023 17:31:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A3929866AE
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Jun 2023 17:31:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0D75C986569; Tue, 13 Jun 2023 17:31:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4D79998683C;
	Tue, 13 Jun 2023 17:31:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFzQCHz7fcVdF8tLkdt0iJMgAVBFNSq03r92u1FgGcLa7rLo8NgDpPXh0ORmci2APRZzdjtTIyzvzFEF/uTm/bxsMfV0tgfWM/kVNCu9V80pA038Fu6UY+27ZvVMb4UcRX0buIDtolfnnJsG1nhWZJVmwHJtS3BiLE/rPqTWbVr4w8lAfp5NjV0gMs1uEtKBs/rSJxa5UwJCw86Sn6ykeJ/pnlN8cXTxNtYwkUI9haJZ5yMq+1p7BLrJFzMdt3khgj0WljTL2eJ5paZbj8auRAEwKtV+xMd5PCR36DIdwoiHZExLQuNOIJzlZNHiiNglQErpjCxyVy8Mhqb+DHOH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqevPKxEkTPCChAP37x59otVRoyPWa9+5ZWKgGRrKtY=;
 b=KFy9q4HfCJEG6fpk9UZrcNTt7F+E3pRI+jK+AGS3+F07qc9MHxiGKFR26vMozrctjJlTlL8XgCfaP6TxCF0zVoEfkw5JYkMCs8okdfpaUiG0jrID3BY0/iDMbj8AhI8gGxZIHsAZYrAM0o8Z9BKw+5GrWYV02kvUFtl9iE/0v9n5ifGXiwysM+6tPADArORS0KCO8GpgOMr17OukDPnkN5y89tmTj96Xw+jyRnIKhP4ZEKPKSGrRsQRjPiHI0buvKVUf3ycDf+vzEtnn699hhkA6ZpZ8OVEqgefCk9/I9kT9oVjuQfOzhZoNy5fZKV9OxxXi4hGNFE08dAUTqFmw0A==
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
Date: Tue, 13 Jun 2023 20:30:13 +0300
Message-ID: <20230613173015.1244486-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230613173015.1244486-1-parav@nvidia.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT022:EE_|LV2PR12MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a3a06f-6079-49d1-27cb-08db6c33ed83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7YiFs9D5MoHFb/6cgT++AM4DDn9OST54DrzSSDjosTG1X6LTBS3QqfEt9vG5CUki+SMaVP1j4uKHFdkBEdAl8iR0kpKyMI0IpYyxaHaeX2zQtU3RU7cYN6wMkFVWskr21hXgkClnsVfIDQwlEGwrmLdaehKiWQAFGIeEosrhtwPVpWID3QRmzbi1yjc77e/RNQD6WSsraK1wjjm5GxL+6Zf4mcx63mH2U9V1oIHS6dQVrcOUUGvhcMAOCuFi3mp3Bt4DEGo5H/u/OWOivFpAJKoJXBSEipnYyPh5gmNaaADPKsx7pf/9XAO+5LccB4gj+fDCOZVUCQQOd5QaljEG2OLqFZ98tnUW7WdwpPwTJ+wsgvx57OtQAupOqyPi502QAtHHaXbBhZBpCFFJesHu2SqGSlkeTp/pt3LrCqGckYIwKuFgJiY8fr1iB0z8lK8tomesqEyZOo+2WPyvtF65vDwvFJY+PFB3ErIhWffXvNnWHE7QEp5n/AkbS7WjS3niLdvKgUQCxzthNhhF26tXIXpd5VIigYp+7NCy7YyZd5Y5qyYXHNk/7ImJw0mJ/GJcDIhHWT59uzOXVckbGgqu4jWfX2Fy+JPzSTCh1XbPsvAUrArVigTb7h+lW1+A44pfmGcjgnnSgoHFxZ1DTtVqfQ/DN8JaxjzepChhuwag1vqr8DeRpqL69s/8Ft8ZqhvX4iO5YLia6Dh8GG4WkBIk1n1ZD75aE+05z2vp51JW7gfqWzAFcYbBxxJ5naOoAs1L
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(36840700001)(46966006)(40470700004)(70586007)(70206006)(54906003)(478600001)(110136005)(5660300002)(36756003)(8936002)(6666004)(4326008)(8676002)(316002)(40460700003)(336012)(426003)(41300700001)(82740400003)(7636003)(356005)(40480700001)(83380400001)(186003)(1076003)(86362001)(36860700001)(2906002)(26005)(47076005)(2616005)(82310400005)(107886003)(16526019);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 17:30:48.5422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a3a06f-6079-49d1-27cb-08db6c33ed83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6013
Subject: [virtio-dev] [PATCH v6 2/4] admin: Fix section numbering

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

