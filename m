Return-Path: <virtio-dev-return-12657-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BD0C77B7F
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 16:31:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C416371C97
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 16:31:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B9A3E986649
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 16:31:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AD1029865E1; Thu, 11 May 2023 16:31:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 929069865E3;
	Thu, 11 May 2023 16:30:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLy0Kv+bGEoVEnPKk+31iO5Cr14RwrUFkBWe5ShNdZQ7ecyXppfL66gu93EI6IW7Wh0IEX6lrmmuvGSNxgs9iRylyuTf+xX37UN/gVaFKb8YVqbqVMd/to1NIiwqfVdulaQJmhCgfy7EhS+R8KxJ777aTsDxsv6ngbyikDcuC3/awoNXnJ+wM5IjjiSfylcXisr9LaCN6lXESeSY5zAxw0ubDbcGIE2nyJtfJk/UQJVqLu9AUO8XYgnOUAOXO60RszxBzl3k5e8E01AKDWMkN26e1MxLocReRUkmwdrv+KjK2SyTLFykNP6HlPEor/73R1f/+8QKAtnMYA2rUf5PWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIvDkkNdMmMNkEnDTfGksySBAK8k6Dk6zz3taNfLpP8=;
 b=QkEmIIqnGQMsThs3W6+rcUJXssWu5/UUGTA2cicUp9Ux7H6mu0hhKc+aMqCaZTZ5i4IZvKNEq8256HymYfgXQwiptHd/Djcm62AWvUQBBGkx7o5d0NXHVDI6wraV2lPjwMvjQ/RZ18tADUUb/C/nUeVj7UpYXoZ2ujwXIzsyij3uJss56xoDEfbzInAg4nGjtWsusdB5emjYKJvP62K1fxwPBAeSK1FX9NnwVe2a3VxEie9OoSwFUvkMF7DRHYgGRTyJ7o0F8KeZod0uHZJku1tlEplwidpcQcpUbHplymDdEymQ8WT42Yt/OVafHmVkwlUKm3QVQCu2g0MTO7ra2g==
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
Date: Thu, 11 May 2023 19:30:20 +0300
Message-ID: <20230511163020.708427-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|BL0PR12MB5506:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5fc29e-7c4e-46de-2b7b-08db523d15da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dbtpBQPPof89gWqsPFr12JXwaWlrJqVjAloV2fW3xBZ5W5yYjLQUhU0oLviOjh9X/9rESg6/z0vk1SVBGgJx7fZn2ah/qNFn+t1Ci+2QQ9qPf76wXf4C2dmEV6f+nc3q81pAMz9OKWKfvTVPrfNkMmg2V4aZgMLTtz1d6zQnSXmjHA48TdXbYNs6IadlW8JHGWHlnwO/i0P0JYBkPKmLbzkML62cSNnVIE2M6CzyMyaVoVTap+LNtCfzIlAbvmVZDbk7/9BzBlGZNvLbAUyWI+zzfaTs9F3QwHzlLV8VpPL6lLctwITBNvwn1q2f2s5WcWD/P94qDCe/aPPUVPDiixJIks6sFY2Z3ptwop3Ph/OHT8VlNjInT/gkcNMfF03FreCjPUIGQXFcvfjr2j2t92KQi8DVCeKygah4DA8+2dABmCzK5a/CMxT3NlcH03tARkStKGQOpd09isnX+EHxL02l+D5X+KghfaIzlqHWl3UNVS5FhkHKU3OtaIUOyRBeO9cS4Zh0kqGGX/MNVAvzTkU5y7Ndvj30L75pzQzUA/kevbtx75tnDkFAXhU0I/6CPB/w6wjz5f/zgue473B3mtSuQNL4U+Ixjd2svKpMuVwI82hyhzM3KsWt2RlO1v4Tv8k9g8rpTlbFXc+wRpzFJy4B9xncBdHAMfqrFCxhhWqZT5mt/1UncBy22eAHtrhxWySLJtFdZHzL3BdgG0D9fQZB1jKipptnedtc+HWT+Bni1UgA0Zo2nmS16+X4t/7Ft/pArRxdxewLNCUf4zUqfcZ6b97VFyOoC7IPhg96Z29h5GUdkpW/feFqTXyHJOxA
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(966005)(70586007)(70206006)(4326008)(478600001)(316002)(110136005)(54906003)(86362001)(36756003)(336012)(83380400001)(47076005)(186003)(26005)(1076003)(2616005)(16526019)(36860700001)(426003)(41300700001)(8676002)(6666004)(5660300002)(30864003)(2906002)(8936002)(40480700001)(82310400005)(7636003)(82740400003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 16:30:51.4753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5fc29e-7c4e-46de-2b7b-08db523d15da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
Subject: [virtio-dev] [PATCH v2] transport-mmio: Replace virtual queue with virtqueue

Basic facilities define the virtqueue construct for device <-> driver
communication.

PCI transport and individual devices description also refers to it as
virtqueue.

MMIO refers to it as 'virtual queue'.

Align MMIO transport description to call such object a virtqueue.

This patch is on top of [1].


[1] https://lists.oasis-open.org/archives/virtio-comment/202305/msg00101.html

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/168
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v1->v2:
- no change, only rebased on top of [1].

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

