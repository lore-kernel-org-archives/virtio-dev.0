Return-Path: <virtio-dev-return-11867-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EC2C6FD1D
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0CF5C6E6CC
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CF9869868D4
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2446F986808; Thu, 30 Mar 2023 22:59:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DD7609865A8;
	Thu, 30 Mar 2023 22:59:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VH7PAv09icc0Qqkx7KwR4pAPc7ZqOJxIMSswXFaqYcImRLV5adr/9Waqib40FKJl1seSJx86+cGqrMh9OI70d6SXs62AeMAHxaA8Jmv0vRKmcJVGpUEMSrGzYt/CBTypkBrkZK1gRX64LquySvCFSTqVQaNADBrSgGk7udmjOlz2L3+OXznc6Fe/NfJxlTq6dDiqq3qixU79GGjE+vf+gf3urC9+lJZF1I52cPRSdRnMYwzXX7SP38qLoAqnx3oSTVjyrGFHgH8rstssqNH9axvkl1c1TolMVRrTtHxfgD+3+AvogYAa/SusHTtmGGQzGyNUKPXasq19q/QcehaoqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fbzqFU6DDkk8rn4e6jpqaA2XfFiG+6KDE3n+Jg+VPQ=;
 b=gzwuskp5h2RY2Bc9dpXuYG3u4C1qmcyI160qlVSJydGC66inA7l5zoBvWFCrbjATLlcZIuMk/cFqVuKP/sKhLk644tPD9JL1Rq1YPrU0io0i8xVTqTDjxVvasb6W6Yx8ymw8Et+VVQ5GpMbLZtFEceVL1AzEfeYgDUvPG7UPJcy+kx5Sc/45rDGRgSvGarOWUvfILGL3xQ6ZcOS0F4/56qbIhtEoYSkPooyCcEfnoDvx62o55eROdS7oF5EHeHzFJigFNLAcoGoXDQaVJQkSvZ2bXKqU9TjB6LlMmDCbx5VCKeBlCDLGOjJzsPHJTaCqwQvp4qkoAXfwpOv6EbUL7A==
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
	<parav@nvidia.com>
Date: Fri, 31 Mar 2023 01:58:24 +0300
Message-ID: <20230330225834.506969-2-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT006:EE_|SJ0PR12MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b597c08-bc30-4358-d81c-08db3172677c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dCAiwbNyhQ1Z7YVmDebSlKlMjCJC3NiUF6w6GqERdxOKTVhdnj9ceC0gRLmNHOAnfC7Y/XvkijZ2rM2I193EKX0Xlw7099JY7Qorl7PjdCRmuobYFPH5X5kej7pQy8UipWvLkTBCzeI8EMenpZQ6yvjHSzcfvzy4PwFLAII+qggDApbIaAXClliGXdhDjDUcbY6M759dzf//s8mCgANtI1Czm1vO2/d8S7pZZNI7F1gsR3P0CDt+9nRPcVZLFAwYFg4xBr0+4q53zChfqOsi36RXgBqm07fz4sMtIrmUHGt/SnWStQGpjNFh3LFiTR2Rkhi6157g4YnuagnUEVfCi23NI+70eRgRH61jpHYoQnM9Slz53Cc2/zOoi3Q1SK21WNYayeukqco6y1RpD6cc2t6Ys1tcflOK6mhYw52B2lxsQVEtCzMuZQDPJGEGPmwCmtpCpu0OLxtTRQNkNOfvrNtv0Q6rOLfDRoMd1TIpI9GUhRS0V16+BFCl8aia/aAiOwjqATvUL0TDZnN0/pRj+Rb/GpeZ5EPpfNrKReOnP8zi7qKbLe2CsYmjtTGXA10vezcy0D0rZlVCtcS1b2N2WGdY0KGJ57q0fzkCSDVg15pYE2i5q1d5SkKMXYJFba7FBORvxG1/0FEE/uldaha5vnVgCT5qDNcVjiQBb8xoIIr3E96N4vJAR4/qro0spa1datucnyzUxTPMCJC0UtMjORiPDFoM4byeW3pTnP12VoxHRyoZ0FG4iWAc3B/8YlVhPoosPA32ZEF87kgifsGEr4y5QdCYne73xnaJkWUpgSg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(2906002)(8936002)(40460700003)(356005)(82740400003)(41300700001)(7636003)(5660300002)(86362001)(36756003)(82310400005)(40480700001)(54906003)(316002)(110136005)(426003)(336012)(47076005)(34020700004)(478600001)(36860700001)(26005)(70586007)(6666004)(70206006)(4326008)(8676002)(107886003)(2616005)(83380400001)(16526019)(1076003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 22:59:23.3762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b597c08-bc30-4358-d81c-08db3172677c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6966
Subject: [virtio-dev] [PATCH 01/11] transport-pci: Use lowecase alphabets

Use uniformly lowercase alphabets to write PCI vendor id and device id.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-pci.tex | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 85b2dae..7f27107 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -18,17 +18,17 @@ \section{Virtio Over PCI Bus}\label{sec:Virtio Transport Options / Virtio Over P
 
 \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
 
-Any PCI device with PCI Vendor ID 0x1AF4, and PCI Device ID 0x1000 through
-0x107F inclusive is a virtio device. The actual value within this range
+Any PCI device with PCI Vendor ID 0x1af4, and PCI Device ID 0x1000 through
+0x107f inclusive is a virtio device. The actual value within this range
 indicates which virtio device is supported by the device.
 The PCI Device ID is calculated by adding 0x1040 to the Virtio Device ID,
 as indicated in section \ref{sec:Device Types}.
 Additionally, devices MAY utilize a Transitional PCI Device ID range,
-0x1000 to 0x103F depending on the device type.
+0x1000 to 0x103f depending on the device type.
 
 \devicenormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
 
-Devices MUST have the PCI Vendor ID 0x1AF4.
+Devices MUST have the PCI Vendor ID 0x1af4.
 Devices MUST either have the PCI Device ID calculated by adding 0x1040
 to the Virtio Device ID, as indicated in section \ref{sec:Device
 Types} or have the Transitional PCI Device ID depending on the device type,
@@ -69,13 +69,13 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
 to drive the device.
 
 \drivernormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
-Drivers MUST match devices with the PCI Vendor ID 0x1AF4 and
+Drivers MUST match devices with the PCI Vendor ID 0x1af4 and
 the PCI Device ID in the range 0x1040 to 0x107f,
 calculated by adding 0x1040 to the Virtio Device ID,
 as indicated in section \ref{sec:Device Types}.
 Drivers for device types listed in section \ref{sec:Virtio
 Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
-MUST match devices with the PCI Vendor ID 0x1AF4 and
+MUST match devices with the PCI Vendor ID 0x1af4 and
 the Transitional PCI Device ID indicated in section
  \ref{sec:Virtio
 Transport Options / Virtio Over PCI Bus / PCI Device Discovery}.
@@ -691,7 +691,7 @@ \subsubsection{Vendor data capability}\label{sec:Virtio
 Devices CAN present multiple Vendor data capabilities with
 either different or identical \field{vendor_id} values.
 
-The value \field{vendor_id} MUST NOT equal 0x1AF4.
+The value \field{vendor_id} MUST NOT equal 0x1af4.
 
 The size of the Vendor data capability MUST be a multiple of 4 bytes.
 
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

