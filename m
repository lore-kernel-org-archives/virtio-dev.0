Return-Path: <virtio-dev-return-11765-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E624C6FD1C
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:36:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AE1EB759A6
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:36:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A2F2C986585
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:36:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 986799864A5; Fri, 24 Mar 2023 01:36:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 846F2986474;
	Fri, 24 Mar 2023 01:36:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEMPaGkQo0D5wSZB53aNaXaOsEa69Xd0e9WR1dApohj2jzd6tixIrH9nkBH5kvVKH7aWwbVJjqhov89364Fgk+tYoXDcDsrxnMR4wl2OFbW2t6RV5s8UX2t8oeqFaHNe8TOcqFiWJnI005RIN0A81kETaHQqdxqP49scsNgfb/zK5uEUS+rOufqfx/o3nWqFwXRbLfInnSbotebd6V/AjhXjxaKy2OVLj6lQOKg+2U3dSUvVcMQ8OUUT4vKDFZXgdwbsIPLERQ3fRObOE8XQYesdRPV5aqL/+Pg+6O4cgO0UlbBOUITVuJYBrDBomhKPkDTnoGUsgJPS/vJAuO8CzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VgW90ALk8o8HVVkQybtB1/BdshQizPosooca7UsJiI=;
 b=n32zHTrNIJIQZIm3WgYbLo5qJ1XRf61Uca3MgSOO5fo29QX/LSYw84bfEbKYQdfePjJafxUddcLGia9SeDi8ibXtm+nAK5df4olSy/A5g/LRjLUz1M3V7TW5P/zvlPrzGewLNmMwouNCPw3xszbdSmn11I+zht0QWB3cIGhIgKXox83bnmYKpP7DQBTBrPkvfmTlr/+YJqjsT1AiWAwYfiR0LGlKhLQ8672qG3Yx5YFtvGJiMwxnTZTdqukeiYQFTOGB04DO2h2wwYaB0pHc2UPusvsbRN2T36Ya7rDkO3ZfI2XwozQ1/meddsffTWVgrEd2LU7qrKDXYwvuo1skDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Date: Fri, 24 Mar 2023 04:35:34 +0300
Message-ID: <20230324013534.280820-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230324013534.280820-1-parav@nvidia.com>
References: <20230324013534.280820-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|PH8PR12MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b627832-8ad4-48c3-89a4-08db2c081fd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X7SnnJUF0LJQn+IZYfXauYzsy6xqHHMGCmJs6swSOWHwaBkrKNleRmel7Cm8EFTfFBnixn8Sd5DyuhjqBRVfbF5SE5zA8eHhE1c0ifystIF9Qcj5Gm+ir8Vi+II5RbWrCiaoAbdiiBxtBln7iBwXdtLDK+yAd79j81TODIBaZFh3+LvrkllZhnkZrCxvCKP1SlWdXCW+zVsWrKL7mjBnaxzXopHE4cnM3OOwSYfCYAFwuWDARt07aPivnlsezxiPqXfKUvTtPi2ID2i9rGzwDou6ym8cl6GZiYF1D27XsagOspm9lCFSs+wXYeaNWWc2s+rLECYuDeM7LH9H/vq+Xru/TDxxXS/D+Cz5HP/8lksdiWcukZiP/hx0a7yUFFpSaSkLJDfN1EH8iKnvtiUeLvyhFmHXz5/rZVkP06eesbD6Brq8LNWf2C75essTQ7eni9NzxQaJpsEDDTBQTQegiLynr07hohmC8j4LikQros0FGWG6oQIDb3JP+Oo0mTgsUKGzVslnwxAkhiyW1z7MRmiYN/OJXJlEDOYg7Di/GNsSEZyFJawEUoFa1kiJoXvZHc3vfv9CBF++ssjfuo0x2MNc8TZ9/po4N4RfhLCcInqPoGiDFrXOv5918QH/xzGxLdatM/VrHggFCyuyT5yucR0y1pzj8uFmT9rx71r1ipWwPgeE/X0NAxJlrTyV61N3Fjk9+MWpNzoPLO8FYyYw2ShRAZsGu2xMz926If9symZKDjauvxMTGvNdUn+e6Eeb
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(356005)(40480700001)(2906002)(40460700003)(83380400001)(478600001)(2616005)(336012)(16526019)(186003)(316002)(82310400005)(36756003)(86362001)(110136005)(6666004)(8676002)(54906003)(36860700001)(70206006)(70586007)(4326008)(107886003)(47076005)(426003)(1076003)(8936002)(26005)(82740400003)(7636003)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 01:36:00.6212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b627832-8ad4-48c3-89a4-08db2c081fd1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721
Subject: [virtio-dev] [PATCH 3/3] transport-pci: Improve queue msix vector register desc

queue_msix_vector register is for receiving interrupts from the device
for the virtqueue.

"for MSI-X" is confusing term.

Also it is the register that driver "writes" to, similar to
many other registers such as queue_desc, queue_driver etc.

Hence, replace the verb from use to write.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 transport-pci.tex | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 1bc89b4..9d492d5 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -367,7 +367,8 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         A 0 means the queue is unavailable.
 
 \item[\field{queue_msix_vector}]
-        The driver uses this to specify the queue vector for MSI-X.
+        The driver writes an MSI-X vector number for receiving
+        virtqueue interrupts.
 
 \item[\field{queue_enable}]
         The driver uses this to selectively prevent the device from executing requests from this virtqueue.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

