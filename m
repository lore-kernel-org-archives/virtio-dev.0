Return-Path: <virtio-dev-return-13293-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FA6EB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 21:28:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D59C1A95
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 21:28:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CD56598683A
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 21:28:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BDD8A9867B6; Thu,  6 Jul 2023 21:28:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AB38A986800;
	Thu,  6 Jul 2023 21:28:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQJD/TFyGAhOb7i3aggS6/vV57/BJqJdzo5wJCkIF4S67tgIzdM0ptLKd9SlgE8fuiESC3BdbpziQ//cyGd7BnJd0lhIm9Elt153zw1JRfvK3cVx2aG/1NcRLd6RrcuV4H4OnAS9AE/beVjfxW6nItXlL5xEV8z6UQDddmn62w+QlYpqP7Jb92N7LogycSEOG2qVEITaSyCCtZtO8K5LA1m4UQxa6c0rejSfH8rSkqF0vy2kSQL7+jk434I0nPFh6iPCPgYLPpmqBySgNyiR2puna4KlHv5X3WChFAL1lFWFO6rJPEKVXBRMf7IRa/ZG0gSiUXaYwPQOsV+R9ME3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3020rDvIbSD+Pm6taRKcYkS9JZq1yRciqD1CZ7wTRXg=;
 b=Kd81dDo1WqkJ+pNYVMiN32NxMqLTODjn7RnKsdIPHjlrDg8fNk+ZFMC9njv/3loKGmzzkjkFqC3qD7cNRqSl+R6wEAYvYfZm+3rHZEnO96QGiW+S0dDPKNqx79pWWftptazKDNeknL5bX6ZVVLTaPx+G8r/TIzcx4tDpJ2iS0alndGLu6sM788kGQxy02GViu40N5NOKEM3v7RY/lVgNjze82v5LoIoUeD8xMSIriO5ipIqu7c/WJG2ETCWqYLGHPa77ziWOfX15qclJ7YQTsvUfivyNQ1p3zAEdEP9hNZFj5dB/5Cr0enMElY2hCQxCDdGNTsJ8k9UwCdPOpki2Jg==
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
	<cohuck@redhat.com>, <david.edmondson@oracle.com>
CC: <virtio-dev@lists.oasis-open.org>, <sburla@marvell.com>,
	<jasowang@redhat.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Fri, 7 Jul 2023 00:27:20 +0300
Message-ID: <20230706212722.97973-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230706212722.97973-1-parav@nvidia.com>
References: <20230706212722.97973-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT026:EE_|BL1PR12MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: bc74b531-50b8-496d-98d6-08db7e67d90e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pEddJmHrhbJed4JWGvu8BAy0key20G/NYEZVvFdk5UXBUwHOC5gHaw8+GCZ3YrKHgn53Wjxe5kzlIfsb2yVmy9wC0L0x9+YDV5gnEjvDWBq+DSlFelEJ07Z3cK+4JYATNH/Kubd/hNm4uobxeGZISipQF6Ooo7e3wyHN91WMK3uUl/WVGHFW8m0EQ8pB7sQwn8WaHKcDQfWrPqr2Y9/FinXpQ+IZ3qoES6IM0zZlC6E0TP/mmtz5ywt09gJB+tbTEKl4tT3r4V5kGLdDxtCuuAbPVpffmiV4vOONpGFABSVAuzh7z8hsX0XHyw6x6M6ex2F4YjV1Tmk0TAHpkGs5mvSF3D1mg5VO0FfXAYWaZcblV5uK7+M9YufNHmiod4gQloQXaQYodDmmT0GHKLrAu5HT5lPeEKBOGoc4TEdtbF1Ml6samPR6icroI2VPsyJHu7DQV1KQXYlk+KwNmXbSG2hdhmhjtfkFqq3jD6N4osg5aNYXMFPB/E7zzBerveyh3ssqPi8j+NJo9ISxx+dKYtfxR9U9fjP1OEA+PgiUyPgIf2FVHbCJJ5dUwfrZYje0CIUUrag9u+sOOnSGQmfzrpzRZWFVs3yqpYNYQ4k9PzNjAS8Sw1QW3jIK3JSnLBfuV5u6djBErjF2r1EMVARfwqKPp7cI/RihlgH+zphSuDeuMH/iJ1dtCVHwu6qgMiD3jaE+VOvWmlGScYqMQapdtYqg+34WomElFD4QaqqceS8dMAlKM9UUf/uujjwlH0zb
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(426003)(336012)(47076005)(36860700001)(83380400001)(356005)(82740400003)(7636003)(36756003)(40480700001)(86362001)(40460700003)(82310400005)(54906003)(110136005)(6666004)(8676002)(41300700001)(5660300002)(478600001)(8936002)(70206006)(316002)(2906002)(4326008)(70586007)(4744005)(186003)(16526019)(2616005)(1076003)(26005)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 21:27:48.9369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc74b531-50b8-496d-98d6-08db7e67d90e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
Subject: [virtio-dev] [PATCH v11 1/3] admin: Split opcode table rows with a line

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

