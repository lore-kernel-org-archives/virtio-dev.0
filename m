Return-Path: <virtio-dev-return-11946-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FD2C76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:52:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B19D46043A
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:51:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0AF0998683B
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:51:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9575E98661D; Mon,  3 Apr 2023 22:51:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D4747986661;
	Mon,  3 Apr 2023 22:51:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwJxDGR69RBRAmeo+N34HVur1uZP4IFlu0cLlJpbODd2YXc0F9zwIuCyoh+ZdNcCpHEU+3Yt6M2p9XrLLlHSG+po2N2/sgffhqHy5Z+kjMsFBtLAw7ys/S+3L3kdgwVVVufll+HSUwY/qkh5xW4wp4vYXX1D9CtfkbYw7CQfL8ZV1zJ0THZIb0ToqlCPAJEY1cmWlZsriMX0BmaHqkFG2Bc03bDnMFWFdVs3ta30G9cAX9h8VmEGcacqhxScexIt7FDW1SUCmEotLPp7HMrR3EAoCj38Ea5/uj0jGBBkQGji1VX6qDB907FBz7yX3Lwo5iH9ERGeijQsOcHEhdbPbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEid9pu2LCxtihg4JFjkqrWbuluNGRgT7MyJLhx2ndI=;
 b=aWryhkBpeMwfKFzQDtxd33jwkjASDx1wL8N/uRssh7jtj5gvc0puk9lei6qhFdQ8VPOICP5iIE5b6XvyRhKBGaWgMnEHrbCLnpxxEEnjd8rH8+Q6utcSn37DU37c8VOxfAsMY2AfhyaE/FerMU/O498M4U8Cn75aoKq6fN7CzDxCgDvXnKjnL2McTdJWsyvRP5yb/OHLyjQmz+yHMDrWPxVH4oCW2xSCCwpr/7JIcZn1Xxtzzx1rsLJN3cj/wRT2bKZjRYR5uWvPrCthtG7NputB53Ym6e5QfK71Gc3DQrQdlAk0fgRQS7Q4vOnvA9cxLBqG2SLEOqKYD/XRf3kVQw==
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
Date: Tue, 4 Apr 2023 01:50:48 +0300
Message-ID: <20230403225052.585498-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230403225052.585498-1-parav@nvidia.com>
References: <20230403225052.585498-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|CH3PR12MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a033ab-d012-4194-c58b-08db3495f5c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hd9jvrYYzr74GnR+JJSlIc0AxaGswIKkTFm4BNLVRMkBDGEOq5StrRPgVEcmOefAViIFwbwoDuFVAisLtlAZR+4nJbcf9EZVnkn6pbOQ0YsC62R9iZ33J8L1xgYom/SeZcmFPTrUn1ahfZHRwTCr7u2XczsAvM3apeI+DKRafwdlzRMvUZK7aBUtkBT+vFsqrZDxxAgA7GUxTUFcLu0jlBXLKH4Nddg0wvQA2ihZMpbF47TcUG0OkC8EVO0ZV1EAGgwqzLnWUQCfd94ZNEcMMXDPHnhQEwybsWxtclrzjT8JHlwhEjINb5IDGWzaKkFuce5jg0LLkT9r/gDup0SpxdHfFohwl9uqW8lXGJnHp1YyXcbx/EDFT51gZeSoYYC7wRZNTIfcp2ylprqrkP1huCaM0koACxCW15hEqi0lTom7Ld59lZ2wMURKUuCpXaERjWp5++QGga8TKqbdYOV+Sj81hSv6p/ewrsi3geMRmR2KoGN/mlI+k9XqajFYozmbqtNf/QsGvIpx66EgxKRy0m0sDcSX9l2bSZAkJyWeNs882Kh/omnx3YtWqqd15NlD9QUbKTnH9jDJfJTZD+NCX0R/4YxanwWIZ4Yb7felvMkoOXP9jau4b+E6ZsCyTg8OmniAcH1aReWByCmMIM+K1JmXBMt9VmCPrNWyiHYJ/0Y2rn+VngmKdqFypky0VtjPpB0SG02WJ2W79OMFe2zYWmb204AJDxr+Yr78s1b6EUS8I4HdeB/4ditMrSZwsOrQ9w9NPbuFM7c7tgya2zd2YWLjJI/vqeu44U4if++uGZc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(36860700001)(41300700001)(40460700003)(70586007)(70206006)(478600001)(8676002)(316002)(110136005)(54906003)(7636003)(5660300002)(356005)(4326008)(82740400003)(426003)(47076005)(186003)(16526019)(83380400001)(2616005)(336012)(6666004)(966005)(26005)(1076003)(107886003)(86362001)(36756003)(82310400005)(2906002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 22:51:27.9438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a033ab-d012-4194-c58b-08db3495f5c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306
Subject: [virtio-dev] [PATCH v11 4/8] transport-mmio: Refer to the vq by its number

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
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
index 164e640..1350b02 100644
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
+    the value written is the vq number.
 
     When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
     the \field{Notification data} value has the following format:
@@ -363,8 +362,7 @@ \subsubsection{Virtqueue Configuration}\label{sec:Virtio Transport Options / Vir
 The driver will typically initialize the virtual queue in the following way:
 
 \begin{enumerate}
-\item Select the queue writing its index (first queue is 0) to
-   \field{QueueSel}.
+\item Select the queue by writing its number to \field{QueueSel}.
 
 \item Check if the queue is not already in use: read \field{QueueReady},
    and expect a returned value of zero (0x0).
@@ -392,8 +390,8 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 the driver sends an available buffer notification to the device by writing
-the 16-bit virtqueue index
-of the queue to be notified to \field{QueueNotify}.
+the 16-bit vq number of the queue to be notified to
+\field{QueueNotify}.
 
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
 the driver sends an available buffer notification to the device by writing
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
+\item Select the queue by writing its number to \field{QueueSel}.
 
 \item Check if the queue is not already in use: read \field{QueuePFN},
    expecting a returned value of zero (0x0).
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

