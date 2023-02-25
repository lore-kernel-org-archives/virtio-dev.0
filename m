Return-Path: <virtio-dev-return-11283-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C8FC7EE2D
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:07:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3181573184
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:07:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2BB14986792
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:07:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 20E5A9866A9; Sat, 25 Feb 2023 22:07:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0E1F298678D;
	Sat, 25 Feb 2023 22:06:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKinoVh1+JurFzSM7ZFDT8LCAAIFX4uowrKoJhuUMT7OFC4HYkazvkg9jl836sLzP3zAqJTnw+6mNDRCGJNz1b23MAb9m8vERnkTOokNQ2iI83LYe+8iWBTljWFRwV9UlZH+OBURgxI6uVd5hPDqfvk1p6sT2k5OJHVp2dU9NY0ENZPmUyGKjoKYZ2O1DY8QWQsdLMmoZteXEz3Yq6KtL3qvc6L6yK+arjsZLTiUr+vhHtSBVznfAuWfRCjkxWxo+aMWMDg2ppb5Hf2+9/9a+Cfmdg535S50tNxusob+aNuO3pM0ByAyPtXVwUFXBJubu2qEqralCtnRB3nUZaYWlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsnpShh4LqFrk1UYdSeGktNNfRufD6uftw9VJ/BtquI=;
 b=jx3KHlxfuQufseYSTBNcDpGewdsnskYis6LuzCaqYyxjtiDsHPIym0vzv7nPUkC0jKyYev1jEeugHZypIWTOuGIDPt2pN7xd9qpmX/pg0kfEVwlxsyXWIyL90n4H80c3YbMU8GGVSaso7SsXgSirnxy++DudErjdQsCqZRWBV5F+jmbFrqonudh/9tGgEczIxefl/IQ+V6lhUHS/kTN7EUDvTRbn/1iJtDrFLk8mPVbYa/eSlaE6+EEPaWDRNLKQdssJr9Yj/gY5NGY9FWd/FwfpfPjWqcuh7M9NqwcpGzCc0lRJ1P9f7efiFqSWkxMKAH8bTyqW1xO8FA+Iq3/E8A==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Sun, 26 Feb 2023 00:06:35 +0200
Message-ID: <20230225220636.429990-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230225220636.429990-1-parav@nvidia.com>
References: <20230225220636.429990-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 23562ac8-ec7a-4a97-6a3e-08db177c98da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1ohG2RcjqKrW5QkO0PAnIKQaU5n35mcoxGfPT/vbVpiqkqU2bv32HMgCFpIelsPfppMdEKATGGuq9/DvMpFkV0Oy1BlL2BWH709MKmSfK81yq0kcn/3nvYAKqCGTfPnGXmNnGqbgIyo/qzL3BQHoSo8fMo0RCkPIkscsmvJVXMDba3oBvj/FYZeB+Hy3JQyVOc5j0M06S6geWqwYBaKL31Xg1xBLaHjHvbQXiPqCfy30aQk6qxk2uzpndIB/x9t/uQ6dmBB5i3Ra+oBiZVP9MTvLfCbVF5U7e4AIOiPoPDh8UZx0ElnybF5Ju0ehyZl3B593LAFqcy2bvMssTHkNuhdVdGhi3wL7rzboN1Ncu6WehRJ5pg5nEQ1tweKAzw+ZpM6lpUuPcr20MGZMBquTg8I6fUay/4HmNXMB0gcqU2HZWE68pAmRcoDKUPwWBz54bRLvjv9lTF/zKiYWSWBbjhs/RW8MuVDO4fEie+DXFvBaYEVULHfw2QFKeSFF6dBnA7Us/00GF9BgBJ+2JIgzEoJ9nWhRmZgD0qLNW1Jc7uG3K4flDcBxEt/dXpW7QfD71rpT+vkk00PRtqJL7HA/+pSc7jodKry/I2oyNLVvs8Nh/AWVe546UUFucouZJGmo4DsL9l8npIrTpBz6k0DVG9j5cB4RywNQRJNmOP5Uc2mO+0PUrNgk+7otgEkPGP3Wa6ILq2V93L2/QG8DTIRydVPR3IDB9Be/tlek6wb/O9s=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(41300700001)(82310400005)(5660300002)(8936002)(34020700004)(86362001)(356005)(36860700001)(83380400001)(40480700001)(36756003)(82740400003)(7636003)(40460700003)(2616005)(426003)(47076005)(2906002)(54906003)(336012)(316002)(478600001)(1076003)(186003)(26005)(110136005)(16526019)(107886003)(6666004)(4326008)(8676002)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 22:06:50.9485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23562ac8-ec7a-4a97-6a3e-08db177c98da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013
Subject: [virtio-dev] [PATCH v1 1/2] transport-pci: Use lowecase alphabets
Message-ID: <20230225220635.P6Y92sntgVX2A07Vko_mkIiUUHwGdzanIqIyQIpSH30@z>

Use uniformly lowercase alphabets to write PCI vendor id and device id.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v0->v1:
- use all lowercase letters to define device and vedor id
---
 transport-pci.tex | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 0642107..9f9f076 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -18,8 +18,8 @@ \section{Virtio Over PCI Bus}\label{sec:Virtio Transport Options / Virtio Over P
 
 \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
 
-Any PCI device with PCI Vendor ID 0x1AF4, and PCI Device ID 0x1000 through
-0x107F inclusive is a virtio device. The actual value within this range
+Any PCI device with PCI Vendor ID 0x1af4, and PCI Device ID 0x1000 through
+0x107f inclusive is a virtio device. The actual value within this range
 indicates which virtio device is supported by the device.
 The PCI Device ID is calculated by adding 0x1040 to the Virtio Device ID,
 as indicated in section \ref{sec:Device Types}.
@@ -28,7 +28,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
 
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
@@ -89,7 +89,7 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Discovery}\label{sec:Virt
 Transitional devices MUST have the PCI Subsystem Device ID
 matching the Virtio Device ID, as indicated in section \ref{sec:Device Types}.
 Transitional devices MUST have the Transitional PCI Device ID in
-the range 0x1000 to 0x103f.
+the range 0x1000 to 0x103F.
 
 This is to match legacy drivers.
 
@@ -688,7 +688,7 @@ \subsubsection{Vendor data capability}\label{sec:Virtio
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

