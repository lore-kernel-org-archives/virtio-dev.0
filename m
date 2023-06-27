Return-Path: <virtio-dev-return-13109-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820EDEB64DC
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 21:11:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B73C3157EE6
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 21:11:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ADF6A986677
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 21:11:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9DD6098642A; Tue, 27 Jun 2023 21:11:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6E8FF98649C;
	Tue, 27 Jun 2023 21:11:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWEO5bZdED8/vMTeSUtw2R8aslLc5MBEmjLLX+mhgqOECuTGXo8+6EiLxOc6fpuji6Xh6qKBLNQgh1OTxoxXvzhBCJQuGw5RNmnMb9AjUz3CvdTkG0g87/wwSJbnZ+Y+1R2tMrCMIpINC2iYLfsYs7/uSembojP+bwlw25HzWuPT6MF650d0Vb2/lMzo5mtJ0SUCXDwIVuIF11pSllT6FUCbYzsI7H8s3MENzqOK18i64rm8MLLn+C3SCZwX0M/FySIhGeOK61hBIB0DA1abKMNvw4k4P8iFz8wfhzVCtbPQZYrBKPNRWmbtAcO7+oNCZPuG43RaLUT8hy2XkJ2CRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpnhhKY+AZMWGOlUxfddk+CfiwFN+mL4rsv45y7CulA=;
 b=L7p4XNI0xwk5L4XXo6PXQB4IIkv/K8b1kUJ+xxie7iX4k9WMovxZW2pPoEiptvdD5PkslmYlhvBXRJ2XWBfNclXLTZc1nM0FQrSSLNqCS/zYSuD22MhVi8N5K/qBmcX2pzXhx6bzQB2+cyXUwBSMbiH/jRUCKaL9IVAJUYskVCEX2Msoezot98ngmF/leaI2lwCCGWWJyqTKjXbSKjPwuSnYATn5HT5ibjPhfOTAD2QjpYBiCAMVlVRoY1PpcjwXpVHbUpClP4VcytS5hN9jcRE7W7NbDzkfM8mW/ZX5VXc5KIAFt3ZwH0x3aY5BPv+OK96XJRdct4NXqoFTXMLf4g==
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
Date: Wed, 28 Jun 2023 00:10:47 +0300
Message-ID: <20230627211050.1527507-2-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT072:EE_|IA0PR12MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f28cebf-5baf-4e3b-ddf3-08db77530c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZrpsE3h7HwMroEOmM5cG7GNhTIWfB22V2A3l/AXMb8FwUFBwtCHazUdG+m/s7BZtYiP1rgb8PoAvMfVqZDfegn1ZkqnOger8gNtb1O2cW2+FebohiNwm8Nn/MoFwlXvILSoHfAul1NL6xrjD1FMGztUuHy/u2Eh9JI7H4p1e8aeEldnj1dmIbG0w9I6bv6DkRvXwEP71FUUCihBGa8hY/WlRYDgq0mAL8p3DaPXsHXioA5v6cOR0ZdTJIOuVvuc2WyxT3db4bh4nkY3P5XZGuv5YAvKHVWyp2xA08T+EgTcI90l8TNhN/rqJhrq0QsygM9+eDbl82LupAOV9QKhG9jcHm5TpoIdN19NX/DPuVFsUC6cuDNrFq3Aw2AsZEtBOXXjgRzGsJKb36pqN57QTh+uVQeZ+FuHczL+fR6URHijFWVkmdyfEHsTgwtxoeLe2nnnWthsHb2Atwm6NmcKnTjc0wu0cY8bbSbSL0MkohUgYbupEPBpxu9hhXTnYN4IkSHrO5D0AEkRpLGlbiC2Nym6unXOG/K1k4rD7atM+LR4sy9J6CvIy9WIXizdKFQUNYD1rVJ8oDM+uD6sWOAk61FGk+8T+YxuFaro7dh8UyIAtEPP+IT4yl9H5Ow7rsvgr9sWd8IZ3Vzu6mxCQ95TeGGuihFBGVAxWS2IrNCYKffALG6dWw7xEVKLMpgcNNgZTzHaynV9z8kS0cYA+PZqmGFj1C587r+1EZUuzXFexjMRMYNXRIClu2BPyYwgVnDsF
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(2906002)(4744005)(186003)(82310400005)(107886003)(83380400001)(82740400003)(7636003)(2616005)(16526019)(47076005)(6666004)(336012)(426003)(86362001)(26005)(356005)(1076003)(36860700001)(40460700003)(40480700001)(110136005)(41300700001)(54906003)(70206006)(316002)(478600001)(36756003)(4326008)(70586007)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 21:11:17.8371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f28cebf-5baf-4e3b-ddf3-08db77530c91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8863
Subject: [virtio-dev] [PATCH v7 1/4] admin: Split opcode table rows with a line

Currently all opcode appears to be in a single row.
Separate them with a line similar to other tables.

Signed-off-by: Parav Pandit <parav@nvidia.com>
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

