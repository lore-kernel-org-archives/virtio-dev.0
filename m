Return-Path: <virtio-dev-return-12466-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AE0C77B7E
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:21:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2A8401395FA
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:20:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B89769868CB
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:20:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8D7FE986718; Fri, 28 Apr 2023 04:20:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 51A21986681;
	Fri, 28 Apr 2023 04:20:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5PcYtTG4V7L4qYqGYZJ0sOkHfWnuWW7XZpEsrcswVC/K8J7VKMvpG5q3u6PQ8zNAv1GY1Nib4Ne3YowLRqn6nmKuXaptkfLxs7hOckU3uInJRVC+Hw9Bi1wGtm6ejQEGQt45op+KEXlyVeS6rVS9yOrI/aFieZT+cEYmyC1oG/xa75pFp3sh1ceo7icPxzB9nb54MXe3JXUu5AA/J0Savj7TDLOzL0pRUCXSa2M8EpHnMBoFKPhLtceNODjmy5kUb65F2Tcb9xXXohICdLRlE3P4AmcZg6estrZSJDV/zgAnweu/agmjtecjQKu9kbvbL+XRq69ZaOfb2rtq37ZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBZ6+G+Bpvow0lZFwE+U/sE9IzT0swXqa4I3YA0NIjg=;
 b=PwUychvbFJ6x1EhFgXD6f5onpxVgq/MBw9ns7dLwaLu+UTCOK0MwoC9Fuo6Zny5TMRJ7mWD8WvpQsVhWcY/wJJoaggDS5WGZEJloVXSoZnuMzDCGK9GWqA9d0m92SG5NPehfAJDKX9wATxz8OIYrqcFjIQCxrO9E3rUPRJKloG6RTxRaMeVs1V3IZ7sgc2z6QeC2oyihw/uLyyTW5brHYkk3qsnQDAk235w/u4I6wGgYyb8N3ryPVYETfwhmXZdUmmPphVAIIY5qd54oqXsS0MqmvB3SNCmkwi33ylBg2mxJXpZqElfdkH8jMXPV42J/xL+i2KdPj6riIn5D3eQZkQ==
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
Date: Fri, 28 Apr 2023 07:19:39 +0300
Message-ID: <20230428041949.411221-2-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT044:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: c192ab03-1d2c-4a62-542a-08db479fdec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e987s0+Qhm7s4IK11+nz1PTZmC7SmUKCwbtNOTku6/4L25Laj+OBHBK5k1mWrqru8BpXIm9ys/hdGVMpJAIRUUBsQOxQodcl8fi5EDXersirI0iMO0psO0pofK8SO7KUkTy8uX3erTrqT3Z32HJetdM5iE05V65FV9qf6tj0nGBPfHnyejPY1DOJgMAU5WVK8WSDaXBtB2ODdtXURXb/dZh/je9919zd07K5l9ubHXln3nJ0KUvsNTzZkoAFLEc1NupfzgN7DfiBDDZOc00BYSQfX0sb5Ra48fjn4txgxxhmgl7XOataSgPkTuz9COG42gntbr78AtfQAnpvwovMo6sW7yTT9mtfgZTp5zmXzz55WMLzRgNv5ofnJxz9CFc5fbh7Qd+blXFfrHh1QcgPmBLmEHyQbCTX1BhE65ZaGvPOKLIOuWpgQqiIRK9Elve1N3sUpSJjBixuymPMJ5mvY9Gle1jJ4lLiO8TzLwTyy6re794IyGP1sDoBZx77k2u1w3enGGRaaOj8j2aVuCZQtmotToi5ii90tmhK3UgI4opQQ8eWt16ODtNBo0TmKhmhJp3+u8vzT8hFqp9vh6h3YQU341sv/djE25Tyk/zVRIUiyXxvhz+eGSU2AgWpRkEQAhbT38WyUwEShKnVy5mhgPjyKGtKu0GtX6vfFzfXWnX59ov03J3G4o4ACbTzo9Qb1IPxF+w/O/57CpVQ8Mayn8ey3qQyAF0TJHbm8KOWcIA9deS08YXFyDaFIxWXuQpFKDqMWb6hzXR8v4juDGUy4A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(8676002)(107886003)(1076003)(47076005)(336012)(26005)(966005)(82740400003)(426003)(2616005)(40480700001)(36756003)(41300700001)(34020700004)(356005)(7636003)(6666004)(16526019)(186003)(83380400001)(36860700001)(54906003)(110136005)(40460700003)(478600001)(70206006)(70586007)(316002)(4326008)(5660300002)(2906002)(86362001)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 04:20:16.3741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c192ab03-1d2c-4a62-542a-08db479fdec3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325
Subject: [virtio-dev] [PATCH v15 01/11] content: Add vq index text

Introduce vq index and its range so that subsequent patches can refer
to it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v12->v13:
- avoid virtqueue -> vq abbreviation
- removed Cornelia's reviewed-by due to vq abbreviation change
v11->v12:
- renamed 'number' to 'index'
v9->v10:
- added braces around vq number wording
- added vqn as another term for vq number
v8->v9:
- added inclusive when describing the vq number range
- skipped comment to put virtqueue number wording first because we
  prefer to use shorter vq number as much as possible
v5->v6:
- moved description close to introduction, it was in middle of
  queue data transfer description
v2->v3:
- new patch
---
 content.tex | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/content.tex b/content.tex
index cff548a..43be58b 100644
--- a/content.tex
+++ b/content.tex
@@ -298,6 +298,9 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
 virtqueues\footnote{For example, the simplest network device has one virtqueue for
 transmit and one for receive.}.
 
+Each virtqueue is identified by a virtqueue index; virtqueue index range is
+from 0 to 65535 inclusive.
+
 Driver makes requests available to device by adding
 an available buffer to the queue, i.e., adding a buffer
 describing the request to a virtqueue, and optionally triggering
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

