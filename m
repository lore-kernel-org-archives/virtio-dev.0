Return-Path: <virtio-dev-return-11997-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FCDC6FD1D
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:08:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A906142BF3
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:08:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A02099865C1
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:08:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9553498659A; Wed,  5 Apr 2023 01:08:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7423898658D;
	Wed,  5 Apr 2023 01:08:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSzOB9XQ8LK6fCUWlcD9VyOuhmUoOB7JPlipfvsS/cqpb0pWaztvpjMSiJNq8n/gbcz9M+qicTS6ZINAoCAF3o+2dCSd165h/T3MQDHht+ln6eQzw427SZysrM7HIpP3eywcJ9OR9q5M334q4WOEuAGAwqz4Hv0V5rNb8nOczWX9kuiSPDcreUSYfAJbI0xPcUaYenN9y9THP+SMms2P2OlLo1vjN28i/FS2vUpUkZXBpsQ2nAdL7L91FraCQv1RbhStRcAgfMN8Ab75Du1uo3w0uY6BlUCnxePI+QRCS/3Bv1oXNtoAHAMQW/ZPRnGD8WEIFg33Hlh8o1p6pGGPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIFtFnD8XInjSH2zCVzGRPxv4OStcMCBAYZYhJi2Wwo=;
 b=A2gcTKEXx9txZfwy6whfiLEIpNQYc48HosOixtxN+MMwUgVnoYxGFH0mSQLEJEiSL9/w5DYaQf5CUIuw5UBcO3fNEH12E9p5QswDYg9QNXgOKpktjZDirmQ0FAL0U6esU8f2mK/tORhJbW2n0bIX8Zef1AIm5pg/9lEdMMonRETr03npnng41V1E+2d1DgZs+O1I0aRtPAoeM0oEPFCJfk4oPWkl/B4kRv2T3xZFwNKR1m1BQIFHqOd4thDnQ6oo+KQDdZKw9k3uP8ObppIgjWWrkAgkxmN4LNNFXWYJG6n9z3sPOdtfr82VQn8UNDHwS89hyxFPcu88myAKSvnYig==
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
Date: Wed, 5 Apr 2023 04:06:55 +0300
Message-ID: <20230405010657.612529-9-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230405010657.612529-1-parav@nvidia.com>
References: <20230405010657.612529-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c8dff7-8b81-457d-4514-08db35722046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sX7K2Yw2hivsFlvMz0SKa1xABftm2VF9nDFrPt0MCYsOFRcY3jDH63AETn2zUWUfbTfPtpalx2ZaOhfdL43o5FSTaidegUTRW6NPjudnsJpmVM9wED9xM1vOHfs6ojcOin1aoW2I3UF372iTM6BNu+4L5oA313AzZ6McUmWjQALzolZqsylNO7tsp/yVFNJ4aMDbHs50aCV5vtE14E4yTWXLhMmQnTYSN2d6VG5Lm7oxOdvAxbSMK16dZwN+0lg86tbK2j9JIjw4K5gJOHwdnQK6lOMmIVvKxC/AoXuXDOliw3kg5AEOc911EZYknQnmLFIeilj6vfvPMSt04A0rblXWJNF33Lfa6sZlC5yvutc1oLqHPOPUk7QDzMB1IKXXstWFnLL+bqD10c7fKe4iHO1D9GWpL97h48I0YX+LEDeKulLn6gEXgyc67HtBiZLhRDiJH+8qYP5OUkB131EwNRsn2YDXwJ/Or7wPK33HWRu2wyhKJWLDV26WX+pD3WQsrUdwpdDzP8YlUdERd4Q3RJUuiZDH07/nyru9eHlgc8PJW7W6NEHf/G767DgYe6QR3Eng3Cv9dNC/5wWgfHr2BCyjGlsYxT8lydx2NageQlxIZnQYLFkyqBnuSeE44q9xYVA5HPV+RSX6S9z+Pszv3x1+kwMlCNcfOT5QGTPatvczuYrojYgLBScE6w9yTIcFEOz13z2wkGR0Zkl3/l+cpI/9IPHDKzNVKHK0/HzH8pDA3RjYSMSW+KhZJsNPZ2gQyfKw2mOlimDGmwXW7SSvUqQi0nMe0mY+/julXI0g3ZE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(86362001)(36756003)(2906002)(82310400005)(966005)(40480700001)(2616005)(47076005)(336012)(426003)(16526019)(186003)(26005)(1076003)(107886003)(6666004)(83380400001)(316002)(70586007)(8676002)(70206006)(82740400003)(36860700001)(4326008)(7636003)(40460700003)(478600001)(41300700001)(356005)(5660300002)(54906003)(110136005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 01:07:28.5046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c8dff7-8b81-457d-4514-08db35722046
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875
Subject: [virtio-dev] [PATCH v12 08/10] transport-ccw: Refer to the vq by its index

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

