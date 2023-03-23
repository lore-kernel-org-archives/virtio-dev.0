Return-Path: <virtio-dev-return-11744-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914F8C6FD1C
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:01:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5856A42A95
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:01:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 487DF9864C3
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:01:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3C211986471; Thu, 23 Mar 2023 01:01:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 34274986634;
	Thu, 23 Mar 2023 01:01:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUBhDEei5h7vR9/2D/VsTh/FnMi7a0xHCeavvDbmajg/TzOBfFC8/Rn9vYDg6Rzlvg+tLpTDnUTcyiGy/2TtmFE76RJ2VFUMDsoRMisBeG0r0wRlCscnovqpWut4Ey6/et/KSJf1QdRRUQx7o73YFu/I8UHP1xIWIKD4KFZX+OPCSm+EX7VJtE6torBk1mD3utkC6RMJLqFQ1Bja3J74iOWDpXu6P9LWvd9mS9GYOtq8tmUM20tnd/YzQvQBqRmgDpVQYVv7F/nmaUqndSMIyZ/DZoHyWyqER2SVEr4cIG+3L4sYuJEfCDA+lvstH1Fb4zh9nbvQoSAWMVp1/pNCKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcyMZN0RuyQjhc65CB01H31HgGj7Oro9NQwIVEqgGQk=;
 b=ZhlwpHoHSsLkjJmuTonJ8herGcaBzx5wqRcarNbj0YNERlz9MPENVWlksFgVzUkUToQE5JlMt4WW08aRFz57YchFbmPSK2tTg0I+ji/dYn59BPgBnysQq9qp4yzqE/TBdiny+sOoXI2S1drQKCTESU/3HcCnSOVG2vGVRipNkU5zldExdjpGTnEwAX48byVwUSSncRvnWLzkcIh/KHJom7iFhfOzIW+lacHCLqdw6L2Z+AgrxG/e1DPHJF68WfVZIx8Zles0FnbUc1x7Rf2HK4BNEzoIcXezm5lTOyQtnJdIaflYR57zc7OUNa4h+w7UcEQgmPaSev2H6CR/8yk/mA==
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
Date: Thu, 23 Mar 2023 02:59:43 +0200
Message-ID: <20230323005944.262738-8-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230323005944.262738-1-parav@nvidia.com>
References: <20230323005944.262738-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5F:EE_|IA0PR12MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: faf1abac-c550-4a84-5337-08db2b3a02bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ea80g/vq+RwsdoMbnvOz0Ll1jsbuDSy1PMjotuFOpgguHORO6RpjS0YTNK3ROGL1s9qCcN8LqLXTjLE4j6U79YPAEKSAc/1ByO14CtBv2S8BtfLUaSTfvr4/hvLXb+jCX8jN5Ufem6hpLsS+O5P2DECXMTj4oSlLeHBbSb7GKHNcpKH+JYndvQ1wgC+Wq5wC0dCn0UC9G9nNEdQvP6qiDEKFzW3WbudBtamowVH9wXn0QlLLLCbnTWwmCH3a5LN5M+zDBpiJaZEsgQb4IjO0rQixelwtupV/s1eFeD85X3eU5qy+CERCG/47v8fU+zvEDIa+UNAs6T6X4AHXhLfocj62jiLXPvoN5KZoGfZjGAaR4ulszQN624RLqKS28t1rnkvI6AxLhu4267ms7bwSmDoXMWU3D2ZtE47s+gq/FX/LZfvvIGSDB58/1xx6wIplUH18UV+6XIgM6cgqEEsAeeL88X0lyOfDHxDcWJDzWn3tIH4UUwLvJQ+23A8HTOLBpbbgCAhzydZ5anR+wYsKJvKzs3r4oolG76ogcbQ7ReBxy9xSVqiPgDs1YQO6mx7DquYAhnhUtmje5gw8vWFEYpzJYzoVzhD28NJkSGQ2jKQiFaxKyCcUF8xhEzmXa+R1UvfR9LL0w9ijkm9etNgY4JLD4HwPVGACbLiqFlnoAHKVbk/PXUwa2LGplIuEBrNAO7oRVlCHfEMiSpDp+vTiTiFzHR6kGT6wD8ZdTOP9Zs2JVehVzEev39k/2r693DojcypJ4+tU8tuoIydlXRjkFqPi+j7PF4gfl1z9AL0OfHk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(47076005)(966005)(336012)(83380400001)(16526019)(5660300002)(1076003)(6666004)(82310400005)(107886003)(478600001)(110136005)(316002)(186003)(54906003)(356005)(426003)(26005)(86362001)(2616005)(8676002)(4326008)(70206006)(70586007)(40480700001)(41300700001)(8936002)(36860700001)(40460700003)(7636003)(36756003)(82740400003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 01:00:35.5423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf1abac-c550-4a84-5337-08db2b3a02bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00001A5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506
Subject: [virtio-dev] [PATCH v5 7/8] virtio-net: Avoid duplicate receive queue example

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

