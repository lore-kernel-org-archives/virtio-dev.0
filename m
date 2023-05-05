Return-Path: <virtio-dev-return-12563-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FA2C7EE23
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7568CC6230
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 16A0D98676A
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EA39A9866CC; Fri,  5 May 2023 01:47:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7562B9867EF;
	Fri,  5 May 2023 01:47:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAXYlmJPcK6aPagqxtXIhLl9DPNnodpW35bswnzr2Jk6f2KZmVEuLnTmrE7mgR11vO5k/+4ZINoUkZsaHh8Sf4ysVCpG675ZeSgAhgeodMrLtRCDzQyYly9AdWbO0FkX3/u/rhagsAr5OMjMO0g8GZcuPa2q5dAJvxchC6wCNKvdiqkltZ6Dr34H4xV6ThVXMnvBN3eGS4s56hm64PUxPEYjX77iGFvsl/oD9TRi7uwAMBoQ39/vG+cwjx+hWHBo+EW1ggwD1PBeoIDL59WGHwmKN1WckC5qB7wB/+JunRYQUNcBls9phILKwKtITDb6EZNp+ExWzm0sbTaWGCyRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBsnPRsmf87Em58IjACeM4bvkmPzS7rq8r5khTY32OY=;
 b=fG5Pm5XJCAGvq83u4s45OATm7sbr8pkFP32POJi6p7aPhFAHuESpyoz/tlVLt+XgAZ5OqIehvyjsjMCcVjs2OdFDivtRtVrAtSR4FV5aCXCxC91WdjYa33tnWNZqplguC7nBT8xyhFp4EbYRFFGFaZAHadfombklUZsq3WGBh656EW6d11VXlS1Z5k+yXHbb/EJfv7x1HWFsVNMmLmImt6OlE53KIe8q/rvTnbHphPmU4p6aXWzIzFoA1n4U06fD8Gdp7Sg9hSEjw+o/Iw5Cj3TwKnopThDmAJuVjzqZIda72OX584FghT7YItWVIhK2hzi94XquxpTQKn+6CUsHYQ==
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
	<david.edmondson@oracle.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Fri, 5 May 2023 04:46:07 +0300
Message-ID: <20230505014614.571520-5-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT060:EE_|DM4PR12MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 461e7b87-1490-4cba-6ce1-08db4d0a9c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2XzMaofU0Jb0O2lxw5P/TfmzRTXUwBUokRsQg1KlKypKHx3u+4Wb1zqelN6NC7V3LI4fmGlabIY56S2b9FHDFcx5tF+lO/FeJqTb2luGFRC5a/T/4kDCCv9wrn1aZerr0B2dWTNCN/b+ePx8G4oX3+jXzIrY3fq74Oy/ErmKNbKSzNcL487kq17y5V7cCGw7LgKjVfCSIsWjn24utHstqjaOwm/ve/s/j6OgeARu206JPOEMi2NXLHvskCha57D3ic6ZxZZKNydmiEahobuX3+zICogG3+ekc817ToVncBb5x/RLP4yNB6/vU+UHhNJH+LqlllvXKuZS9BNAZSgGfwLJF3UEvMOPxqMUipgy22vHo6RLtDrTzw2BCgHxAFUXyEDxkegyeHu41jeUhyQ0hW/Gs1EnLsXAOBwmwGO7QZhPZQ+Q113ITgB80iSsBudkf1ETnkN8tDyvJTP+A6HTo8BU6q7/sJ3mPoqi3bN9wgfR/C1+lvfKXJR+QxeYz8DoKRcyAQFDs8k/3fah9Yo4z5hNopfJ1yTo0xq2hEYFubEhreV6KXk4OoGO5fC/329lZ8UA8oXY4+fZiz2OCsZtNNW+SXWGEROw3OW1yIzLVUsqccz1UPTNse16Uu+qMiRl4f3QKB4tkjeAFAenREvnd6QjwO/bXLLfSqcFrLH6DXhuhMV5EzhwFZ0v+8Sbj0SnoxVnEgKot6+UIusIF6JyDbqIZxA5EitbRtGRDwHDrvmg5AjyI4PrFQFZl0DhDnd4
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(8936002)(8676002)(36860700001)(966005)(40480700001)(356005)(6666004)(7636003)(82310400005)(41300700001)(4326008)(36756003)(70586007)(70206006)(316002)(478600001)(110136005)(54906003)(40460700003)(82740400003)(2906002)(2616005)(336012)(426003)(5660300002)(86362001)(26005)(1076003)(186003)(107886003)(16526019)(47076005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 01:46:56.7933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 461e7b87-1490-4cba-6ce1-08db4d0a9c3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328
Subject: [virtio-dev] [PATCH v17 04/11] transport-pci: Avoid first vq index reference

Drop reference to first virtqueue as it is already
covered now by the generic section in first patch.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v11->v12:
- drop changes related to vq number
v9->v10:
- updated commit log to drop reference to old patch
v8->v9:
- reword the sentence to avoid future tense, like rest of the other
  fields description
- reword the sentence to avoid multiple verbs use and put -> uses
- use shorter name 'vq number' instead of 'virtqueue number'
v7->v8:
- remove note about first virtqueue number
- skipped Max's comment to put word 'structure' in same line as its
  crosses 65 chars limit per line
- reworded queue_notification data set line, as '=' and vq number
  wording was odd
v2->v3:
- addressed comments from Michael
- changed vqn to virtqueue number in the Note
- refer to vqn field instead of virtqueue number
---
 transport-pci.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index aa9842f..cfe3fe2 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -1011,7 +1011,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 The driver typically does this as follows, for each virtqueue a device has:
 
 \begin{enumerate}
-\item Write the virtqueue index (first queue is 0) to \field{queue_select}.
+\item Write the virtqueue index to \field{queue_select}.
 
 \item Read the virtqueue size from \field{queue_size}. This controls how big the virtqueue is
   (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues}). If this field is 0, the virtqueue does not exist.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

