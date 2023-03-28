Return-Path: <virtio-dev-return-11827-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39B8C761A6
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 20:19:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D32E1C612C
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 20:18:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C6CF39864AF
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 20:18:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BC9EF98413E; Tue, 28 Mar 2023 20:18:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9D8479864B0;
	Tue, 28 Mar 2023 20:18:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QS2D9ppRmwTr0Ct3CKsFgZ47zM3JRyDsYmmpB0uU2u5rHcPCOvn+I1fAo/THEsSLzuOm9VZfl8MTItVY3wng8kSANZU19x3F1/NwYi8oAaPONJ+BGc8vJuG/h0L2tzOFhEc7JMhT8psH9xYcSJAZYoDxM4s2dsRPdewg3rbFkgnyEV8XMWrTlmiRKLabi8xXGfUQn010YX1coDU72xzeTXQ4/bCfNnUPuSi12Aphz9vVeHePQW2ol09Ism3a2dG9u0qFPLCUuSwDtgvtJvjS6MvZQutHW5Ca24KPsUZ9d/FTE2oOX6jGeaw7k8a70CiJDz828OO98Yw/F9IG0M9SLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dsg/Epu5ok/cP10Whq0mnZQCq9p4QGAaH0344h2NW3A=;
 b=TaxD8tGfXWYrqMS9OJUgbNmUv1EES7Wr0HUWrFMgZLZHfikTOwSlrjfWK9TZlPP+pippP4IUloLgX15v2TeKM0pb67njzRZA3/u4txUciAM0pTDUKIo4B/AdUAhB5GLdq3yr8vIltnl2QQ4vQg0DvGrfgboWAUKneEJURYmg8ljGPGqD8opUN7Y3+b7goxx6/7XdfrWgUIVpVgaLJqY0liKCBhbg2fwyiDf9r4tBrynxn+Q8CIOBEJsK6ZBk3kbUikGXOPZXJ9927oDBbPosabpGc5oHY7nnbLdzj99UccJOJ9RvmnsxMHSdBEZRAwEyeSGuXPutKFYIr10F0a+Wag==
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
CC: <sgarzare@redhat.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
Date: Tue, 28 Mar 2023 23:17:50 +0300
Message-ID: <20230328201754.440974-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230328201754.440974-1-parav@nvidia.com>
References: <20230328201754.440974-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97F:EE_|BY5PR12MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: afa82082-7529-4575-c65a-08db2fc9974b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kToay/VYyO4yvBD77pnHcyZXcYi8GUrLOhI3k1NO4raw4kDfagxkQ9HYXo6nHcM4FRzGjY6uwzsT0sbqhFTzpreLhEkBKh+DcSyVeL7qDSg82n0WQnjtosou6S64CX3Aij0IiWZs11/WJjMDEcevgq96/omS5o/3UWtcDL/VvpG+N6lHRaZEQRF2C1YgCH5QqZT5cwZ1BrtbwB6VqHLkLETMIV0ieGxHouUnlN9FodmQ6T04sQ63QAeEyaF1xIAa7VMlUmvLvTUItmkmxts12Azhp9oVF/RNx5kjHZUNNzchMBlePSPhVi3rSgIphQ3DPF2epSfshgnSgn78xELWRCq/vS7OrrPfpxLW4XnEQD8ShreW3pWC2ySgGk4OLcGinJam9/g5Yi/ajryEMny9stDrdPeEfwBkSW4virJOrlwnVpTv7aT7Y7qSjl5Zk0IUAKREufm7fYQdwu2RnD1HdfDGuDV5pQz4LDl4gX28yKZxeYV+JbGh+g81xdc5EncTpW327ZPJD+5zLp75UZcHeV1A2liPkr8g7fhMm801XIt8rxaTrLPyfC8HRXTYFJqTWMAQLJA81OTnVuM1I1Lv8VAsf+TgnUVb1ygYJSrzcb556ZtjNT87rOB2FrL5LoiBpjdv+28ZeyVHp+rv2oY5wI8SMYaUnQtuu4v3OkEDioxeIqske2oZEY9KG7KIkilFzEeg7lqc7eLG4Ra95Z/jdEiuQa1kltgmBfonaRz/7YYoGb3HzLQWNSlFUFgD1uTF/JFL2zHfR9Uh+PzUCxMRaw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(46966006)(36840700001)(2906002)(47076005)(83380400001)(82310400005)(8936002)(5660300002)(107886003)(110136005)(36756003)(966005)(316002)(478600001)(54906003)(6666004)(2616005)(26005)(7636003)(36860700001)(1076003)(426003)(4326008)(186003)(16526019)(336012)(70586007)(8676002)(40480700001)(41300700001)(70206006)(82740400003)(356005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 20:18:27.4596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afa82082-7529-4575-c65a-08db2fc9974b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C97F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
Subject: [virtio-dev] [PATCH v9 4/8] transport-mmio: Refer to the vq by its number

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v8->v9:
- added 'by' at two places
- replaced 'queue number' with 'vq number'

v6->v7:
- remove text around first vq as it is already covered in the basic
  virtqueues facility section
---
 transport-mmio.tex | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/transport-mmio.tex b/transport-mmio.tex
index 9b450b8..acc72f1 100644
--- a/transport-mmio.tex
+++ b/transport-mmio.tex
@@ -108,13 +108,12 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     bits accessible by writing to \field{DriverFeatures}.
   }
   \hline
-  \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
+  \mmioreg{QueueSel}{Virtual queue number}{0x030}{W}{%
     Writing to this register selects the virtual queue that the
     following operations on \field{QueueSizeMax},
     \field{QueueSize}, \field{QueueReady},
     \field{QueueDescLow}, \field{QueueDescHigh}, \field{QueueDriverlLow}, \field{QueueDriverHigh},
-    \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset} apply to. The index
-    number of the first queue is zero (0x0).
+    \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset} apply to.
   }
   \hline
   \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
@@ -150,7 +149,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     there are new buffers to process in a queue.
 
     When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
-    the value written is the queue index.
+    the value written is the vq number.
 
     When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
     the \field{Notification data} value has the following format:
@@ -364,8 +363,7 @@ \subsubsection{Virtqueue Configuration}\label{sec:Virtio Transport Options / Vir
 The driver will typically initialize the virtual queue in the following way:
 
 \begin{enumerate}
-\item Select the queue writing its index (first queue is 0) to
-   \field{QueueSel}.
+\item Select the queue by writing its number to \field{QueueSel}.
 
 \item Check if the queue is not already in use: read \field{QueueReady},
    and expect a returned value of zero (0x0).
@@ -393,8 +391,8 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 the driver sends an available buffer notification to the device by writing
-the 16-bit virtqueue index
-of the queue to be notified to \field{QueueNotify}.
+the 16-bit vq number of the queue to be notified to
+\field{QueueNotify}.
 
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
 the driver sends an available buffer notification to the device by writing
@@ -471,13 +469,11 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
     (see QueuePFN).
   }
   \hline
-  \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
+  \mmioreg{QueueSel}{Virtual queue number}{0x030}{W}{%
     Writing to this register selects the virtual queue that the
     following operations on the \field{QueueSizeMax},
     \field{QueueSize}, \field{QueueAlign}
-    and \field{QueuePFN} registers apply to. The index
-    number of the first queue is zero (0x0).
-.
+    and \field{QueuePFN} registers apply to.
   }
   \hline
   \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
@@ -552,8 +548,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
 
 The virtual queue is configured as follows:
 \begin{enumerate}
-\item Select the queue writing its index (first queue is 0) to
-   \field{QueueSel}.
+\item Select the queue by writing its number to \field{QueueSel}.
 
 \item Check if the queue is not already in use: read \field{QueuePFN},
    expecting a returned value of zero (0x0).
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

