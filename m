Return-Path: <virtio-dev-return-11786-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDA7C76195
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:54:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1F1732AD4B
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:54:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B02EB9864C3
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:54:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 96E6A98658B; Mon, 27 Mar 2023 20:54:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 08A169864B2;
	Mon, 27 Mar 2023 20:54:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiY1nPXDNhqCVDYfwIZf4WFx+im1RvLZbyhpCCDuw03wkYVKkgBG73grM6Z8clNkVWGWJT1S8WGulAt/XZEbd9iyhlZ4ygAdmluzygiRmH2+sxJC/YotKBH0/EYOLLq5dn6ntSXQZg/GbsiOZJCYV8J+JaRi0fRRNspj5VU9tVKpSubuF91MJQq9paR07DFn4toZwDOJuSDWTzpH5y5H6rQ2ebVwtu6kCfJWZ9IRI0ZlLN6X/pfcFvrO0SZxYS3mjM5MM6hUAQF/YmMhGHH5NuK68aBz9FKqdU8lDmzxcMfzwvuHMuClgeRhov+Kj7paraH+n0Ll40zpgJuW0x1ZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DLxeQvDTyhATZ77EhHjxx1JoGgvKDnEg/8v2GLUics=;
 b=PzbuZGV6yrxvUq65iO42Gh7/m78drs2HboW3wKEbdKOb8HP/OqyofEYY6u7c2pd6q3B2XrkklQIe+M2LV87kf9zP1aDMdvIm0ADdvgmNJVu0ZkjG/vIgyJRw/fz8FAeR0p/velgtYe+g9ymq8sTiYf+pgCvzN0E7pyNk6pbvAkn+luzR8YpWKel2epAaxl4d5XEtHOJyFoTzUSSUeafQc7uZipuleQ5Xoh8gzRBY1sK/3S1V5EWiGLXQ2A3P1PLM47bjPT73e+GnVXxupkgCuPVXjBy56yAoFzs+l8YAAVtaWqoNg1GeX6z+Ib6aMJHDMa4oMyp8VxfFoSIkVpOuPQ==
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
Date: Mon, 27 Mar 2023 23:53:55 +0300
Message-ID: <20230327205359.406605-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230327205359.406605-1-parav@nvidia.com>
References: <20230327205359.406605-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E631:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cdb3e11-b2e6-4940-8e0f-08db2f057332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y/IjXMdFaqA8Y4GKTtAzNOpk5xkl2F2HndPfeUC4SnEwhXlPKG8rP4lERnw9abw+vE2UO/8SfWWXVnCpv4VjZR2Riq4PZKKa48N3c5QBZGahDlMPlLVR6j7GaG1HPQdy88nKjJ5BD2B8h1Qd+GV7X+ragvUhRSQG9El2BLwdxrl+dhwDMwe41/1dJADuPi8bYyK3UHgf/ucif2WNF6nx4ZQj152SovzP4F9FpM6i2leb8EZeXxNLnX2jJifxJaB04Y9UQcAQ2XAqVdYPrZ3ZQWmYKrtSosvxgLxN11HTYAiamzOCtCQS/a2eoJu9ahYXGi+dv6Tsge/d7EFPChVKd/S2PCnD4TmbMbkM3DTVR9hJW3f4MpsfpXeCtlbmrgXuPkb4cZS7Qs2/LCIcuZBl4RlQ+b60mmt7dmADR20xEzHG82uCFba3AMAYmAsTLMlYm26XpCGsRraSVEaBDv+YkEnwqCj1JJYkOJpLhUNaYKdGcN5P/3i7Hbe8KfbO8RRxSKCcdCMYO2rKKn+tJqQipPdtzIXXEHaciYnAyR149wVK1jyLlR6EW0rvQXUZd0oF6ubtKIQw9E5y+LzhNsmF9V2kJSGCAwAh8GGWB3WG6uxK49gZWeAaRMiv2o+YkCXAgeECZ8lNoyJ9J0LxkALlH7lOy/RG9nUYzfmheS0S5BuidApdmw3SO9oulWxHfH2MAcigKguDfyV4L2LFhsEbwv1cxaYqvuL5Sdv9bLPpIq0xILwBx0Juxwwkr+cxgyu6KCgedpiycGZ3d02psllHrqAdaQwXK9mMsAn6IMTeEgg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(1076003)(107886003)(356005)(316002)(36860700001)(16526019)(186003)(41300700001)(82740400003)(47076005)(26005)(8936002)(6666004)(426003)(336012)(5660300002)(8676002)(40480700001)(2906002)(7636003)(86362001)(54906003)(70586007)(4326008)(82310400005)(40460700003)(110136005)(70206006)(478600001)(36756003)(83380400001)(2616005)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 20:54:25.5529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdb3e11-b2e6-4940-8e0f-08db2f057332
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0000E631.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431
Subject: [virtio-dev] [PATCH v7 4/8] transport-mmio: Refer to the vq by its number

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

