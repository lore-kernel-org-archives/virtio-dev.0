Return-Path: <virtio-dev-return-11868-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E35C7619A
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 23:00:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 973D1759B1
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 603F0986946
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6376B9865F1; Thu, 30 Mar 2023 22:59:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7AA66986574;
	Thu, 30 Mar 2023 22:59:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fr4SrXikkPG95JtjVJaZuBZKSQzD3BUKWvC3YOcswvf/dTwnlRt171CO9b/xFXK9dDboImfIwfbsWIJunnOByoXCE4wKwnkp0koEzMlW1EC/lrOpKvCr1x0It5Cdx4uLARwf3mZx7cBaUyTklprR+peojKfkCMsdYUA6XhdXtxHPVyyF5PE0RlZ7rezwXysPKcLB1zQTagDLmZrPqGvQWxMUaA9O0CB+HSq2m2cPEtwMxJhaCioFEajH/NBRla3DGIq/bjdoJhoKSq5BYA7lcxwNiATo0vtgvJBfm6xOvWxgbiLIz+IowvvavhZJahZsiECxPpjcOsS/NWLj8KOlyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMy6CUQ4hFLIGp3F8fzMk1eE0Masw+53KfLr5gCtIlQ=;
 b=OB4P/fUBBxPgp1JqMWZ31jt6gwmGyg5zvgKlgNm6m3/BFfj+WJTZArNHxRDSMYUdLcg7vENKQIPc96rbN3CtxveUAwc2+Gi4LZi1M4k5RPvHp92t8H+POH07rbwccF9alooS8SYQR6a99BKt4DlSU5YpXGHP2zbljc98WvoJpqQ3S/2KLHiXJe4vkGfxSUQWM5a8UBycxjpHNbSdqYtzzw+o6S7ROdDhtqAta5mwlhQIJJnMQk83TXX2qHR3h2CUOBg/qJGq43D18UX81gbo+bR0fNc6uMbSco4ejrIV2DOz/n5FfNcRLcCywo+DawMTkZ/w6XaRpAVKCj+Sm9mHDQ==
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
Date: Fri, 31 Mar 2023 01:58:26 +0300
Message-ID: <20230330225834.506969-4-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|DM6PR12MB4578:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c7f88e-6b5b-4704-eb73-08db3172698c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PDrk7ytBg/Snje7V2QRopyfAYWBxVejI62346hKNNWzogaBdLkfHZ/FNdxdMBzpbysS1Ko5xlNsUDhOVASuMJ1+GEoPBCI6acmYzyMsnlReuA92gHZdzdjekB+jDP/ZLDzuzkpPoaYS62PUhOa5vOsWjTE1ULDHCD6BF6igHJCbAggH/rTv+sRmccYyOjHDr7cDIO+8sl4bwfc/Z0rYV3KL4SB/9LnV5205zqQ3L1duim3AdVXKO//RbJLy7BGUZDZY40y2hROu3BJGO8w+Pb3+JRpkNvW+0pAtun4GdV3OgGwD+LWqhZylZ7mm5DU7UNq3Ycqb2aVUahkrJ17t2mQT7ZMSdEKIo/7W+AAMfbk9TDDlsY0bLQz25Vr730dxpS0gylz8N0BRBfXQMeMyyE7edMlP96NAoC6OlPgCT/SomG9hJra99LuGYSsLuZPqAhNAqSa23De/FzGg6V1E5aBdFUqdzhnFgM8xDkzkQl23BHO6TNMPPVye52VZUmfrscan+ta7INLJXc4sBOf7k6RcV3U/d/XkpUHRmvBWC3pTN0qSDIsnAxgE/r0MLOTWAm5XLNn7xIQqjiwKbkKIzaMbrBz+Rb8wH/xQfQsXXnSpyi3MZCHPzZPfL3xYuM1RY9JyN5OAG/rhyrVvngMEe3Agg1av1dNWmnpWp8XN5lvWu1qsE58KW76+rZN829IfvygwwQCm12YCYLMZ8Z58vjzB7RfzsAytz2+raz/5KGuR/Pa9PrbCTrlgAV27BBW7RTWVx1C4NcH/aMWM0gqoRwA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(186003)(70586007)(70206006)(4326008)(16526019)(86362001)(8676002)(478600001)(40460700003)(54906003)(34020700004)(316002)(26005)(6666004)(40480700001)(110136005)(36860700001)(1076003)(8936002)(5660300002)(36756003)(2906002)(83380400001)(426003)(336012)(47076005)(41300700001)(356005)(82740400003)(2616005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 22:59:26.8370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c7f88e-6b5b-4704-eb73-08db3172698c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4578
Subject: [virtio-dev] [PATCH 03/11] transport-pci: Split notes of PCI Device Layout

Currently single legacy interface section describes PCI common
configuration layout and feature bits operation for the
legacy interface.

Hence, split PCI Device Layout legacy interface section into two
parts. First subsection for common configuration and second
subsection for feature bits.

Reviewed-by: Satananda Burla <sburla@marvell.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 conformance.tex   |  1 +
 transport-pci.tex | 14 +++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index 01ccd69..4f724c2 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -263,6 +263,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item Section \ref{sec:General Initialization And Device Operation / Device Initialization / Legacy Interface: Device Initialization}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery / Legacy Interfaces: A Note on PCI Device Discovery}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
+\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Legacy Interface: A Note on Feature Bits}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtio Device Configuration Layout Detection / Legacy Interface: A Note on Device Layout Detection}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtqueue Configuration / Legacy Interface: A Note on Virtqueue Configuration}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}
diff --git a/transport-pci.tex b/transport-pci.tex
index 1f74c6f..65d9748 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -845,16 +845,20 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio
 devices MUST present the device-specific configuration space
 if any at an offset immediately following the general headers.
 
-Note that only Feature Bits 0 to 31 are accessible through the
-Legacy Interface. When used through the Legacy Interface,
-Transitional Devices MUST assume that Feature Bits 32 to 63
-are not acknowledged by Driver.
-
 As legacy devices had no \field{config_generation} field,
 see \ref{sec:Basic Facilities of a Virtio Device / Device
 Configuration Space / Legacy Interface: Device Configuration
 Space}~\nameref{sec:Basic Facilities of a Virtio Device / Device Configuration Space / Legacy Interface: Device Configuration Space} for workarounds.
 
+\subsubsection{Legacy Interface: A Note on Feature Bits}
+\label{sec:Virtio Transport Options / Virtio Over PCI Bus /
+Virtio Structure PCI Capabilities / Legacy Interface: A Note on Feature Bits}
+
+Only Feature Bits 0 to 31 are accessible through the
+Legacy Interface. When used through the Legacy Interface,
+Transitional Devices MUST assume that Feature Bits 32 to 63
+are not acknowledged by Driver.
+
 \subsubsection{Non-transitional Device With Legacy Driver: A Note
 on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio
 Over PCI Bus / PCI Device Layout / Non-transitional Device With
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

