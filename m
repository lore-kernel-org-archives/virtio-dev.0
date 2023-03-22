Return-Path: <virtio-dev-return-11725-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C74AC74A5B
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7501D721E1
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2C4E798657E
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1761F9867CB; Wed, 22 Mar 2023 21:53:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E326F9867F2;
	Wed, 22 Mar 2023 21:53:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/feZFOuG0dmEtSfbAt4i7Xgb4/KqtTY63it8GagssUPVrkMpDgLF6rCTzkuja9/qoZT99Px/M7z30Gxss2B6AN4Z9TNnls7bxN5LfV3mQY3BHzjx/fIwoM77mRMPUVh0n/bMoXhzn0yOOhq3s3LZ3Y7q8ggtXvoF75ofsSnBYfSRCCZWx2quC71k/e2ozsIKd3fuyRVQjdOa9sumzmGhKDxemQ1mNOESnCo6qWkGs8xvHAfrgEqkYZ3ZWeW64lYVX2YRLPg/3FYP4319G5KY7RqeQUr0tbdjTUtNC0ZjWHMmpkw5yXljP7TjY2BYjvpxMKktgSagdPykF3Ue05dmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=endzE8e8srqAsOtj09NhPJXNKyARwdFDkFMFOJLw3oc=;
 b=ewCqwHn/JiSiIOFyeQntocyyQpaoxhsVNttHyoTWPFSFMpEFT4+gXW1oFc02QUvH84H6cxlsTloG8uIdMQzvAj7diVPyFx+Ak/fjQqbvzfWjqVMQadnKLF7IHnTP/YpLFCs4YwG2fO0PKvcShWNzFvrmxnNPX5BLlcbIeriQM9lTMZwhSo2y7qOGRWR0r0RwwciEB7ujvdvYGiorrpzSDdlOo5XWNOj35IEYUhfa4zLjKhzdxbL977XQXluwpVUyiWSHVBbuDNulSN2toRefwYjt4rAkIihnBRK9Fg+c2q3AEOTOP/aC8IhQZyoY+HKKhF13/S4n227+nG4oexYHrQ==
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
	<parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Date: Wed, 22 Mar 2023 23:52:39 +0200
Message-ID: <20230322215243.249524-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230322215243.249524-1-parav@nvidia.com>
References: <20230322215243.249524-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|BL3PR12MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4fc4b9-85d4-439a-3c10-08db2b1fd2d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sr/unl5zvRSo3wQZMn+x8lN8Hd/QQcjJNd5xMMVSN6mgZF9+VGcWw637TcQOwe3I+YJgzvfOGWj6s52NuLDg9xQ9pNSg3IBYMODZm2Zb/ZFP/7UfP/qkTa435mLsBRa82/uK5wbp+RBUNbNs6uiRw3ILKfOReip4yK4qYavsTFUBYUGYdS54a84negZBzw7oHBjdVGmfKmYcAxIUKZSfTo41Z4iOLsmniGgeEAXEqrb1gxTOEMYJpwObOyIenhY2Ti/4HLEOdbg2Pl8ld1P1rSJ9zXsMarVy7un9rs9Fbfd7ylCVbYtnyLjHXqIbrP5jT1dePqrDGYPB2AsVNEYxOL/HwLqDJKwiVk3zkFuUjn8iJBQJQqF4blmspn47VFpy5MbNkJdQYSa9Sv6ebUKwt2Ud4i8cTjPYXu8hGuw0ddaNrHU9TBoimpNnA+rjw/IzjHlkBZLwRE7QmEhC+TyYIZX4ECZVf8ihd1qr1KNdVRGJ+OJty+02D02y26QDNlskwmWU2EkJNjNANYWeRpVLxf6L1ivlahp/Icx4P3q5GaHKf6hEzWgnBlOajv91mqRTUnuoSat8L4pq+26kbqX4/tQoiJOgdWtNrWJbcCi4tRfjXOZCHUzDdBiTGUki4EUa4PunhzQB7L1/XmsTQrjy3NbHalO3jXQHOUJN9G+BYDBXlxEM4gq2YvbzwJoIGoYMzRqkK1N0WZ7iGsbg83KRQ8sxAGY6n09E0X6X2rz8ybP17/GfMsnqulj06q91oac6eReI5SKqzuWmmPLqFSfS8Z0haEejI8r59phwHqDzQDE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199018)(36840700001)(46966006)(40470700004)(16526019)(2616005)(966005)(47076005)(107886003)(26005)(54906003)(83380400001)(426003)(6666004)(336012)(186003)(4326008)(316002)(1076003)(8676002)(110136005)(70206006)(478600001)(70586007)(36860700001)(5660300002)(41300700001)(82740400003)(7636003)(8936002)(2906002)(356005)(40460700003)(86362001)(82310400005)(40480700001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 21:53:08.2337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4fc4b9-85d4-439a-3c10-08db2b1fd2d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6548
Subject: [virtio-dev] [PATCH v4 4/8] transport-mmio: Refer to the vq by its number

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

