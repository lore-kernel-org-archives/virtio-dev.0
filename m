Return-Path: <virtio-dev-return-11666-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589DDC74A5B
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A45951EDE5
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 99AC3986463
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8D1E898642A; Tue, 21 Mar 2023 04:11:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 36AD0986767;
	Tue, 21 Mar 2023 04:11:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Az2gUoqEHmuTAUnVrXQWwejqzrC5OT2p6zoMJSYfUKynuveCz3wAljfjQ+Io8sZSVjqgJJZfhKHe2VxDLB6Jp79yd3kHEukDrS7JibkMG7iI6Io3juSWsX3rg0nVQijvmNlDVKKqFqNTWFAPQZDlHrSDsrWtueUTUAPWCbalHWZUuIE24O/5D0m5gw/HyvlRlffS0Ll7i1vetiAKWiszB83YyKr0527uy+Y821kHZ5dd6oZMnBkCey+7qvMwibMaNcPiyqN2/dSvDaBFs10BK5SXRBzjA2Jo/qJse2gdHcKvIJGDD4Rh10P0Vc8EoH/9Vu1Hku4xTve5xAyyqolnLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/y2yHD9+eaIc+KixlneYCSkG+JIP/pzXy9DSNAAr7c=;
 b=e/eqfE7itjwoMBwRRHEYSiLHXbPpcNFJD/Z49GaNlnwu4KkCxM9uB3NC0BtNRTRFb1ztzCcaC4VyQWL3KGv9uypug4E5IVDzEH8Ff2NGmFCgdiVD1TwKpje8N7v1rk3DDVHdnQ/EM0aOlb4/yrAiCNK+FfH7qpXJ50lJHfsvhxuhviUkibbNLu+dTP2HY3xtkkPm5mtxkQn7k31wVPvYefxHpylEkbWvfFXGBgMFxEa5Ch4e0pDp90NMUea0ly6/PNeYb1ScDRJL46Ym10g9HaxD5cY+kmV4ASryZcXbqj1c4UPKaLGVJ2FdjBRH88rlYLwEZiaedKU/CL//p7dxoA==
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
Date: Tue, 21 Mar 2023 06:10:31 +0200
Message-ID: <20230321041036.201439-3-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|CY5PR12MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f81ebb-1e31-4eed-b93e-08db29c24b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FPdq/qSViY+FWrWzJwSSt7HXICdoO+t/kXDtqk//H27kTHnoxNS+5wIWG/crdu/WtEv2hWFw56Oenjr0kolAiQVcsVENFSUXxHhnUIwj80LcEE34Am/pnWZ6DYRu1cHDk00ggQi/xrBUk1gPu74qZ2ww7pZnvKoqwekByH7Hc2bSSJlQ6yzlUcQngZ8CvxBCLTLQJ2q120batXz2gLTIZQeiM5D9ocOA7u3j1eF2X25hXvBeyV73pqbXpQzwwoLU09ZQ4P97IpGRuLo6gO4fmQ3sKCcaBAkopl+fA34mXhx6yUFSylS7pDokNgcQ7EooHJB0M78m0YuH2OEKWstdGxZXQYXNMyuvwf4/87v0Me0BD17wJAlZSWyKP74lEmA6eBioXjKPX8P62M2Ml/UA93BSFVR5lZp90PVzTqTZpXV/qBG+7Se5d/XY7uUTMHR2UnhalbKMwcFDzPJa5pEXhpNOdTriYV1YohHCye0MZjDnsTyzkCq8fvmWTo/9i14FiAUHPhGXL90ZCyXnRiYQb3kW4NN2fPWtToU5lS2ioGo7/sLUGVGNrkvN1ddOPAkBhzFcViaNEDr53PqJeHIoZkoDdcibauTea1DPNt6zOuGS8YkokFEc+gfXjX1PvWU/S87Ityok0ejIobYyZYKKebTXNbTyOlmYQKCfqtABy8FEKeTe2/SMCwzIS9TTGqleoE5LTl06l38b6JAl5OCZb22RcUEtMAV11HMdPxRXEuNxC73DyXFrS26kj7ChEi2sTqjnWjCHJdYoiho6gSAxVLjbUeQ1dBgh3G4Dplstw6o=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199018)(40470700004)(36840700001)(46966006)(5660300002)(8936002)(2906002)(41300700001)(107886003)(83380400001)(47076005)(6666004)(4326008)(8676002)(110136005)(70206006)(16526019)(26005)(54906003)(316002)(966005)(70586007)(40460700003)(1076003)(36756003)(86362001)(478600001)(82310400005)(186003)(426003)(40480700001)(2616005)(336012)(7636003)(356005)(82740400003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 04:11:06.0570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f81ebb-1e31-4eed-b93e-08db29c24b0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479
Subject: [virtio-dev] [PATCH v2 2/7] transport-mmio: Rename QueueNum register

Currently specification uses virtqueue index and number
interchangeably to refer to the virtqueue.

It is better to always refer to it the virtqueue in consistent manner.

Two registers QueueNumMax and QueueNum actually reflects the queue size
or queue depth indicating max and actual number of entries in the queue.

These are further named differently between pci and mmio transport.
PCI transport indicates queue size as queue_size.

To bring consistency between pci and mmio transport, and to avoid
confusion between number and index, rename the QueueNumMax and QueueNum
registers to QueueSizeMax and QueueSize respectively.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v0->v1:
- replaced references of QueueNumMax to QueueSizeMax
- replaced references of QueueNum to QueueSize
- added note for renamed fields old name suggested by @Michael Tsirkin
---
 transport-mmio.tex | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/transport-mmio.tex b/transport-mmio.tex
index f884a2c..3047633 100644
--- a/transport-mmio.tex
+++ b/transport-mmio.tex
@@ -110,24 +110,31 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
   \hline
   \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
     Writing to this register selects the virtual queue that the
-    following operations on \field{QueueNumMax}, \field{QueueNum}, \field{QueueReady},
+    following operations on \field{QueueSizeMax},
+    \field{QueueSize}, \field{QueueReady},
     \field{QueueDescLow}, \field{QueueDescHigh}, \field{QueueDriverlLow}, \field{QueueDriverHigh},
     \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset} apply to. The index
     number of the first queue is zero (0x0).
   }
   \hline
-  \mmioreg{QueueNumMax}{Maximum virtual queue size}{0x034}{R}{%
+  \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
     Reading from the register returns the maximum size (number of
     elements) of the queue the device is ready to process or
     zero (0x0) if the queue is not available. This applies to the
     queue selected by writing to \field{QueueSel}.
+    \begin{note}
+    \field{QueueSizeMax} was previously known as QueueNumMax.
+    \end{note}
   }
   \hline
-  \mmioreg{QueueNum}{Virtual queue size}{0x038}{W}{%
+  \mmioreg{QueueSize}{Virtual queue size}{0x038}{W}{%
     Queue size is the number of elements in the queue.
     Writing to this register notifies the device what size of the
     queue the driver will use. This applies to the queue selected by
     writing to \field{QueueSel}.
+    \begin{note}
+    \field{QueueSize} was previously known as QueueNum.
+    \end{note}
   }
   \hline
   \mmioreg{QueueReady}{Virtual queue ready bit}{0x044}{RW}{%
@@ -308,11 +315,11 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
 
 Before writing to the \field{DriverFeatures} register, the driver MUST write a value to the \field{DriverFeaturesSel} register.
 
-The driver MUST write a value to \field{QueueNum} which is less than
-or equal to the value presented by the device in \field{QueueNumMax}.
+The driver MUST write a value to \field{QueueSize} which is less than
+or equal to the value presented by the device in \field{QueueSizeMax}.
 
 When \field{QueueReady} is not zero, the driver MUST NOT access
-\field{QueueNum}, \field{QueueDescLow}, \field{QueueDescHigh},
+\field{QueueSize}, \field{QueueDescLow}, \field{QueueDescHigh},
 \field{QueueDriverLow}, \field{QueueDriverHigh}, \field{QueueDeviceLow}, \field{QueueDeviceHigh}.
 
 To stop using the queue the driver MUST write zero (0x0) to this
@@ -363,14 +370,14 @@ \subsubsection{Virtqueue Configuration}\label{sec:Virtio Transport Options / Vir
    and expect a returned value of zero (0x0).
 
 \item Read maximum queue size (number of elements) from
-   \field{QueueNumMax}. If the returned value is zero (0x0) the
+   \field{QueueSizeMax}. If the returned value is zero (0x0) the
    queue is not available.
 
 \item Allocate and zero the queue memory, making sure the memory
    is physically contiguous.
 
 \item Notify the device about the queue size by writing the size to
-   \field{QueueNum}.
+   \field{QueueSize}.
 
 \item Write physical addresses of the queue's Descriptor Area,
    Driver Area and Device Area to (respectively) the
@@ -465,25 +472,32 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
   \hline
   \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
     Writing to this register selects the virtual queue that the
-    following operations on the \field{QueueNumMax}, \field{QueueNum}, \field{QueueAlign}
+    following operations on the \field{QueueSizeMax},
+    \field{QueueSize}, \field{QueueAlign}
     and \field{QueuePFN} registers apply to. The index
     number of the first queue is zero (0x0).
 .
   }
   \hline
-  \mmioreg{QueueNumMax}{Maximum virtual queue size}{0x034}{R}{%
+  \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
     Reading from the register returns the maximum size of the queue
     the device is ready to process or zero (0x0) if the queue is not
     available. This applies to the queue selected by writing to
     \field{QueueSel} and is allowed only when \field{QueuePFN} is set to zero
     (0x0), so when the queue is not actively used.
+    \begin{note}
+    \field{QueueSizeMax} was previously known as QueueNumMax.
+    \end{note}
   }
   \hline
-  \mmioreg{QueueNum}{Virtual queue size}{0x038}{W}{%
+  \mmioreg{QueueSize}{Virtual queue size}{0x038}{W}{%
     Queue size is the number of elements in the queue.
     Writing to this register notifies the device what size of the
     queue the driver will use. This applies to the queue selected by
     writing to \field{QueueSel}.
+    \begin{note}
+    \field{QueueSize} was previously known as QueueNum.
+    \end{note}
   }
   \hline
   \mmioreg{QueueAlign}{Used Ring alignment in the virtual queue}{0x03c}{W}{%
@@ -543,16 +557,16 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
    expecting a returned value of zero (0x0).
 
 \item Read maximum queue size (number of elements) from
-   \field{QueueNumMax}. If the returned value is zero (0x0) the
+   \field{QueueSizeMax}. If the returned value is zero (0x0) the
    queue is not available.
 
 \item Allocate and zero the queue pages in contiguous virtual
    memory, aligning the Used Ring to an optimal boundary (usually
    page size). The driver should choose a queue size smaller than or
-   equal to \field{QueueNumMax}.
+   equal to \field{QueueSizeMax}.
 
 \item Notify the device about the queue size by writing the size to
-   \field{QueueNum}.
+   \field{QueueSize}.
 
 \item Notify the device about the used alignment by writing its value
    in bytes to \field{QueueAlign}.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

