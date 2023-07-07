Return-Path: <virtio-dev-return-13300-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6E0EB64D9
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 03:54:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 099F6866D6
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 03:54:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E286498681F
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 03:54:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D33899867B6; Fri,  7 Jul 2023 03:54:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 87F0398682F;
	Fri,  7 Jul 2023 03:54:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwKUHrOgmVj+rtjOe4610LnKYWshWiRORWX7LIJRC72Sqgs9vmPim7Rof0yW3LuGyrzz3pg+ahM/A8oI2fZsTppTqPtQ+fBDpLTJyA2LuAZuLT3UUQEY5r1Y9qPlXrWisQIePiT1/xAvfG4FXVCGyT0cvOxMtvyVfJvzmkaytFihHN0tDEGxGkEjrWuEbw8W7wK8l/2WSaZaAFXaRK6TSGQBgCbtXqkeTWNZypsIjmritXI/j1tGS98RYYO3eL0YLabne26ldlzh1ivFSD5PI6CMFOEKESeBhS9lqK3RlooGjE0pzlOyFK0yn8D3q5W0PFSf2mLwu6OyfcvYHn2ggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3020rDvIbSD+Pm6taRKcYkS9JZq1yRciqD1CZ7wTRXg=;
 b=Jl9Z3UCIaxz4TN+1E439FGuMyv+cLuCmp+KoctkltiSyDl+PjeRTYmUEaxjsnGZxbNr1J3R7UDSO86bapYkzU3InjDy5uvF8djmjzIvHCvTjU9ALFAQjsrAuZ395Qr9R+rpzt3xM8USDlVtodjMJxIRnLMKeyC0ZvDSshBGF/oVhkAI1y4nuHCjWDXhBudSQnIBgWE+6szWmSxFlsMKNuBD8RKd1aCgBCDN6XA040UMnK9e29REK/pqtXu1xlKwx3SyE8CSV5FgAtayVxbPk56FcDzvr+Qjnm7yE8uXSzuRB8CJM4HSRHo6cTfIwEhDGlTOz857cZOybut7U4Dlmaw==
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
Date: Fri, 7 Jul 2023 06:53:59 +0300
Message-ID: <20230707035401.107855-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230707035401.107855-1-parav@nvidia.com>
References: <20230707035401.107855-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|CH2PR12MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: f32c3f9a-c0ea-4613-6ad6-08db7e9ddc65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3RyYsgnff/+G+AHidb6l4j1fWcF+JdnIJ45CQUla/D8Xmj1LezWgT1P37/Nzj+6ja0kOUvH4GfdKwLuD/rMJNF2uwM63dQQWveueNkCWJYkbuRqO1jeGxN0CFHtP8UCJfuIfjjGnsqHtwsNO9e3pNHbK+tkHWv3GLjLQOGvPJUA4VMtPXSL53XGkM67gnXIlCGe2EeRmCn5BYKhkwOZ5XTmdQqFN+J3gltJFPUBIlblupNRAVS8JzPiAVpSmRoVyINwagbtc6qVb0JiIvlde7AhCWvXZbSWChdcWKh+D9HMY8e46H+Ri9wFSwIK+KzoktBVc8h7ZD5ZNs56oOVZmdZEA3xBSw3FODNL4d//tmxGFRcoxDgt6DYBSWQ0xYDATsURaZhSNXDa+nal+drmQMWsfEKI+VXd8b59pkrTRKut9rThp0kGbTS4227WeqLE2WUVC8Y7ft1OaZptMIs2X8UbBli4DZIYr26wy0lpBLp5AmbIAW7lhB3tbLHtQUID6ZCjQhgcof7Cuw8w8Nde7RIvt5D2fcCxptq0QWxHbMIjrmZPtr/+etVZQZxzRLN2C1wwOZesIQ6cI+bcn10ur0gu9/Ng0PUVQ4IA/w78oRG6Tiz+p9XCpydcVBPJElq4fnm7pkXnnBmg3cddyuRmHBXM/8eg9+noSbx3h5LMpuX/Op+jCuQG56jrfrV3rtTwNGNHeIo+4wD8Vo3u8kovIEhZEr0K0o1Dc5pB/5LaGMRkHtLEPCkyNsOtF2q7z4pdw
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(2616005)(26005)(1076003)(316002)(41300700001)(47076005)(36860700001)(83380400001)(107886003)(186003)(16526019)(336012)(426003)(82740400003)(40460700003)(478600001)(356005)(54906003)(7636003)(110136005)(6666004)(70206006)(70586007)(40480700001)(4326008)(8676002)(82310400005)(86362001)(4744005)(5660300002)(8936002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 03:54:27.2844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f32c3f9a-c0ea-4613-6ad6-08db7e9ddc65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
Subject: [virtio-dev] [PATCH v12 1/3] admin: Split opcode table rows with a line

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

