Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6071D554
	for <virtio-dev@lists.linux.dev>; Wed, 25 Sep 2024 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275967; cv=fail; b=Jf0XzZ9FNk19240qc/nVE9xlBEE3JluEnI//lq6Vq02BVOr9nYe1C49tKkVVCQUQe6aTdcchSeDA9tp8dMnPsEwcG0aY2PqI786XxK4y45Bu778CBnJmSAB9ZNmwjpRAgkm9iHQU+A2WIC0xSMbaK0ul0G8htBoCjlpoMfXENH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275967; c=relaxed/simple;
	bh=+UepVsklpPSV34JDBpCOoP6gnMQMdVcDxJnyNeIp/FA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rHZqqPc6O68gXSQoTjnnhVbbNhR2lcR+vQxxfgaiJES/EXI+VEvfXnzSILaicRUSdpADhr7cQB0plvo2SMcwdAqc2cDLc7fT1iFmI9ALibkPJuRPuDUNA873qwdZesQI0KhlZWDBdWOLE8foYI7YgvJqa0wjn71TqFnCutnVoGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GBUbzNkO; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GBUbzNkO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOPijvS+wSex0apGy2Xq7L5Rs9mzeNrMIG5eg3anNgDA8xQ06efl6lUX9skb0hN9bJpFuXYxdceDojJ8VgZWiqrLgA0AcMzN703eU1lQh5cvXYTbp7q/ICxZM0IfK6dqu5mz20Md+d0qMOGebFLflXAVsLRrKEGLE5vN4uTch2BRGqe0lQP78vtDwNw+1RXCqAWkIUs/SQAPPYwejloLpFauotHxITgnEexRRoXXnusieHYuclnTgtHmVXmiq4H6KAsVrrP9a1o4AcTdS472OmVRFUiWTImuviuaew3SOfY5Ft8ZhJyimVvXFVq50HO2sp89CqKQExnbFykJUWbTpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZfZ92dJRZpv77ZMxZyFAl1c4Bzakf45L7d3aESRLG0=;
 b=Do7V5Vh0yu5sXFhnmz6KAmsJt35tkW47OaYAe6Po8Ju2tPmufUtrUSpfcPvs7i2qdy4AQ8iDQ8UvqnQp/YOsHeOiGTGREgdkGdsmnQ9X7pOsUSSFdrqPiJu3BzkpvALTMsZmEiz2J3jt/sMeox5BrJrIxWGv9s34512EG1+Fd/Olgb/4n17BlvstzI9nGQNX5aCRSU5FA9K+ASjq7etsK0EZ+wVK31lK1/TbXLZueuYiy9mfFQUc927Wx1qiqpuZmgBZSMdAPc/MQH+Zo5GrXRoyPmZrmqsWZQMPC5Bg1q6jbFvtPw4oK945OUjaB9SmJyJseHDkGmQDeqpjwbJNyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZfZ92dJRZpv77ZMxZyFAl1c4Bzakf45L7d3aESRLG0=;
 b=GBUbzNkObX4hO4JKoVziaS8SPatmVT9XvBcGTu25LtMtl911rzODFa3m/aKosTd9E7OSczS6nZRHKlogVIbHdzSgYYIUK0N3Y7RcVZL9bbjQPL2n63/8sY0E3MpPZPLnge8dc9MuqkZ3uImOXwEwourmJa1XNQkTcw94+p2RD3lbQLUdwWaTj3pql6Mzl21G/K46pJYBUH91CD8fGxzi2X9RFv0IGopif7QIrrv5DCBffzE271sLyd3nHEwGqtBDMd7qQQFDtXnZ3z6G6J7nDD/eh+4twliKc+57AUUoiCWiX6UREAXjG/PTljhXKDd2zxEB5eG6eLskRtVE5o+AIg==
Received: from CH3P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::13)
 by SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 14:52:40 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::27) by CH3P221CA0028.outlook.office365.com
 (2603:10b6:610:1e7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20 via Frontend
 Transport; Wed, 25 Sep 2024 14:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 14:52:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 25 Sep
 2024 07:52:31 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 25 Sep 2024 07:52:30 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 25 Sep 2024 07:52:29 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
	<stefanha@redhat.com>, <virtio-dev@lists.linux.dev>
CC: <oren@nvidia.com>, <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] virtio-blk: Add description for blk_size field
Date: Wed, 25 Sep 2024 17:52:28 +0300
Message-ID: <20240925145228.27953-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SJ2PR12MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 984a3f4c-0f75-4a7e-94c1-08dcdd71b3d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kzAPpdtw4ucgERFrwCbrR4fYzx2lXQLfEEHO4KUaA6qAn46RHJkrhp4+WsTT?=
 =?us-ascii?Q?oU/GZT3C2pb0FCO7Z+HXGdbKrYk9xKAoqg3yfQeU9R2I5IQ83WLz+gkXdBpL?=
 =?us-ascii?Q?U3es8p/OrPmTEpwGDapzJoqmSsoe8aoQ1ZS1+TwN5wVspBnljYnbYzoiVD09?=
 =?us-ascii?Q?piZWhrRPrGVyn3DYiChQsL3jePeR9cG/H2CevazpSO9Auh/7BQB9O9viKZ17?=
 =?us-ascii?Q?tMSYvA82gZAEq6xUdfmBSiI+goOGD9BaYKP2s96zo1NOAkrNicivXlR566Sq?=
 =?us-ascii?Q?d8S4mcfNfkNraDUsk6ETJEEa8gANTyEgPx9QE7Zh1SQmIEdafTOmsLOoD2sd?=
 =?us-ascii?Q?6/Ya29XQ4/DwKGYY8lKoDCThtVIE6swLAzABaabwpU1cEyzGU1f+rIQHBwUt?=
 =?us-ascii?Q?JN0dvk1cpDXRUYZeNIci8Rh8I2ZYkRiJbipCeW45nvwLb7mgw4j8ri81sGoh?=
 =?us-ascii?Q?llRhKjyjN1HI2iCUNfdjjhEzZM+0aBh0h3Od83t5reGT8o9ZFvbffiS+Rkde?=
 =?us-ascii?Q?F+2Se9GklVFdSvGQbWjCQEJlybJNz5znLUmrOLk/vBYAJEdai0PkcZoOw9gv?=
 =?us-ascii?Q?kmPR6VAsOtCheGWSUEO/lPIe7HfOVWZ66UkdvO+jHStWPMbJVVpEVhp3myqE?=
 =?us-ascii?Q?0tcVgO5AclhIFXDq39kIAnf5Hd/P8ZSxLIIKhyk/mEe5AgL4QjH4na6k8P/s?=
 =?us-ascii?Q?tLV53vK6NAnn3m4OGV8mhf2WMqui0wywwlKBhxMUOgabuD/G1lc0gvBwZSwa?=
 =?us-ascii?Q?BiwBHM6ZOJcOoHce2J8XbRZmW3D2h8dHq7XdN16c61GcVSVkTvUFOQTnr9Z4?=
 =?us-ascii?Q?a67+xK1iQ1lPorbmwB155ZbS6y0n6QCZZLPaPF5XwIb+mxzBkevdNZ46fBYn?=
 =?us-ascii?Q?YoIZRR1RvJkakV7Hf8kxdmM1scRlWVfGR/cJcC84K8V3iAquY8eAxmKNf9w+?=
 =?us-ascii?Q?vqD/EnYVWkTsZdS2PToe0E67HxYwWMvk9oSnfSg/OuzZZK0i96OEPTh37say?=
 =?us-ascii?Q?K41uK0oPbXUNQ82SLnDcGhcLuOYcXTIj/v0MDK2o1Gl1Odiee8JICtnx/FQO?=
 =?us-ascii?Q?SMbAQkj7EUk1LMKtYpd/xHkwkHdDMoi0ldYN+STkUb1ONKTbrTTGeuVhqCi5?=
 =?us-ascii?Q?opOwU7oGxabpMjLT/q7m80l6xHYFY8ip/gV4+EwvYoSxvSrx9t9cejme+4mO?=
 =?us-ascii?Q?5koAkd1TZcUUme/Dkn+YDVl8wkZ9N9TSIXfdX0BKMDTjJaJ85xNjnQDxLg70?=
 =?us-ascii?Q?PNtKdT5nTPRCq/GTA7dYmwCzSjILdAugQ62uoXCZJF8BHn2OMZorLp608a0F?=
 =?us-ascii?Q?IJM9H1mY3bNt/RNtWaygQlupPC/QsWYipNo8rGQvq0siORFia8BXZ4PfU+Z5?=
 =?us-ascii?Q?tbO025htLoZ/YE5pPR/AiC2bdisGYJ4buqB6pschwwuukgixdr1M5wykFdsW?=
 =?us-ascii?Q?16SNrLE/2GE+VrZ+N83qAS4aOXUZ8I8u?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 14:52:39.6039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 984a3f4c-0f75-4a7e-94c1-08dcdd71b3d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738

This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
set.

The blk_size field represents the smallest addressable unit of data that
can be read from or written to the device. It is always a power of two
and typically ranges from 512 bytes to larger values such as 4 KB.

Linux/Windows systems typically use 512-byte/4-KB block sizes.

This description provides clarity on the constraints of the blk_size
field.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 device-types/blk/description.tex | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
index 2712ada..88a7591 100644
--- a/device-types/blk/description.tex
+++ b/device-types/blk/description.tex
@@ -3,7 +3,10 @@ \section{Block Device}\label{sec:Device Types / Block Device}
 The virtio block device is a simple virtual block device (ie.
 disk). Read and write requests (and other exotic requests) are
 placed in one of its queues, and serviced (probably out of order) by the
-device except where noted.
+device except where noted. Each block device consists of a sequence of logical
+blocks. A logical block represents the smallest addressable unit of data that
+can be read from or written to the device. The logical block size is always a
+power of two. Logical block sizes may be 512 bytes, 1KB, 2KB, 4KB, 8KB, etc.
 
 \subsection{Device ID}\label{sec:Device Types / Block Device / Device ID}
   2
@@ -135,6 +138,9 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
 present. The availability of the others all depend on various feature
 bits as indicated above.
 
+The field \field{blk_size} exists only if VIRTIO_BLK_F_BLK_SIZE is set. This field
+reports the logical block size of the device, expressed in bytes.
+
 The field \field{num_queues} only exists if VIRTIO_BLK_F_MQ is set. This field specifies
 the number of queues.
 
@@ -228,7 +234,7 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 \item The device size can be read from \field{capacity}.
 
 \item If the VIRTIO_BLK_F_BLK_SIZE feature is negotiated,
-  \field{blk_size} can be read to determine the optimal sector size
+  \field{blk_size} can be read to determine the logical block size
   for the driver to use. This does not affect the units used in
   the protocol (always 512 bytes), but awareness of the correct
   value can affect performance.
@@ -282,6 +288,12 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 
 \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
 
+Drivers MUST negotiate VIRTIO_BLK_F_BLK_SIZE if the feature is offered by the
+device.
+
+If the VIRTIO_BLK_F_BLK_SIZE feature is not offered by the device, then drivers
+MAY assume that the logical block size is 512 bytes.
+
 Drivers SHOULD NOT negotiate VIRTIO_BLK_F_FLUSH if they are incapable of
 sending VIRTIO_BLK_T_FLUSH commands.
 
@@ -319,6 +331,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 
 \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
 
+Devices SHOULD always offer VIRTIO_BLK_F_BLK_SIZE feature. When this feature is
+offered, devices MUST initialize \field{blk_size} to a power of two greater
+than or equal to 512.
+
 Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
 if they offer VIRTIO_BLK_F_CONFIG_WCE.
 
-- 
2.18.1

