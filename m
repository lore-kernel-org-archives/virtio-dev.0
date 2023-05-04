Return-Path: <virtio-dev-return-12539-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B652EC77B75
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:31:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1799A153871
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:31:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 32874986890
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:31:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C3F3C986727; Thu,  4 May 2023 02:31:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 15B61986745;
	Thu,  4 May 2023 02:31:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9NFL0Aa6V4YTtsLC4kqmt6yHNli4HJoF2eyHvI6QSkTcFEeoln5biX76Wsz71vlnnChBOG5Ty1kv+Rm5tWtIDAb8i9N52TIaBle4omYsnsIdrTQ0SpFBS0vSuZMXWfGwqvEl6GpwsaTVTRGTWWLGLxIft39+/4/5B+9Oo+glGTpIQlZy+GzW6oCuGzShfo0UsNjqolKtC12wgzmj3b3MtusrI5c9mo4+1GbG5HhrdmCMJj1Wb422QpGpjK9ykrQQWZbbazCrkmKjuEPFwVNdcbYYhXjAAgnioB9VP7V2/MmAQh5BAXXALhzmAtM4qILoagCF5YQsWxArKLiLw/Vuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIrKzNK0r8J0mYQY62yxj4x4aPPGtPcxoZR+7vQKVt0=;
 b=NvS29w7xzMVFSz2O1Rf6qoCQ0EV+wWZaGlqT5LwkW/gqdzAdg7bpN+iSb539pcBpuX2/uL1tDtj06tWFd2kAWrPVWkwjza3/N7L+RNVzfx5ICaXGCQ7WxZrcBMtVV9l2yY/ykgGh5cOUx5ONCNpa4w+d2BFqhrOZXbcXJuHtq++NBAQrsbGySBcWaSSBc8PnESw4apjNLIfbOwrQR6/Wh2JRNUWGAiwaDoRSsNgcH2dcRExxbKQ8p1OzGvg5hY2Remq19paXJLkv9QNHXjPw7TMsIg9lrq+U3BDznprXeBJQNKijnhd2kdfEjCvvHx7EpfNhXL0BB9sRJx5/GhGR2w==
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
	<david.edmondson@oracle.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Thu, 4 May 2023 05:29:56 +0300
Message-ID: <20230504022959.547025-9-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230504022959.547025-1-parav@nvidia.com>
References: <20230504022959.547025-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT073:EE_|SA3PR12MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: d15fe154-aac4-45d4-395b-08db4c478c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Tdcr9UKieVEUdu01UXbLBNMLH2wx+H9yeLBTyANft9DvnbO8+y6oHrfWtOVNwZoa1TzfML5KYGOfveWiyTOEjStaIW7rBUhu2lcTo9rkzyMsTlBP4aDhprQvlJm7tN7UCMtiqy+N1BTQ8ywebWnVAHetVCH3zHQrFsor9d6ZlvMoLB+Zbp2ZEhIpVp584vLyJ6nayJ88J9Gn8/uwm5Q81+SP0l07mg7mi+xAA+vWf0hDGU1zPmvPapJPakUhu+KwJrSAPSqYtDn1QP+XrH6tVQwaro9iHUXYRZvYIDqWcXQkRSX2vp8mUeJVz2r9W7dZ9Niy4x9HY4m2B3uc9uQEofoZtCB7UrcSILmx0IqaJV3zIE1x9WZloog8CzlSYgtBCP7V8ADqI4JLoHGtiqyv/Iq6gwSFvlCHyxSO5NVIy6AQoBy4ntVP4UbDyK5RAW85/aexGyULss7b7G7VFK4MGRnH4eklZmZWApj4BmyBxAzvxrRb2ubaMEd1FsIIbXZNxOA1u5Iz/nZwc13yZ1ozIFlMBms8l+g1+wYce9Gq6kusaA1RmKNhiH6P24PoQ1cXksCxQT+dsKCM5Z13kuKYsXmcTcgBdiqiWshmUb8fj4yGgrBAclMzDfga+fdliTPrT7RKM/cJz+P3ahdOmTH24beKq6oB7j0sSN7teJTeVjUXybXJ1nHtY7+18nRQzq/tExmAgTU2TpnGiSv770MRwpFkJQpsOARAodOy+KBy6U7v6nlBbmbAdiEG5AAmGcHr
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(8676002)(966005)(40480700001)(36756003)(7636003)(82310400005)(356005)(82740400003)(6666004)(70586007)(70206006)(316002)(41300700001)(4326008)(86362001)(478600001)(110136005)(54906003)(40460700003)(8936002)(2906002)(2616005)(336012)(426003)(5660300002)(1076003)(16526019)(26005)(186003)(107886003)(47076005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 02:30:37.8185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d15fe154-aac4-45d4-395b-08db4c478c0d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7781
Subject: [virtio-dev] [PATCH v16 08/11] transport-ccw: Refer to the vq by its index

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its index.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
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

