Return-Path: <virtio-dev-return-11724-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B333C6FD1F
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B6B2B60371
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B08A39864B8
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A5570986455; Wed, 22 Mar 2023 21:53:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8451898648B;
	Wed, 22 Mar 2023 21:53:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRzOJmdzk9e2bdsAYwdsLAFaqzF9RqoZAlkeM+4h+J+3/b4HgchrdKT/UDfpuLKnLHpSj3p9WhDSoWumFsqDkWknu0eyKs3un/w0+GpTX3wEww0C9CLl2fcipve04liBBnMF3Igw6TOgzlMxKjkl6OVsYZTJJS/oRamSLxYrC+zEZpNRqXykqOJD3Pn6WsqzGq0jjxqr2YNShvqhK4K2D6PmbQo7UaiEnlbE+NHjuHWZbQs1kf5BFfsHP2eOmL40MeLLCnr5wVG7f45paJY1pJ8KZYsXQR6tSGFfFkVCoa/JbINsIMhBV3ofaclv4N50wtphUCabmkd4Wg83tLXUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zScwm1MtdLjw4GnXL0eryLQ3iiS/+EeFqnSFtrsCQjM=;
 b=FliEzrkdx8Y4UTkihM6P6JzV+FuIFYnwuFgAtUXaXwCJQ7wcMiqbCQq51Szu3mdRXO6ZjJbmhOqJAuukVplfNK1KtI7hrDnK8wd4w98x2OslRUeBg+pJc86mMKMEKQLYIbChSPp1acWYtn2TI1VaqhqZYBVEZ7Gl9OQDL66sHkgR1Acts7TbYmcoVyKHZJnb4Iq1qlsvUG87dA82cFgEdJI1KxtuLwXp1e0FiQBeSIVYzUOiAqtYOl3WbsLzq/JLCLtE0LNTK7XxeR7oc4PqhlwPlcqQx6T74HrAONzSdYAHtxO/imz5yEeeaVmNvBzRRtsAgqclQD4cJG+Vt1pGdA==
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
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Wed, 22 Mar 2023 23:52:36 +0200
Message-ID: <20230322215243.249524-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230322215243.249524-1-parav@nvidia.com>
References: <20230322215243.249524-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|DS0PR12MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bee68e6-abc8-4f9c-a379-08db2b1fd127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y+ol9cTCIDU7RPc63PWVhIEfcVoAW6dWm8Y9mLQeuM2db+T11j2QcUlu6JcQ8sxpPwrUh/EPKZ8MoKaA7+qO2MJRWkCNc6j6U/6/I5BM6c2E8/j+GwYcWbIkNVe+uTKrRYh05p/dvhRd0yRoT+WVkI9IpflSngqgjs357Ky9b91P4XFhrgp1LFwVlwECA/l+ZqdC9fFbhyIN3/MFUdXJDQhNx4oJfnQ0Bls79/arw/J677qBGI8z/acw5gXlBzJGRwYgzHWpsfDtsInI6vWcekM56na1QaUjppEHZ0aNL1j6gUyjusrhOm3KTOk1Z4Ao1V2OY/gEebRcky9pQ3JBVHb3KMWrjkMsTVzubcCXOTqKsPks96Y0S04kR2/yM3Pnq3EB9Fm5OWW9t7SX06oCEBeyczyt4Ze9JPjVMcctXUyeRwqUsTcBFE7jyos3HdjQruZeGPnxZz/D7IxjusiYQFea3HACdhG0iBmiM91DgwKn5ifsCllLq+/3N7NkpXbKDo0KzziJ2Qi8SXj5012GWBvTsfO9tVSeIYEh5HBRL7gnZEBaSO7D0w/fAC7E6ngalBjI9RANZmY/08A+DpOqDpzEg3Ki1IcdU7qTyElAd5QRqR1vuV4LfiS2dFr+CT2+rXtnCxUh0uSiF0ZbVaKf+bxPdyEQLUoVZyEeLNqXM51QpdDlabb3YAve16F9TdHIhiC4sYN5R/0v9V46Qf2wogp2kn6ruz/l21VIOm9oBz/ploTsjD4a9Y1PhYD7GgSIbCeDK/XiaC2ymRH9plHhojb2YXz3HqjWx/XXgqdoTo0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199018)(46966006)(36840700001)(40470700004)(356005)(2616005)(336012)(107886003)(966005)(26005)(1076003)(16526019)(6666004)(2906002)(83380400001)(186003)(426003)(47076005)(40480700001)(54906003)(7636003)(478600001)(40460700003)(82310400005)(86362001)(82740400003)(4744005)(8676002)(41300700001)(316002)(110136005)(8936002)(5660300002)(36756003)(4326008)(36860700001)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 21:53:05.4667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bee68e6-abc8-4f9c-a379-08db2b1fd127
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392
Subject: [virtio-dev] [PATCH v4 1/8] content: Add vq number text

Introduce vq number and its range so that subsequent patches can refer
to it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v2->v3:
- new patch
---
 content.tex | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/content.tex b/content.tex
index cff548a..1ab7794 100644
--- a/content.tex
+++ b/content.tex
@@ -321,6 +321,9 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
 VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge
 might allow optimizations or simplify driver and/or device code.
 
+Each virtqueue is identified as vq number or also referred
+to as a virtqueue number; vq number range is from 0 to 65535.
+
 Each virtqueue can consist of up to 3 parts:
 \begin{itemize}
 \item Descriptor Area - used for describing buffers
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

