Return-Path: <virtio-dev-return-12561-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B13C77B73
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2CEBD4437D
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C441D9867EB
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9A8E29866FC; Fri,  5 May 2023 01:47:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 66BB59867A5;
	Fri,  5 May 2023 01:47:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxbYfrdWEHLAnj75IvonuXpQ3HHIahbAaH/Aod3P/ER8wJPd7HheCBaGZFC+boZWSjuJthM4E5bdjA0WZStAfYQupUJnpjH13e8t+NmIbTEq5FXysi1j0vP44RHl16MPYNjdswZtyQncRrGFOI6I+GO5f6fDDPxJVVisopNXBI4/u+5F0gLtIJX6ZQJlGOjxbjkGGWQR/OmbE+1bRkRkD3HQzwSe8GrfMfAHPZhGfL9DjqCj1EAyF05p2bXM8PQlom4GQBASJT5jzFCiBMxlHWwas5x4v9UyveSnmxUJxEIT9kVWF+OzuzqEKM05lpkQo7bD++CkWkdbeg8BFBLebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIrKzNK0r8J0mYQY62yxj4x4aPPGtPcxoZR+7vQKVt0=;
 b=EuF0qkaCOcjxIJXEYF37e/ZGFMMG2E5VkHLkpJT3dBd35Z7iRjuSmM7mV2wD2Lm4W7jZvNam2BQ6RIbHrklsGtkJM3AWco7ORJohMg/CAKbrPFEQA5HaHRrKasrwYwq5Ufzns3QKKFXipdNizz1w2zyqmRFO8uFLRKqFftfLK5q/EpW5Zih3QOjo5uO5fS+fgSNEc1jWW8Sc31vkptCsL0sUdjkTiBI7kyC31dHfPJbZ1IZ4G5iS+N+JYfXgRmN3vgto/i/16oYH2KX/kCQqN2k+4w2qb/csYMyK5NtKH23erMCsUNlPN7LBPaEW9P5STyoVoe7h0sFpqjydb4iYiA==
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
Date: Fri, 5 May 2023 04:46:11 +0300
Message-ID: <20230505014614.571520-9-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230505014614.571520-1-parav@nvidia.com>
References: <20230505014614.571520-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT066:EE_|PH0PR12MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 9442e179-f5e0-473d-d978-08db4d0a9a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jEQ4nj6srlvz0eTCUfRMd/WJXUrg8z7itu4yRo6kTJNxhFg3UQl3LH4yetID/KKE2VYfBW4eeF1oSUOHQTfI2XlDchW4mzRkkRK/eFupXrgiq+TeGAJRXAivfjk1gCfoKk1B0eWARAy5r+ZSVtViFGROVd+osB4rB/pEi4LTFeL1DuT9rw8usgLNbrgoBo+CEuWxq8+2nZmONFQ0WzdxMsdU1yaNJwpwWWUXtps2vEX6bPCyplpWt1ZpjWKipHu4ATZvBWnWy4EVvGff8RAKidXMJeLxfsAGjHtl/WDVl0QytBwgPiqqrGGOP41FVFInjUv7bWjam08eUtvhs1YcMkbGL2CkxmWmsYmugT//Ssx2P2MSOmMUswR70kt+3mlmwS1a0yD0RJDntoQ32hS2zUUgGX4dhSQQtkVS5FpZ12fAdum0ZH0dZYq/7TTWudzZBK0g8IE1HBCnWxqzKY+K2lgU4os86DEqq5oYxp52wpc5D6GKPw9Thz/fKQ2qHC4Lo6wR4j/COUvsibK+YnUNG6fO8aBDLdcr0quBSvh8HmjPAw7dgQfP3J9JqsWvxumTRHCeAlAlo7/jv8PBa7zBTNUiapyPV+VKe6X8nmLNM2SYBX5N4wZ/fi3h/+rW4C1qyCoqd8WCIzD/8i0DdVwpRJ40tWqHn4KLmJagICicub+zkRIhD4PMQFcham83z0w0M2CeE6B7n0fquvqIsJ4XzzWeMvsElVVeZyPG8OGYC+Uo2QI7j3OOdeTsACJKiPr7
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(40460700003)(86362001)(356005)(7636003)(36756003)(2906002)(336012)(40480700001)(82740400003)(316002)(8936002)(70206006)(41300700001)(82310400005)(5660300002)(70586007)(8676002)(966005)(6666004)(83380400001)(478600001)(47076005)(107886003)(2616005)(426003)(26005)(186003)(54906003)(1076003)(110136005)(16526019)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 01:46:53.7759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9442e179-f5e0-473d-d978-08db4d0a9a69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8097
Subject: [virtio-dev] [PATCH v17 08/11] transport-ccw: Refer to the vq by its index

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

