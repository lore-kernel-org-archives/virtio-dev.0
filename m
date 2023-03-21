Return-Path: <virtio-dev-return-11661-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB653C74A5B
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F2F21B85
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9FB8998659A
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EC86998660F; Tue, 21 Mar 2023 04:11:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B5C198644B;
	Tue, 21 Mar 2023 04:11:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpLpE8huWLU11/pGGfsVGrHGMelGJGS60SOLETL1I1AQr/Grpf6W+DjYII+0uDoaKX95G5fZlQ5YcSsneboijoQVGBDMKB4QBePtP4nywvh7hXNGXIJTS8nwrLtIMOL+ldXSyJlxRZn/O80VxXcSdAHRY2Otc5Rp0iEBP59Yr4d838iRGMq/QXhQpeBsW6MeuVuhpQwpYvTs8pEZI4fOVjGZag8OcyMehz0IIjlRkEUCbljPF+kTzYdyeHlNRalNiJHYLAZl5iWxk3l4xjHIpM+KhuKW0H/jlhM2OCFOKV531CQzjGBrBd3lSScXHyYSBB4jTeo802yNippyOkcWfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=endzE8e8srqAsOtj09NhPJXNKyARwdFDkFMFOJLw3oc=;
 b=Fo9aZRWlK7oaVY2wP/S4xYDw9MA2H0ryIQVvVcsdYsytcpbl4EDwJqGgFRYMlulfFhywd8KdF/JRDOxRexUeC48YNZJc727hlwh0NIPlbGhyqVkSCdoTSPQuJKWh7SDSfuGSr3SuTohyRia/AbiJ3Srjs4srDSFAsMF7dct9Ruh/pgE7Bu0U16iPKYIFxdleGl8kt55TsM4L/Y1GZDuNYXfnyIGW2lCy2IcHrzxfbLO4v048wJVq5fF6DRFgj7JJ8s7UTbc7yr3l7H/7cWFLFYs2GjcTkPtHf7J0EABCIqK/IItAN4FrPffYp0bMXplKDUpSS7jLYggJPdtGfrGMOw==
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
Date: Tue, 21 Mar 2023 06:10:32 +0200
Message-ID: <20230321041036.201439-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230321041036.201439-1-parav@nvidia.com>
References: <20230321041036.201439-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT010:EE_|BL1PR12MB5143:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d45f7f-1f74-4fc7-dc8f-08db29c24af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V9snGCmL89FSgIGbshp02LHmpVAhm72zXWHaDWstkAJxRbzD9YYIQ9f4klcL8sI3wBYWfTu2Ux6bnpZ5n9nG0fzlyPwqeMUqZI8XY9DP/iVbdd+x63QtJDEWzNj71jA3+mriZ4ASzZgEr6cZ76hOroxUfdGKYE+IeEhn/cjNdK5AKNqQsm6TpH27NUUN5cVVZwSwrSF7dWIaTJmta221fZIyChubZwbSaVpg7e6s0hLdC9Y8zfZhdeVH9XQhAWZMktX3RJTCcx+gMyZp013zob3kD+63nm2S+nrTBvaVmyCbgFcJccpIlqoL5u4y3GDFmWplPG3rM/MtNq92Mc4bqSgxgcXpwaakEVl4h479Goi56tC3WUtyeEp9P+pxHpYYWzijIA8boK2qfyg6J8tmsGxRmhHprzjpsyBn1EiGIYlrTT7lau+4Kukb5u4gq0uPWJzAAPUd6RQGRIlSgQOLdZTVqGEl6aFkErj5xsS7XtPjPzVvfNwt8NfEUYWoWa/lngY5JLNJg/NgUuUdxuzsR11lZmax8URYaRyCpXzpVB0kndjhrpEUB9CeDyWmyTuRr91ebiKz3dpiDFBiHjR+x/o/j9L0On2VI3YdMdMPjdcPlVjzSQFaWhp2Y4SgxhU2GwlueLDqvTsmcZ0r4RW5L15LHwba0dS5VyThKiNiXJScaEyEzebYK/KT6HMnjnu1op1z5KAVDLIiqoXXYELW2bvmp4mHrQcAlAhlA3yiCKxmltL2BE4H9fT1ACMiKf8TeoGQ0KQmBSyEe1bGPJSt8y2oXOOWVFn7ApnzqiUINr0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(8936002)(41300700001)(5660300002)(36860700001)(356005)(82310400005)(40480700001)(86362001)(40460700003)(7636003)(82740400003)(36756003)(2906002)(4326008)(47076005)(426003)(966005)(336012)(83380400001)(478600001)(6666004)(107886003)(16526019)(2616005)(186003)(26005)(54906003)(1076003)(110136005)(316002)(8676002)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 04:11:05.9918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d45f7f-1f74-4fc7-dc8f-08db29c24af4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5143
Subject: [virtio-dev] [PATCH v2 3/7] transport-mmio: Refer to the vq by its number

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

