Return-Path: <virtio-dev-return-11849-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E670EC74A5B
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:25:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 011A23DF21
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EF756986542
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E36CA9864E9; Wed, 29 Mar 2023 21:24:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C242B986573;
	Wed, 29 Mar 2023 21:24:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfvXZTR1K1OPmgseqR3r37jnE6tRiWykonK9J9poAy/KFbbrmZCmay1nFhsIC8fHuCSX5KSdR2LXGH9ZgnFttufcVf6ggU0GssC962Kdxjv3d3Jk+DcMLWtRYmOUKxy+wZWqmUqtZqSCG/KH/uIZPaAG2cerSOO0bVWjzYdldK0hx1fxxqAuPmfSwKE51AIjrwUJklnTFQBav/pRYMu1Rn/33LwOvASOUpd1i3WLOC4tzM/P91vYA6dVZNgHVXZ1mz3Ovyq4QpsHf1XsHMly5nYlkXYQIonDNpTFj7jdlAZN7hpAdKh+aKd+nPKFtu14sz2onrSO9uVskF8JiZfD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEid9pu2LCxtihg4JFjkqrWbuluNGRgT7MyJLhx2ndI=;
 b=GYRBTQrtiiY5C194TIewQM0gM0Nx53FGsfmZt0BYfVWqVhTT9iyJrJV260Wr4YeXBR8gPdWIU2eRA2Dx73uJRO8eFc4r16EmJTRHm3FWTFBdEMuf7qgmVJaIcIlrzlKVqOHIRANF7d4dMMJQW4V4O/HgmqKr0xELreEWJOtdOYgn/A1Z1SGhGT5XMmBJLBwxXaWjZd4qwI7uEgjwze/w9n0SSo3JmrJxQfPbpSc+/jtKPXy6ruSBPg3YJ3oaHyQfM5kh/ySxHUDBGX1uxkQeykOwyPFNEsCtvr2MwWzThK3rOMbk4qo2/SMGnDvp+0LcX7MxMbTsafrQtrlc5pmRyw==
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
Date: Thu, 30 Mar 2023 00:23:37 +0300
Message-ID: <20230329212341.465843-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230329212341.465843-1-parav@nvidia.com>
References: <20230329212341.465843-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT087:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: 30b0df93-b38e-4312-0298-08db309bef53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hywe+U8/DK7Q6OS6d1x0/kFkJ7lEgYUW6y30/hIwJvQEJMnwnuh7+FsGGaDiTqsXk0fenaenv+DNcCdM4jWUA4S5LvJKi7jt+FPc5YJ/jMNd31C0oUkD27Ae3aONLFIg3rGyULBO05iyHgYuXq9s5Sw7DMXqMqUNPdfuoRLuP2wDFbHzj9c9nBIcogY5cyZfesbx3Ta6u+Vx1sObKCguJ6IWcwCfsKvYJoZ4DWg0iIjeqhpUT1/O0PGqNVFU+B8iR15j/HHUNvE4HZrH/bX4nUh8j+W1t78Pb4WinwsEknrsWX/agKqX/Z4QBt1196NDdRJ3Ry31HXgH8agf6oT0S3Hv7GAj+Fg54RxdT3dK0Unkoicw+QgLL0jQw49sUVsNBVk0LGeZwFYyZkaYhO5BUhQ/Q8QDQA4Os7higa9L92nIFePpsQwIZldSPqDF++sbnR0iH8jr4UDe1ay5FUMZC30Q2OwjnXs663qy890EZAqEFnOsvNGUAL/ImZc/3WGDvxI5nPt08w070+zOx6+fYo7JoCfXNzpJG3FuyHwBmA2uiNlm0waL7I8ekv87QF0kUCUIjIX/gemNiQ92oCPAF3HujyFPjMVkwbH2jhqVVA2GYD3pNvHn0+9rmKzBmcN4FHr0vO24khyC07G2dUZD5StIFZx4iaLv7Lf27r0du2HyrEVEanOdxn+/TtC3w06j5i8Vnvn/ntm5GdgEk87wYHeBtXkthnM70agZq/lW02cpgn9VyhJLpW0D+lGuMP7lMZ1IsjNJjai0Q712E6ms9anHw61xxxTc7nFNY98kkxyhxYd9qZl8mOsV50FvMMFFl6d+Y/3oAIToVrGm0kmuZw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(4326008)(41300700001)(70206006)(36860700001)(70586007)(34020700004)(316002)(110136005)(8676002)(478600001)(54906003)(83380400001)(16526019)(82740400003)(186003)(5660300002)(2616005)(82310400005)(426003)(86362001)(47076005)(36756003)(336012)(107886003)(966005)(2906002)(6666004)(1076003)(26005)(8936002)(356005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 21:24:09.4441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b0df93-b38e-4312-0298-08db309bef53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095
Subject: [virtio-dev] [PATCH v10 4/8] transport-mmio: Refer to the vq by its number

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

