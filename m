Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A10136E3F
	for <virtio-dev@lists.linux.dev>; Sun,  6 Oct 2024 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728233788; cv=fail; b=MkIQ7Hlyn91T14rBob4depCUBuSsELK7ifKIn+dzwhesA2b3Wh4REl4grveC0CGn72YOahBFY1vDXUCZdRQ3TUZ/Db6qz7gi+8+k8A1v76jlesa1bOc2Qt4dYRM45hTkah3h6aRjosYog4qHlP6X3YptB2egnqr6bYzg5TXfJ90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728233788; c=relaxed/simple;
	bh=iLM1OpoIH8GoBimnK+IzKOCOxIepvwL5IOniYUVhuAA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OcwurPXV9jp5M9HaKXFaU8ccYZyFcaTv08Krt/TRU7f8HrI09Xq3EedzAN1LuzicBJjS8nSQb5gKgB9P0zvZMmlZ006nhH362JWFJbLAniWuZyb6yM3gm/TsRnRvnrY0QjwTYhfxt5lZtwkd5/2M2x8h2u3pzRDsSL/SKjm0ORA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UEbZRGXf; arc=fail smtp.client-ip=40.107.212.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UEbZRGXf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Au3FH3K+mYBd7W/oAEaI0Cnn/b/BxlOP4W0S0L7RM4zzYTC5Cq7Y9xFDGo6I9ir0lllKG57f4AcM91k8QsAxsCmqgQB0q2lU9khecsDm0dq1XqWQFyw8sP8BZKtL0Tt7/QxhfTQIhRF+gnUCMwBG6Z8JId4BQU/Nc14WrqmIY75ahr9jwu4AsCl0aZVT3Tvdn2BtjK5/210MY3eGM/8fzN3rXI0WfH6f+JGPOX0hx/KUDVlAG7CQ6LGV1PjTG2ioEaf05q+iNz835bBEMdS9SxVkNxRXkRTXwVAugWhckX039/PXnVwS2NEgdJQc3rU5EXL8mnB1Sq3QpZkHnqppjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZfD8vxXzSLvj30glOuvy5FqBaKqJz25cgjKGyjZE1c=;
 b=wljV+hpm43dbsHRABhkQAogGwGBOXnyV+8RO7iK4NTlr6DaQ5AArmfKpiJ+VBDNeXwOvTQmmfK4URCVBWmfsIw4K2k+6611lACm8Aa1wf7HqvAV+6iAyLh7qp/Gr/5VQM/kibhR92wlH0ezZLlAi+k+24gU/J1QHarjjrX3kLcE3zk08RsQLwCb+YeNVjUNKLPYq5V6NtixEGlhOwRxxRAfXZ829KsKCyapHrMtX9m98PhzJwklTA0wD8QrTMpununPIfHmsLRIO9MFSAABnMAhd7WzZgFInUSLTV++PQa9cQHYuxKYhv8eL1WFYYLW+rBrf9VtB5Wd8m5Dg47KAog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=chromium.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZfD8vxXzSLvj30glOuvy5FqBaKqJz25cgjKGyjZE1c=;
 b=UEbZRGXfkUPiFQkYwW+cK4G5gvJJGpx9ot4X/zSz0gfFhdF33B7oRYq7jj3w4AtDGZoYyG0iUB/r2Joukc5gfE0KFCdKK3tY5yefNIZmQK04U1YYvQjIPXRLu3p9Pauda4NMA20X4t1bhlDlcEBtX/j6ftPzyto7CrGm3v3JMwZTcymTF2zaSUs5P0gqFbOSwBsh3/Ao66a5e61bufYSKw2JuuIGm4JTwvGRBjQTc7EGGiNIJJKnKsgZ5+ru1yn9b2/dRDKB5N+MB3YF7ZcouYPSx0a77ZnyZpm5BgxAFhjfH+NE0AAT1obUeT4h47DtmsB3Qypk+6gT3LAIFUfXNw==
Received: from CH0PR03CA0301.namprd03.prod.outlook.com (2603:10b6:610:118::11)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Sun, 6 Oct
 2024 16:56:18 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::9c) by CH0PR03CA0301.outlook.office365.com
 (2603:10b6:610:118::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Sun, 6 Oct 2024 16:56:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Sun, 6 Oct 2024 16:56:18 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 6 Oct 2024
 09:56:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 6 Oct 2024 09:56:13 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 6 Oct 2024 09:56:11 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <dverkamp@chromium.org>, <mst@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <stefanha@redhat.com>,
	<virtio-dev@lists.linux.dev>
CC: <oren@nvidia.com>, <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v2 1/1] virtio-blk: Add description for blk_size field
Date: Sun, 6 Oct 2024 19:56:09 +0300
Message-ID: <20241006165609.34953-1-mgurtovoy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|CH2PR12MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f58d66e-c03f-4358-2d49-08dce627cc4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TyCf697RhlpVKK8XlqH71ZWCRs1DaWssX0lMG18O4GmwPHOkrdfw+ljEqi5d?=
 =?us-ascii?Q?JY9v5WDlrXn3KWfKe3TJrg2bda+om2jksxfzTWt01D/1XwHNRz2Q2MJGXbfS?=
 =?us-ascii?Q?MmbP2VKgeEm5FlLLlT3Cau9O9QLpmDRMa9livQ5QXsQWx365BNWv9d6qWPmZ?=
 =?us-ascii?Q?pF1GLRFSVThjBkO3Pazv9kI7o1MMEc6uQzBvpab8PNU59itsF4Y6vUMjhOlh?=
 =?us-ascii?Q?JGSMnxZ82hgdAIgOmpkYUGkP+ffyI9wOqvA6iFutc7Ij3Z7CnpP1iUoWzrQu?=
 =?us-ascii?Q?pfbU3rcRBw3cy15tx3aunCf4DW4XenZE9LXs2BBUvUXZZ9VABbhyjwRII8Uq?=
 =?us-ascii?Q?w0m2qUcl4k//yc3CTrWQ2OU24NVIQfl8XLtkjwJF5oZSInGbu6K7ULTY70V4?=
 =?us-ascii?Q?eqtlxSFCJSC8r4wyc1w6ubJpVqnqJQkwSg2ZMnPvoC5pa3iG1ja5vyjRikff?=
 =?us-ascii?Q?I4kp1LAj9w+EdTtTDUMEBmOmVtHu/hPjmGIEjYoDSNVzPQT3J+aUV5k82gMy?=
 =?us-ascii?Q?n55tgT94lF1t2liTbNiRXoFb3x1y1CGKCG5SoP1utyoUInK81d7LX3F0kkzw?=
 =?us-ascii?Q?/RPcKl/19JzatYhwPU4fHEmc75c+RKxq0ffPT/lnIQ3Yno1QPnZjj8RJxMuc?=
 =?us-ascii?Q?QbpP1WDJwFs0gHTxF9U+cs9kLnXy4AR1JMrGlX1PE8y8p07yrx3KrLvLRKfG?=
 =?us-ascii?Q?8wdkMDIGaOSkbe9iqMaRxW6JA/J9LaOPK9tZsTE2FF3xBxw5X8wUzCPxaayo?=
 =?us-ascii?Q?jameAxazM5SQCmRmFeu49Utmjhvlkb5VYV4Fa8OSeO7YUBSbQjblNZfHKnjh?=
 =?us-ascii?Q?oFSwAu7cmmkB7IbzPOH6mmfOu9MYZ9PDYX2A0CwuIg/CKDfWiVbSMSTFi5cW?=
 =?us-ascii?Q?stzb9wOh/YyUUqpFN8ZGTKnrEjNWxpqmbF8HCpPcotCKlYVCiltps35B8X7z?=
 =?us-ascii?Q?n83pm96ZAwyQJ/X52V58scVSOME+sfu8rME/61IPhVtYAFcx5tSHdZjtXudO?=
 =?us-ascii?Q?LJqQjanbZAgSVNCVWEjtbpWYpJtZVeHvhGPW7zu7c8L1UmnI3cMJrSgzmlfI?=
 =?us-ascii?Q?sfwa7iIClbu5KttTF9RDYyTZwDDhremBqmcGkmIY0sfcTKNK+8M2CZ/8CT/Q?=
 =?us-ascii?Q?ozx7Bge8J6YBNbHwFBh1uBAHscSd9CWxQQy0l0VEXzB1gfh9sMlZdzhmO5eK?=
 =?us-ascii?Q?9sb8xG0EaIoFpAeQ5YUecF80Ap508ebBZ47B3chfbpmXyZNtzG6nEo7k2wbk?=
 =?us-ascii?Q?BEwripkHyJsW3q25WlFXrUmAkrmJBQf/aCA+BvIvgUguBXkzuB6b9IvIjg9E?=
 =?us-ascii?Q?kqna9HlzQdiYlhwjhDz9bebpOnVv1nuG6GjJEvTPU1o+8omdSivjWPbSUBKc?=
 =?us-ascii?Q?JOOW/VZnV3wC9KS8OwzKpZNi04Hp?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 16:56:18.4397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f58d66e-c03f-4358-2d49-08dce627cc4d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213

This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
offered by the device.

The blk_size field actually represents the logical block size of the
device. It is always a power of two and typically ranges from 512 bytes
to larger values such as 4 KB.

Add description for this field to provide clarity on its constraints.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---

changes from V1:
 - Addressed Stefan's and Daniel's comments:
       1. use SHOULD instead of MUST
       2. Add a note that devices may return IOERR upon misaligned IO
 - Add a note that devices may return IOERR if IO size is not following
   the block size granularity.
---
 device-types/blk/description.tex | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
index 2712ada..77eed80 100644
--- a/device-types/blk/description.tex
+++ b/device-types/blk/description.tex
@@ -135,6 +135,9 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
 present. The availability of the others all depend on various feature
 bits as indicated above.
 
+The field \field{blk_size} exists only if VIRTIO_BLK_F_BLK_SIZE is offered by the device.
+This field reports the block size of the device, expressed in bytes.
+
 The field \field{num_queues} only exists if VIRTIO_BLK_F_MQ is set. This field specifies
 the number of queues.
 
@@ -282,6 +285,13 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 
 \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
 
+Drivers SHOULD negotiate VIRTIO_BLK_F_BLK_SIZE if the feature is offered by the
+device. When negotiated, drivers SHOULD interpret the \field{blk_size} as the
+logical block size.
+
+If the VIRTIO_BLK_F_BLK_SIZE feature is not offered by the device, then drivers
+MAY assume that the logical block size is 512 bytes.
+
 Drivers SHOULD NOT negotiate VIRTIO_BLK_F_FLUSH if they are incapable of
 sending VIRTIO_BLK_T_FLUSH commands.
 
@@ -319,6 +329,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 
 \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
 
+Devices SHOULD always offer VIRTIO_BLK_F_BLK_SIZE feature. When this feature is
+offered, devices MUST initialize \field{blk_size} to a power of two greater
+than or equal to 512.
+
 Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
 if they offer VIRTIO_BLK_F_CONFIG_WCE.
 
@@ -879,6 +893,14 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN
 and VIRTIO_BLK_T_OUT requests.
 
+The length of \field{data} SHOULD be a multiple of \field{blk_size} for VIRTIO_BLK_T_IN
+and VIRTIO_BLK_T_OUT requests, when the VIRTIO_BLK_F_BLK_SIZE feature has been
+offered by the device.
+
+The value of \field{sector} (multiplied by 512) SHOULD be aligned with
+\field{blk_size} for VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests, when the
+VIRTIO_BLK_F_BLK_SIZE feature has been offered by the device.
+
 The length of \field{data} MUST be a multiple of the size of struct
 virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD,
 VIRTIO_BLK_T_SECURE_ERASE and VIRTIO_BLK_T_WRITE_ZEROES requests.
@@ -966,6 +988,18 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 for a write request if the VIRTIO_BLK_F_RO feature if offered, and MUST NOT
 write any data.
 
+A device MAY set the \field{status} to VIRTIO_BLK_S_IOERR for
+VIRTIO_BLK_T_IN or VIRTIO_BLK_T_OUT requests if the requested
+\field{sector} (multiplied by 512) is not aligned with the device's
+\field{blk_size}, when the VIRTIO_BLK_F_BLK_SIZE feature has been offered by
+the device.
+
+A device MAY set the \field{status} to VIRTIO_BLK_S_IOERR for
+VIRTIO_BLK_T_IN or VIRTIO_BLK_T_OUT requests if the length of the
+requested \field{data} is not an integer multiple of the device's
+\field{blk_size}, when the VIRTIO_BLK_F_BLK_SIZE feature has been offered by
+the device.
+
 The device MUST set the \field{status} byte to VIRTIO_BLK_S_UNSUPP for
 discard, secure erase and write zeroes commands if any unknown flag is set.
 Furthermore, the device MUST set the \field{status} byte to
-- 
2.18.1

