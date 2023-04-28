Return-Path: <virtio-dev-return-12468-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6A4C77B7E
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:21:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 74D7D41A39
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:20:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C164998669F
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:20:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AE509983E91; Fri, 28 Apr 2023 04:20:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3605498668A;
	Fri, 28 Apr 2023 04:20:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfzgYhSN07vgV/MAqmyJ0STXGGMqUJX1eSQLhJYYssKlKREtSaI0y7GuKNt3SIWDj2bFwTXp1WXNN2VygOoJiWkbP+6b7DkeM5J/IB0hLxrC2mFc4RqdFn/j88jlX909RKi7Sz5sdDNE4oNdSsPm3zdyIAlGZWAuI9sraoOav7mJpWqyYxM0wYRI+Bgm4cB5P9LfbQ/IhI/lwO41z+S6UNAx3phcemFrnCGz2Y5vDZnl4FHb0WbbggUA5eHOziU0YUqXJwfChHnvvJFuCSswJHw1dL0Swz9/rzG7tBZFMZoQ8SWh2hTHWL3tdoGy2DvAlmTLhivvRwsSxyHXWFi8xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIrKzNK0r8J0mYQY62yxj4x4aPPGtPcxoZR+7vQKVt0=;
 b=iOHYWOPTpStPaIJojv5YdOQaxf+q3CnFWhARP8pgPZnOieUfkUbXgRCJcJdqGd80JabDcM6bL1fVN5WF12LYx+KnNB11SHRktpGltjmP8UMVWdd+BvUk+dzAfvHmfbEJRTtvYhjDQsUANsxjFoImQVvHmaVoRVrxw+wsuK37tjOOCUMGYfj0kmx4tusNTn8wRcBbL3YkuznBwB21aMCZi6pfefejcFqygrYw8XZtLTsqXmlfhEp4WHpQVH8GiDJZdf1rAOgO/JnTJSsceyItazoC+orA5aiD32a6qHzos6ALjUid6k+EWKPUODK3VbxHodo383w0HvjBDZ03VX6YCA==
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
CC: <sgarzare@redhat.com>, <pasic@linux.ibm.com>,
	<virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Fri, 28 Apr 2023 07:19:46 +0300
Message-ID: <20230428041949.411221-9-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230428041949.411221-1-parav@nvidia.com>
References: <20230428041949.411221-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT044:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: c578334c-d560-4b38-d3cc-08db479fe2a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SGYy7fL0B9iT9sgIGX7ZUATX1Z41DsyCb4xHrNNpsjn0I/WBlL60oUmJBQt07Oi8WYuhwtP22akH7wGOpxW+KfmhHnDQ65iSBUjM4x7371N2WroMmOjV7EOS3+39/2juWVN+S0NcvvK5leMqs6tMt9VHKAMgAMeUasb1EG3llIPrw15TgKAGH9v+ut9+Uuu3POKvYaFo4LexTbxoToO/maXOeuOJSjNWgr8BapKKYDY7jgYkfvq043RVgQK+MD3+CxDkG1iIZKIOPryQjvDZgGAGk5JK4VREM2UWTakUyrX8ljmJv7Sz4R6pipY7gP0ibh3Kz1XuUABZo+/hYQGuIfOd1YvLptpDJTbkQmDQjDWSKFJj9VGWlGVy/PfKJ+2WD/94333wfNb8MU9hr9dI/p7ruCK8tPULaCVvWbHVHnMvmZypHpOMGqDCFt1MZ7+2lkawHU1HOUKPJvqQawhS+FRZK0zDIAJBWhYUcDDdvX+fIS91M56aDR49IsHevjThdnQ9krB5ZrvTr78y3ymAgcBIsUEoy0IEvyCaiY6ZvC4bgCTHxxjAbLnlt/68C8RQ495LSFpap+INyVoVCZRfK5ZKM19DGabzbu5u+VM/w7bSg8Zdt5Ab470SeBBSRY+BI+1/vY4VAS0sCop0LDwm7rbC5n1BkrHd/WJweUboJZ7ZR31wCOsOU1meRcy0oMrc+gJCTMX8kXrDN3pvrcrbGwnYSrwWK4lgvGA1dy0P6urvPzwg3csMQiqFI89hIjDOR6iSUuS1d799uBRcKWp3qg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(36756003)(107886003)(26005)(16526019)(186003)(1076003)(40480700001)(40460700003)(70206006)(70586007)(4326008)(82740400003)(316002)(86362001)(478600001)(426003)(110136005)(336012)(54906003)(8936002)(8676002)(47076005)(5660300002)(2906002)(83380400001)(41300700001)(7636003)(356005)(82310400005)(6666004)(2616005)(966005)(34020700004)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 04:20:22.8588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c578334c-d560-4b38-d3cc-08db479fe2a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812
Subject: [virtio-dev] [PATCH v15 08/11] transport-ccw: Refer to the vq by its index

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

