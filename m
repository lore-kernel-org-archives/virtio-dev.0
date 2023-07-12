Return-Path: <virtio-dev-return-13357-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911DCEB64DD
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:24:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C4B28120D49
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:24:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AFF4D9867E1
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:24:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A15E99867B3; Wed, 12 Jul 2023 22:24:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 87E6A9867B4;
	Wed, 12 Jul 2023 22:24:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5HRlAf7k1PNGVuMsQ+dnfrfNXWkTm16M2K+a4eM7W7l6M8OMC3o0K1ZX3SMPQJoOBt4VyYRqGJoRQHT6xkLGUpTYvsU/BoreTZ/YgbmvFy9EuS8HKn+AxGkwP46PHZV2nXZ/BkyvhQmTWPAymx/Uwb0o6MsX8g8YQWWvjkSj1sKwyacykw8TcgLLSAUk0i0rnIE12JjssVJTWNsYWfr8JT0a6x5eYNvch7IDguPynIXMwgqOSgtunwuJUkxnQtNLo6SCmL+QdDAxCns978tt9qTcoXRU4+P2Fy/8ZIp5l2r57kpnaYts1VXWfA9hj7WmdD+cLpHgEH8GMTW73N5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5gBksaLW6nX7PZWQPUIiC9+Knp/E4gnjh8F8YjoRf0=;
 b=Uor010M2nEZwJKoCm4bI8z8g0Dd8EaEHMJKn8SBAZy/+lVm6ZUw1vRA7bMEolYUsuF+pB0lSIWo1rPO1XjStHWFd7JK2iN/TEnQ0L1Iz+aJiGreKM15Lo2KL8zs7ujEHMaixo9jo2tGPxfM9BvGO85/toBqorg2f8+0jBlrSzGy9aDZieTOljnM/Im3EWt/wenmnaOy06M2esM4XndD4/6/So/2N2dMnxtq+o2PDk4rN+NkJGEtcj/ae6yJAPPWvO2YJOQ6YOlsdGpnW4oMQfmcihgDV3sQpDGM9cDQUfeBfVTgv6wC9m5DCCR/lgBkA09J9qJ6ELfQS1pvd+Bg+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.oasis-open.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <virtio-comment@lists.oasis-open.org>, <mst@redhat.com>,
	<cohuck@redhat.com>
CC: <virtio-dev@lists.oasis-open.org>, <hengqi@linux.alibaba.com>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Thu, 13 Jul 2023 01:24:02 +0300
Message-ID: <20230712222405.455201-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230712222405.455201-1-parav@nvidia.com>
References: <20230712222405.455201-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|BL1PR12MB5271:EE_
X-MS-Office365-Filtering-Correlation-Id: ad31c085-8138-4066-a66f-08db8326c285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KZ5xdNdJZAefdNBTjyacW5EN2SFsFEL72MgAjV+VU+wjeXFgihIvh6AaWpMLXy86j/1ZKaOb4MCy/rNPVGSc6Z1eC5L8ERkaSU19+1Y1FviKouvaEEkRtoW3HrIQt9ecZfB85T9j0nO9NNWcRl0LSOteuyJliH9Kcgfus6sldW0a9a5G928n0D9HeS8W+CqyzbclUvCUttILQEHfLlC+yhkPddSRaF5C1UOdMGvsAX+ou7yvsLovhJaDoM3TruSY7VUs62P56nua8A+tY28RXndX8gNHBrmAYgGuzz31a0cQZLVH0+agqJ06SXhae1skFYPP/ndDzPYnVGqi3TOxdgcjry3ONDAz/wuBrRdniJG+EWDAam45+nw4s1CIy0MzMOYLKADJxmVMbNfxaOmAfeATrgYM2oyzDhUtnSwvt/3GoR7hRR8kUmpdbaCvZbS3N8VggK157wGTIiwQztXanUaBaORM/qom1sn278KG9VSrBthilkXFm2Hv88JLiKPHbMERJxjTTARGDOOG3ANh1fmJ3oy1hcEtal2zeYzDy8schFSOFIM7J6MPxIAn5FfZoTwyqeDR3BnaRw0ZeAaT89A1NsoC75ZHADfCX1do6B+3sVYe8o4F/rkpX23j+ws8bx+hVN2KZ51GZDrcjKjGHC1obJUyF8vrDRmkKqPIret6Ek5SOCpibUhVYINB6Z7t1JDdY++ehNDTyJMNY5kIAKzYKdLqNmjXe3pVcy40JFduMUQnI0Y3ZAu9HygGZQxo
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(4326008)(70206006)(70586007)(316002)(2906002)(41300700001)(478600001)(8676002)(8936002)(110136005)(54906003)(5660300002)(36860700001)(6666004)(40460700003)(107886003)(40480700001)(1076003)(186003)(16526019)(36756003)(426003)(83380400001)(336012)(47076005)(7636003)(82740400003)(356005)(26005)(82310400005)(2616005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 22:24:29.7185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad31c085-8138-4066-a66f-08db8326c285
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5271
Subject: [virtio-dev] [PATCH 1/4] virtio-net: Place C code under listing

With extra white space for the define, pdf generation fails.
Also place the C code under listing.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 device-types/net/description.tex | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index 206020d..6fd4a20 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1024,12 +1024,14 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 If VIRTIO_NET_F_HASH_TUNNEL has been negotiated, the driver can send the command
 VIRTIO_NET_CTRL_HASH_TUNNEL_SET to configure the calculation of the inner header hash.
 
+\begin{lstlisting}
 struct virtnet_hash_tunnel {
     le32 enabled_tunnel_types;
 };
 
 #define VIRTIO_NET_CTRL_HASH_TUNNEL 7
- #define VIRTIO_NET_CTRL_HASH_TUNNEL_SET 0
+#define VIRTIO_NET_CTRL_HASH_TUNNEL_SET 0
+\end{lstlisting}
 
 Field \field{enabled_tunnel_types} contains the bitmask of encapsulation types enabled for inner header hash.
 See \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets /
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

