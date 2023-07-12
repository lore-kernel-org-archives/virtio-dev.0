Return-Path: <virtio-dev-return-13361-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A469EB64DA
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:25:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DFD042AD55
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:25:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D637D9867CC
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:25:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C83FA9867B4; Wed, 12 Jul 2023 22:25:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0819698682F;
	Wed, 12 Jul 2023 22:24:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIMGVzOlZhFJ4WQgCw66lXle6daMKpdhQm7pWBsrylOzxLL3Q6FXmX+XVDW8Vqtzpp1EB6mGEcyhYFlycUrCwgH222QQ3qhIU8KoE7QdtmxftE4l+otoMX0NahuUaNBIgB78d8oM2sGbbceYWzR1J6zLmCEePvY09xtKp18LYbFb1hQLIAz5s0vXBOlGYHD63BX86EVG8ySijgeMGcxGp02NkP8RQOhLXZ9WZ6+1rY3ZyybQgwRhXTU6g06juH5xrO/1ML+2NtAbDmkddwX8+NUwmQmSgiaUla0wovQ95KQtc5q5Fr79KoWOVY0H4FYWBvBo/1BKicc+zFXGMt54EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnSyP0OhVYiRgDi+K3H6zsVzOZ1I3unm+D2HnTnazuQ=;
 b=cyx1ix8tdkyBNMvnRG4ZLJEzu29KH4px7D80fyzaFlI39x8g8f/Uk+pp0jkSxyer6ArN9GSSx5bO9rqF1jUfUA0rw4jOiMwSDSVoWiucQFVQCSEx3dcPwqCZvltJ022cVxf8PplVhp8Xjz8VuuPqV55VGiMLFrIWZI1Zm1nLs0WZRs+xashEpTeYEzdBs3ROBrCA4rdVONllUpIUx3tDoH3LPqEtWniVWyIoK2iuNlgbTM7uQqCdwSIzB5ZQBoP3Vdb972+u+gvuT5wyVZDbybpc8SdLijab7DbxIxCw1ikDEsvrFAxY9dyaCylxTvpljE6JMC03syc0oyAy6iAjwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.oasis-open.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <virtio-comment@lists.oasis-open.org>, <mst@redhat.com>,
	<cohuck@redhat.com>
CC: <virtio-dev@lists.oasis-open.org>, <hengqi@linux.alibaba.com>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Thu, 13 Jul 2023 01:24:04 +0300
Message-ID: <20230712222405.455201-4-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT085:EE_|SA3PR12MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: e9318eec-ec02-4bd5-59d0-08db8326c975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zH9jVzGBMLUy0SfBppj70tBuXOntM4WADSS3fNs+ly4guUxvWK6cP0U9gsyn+VwHNRJxg960r/zd0a/EpnYO6OOYUwwjbkuPpuwagc5JpnqatzHRpy8XfzEUGirlJ5OcpgkYcP2dRC6ju3bilf7MubQE5+z0FnHEQu1lQTGCHlt6xH/JzsPEG1p00fxmmV7CW8HOjmYk3vqX7s07mVmXVYlw2NZl/3+Umg85VMg0d5gTM5iTeAShrnPN8s/JjFnTPSUcr8ewo0dOyjrXzgAVHPmBNEDyRshGwvg7pUPIP24PxzX5xUGmr7+fR7GCiz0y7+Ol9VqPQNOvovvuO5Rh026pdo4iifDjoFh8d0n5QuSTxphh8x+37lb2oHjSkY6nx0H9i6B6c6HCNLXi8Tf+SxsqOnqsZ52aPY796Y+MYGdm2rL+DNfB12q4J46u43glA4DGrYlmuCkf+XFqiIO+s+s368CCJDndsL/T1MZWaKV5M74Wr6NwiH9LTWyP0Gia+NWlLC9U7d4qddFxsKOVPAAPk4pazw7mvUxa8+tPUUNai7fLO510Uth4G2D5bjBgWny++SXn+92jfCMZuS2uPlW70PyCS4BvmbnU2qlr2oTAHCtEZODydzfHgnF/WT4h2CW/1AxF0E+rXOb0pKq9xC4GrWwRrJ/JmHTny9AqmdmLBphI8Nwx5TWK5hSPd9+23uUMgEgBXfzHhTdQtAut7ITU+ouIvo0+WzkodYkJLU+Hn9csUJP8DRhm56ljP6ww
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(41300700001)(8936002)(8676002)(54906003)(6666004)(110136005)(40480700001)(5660300002)(2906002)(316002)(4326008)(70206006)(70586007)(40460700003)(426003)(36756003)(478600001)(107886003)(186003)(86362001)(336012)(82310400005)(16526019)(356005)(7636003)(47076005)(83380400001)(82740400003)(2616005)(26005)(1076003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 22:24:41.2776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9318eec-ec02-4bd5-59d0-08db8326c975
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804
Subject: [virtio-dev] [PATCH 3/4] virtio-net: Use table to describe inner hash to rfc mapping

hyperlinks inside the C comments do not work well.
Until we find out a way to represent it, lets present this in table
form.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 device-types/net/description.tex | 35 ++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index 53c811f..68311ab 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1065,17 +1065,30 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 Hash calculation for incoming packets / Encapsulation types supported/enabled for inner header hash}
 
 Encapsulation types applicable for inner header hash:
-\begin{lstlisting}
-#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2784    (1 << 0) /* \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]} */
-#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2890    (1 << 1) /* \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]} */
-#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_7676    (1 << 2) /* \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]} */
-#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_UDP     (1 << 3) /* \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]} */
-#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 4) /* \hyperref[intro:vxlan]{[VXLAN]} */
-#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN_GPE   (1 << 5) /* \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]} */
-#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 6) /* \hyperref[intro:geneve]{[GENEVE]} */
-#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 7) /* \hyperref[intro:ipip]{[IPIP]} */
-#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 8) /* \hyperref[intro:nvgre]{[NVGRE]} */
-\end{lstlisting}
+
+\begin{tabular}{|l|l|l|}
+\hline
+Inner header hash type & Value & Reference \\
+\hline \hline
+VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2784 & (1 << 0) & \hyperref[intro:rfc2784]{RFC2784} \\
+\hline
+VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2890 & (1 << 1) & \hyperref[intro:rfc2784]{RFC2784} \\
+\hline
+VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_7676  & (1 << 2) & \hyperref[intro:rfc7676]{RFC7676} \\
+\hline
+VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_UDP   & (1 << 3) & \hyperref[intro:rfc8086]{GRE in UDP} \\
+\hline
+VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN     & (1 << 4) & \hyperref[intro:vxlan]{VXLAN} \\
+\hline
+VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN_GPE & (1 << 5) & \hyperref[intro:vxlan gpe]{VXLAN GPE} \\
+\hline
+VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE    & (1 << 6) & \hyperref[intro:geneve]{GENEVE} \\
+\hline
+VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP      & (1 << 7) & \hyperref[intro:ipip]{IPIP} \\
+\hline
+VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE     & (1 << 8) & \hyperref[intro:nvgre]{NVGRE} \\
+\hline
+\end{tabular}
 
 \subparagraph{Advice}
 Example uses of the inner header hash:
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

