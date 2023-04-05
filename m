Return-Path: <virtio-dev-return-11999-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E3BC76188
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:08:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1311B76043
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:08:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0651698672C
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:08:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EF13D9865D7; Wed,  5 Apr 2023 01:08:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB16198662B;
	Wed,  5 Apr 2023 01:08:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQv1JlA8FyhZLOuu/ZjB8TMKl/9ouXGP0pBFu4xGvO0AE9JUjkmdK7F2guaiypjoNkQA9yfol87te0KsOsfTyosHNDOCe/OU9z0l3HN595S5syAqyoByfY6PhteEW8XDpvNbYK5O/qNL3P0n3HgYxUlFKcnu0q/JGvc8AUzGvOSNK6G6D695+ch3iZIinF/6E+FnVqyGBpFYXCHyF1RHjDmz9Kmc8ldS1zlaevu52TwOveMZYzbJb2cxxC8sh/U92FngXbDnteq8YOIV5Ky39+VReWjQVTM9J1cP4G5N6+/o/LaQLC+mSQCm+wOoM8/QjjaXWBmgD2pPn8JUUfDQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5llxrsT/P25e98ThXNFtJfuZkECTmlcogp2oQF+P5M=;
 b=B4EzmhMcA/HP/mjqKR+aawgUIepHpQgKMJKxASKCEBZYMj+Tg3oE4bK8SyQbK1yIat0zxOJLhjb53dqTjNds7k7dRqvD2CJGrd0+LHmj9M+XJA80Eq1nTKkg6LAz5FDMSSrV2QcvRYTjq217xEUKcKeBEzR2cEnGds/5ff1oSPsRbfXaTinVJLEVoJr2vIX7a0HFLGqovq7RBt5nnqNCMwZHcPHOn2AA39xN7O+VOJfa9cql2Yyv71dKwWEfsY5T1jZi2KyJ9r7lJIMq7D+pp5tRzd0lkwQSUSNULeXHlqJOkoh3iYejBPOAfB+oDjK8pydx41vSvdGW1lPPTN3Y0A==
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
Date: Wed, 5 Apr 2023 04:06:56 +0300
Message-ID: <20230405010657.612529-10-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT093:EE_|PH7PR12MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f66f82-a661-413e-5b51-08db35722197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HS6HHTRLTFC9LHXOwP8sMXfxbFbJi7TVXtU4L0QLGtMPUAij/c7r9ctz9LtF1YTYck+wro+XtW6nLzW25TcsRnlvX3/mdwuoPD6UCMHT6nCXcRpM+NngaFKIOO7Jxa8Do7IlPL7WHQVQB8XHqiK3Ur26+qGAyflLvjKBUmwMHoLM+yo6t7YJZVBszZ4+qtoSmvOS8Rn/2Wx8m1higz6kTvsgflml64acvRkg2VBFhbjtHYfdmbEBe3B6bCK5zDwwwtA5H0YD+JQnNvTanPOJtUBwsY21iSltnpcItRt2a5wc0eGoSb9STVuwqdBlQgKMOdDanFT0M1H3qn/fMJD7YzjQEN2/eaQtf6J/hEiLnbAa2mu5lc9M6Mh7KOG88z6/0xrt5vglX8u20LWfQKgRj4Mel7Vgfbebkkui0Zj8mj0Y45YwdUl6nF7IkwjUiis1XLmpy6MwnMBxdaoMklwAWwgZp6f4SCuepXZ7QMD2nyBXhhr4+naPJ26laODQutNJotZa+T8zIhmiwNOhbWkpJvPT10g8FhjrLUca0eZLhkoxmAxMouEjDAFkOh90/q6nNAIHHx+1ZFpUWO1WQBqkZiEbPLwDbfF6WYBbti7XPgjPXZDrRXhC08PzdN5TUXTJaNLneDQrqVhOFwjDf5mygxyncUspSGTeiwYzjgcWVbIyP45HKyCC37hLz9BHobQbbsg+BkyuJm/oN2hcESzPRWmy0x3akQWlKTTCZHKiBVJu+XT3nf5lY2AD4hNRLVsL/AVu+ZHS2YtcbuEEBSNr5qwf087Sx6/oy+Z5+6upEuA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(16526019)(40460700003)(54906003)(83380400001)(26005)(107886003)(8936002)(1076003)(966005)(47076005)(186003)(2616005)(5660300002)(4326008)(36860700001)(426003)(70206006)(70586007)(336012)(8676002)(41300700001)(478600001)(40480700001)(6666004)(36756003)(316002)(2906002)(110136005)(356005)(7636003)(86362001)(82310400005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 01:07:30.7762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f66f82-a661-413e-5b51-08db35722197
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6588
Subject: [virtio-dev] [PATCH v12 09/10] virtio-net: Avoid duplicate receive queue example

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
index d7c8b1b..435c1fc 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1467,8 +1467,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
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

