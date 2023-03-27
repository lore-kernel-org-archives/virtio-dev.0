Return-Path: <virtio-dev-return-11803-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF40EC6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:01:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 71F1E42BC6
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 691A99864F2
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5A29F9863E4; Tue, 28 Mar 2023 00:00:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 92A2F986615;
	Tue, 28 Mar 2023 00:00:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=If9/XWM8Mev9YRuTonEZBUjHla+fdl2Fgs5efM7KKoIY9CIaOlrWj7nPMLbMUGFN41yJYN9mPN9Ckr0LHTG5gCfQGcO/8lUAGzvKiIC9mv2mJzaAKyyi8GNK9w22qxVvygzNYe+lCqsa8bQG2jGsQs9V9WfrEsSqhoPohCmvAov6PVk4/b7RsA7MEKNbiL4Z2IXcEth6vzjXlSpP5cqAWajISXG9ww6Yq2jiip9AWlxDCkZY6h1iFHAYFvH2MPetVaat2L7pzaqhNnl4lxGJZvJJ3Ew/ujJvfq3F1D4Sd4bCTZa62UcLlcgqPv+M3gKsvChXyTWBauUsvjPUZdfIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DLxeQvDTyhATZ77EhHjxx1JoGgvKDnEg/8v2GLUics=;
 b=JGpD5sdHkAePHUUK323b2NZPsvrfcxdndXHckTGFmU+gMEKnQ1ccfrXmsVmQdYLulgJxAkAr2oTRVcuqGA30042Kai0/rrsNl85rkPFDfxG3x0ghnZaUDnTGtNH1eIbi6tX4HwUWbm3g3fopiqONAcrX0c+x9LBPCHroWkz0Nuur92qqoaoM0ydAx/mDxsQrJwJ5UDOgcZhB65xaW6XPm8RQOMPQRlt/bapJpTMYzBVzwzVK58070HR6ANkxS5mts/7LsWWQ35hqPMFnUs+CaUjX2yGfmTsvIND9MZLk2nycghAAKbqilG1EsrPZSWH/2pn3zvPBOTejqd6Fxr5ZZA==
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
Date: Tue, 28 Mar 2023 02:59:32 +0300
Message-ID: <20230327235936.414196-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230327235936.414196-1-parav@nvidia.com>
References: <20230327235936.414196-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT010:EE_|DM4PR12MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0648f7-4f42-4c83-160c-08db2f1f61fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yfas/gPOh34CvU7nOgRShITM3QFKMdxfJAmz/FzFX6AGADZ/aCPGa13uFBuRZmaFxenKFACBQ8Xx/G+Y1H0Q5+QoOI5PDAXiI1VUiK5aAfF9LqvvxL1IH2DiwSr8jtqX9LhnuSVvC8lnc1vMbk+PW+FtCR1Lyy66zndLuAh30uok+u6+rW5uLJAcUTbSUE/1aWQNgVY2sZRGJf5Fodlb4qH3yFyBlnt/H5Qo5fYll5k7vbVp8KaIfaEbN8sTeLYf/iIdhGH2nHXb8QKDNr2gKOXmDD9M4DulTpkEsA3r5tNz6s+Wvnql4NOKt57uXwi4ZJq0TxqEZABaOT+o648ywHd4W5rBeG/W541bExUR0SJMUffgXzko3daoTTb8XshmvL5uWKclFEX5Q4/dwzPRW7UHt5OKTdzhd/bBwEn8TsglbB0I3MDo5/7eFiyqn7Ab/Xq+S0k/81+8u5L3FpOhZS8LYD+CxBy2gD0mpxSwQ5tR/kPSjhFaThrMLuhmQQQuz+JPEwX1Lr17yZtvWpDTeBxAPglARhBXcHsg635uQI7ZDtVktOzpuS/2ijUm+wcktyRbqJYskkgSPAT8Xm3QCsIWrPUq5oES03q+A+FGr97MfWRDm9qxt0OzmMo4UtEqAITKa9JJK7cScXvVsxWVCjNExbJxEfcRxtrwhGswMDQQ4fLqwQDR1rZ9ATKMbLqnrfggfVDuZ/+Q0GRaE1c6WrDEwpatDqqM1rloCr13CE1J1GNiOw4+107go+AwpiPouxsNNsJjUPn6ABeLhcJm8b5abb7ukwyLi9UAptRx0kNa07PmMuqk4EnNgW/uvIYotRa6oWlA4vs7VBJ+l5UHGg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(34020700004)(4326008)(36860700001)(40480700001)(70586007)(54906003)(8676002)(70206006)(316002)(40460700003)(478600001)(110136005)(2906002)(47076005)(186003)(1076003)(26005)(16526019)(83380400001)(2616005)(86362001)(426003)(336012)(36756003)(82310400005)(6666004)(5660300002)(41300700001)(966005)(107886003)(356005)(7636003)(82740400003)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 00:00:03.5650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0648f7-4f42-4c83-160c-08db2f1f61fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5962
Subject: [virtio-dev] [PATCH v8 4/8] transport-mmio: Refer to the vq by its number

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v6->v7:
- remove text around first vq as it is already covered in the basic
  virtqueues facility section
---
 transport-mmio.tex | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/transport-mmio.tex b/transport-mmio.tex
index 3047633..2aa6627 100644
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
@@ -149,7 +148,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     there are new buffers to process in a queue.
 
     When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
-    the value written is the queue index.
+    the value written is the queue number.
 
     When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
     the \field{Notification data} value has the following format:
@@ -363,8 +362,7 @@ \subsubsection{Virtqueue Configuration}\label{sec:Virtio Transport Options / Vir
 The driver will typically initialize the virtual queue in the following way:
 
 \begin{enumerate}
-\item Select the queue writing its index (first queue is 0) to
-   \field{QueueSel}.
+\item Select the queue writing its number to \field{QueueSel}.
 
 \item Check if the queue is not already in use: read \field{QueueReady},
    and expect a returned value of zero (0x0).
@@ -392,7 +390,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 the driver sends an available buffer notification to the device by writing
-the 16-bit virtqueue index
+the 16-bit virtqueue number
 of the queue to be notified to \field{QueueNotify}.
 
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
@@ -470,13 +468,11 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
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
@@ -550,8 +546,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
 
 The virtual queue is configured as follows:
 \begin{enumerate}
-\item Select the queue writing its index (first queue is 0) to
-   \field{QueueSel}.
+\item Select the queue writing its number to \field{QueueSel}.
 
 \item Check if the queue is not already in use: read \field{QueuePFN},
    expecting a returned value of zero (0x0).
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

