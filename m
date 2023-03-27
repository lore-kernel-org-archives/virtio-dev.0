Return-Path: <virtio-dev-return-11795-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1633DC76195
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5E0213F54B
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4755F9863E5
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3570698633D; Tue, 28 Mar 2023 00:00:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 07E8698634B;
	Tue, 28 Mar 2023 00:00:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjKuB4NXXmJOBA3MWd0PIk9/vGDeTUOwk/KurMxkIGVoHfoWfvePWY76PkCxJvlygqcCSotDgzgdweLK/9EFnwbuRhlrrgtn7XnFUqsuM0tDm+9OFbqko0RpATJXs7JKBlQjSJ2G0Aeh92Rth8H2OBoqIiVHkZs3QHqU4nYFJmUnW8jvL8cJZGzi9661ZFExnYHeSjy7j4pinCZurwI1nb0RyAgYdsvDYx6gRB2kLsjM0QiyteKriULNhY8IeZyH4JhDtwpoq7uGQE5wXL8vnq4tyIMJj11YPyqPt4aoJOR9EJwWvZY3gjN87HXR6dNsKm32QbKhPOUzGUrrssdy2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pv/QXA9hS/AwFYlegISNQ25GEnz9PMI64eQQMoAaRuQ=;
 b=iOj9eiWZxTp5WJI7EiB0a2h0m60lDIeJiZ+qpXkLyXvWlwv27M0M8k9yZOzgvmN1X3m+V357N8wXEKF+TKKYBxgLrnthHbE+9DQG8Ab1cwisik4BNAl2JbVe0RH09zkDV+YjegDlxkiKnwhVRBa8VKop68jZDoim1PIJiPqiJBn02TE5KN/abgaKizAOslz2EefMDtnxVs7JQwVCl9Cp1UExG6ubXHNp8J1C+kZBfjkJXvPi3QI5ByHJDeQ87UZq2HxX1MbOCTVJ9nol+SH+MDLfz+yl13Oj1VuYfkbwNESFZisGRUs+QHQdJStmXvjS2irsxp9XFx6qNYJEPzY1Mg==
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
CC: <sgarzare@redhat.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Tue, 28 Mar 2023 02:59:29 +0300
Message-ID: <20230327235936.414196-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230327235936.414196-1-parav@nvidia.com>
References: <20230327235936.414196-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3F:EE_|PH7PR12MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db7fab1-13e5-4dc1-101a-08db2f1f6056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tMxeq3Vwg2Oy+LgVAtUsntwh7y/DGn0ob0GsaDvLJn9L7z9dB2iPI75MPL0r51WgLJ504zTKpSZwhRd4HOQSdjoZJxL0EzW/7v24BrmtlZBozlxOQyf/c9ycTl29fw6BYJf3uzgA3Trtcbj2hiuVyienv07WbGqYNqnLeQN9N8smYy8LazG+DKHfX1o/ewpBy1qtW6EGnjPeVjlDJS0Z9igEVG/toZOiVNTTsljaph9eDonlGlHqOnYQQdMFJvcas0UVfiP8MciCEuaPoHrwY5SSZm2K3rAUOztHSqjBTu6b3JEiFwQlLIYfnFZl57CW71VZiOGkjDXf22HTuCnQBvcPMrqc5RtdwcpagsWA7q34D/hgjurIXvJ6yhylGuXJdMj4wraK7947vS3gDdqKzNqMU0iMq2S8PjQtRSgBz+nYECf2IYswRFbSHNd1l0BcL5Ak1h54Gka39vSAvXRL3nM7wipNe2QALxXi+yaTYafpZVzXPYGaqWwLEdx7+QTAwUboUhfVFxZp9UuBbFhnOoSgh5jjfAQfdLO8Hyk0cxwqeGDTH8dSOgYwaZloAePRo3FUuKQbIVZ6Ni/LXtVrcH1UnaP/wJKeb+/tlbuEWBGV1M/5l46AGt0We7lcTKuI8jPvOGrk2Hqb7K3uAGepW0gUCoOOSBA3YyzqiDU9QMywfpm9B0n/kzZQAWM3/gC7eCMKnS6jpO4qJzA8v/WnzMO+CBDllV7x1LAQNH0kbCGHChdHA13o1Di1gOjCKWzoA6Ct9lO2ztM/Wx4zwKQRe2FMNabi9L2CgblG/hu9FRI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(8676002)(16526019)(40480700001)(426003)(5660300002)(41300700001)(8936002)(70586007)(82310400005)(478600001)(70206006)(316002)(186003)(2616005)(26005)(47076005)(36756003)(1076003)(336012)(54906003)(6666004)(83380400001)(40460700003)(4326008)(966005)(36860700001)(107886003)(2906002)(86362001)(7636003)(110136005)(356005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 00:00:00.7770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db7fab1-13e5-4dc1-101a-08db2f1f6056
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0000EE3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7844
Subject: [virtio-dev] [PATCH v8 1/8] content: Add vq number text

Introduce vq number and its range so that subsequent patches can refer
to it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v5->v6:
- moved description close to introduction, it was in middle of
  queue data transfer description
v2->v3:
- new patch
---
 content.tex | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/content.tex b/content.tex
index cff548a..5171c12 100644
--- a/content.tex
+++ b/content.tex
@@ -298,6 +298,9 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
 virtqueues\footnote{For example, the simplest network device has one virtqueue for
 transmit and one for receive.}.
 
+Each virtqueue is identified by a vq number or also referred
+to as a virtqueue number; vq number range is from 0 to 65535.
+
 Driver makes requests available to device by adding
 an available buffer to the queue, i.e., adding a buffer
 describing the request to a virtqueue, and optionally triggering
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

