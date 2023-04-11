Return-Path: <virtio-dev-return-12152-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8B5C7619A
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 20:17:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0D159676F3
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 20:17:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F28A69865FD
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 20:17:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E6BA1986193; Tue, 11 Apr 2023 20:17:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D1FEC9864B3;
	Tue, 11 Apr 2023 20:17:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/RHG0P8JbeVS76bM7iew+4VF0XMAtISeH4SBveK0qVqD7cZV2aYA2qsu1UWP0gHv4WGLAhqRsDeK+ffEz/PQwUsel+8P/GS7DrZFVdGfqsd89iiXMlVhMZbBVhzAKhnHM285Nje+unE6T5rSvvTmtA4QVzAhZPIwKp4WHA5RhPcIP3+xikG4xRLeOBbtZSJ3r1F6ggJRs0XGV2t2zpgVhaFF85cz28QJVhQMnTQ/5ZkcXEEjP30Jm03GJnDr6y5BLIfvbk5+vxN8LnBrz1ZonsjNZiUL55DjsiNem0D4FXobVdfy6UqlUvh8nPZWbjJ1tNvhXtRgqLmF6NQcrskxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIdn1MuF/oNFR5yGZueg76nPW9g2RzzXnjfHsFtNNPU=;
 b=CpPv8N+Gr4ueReHgL61sbcu18rSILyImgF7rocxUot1nrfEDy8s4/csyDgcIlLPXv0ZqrsRYUkCipU7r0ynVMnl+3EBUpaBhzjcHyDcUk+aUoybnr4p4jlnZp676/DykZC0mp14mjNawGBwuem4tBWNIrektLLquy/f9Bh2MWTOAw7qOX/ig2krG4JSpcohek/AyHwl305dWv6Y7opROi8Z1PBMsaC4DCI4f4isDoSoFdvzTvoARQrla/ixxIzXNnYB3upSbzjt6upMpvq6eEx03y64GsCAGt7IgP1LEGhh+X+3/YYlzTUQTArT9XpJGYI/ijhv+bOgrAdChvHGN8g==
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
	<parav@nvidia.com>
Date: Tue, 11 Apr 2023 23:16:47 +0300
Message-ID: <20230411201647.753327-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 397327bf-0e21-425f-aeae-08db3ac9b6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+l3/kraPwmXbFolIIV+PgOHz2d2y0cr5t6bqZRwpHW8nMejVi6Hs7qkkUBcdjREQlD/iDZk85xpbKQoB8Zs1TeO/YQsYWTVLuU8cYruc+5XEcqEVy9IwglonRG/p9iuoUIppvi/RlVOL90Cl9AQzsWVOER5tymyXXRZKFarpEHDIqNxFBJBXhQlhrNYft8Q84qHXEBvmS+HpAW5r12kMsQ1EwfPb+2f92E4UXYkZzTM5sK79yKwQedXJ6mLSQad4xGGNBNIVAc4OMJ1qELirYo2lY2GOOAzvtOXBiaQ/Xkx9kHlJz0Ug2TlxM+MuMwwzEpSpFmzJAsvgelF/IgvZ0NeNlBMr2gLYaGpmfVXXwrs81d+nFBMEGfqCrtGshdtOws/6umrCiRdbS7+Iuze8dBS9rBahc4H0BT1NPF9Xz0fRzJ/0i/bXgC9LBtoM8mMYBFx1w77p3aoiqrJruuD+ZkQOVZvQaDRT4hOrHcP+a1Qbb+5rF+NHyCPqOkhUf9paa8RaINIMOGspu/StJarOW1GZeCJEzJF+Ippfk2Fx2gNgRbvts82FR8ndGnvDvWf3PeXejOSiZhbiSIx2m/m3hcfOabQSBINWH4s9xYZ52qJNIq+Z8J91ziO+5t8ckKH737wHnzLqTOJ10LDQMYIEHDx13/E77XsJvnPTX0+5f5YkTgVuZEyWatclOf+YLHSgZwwe57aIKx6ep9VTEICEtMpNdSYoGhog/1YaVYAUkwqXGd7Jbj7mRfHqhUPsm0nmWGI1ZBjlcS0zo1Bb3TKG0yy3RLb3cpMGQHPfqs/Y7gm7FnK4155AvnBxRiKhL7VeLaqnpb0akpvOOF+mBI/poQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(478600001)(54906003)(70586007)(316002)(110136005)(36756003)(70206006)(5660300002)(40460700003)(8676002)(8936002)(4326008)(2616005)(41300700001)(2906002)(86362001)(966005)(82310400005)(6666004)(186003)(107886003)(82740400003)(36860700001)(16526019)(47076005)(83380400001)(34070700002)(26005)(426003)(1076003)(356005)(7636003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 20:17:03.4017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 397327bf-0e21-425f-aeae-08db3ac9b6f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517
Subject: [virtio-dev] [PATCH] transport-mmio: Replace virtual queue with virtqueue

Basic facilities define the virtqueue construct for device <-> driver
communication.

PCI transport and individual devices description also refers to it as
virtqueue.

MMIO refers to it as 'virtual queue'.

Align MMIO transport description to call such object a virtqueue.

This patch is on top of [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202304/msg00253.html
Signed-off-by: Parav Pandit <parav@nvidia.com>
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

