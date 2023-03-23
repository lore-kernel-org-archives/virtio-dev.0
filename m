Return-Path: <virtio-dev-return-11740-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9338C6FD1F
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:01:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1CF656849D
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:00:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EE3CD986583
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:00:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B743D98658F; Thu, 23 Mar 2023 01:00:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8C5959864BD;
	Thu, 23 Mar 2023 01:00:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ii7VkXmGHVJvcDW4vdX23sbd7rY6hn0eh2kFE7i6VgpHd0chyIQKhAEECnOYDnSGxRYLvpTh6S4QHMQGofXXpj2LNaBfTaPfZDwuANr8ZNuKcySj+96Y68AwrDoSxK3V6rg39huk9Ep6RXSpyk7qC34WNkBhSnaUttALVvIsN/2qwUnfPxaxKRBPvma0/b99/weIVSt2hxoGiZqHt4upsGxdA0vek1x0SqQsw8gUBf/+aaGyqSyXfKWYiUe1pt87AGWr8aT6UmaY27NYXv4piU7mL2rQYDKxpMpG8Pmysie3n6LCiPn56A1gBmM43zS2mxlYKk+/n3PmWGc6y/GqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=endzE8e8srqAsOtj09NhPJXNKyARwdFDkFMFOJLw3oc=;
 b=V39TykNn0EjV3rEy7/+EexWUrKxe4eiVMDBeCmbU6qzauTiNyoyt+643wavJHTt2Pv9zAX2hFa9sMPNbgbvtJrT8oLVwtVMbxgzb3jlcx5DLwQ+qjOrDy3D4PYZU5jUpTNPbyG+YQVGrCp6/BOtp33J5ZHIb74Op8o1fF5YRmFUzRDC4viy167lpfLv9q0I2QpH+FEDnNgLStCRZh4AkTdGr2P6c5BB/Smff9MX06NxkRhikWWlulBHovW19RBy4vtHclfa8nGIxDHHi/6FnMTashLK9JobCOhyYUDgE6xqWqMpi81fO/t6paXXUBkHTX210DioNRy07uO+acRdbnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Date: Thu, 23 Mar 2023 02:59:40 +0200
Message-ID: <20230323005944.262738-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230323005944.262738-1-parav@nvidia.com>
References: <20230323005944.262738-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C983:EE_|DM6PR12MB4340:EE_
X-MS-Office365-Filtering-Correlation-Id: fda91549-6066-4299-b798-08db2b39ff27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z/q8988tBGr+YFTvKhFeuYDMSlzN5SwlQPpHrwKjwRKa/Evp8xfUj7jJrxOERhOtwInPTd5XYpfLPoMkSpRYXDwpMEE5ksMkDWCnC/5z8vjaByRtcKBL1MMejmjS1laTubhebOBYlT2/oD1radxqo7QVsSL1qdniTOSSLmxCqpZjerJperQDwmKG7g49sd8ZIrYzULiCjKkTjMUgvejGTjAfQeVJnZ1634SursoPNQFEbZRXewYNuVJzkJ5NUjJGRsMGO9lcWKdeMEyjZIluHBjHR6FapABOU05+J2xKXYwEVLSd9MtQgeB59pkWmpouBWMhFGD6pc8DDlqeLgscs24cpgbGO3VVTQbQmSSqedomaYkxC6QOwAc8ZZ4K6JJ1g/0PeqArKi369rksIxmZlm+AHoVjuQUzknlxdJlp9z8dsTJgWG1cOKcB5NI2mdPlYRx0MZsx5lI9dbiF5Ng2RhmZ2Lq/R9yaZOA4ePboXsxcdMCKJqgoOpsimiBh69Fg6QX+ufvzUcfzW+MPYowadvuE2jL/xtmn6UWBoDPFDPSZ0DPCNRocG/xUjWN3CZGoAACWcvG2zRQmPtWKGbYW4StlHMW3TeGtl0a9E+ecPQ9chW+wTdRSm0R/fhYK4eI4tOpoUebpavOD8/baMotu9UtCIBSmWMcXKtrGTqRK/b7nOnIPIf40f1rBOAJvYVf1yd29lIv4EUJ0+RjubFbFO79dlwCsmeQQ35aFo8mWXdTCVC9YQI4LtCayHa7OKvlubopW8GWHOfhVQOu4OL6nw6BapTOhJM4MSFUxA6Ncvvg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(86362001)(82310400005)(40480700001)(40460700003)(36756003)(316002)(966005)(478600001)(83380400001)(8676002)(110136005)(54906003)(4326008)(70586007)(186003)(47076005)(26005)(336012)(6666004)(2616005)(1076003)(16526019)(107886003)(426003)(356005)(70206006)(36860700001)(2906002)(41300700001)(8936002)(5660300002)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 01:00:29.5886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fda91549-6066-4299-b798-08db2b39ff27
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C983.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
Subject: [virtio-dev] [PATCH v5 4/8] transport-mmio: Refer to the vq by its number

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-mmio.tex | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/transport-mmio.tex b/transport-mmio.tex
index 3047633..f9b3a34 100644
--- a/transport-mmio.tex
+++ b/transport-mmio.tex
@@ -108,7 +108,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     bits accessible by writing to \field{DriverFeatures}.
   }
   \hline
-  \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
+  \mmioreg{QueueSel}{Virtual queue number}{0x030}{W}{%
     Writing to this register selects the virtual queue that the
     following operations on \field{QueueSizeMax},
     \field{QueueSize}, \field{QueueReady},
@@ -149,7 +149,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     there are new buffers to process in a queue.
 
     When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
-    the value written is the queue index.
+    the value written is the queue number.
 
     When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
     the \field{Notification data} value has the following format:
@@ -363,8 +363,7 @@ \subsubsection{Virtqueue Configuration}\label{sec:Virtio Transport Options / Vir
 The driver will typically initialize the virtual queue in the following way:
 
 \begin{enumerate}
-\item Select the queue writing its index (first queue is 0) to
-   \field{QueueSel}.
+\item Select the queue writing its number to \field{QueueSel}.
 
 \item Check if the queue is not already in use: read \field{QueueReady},
    and expect a returned value of zero (0x0).
@@ -392,7 +391,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 the driver sends an available buffer notification to the device by writing
-the 16-bit virtqueue index
+the 16-bit virtqueue number
 of the queue to be notified to \field{QueueNotify}.
 
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
@@ -470,7 +469,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
     (see QueuePFN).
   }
   \hline
-  \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
+  \mmioreg{QueueSel}{Virtual queue number}{0x030}{W}{%
     Writing to this register selects the virtual queue that the
     following operations on the \field{QueueSizeMax},
     \field{QueueSize}, \field{QueueAlign}
@@ -550,8 +549,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
 
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

