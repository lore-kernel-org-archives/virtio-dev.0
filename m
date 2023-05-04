Return-Path: <virtio-dev-return-12543-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550AEC77B75
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:32:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8DDC0603FA
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:31:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 822E09866B7
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:31:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 757499862A9; Thu,  4 May 2023 02:31:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1D005986834;
	Thu,  4 May 2023 02:31:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckQmZmkQ+NYLi8joH8on4S4iU0IvLmtXQwaSkPCqXDSwNQSv4lX3fBKp6MigpPvgRW1k+zrFMfdYusj3Lhn28bGzduuvC249uEon5uMlmkiHWVaIzutfH4b11ZLQU28rN0sicRdDJogyuWuuKBBy3R9QmGhwPIYhoNPhRgj8NuQgg5fAlnfnbLRjJheAgWAFHVYy9UuR3z4ulV3vNuEHv3TMsBKhAT6n7WpChGYIlKtyInIH9KerWf5fWLBwpwTCJM0F7l1DStgoYBffj1BDnDOqMpqqWnbx4pYEBizOV7aHb3f5Ts+Gon6Wnd0kKxAlEmGJF3a5eB+K95JO6Lloxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=te4Hc5Rl0s9hzd5GnJLQkqRPFY7D4crERYFvW7XRDFc=;
 b=YFBvV21wp/ZSq10LQYY5nFUNd4U3QcIIJfIK5XR15ip6zv3QvsgsNjFl/35GejN0P+kxvw4OUMRGXZwwU+FUCIcNGyHkpjCBM5yj0Sh2lQa4am06HF6i+QxCwV7jgtLIVm2Z0VwH2ZYz8yg9ZUvAdU2BH5c5VwyKKSzDK8MISAnM4d2TEAzESp6ktTSuMmnKKseiDdV4utNDgkSGj6BAjRVv7fjG/ADWEVWlCjwLxWmKGP+n/oKemKG9BxrUt6g6//d3SuwOSfzT7LTLjtFE+ttRRYUAXT7JVs4RxDzS3F4hBX1kr5Lc48UtRt9NMSMhin7HurfkjxXQxg0awLZqfg==
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
	<david.edmondson@oracle.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Thu, 4 May 2023 05:29:57 +0300
Message-ID: <20230504022959.547025-10-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230504022959.547025-1-parav@nvidia.com>
References: <20230504022959.547025-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|SJ0PR12MB5454:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ad88e9-c938-4111-92e2-08db4c479036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mCg+T/lbWmr2daQ9uI0cxI/a+Fx5VvDa6lakFQmkQLGm1/oQLZaqEV04497dWc0So2JR60tHcxlo/Lfi+9zw1r83S7I2NE0f3zVpoSW/idGYWn3GZPueglHScLrrPnmeeD+uv0Zmu+DEWkw6ORwp4Q1IWStRjf+9u8JJToCtaFR1U3jfUbyc6u7L5si3XY/5pKThTOlKLHw8Sxr+BicrrqVijJkh4ByObfxEz1zLqv1uXLeTvYAh6Q7QM4iTQEhPTq/Bk14y/ulIibe6FfgzGeu1s1w8PZdg4yqath+kNAbiHY264qL+CXqZ/1jDlyD3gRwGlOIlfcNswnvEbjjd0Mk/O1J8V+qAQe7KosdtM/5j7S+WhHEV4Fwkaht22YaDdf1vFaSMWfjzZtPmlwzCzid3SyRopE1sbuwecP0jDXjtXf50bygjfd5zcXHfJWtwezf347rI8IRwv9sOQnF+V7KgnPATMfZx347zHooYaxEr+Myd3RfPgqTRh1yZCqMVsgNXk4/4yWbqgykZ2ooOiL0ps8TripCVzWWBmJzjsJ01jtqGIuBimxyxJ2M89bQHRJhTTqFZeIA3seieZ05Eq8tX4AnEF5isBYOidMKQvrb54DtfmDKuiDVFjshU0soVm92AxHhKOxdQE6Ebb4qsdecDgChdfVnYsZ1GeY5YPqnuUED5hJVp9GdFN3XKGrfKRWUp2xTbrc87B5qOgIXQaPm3etT9j9EyMaAN9/M+e6cMOL/l+t8wop2ilxSV2dS4
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(54906003)(110136005)(16526019)(2616005)(36860700001)(186003)(47076005)(966005)(6666004)(41300700001)(4326008)(26005)(426003)(336012)(107886003)(1076003)(83380400001)(316002)(70586007)(70206006)(8676002)(8936002)(7636003)(40460700003)(82740400003)(356005)(2906002)(5660300002)(40480700001)(86362001)(82310400005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 02:30:44.7379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ad88e9-c938-4111-92e2-08db4c479036
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5454
Subject: [virtio-dev] [PATCH v16 09/11] virtio-net: Avoid duplicate receive queue example

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

