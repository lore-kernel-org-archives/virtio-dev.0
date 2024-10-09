Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E4B1E0485
	for <virtio-dev@lists.linux.dev>; Wed,  9 Oct 2024 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489938; cv=fail; b=ApTMU9Rjvg4AlD1UlF5h9+aVBQA4//GYEPo/G8jKQmIgU59O49hvEBADlDJRBm7BxNmgq1vloIA9dDUxM0UhPmIiQJBGK7Zk7uJH29KzdEd+WHWRT2oh0QaY3UUekBL8xYMyFMxURZGFedv2ID92oTg2uRletqWMYXjtTom08aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489938; c=relaxed/simple;
	bh=G+KWMlzfwjjPM3a2WLVRj69PBxTbtR/i3U315v+QcM4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BKyIAOVMh77ZFCzNIDbxlU6TEh2fr9Pcp5MkZDsX/k5g5cA9oXL5JnNXlfcTtoimnz6pg4CxyoS2pnntlQrmbhYYh5XqOoKIfYOZnY4UbE6TtDQpbYFFz4vYauXJRI3JUhLEtKjAMouc5sZyor4yl0nOuHbEtxlCkyWnrmwg/Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r5UGfNut; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r5UGfNut"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDYiz2TqdubmfuIVG7ZEzhYOCjRsiWI09SCOoRkHJbc1iDX5LRDZYM5yuTxGG/+1pkH1py/TuDF3+0CAQYHTXZt0ycFgDvCSZdLtLN0Dqm8ZZIQYvUBZ+a4e6/d6101ryBYnuhVy4yPMUG+QYSc/V8Cbnjx9ujGJUxotG+QQgKvnN9SndnHM95d9J7t4m/yy4DZAUkPkF79AKfwSuBs+K95c4uoUi4tFydnX3jZAf4H02Z3wB3IimYz3pkyAM9SNtyzmD/J0i4lcsnUmQXfiGZFKxaWbSjxY1pt7rXZ8CIc3M5+iKQ1zslbBkNqsKEinjWs1w111gxT7L7GWJbPCYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NuVc/EEFVE/G+1wwiZSVitx47SpFilYds5NqetmRio=;
 b=FJQTu7wgBOUcDVMyZCkqJKVuDRVzuUEeHlDMsRoVmeF07C80XrUKB1Yv/Gt8N149gCxJOsXxm/zN8SPFR9BQqQhyZnvNtKk1hdp2M8L3ndzHULltaj2R8PsUT+I3Qmw4K7pFH9wcI6EVKlcK+STveLdTTfEL2M0JiqbnjQrbuEM2uW2HQ+0I2IgyPVARQTMkg+FMhnLi/V+AfApk8aEmZkuZ1mBrONifzCs/nKs93jk+CN+YKyT9mk0jgapBjPYLE3Zcb6DuqBkws5tx+1crQQpF0BT3jk4ibmHUyBzGpEGvZ8loiUNA2t4Y4mglCpViIBFEoLrNfLwevngQhBmZiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=chromium.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NuVc/EEFVE/G+1wwiZSVitx47SpFilYds5NqetmRio=;
 b=r5UGfNutsLmdUa7HhTGnedy1VLwCnB/u+6r6xRlEvuYKMpVTZzSuWRLVsAUA+h8vL177E25yAUeBoZgIQKQV5GrfwQfpZAmAjEF8dI2Ws/Pdo11/PZDsaom+ZGQ3syhboRKo5XWgVSoxo6jBF26Tn5NOcXb4qcIGULaKq9zamTRPHKsbuEGtk0J0IuwQlG0Sc2VRh0mQPI0+7d4l2zGpydzUUx8pH82gjWB64SUXTS7fYWID85YwgGqAG2dOSut1HtGBe+E72dJl1kP+ypx/934dYTWXQJcecaW6rg2S7lpaAQcEXdVl1ZE8yCdkHJ4v14TOFG3xvpuoaXXy5hCyBA==
Received: from DS7PR03CA0262.namprd03.prod.outlook.com (2603:10b6:5:3b3::27)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 16:05:31 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::f8) by DS7PR03CA0262.outlook.office365.com
 (2603:10b6:5:3b3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 16:05:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:05:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:05:16 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:05:15 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:05:13 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <dverkamp@chromium.org>, <mst@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <stefanha@redhat.com>,
	<virtio-dev@lists.linux.dev>
CC: <oren@nvidia.com>, <parav@nvidia.com>, <nitzanc@nvidia.com>,
	<benwalker@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v3 1/1] virtio-blk: Add description for blk_size field
Date: Wed, 9 Oct 2024 19:05:12 +0300
Message-ID: <20241009160512.8390-1-mgurtovoy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f6c765-1b14-4cfa-47c9-08dce87c32fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fu4ZKk5ATOpmZKrSvWMTreKko53O7wSk/FLkViS6bMx+QFtAw5dRiUGQQ+4f?=
 =?us-ascii?Q?tPWimexVK42Fxr+TkEBkuht3U0J8PmBI7Lrrj25Hjeb73ON8ExdddI++eO7P?=
 =?us-ascii?Q?4dZJZVW8iWuMjq/V4qu480x8oODwRBJze4sWl4qFzIMIL+dyPnsyDY1aOHq1?=
 =?us-ascii?Q?sBgHj+Vxk5z2HuH3JSJbmO7ZbNZyqMCty2Qt4ZzbwkfRptUQyzetT5TnBx9T?=
 =?us-ascii?Q?DePtdx84FI6d/GKD7fTalr9HKpehvNkEfIMlM8uzJp/njbdYEYDfKhT0FmP8?=
 =?us-ascii?Q?9xEkZbFxwI5HCn0AUec6LBSq0mtimFQ4csAuS/+T5KDfFMjueNVJIhuvK2UK?=
 =?us-ascii?Q?k69DxMvI7Fs2JGnCKXMdArtYoLe3dwzMXHDAsQjzcw7CpfqwZygiMu5JkSDn?=
 =?us-ascii?Q?SYuit3uJGRPi2Sp2ZoKp4LSTj7nBpM32F/CAO6+Myh7jRs7j5w8U3yb+n4Ll?=
 =?us-ascii?Q?ZMkrvpec5nmBmZGJorq1F0kly6wwU8qLAKy73mG7n3lNNjC4MqlZzgD2WvsR?=
 =?us-ascii?Q?2cWrn3ahFRoceomK0/uGKPCsWiza7sZeF6YjIfGQsRKkMOSA5NP/ed7qngnE?=
 =?us-ascii?Q?hjHvAiXhn+ACklMe7/sJ9a+VAoKv8VEuo4V8K5SSGmuzt/YvZnu9SMIIO1Sa?=
 =?us-ascii?Q?3Q19nmaxXKLV24J45/0zIWRiBwkQe7ivA3pJ6ZghJwX47XvCVGGMxDRjDa/S?=
 =?us-ascii?Q?6FWy9620bkbICmQbO5Jl6Ua9nXGRescf2IdJ07BNW1C+zscZCfAAi5PYbSDu?=
 =?us-ascii?Q?Lwobt9rmuNd1Yml/z+oxp7bYjfZ/FvgmmiksdOfIkdN5aAqpesfLwja/Mli+?=
 =?us-ascii?Q?NgxaBjTrJ92V3bPamfwHEx8ZNaUjse1KjRXpHgBBsb3oCEP5tiwGy9dO/AcT?=
 =?us-ascii?Q?znANCwCaqNmNJaMm64FOjMi7y/7thjTTIjPxqSnGT3oWNkseRYFjjZBmzf48?=
 =?us-ascii?Q?CpWaASoU17ptuBe29aJRoG6i6eGzUwOtlk0IeVpx6u3C4F+IfcDvFTP6rfVL?=
 =?us-ascii?Q?3i38DgHXv2alOYa9EH+B1dvvc45b5f7lzwl0dXjb5ZYWYSkHcET60/NWAFAQ?=
 =?us-ascii?Q?ZjbewETQnU0KedtLvDGxfxjZniCNTLN35GW5Am1SxMTP1em3+uOiQG6KMeV/?=
 =?us-ascii?Q?nUfvdyRPG+1Gw7CaH0ppvjXnGtWUxnZ8MFLrXX5kNRNkMHwzjvlC4G3hic6A?=
 =?us-ascii?Q?ITEsqImu9ANju4k7Mw8YivSJq3vRr3eE2ML+G58iM9lM2EjeJfniaq7o8fcg?=
 =?us-ascii?Q?V/Xiwz1OX0ScNa/IFrQTE8ETLXS9RG3gF/dgFvYxFz4clm/Cj/hiw0lALKl1?=
 =?us-ascii?Q?KLjn01qX3CukaOYdJRIxZCINxTA5HmN+ddNo+Acs56A7f9KZL//IwHz61b2l?=
 =?us-ascii?Q?DAob80aac0+bshaPhNt+Vcvi1tL6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:05:30.7410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f6c765-1b14-4cfa-47c9-08dce87c32fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
offered by the device.

The blk_size field actually represents the logical block size of the
device. It is always a power of two and typically ranges from 512 bytes
to larger values such as 4 KB.

Add description for this field to provide clarity on its constraints.

Reviewed-by: Daniel Verkamp <dverkamp@chromium.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 device-types/blk/description.tex | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
index 2712ada..caa5d13 100644
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
+The value of \field{sector} (multiplied by 512) SHOULD be a multiple of
+\field{blk_size} for VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests, when the
+VIRTIO_BLK_F_BLK_SIZE feature has offered by the device.
+
 The length of \field{data} MUST be a multiple of the size of struct
 virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD,
 VIRTIO_BLK_T_SECURE_ERASE and VIRTIO_BLK_T_WRITE_ZEROES requests.
@@ -966,6 +988,18 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 for a write request if the VIRTIO_BLK_F_RO feature if offered, and MUST NOT
 write any data.
 
+A device MAY set the \field{status} to VIRTIO_BLK_S_IOERR for
+VIRTIO_BLK_T_IN or VIRTIO_BLK_T_OUT requests if the requested
+\field{sector} (multiplied by 512) is not an integer multiple of the device's
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

