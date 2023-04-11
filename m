Return-Path: <virtio-dev-return-12136-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84AFC7619A
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3B45E7C27A
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3162F986635
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2613F98660D; Tue, 11 Apr 2023 19:24:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 117D698636E;
	Tue, 11 Apr 2023 19:24:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6K6LMGYgejJCI//tXtha+yWHpKUxDKavrD1bmE4L4RlH8e+pnpPZhaA/m2HVFspmIPkYyqNu/QGHY7FH13lyDCQSjYvYrBNX9DiwWlixCrjq3TtkwJ4181RrybjPI/4jGzoKJsU09tInlbk5p5qcFTfVkMeB+Wz2rfnxDpkxJvKOrvHiqvLLy8kht2cUeuthMwOTFBlqpuIjSqHTw+rHXA2KX7TdpXqoxUInUPZjtZhzQ6+REU2wfIObQi3XwTaGLUTxk2A9XKDvqixKjfT9YDkpX6F/cpkbXNjebmVP5KWjZ3srSGBNlKV+YuPY9r8AZ34tO/SKYR2y/bEAqhtsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1R9RYeEv+8n6LLsUv5f10XgbpoB8wBuwiEECiap9rao=;
 b=e4h8+KMsBre8gmZNrjHZMprRg44telvHic1P7Lz10vo4IlvxWNKAOJIUmnml0iOB+S7VSnvhFtWSJHUOCZXj+IwNP5btCMoF6r8dNZ+ktGJkjBAy6Wono5IAVqZoszz9run9gfzncHdLyOsIAPoKllTUvIL/Hts3o1C2bPmT8jNn5JvD4ZpdkeaW0NAleDkySeV8tLR4jU/+EtmUeXymelGo3ThEq9e96wGEROpBeQGKozdCjTCMwlSok7w8/2QqutAFeeBOaTQhA3/R/woyeaZft37DAkhFIQJECpr6JhPANEI5BsDzGLQB8zxL3GdzZEaWqCsN4gfn/+9unS1iEg==
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
Date: Tue, 11 Apr 2023 22:23:31 +0300
Message-ID: <20230411192341.751841-2-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT098:EE_|MW4PR12MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e4f5e2-ebd0-4491-44c4-08db3ac250c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IO+o2K7a4Og8ujSvjYRHyWDQLEFkceIfmqGOEHplsJ0xKAu0GVbQ6e0oTZsOpGhd8+h38+TABWOoAVa8ifsaVggowANsGNd4t/Rh58EJ8IUhl2dYawItYI5Tte4iL8CtC8kKa7v8NUr8wWcrB/C7INo0zPrsUiZEAN1BQBqkMOVUigQwWHPW7ZKf/XJPK3fQibXqYNC2Drih5il4YJ/plkEpHsrmeRqtyQYpEabeWoHO8e46Vx0mDxFbAdtt56RhbEnhKkulru6mpjBijP+k/IswVqFvQU8CfO/zJnxqKAdcsvHPXAdrqyxgJ7g+3S71APZsSloZmDEdizJxAEE7tMxOovZ2Gtg+5xOCZlZ9R0LGnmrYCgbnoT2vk+02j7exMWn0ZvngWqMyLVoJ1AVR0QGssCxrlsmfMtFUj3hXsC27lYlCyCRGJ7zRMD6XricNzecAeCwmuujBm7xSpdLYSA6mkF6/E1UJYrSnNnpQNBkfO1lBdqevzsSeiypUpbIXQoggylnLPXcNSQ6rcJn8EFzbuQMS9DEfGym4PJVlYrnuqGH3x7niI7oZ9S5/QWSxJierlnFAhOH9OQXSMcutE/wgHuCb3t929uFCb8VrdvdiNOca1eVMvZE8ZovxlocFkRKcHYLWeD2RpqJy5EXZJ38wH6+xr5qMwRClhRo4LHZyMY2ij8B5K0ipYzermsnXUu66lQrYAApqcuZXrxWhnLWsJkEz5bJPH4L/ip0QN38Q4GlcmFl6cUUpO5aA46mrgGFHNsd43i+Og4tkSWP9sUF3Gnh7e2HP6NO0qW7VEaqusSD4FOEpOwpgZNQNrThs
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(186003)(6666004)(426003)(40460700003)(5660300002)(4326008)(2906002)(36756003)(8936002)(40480700001)(356005)(8676002)(7636003)(82310400005)(41300700001)(86362001)(82740400003)(70206006)(70586007)(36860700001)(83380400001)(2616005)(966005)(34070700002)(47076005)(336012)(316002)(1076003)(54906003)(26005)(107886003)(110136005)(16526019)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 19:24:05.5331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e4f5e2-ebd0-4491-44c4-08db3ac250c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7439
Subject: [virtio-dev] [PATCH v13 01/11] content: Add vq index text

Introduce vq index and its range so that subsequent patches can refer
to it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
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

