Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA3A1CEAAC
	for <virtio-dev@lists.linux.dev>; Tue, 22 Oct 2024 23:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729639500; cv=fail; b=WkSV2fUNEiLevHwbXfTmk8hvhejyBNQ4sOg0yKgmmBAxznr/bCifWnb1XxXZRlhQ6QSUDikapimSYT132vq/yEoNeHURyYlDpNhsjaslJEOoW5pY8ZgAXmnlL46Z/vRWGtTb0LzTptXW+fxgOVYc3RE/IY0p2Pi7qYNns83CERk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729639500; c=relaxed/simple;
	bh=Vyxr+ozBFR2E6byX1cmL7fqrMxxZqVqistPQd0lsqx4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HB6zsXZL+mW6pYuoWokFf0MXQ+cBbFF0DJJRad4s4wnhIl2yua3B3kG4MXcJBF/TB+aLQdLpw004YjdCymVXWbUG4fbuKFFCHcYNWCR/jnitcM4HZA3/SuaKusd9fFghQn6PxDdybAXcLxGlRVoGu/KfP21q9DANNCmF2T0xg+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LovNS+QA; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LovNS+QA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K16I8Pp6CV5hADT89t3PeOsOejzneCD8EIJJpM9lqIG8i6zXYlplN9gitVZt9HfNy7vjTrldJmNNP4+3hUN8dZGJWx53Bwtq2icWyTSvZ36nyWdaDJOWl9ZGRWzshCRh/o/71xsi25CSOY4Xwb6ELoYmT0xK2QZYfpKBQN0C+CboMATmru4k1wOnxer8QjtLPGNhhb3mzAamzF9/q4FEBoQa0EuPmaLsoi4oIH/z9je6mkKStbV+4iDeoSLcWD+uloNaCLCMPpBjyk7F7MEphsY08dlb+zWqeli3seQuKvqbNQLlYO/ypUDYihsSeU318y2Oor/AWLTU5nY7zMC0yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qg+Tyj8zCsGosB9XtNtFFosSgFl/3CxIxCROWNcjygg=;
 b=JvY5zOolBPbR2ZqNgAvstg9Soig9eUL0PeOyvg4Grzy2EcSF1AIq9dU6GTC62jF3+9oTH1q2TWbvDXSMo6T2cGkVKU/Qbciq7u0WafXuSGK2WfGOJ+e2Magq/TgartjN9kwAE5JmrdNn4gWbGb77TShhsNvISq36gFabfmxu3EpVbQXPBCTWj3XQi97hXwf6lVd7PmdP89eDShx+7MWkpZtOOKltmCC+LXgoU7dlQsBwr0tmQL0STt9MmfNfnhQUbuZkE7bfQ+3PduyTiPWGiulk7/DGe5ZTgHHcDcB+lo0kcTC8kX+X25fd/Qh9JDP7IKDrgukwgI0RjD5uR7L81A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=chromium.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg+Tyj8zCsGosB9XtNtFFosSgFl/3CxIxCROWNcjygg=;
 b=LovNS+QAjJz2XBP9aV68s7gKavQuDq/K/G8UPp+c/kL0APrBzEbohrJc1u4FafO+CURXHo1DdU7jwpQ7l80L38mZXW2VuqK16nxH7EMMsnHxI8uX85k0D+S79n3JwbsfY522iUT9jAVlq14axGid/pBHnbGCMSVPmrJIGTNsWzsToLPcwmzWY8p6DnGKaJ6uDdum/M/ynGEsB7foAWxuM+n2hIolSZ1rCDsQneyOacsZYdcNBy5jUVFU6dLBmA0y8DJIRD0Ddg38i1E3A5Wj8rnvHt2BEzR4U/71TPwqklkPXWpvGwnNQEBMVg1fzxVKilV5p1HwkzkA95mYWrWJ5g==
Received: from BYAPR05CA0103.namprd05.prod.outlook.com (2603:10b6:a03:e0::44)
 by SA1PR12MB6847.namprd12.prod.outlook.com (2603:10b6:806:25e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 23:24:53 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::db) by BYAPR05CA0103.outlook.office365.com
 (2603:10b6:a03:e0::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Tue, 22 Oct 2024 23:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 23:24:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Oct
 2024 16:24:39 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 22 Oct 2024 16:24:38 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 22 Oct 2024 16:24:36 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <dverkamp@chromium.org>, <mst@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <mvaralar@redhat.com>,
	<stefanha@redhat.com>, <virtio-dev@lists.linux.dev>
CC: <oren@nvidia.com>, <parav@nvidia.com>, <nitzanc@nvidia.com>,
	<benwalker@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v5 1/1] virtio-blk: Add description for blk_size field
Date: Wed, 23 Oct 2024 02:24:35 +0300
Message-ID: <20241022232435.20799-1-mgurtovoy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|SA1PR12MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6a2646-b26d-460e-e312-08dcf2f0bb19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i4MKHiabi38Nn3UW7DwYDaRbfP3TX1QLv6/2ujxG4QHEoN5zni9NS+fEi2bH?=
 =?us-ascii?Q?ifMeoX9aM71STzN8X+/rNu3pcyjwIuH23ZLxf/M4mHyVYiwSSQV9lPVsMx6o?=
 =?us-ascii?Q?oHyvlFKMt9poJmfOBn+yTBscGRrpY6y3iy4FWO5sZWUSJnfOwPNNhcG2YwBW?=
 =?us-ascii?Q?z4A0xjXvj98lUOUc1YU+tPIV/C6DJCTf109XsUUUTm7CrlCXkYXgC8/3hISD?=
 =?us-ascii?Q?N7cyw0Y/dQkuQO6dtNlunqlSICzSeGiejJKIdac1HPq9ETKYttCmzV6PvGNT?=
 =?us-ascii?Q?oXybh+lY5WnnmHUyfwCEqjSZA7e4B2QBzjk7nB1QmAtFgO8heFVIDQ9hf7mV?=
 =?us-ascii?Q?7427GWeB37Bci0ukPGZrjB06+KKEaxIqzhKdAezM2H7l2G2zsiGr1N0vX8g/?=
 =?us-ascii?Q?+eWB9XxLHZx83xAePiQe7+VB0yOhC1ruev8dSKMFeEp1Q+OFB93kLuk10OUo?=
 =?us-ascii?Q?3f+MDDNZHsIsdBygdc5pOSMb1gIlZT/ZIUSj7jf1hU+4vU+qw7sqxkX74P80?=
 =?us-ascii?Q?IcFShRZShd+97UNFE0uKhvA0WYr2ZUBas2eZXjO0TfIIDlTE0vrk+2aqpT/w?=
 =?us-ascii?Q?TaBdBpxGF1asIlX6c/zGFpGBWG0/jMaXnS5cMglRj0XPEKmO8sTbD/WmzL/1?=
 =?us-ascii?Q?GjS14O7ayEfbfx3BdeiOfgrgHf6xAxuReH4cixeKDJq9zuTAvBLf+AgNASym?=
 =?us-ascii?Q?Q4tDdfGbREDWYBtNjn6oHkdSjbmfpBTgk2g7k7R3AR+hM7uHFc1C9wPv8FSD?=
 =?us-ascii?Q?RhTCkUKtcJuoHAQCqj+0VRh94althe+65Uk4RcZDESaB/j2t1BderYmP7w6s?=
 =?us-ascii?Q?s4Ndw/NPHQyaoMHAezhdUmNaXm2cJ58+hoJPd/3ZSyEW4idaDo7pkUMdnpT8?=
 =?us-ascii?Q?/AUrBbyGByJFIMQCPsQwHoSBkggJ/6blaMW/Wr1VH5MPYjybt56XcoB+ePKf?=
 =?us-ascii?Q?SFhMKU3mNZ0tKtm5lY59Uu0b2AA6x1dZmTmzsqfj8VTRZKS/5J5oV1YbZoWd?=
 =?us-ascii?Q?RFvwA+EwsFtZhuD9KhPBxQWHJd5R8bciqRp8C8pI/EURe0z3Qbkwh5FJyKUD?=
 =?us-ascii?Q?bEL+tOCo5ZdR7ozRd7VcjcCaK8DFcck4dBhDD6D1cGix/fx44vKFeh28P+UR?=
 =?us-ascii?Q?9rvGU7uDxew2biW2QXd59Hro3TXn37ayGLbjRGLUHbdwnXQjd9VndZReCeeT?=
 =?us-ascii?Q?W8CzGJjggjxkxMbEBQbrj1yFYXYFIKdFHRDWtfugtlvnuSdOQCYAIa40hpiX?=
 =?us-ascii?Q?GO48LpE/tnuF6yRxzI4OQ28F80nbciUn8v+J6NYsHALlGgkRMnJdlVoVQzHp?=
 =?us-ascii?Q?95Az8HiJfLJC7rEDCzqSfb9f3QjSuIBK/Y8d9TlVRobK1a2i1Voio5lCFMI9?=
 =?us-ascii?Q?H173sYpVz9gEU7cWe5wN7rpYMOt+RU128V1skzgvFYo9wy8Y5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 23:24:52.4095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6a2646-b26d-460e-e312-08dcf2f0bb19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6847

This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
offered by the device.

The blk_size field actually represents the logical block size of the
device. It is always a power of two and typically ranges from 512 bytes
to larger values such as 4 KB.

Add description for this field to provide clarity on its constraints.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/208
Reviewed-by: Daniel Verkamp <dverkamp@chromium.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---

changes from v4:
 - reorder paragraphs (MST, Matias)

---
 device-types/blk/description.tex | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
index 2712ada..093a139 100644
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
 
+Drivers SHOULD negotiate VIRTIO_BLK_F_BLK_SIZE if the feature is offered by the
+device. When negotiated, drivers SHOULD interpret the \field{blk_size} as the
+logical block size.
+
+If the VIRTIO_BLK_F_BLK_SIZE feature is not offered by the device, then drivers
+MAY assume that the logical block size is 512 bytes.
+
 Drivers SHOULD NOT negotiate VIRTIO_BLK_F_FLUSH if they are incapable of
 sending VIRTIO_BLK_T_FLUSH commands.
 
@@ -319,6 +330,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 
 \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
 
+Devices SHOULD offer VIRTIO_BLK_F_BLK_SIZE. When this feature is offered,
+devices MUST initialize \field{blk_size} to a power of two greater than or
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

