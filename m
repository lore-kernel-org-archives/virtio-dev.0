Return-Path: <virtio-dev-return-12139-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C70C77B6F
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B48E233572
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A45C09865B2
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 96C7D98636D; Tue, 11 Apr 2023 19:24:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 80513986652;
	Tue, 11 Apr 2023 19:24:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNkTkoE2chTUPeVqqA0IO2yPziSjuXiK3iuqXX3blNCYrVEry46yI8GfJ6gUmqrwsga7YL1pY1wUMSRy/Nb7PLmmYp2V4SdS2M/pXMYLAxK3oL893+RbX1WKG7t7LN9JYn5CP8HgMWrH55/aneYM16vD2T2XqZKBb/bl+eWEj/xvaz1wGUy6ZdwsZvYSf2dZva4CXEJYQ/gH996GQUsZGuAsxVg0xMc728bc560mMtSL53llLiL8l0j8DnKZ3bPk87v6YE/iLyKXl5FmSJXWN8D6jt9HSkP+Ry2r8179vIwfwx8k0VIgZxHqwc9lIgT78thKD0AdyX9r0SBtyIEFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIFtFnD8XInjSH2zCVzGRPxv4OStcMCBAYZYhJi2Wwo=;
 b=LAALISrFmM2GGMwpa273DnFdsn5aYuxFUUg7VFRAmsFmnkUqMTQerZkIIicxi8vmcjeuOJFSgJgbvZ63s1TtaghEKKLV7GKpbiSjsUlJJeHZ9yZTE9in+beDJ92lKfR8RfVzOs+R9fIisyJ/+x+snpb2sFo0XbuhTaErQ7tpoEGK8j7el9XLQiTPk5SL79DV4beH3x5yEYanXhpeQTcJ4y7R1Y1d0qToYLzo2K0Mz/k95NL3r8LbnAzj7RWA8QRuyanJzIabzVqadTRdAo+CvCU7h7XJD1G7HXxOcuHOsXIgydHVWpab2r13kudsnlZ2Ow58AOjqxMGFSo3c032oXA==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <sgarzare@redhat.com>, <pasic@linux.ibm.com>,
	<virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Tue, 11 Apr 2023 22:23:38 +0300
Message-ID: <20230411192341.751841-9-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230411192341.751841-1-parav@nvidia.com>
References: <20230411192341.751841-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT016:EE_|MN2PR12MB4335:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c0340f-ca83-4d37-6b2d-08db3ac25476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	678jC7+pVe9gpIa4sREtW3xKuZbRZCTCQdFfP/ZY/4XE2+33wJkWbBKf6CxUhPqowR+qocHZgpoek2L+hOHtRSX/uphwNuyvMJXAZTQAfZEtH07fet5UDUTNjMktVkYIWPM7iLDs/f7qcfm+f96I+qiRH1ic2nbIy6bW0D2SM09lMhebXku1GzCsSdRFWsz6Y52aKqWpaFdAfU7K6vz9YfZ72ehZDiDJsdyn+koioHfasjkym23QnP6OYrDIporwglyPF22NMlJq69e8DRcNPLq1x5bOy3Kq1vw/bmywHwJTaKMfAFJoBao22vrsxPlZWvODSzn5aqAeCZ/DjhpUrZq0fUFST0Q6rvniT9/MZFmkUhhg1t0pmNhmhve3UTRUoiuW7eeW1DRH2uvMipQapWyrsBatN2MQuvz3lR5GT5XJ6Ge7MWn6aKcyWHeJmXHiENlRN87m8gOjYXCNkWTmyDLMVBpTB5NV5iitgovQ+ZJvRTIhGj4dnsHpSza7av02nCfHqlxKhq+7JYjBLHcY4aPmJj7I530CZV8JdydIHwG+fi0iFxiaIpYWXC4f7u0gakKEe8PfS2uuykiKCmS/5BSRZCCl2qSgnJCbjSPy+CYFcMued9Xoo/ZoIulOVlVHMYCqnQ3vz02wFjgOv3xH4jXAT93prAk3PRQtyLZvUGeDQUzGILRgzc7sV1EKQBenrT7kiot6GdgL5W9truihtDbaPhIUbm/nfVd4H0plTfgNT3VY95Z/yWXroBAqr23rSk0Jf/wJRWNNHEJdMdbhzLhgYFmAYGBjKGmkibtXT9FkO3ZYD/LU1dmad9BtkwWEf1L6vSNSZlZOK0zyhCbAnA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(40460700003)(36756003)(5660300002)(2906002)(316002)(8936002)(40480700001)(86362001)(8676002)(4326008)(70586007)(7636003)(41300700001)(82310400005)(70206006)(82740400003)(356005)(2616005)(966005)(83380400001)(426003)(336012)(47076005)(34070700002)(107886003)(186003)(26005)(54906003)(110136005)(1076003)(6666004)(16526019)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 19:24:11.7232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c0340f-ca83-4d37-6b2d-08db3ac25476
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
Subject: [virtio-dev] [PATCH v13 08/11] transport-ccw: Refer to the vq by its index

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its index.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v11->v12:
- removed changes related to index
- replace number with index
- added 'only' to make it more clear that
  notification has only vq index
v9->v10:
- replaced queue_select with vqn
- used lower case letter for first word in comment
v8->v9:
- replaced 'named' with 'known'
- replaced 'queue number' with 'vq number'
v3->v4:
- moved note to comment
v2->v3:
- added comment note for queue_select similar to max_queue_size
v0->v1:
- new patch
---
 transport-ccw.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-ccw.tex b/transport-ccw.tex
index cb476c7..86272d1 100644
--- a/transport-ccw.tex
+++ b/transport-ccw.tex
@@ -545,7 +545,7 @@ \subsubsection{Guest->Host Notification}\label{sec:Virtio Transport Options / Vi
 \end{tabular}
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
-the \field{Notification data} contains the Virtqueue number.
+the \field{Notification data} contains the virtqueue index.
 
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
 the value has the following format:
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

