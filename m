Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C029B1DFE24
	for <virtio-dev@lists.linux.dev>; Thu,  7 Nov 2024 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976679; cv=fail; b=cvWY605sUI8EKgzQzdkuGgnn60VAlKuDhecQ4a4KyRiLDZU1vLwrJDowk/MLUnEgDrBWAM1fmTKy4siPeGDNej1D//46nY44c0fifNNb0sayJ/LslXcNl2L6HtdEJvqUVlNjfhMnw5iwEgUAXxXjp2o2onTulqLEB94xZ1ID0LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976679; c=relaxed/simple;
	bh=pMkwXEPLCwf5KphA+q3ojGPVOrIiaY9y4Iu18bVfFj0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iR+Vo73iyoV3ak55n67Z1J7fh8/wPMQaXYnTNbnji15uf1k6YYcMU1tCzJBhEOoI+qzkjU6ZY4+odgxHNPxTRaB8XPQ1rKlqrguPmhCLEXo6PNa2PfIwLClem1mIhUvMg+Jk1M9BKlpNk+uBzRxSWazD/8a6u/IchxCkEifUHLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G95JL78t; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G95JL78t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxIlGFQGjSMlUyrajubLjTmLJdQteEX9h8hxR92/qI0ZShdNv1+HSkJxwviG9SxjfZsa9XSu96FMB4janoxiuZnYSiW+ots7oc3JAE7wBAK4xnjf+zX/KO6XW8MPGopFDg7GJ3C2YNh3pZkUn0bFcA5MSZIZKCU3LOgkPMh+O5l5Aq19bfedzfq48IYE7jE20C4do1KSj2AorkSjRKi5zhZ7xUF7f5YND2KHYBvFSLop5JOH/BIBVWEUVGvZO5aEE6R2pg+qVU2EmLNpu+U1aw5R/VjErByDFdOL3nE757x7kVuptQc3LzPrcXEKnJ4mdkxcfzRYHkIItFnHLO2uKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0jK5jiKMPvDKWm2KSJCplThClMbyvt6feKcJU3CQKQ=;
 b=ag5Ya+65uDa3aRg1wnb0FmXDOn1BMFNG2YO0GdnrK5vVLJX2haA4zld1Fftli5j2FH1sZgcRHKnJGMX6yh6xId0vSzx76BniFNestLSulGtec5+G2Ibv4FARzircOC5J+AMQmp0hyefD6PtdREHrD178ZEeFsJ7gHAFqwoeJoMw5/3Eyb67KUNca09LySEv0h4cNmE0rOzsk6PgWJBqmsS4Eu9z7gUQYKKRtEA5TRgKKxY/eKuemab0Raee2EQrfhR1E70DMe1BmZU9trmUkK6MtebwwARdaoo1co/6V62BCiSnfYfYUhCmIge4800taul97E953IC+PkpMCdFWnfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=chromium.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0jK5jiKMPvDKWm2KSJCplThClMbyvt6feKcJU3CQKQ=;
 b=G95JL78tNjABUwT1emNQAwCmAD1n2WwuVC/CIW/FTyqMa5CseM1GdiPxwx155rhl53yOEnMxQcTfQ/zBxJCOWJWLI2IrOFlECIShZUxRv3QdbZMJKFF36ccn7hYZApnI+cKx/20M5TfmytJZs0kgbpmY6E3M6t9l6Ew5cGv20V9hsMKKm2FIa7KzL7UmRm0V3TFEbhRKPYqIorkaKPncGLenWM5L4/BWiTz1nEJvjZguGDvFt667im0nF7k5raqxjB/AfbAc4213BFLTgAkjWo40vl2i50HmL6r1ox7cP6XJHrICZR54Bu6LH12y0mbIkbNfBJn9u0x1/qwVilhxjA==
Received: from BN9PR03CA0988.namprd03.prod.outlook.com (2603:10b6:408:109::33)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 10:51:14 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:109:cafe::ef) by BN9PR03CA0988.outlook.office365.com
 (2603:10b6:408:109::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 10:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 10:51:14 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 02:51:06 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 02:51:06 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 02:51:03 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <dverkamp@chromium.org>, <mst@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <mvaralar@redhat.com>,
	<stefanha@redhat.com>, <virtio-dev@lists.linux.dev>
CC: <oren@nvidia.com>, <parav@nvidia.com>, <nitzanc@nvidia.com>,
	<benwalker@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v6 1/1] virtio-blk: Add description for blk_size field
Date: Thu, 7 Nov 2024 12:51:03 +0200
Message-ID: <20241107105103.19152-1-mgurtovoy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f6fb686-8ce6-4986-3559-08dcff1a19b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vu1RuLazkE2IcDvC3216n65z4DmlZjbYFk/ZwovDkpWYvaAscOhYYMJLyLVP?=
 =?us-ascii?Q?98wyyeAzdjnGQZSYsQ5mO4qkKTrKN/5rwtc20VKr/SRg8FQ9PLjc0S8LgzD5?=
 =?us-ascii?Q?F3cqIjK36GfEeni+FjmsBiCaPovRtYaAHlwuBZlRe/eZmKFBc/5vjm8hZdKJ?=
 =?us-ascii?Q?OVGPC4nVTCtzBDLbT9krNA6kM/R/6skIf8fFNxBiCiNIyY4kCrfrawTXXJ3c?=
 =?us-ascii?Q?P16W7g66qGV/Dha2PK9W65d7NsMCFYDFuVHyRuV9qlGUOZB0tPnAxYmBdrzg?=
 =?us-ascii?Q?ck99IAjDlQYWCga0/5N/DF1HXhSMyGN6ocRbj/Q1H1n16bwpIsjaZgwIkUQh?=
 =?us-ascii?Q?YJ2V3DggZYFLkarVPfFmFfh0zwv+labZA9Ehy4dZ2N6vo2aygaq135BeMJR3?=
 =?us-ascii?Q?u2DGeq+pt+2cBXXWMuDgHSpQce+4b1pm87y8FVsLxHR2BnILi8C+oXHMp4z6?=
 =?us-ascii?Q?qB/wEDbNPRyw4MPI/EwZHiJ11GeQ1ZNWZExastm470Pkw3/I0DKQhR1jDHtt?=
 =?us-ascii?Q?TkBrI/jssF8dl9wrN2gOYakwKy0JhRBT+TdCwlalS4RmNrEQk4lg7+QGZhbw?=
 =?us-ascii?Q?U7qunly1dHmmH3NAM365hDiA/Tznxm27Yarhsy0L7YfL69NtZahn9ostvo4b?=
 =?us-ascii?Q?hpKcLhwZs2BI/6DgqwSoWIqUd8WLBPjetQcH0A5ni5+HBvjHnk5bBVhLZiAn?=
 =?us-ascii?Q?ouRXjcyKWEb4T1knd/BYtg0Fi7B96g9y9qBFPqnxdVNNDGIQ6UmBrIys5vuF?=
 =?us-ascii?Q?VctjeZok+jTD0BmeqbCqNaj2Eb5HChasc4C/zndTzTr8kH2ViY2IEZldXU2S?=
 =?us-ascii?Q?kYo7YbdAqc7RFtPFoL0yw4hPvpJ1kZvuz/3LISDiB4kcky8FYbhUNhZvRNMw?=
 =?us-ascii?Q?3gfjMpQxdGUlfXP583WtghvVpPkHWiFSt9cexOCBixnJIvZ/9DubQHaASR9y?=
 =?us-ascii?Q?411K9vPJCIZKXFzS9o2pxCpxMRESdpZ35nNJ2xl/c1X6okiVTkagbo644Cy1?=
 =?us-ascii?Q?+C5rZ9Q7DvwQKtQ+2G58ANAigNCDupnONDGDLHa0o6GagX6iiXAh7GCN8Cb8?=
 =?us-ascii?Q?+EG7+eeLwVSJNSl+MKeH7TsnnPzHK1+CvM/fPlatnQT95TNzFqROzkyFkm98?=
 =?us-ascii?Q?mu90+yH7a8HXZNV0qOfPhIqeUG+4Wikpg0/Ra1s19ipXAxaO2Y9Ez25PIqQd?=
 =?us-ascii?Q?AT1XUKh/VlLfhlhWIozkUGLh3Wuu+dYuo43rF14ea6lZ3l8hR62BySXmNeCb?=
 =?us-ascii?Q?u63bU6Nll+5DpAE/1Tmw3KndcbY6XGVLVv5rkzs6G93JEotQ+RpbzDNHX4SM?=
 =?us-ascii?Q?QJOo3H6ojYuKbFrp6p5diAKsKu68l4PKPRUrJU5tzClpMpo+kJJbLi6ER+YN?=
 =?us-ascii?Q?k4QVoa/kTmnrQQWBw//ORbYPqkiA7mYpw6bf60UK+GIpwYiF3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 10:51:14.2947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6fb686-8ce6-4986-3559-08dcff1a19b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519

This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
offered by the device.

The blk_size field actually represents the logical block size of the
device. It is always a power of two and typically ranges from 512 bytes
to larger values such as 4 KB.

Add description for this field to provide clarity on its constraints.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/208
Reviewed-by: Daniel Verkamp <dverkamp@chromium.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---

changes from v5:
 - plural vs. non-plural fixes (Parav)

changes from v4:
 - reorder paragraphs (MST, Matias)
---
 device-types/blk/description.tex | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
index 2712ada..47713ab 100644
--- a/device-types/blk/description.tex
+++ b/device-types/blk/description.tex
@@ -135,6 +135,10 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
 present. The availability of the others all depend on various feature
 bits as indicated above.
 
+The field \field{blk_size} reports the block size of the device, expressed in
+bytes. This field exists only if VIRTIO_BLK_F_BLK_SIZE is offered by the
+device.
+
 The field \field{num_queues} only exists if VIRTIO_BLK_F_MQ is set. This field specifies
 the number of queues.
 
@@ -282,6 +286,13 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 
 \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
 
+The driver SHOULD negotiate VIRTIO_BLK_F_BLK_SIZE if the feature is offered by
+the device. When negotiated, the driver SHOULD interpret the \field{blk_size}
+as the logical block size.
+
+If the VIRTIO_BLK_F_BLK_SIZE feature is not offered by the device, then the
+driver MAY assume that the logical block size is 512 bytes.
+
 Drivers SHOULD NOT negotiate VIRTIO_BLK_F_FLUSH if they are incapable of
 sending VIRTIO_BLK_T_FLUSH commands.
 
@@ -319,6 +330,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 
 \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
 
+The device SHOULD offer VIRTIO_BLK_F_BLK_SIZE. When this feature is offered,
+the device MUST initialize \field{blk_size} to a power of two greater than or
+equal to 512.
+
 Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
 if they offer VIRTIO_BLK_F_CONFIG_WCE.
 
@@ -879,6 +894,14 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN
 and VIRTIO_BLK_T_OUT requests.
 
+When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, the length of
+\field{data} SHOULD be a multiple of \field{blk_size} for VIRTIO_BLK_T_IN and
+VIRTIO_BLK_T_OUT requests.
+
+When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, the value of
+\field{sector} (multiplied by 512) SHOULD be a multiple of \field{blk_size} for
+VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests.
+
 The length of \field{data} MUST be a multiple of the size of struct
 virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD,
 VIRTIO_BLK_T_SECURE_ERASE and VIRTIO_BLK_T_WRITE_ZEROES requests.
@@ -966,6 +989,16 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 for a write request if the VIRTIO_BLK_F_RO feature if offered, and MUST NOT
 write any data.
 
+When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, and the
+requested \field{sector} (multiplied by 512) is not an integer multiple of the
+device's \field{blk_size}, the device MAY set the \field{status} to
+VIRTIO_BLK_S_IOERR for both VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests.
+
+When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, and the
+length of the requested \field{data} is not an integer multiple of the device's
+\field{blk_size}, the device MAY set the \field{status} to VIRTIO_BLK_S_IOERR
+for both VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests.
+
 The device MUST set the \field{status} byte to VIRTIO_BLK_S_UNSUPP for
 discard, secure erase and write zeroes commands if any unknown flag is set.
 Furthermore, the device MUST set the \field{status} byte to
-- 
2.18.1

