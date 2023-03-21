Return-Path: <virtio-dev-return-11696-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEA7C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 22:00:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 622DD370E6
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 48B48986485
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3AEA3986450; Tue, 21 Mar 2023 21:59:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 080209864E3;
	Tue, 21 Mar 2023 21:59:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLbB5VOzGSkhfi15uicvHBdq7Nuc4Idv444KkM8PU/xqiFgJhdeNrwBOWCC0pF/9A1Fqe3i5Ebl/a0DRJ4ndonoOzDGjmiFRob++Smd/kGGghdvASQTLF+UApoT6diD1ZF6Hxh2xTwrIWa090Juh+hG25NV4NO+aPcYWceJOsQSUhB25sbOqFy6aoA/e0USvr1T7sj/fPqbBz5AUcJe15J3pzJ1lo6rQxALJFH0OWr/f1EaINhlfAIh71M27vZxcRgvzlJ787pkVTK6VkUgdwhp4p78M5G2+DBzBjsVwaeQJC+lM764Cj5u6iHUPUKXJifVbTUkgyPmu0XttyJ7F/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcyMZN0RuyQjhc65CB01H31HgGj7Oro9NQwIVEqgGQk=;
 b=Z61Lz7HZSyBlh4JCwqxwfYcJLVk6KeDO28Sj3Vgy6XYmkBGfhm4qOIewt2Rj2qtPI/b1jvsxnPpyQ9y+NsXIzsAuoe4D6NbGhvTRm0T7rmfkBGk+MXVVsG02yAYG0iee7Rm944iTN/P+uvMSs+ddOFdB79meS7XhLd4Htq2I6APpoKqrNtojvSe8KsHqwEuiyJhKz6VEKCSb6meW0o/62B0qCGQ+kmThTHy/wWYsiAE5FwLm9EJKHckZTAXTXxRf8IgToOlNbVq9XhoH5iNBAzMmaLoo3kOn4YPAI+puy5SBdZViJwAYeoZMfYburB68WSUr0Iv4Q4N1mQRBs2EqQA==
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
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Tue, 21 Mar 2023 23:58:33 +0200
Message-ID: <20230321215834.225856-8-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230321215834.225856-1-parav@nvidia.com>
References: <20230321215834.225856-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT019:EE_|SA1PR12MB8642:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2c940f-9efa-4635-b7c8-08db2a578074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sVCnkOOVuIxE8EgIACq0giC8ICIgRJ5fZVts8f3k22/4QyUaDnuyXd8AGteX3c+Ls5NNtPL4Rw/rcCVVDi90YeGOLVG39+Vuk2hyUOu+wIwg6AfEAxz972IQMyH5Wgd57UceL9gPLLGTsfFCWIM4U2ZNL0zAdqARRv964Pihp58uUUwt8/RSRrRFmmmqHbB4+4gcPgYmBi+3rW8IEeSzA+3iRtJWihgb+zoOD9ufMlJeoun5j1U64VX97MeK7/jXS3m+TU27Zre1eLbgIlxVttSepFFa6fZAme614ThF61jnQvfCKJTohiuOKu9xb9clxycEebNA6k8uirO4EZWLNegnwwtZV45ZQ50eYlvhpuZepUulPyjLhp3Sx+BdDfB0YjCz0oEj1D30IycEw3A/f7xvEAkIlchWq68hmytvVFEVp3o/PZnxkJ90p3YNplk7atOwKJ7axlde2XzKYlR4wf1YpiqnvLNrf1e4qGuRm/w0eMQdRYAUUySY/TLORer/x418GKsq3yDqV6f6TC1jevtES/L7gCNmjytK7+XckwVBBtIoCoCV7j96hPeV/a1QxRBohCr/8ymP0Qu+MVJ4CnLaLJWjjSEKVZ+o6tYtK/LYZThqzy3sag+0H2ZByle1pqB4dicrviAKz1s+QysWs3Awza0S1nQLscilTVCc1RaC8c9sqahLEiEeq9X7Gsx99lUksYvxbHGjZ32QY4oIOeNWvkOo+C6dEwX8s1kyjgGyjFQCRfc3vV22m9SVruo8s07SQs7aOFUUSo6H66GLPhwFTO2bdBN/9lK6T6U9mC4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199018)(40470700004)(46966006)(36840700001)(8936002)(41300700001)(40480700001)(5660300002)(36860700001)(7636003)(356005)(82310400005)(36756003)(86362001)(4326008)(82740400003)(2906002)(40460700003)(54906003)(1076003)(83380400001)(478600001)(16526019)(336012)(107886003)(6666004)(426003)(186003)(47076005)(26005)(966005)(8676002)(70586007)(70206006)(2616005)(110136005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 21:59:10.7305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2c940f-9efa-4635-b7c8-08db2a578074
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8642
Subject: [virtio-dev] [PATCH v3 7/8] virtio-net: Avoid duplicate receive queue example

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

