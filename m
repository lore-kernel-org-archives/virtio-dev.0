Return-Path: <virtio-dev-return-11272-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C48DC6FA8E
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 23:13:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D386860266
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 23:13:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB06C9867A8
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 23:13:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C04FC98678E; Fri, 24 Feb 2023 23:13:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A2F60986784;
	Fri, 24 Feb 2023 23:12:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEPxZ1+st6BGUgPESVxllLP32Y6x7VkptlubftQi1qMM0jLdR0B9+ut4RXdyul8rrQhCkMi8UmkKpjAzf2ICuj8wVk8IsnVI+C6CGc9986+92RCNR7tIdrZNDUS4VSkgZBa/KVuopyaQ3m/I8qP9FxX2DyCUkKEsN2G9aAJPYJnTNRZ0loQQWpC+6tXwdV/f15Yf6RnhrSjMBWKbz7EOliEaUhQ0E2RFAK2kZLh/9Eq7B36f23Lhz4ncAOjTjrhNxti3zRCurER0XhY907MNbJiM49kScnxVmL9iWt4ZxQBcEWihQ9D6tNlrNlD9XDV3nwXpX/bBspf8WKExzev9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aik8ZuJzwML805z1xGj9dvtgolX6L3FZM9QNesX4Ano=;
 b=FJWQblsEAy3X+ihupPz41mBRB8hMlpRwwJbxbwZxX4Qchw0gFWZCBq/B0lP4YZuF2w70m5mJoRiCFmu9VvsKBIRk3YWtVGvdN28xoWjqsLBdJNT7J/qGAute3Yoauw65S24z+O1o2w8+nAgSHcgGydmtzORviZi6XmYTGLqZkSjhSZy8Kf95gFakKDAt6EgUhfX0sDqmzR7LGTodC16BvkRTriWZAVa+ar9tnhaPh31aNt6DIviz48YxQxsTJQxuNNX38R8ZhUHXaP30XT1rTT0Ww1YQeNfBrzYtqH2u+Teas+1ZbRGuFWrlTceqJ7+5MRxG0d21qivwGOa+ahbitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Sat, 25 Feb 2023 01:12:31 +0200
Message-ID: <20230224231232.340814-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230224231232.340814-1-parav@nvidia.com>
References: <20230224231232.340814-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 drhqmail201.nvidia.com (10.126.190.180)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT059:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec48fbd-9771-4de2-0d36-08db16bca933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ynVGSHXHEZb0IEOKerLUh6xGzMA0ZJ9kIl4xyj8EugdNPjzKF7lhJYMgihH7E24USsVOCvDg29M1lO6uq3CaqhU1SQ/NgNSe6rJfwYXdidaTK9HgMuGx5zRt7DFAzl/y2bxxKyWVpdCweYsSmlIU5uLKyMr7ICYVuKBEJoZ7A0IboD4J2/mxQJiep13pJ+8kpQgIkLCibWBzEJof0tMBkE7xnfXfkEEKfSXjgmGY1R7uN2daTqzUi4IFc4ipnKDjeUUmxqqMLuLvXnj3y/UVC1xx9vlaPa24giH7kAcnVFRPn7zQA25y2o1hZ6r2ixGoBI5BCfO3QuiKe7JsZXSKGkSNmsNdDgRGQ5iFu9g/HKwe6D7wpID6VX6VJ5a5/rqcVP2gdHMalDHm74LyppORGG6g225AwqIgiV8KdKNduOQmHHjB/1rh14MmUaUBcCAa0icIFw7bGUFzYrQhLHkZDef/CY7XvZ5wf5s9UYJOMQpETqkN6fLh/7fbfn0HmwSOyUT/+s7SEnne8jwyBp56E3HBt7GWjmj52hsaSw+WOqq++u9ZiPGJgLM4Ub2687PAiQwfWGIymyUMDPTzZFUdeprlWnSsKf7fhBO3GL8iDMmeMSC7pwWgtYYahh6arC+89pYiAcCHkMUdm/MZr+hFUuj0LkmkzY6I5hHbtk69/zGab3gDUcgCH6OURVyAbX5xgsZUwk8NByc1ChdbHRI24bqFChow8Qr91I6VnEp2wBo=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(186003)(16526019)(26005)(40460700003)(70586007)(4326008)(70206006)(7636003)(34020700004)(83380400001)(82740400003)(356005)(8936002)(8676002)(41300700001)(2906002)(6666004)(36860700001)(1076003)(336012)(40480700001)(5660300002)(47076005)(478600001)(107886003)(426003)(2616005)(36756003)(316002)(110136005)(54906003)(86362001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 23:12:55.0008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec48fbd-9771-4de2-0d36-08db16bca933
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623
Subject: [virtio-dev] [PATCH 1/2] transport-pci: Use capital alphabets
Message-ID: <20230224231231.VNnYmDrobueJrCAycCmHxgE-oCMrqFLEsuWqeSk-KKE@z>

Use capital alphabets to write PCI device id
similar to vendor id and existing device id.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-pci.tex | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 0642107..e271d51 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -61,7 +61,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
 the PCI Vendor and Device ID of the environment (for informational purposes by the driver).
 
 Non-transitional devices SHOULD have a PCI Device ID in the range
-0x1040 to 0x107f.
+0x1040 to 0x107F.
 Non-transitional devices SHOULD have a PCI Revision ID of 1 or higher.
 Non-transitional devices SHOULD have a PCI Subsystem Device ID of 0x40 or higher.
 
@@ -70,7 +70,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
 
 \drivernormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
 Drivers MUST match devices with the PCI Vendor ID 0x1AF4 and
-the PCI Device ID in the range 0x1040 to 0x107f,
+the PCI Device ID in the range 0x1040 to 0x107F,
 calculated by adding 0x1040 to the Virtio Device ID,
 as indicated in section \ref{sec:Device Types}.
 Drivers for device types listed in section \ref{sec:Virtio
@@ -89,7 +89,7 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Discovery}\label{sec:Virt
 Transitional devices MUST have the PCI Subsystem Device ID
 matching the Virtio Device ID, as indicated in section \ref{sec:Device Types}.
 Transitional devices MUST have the Transitional PCI Device ID in
-the range 0x1000 to 0x103f.
+the range 0x1000 to 0x103F.
 
 This is to match legacy drivers.
 
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

