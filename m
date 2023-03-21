Return-Path: <virtio-dev-return-11667-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9C8C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 37F8B6705A
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2722098646A
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1BA399863AC; Tue, 21 Mar 2023 04:11:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 05F0B986455;
	Tue, 21 Mar 2023 04:11:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJsiOg0C32fvHX3C6JYyWO+KiE6YIWs9VeIPq6Bt/bRH7xiQkI3dIADGirArpDbH5d9DEpfm3xrX6r4Mv0Y1rRozxh1EVzoT2fcugOs7Pq/yC/GiUmmORmiUJCTHyKx0ZifjvboKraj7IUfPBYEuyMzmsjmlMcxhMP6B+o6lB3hZtLTmw2y9l9u0PkWSlxlz1/E2Va0BsVdDQ9lkPLRMAz1f7VUEck3uKxIxxCy+9j00U+qopTQnNzhF3oszlb8e6EetBUEbXOLPOacMgDSyHDzhHa13vgUCzDvLA5r2MC49bP0XuWARM6hDCIsonOzN6KCKIrg7De/qGda2RVlrxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcyMZN0RuyQjhc65CB01H31HgGj7Oro9NQwIVEqgGQk=;
 b=TEqGf94f1Vs+OOi8uBiTX0toGDc6NM62JBghjUCMncOYGPz0b9QUbSXWMjxtmkmZ/Rl2B681FTgK6FQl4Yh9x2C/TM00TblZBVQ1pICIeVn7wM8nUVehrvOvY4K0Oe6HYCkO8cqM25B96DfLZYYJ3vM5xb60bdiJEMtfza2OBHulwKCaENZ39qFgq/A/wnraGVxstkmoExTzfisXP/aTUXRyWcM8cFBmZ90orhX3qimgfSTDxiBaoWVI4ww2aGrh6opfTQHG692CZecCwyKlIrz9CImUAOENRaw6e12808TswAp6ZKfwHHfCae9fhKAt/DMKZLoKzu5eptTVAVfB/Q==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Tue, 21 Mar 2023 06:10:35 +0200
Message-ID: <20230321041036.201439-7-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230321041036.201439-1-parav@nvidia.com>
References: <20230321041036.201439-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT045:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0032f1-0f45-4829-9819-08db29c24e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lzEzXFcqGyP8Mcr2mP+C9xU+BbFdnU9CbIherYJbloZkqaOckO9ffTlveacpMo36J1moyJR+mGWErTZwIfZqGmo0jPAuAP+jaaZLzmvJJjoodLfw5HarTW1DPNZh7G7sN41cYtgoQ+jobPIpDUZIcF4VPH4974240VOSgZKg4t+NbkwbsLlZ1KmEzgs8NavyB7ztJRpbfGbhts6OtGg7TS7mC4XwFtRR/oy3Gh2jPMY2Kox1pLhz+uYs+BYhAyJ0H+Qf9zhyd4Aio3T+Zq4s51C8O18evyKR/7vTLlmKvPL7g6rcMQ3P6xqO9Mrm4QFcD4AC9RzqYZeDNONJnSbVXTAdHcSCkLu643vNyv9HczSxzp2jNE+s5sysjVoILfuVz4pYoBCnl3bBeBCFFn9JdNg3TOvNDSewCejI1K6JqVzCW8mYD5DKUItwK9UHeWTj9FEHbEJdgfq5SEgwI0QFegTnCVJxq6PYBfzOPObA5FIyFlnV0Vq0CjDBUmE4YmU668ypGvcIXjDQN02C1+HxV2mXZKrSL50RaCoL6/01D/jGXa//4AHbNdNmJCrtAxoMywzR+N602//MIE2WXOsXdUZE4TmVIxd8E/u8BkG8vC0wmwHDep1iC4OZtd3smQFKnp46LVN8FnqCQvS6xPg5awxIeD7uLUuSFqLnYOzsC7xe09hQxFtp0eNfGhfl8pFjPMxY62g9kO7rQzsEM0TQL34sI9JeA6QosaQvPVgT2pUrqiYeekpTEDXoN2ctPMUPzTOrij+3tAZzqS/pz5uTT9uRR7+7+Albz9NUh61dPiM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199018)(40470700004)(46966006)(36840700001)(7636003)(47076005)(426003)(82740400003)(2906002)(83380400001)(5660300002)(36756003)(8936002)(82310400005)(40480700001)(1076003)(356005)(86362001)(40460700003)(36860700001)(26005)(2616005)(41300700001)(16526019)(186003)(6666004)(966005)(107886003)(316002)(54906003)(336012)(478600001)(110136005)(70206006)(70586007)(4326008)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 04:11:11.0646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0032f1-0f45-4829-9819-08db29c24e0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976
Subject: [virtio-dev] [PATCH v2 6/7] virtio-net: Avoid duplicate receive queue example

Receive queue number/index example is duplicate which is already defined
in the Setting RSS parameters section.

Hence, avoid such duplicate example and prepare it for the subsequent
patch to describe using receive queue handle.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
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

