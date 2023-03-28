Return-Path: <virtio-dev-return-11828-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40F8C6FD18
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 20:20:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 16C222ACF5
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 20:20:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 096B7986956
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 20:20:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EFF20986736; Tue, 28 Mar 2023 20:20:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB6409865D8;
	Tue, 28 Mar 2023 20:18:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvZlPcN3wfF9Vp7ljocA8mW2cnMuQbb/4AQoAi8JMX3New4FLU+WByQnV7x/XUCiiBDL61ZwZBRodxB9gwOdW6UXYdtAdEVo0s1PS624NoXupJj2nRMb+W8NfVpVEC7AujAn0jLPW1SRajteC7KWTM4Q+D3L5hsiu9e5jQN9m2gbUJbRZMYyMI7BdPfMgCGc3I/rXVxHH0xSiUpwybU3GaT0QLccCYAnksNQSCZ+zk8dpDT0PMzzkIktQpqVoId4lledOzW2tvhitOs9AoOo2I3o3nDfIwsT3NNh66u6ihm+dx2Hvkj04voFZkKDek7+2MY4QxYmZ8nftMe8iXQ1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcyMZN0RuyQjhc65CB01H31HgGj7Oro9NQwIVEqgGQk=;
 b=g5VmCOeqBqSX3cDPnb5v8QjeHZfDRm9K70wwRv0PHvCXvEe7BkU8wy3RpA4Lg4Pak2yIFk9dtKTfQzxFMOPCLSycaEDfuh0x598ArY+oQl3hkKaLjGnrAmVvzR62rDncQ8xa18JnqWoXWoGRSAhJVK86wLou12lTTj01aP1SgYuptbQuSbAHcYikV4i8HnOO0pkCWe+sg6blwq8GY8BUN0YVOQfB50HL8KSB9wrPono3qG4pvVNoiad7P7xuls8Tt72GxUbs1BsyKI0442jvXK4cnbifm5Ww+dx3NwqVqw8uMDtI3Y9vWYnNXNuipB1AHUKl4D2Qk2SdEaMuymvYEg==
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
Date: Tue, 28 Mar 2023 23:17:53 +0300
Message-ID: <20230328201754.440974-8-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230328201754.440974-1-parav@nvidia.com>
References: <20230328201754.440974-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5079ea-8f30-44d4-c119-08db2fc9999f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JAMrR7mMa0rHd6bZobjSJqfuE7+E/PFwhZfCjI0dobTTTXTOj0wyp6QKvCz4S7ifnzqVlL8LVumeBpXU/2w20lGHzmb1PfFD5FEe5+OWgGxLnD9iveeEGXUdILfCEQV176eER2srQC0J4KE+qyYAIpq4Sg53y7IhHhb0tCOSL0wIwKykeEs4akevxPBgboWc0Ec+GlFatqbcDGK3OAXJCngq5K17Ra92AQWZZdTZoiSjrcIsvDYZkhwnYwNbNCnBl+vuCRJv31qkij0eSjYijNnwfz3vhmxE6FeL7ofdwTwmHJIrB2uX5HzM0EGPBH3s+prlYz3rz5B9XrkPd5ljzmxAIJJ+2spTMLyebpjJx4O9QtFKtwLWechrAuPCvDjMFDqP44Mn4c3ym5l7JUN66WIwJCYB/Aga0jbAIn55tWaFLGytLx6LOTW1mMvx4YPzDc12Hmpv4dfEweg5r2cP8B/cvpPchajKTnAfc/xAE/AgS5TEuicYfC7EoqiPWtOXqbskt6ZFNb5agNclSPu7lOOAyBTb7bCVsvRoMLVWuWvOZ22GmaI34ZO8Z4t7ldmiCfHxHY+EAyL0mknmXcN0pQJoESaYUgViB2k2yj4qx888hCv+vCn9+V1OdStfk6oiN4tvvrPH0sxb5yWooFO2cn0fIQeVNK6tuv1OdMMTdlpqo8B1DLsC3zrqW80WWYSnIW6Lg6YUGaMQoPSCL9hbYaZKLZE9MXUdj7qlpGEBKVXDmdpwL6CeD6HDWvaxvN02IWpsi+6ubVvLLiGMQmXTgwFzz7B+KGv1lZ0wWrXA9l8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(36840700001)(46966006)(40470700004)(86362001)(47076005)(426003)(336012)(82740400003)(36756003)(16526019)(83380400001)(82310400005)(186003)(2616005)(5660300002)(26005)(1076003)(8936002)(356005)(7636003)(6666004)(107886003)(2906002)(966005)(70206006)(36860700001)(40460700003)(70586007)(41300700001)(40480700001)(4326008)(54906003)(316002)(478600001)(8676002)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 20:18:30.9122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5079ea-8f30-44d4-c119-08db2fc9999f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903
Subject: [virtio-dev] [PATCH v9 7/8] virtio-net: Avoid duplicate receive queue example

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

