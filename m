Return-Path: <virtio-dev-return-11758-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1236C74A5B
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:06:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 43B0729FE2
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:05:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 45F44986943
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:05:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7B1689865F5; Fri, 24 Mar 2023 01:05:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 66CA3986463;
	Fri, 24 Mar 2023 01:05:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgdz8fwOyM80W3PAr3Yh44ZKgu6cPXZwVTXhYHm4m9ZyavbxVd1wDX9/Lp2DHOc/rENrliXu6juYQsWZKFlMH9qY5jRQzFyVFRGz8PeFNeLvpY/WsyIised+PNdII4ukATRfLpMa7B0Pb7bctfGUlR0DtiV7WmqedotLBWCxtLBM2tPBHmSSvXkXRWJjyXjlpO9D4Uv4Ejx66AscUPmXI/bniLfEmg47CuqJ/HfqnVbTHQ1QbVqtO5AxVY4mgJM2E39kpOgpg/iZXjDoYBm/pnVYCA2rhY9W+506vXGplKDy1myI8/f6KFDkF78P2f9nPINq0/4bRDUj6Dt3tWqtpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcyMZN0RuyQjhc65CB01H31HgGj7Oro9NQwIVEqgGQk=;
 b=ILMYMBwEp0K5uCM/0j0fNL2E0cXyBttehwmpPe416fFWrDPTEBgp+KRwtNhwsawPBptgvUd4Z0WFfCe0jaj9uyt0ZMdrmVDA6oyNO3UreQHOL9RuQc9J8Dx0nzwY5exuOIkGhDLkFLA5QgVfpYW+Z0Xrq1EnGJn7lJyurTg5ngjLTxmeJOxIiqLPtzwzRR1I5OYlqQNGFj2nQraGfE92rfoc/+ouARYp3EI6tjvewebKVACwm1D1fxrnsaITK+xDpQkgGHE0ntRll5uUYJhff/paRBZLE1zRfVqlob+NH7mwqp8wd+vAPQQtHBBmo25+OJfUS+TKcvg+8vCOIyWexQ==
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
Date: Fri, 24 Mar 2023 04:04:31 +0300
Message-ID: <20230324010432.280330-8-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230324010432.280330-1-parav@nvidia.com>
References: <20230324010432.280330-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ade72d-9d11-4917-1ac5-08db2c03cc3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0VXxWIddl9XAhu6+yoOv1azh1lMZrwzZ3onoK2r+kzjE9fy8VcmAcGOBphKwPNxgd49vurhmmfB3V4TI9mfK5KkgA99tIb8LjJbseHaOi3asWAWB/nd6WA1j5+g9E2OxwIS9RoUDx8l/pGxP3xfkOs5/xwRHtGFta3NB/aQjbwSdSEs6OIwb6GeLYF3ouCAcQGfgZBphR7Xic0MzGmvODpB1GggahBCAqy9117FoikgLyFR6jbgjruk5rX33oDCnd7N79Tina43dhTkhdvgTGTH9rUs0unXV1GMqGYlPK9mTHBTeDqkTJ+1YsCw5/m4XB350zx5zKiADDEzLrk9KKeQccKE1qrgDZ+c+HLprY0JbSiIrvOgLOwV8oA92dq9wdmE5AMsDKC9116wiUHIFZBOhAxp+yu9GzYS0DwQXfrb75bfF41a8XdEVLXv+8tc18vUSh/Txrd79yBgWAP8uH/uqyHkL8r+soaSBue4kHZ7NiDsb6+0rh4YHg5AH/+mNiuTtyUHoL472/+gB41ZMIYKbg3mkNWVmZBwIdAWBWW9h/kBcvLjj27HYEQmFrx+EdDRU+V7C/UlINqMxRpMEtkwdhWb0bd6Pf8c3v6pHUfM7s+e2w5rYOUyFdRfgnXmm63zfLM2933DKolmTSDqwEWFZD9UHSFlRri4Nz3ZjsLkP0SshSxTQJH/kzs2hDox6JHgAGRU6tbILcpWn7380yg14W1anz38a2OSTOGMuzYfscXFkO4bHUkzKN3rnMi8HEcW+xvfmXkRRI/LoQbEsb+RfvzeUPfOoB3aEVaQk1KM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(478600001)(70206006)(8676002)(4326008)(36860700001)(70586007)(54906003)(41300700001)(82740400003)(8936002)(110136005)(5660300002)(47076005)(426003)(107886003)(1076003)(7636003)(6666004)(26005)(186003)(2616005)(336012)(16526019)(966005)(83380400001)(316002)(86362001)(82310400005)(36756003)(40480700001)(356005)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 01:05:02.4419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ade72d-9d11-4917-1ac5-08db2c03cc3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905
Subject: [virtio-dev] [PATCH v6 7/8] virtio-net: Avoid duplicate receive queue example

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

