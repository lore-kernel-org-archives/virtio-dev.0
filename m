Return-Path: <virtio-dev-return-12556-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AC9C77B73
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:46:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 62B1586691
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:46:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5E36C9866E6
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:46:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 51D659866C3; Fri,  5 May 2023 01:46:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 31D3C98665C;
	Fri,  5 May 2023 01:46:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4OrG4hEbZhs1YIckRn0aVtqm9RKhk8NkyphzUtFl9JaKiOdIp8DP9UX0aXfEI1ZFFR1SBVqubiAzbekvufdad7P/Ro4TWCjtSzm/4TQlCwDLnEejEnGMM0eMWZFmA6p2mSGsnEhdFmUt9Qz749MJLuK5xbtf+eq3fPCg4StDpu6IHp832nmUhrxHGMcjJyM74rueHP0JnAcEE1AaNS0ZC2YjBnqUlxEcjRmw1SJ8nSPsQ70wY/lk6K1F5NVVX/sU8NPiF8pHJE1ZgjBnih+GvEo+f7MIKAJA0GxgwEtGFyelbGgM+CBEAeyiyedMxARzPL00xV5g44tZM8FOdmPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pik/DSkSnQaQBF9dtPfzm4/i4FFd2goGBYOrajc0DfY=;
 b=Sq61NV4dB2OEoTbGnMxM0+JN0wixg4wNEe+hdZ0KokYsqrqkm9im1v1j0GrVQQhptDLyvFvPrE6bZjVjb6eDDgoviIMD33+M96dDunExLEqClXsvg/siMSUEMqhYfI3kEJIkVonMKzA5VQ+1TZsTTX9xkBqpfqqLi3xOIo2hsEhphVCGxlsd1qJFbgr7UFofkzqcKECXjOXyHDuSadNUfKgQYwdeDjefIbt9m412TdEqtr56jSazqJYs/MkSY78QevQcPvfIycTNCSZdsL/63bvlEOxn0f9Gx/p8btHzBFZpe3AO0pHrd+8KSb3WuAJvUy7+CuicICzWRuvtz4Dt0w==
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
Date: Fri, 5 May 2023 04:46:04 +0300
Message-ID: <20230505014614.571520-2-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c40847-38b8-48b7-207d-08db4d0a93a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LiKz1Zt6erfykvxnyB8Sk1ekJV0fYl7pprrkv+07Kmbmg6j4ngiK8uu6+6pUDGED/vGXQHbKCUx0Sg2p7sMvKU+SYzYhKfC0fCUbEYSG8QuEyjelKsX1AeYp7FUvcU1Rj2XBvP0ixVMfyEKV9qc1+lmMJshCbw/GVMoiZ5THi3oCerZeO9TGehnZi/LKqmRYBSZPOCfSSSQZ1bZbZiXimCwvTJtOEte4x4nTpS6YDtsv2M0OoW2z15pV5zMv1IQ2NQlOi6mgJwWp7p8l3VhBqdYIhV5GLGUIYryobukJA3M2eo5XdEhKig0YSH9PZK/xMtc0cS06TojYcjNT7XLnJDJbShMwZfdzFYdzefGAiUtpHzeCz8gxwgZOjo8UEps+d8afs7ZIlh67Ho3pl10lee/MgSED8469s2QHtikX2YhDPxZgnUP97xkCipfy8ONF1RJNS/714yBjCIOiB5e/+jSCjZdR2LdC0ct0b4bN9eB6wG1Q6/e2ZoBY9OGvqcWVof7baZfV0yDbrPHZEZ5dx+x45lV1kZqfI672cEQW7v8GchqpERkfIBb3a5t+XqdKsBdARX11c4K9gwQQPuJxw9XdCOaTE3AXXFE6lfqcTtin3LfCwDBawz1A+hzrFDeZT5S4EXKtjEcPjU4GHqaCS1MSzI9CvUKD5J/+XodwRR06kHDrfJZA4pQlVArM2+yHalD8Ijt8pm4tTkw/AG/fxEf/1RGx5Gf0B55VtR1AOVCXuCZf782wtKXCCcJrRn2T
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(2906002)(186003)(16526019)(82310400005)(40480700001)(6666004)(107886003)(478600001)(86362001)(110136005)(966005)(36756003)(54906003)(40460700003)(1076003)(26005)(7636003)(82740400003)(356005)(8936002)(8676002)(316002)(2616005)(5660300002)(426003)(47076005)(41300700001)(36860700001)(336012)(83380400001)(70586007)(4326008)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 01:46:42.4138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c40847-38b8-48b7-207d-08db4d0a93a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
Subject: [virtio-dev] [PATCH v17 01/11] content: Add vq index text

Introduce vq index and its range so that subsequent patches can refer
to it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v15->v16:
- rewrote for better reading
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
 content.tex | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/content.tex b/content.tex
index cff548a..9b694f2 100644
--- a/content.tex
+++ b/content.tex
@@ -298,6 +298,10 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
 virtqueues\footnote{For example, the simplest network device has one virtqueue for
 transmit and one for receive.}.
 
+A virtio device can have maximum of 65536 virtqueues. Each virtqueue is
+identified by a virtqueue index. A virtqueue index has a value in the
+range of 0 to 65535.
+
 Driver makes requests available to device by adding
 an available buffer to the queue, i.e., adding a buffer
 describing the request to a virtqueue, and optionally triggering
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

