Return-Path: <virtio-dev-return-12469-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A5EC77B60
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:21:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 50716119610
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:20:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9AEFA9866D8
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:20:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 31F669866D7; Fri, 28 Apr 2023 04:20:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5FEDB98668C;
	Fri, 28 Apr 2023 04:20:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMR6Uu1SD14+gKe4VBu9Aex7FKGhwVWo3/PhkfN43HulB8T4jYzH8eB1hKntY0RQDFUIXWf9hY53Juuj5PiQ1yL66pNW19J2L0a2+sJ4f7OpWgwbq5ED+lE6Wel4ksPc+bDzbnzW+Veqo+AqX0vYoZBRfzOWTifYg/Ij3Mbo43oyteikqzyK4gfCxc2e5d+LU8f6/bBb1OahtXxPA0ouyUhKhJFq8YsWYR6u9zR29hNCZN5UwklG+b5hRM5Z2Z63G5y92H1voXT7by9U0ZipAo3D3K8VTYJtl/EQ29QBBI6gkedSp/zRtrzQM0zvyBSHnEAacs4EltUU5mfieJenWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=te4Hc5Rl0s9hzd5GnJLQkqRPFY7D4crERYFvW7XRDFc=;
 b=WTzeczFutrP+VbcUnEz/qVmsKu/jNLChmab8EyUhnTZViQfliQpWJiEY7T/aL6BKPo1/OHkkupNtmf1EsBOUjY3rZueSv6oQtlXa55ekf1GYc83I/NOSTN+S0pxONO8ioK9NnWS1Ae/bXb8e/m3HLhJ09inSioy5+Bqv3G38J6J5mtRq/scP7zE2IsTLUu0grMKbQ4EX0nLXpRnTXwPaiMn4OOb63ZpJ/OghQsMaQ+nNkNghwIERI6APY97sg2r4CQZW9oNmNdUwF1Ch7Ofe5tHgjJfvIV1qKt4FEQsxWf9Gqsmjqz9JsVuJdsoRrw/qIzrmWoAaloAfDUXvZyo5Zg==
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
Date: Fri, 28 Apr 2023 07:19:47 +0300
Message-ID: <20230428041949.411221-10-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|LV8PR12MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6e5616-6f9f-4562-885e-08db479fe39b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l2gldoqlLbhnomLdK7z0+HwT9ahHFr1O3u58tBc0T+obYr4oQwWJEzBEqlrHkAIzIzWYRx8IGNgr6uWxRyDuXFTwan8J90mymvvuoiv0IS7l8h81R9l3z/QHvlXvz0cjdr/+lT2ySVVCDzWo0tXM/w+6jkSszfrONruurlz9gNRRK69T7BN6bSFeYUCTaDJ+US0jXDAVQSupxyGYM9FCVcWdPxPh93FOFQqzHo5+8cy+j479s+rCwNy1Pf0z1UpoHxffK0wDbQm5AR6pY5RswZhvoI/o7yNIICETXVx1v09Dcr7+HhHO0siNbFABTXiyl7SNBkzy1UnPsOd5HHLny4H+BNmIzJSLImq4FTEFLw6lZ8MrclCh1My+PbNxXwrqdxbF3QIWiJS53+81NctvDxE+CesXlRML370bxLqQzL5DbMB0l1+SOTHKJlO0CWu9ITpkGPPCjo1thln3NbKy/ZEftI8s95ynKwu/QXynAC/lsiDCKOod9EPtdbdrzkei2yyK38pguW2btKCgXett2DnLXvtqrHfZeP8fAb3C0/ryLuZG4Bj6vLoWlMRfIWq1OyqJAv9L7RFscNRo0VSteK+/G7BMt9NxuN9xPZaBwwXTqXbWu0QKf6LRefEvOGzlvOW65MZ6+cAH9mwILrexbaGHBaE5hYouUueW60QQZ5nifQaZ+rsnwAmh9ZZGIuN+zrvY1qh8h2fu5Ksgb46wx2n6V9h8cwazZI7Jw2aYvMarYbop3U0C0yHpT13BNfQ4jYfMICZHGKGe1M8eb4OWbg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(316002)(110136005)(54906003)(4326008)(966005)(70206006)(70586007)(36756003)(186003)(16526019)(26005)(36860700001)(1076003)(426003)(336012)(2616005)(40460700003)(7636003)(83380400001)(47076005)(40480700001)(8676002)(5660300002)(86362001)(8936002)(82310400005)(478600001)(41300700001)(6666004)(34020700004)(356005)(107886003)(82740400003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 04:20:24.5019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6e5616-6f9f-4562-885e-08db479fe39b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083
Subject: [virtio-dev] [PATCH v15 09/11] virtio-net: Avoid duplicate receive queue example

Receive queue number/index example is duplicate which is already defined
in the Setting RSS parameters section.

Hence, avoid such duplicate example and prepare it for the subsequent
patch to describe using receive queue handle.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 device-types/net/description.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index 875c4e6..f3f9f1d 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1478,8 +1478,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 The device MUST determine the destination queue for a network packet as follows:
 \begin{itemize}
 \item Calculate the hash of the packet as defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets}.
-\item If the device did not calculate the hash for the specific packet, the device directs the packet to the receiveq specified by \field{unclassified_queue} of virtio_net_rss_config structure (value of 0 corresponds to receiveq1).
-\item Apply \field{indirection_table_mask} to the calculated hash and use the result as the index in the indirection table to get 0-based number of destination receiveq (value of 0 corresponds to receiveq1).
+\item If the device did not calculate the hash for the specific packet, the device directs the packet to the receiveq specified by \field{unclassified_queue} of virtio_net_rss_config structure.
+\item Apply \field{indirection_table_mask} to the calculated hash and use the result as the index in the indirection table to get 0-based number of destination receiveq.
 \item If the destination receive queue is being reset (See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the device MUST drop the packet.
 \end{itemize}
 
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

