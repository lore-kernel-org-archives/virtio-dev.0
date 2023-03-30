Return-Path: <virtio-dev-return-11873-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8A3C6FD1D
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 23:00:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5D53398FBF
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 23:00:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 599DC986AA4
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 23:00:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4ECC3986810; Thu, 30 Mar 2023 23:00:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D3B1198689B;
	Thu, 30 Mar 2023 23:00:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9eisupZ4TlLx1QgLdrrtGLJ+mxsac//fj+LinlxdPDGKmWB54K3YD/2ubb2KQFJcozhSCiB0m9UVNyxWm9IYx+nrW0a21Vn1Ss2ZGBHoKvIGCBbvZOO9OtIUK17zLOAyGfjVHrk6jfj1N2uwNhMoSkxc8QzKl10tirfUvftWoE5abXcAlkqVueQtB1u3YvaOZ0TMuXfV1RAzpH0c8TkB8qPAJXzl/4mAuoh+QDAH66XHEBH1VutpBfHXOsRX3lwFgic0HPGI3nWkysogtw5cv6Jog22ntlnXNkYF9AB+OF8nqiwG3q+exbpCnlU5/5IWV0KdIDsI76t535fi+1Lhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIPT4x6v39QvctAomuzbBiZsyQyP12gJaQXHOpL4XDU=;
 b=nzPKW8e8NiTB/sNhwzJvRLRj3AhvJit6p8DCk+auZfzggMrpKxNPu+yZTuRuPTbXhcu9igabtdjPSr8UELOQ2bS9lm1zt9DHvVAx4Rrh5JiSdfCZCTraCfjtAYkut23Fcq6KkOJ8SakywYT8bIjv4RhGY3hkArRoaKLALWCA8Yvlwna73NYLnK4UyWr9g/maddajf7NIbn2VvXIy78EOQ/DDdqQA42mxuYR3D3up83ziXtR4r0XFbJmEykPSJ6YCQatwjM4MAvpTqtFQFEcPjMv6TCUkkYKnTsAIhJPZ/MqHX9Q6Ue2zyqcYcLgck0YQ6cy/SZ26evbzOBzTGFv5Mg==
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
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Satananda Burla <sburla@marvell.com>
Date: Fri, 31 Mar 2023 01:58:33 +0300
Message-ID: <20230330225834.506969-11-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230330225834.506969-1-parav@nvidia.com>
References: <20230330225834.506969-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT052:EE_|BL0PR12MB4948:EE_
X-MS-Office365-Filtering-Correlation-Id: 339274b9-25ed-4723-1ee7-08db31726dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KJNE51SrwArwxr81WRTDoTYeHPcd6tmxQ+yEHudJfcxcu3lBCld+VC/ND5+RuN4TU0ObYKKIMk2QmN4Uc7IRPqAClVBI7pfYXt27Z00soZLiXomNOQFc3ssrF9J3RlYa++QuFg0iBRzx/iBU8hnYIzRN/NOSR+EZkwRn3YQam4TV8FRDmB7V5CR5w+5cAgcWsKISNORYhVp49jrRbxnQoaPHYLTOvVSmsqU6N3Lvei1K3SP91FVUFrSiXjhWDCf7wrdeQoGFvIWIAn3/ecrZjH+iO8FZbmjeXp+WEDNH7xqvgmt1l2hg1kPPzalv0Lv4CMTPTZjPzFBhlH+5SU8RyxI27LFgZD3Q644S8udFxuYsBs0UGzmP0bLVniJEyExHFPXsaT86dr3I7qQMOO7pgF3gEQxcj8WvVxchmsGWH08deTp44LxdFuntVyH7IVuy7ahICFlnYZdGx99BW0WKMCyMbe3J3fJ4CIx0fg/2W9xbz1mSQLs8wJBaJ4dab1RtT9PN1a8tor3XpSv78Hi4rqc3Ix88x0MHJ7z1835PtRSVApEHNUZpBn8AQR8tx6JBs7V39Pgbca3fd9Gi1aD5ZsYcee4g3oLTSMTYYX4gpAu5rWlDCL8wNFk43IvfEFM8yE2IwWAjYflSETcx5eb9VaETLNZaClVQ8aCIz4IsVXXGlQmOsPNM353k/HrtUThcRMqpIJQeCQfKxZJn9xs6qZ9Xdn7kN0B2uVOmaqSZHXKW+sAVI0DEWxE3/h4pay6U
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(36840700001)(15650500001)(2906002)(8936002)(82740400003)(66899021)(5660300002)(41300700001)(7636003)(356005)(82310400005)(86362001)(36756003)(40480700001)(47076005)(478600001)(336012)(54906003)(36860700001)(34020700004)(16526019)(186003)(426003)(1076003)(26005)(6666004)(2616005)(8676002)(4326008)(83380400001)(70206006)(70586007)(110136005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 22:59:33.8507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 339274b9-25ed-4723-1ee7-08db31726dbb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4948
Subject: [virtio-dev] [PATCH 10/11] transport-pci: Use driver notification PCI capability

PCI devices support memory BAR regions for performant driver
notifications using the notification capability.
Enable transitional MMR devices to use it in simpler manner.

Co-developed-by: Satananda Burla <sburla@marvell.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-pci.tex | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/transport-pci.tex b/transport-pci.tex
index 55a6aa0..4fd9898 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -763,6 +763,34 @@ \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options
 cap.length >= queue_notify_off * notify_off_multiplier + 4
 \end{lstlisting}
 
+\paragraph{Transitional MMR Interface: A note on Notification Capability}
+\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Notification capability / Transitional MMR Interface}
+
+The transitional MMR device benefits from receiving driver
+notifications at the Queue Notification address offered using
+the notification capability, rather than via the memory mapped
+legacy QueueNotify configuration register.
+
+Transitional MMR device uses same Queue Notification address
+within a BAR for all virtqueues:
+\begin{lstlisting}
+cap.offset
+\end{lstlisting}
+
+The transitional MMR device MUST support Queue Notification
+address within a BAR for all virtqueues at:
+\begin{lstlisting}
+cap.offset
+\end{lstlisting}
+
+The transitional MMR driver that wants to use driver
+notifications offered using notification capability MUST use
+same Queue Notification address within a BAR for all virtqueues at:
+
+\begin{lstlisting}
+cap.offset
+\end{lstlisting}
+
 \subsubsection{ISR status capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / ISR status capability}
 
 The VIRTIO_PCI_CAP_ISR_CFG capability
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

