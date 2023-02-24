Return-Path: <virtio-dev-return-11268-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CAEC6FA8E
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:28:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DE98C2CAD2
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:27:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D0D3D9867BA
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:27:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C5E2798668B; Fri, 24 Feb 2023 22:27:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B396D98679B;
	Fri, 24 Feb 2023 22:27:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MM3JtJKK8vH3uHbyYI0/qCSqg5X86WY0DlkJkJqKG0Tu4HsOu7W7aNG/deaw72ZTrO0cCThk1cGGFLFQvvYTewX6wtpRUhZNpXhbzAw0na8KfzsgrB0QR3wuTLRsEVyUZEReBfpeIQXPrY/ngkSkuKvlTE/9XGDpzX/phZM8z9dEsKv+VqEc9/8Aea6GhlOn/KKBMG4SgRLdIk01LDvpdhT1Ex9WjZ85mzql+J+rcwm2+4SNF+VEnhsw2OGF+TfOJHbRQC12hIkcWAyzh3kcJv2/NxbbqiWWI9XWQcj2Rl3LK6/7+T+J9R9s/4fZdpwaErwyLUUhcYcjR7AFxIZs6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZ6b5/UhZ5aIGm4C7Uf2R3YF2jy6iT1eBVDRnTQBuI0=;
 b=LrEfBvIZXKJYeM+UI+ZXaACn1mvI3HpEd3mntD0Xe7NPTQsmVAVQxcHSlKKtChoyml/QWEzFvC4mnHbF86duminc8CXsSS7L5MrRlPuPnlTtkhpkfr0UAN94SZZy1cnuZcSSMKrrtj0vfItdlKLiaAr/mh4o091CxaUKHqqutXw18NxsOTV+xqwa9Ij+JEGVzU3LHfJznDh87gsfdYuiGvO2qeTS6+Xxj51MEcv9KsOOWVd0FY5IthURarakiwUO9xi/95vuAaXlDHT2jvC/dum45HfSevyZPKi7SdrQ6GpT4iy+uvGrYLM23PMarD6AKYpIlGB7L3dlILLTqGfRYA==
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
	<parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Date: Sat, 25 Feb 2023 00:27:18 +0200
Message-ID: <20230224222718.339883-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230224222718.339883-1-parav@nvidia.com>
References: <20230224222718.339883-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|CH3PR12MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bce97f9-93f2-47de-c3f0-08db16b65b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RyfPOTP/ZbYc6r/RuOYvoCWGkE6xBcVkIXxziHyEC8onF+rmGETkLuiqb8IoqVCjF2BVDvz8yVLnFWxnLXQOvxvjEFJeU1547Gui8vqCDlrMU3RkefLKX685tIrD8gXfRdnUYxO5RZcGE+YgZBjDS+8Oc+D8ok+7XMljVpiQc36t4t1npKli0cVGn73r0IqVO6vkDpsskmbyDYxXg8dxhDNuZf4I1c5yzPverkbhQ0ptgHYrm3WA6cDjcuhpTRJ3acp5fF7++HO4GeG9wzvh7XukPEjlIxDQtyIquL+tIXYWaSqV3xKwWtMMjXwD3UtsCNHmCDvio/TFpKe+TdKyC8djRrsAFZ9o3MuOFijiAvMsG4c9r7zfVgkNk/HlbfO+gvJB1Txi3jK1/dkssVL35eviMHoHkOTOfx4x79JEDPpj8Azp8iqOFRLrnOZ/0IXseIASa83yv0xluhy/p4+M1bK4zYkTCcbZpkOBFZmNrs6krnPlrofpLDAugam/rllhCm+PIESeidGS+sk4BrTwj5sQCT37a4b1VOEPYVZjJhlGQku23Z6Pzn5hIJwbJMIB2Ygd3poSIJao3/AFUT3d5oyOk3hAKJbT82b80qdRXtX8mcuSJ0rkAP/54IsEEPBPFa9PgP4i2WUo1NEB6Bol0sYxqwWDJMkXaGaoROQ3P6yZxzoQK1WG22SfEI04AMTBzA9JUNsJoZonNh45IpzCdcB2UyOjNMDP+EQjMBQbxtpWAblaJKpiVr+4CJKGUjqrKHv6/LxscDgG+7JRC25eQTuzu3dDKcULZKaXFsMbvRDn7pSf1BtNE978tKBFdQqf
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199018)(46966006)(36840700001)(40470700004)(966005)(83380400001)(110136005)(8936002)(5660300002)(36756003)(40480700001)(70206006)(70586007)(86362001)(2616005)(336012)(4326008)(54906003)(316002)(41300700001)(47076005)(478600001)(426003)(8676002)(82310400005)(186003)(16526019)(26005)(356005)(40460700003)(34020700004)(7636003)(82740400003)(6666004)(107886003)(36860700001)(1076003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 22:27:47.6640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bce97f9-93f2-47de-c3f0-08db16b65b89
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8711
Subject: [virtio-dev] [PATCH v1 3/3] transport-mmio: Refer to the vq by its number
Message-ID: <20230224222718.iRm8DAbBLn0lYuq58AtYv1w8JHn1l_OjOvD8Yp0wW6w@z>

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

This patch is on top of [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-mmio.tex | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/transport-mmio.tex b/transport-mmio.tex
index 1bcc194..7181d3e 100644
--- a/transport-mmio.tex
+++ b/transport-mmio.tex
@@ -108,7 +108,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     bits accessible by writing to \field{DriverFeatures}.
   }
   \hline
-  \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
+  \mmioreg{QueueSel}{Virtual queue number}{0x030}{W}{%
     Writing to this register selects the virtual queue that the
     following operations on \field{QueueNumMax}, \field{QueueNum}, \field{QueueReady},
     \field{QueueDescLow}, \field{QueueDescHigh}, \field{QueueDriverlLow}, \field{QueueDriverHigh},
@@ -142,7 +142,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     there are new buffers to process in a queue.
 
     When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
-    the value written is the queue index.
+    the value written is the queue number.
 
     When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
     the \field{Notification data} value has the following format:
@@ -385,7 +385,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 the driver sends an available buffer notification to the device by writing
-the 16-bit virtqueue index
+the 16-bit virtqueue number
 of the queue to be notified to \field{QueueNotify}.
 
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
@@ -463,7 +463,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
     (see QueuePFN).
   }
   \hline
-  \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
+  \mmioreg{QueueSel}{Virtual queue number}{0x030}{W}{%
     Writing to this register selects the virtual queue that the
     following operations on the \field{QueueNumMax}, \field{QueueNum}, \field{QueueAlign}
     and \field{QueuePFN} registers apply to. The index
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

