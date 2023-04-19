Return-Path: <virtio-dev-return-12289-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0FBC77B7C
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 71F8526A5D
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6669A986639
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5891E986432; Wed, 19 Apr 2023 01:47:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1B680986412;
	Wed, 19 Apr 2023 01:47:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGgpkY5+Kteu+gsPj3e7Lts4pzyfx7C19UO3qGFMXT07Cc9wEOC75SpLShdEk3bJz1FR1dFMPEmZts4WJI6kpvYGfMpxDn+lWNLLq7jmFGYrSsc2mnR2E5NDuZWUc9hJXxp8JAnz3FbdebT0U3YZXnzr2aQ9stKLCL1MvtHHz3VWK36FR6Wet7zRsL7jnlKjW0CEo1et+9OgmzrC0Xi3C5dWtyvkjmO+socOSFB7+JW8LXY9qCtQDam5ea6LpHNxiJZ9UfaxIZjmuNzBGxfYCDOauUfsDp3B/kkfCzADGGmE0nMeARYWsEbc8m864Xe6RzuUbMGfYQBNLyQFbzmVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBZ6+G+Bpvow0lZFwE+U/sE9IzT0swXqa4I3YA0NIjg=;
 b=PYQavKECW8Cj7RlLBMUONVLbOj3OJL5fUzbizeC0yowkU0a6zOXkAObgp/FCK01xmSW+sX3mYksV9uY248rQorVs1vYeZXaiJAIU0SxIjOW2icfkTyuhMpXsrFgo1JXbevOlvSsnWRHicTN+Me55/1+JgVRSWSdnXuHT2EKhR6DlV36OCt+W+sO5nOvxTJ1cajF663jMpuY3RjeJlvsLuGFJBJnbn2FXEf3gT7MksHBrloFQYC6BwKrh2RG5CYUKy5HsWWUw3Dfgvb2P+GzPulB67yQQtUGyPEtA+ahL6+Hwa2dkTNYxlm3YxUwWH8a144geF8TzFD5/Q0u18pXMlg==
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
Date: Wed, 19 Apr 2023 04:46:29 +0300
Message-ID: <20230419014639.919458-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230419014639.919458-1-parav@nvidia.com>
References: <20230419014639.919458-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: e13ede38-7e99-4fd1-13e9-08db4077f9e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+cTf8l/02Rs5IJULArqxh+Ek2Dl/1Or0Xq4Lwn0xhf7cPOfyAikgaNu5u38ZVQ3HuUAg0NszPzzgKXWRxLsGATg9t+U4tl4nIFVjj1U3gG5KXhPKUm5iF9DyExMP+ZY/x2sBhlxC2yeOviStNGqm08rg/NN1O0kMMkK+p37caX22eJqF+zQNekyUKAn0qytR8/h+YQPUO4sORM9R156Erfd5vtQg3wHSCTbkxtfrelZIt3yxF3nOUJ1FX7cH5EYXMcmCVzwnDGZ8hNZrG4zY9cxUsNZ6WwgAtkNXDXHRsoAkIDRKo602YvuGeodhCH01mdVZdcImeL3E4F/Ckw+c3chaum2poucsde/Nm8PYVLxdSxr6I5HY35gataEXN/l6lrfJH56cmkACiR4e98dYLdPjkDvxKwxjWVji0nGEgZZPv1XcOAEp9k6RNFlBWf8CQgwQMDZ8/c/e8VyHIWsABghwO1OfbeE1eDZRaVk9jrbdGfzj4jngmmfmA3kQldbFcDVQCE9YFhd5w8mi1Be+EcbNtSlF0Ob+OJOhpjg2UbnmS4oIABAAu1V3Cm776fcV6K3IFz4mLPSSeF1Vlb4/Qj1LAWfqSl+yxXCrKiKxw77AlFBLif4Cy0GQdIDwb9YkEVO73h2nocot5LUwqujYX2WAV9NYaUNhVAqRu2aKfuTSNIbffyQs0hni7J2Jxt4gojTs/1C1MAS5DnHnB9ov2umNIQY5DXcnzjoRgr/nudksPIQqRBh19WbnawWZ5CdCTasA9FeXNyiB/IW6Ww4gJPz4K7sRifSV6rwLMQtVdlujLifeMPkinoQjzKUSkHVL
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(478600001)(6666004)(8936002)(34070700002)(8676002)(316002)(82740400003)(41300700001)(4326008)(70586007)(70206006)(40480700001)(54906003)(7636003)(110136005)(356005)(186003)(40460700003)(107886003)(2906002)(16526019)(36756003)(1076003)(26005)(83380400001)(426003)(86362001)(336012)(47076005)(82310400005)(2616005)(36860700001)(5660300002)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 01:47:03.9385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e13ede38-7e99-4fd1-13e9-08db4077f9e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6962
Subject: [virtio-dev] [PATCH v14 01/11] content: Add vq index text

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

