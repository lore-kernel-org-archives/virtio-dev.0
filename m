Return-Path: <virtio-dev-return-12329-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C5BC7618E
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 19:56:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 290AA2AEDD
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 19:56:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A7F9986640
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 19:56:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EB25C986634; Thu, 20 Apr 2023 19:56:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D8DB0986635;
	Thu, 20 Apr 2023 19:56:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPZCXsQXMQoMDDr1NABzg7TtO8CgRfInw297C/Euk4w+LW59LE5AZggSsg1XqD936Krp6dpNr6wNbj7ynRVnF6AhRxgZJ3w4C5+2HTQtu0svVCcBD56AOA40lzhKkMdA1VeOtKoLXedZZO2D6WfRoJahU4ILVyxPcmulx+8ozYM9PcMHYu+ehJFqwGiEYxqeSW6c8SebmslKDgRAIISpZK59ZQcB7gFxf3pFySCmwPk4mdPN8mzMVvJpOoB9PCB3C/8X+hZ5zrI6+Ncy824bxv/Zk6iVok+JFHIV6bhh6FNH5m/tKmBVOj4ahbKIvGTNNiEKcLrPTOTcBzC11emYMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Y9pg03NbUpdEwgRlP1vhr61Iy59xOs8aAn7HuedPGk=;
 b=XpYxbOekqgX1KXzlPixVueSfJtGaBCqbR5uVcgZWKjakxb2zdTQq5xk0lao//s6pY9T9PtZ91RqDWAisVDP5cU1o99RGB68Cs4FJ3GtylBYyFENTAJSMEMng+HSvsxBsOlmeKbjDdG3RMe9lgqklPeUeIuwUv10t68B+PUwCVV2QIfsgdR4Xq5CA16mWItanuu38UDxnk5bTVjEhmJUftbuSfKjLR5B0Wg8mFIZq67DGWgHWGEsep48O3n/7GqGxdRKujlKirk6qMSUdefNNa6dj7IwCbNiCwhIdzY4zkNmuXvDzTuyL9ctvTwmj+P2KZ87kgLBtwJCD8FOxBwzMBQ==
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
Date: Thu, 20 Apr 2023 22:55:54 +0300
Message-ID: <20230420195554.69907-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|SA0PR12MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a7b25d-c040-4657-813e-08db41d94dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fc2ANBKrRrg6ivDLMGe5WwfFdbW9S0AY2tMQKljNEDsySBKCDPj0K7BS90vJg6RjgOjQHSPRVeji5rQONaKSoNbmiy9NJCAg2/bJcICGplsSBB2B8nbLIzxIg2VOSnLgaUSXXW6j1YdozVQNaVMQlZkg2f3+Bf332UAI34U6Ym53ZdZvB3dNjU8+LDbWOMoDeB3a2vhd5vdE/gEaiNNigKtNxGbV0FlLnc+Y9Gf4LLVXGQLOPUw7qBMN0SqQvq0j6yPAPDpBkebiQn/s2g64Mf3oFWJoHiwsFLG8qNvNdZC7gO1dtVcrBGngqthuDTqUcjvkxaxOiMKOb0mPt2uS0+ykJkmQ+aNcmiRe8io9FSQy6ON185kpDKEt7UUPjjoJV48h7yvjJuIAIzGxeNmahro4LoK0whjK7guH+KyNRqIFXhakapkRxANTC9xmKiEMq5j5KOymqjl8+9m9YZJwX5oiBfSAXoqLuiDzwn44qvgVDMKZ/maTZdqSbI+AXDoMiCdtcFeWc4zcK/7smRfBv+kqHcIbexUCWZorFu+6xGWaQU4HdTiTTYm8s20MXlkAeZ7I216HC7zXXf9VORz1tX8dUhul45vowc6rpX5dVrX1E2EGOIUAmiiN78521zitlOHA7JVFaqq4ENn9QbkhXX+WaeHFbWL3MP+8f0WZlfpT+7TNfiKKKu+j1BeZbn8ZKJ+7AlbQiKsNmoRK3NwQ+IEKqFd2gyPj6WyQbRtvh7jLwPtjXgf3XMPxenYOPcfFR+ueUoi9aHFNBmPS9sbgZrGDy8YnTrVE2gRcol4Tqws=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(6666004)(34020700004)(8936002)(8676002)(316002)(70206006)(82740400003)(4326008)(40480700001)(70586007)(54906003)(7636003)(110136005)(16526019)(356005)(40460700003)(186003)(36756003)(107886003)(2906002)(1076003)(426003)(26005)(86362001)(83380400001)(41300700001)(47076005)(336012)(82310400005)(2616005)(36860700001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 19:56:17.1303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a7b25d-c040-4657-813e-08db41d94dd9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398
Subject: [virtio-dev] [PATCH v1] device-types/multiple: replace queues with enqueues

Queue is a verb and noun both. Replacing it with enqueue avoids
ambiguity around plural queues noun vs verb; similar to virtio fs device
description.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v0->v1:
- replace 'on' to 'to'
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
index 105bb30..7d91d15 100644
--- a/device-types/vsock/description.tex
+++ b/device-types/vsock/description.tex
@@ -218,7 +218,7 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
 \field{buf_alloc} and \field{fwd_cnt} fields.
 
 \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / Device Operation / Receive and Transmit}
-The driver queues outgoing packets on the tx virtqueue and incoming packet
+The driver enqueues outgoing packets to the tx virtqueue and incoming packet
 receive buffers on the rx virtqueue. Packets are of the following form:
 
 \begin{lstlisting}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

