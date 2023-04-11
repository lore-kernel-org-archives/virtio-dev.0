Return-Path: <virtio-dev-return-12147-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC8EC76196
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:26:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 86784157EE7
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:26:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7F69A9864B3
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:26:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 73C4798636D; Tue, 11 Apr 2023 19:26:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F6C998636E;
	Tue, 11 Apr 2023 19:26:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJx7ajCdxdhyEfqDDVhAFOnYVe7j9q144LnKtUWkKcIKzLgkFeJKueiN/jTjlFrnwbxlIeU1tuPC2qMpUo1L/lDVxa4ZXVIGKjIWIKwiqMwptRo6pDbM32hLVh9AdOee5u7csv7CLXbL2/ZK998AMpXuYpgiLrzw4czGQmPO/I+vlKHM3R8ILmjURVDE9qVtfLh/b/2oNB20i5oc/ldgefUO4nUD0zZPtHHen5w/A1HEZ/V43NDl2ZF5fc6KQqpScyXDhBLzK2mrH7z3/VLflRHQASFp6+40W8c6karISs4wZg151Gbtp+PAz0JFtAaTkHLcxByunDyHRGn+4ytoAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9HTrGugx+JNPjQM+wZh8VrtQdUvoYUNK9B6LvSo090=;
 b=gb//MlGugNxk+pWJabT++ptS1+cU9pzEuaZSyx7p/D7GWg/l/wx3hmq1T7BXbAhH8dXfCTYgODFNQ1rjNTiWJxSuhOWOCHRbGhN9shb9I/Y+VFaz7ZTuZ7spdXFPlB3GdLHwEymG3KgkZTGjrPVXQ/Zhxbi9O4hwCOyBNzTPVIiLHn1lDqMkypQAR2hAwjqVyi7L/xkFIiXv+sTH2f+DAMP1Gy3xFdHmXzKrHPyuTxl+jFDFnqDS2THDMx4PHqoSwTqXq9fWxjmd3ekJuI2K6IC63uks4JJ93y2PkNLfx1UTszC3KpFc7uiFk2zXnrjwXAtu060LwM5ZwlDHBfbsIw==
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
Date: Tue, 11 Apr 2023 22:25:54 +0300
Message-ID: <20230411192554.751994-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BA:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 726b3893-a2ed-43d6-0890-08db3ac29f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lxY9YnQdAfUkoE4ko66DmPf97BtHIrMvk7vN0TxVxgYJP/SXfcaiaDi2Olcn7hjV0j/L8Z4jlz2+0iSVlrLqIIIXy86rxkGN0WLPDa6VKMcqHQXi9KURjgF01pKjPR8Vx3H1g/3bHKXJ4ht8b8RH6Kul+6m6xC22f5BAH/oungyZmHmajE15AIhbBo7XbM2WfjgLWvPo4SlkZnwncyKVVnyjSIdjbhzDR3XB/R6J9hLswRg+YqfMHwxRnLCwXt4p7wmemusMXEZLWGHJra8HIYMxbQV0VWh0N3y2v18npi+kRGShl+jrcnfhlB8vN6wi0B+YLBlShCOjS4trJ+ulsmSpz4Jzs8qd7S0LpqiW/DcQoHcAzK/qqmpRZyj3dfhzmflULoiMCfQNB2sSQjf6nETsgKU8Wp0Ic06vSfzyKPsJcDQfSrBi7novKwqfI7jPymBZMq53b+70xDy0sB0h4PJYLQVmNPq2wImKULblAKnFlZJefRWTeFPoGJI5AGLxF8dBdiovYsEMJN4sbNjXUrOEEFWfd+tmoqHZAnf1hEt7f6yghHLNeXKL1IlTYkrCVBnSmRIE9E/KRlqdbiwfyS+LHrp/vMlcdW8hsMI3rVUuJWugp23QhEJ096Bb986hcBpdzKLNS8CLrEWl6sfyADSE5VHREbVNAvLn3BQZSr4WWeXcpqTtZzg6Ex5Xhp/u9Av5bIMxHm+Qn6y0YwNdceTdaSwuj1rI9CGfxI5HmFEHGtGEuHDyQ+KEMFlr0Am+
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(54906003)(40460700003)(70586007)(4326008)(8676002)(36756003)(82740400003)(8936002)(26005)(6666004)(186003)(107886003)(7636003)(16526019)(86362001)(356005)(4744005)(41300700001)(82310400005)(316002)(2616005)(1076003)(5660300002)(70206006)(110136005)(2906002)(36860700001)(47076005)(40480700001)(83380400001)(426003)(478600001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 19:26:17.5035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 726b3893-a2ed-43d6-0890-08db3ac29f82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF000145BA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
Subject: [virtio-dev] [PATCH] introduction: Add missing helping verb

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

