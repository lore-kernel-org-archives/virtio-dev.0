Return-Path: <virtio-dev-return-12465-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31319C77B61
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:20:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2A90326D0
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:20:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EFEC1986765
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:20:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9340698689C; Fri, 28 Apr 2023 04:20:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CDC9C986687;
	Fri, 28 Apr 2023 04:20:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNpr5+xmN3yWAZSJDwdK2tYhXAUlLoMwDDsSSilS2aLuiU87vEc1PmbZllVrXU3ZrzoE9NDlSqLbBkLUW/6cTgVAQK2iFQQdFFIAMrzGwQhrODjbED3QqXJSe0EME+jACUgYJ0Cu1AoeuicwTRyeKxmOGT0YsUeADsDaimU9WBPd7z54Xsz687jEoeteCqx3H5le1P0iPbgB9cuDCYG/W8n9tVMS/HCcWu8R9EwPCQRcNr4f5XOWsz0i+PVYlvGE4iaTMNjAGqj6fpsPJQ6dRQ/Zf+Dqn4Kb8ZALcGdYyqycWMH4wfyHCenLdviTYaC/tpTMjZgn05i44le7nZihEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yc4ciJ9rEsOliBQ50YL5qcYtpRlEQPs2r9jf79JtoIE=;
 b=QhBasOBaqKFHTJ3gnJNc5EQ6mmocyJC5dv+bIUsTYd660HDKWtI+qCA057VcxjBBRf4Zznyy2Jgd1xI4LDNbhCyJGRgD3rKH5MHQwkCC4AVGl/nl5BKN53H+hk1CiyYB1oOz6XDV7rb/EBXiovBdI4LGQ5awCaXRdvER3eKQhYmsZM3+wPl+ofMtpInvOHjEj16n+Lg8ZnviagvapHzaaUtQNwUDrT+J27G20/MeJ9MhFU4y5m07IaPtDGDxpT8S5Z65GSRz2BbrrFdN2DnqW2R+cqMEHiGGdnCVPKQQD8VxQXDdIAYqBo+aBwfG6SjcFGpaNhpPMXRzfutzJYP7fQ==
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
CC: <sgarzare@redhat.com>, <pasic@linux.ibm.com>,
	<virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Date: Fri, 28 Apr 2023 07:19:43 +0300
Message-ID: <20230428041949.411221-6-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230428041949.411221-1-parav@nvidia.com>
References: <20230428041949.411221-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: b7902ed4-c77d-43cb-7e04-08db479fe0b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FJPBKqPVUb7rtUCwAg44vl7s+KpuSzWuVVFun6tsnUNUTtp2BhMsF+EOqV/i4AUkoOh6vgqTTdkAg6rIsdzaQJhcqVCdTbVDAto4VFo8c9LBRzxEF8HZF1eIAZGsqgvN7ctLUGhlLIp8WJ2wlEb1ZPTZQBM2b+AxBjTEwakXT9Jy3qhVE2QLmANCdBf/yCYgSj/ObgNYPQyp48vZBnu4yxLFPiRHVHZCL/EBDPE/ugV0QBHvWOlNojfHfzzCFyrjwUv11MUIpRDyWBkEYnSHEP2GF7Li/l2DJVyuroLs3AU0NXHDK7v+buuU26BAY3GclDD/ahYaqgYO7fsqYbA+Ph2xXAF6HfpLAjgRDzS0ojsy1t1+z9F9VFR9qzF33KKrduXMvPCO9QLl5EtnCqtQe5+qEpn/u+jskPqVNcX4iufZYQbo/J7rg+7deMEd1npRx1dBL2vXc2L4B2GVI13wb6JjbXNBKi/YorAkLBR3oTwxc21hJrZz1Q69EXhKOHlHPbUXT9XhNtMDTF8iFuBQ8wxmD5bxZuFQfuZmhRgrE851taXaDDWrHhtw7C9bhrYXj2D3jNMqDeX7GKDdcLkXSFXQnfZauiCyUuGOvByo0RukGC8brAu8nSYXIg2oACO69pbCUHYBRgF5trvrDc4x7yZ03p6Ca6Y2XuGQpC1Yf+ffWjb7cDfFvFxrCav4KCRtKPdZierKBOGfz9EU65hUbxHoo7QyFu2zHf700outhYRNHRVAAWhTUpbTUbEj395HpJidwoXMjGpkIzmV4pko4g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(7636003)(40460700003)(5660300002)(2906002)(8936002)(8676002)(36756003)(82310400005)(86362001)(1076003)(40480700001)(6666004)(107886003)(26005)(54906003)(34020700004)(966005)(478600001)(36860700001)(2616005)(83380400001)(47076005)(426003)(336012)(186003)(16526019)(70586007)(70206006)(356005)(316002)(82740400003)(110136005)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 04:20:19.6273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7902ed4-c77d-43cb-7e04-08db479fe0b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
Subject: [virtio-dev] [PATCH v15 05/11] transport-mmio: Rename QueueNum register

These are further named differently between pci and mmio transport.
PCI transport indicates queue size as queue_size.

To bring consistency between pci and mmio transport,
rename the QueueNumMax and QueueNum
registers to QueueSizeMax and QueueSize respectively.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v8->v9:
- added field tag to indicate field name instead of English word
v0->v1:
- replaced references of QueueNumMax to QueueSizeMax
- replaced references of QueueNum to QueueSize
- added note for renamed fields old name suggested by @Michael Tsirkin
---
 transport-mmio.tex | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/transport-mmio.tex b/transport-mmio.tex
index f884a2c..164e640 100644
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
+    \field{QueueSizeMax} was previously known as \field{QueueNumMax}.
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
+    \field{QueueSize} was previously known as \field{QueueNum}.
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
+    \field{QueueSizeMax} was previously known as \field{QueueNumMax}.
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
+    \field{QueueSize} was previously known as \field{QueueNum}.
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

