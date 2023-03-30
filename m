Return-Path: <virtio-dev-return-11870-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E67C6FD1D
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 23:00:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AF5999917F
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6136B9868E7
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 082D398686B; Thu, 30 Mar 2023 22:59:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 961BF98662C;
	Thu, 30 Mar 2023 22:59:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVDV4+4QULQ7xWFxB2++fhIfI1BdkOu4NgeoeJq2sGf3ylPkl5QduvNoTKL0ubksDDmubo4TdM6C9DL14FfdSa3RSpaO+0c8DKsO/4st2IRWfLCK9h7JX0yVla1CFmqxkhze3CW2P5A/tHfnpexGgkSKmBMgS8PPsVTNvGmXENpyWkcw6BeEbfy8ZK6+7NpYe2URs5Ak+uOa8dopg1MSbLLIoKLORUbw3FF9F9alu266TjIMLPjPmCSeFDaMm7EF6Up3M+gS7QCGaLF4M5PPunxkQVHFWlAoVo7P6cb/cilbxadJP8D1PfTg1e5mWVg3oRvDlTrqFeG5ldk6Txcn7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9HTrGugx+JNPjQM+wZh8VrtQdUvoYUNK9B6LvSo090=;
 b=Z4jHkErFt+3C7eM3CX06oVcFzHNpPJ22qj3yjPOwch7RmnLz50/WdmxMPHL8U8ngaa8/O+heijNFV3UGxyG4exqg3nvFOZp+verbLgpyIaw2QOJVU5Ds2bxrtw8uY8krPb9m/53aXuzIq4Iua+wlAQXMJCiVpfrcUaLuOTPLbR5rB/2Aql3y3m61kPh79buz21OTkOSPIboyuNUCJPZrGRq4x+VpLaCdfeF37g1ytNBptKAGlx7Q8aDOhvj+q28KJLwcydL8LN/cUnsA795mmy2ORaDUeB2uMLH+PXea5SW/IPD4xmTZICm943LyrlF5VQXPspVTRKB1iNeZc3Ci9w==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Fri, 31 Mar 2023 01:58:28 +0300
Message-ID: <20230330225834.506969-6-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230330225834.506969-1-parav@nvidia.com>
References: <20230330225834.506969-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT006:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ecf66c-5220-418f-4048-08db31726b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6nFXlGgJhwTDMfifRan5fJa0e46JsoF1SekyxaJTu7kJfEFsG9BIo7Ae7MWvN5H1NXCZ0qssjSpS4RifrAKfnSM3ZNatsxCJbAtYM1C3uhhoZEl8YtfLkTUR/7lDBj2J8STGAY8mLrGQ1FtdrdU8Sb7N+0jrLfkT9fmIVHcRHoAkklM/cfLtCnW0Mix+nP5SjTh0y2s/BjRB8+GrC99HL0HLbk2DV7XibNvfxYCrMRgEtXQw4aF4n+e8TnrroRyLsq6Gx29SNYrfcax2BRTsFiTgVnwf73unyIUVnZVX1kzG2lR2/gXTWHPLDjOYycoPoTFkmAF/Yh0mITHPV97bn9v1ix62u1q7HaahYDIbNp2pPZlYBEbXlvV/UOrEH5ytoZbPFtqzihh7KF8d2VbgXrxe1IrHIEWKtZPlIpaDd/CkWo1seFA03ZmznmGFtr9+5NgTU3jc6eRPpJZt+DDmsZEeuigpQDc35+H7xKA1PTjkXjF2XXUEAi2vOS85F6hc/s2AX9Rk+QV1wCLA163v0gsTm6cEG6Uvv+7teHQJZ/m2RxXTHHGvwFHE+4yykVevm8gYKwbctEuatGbbpI/uEUm1Y9bMB+HY7BwJO2CLLhuaP5dNd1fV9mhTTQG5Hr/Il5RN/NJAiH7ZiVEskIqhfvL2S9eanN+YrBf9Av/20f/wrfZbfjvQI4VHRui0Ed0t/6Z7ULMD6j24oEDOxQvxVq4VPk+QRdc2ydKYOo+1ub9PVX54rKOJ90uulBF+knBrq+w5ewQBN/Q0OywpoSFEXmPDojMANF+Bz1R45AHCK7o=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(426003)(47076005)(70206006)(356005)(8936002)(7636003)(36756003)(4326008)(82310400005)(4744005)(70586007)(5660300002)(86362001)(8676002)(40480700001)(82740400003)(41300700001)(83380400001)(336012)(2616005)(36860700001)(6666004)(34020700004)(2906002)(54906003)(107886003)(110136005)(1076003)(186003)(478600001)(316002)(26005)(16526019);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 22:59:29.5327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ecf66c-5220-418f-4048-08db31726b28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188
Subject: [virtio-dev] [PATCH 05/11] introduction: Add missing helping verb

The terminology of Transitional device and driver is missing the helping
verb 'is' similar to other terminologies.

Hence, add them to complete the sentence.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 introduction.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/introduction.tex b/introduction.tex
index 287c5fc..e8b34e3 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -145,14 +145,14 @@ \subsection{Legacy Interface: Terminology}\label{intro:Legacy
 
 \begin{description}
 \item[Transitional Device]
-        a device supporting both drivers conforming to this
+        is a device supporting both drivers conforming to this
         specification, and allowing legacy drivers.
 \end{description}
 
 Similarly, a driver MAY implement:
 \begin{description}
 \item[Transitional Driver]
-        a driver supporting both devices conforming to this
+        is a driver supporting both devices conforming to this
         specification, and legacy devices.
 \end{description}
 
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

