Return-Path: <virtio-dev-return-12302-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A10C6FD18
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:57:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 58E8A3243
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:57:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 51797986638
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:57:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4801D986613; Wed, 19 Apr 2023 01:57:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 357EB986411;
	Wed, 19 Apr 2023 01:57:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alLOB1yoLBKxmXemTU8NUWtzWn9pRY514cRwy3CqbjFgJ/2+siVROpncAweWh5nCeF9SZq0SHQ7tmIxT9MR1bQczR0jY0g5yYnB6IH03rf83cTFM+fcZT2lZR3LwkB0X+S0RIeutc7LYOaoPc4pP1fN00OAFFE6+gCp7ZtybEsedpywnJ6Tr++7o7Ij91CJNY92cYTbCd/666FqaDL2Gh+L9ghstbwdebRxiTR+eF1kIA9ElDPpaMtvB8AoOXY/v7pnKCEC8OYLaV3NC9XlmsLiXWVqjcFTFDvHtM39XEAR84ferdkt0b831rGEpxoBwjELgr5J7IUvKPYl68WOHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdsCtcG/CXMfT6VfaJ4dhB17AsR0lfFRtt7R7kRgp54=;
 b=LE7QOmibyA2rsSl9uRk4Vl6mf2q9DNW0YWtVN7+n+B//cD80Yn7DrvEdY1Yk7Shpidv9Bl3tnaQEgbQb/7PuHSWg1D9HgxnPhHB7jpoK4joJBgvnqXgfr7NUomCb+uMlGwr63lytubc2Trx2trCwTPK/SHlM32KCY79JHukkEEsxGf0/5eHRqexi468N3RjVL4Vrty5INJ+1//Y1Hz4/jO28bkjprM0TuXUqin7KJuTcFQDA0NNYcIZe5VDamvtrBFBgmiIbNjH14Y+zzPsMF/iQ0LssIF9lFYZgZEWyPufHXqX3hH4jDpwJGQ/KJ61hki98rTBtrv9j7ri8pU6RIQ==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 19 Apr 2023 04:56:38 +0300
Message-ID: <20230419015638.919627-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|PH0PR12MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e587b05-a12d-4244-4a3a-08db40795e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jij6cwlQEs7nzNERIlouYNdmudiulAKGfKrgdDclasHLaNrLyzYVSUiNOcSdt7/hm6CffnBkY2pVWfArIsBMWsjICXfvkbyN/T2qfp7QlaXbVkBHnC4jySGpV50OXyOFNgmMBQ1yWwJKI5cJw6e5Bp5mGExBihFR+kz+Fh0vMYvdnR2cOyhtP9aYjPmo+3JhMyE9zpNRQeMk1OZa/gPJFNiuWacGOguPAfpK1kQjEwfVfWQ5AQpGrMvCSf8B/3lI75piKfphBraYSXC9VxMVwgdyzKj9+dGJFq8JXdF6PdBcXPQJ+xkzxP4j3HFXCBhS0IC7igUjyL+oCh1VlTNHe++qiQL7Ism8MFBIyZPjL35GT2hC0WIzvpr3X7XBklB4tJIZKPdyhRmXrMoBU54D6jzSYDFOoxaOk5vSrL35r19CkIth5UMOKcyZnCqenCVa4Gd7gkUXuJmj6NVuADfsIZkDiuL3hrnLnmNnRC+N6L6ge8a/6o353kDZU/IcJrOw6Sh/W5ZjIqUyZCGcp0GnIaaMKEp5V2c17WNqCIzTqCotbCuchPkDhXr2ujQFu3IaLMK8XmJqKZfCNlSgMERg3Lqq1RlZ714WLYfTmjdD8VhC+2/BAbYfAmiqCiQm8hEKOhKy2L5vikrS0bMkT6ce+y7bf7qpk+2kQRuGrh1ELyGzdkm1CGWJDxCzOaql75g1RMTVP2w7R/GXrg0OqmQ0RP5TtUm080GCAj5sgOrNN2s6Z1U8V5dVMNKdfgW7TTJxF+AgUag2JnJlFlA5B33RJ8JgWrIX+bvXoJwlEjZiHqXsIIvBHHvXhWREZmucMH/vZn8B8UtZwR1MOy7gHmsw3g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(30864003)(2906002)(34070700002)(2616005)(36860700001)(40460700003)(478600001)(82310400005)(6666004)(966005)(86362001)(1076003)(26005)(36756003)(186003)(16526019)(40480700001)(336012)(426003)(41300700001)(82740400003)(54906003)(7636003)(356005)(8676002)(8936002)(47076005)(4326008)(110136005)(83380400001)(70586007)(70206006)(316002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 01:57:01.6701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e587b05-a12d-4244-4a3a-08db40795e2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8099
Subject: [virtio-dev] [PATCH v1] transport-mmio: Replace virtual queue with virtqueue

Basic facilities define the virtqueue construct for device <-> driver
communication.

PCI transport and individual devices description also refers to it as
virtqueue.

MMIO refers to it as 'virtual queue'.

Align MMIO transport description to call such object a virtqueue.

This patch is on top of [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202304/msg00407.html
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v0->v1:
- rebased
- added Stefan's RB tag
---
 transport-mmio.tex | 50 +++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/transport-mmio.tex b/transport-mmio.tex
index 2d24b4c..f5aaace 100644
--- a/transport-mmio.tex
+++ b/transport-mmio.tex
@@ -108,15 +108,15 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     bits accessible by writing to \field{DriverFeatures}.
   }
   \hline
-  \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
-    Writing to this register selects the virtual queue that the
+  \mmioreg{QueueSel}{Virtqueue index}{0x030}{W}{%
+    Writing to this register selects the virtqueue that the
     following operations on \field{QueueSizeMax},
     \field{QueueSize}, \field{QueueReady},
     \field{QueueDescLow}, \field{QueueDescHigh}, \field{QueueDriverlLow}, \field{QueueDriverHigh},
     \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset} apply to.
   }
   \hline
-  \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
+  \mmioreg{QueueSizeMax}{Maximum virtqueue size}{0x034}{R}{%
     Reading from the register returns the maximum size (number of
     elements) of the queue the device is ready to process or
     zero (0x0) if the queue is not available. This applies to the
@@ -126,7 +126,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     \end{note}
   }
   \hline
-  \mmioreg{QueueSize}{Virtual queue size}{0x038}{W}{%
+  \mmioreg{QueueSize}{Virtqueue size}{0x038}{W}{%
     Queue size is the number of elements in the queue.
     Writing to this register notifies the device what size of the
     queue the driver will use. This applies to the queue selected by
@@ -136,9 +136,9 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     \end{note}
   }
   \hline
-  \mmioreg{QueueReady}{Virtual queue ready bit}{0x044}{RW}{%
+  \mmioreg{QueueReady}{Virtqueue ready bit}{0x044}{RW}{%
     Writing one (0x1) to this register notifies the device that it can
-    execute requests from this virtual queue. Reading from this register
+    execute requests from this virtqueue. Reading from this register
     returns the last value written to it. Both read and write
     accesses apply to the queue selected by writing to \field{QueueSel}.
   }
@@ -166,7 +166,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     \begin{description}
       \item[Used Buffer Notification] - bit 0 - the interrupt was asserted
         because the device has used a buffer
-        in at least one of the active virtual queues.
+        in at least one of the active virtqueues.
       \item [Configuration Change Notification] - bit 1 - the interrupt was
         asserted because the configuration of the device has changed.
     \end{description}
@@ -187,21 +187,21 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     See also p. \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Device Initialization}~\nameref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Device Initialization}.
   }
   \hline
-  \mmiodreg{QueueDescLow}{QueueDescHigh}{Virtual queue's Descriptor Area 64 bit long physical address}{0x080}{0x084}{W}{%
+  \mmiodreg{QueueDescLow}{QueueDescHigh}{Virtqueue's Descriptor Area 64 bit long physical address}{0x080}{0x084}{W}{%
     Writing to these two registers (lower 32 bits of the address
     to \field{QueueDescLow}, higher 32 bits to \field{QueueDescHigh}) notifies
     the device about location of the Descriptor Area of the queue
     selected by writing to \field{QueueSel} register.
   }
   \hline
-  \mmiodreg{QueueDriverLow}{QueueDriverHigh}{Virtual queue's Driver Area 64 bit long physical address}{0x090}{0x094}{W}{%
+  \mmiodreg{QueueDriverLow}{QueueDriverHigh}{Virtqueue's Driver Area 64 bit long physical address}{0x090}{0x094}{W}{%
     Writing to these two registers (lower 32 bits of the address
     to \field{QueueDriverLow}, higher 32 bits to \field{QueueDriverHigh}) notifies
     the device about location of the Driver Area of the queue
     selected by writing to \field{QueueSel}.
   }
   \hline
-  \mmiodreg{QueueDeviceLow}{QueueDeviceHigh}{Virtual queue's Device Area 64 bit long physical address}{0x0a0}{0x0a4}{W}{%
+  \mmiodreg{QueueDeviceLow}{QueueDeviceHigh}{Virtqueue's Device Area 64 bit long physical address}{0x0a0}{0x0a4}{W}{%
     Writing to these two registers (lower 32 bits of the address
     to \field{QueueDeviceLow}, higher 32 bits to \field{QueueDeviceHigh}) notifies
     the device about location of the Device Area of the queue
@@ -235,7 +235,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     0xffffffffffffffff.
   }
   \hline
-  \mmioreg{QueueReset}{Virtual queue reset bit}{0x0c0}{RW}{%
+  \mmioreg{QueueReset}{Virtqueue reset bit}{0x0c0}{RW}{%
     If VIRTIO_F_RING_RESET has been negotiated, writing one (0x1) to this
     register selectively resets the queue. Both read and write accesses
     apply to the queue selected by writing to \field{QueueSel}.
@@ -274,7 +274,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
 The device MUST change value returned in \field{ConfigGeneration} if there is any risk of a
 driver seeing an inconsistent configuration state.
 
-The device MUST NOT access virtual queue contents when \field{QueueReady} is zero (0x0).
+The device MUST NOT access virtqueue contents when \field{QueueReady} is zero (0x0).
 
 If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
 \field{QueueReset} on reset.
@@ -359,7 +359,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 
 \subsubsection{Virtqueue Configuration}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Virtqueue Configuration}
 
-The driver will typically initialize the virtual queue in the following way:
+The driver will typically initialize the virtqueue in the following way:
 
 \begin{enumerate}
 \item Select the queue by writing its index to \field{QueueSel}.
@@ -422,7 +422,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
 
 The legacy MMIO transport used page-based addressing, resulting
 in a slightly different control register layout, the device
-initialization and the virtual queue configuration procedure.
+initialization and the virtqueue configuration procedure.
 
 Table \ref{tab:Virtio Transport Options / Virtio Over MMIO / MMIO Device Legacy Register Layout}
 presents control registers layout, omitting
@@ -468,14 +468,14 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
     (see QueuePFN).
   }
   \hline
-  \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
-    Writing to this register selects the virtual queue that the
+  \mmioreg{QueueSel}{Virtqueue index}{0x030}{W}{%
+    Writing to this register selects the virtqueue that the
     following operations on the \field{QueueSizeMax},
     \field{QueueSize}, \field{QueueAlign}
     and \field{QueuePFN} registers apply to.
   }
   \hline
-  \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
+  \mmioreg{QueueSizeMax}{Maximum virtqueue size}{0x034}{R}{%
     Reading from the register returns the maximum size of the queue
     the device is ready to process or zero (0x0) if the queue is not
     available. This applies to the queue selected by writing to
@@ -486,7 +486,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
     \end{note}
   }
   \hline
-  \mmioreg{QueueSize}{Virtual queue size}{0x038}{W}{%
+  \mmioreg{QueueSize}{Virtqueue size}{0x038}{W}{%
     Queue size is the number of elements in the queue.
     Writing to this register notifies the device what size of the
     queue the driver will use. This applies to the queue selected by
@@ -496,15 +496,15 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
     \end{note}
   }
   \hline
-  \mmioreg{QueueAlign}{Used Ring alignment in the virtual queue}{0x03c}{W}{%
+  \mmioreg{QueueAlign}{Used Ring alignment in the virtqueue}{0x03c}{W}{%
     Writing to this register notifies the device about alignment
     boundary of the Used Ring in bytes. This value should be a power
     of 2 and applies to the queue selected by writing to \field{QueueSel}.
   }
   \hline
-  \mmioreg{QueuePFN}{Guest physical page number of the virtual queue}{0x040}{RW}{%
+  \mmioreg{QueuePFN}{Guest physical page number of the virtqueue}{0x040}{RW}{%
     Writing to this register notifies the device about location of the
-    virtual queue in the Guest's physical address space. This value
+    virtqueue in the Guest's physical address space. This value
     is the index number of a page starting with the queue
     Descriptor Table. Value zero (0x0) means physical address zero
     (0x00000000) and is illegal. When the driver stops using the
@@ -536,15 +536,15 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
   \hline
 \end{longtable}
 
-The virtual queue page size is defined by writing to \field{GuestPageSize},
+The virtqueue page size is defined by writing to \field{GuestPageSize},
 as written by the guest. The driver does this before the
-virtual queues are configured.
+virtqueues are configured.
 
-The virtual queue layout follows
+The virtqueue layout follows
 p. \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout},
 with the alignment defined in \field{QueueAlign}.
 
-The virtual queue is configured as follows:
+The virtqueue is configured as follows:
 \begin{enumerate}
 \item Select the queue by writing its index to \field{QueueSel}.
 
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

