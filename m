Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0061CDFD3
	for <virtio-dev@lists.linux.dev>; Thu, 10 Oct 2024 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576467; cv=fail; b=P0pZzOC5Gh/9/nw+0MhrDz/0rd6ZGg2UhE18dBeU5rha1jyy5FX+D4yZsUuf+u2lkaHyjEWZ2VkoFsEYzvbXNJYT19dNCGXHAY/0ZINZxlcMZjrdpE0HhHP61EkSd9cbqFXA+vyT0MaEsUEjemtbSxJ/8BZUWEReB9xVvF/BUEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576467; c=relaxed/simple;
	bh=Z4es7VgnCEnKNakiYS+cSU6p0aiSHikWv5Qo6/KNTlc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WMW6KIe8qvHzWDJj0DT/DBssAEK32bMAfaFErzPuVjVY4hIs6AykSXEAGoLGMvbNe2R/GETSPV2+xLBjvCyQ5aX6YayvR6NKk1B34GaSWSlKOyw4smWXq2NMc3YfMCP2jQ0Q/1cOggVOC2+CJhwpgf9wsn9E77WBjyr9bHW7R/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NYmd9ZtK; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NYmd9ZtK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MT+uxxMOj6pexx6QNZgZW/wWMZ/zoXYipsDMO29czshpWxz96SLXaUdBghAoz9V49g49ToFVSyejzIEUYLDPkV8srfhBGyLL9o0l951T95ycsM8JGohg6TD001RsktoYXmZgWZ0tt2ODRfVRlUI2dOs7K3hM3sROWKmSqcYx/TzeRjjHu8DVPSOVALwg+mI5/2++qfTgY2Ppig8VkYwX1q/rbtr2iSuy0G+e7wOO37U07cTGTRfX0tUXY2CHLwKWOWQ2rvMMGUwt8ns0/u4pT61UCKyKwkbElaccr6TIzISBi/9b1i05pT9vdQ4LxyNssE60BlxBs5PoomsCdZnHsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iGMuqXiSyJYs4EKo9rAQXCE5YqQQKT1qZ+ZpThxknA=;
 b=kKnF3P9yebW7cogG2L5fHHS/KR5MV1Gjwf9o5H94dG9pBHsdH9N40sLsUsMP6F9M5PIIUJAk8kUObMp3DmgNLPdKA7q/VfJ80hHZYJfDAC+abZnauR5Q7Gm1Q5JDkcForaAYmtAzSZEnD3SWoEiszTEselz0Hk107t0m14gHhuDeVZ2tJFodcKpdSXQh720atB+JUSnNKHRV8BGYYFwrdLU5jX1KsARlXYqJaFIVBQ05u6GS6FnVLWxGV3V4s7ACKkp3k19mlvtmNEpxi+V3rIwJcpYAsqSsPlnw86NEqSAjHuXuS0Hw2kbslka+rtfiUX5kuHrrq+nNaQc40UUo0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=chromium.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iGMuqXiSyJYs4EKo9rAQXCE5YqQQKT1qZ+ZpThxknA=;
 b=NYmd9ZtKRo69H9Zd9vj/eD4U52sCZOXHDsVEzHpnK7KAqGmW/6gJMu78Y9KjaNtoIEO5lqQZhVFI1AmWDt/qaDC3SEGOwdYt/SegbMCS/Hr1sz5cnVuVjnkRF4VIIm5tl4pGGtcyWhoX5qRWiCdvhQ/Jv6ZGgE0+891g4kUw4mPJHEJ7hRsk2O8mB/KGADy8rNc2hpvuxJ4V0zdoEyUMlLEE5MgzlFxk9/s40UZ5/7rz2Eg8FYh32euGrE4fSwVvtwsrZmVb9p+6ymuVn7AnNwsO0sWpVzl3Yb4/ppp5DnWs0r7FQcp9dfPaAjgaN5iciYmK+5RXFp9v+ymnrfFnWg==
Received: from BN0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:408:e4::30)
 by IA0PR12MB8085.namprd12.prod.outlook.com (2603:10b6:208:400::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 16:07:41 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::b4) by BN0PR02CA0025.outlook.office365.com
 (2603:10b6:408:e4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.19 via Frontend
 Transport; Thu, 10 Oct 2024 16:07:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 16:07:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Oct
 2024 09:07:28 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 10 Oct 2024 09:07:28 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 10 Oct 2024 09:07:25 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <dverkamp@chromium.org>, <mst@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <mvaralar@redhat.com>,
	<stefanha@redhat.com>, <virtio-dev@lists.linux.dev>
CC: <oren@nvidia.com>, <parav@nvidia.com>, <nitzanc@nvidia.com>,
	<benwalker@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v4 1/1] virtio-blk: Add description for blk_size field
Date: Thu, 10 Oct 2024 19:07:25 +0300
Message-ID: <20241010160725.3087-1-mgurtovoy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|IA0PR12MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: fffdb24f-8b1a-42c2-d33f-08dce945ab60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f+S4B6EytR+EKkyNedH85WujqUxtkvRrMoHdJkksaiKbtUC68YLzXeOerDP9?=
 =?us-ascii?Q?d6biUAaiDj+QEmWFSKJK9GgNcdnNRbfSMTtbJdBlpk9pn8BUAKdbqIERIrmm?=
 =?us-ascii?Q?KEsISoKwTrX4kbBCV5Ulq1lhDYxOBiWGDVaPJqW0VxuO7JFmQCNfK/QHJ4JV?=
 =?us-ascii?Q?hcQEutqWDktpMaIhNVzKvzM033s6xjbqGLwRkJhGKbr2Y4GA9wW6xwHoo3W7?=
 =?us-ascii?Q?VtzQiCTbkS4jb8MmNtWAjej4UIYw0bZ3YmVlp95DtbG1qmL/X8Ux1aA3OHrQ?=
 =?us-ascii?Q?LuHLRSKBimrEOO5PxOrYiaquEAyHHdGHOO0vc6wzja1PnYiloe/zumep7zdl?=
 =?us-ascii?Q?r7SrMvuFacZ07YQCk68fl4JmNGGpapRUvS8Yn6xpPS2UpXVROOa2fStYLEho?=
 =?us-ascii?Q?ZufPDaZRXNKNyIGQugAiYPtEs78Um2DCgxBksX0F/9tUUF88Xzyif5ozYDDg?=
 =?us-ascii?Q?iFs5yl4w9c0WhMGhJcmGA0oRkFJsYYKz02ib0zzE0vxPTkDCbfQf5/giH9Q/?=
 =?us-ascii?Q?amXq55rwUJ121uWZwR7TXpD8+z1tMhmUnvNd1ZSUFfzxzG0S/uxq9Yr8rWnx?=
 =?us-ascii?Q?0mSvG8W7fgfXCqBbYBU2Dh43C0sx2ux+4o130oilvbFAC2MsVaVMA2bvhqIM?=
 =?us-ascii?Q?2qEtUm84Us1lfskKWteyptqySAwOL9YFQEsX/ZDXCboql7/MW4W3IJAL+DLm?=
 =?us-ascii?Q?83LzHgEAIfQHNGlaPioyvK2SXnBVOeUGgpXPjy9qu/ZmYO0QZ55fAqO4Vgpc?=
 =?us-ascii?Q?IMYjF/FZ+G2T7nbmahJ/uy4IH4b6qQqDr07qUgOlSoHjyZ595WokbW4+f5Zy?=
 =?us-ascii?Q?/40uiaxYHO6gwP34IajYadN1OKankcJXgkip6yFxpJs/WPX2+4gbg1hDzKu+?=
 =?us-ascii?Q?RvWRRi9KtyZC/HQyYbnLV2uyfZ8PTMsRyJ9YwJ8Lbwonr8VI+x7XWglmx3gM?=
 =?us-ascii?Q?+c883003fTnj071CIF2t89Zj2vLE5wZTVnqpIFR2/G31Sk+6jegjTspVDtlA?=
 =?us-ascii?Q?JZe0djtkMy924eehsIzTJ3/M6SNd5FH+VA53UxUBdsnchr4TfXMrT3Cz5QJd?=
 =?us-ascii?Q?Shuf4dGqinP1313G7eBr0hTmKHdYxE14IbXzIVUWEb6vbklWfaA957H2uNBJ?=
 =?us-ascii?Q?dv+wgu7wVzl0yNk29lpdU0mil1xCK6u4LPLe3hK0OryYOGmAEbz34wXFIJls?=
 =?us-ascii?Q?Xco1rAJG1IJMNFW0p7eNCrqU3Y7A9wKYJ6G8o5ytTvI2qwquUWXf/xe7ORJU?=
 =?us-ascii?Q?9sQx4C4a4yA3DVOi9aY8hm1wlpBLVZkfsmOv4/wNOBqhglmCrIV0PtaCDxkf?=
 =?us-ascii?Q?Gg9AodKWxQJQtd6FL3JgROrweP2IJ+pOlBMrueh05IMgKF3VH6BcuNbTmVYi?=
 =?us-ascii?Q?Vy6KOGG+0Ac6aF/MzXgLuoZF+Y3u?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 16:07:41.4532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fffdb24f-8b1a-42c2-d33f-08dce945ab60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8085

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
 device-types/blk/description.tex | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
index 2712ada..0ddc223 100644
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
@@ -966,6 +988,16 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 for a write request if the VIRTIO_BLK_F_RO feature if offered, and MUST NOT
 write any data.
 
+When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, the device MAY
+set the \field{status} to VIRTIO_BLK_S_IOERR for VIRTIO_BLK_T_IN or
+VIRTIO_BLK_T_OUT requests if the requested \field{sector} (multiplied by 512)
+is not an integer multiple of the device's \field{blk_size}.
+
+When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, the device MAY
+set the \field{status} to VIRTIO_BLK_S_IOERR for VIRTIO_BLK_T_IN or
+VIRTIO_BLK_T_OUT requests if the length of the requested \field{data} is not an
+integer multiple of the device's \field{blk_size}.
+
 The device MUST set the \field{status} byte to VIRTIO_BLK_S_UNSUPP for
 discard, secure erase and write zeroes commands if any unknown flag is set.
 Furthermore, the device MUST set the \field{status} byte to
-- 
2.18.1

