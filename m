Return-Path: <virtio-dev-return-12151-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038FEC77B72
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 20:05:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5CBEEC6220
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 20:05:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 765159866A2
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 20:05:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1F29A98650E; Tue, 11 Apr 2023 20:05:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A0733986509;
	Tue, 11 Apr 2023 20:04:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7NdHl4za5TAO90+7jAl/MGmQe7VWmXeEH01LzhJVYcDDezDPtyyAzdP0X7LgwG94i0w8utn4O2B13cXeWZLTBEjBQBS1Lr2tO8q9dQYai63lkYj/fruRGhProVBW5Vky7Kw2A4PvOUXPFQqdX2jvCBnn7soCkXovwY8kPrc+6t80CSWHJgwt7da+TkemRodqmmjR0SqW9B8WTOvttXYjMiCS7ObPkmupEbGX4D5YbKEXIe+YsmARQrH5yHVeggCB2M20GLorGtyOaOGjdo8DrLfuCIj6zzOKuktfB8/4wEX0G33+8aJoLBDhEyVmRTjlXpsHFmBVPQoI/DHsNJVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ebuD5M6X0n0QqbALVwBvtg87SIDXJMH+ZqIgYEAEmM=;
 b=bifDqcRw55nxJ+2yXZ86JT7lpG7CUTx/ED0Mvmz3QZ0GHl9Mgm44LujpAash08dXaia1t4s43UKdQSKiOQF2ej/mqd4R/mLLxJmFhGzXCXoEFypu5SmtHK+4dRKJBILNL8Rmetq8D1DiTTe84AlI7XrFvKLPJ6mBgvzh06MzB7cHrv/We6g67BTODwtjgUfZjbpfPbwmk5Lpu6gEmD+RjMRvb4WxxFag85Mwn8bsWG0NWimDghlal5Ul6aetuFuTNUj1IcZjzFaMeE3i3ssTm0PNqyAGzx8fqgkYhH6Tz4QLmeJ50KGQ8s8aqIx8nBGt9/vztYt/QhNbYHQCaJEfFA==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Tue, 11 Apr 2023 23:03:58 +0300
Message-ID: <20230411200358.753101-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT007:EE_|IA1PR12MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f539fb-09af-4566-1641-08db3ac7f2d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2dXiZJwqTaEkxJPB7Ce71WoGSEdfp1XMo7Gf9ETHnE/U3FAWl6JxMZew7qgS/PdlVbz7yUio6xjGvJ/nEv20xnTgiJ/KidqkHq9GJnT6ueQVECtFMVjur9bAH19n87eXU4NRgIf3wN5+3QWo88yKNjzAtljB32UKLGcH9v/cyuRUeSsjDKywMT7XC2g3rDTAbvDJv3aMl7xdjbVxyinC3QH/PE2qSCgOZo+OXGtgFgSmbp7gl+UR1iTDuAYRMtjJXmN+l6dav1DGTOmKOLBEVFDdiOxYYH0GWnsqUPCSy+n0DcJ/YRZg3lWu76tpvzmiO8CpmovHtn3Lp+OiCK2LRe+vyI6EIckDO0EocjAdCK3E44rCi1VtSnunNOt+Ok/gG3GixLQsFVQfZ9UuIDRoZvwrpOtHcDM8neUnLDSih4l+GZUrf9ACzSWc6ylbiZvrJi8Ve15H8IqARf81R0ap1Q7fFWyzCh9N3ydHT6kE3+Y4ZPMAE7gRdNf2fRmlhbICysQKTNPdif4WIretFOa4IqTQFCqmwtQ1A1QGQapOjHu+lnuqvU7MFr74yNeSYOzbd3ulfvmtvmLAwuFfjO7DiV4Wd3vG13Q7U7WWTQcdicP8/Jr1gYOeL6IhtuqO2PorvyLrG45IhnSGhd5hQT64q/XSju8B5Vox9btRLKu3TzYs98lfALcRAZzT+WTZjem7j+QZCyyvXZajGn/NEpPnYy1CfDK1C8SHsawW9rqfyMU6N3ZbW5Lc6CjeaMagGluv3tHlSko5A7n0Zvi3lPTiCr2gQIeL+lxtTU6DkjeBors=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(36756003)(478600001)(34070700002)(110136005)(54906003)(5660300002)(8676002)(8936002)(70586007)(70206006)(2906002)(41300700001)(82740400003)(7636003)(4326008)(316002)(40480700001)(26005)(1076003)(356005)(107886003)(16526019)(186003)(86362001)(2616005)(83380400001)(47076005)(426003)(336012)(36860700001)(6666004)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 20:04:24.8710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f539fb-09af-4566-1641-08db3ac7f2d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7688
Subject: [virtio-dev] [PATCH] device-types/multiple: replace queues with enqueues

Queue is a verb and noun both. Replacing it with enqueue avoids
ambiguity around plural queues noun vs verb; similar to virtio fs device
description.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 device-types/blk/description.tex   | 2 +-
 device-types/gpio/description.tex  | 4 ++--
 device-types/i2c/description.tex   | 2 +-
 device-types/scsi/description.tex  | 2 +-
 device-types/vsock/description.tex | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
index 517b012..f04c932 100644
--- a/device-types/blk/description.tex
+++ b/device-types/blk/description.tex
@@ -427,7 +427,7 @@ \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device Types /
 
 \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Operation}
 
-The driver queues requests to the virtqueues, and they are used by
+The driver enqueues requests to the virtqueues, and they are used by
 the device (not necessarily in order). Each request except
 VIRTIO_BLK_T_ZONE_APPEND is of form:
 
diff --git a/device-types/gpio/description.tex b/device-types/gpio/description.tex
index 8e5c7f0..d51fbe1 100644
--- a/device-types/gpio/description.tex
+++ b/device-types/gpio/description.tex
@@ -358,7 +358,7 @@ \subsubsection{requestq Operation: Set IRQ Type}\label{sec:Device Types / GPIO D
 \subsubsection{requestq Operation: Message Flow}\label{sec:Device Types / GPIO Device / requestq Operation / Message Flow}
 
 \begin{itemize}
-\item The driver queues \field{struct virtio_gpio_request} and
+\item The driver enqueues \field{struct virtio_gpio_request} and
     \field{virtio_gpio_response} buffers to the \field{requestq} virtqueue,
     after filling all fields of the \field{struct virtio_gpio_request} buffer as
     defined by the specific message type.
@@ -458,7 +458,7 @@ \subsection{Device Operation: eventq}\label{sec:Device Types / GPIO Device / eve
 
 The \field{eventq} virtqueue is used by the driver to unmask the interrupts and
 used by the device to notify the driver of newly sensed interrupts. In order to
-unmask interrupt on a GPIO line, the driver queues a pair of buffers,
+unmask interrupt on a GPIO line, the driver enqueues a pair of buffers,
 \field{struct virtio_gpio_irq_request} (filled by driver) and \field{struct
 virtio_gpio_irq_response} (to be filled by device later), to the \field{eventq}
 virtqueue. A separate pair of buffers must be queued for each GPIO line, the
diff --git a/device-types/i2c/description.tex b/device-types/i2c/description.tex
index 5d407cb..861529a 100644
--- a/device-types/i2c/description.tex
+++ b/device-types/i2c/description.tex
@@ -47,7 +47,7 @@ \subsection{Device Operation}\label{sec:Device Types / I2C Adapter Device / Devi
 
 \subsubsection{Device Operation: Request Queue}\label{sec:Device Types / I2C Adapter Device / Device Operation: Request Queue}
 
-The driver queues requests to the virtqueue, and they are used by the
+The driver enqueues requests to the virtqueue, and they are used by the
 device. The request is the representation of segments of an I2C
 transaction. Each request is of the form:
 
diff --git a/device-types/scsi/description.tex b/device-types/scsi/description.tex
index 904c4a7..478b558 100644
--- a/device-types/scsi/description.tex
+++ b/device-types/scsi/description.tex
@@ -158,7 +158,7 @@ \subsection{Device Operation}\label{sec:Device Types / SCSI Host Device / Device
 
 \subsubsection{Device Operation: Request Queues}\label{sec:Device Types / SCSI Host Device / Device Operation / Device Operation: Request Queues}
 
-The driver queues requests to an arbitrary request queue, and
+The driver enqueues requests to an arbitrary request queue, and
 they are used by the device on that same queue. It is the
 responsibility of the driver to ensure strict request ordering
 for commands placed on different queues, because they will be
diff --git a/device-types/vsock/description.tex b/device-types/vsock/description.tex
index 105bb30..07909d6 100644
--- a/device-types/vsock/description.tex
+++ b/device-types/vsock/description.tex
@@ -218,7 +218,7 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
 \field{buf_alloc} and \field{fwd_cnt} fields.
 
 \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / Device Operation / Receive and Transmit}
-The driver queues outgoing packets on the tx virtqueue and incoming packet
+The driver enqueues outgoing packets on the tx virtqueue and incoming packet
 receive buffers on the rx virtqueue. Packets are of the following form:
 
 \begin{lstlisting}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

