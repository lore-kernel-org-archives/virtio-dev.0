Return-Path: <virtio-dev-return-11266-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767B4C6FA8E
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:25:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C41A93309B
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:25:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BB85998679B
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:25:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A8E539866A9; Fri, 24 Feb 2023 22:25:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 253E998678D;
	Fri, 24 Feb 2023 22:25:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQnhP0i9fv9IcoWuI9/319H7X+nipp7LzV8MsO3qKIh34Bc3HcBFbPjubz7wg20Bou5BdfhMSHUtsDzdrgffTzh8FE3c0Ob0WBGHNUEHnUq2rzvOJNS3lIN+stIZX0pVHa/osLXWRu21MzdxGHIAlzAr+iICNWkEAbc+nQAkwdw4+tBVOvA5S+NEAU535oQX8Cb/n4v39YNLy3r2tKdJvrN8a17FnZqTLkuAMPLDiHVYcWGTCRuiaxrK4Gm1vjP9BABrhRhOLmOw31mmtR2vEUaULZSIjtDthNkdpv52JK+HVkv+THCHBkxp/fB/ViwDgGlgREHGLDJPx2ktUckG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aj3RIC4hweQQu4+BdG5+Arsd3HMCERNLwCc5oR0DZs=;
 b=Qthmi3MMYPo32Y0hkV3oK9h+WSPwvImr9kHgatRrXjA9JOP/KuGE+I8rWpM/X87CiwsjiAGmcUxPIp/1D1stnbRWq5m9TWYJS7UXb5d0LY+YYocfjvuVg39POPI6jpL/FbSdEVyRSR55bJeYDOJD325rHIrSsH1MuLzOHOY/X73cASCZsVVnyK5V+Voi91p9rBGWMdob/npugebON68Qbo72YFiDtp0egFGODYb/PSPIjdOSscRoj+jB7MFNbEu4cGZ0dNJ56mok10EDe048nEXLkOdEQEnkiGtM8jj6WsXc2n1Wo+ZkVzKWMZoL658TwbV3WdLeNyuiZnUjYFn/fQ==
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
Date: Sat, 25 Feb 2023 00:22:14 +0200
Message-ID: <20230224222215.339715-6-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230224222215.339715-1-parav@nvidia.com>
References: <20230224222215.339715-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT069:EE_|PH8PR12MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a0f674-1182-4d87-32b4-08db16b5a7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x5aCKrEs2yuGAu4womddmzsWTz+1qeMG5XAfPeN5r7ha6LsrGfKrTAM3BqaH9Dcpj6QJsBEshXFpmwf2DnS9ocXx+uNTSPgL2KhvKcYcLjmdTtTW8tN32K9i0dZ5mCoOs3nCPR7mLLgNmJCG/fmBAw91jzt2jV0ICoAzvaC/KkecqSbMjcPhtcdgL0UmpKwSGMDmDBFVXa9iwYoTtf01m4WRYljHu18esTlpEdH5ExVD3pXudrrHnHLj5r2n/LDbKy+Mst5y7vX/Vhhh874esYyX/qYF4kqqxwCqQV5eHc4qvcUKfaAZxq285NB8TOwFMg2Wk0kWp/tLD2REl7jZV44ZY6S5VdPevvmiunm9Pl924//JkKpzhZOmZytqe07b7W+oHZJjJOsVU3n7waJdCzEfrJFaITF6XXB83Oo1faXHd48Q3DV5TT8lrIzAm5TlJfEyN29XHRunsqtRdxkoQfK2BErwG0VXAbk9GVEZbpNbDk+73SgGGBbEdkN2QMh70tzM9e88ZSR82nmrEPKRHneo+oModdVHWbyldz3IicYOfz8bh9v2zz246/qVBq5dsyWxoAco05t26ueFsmf7SMkaBPmEVRRcGgCy5nlW/1DyFAplYrVEKOUEy3KK1lT4/d2/HYC+rdOm5jKhG2VUw+zvkquLrsEKT/P384g4smbtv4ax54fdwimBf3lkJzTiYDuVru7LSt5RDwnI174iK5BkZ6o+q4PzOA56zwDzUoq3UEC5c3/+jtS/v99U483yKHRne23DemqPqxwYs1osQQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199018)(46966006)(36840700001)(40470700004)(316002)(83380400001)(478600001)(54906003)(41300700001)(110136005)(426003)(7636003)(2906002)(82740400003)(82310400005)(86362001)(30864003)(356005)(36756003)(70206006)(8936002)(8676002)(40460700003)(4326008)(47076005)(70586007)(40480700001)(5660300002)(2616005)(966005)(26005)(186003)(36860700001)(1076003)(6666004)(34020700004)(107886003)(16526019)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 22:22:45.8367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a0f674-1182-4d87-32b4-08db16b5a7a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6675
Subject: [virtio-dev] [PATCH v5 5/6] transport-mmio: Fix spellings and white spaces
Message-ID: <20230224222214.3fKNUdVyTJ1n1Xj18kJM4fqGftt_sE9awI2IpYIAhWo@z>

Now that we have individual files, fix reported spelling errors.

While at it, remove trailing white spaces.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/157
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v0->v1:
- removed many trailing white spaces
---
 transport-mmio.tex | 90 +++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/transport-mmio.tex b/transport-mmio.tex
index e12a652..f884a2c 100644
--- a/transport-mmio.tex
+++ b/transport-mmio.tex
@@ -30,7 +30,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
 
 MMIO virtio devices provide a set of memory mapped control
 registers followed by a device-specific configuration space,
-described in the table~\ref{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Register Layout}.
+described in the table~\ref{tab:Virtio Transport Options / Virtio Over MMIO / MMIO Device Register Layout}.
 
 All register values are organized as Little Endian.
 
@@ -44,23 +44,23 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
 
 \begin{longtable}{p{0.2\textwidth}p{0.7\textwidth}}
   \caption {MMIO Device Register Layout}
-  \label{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Register Layout} \\
+  \label{tab:Virtio Transport Options / Virtio Over MMIO / MMIO Device Register Layout} \\
+  \hline
+  \mmioreg{Name}{Function}{Offset from base}{Direction}{Description}
+  \hline
   \hline
-  \mmioreg{Name}{Function}{Offset from base}{Direction}{Description} 
-  \hline 
-  \hline 
   \endfirsthead
   \hline
-  \mmioreg{Name}{Function}{Offset from the base}{Direction}{Description} 
-  \hline 
-  \hline 
+  \mmioreg{Name}{Function}{Offset from the base}{Direction}{Description}
+  \hline
+  \hline
   \endhead
   \endfoot
   \endlastfoot
   \mmioreg{MagicValue}{Magic value}{0x000}{R}{%
     0x74726976
     (a Little Endian equivalent of the ``virt'' string).
-  } 
+  }
   \hline
   \mmioreg{Version}{Device version number}{0x004}{R}{%
     0x2.
@@ -68,7 +68,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
       Legacy devices (see \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}) used 0x1.
     \end{note}
   }
-  \hline 
+  \hline
   \mmioreg{DeviceID}{Virtio Subsystem Device ID}{0x008}{R}{%
     See \ref{sec:Device Types}~\nameref{sec:Device Types} for possible values.
     Value zero (0x0) is used to
@@ -76,9 +76,9 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     well known addresses, assigning functions to them depending
     on user's needs.
   }
-  \hline 
+  \hline
   \mmioreg{VendorID}{Virtio Subsystem Vendor ID}{0x00c}{R}{}
-  \hline 
+  \hline
   \mmioreg{DeviceFeatures}{Flags representing features the device supports}{0x010}{R}{%
     Reading from this register returns 32 consecutive flag bits,
     the least significant bit depending on the last value written to
@@ -88,12 +88,12 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     features bits 32 to 63 if \field{DeviceFeaturesSel} is set to 1.
     Also see \ref{sec:Basic Facilities of a Virtio Device / Feature Bits}~\nameref{sec:Basic Facilities of a Virtio Device / Feature Bits}.
   }
-  \hline 
+  \hline
   \mmioreg{DeviceFeaturesSel}{Device (host) features word selection.}{0x014}{W}{%
     Writing to this register selects a set of 32 device feature bits
     accessible by reading from \field{DeviceFeatures}.
   }
-  \hline 
+  \hline
   \mmioreg{DriverFeatures}{Flags representing device features understood and activated by the driver}{0x020}{W}{%
     Writing to this register sets 32 consecutive flag bits, the least significant
     bit depending on the last value written to \field{DriverFeaturesSel}.
@@ -102,41 +102,41 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     \field{DriverFeaturesSel} is set to 0 and features bits 32 to 63 if
     \field{DriverFeaturesSel} is set to 1. Also see \ref{sec:Basic Facilities of a Virtio Device / Feature Bits}~\nameref{sec:Basic Facilities of a Virtio Device / Feature Bits}.
   }
-  \hline 
+  \hline
   \mmioreg{DriverFeaturesSel}{Activated (guest) features word selection}{0x024}{W}{%
     Writing to this register selects a set of 32 activated feature
     bits accessible by writing to \field{DriverFeatures}.
   }
-  \hline 
+  \hline
   \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
     Writing to this register selects the virtual queue that the
     following operations on \field{QueueNumMax}, \field{QueueNum}, \field{QueueReady},
     \field{QueueDescLow}, \field{QueueDescHigh}, \field{QueueDriverlLow}, \field{QueueDriverHigh},
     \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset} apply to. The index
-    number of the first queue is zero (0x0). 
+    number of the first queue is zero (0x0).
   }
-  \hline 
+  \hline
   \mmioreg{QueueNumMax}{Maximum virtual queue size}{0x034}{R}{%
     Reading from the register returns the maximum size (number of
     elements) of the queue the device is ready to process or
     zero (0x0) if the queue is not available. This applies to the
     queue selected by writing to \field{QueueSel}.
   }
-  \hline 
+  \hline
   \mmioreg{QueueNum}{Virtual queue size}{0x038}{W}{%
     Queue size is the number of elements in the queue.
     Writing to this register notifies the device what size of the
     queue the driver will use. This applies to the queue selected by
     writing to \field{QueueSel}.
   }
-  \hline 
+  \hline
   \mmioreg{QueueReady}{Virtual queue ready bit}{0x044}{RW}{%
     Writing one (0x1) to this register notifies the device that it can
     execute requests from this virtual queue. Reading from this register
     returns the last value written to it. Both read and write
     accesses apply to the queue selected by writing to \field{QueueSel}.
   }
-  \hline 
+  \hline
   \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
     Writing a value to this register notifies the device that
     there are new buffers to process in a queue.
@@ -152,7 +152,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     See \ref{sec:Basic Facilities of a Virtio Device / Driver notifications}~\nameref{sec:Basic Facilities of a Virtio Device / Driver notifications}
     for the definition of the components.
   }
-  \hline 
+  \hline
   \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
     Reading from this register returns a bit mask of events that
     caused the device interrupt to be asserted.
@@ -165,49 +165,49 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
         asserted because the configuration of the device has changed.
     \end{description}
   }
-  \hline 
+  \hline
   \mmioreg{InterruptACK}{Interrupt acknowledge}{0x064}{W}{%
     Writing a value with bits set as defined in \field{InterruptStatus}
     to this register notifies the device that events causing
     the interrupt have been handled.
   }
-  \hline 
+  \hline
   \mmioreg{Status}{Device status}{0x070}{RW}{%
     Reading from this register returns the current device status
     flags.
     Writing non-zero values to this register sets the status flags,
     indicating the driver progress. Writing zero (0x0) to this
-    register triggers a device reset. 
+    register triggers a device reset.
     See also p. \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Device Initialization}~\nameref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Device Initialization}.
   }
-  \hline 
+  \hline
   \mmiodreg{QueueDescLow}{QueueDescHigh}{Virtual queue's Descriptor Area 64 bit long physical address}{0x080}{0x084}{W}{%
     Writing to these two registers (lower 32 bits of the address
     to \field{QueueDescLow}, higher 32 bits to \field{QueueDescHigh}) notifies
     the device about location of the Descriptor Area of the queue
     selected by writing to \field{QueueSel} register.
   }
-  \hline 
+  \hline
   \mmiodreg{QueueDriverLow}{QueueDriverHigh}{Virtual queue's Driver Area 64 bit long physical address}{0x090}{0x094}{W}{%
     Writing to these two registers (lower 32 bits of the address
     to \field{QueueDriverLow}, higher 32 bits to \field{QueueDriverHigh}) notifies
     the device about location of the Driver Area of the queue
     selected by writing to \field{QueueSel}.
   }
-  \hline 
+  \hline
   \mmiodreg{QueueDeviceLow}{QueueDeviceHigh}{Virtual queue's Device Area 64 bit long physical address}{0x0a0}{0x0a4}{W}{%
     Writing to these two registers (lower 32 bits of the address
     to \field{QueueDeviceLow}, higher 32 bits to \field{QueueDeviceHigh}) notifies
     the device about location of the Device Area of the queue
     selected by writing to \field{QueueSel}.
   }
-  \hline 
+  \hline
   \mmioreg{SHMSel}{Shared memory id}{0x0ac}{W}{%
     Writing to this register selects the shared memory region \ref{sec:Basic Facilities of a Virtio Device / Shared Memory Regions}
     following operations on \field{SHMLenLow}, \field{SHMLenHigh},
     \field{SHMBaseLow} and \field{SHMBaseHigh} apply to.
   }
-  \hline 
+  \hline
   \mmiodreg{SHMLenLow}{SHMLenHigh}{Shared memory region 64 bit long length}{0x0b0}{0x0b4}{R}{%
     These registers return the length of the shared memory
     region in bytes, as defined by the device for the region selected by
@@ -217,7 +217,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     region (i.e. where the ID written to \field{SHMSel} is unused)
     results in a length of -1.
   }
-  \hline 
+  \hline
   \mmiodreg{SHMBaseLow}{SHMBaseHigh}{Shared memory region 64 bit long physical address}{0x0b8}{0x0bc}{R}{%
     The driver reads these registers to discover the base address
     of the region in physical address space.  This address is
@@ -228,7 +228,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     \field{SHMSel} is unused) results in a base address of
     0xffffffffffffffff.
   }
-  \hline 
+  \hline
   \mmioreg{QueueReset}{Virtual queue reset bit}{0x0c0}{RW}{%
     If VIRTIO_F_RING_RESET has been negotiated, writing one (0x1) to this
     register selectively resets the queue. Both read and write accesses
@@ -242,7 +242,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     If the values are different, the configuration space accesses were not atomic and the driver has to perform the operations again.
     See also \ref {sec:Basic Facilities of a Virtio Device / Device Configuration Space}.
   }
-  \hline 
+  \hline
   \mmioreg{Config}{Configuration space}{0x100+}{RW}{
     Device-specific configuration space starts at the offset 0x100
     and is accessed with byte alignment. Its meaning and size
@@ -284,13 +284,13 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
 
 \drivernormative{\subsubsection}{MMIO Device Register Layout}{Virtio Transport Options / Virtio Over MMIO / MMIO Device Register Layout}
 The driver MUST NOT access memory locations not described in the
-table \ref{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Register Layout}
+table \ref{tab:Virtio Transport Options / Virtio Over MMIO / MMIO Device Register Layout}
 (or, in case of the configuration space, described in the device specification),
 MUST NOT write to the read-only registers (direction R) and
 MUST NOT read from the write-only registers (direction W).
 
 The driver MUST only use 32 bit wide and aligned reads and writes to access the control registers
-described in table \ref{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Register Layout}.
+described in table \ref{tab:Virtio Transport Options / Virtio Over MMIO / MMIO Device Register Layout}.
 For the device-specific configuration space, the driver MUST use 8 bit wide accesses for
 8 bit wide fields, 16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide and
 aligned accesses for 32 and 64 bit wide fields.
@@ -419,23 +419,23 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
 in a slightly different control register layout, the device
 initialization and the virtual queue configuration procedure.
 
-Table \ref{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Legacy Register Layout} 
+Table \ref{tab:Virtio Transport Options / Virtio Over MMIO / MMIO Device Legacy Register Layout}
 presents control registers layout, omitting
 descriptions of registers which did not change their function
 nor behaviour:
 
 \begin{longtable}{p{0.2\textwidth}p{0.7\textwidth}}
   \caption {MMIO Device Legacy Register Layout}
-  \label{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Legacy Register Layout} \\
+  \label{tab:Virtio Transport Options / Virtio Over MMIO / MMIO Device Legacy Register Layout} \\
+  \hline
+  \mmioreg{Name}{Function}{Offset from base}{Direction}{Description}
+  \hline
   \hline
-  \mmioreg{Name}{Function}{Offset from base}{Direction}{Description} 
-  \hline 
-  \hline 
   \endfirsthead
   \hline
-  \mmioreg{Name}{Function}{Offset from the base}{Direction}{Description} 
-  \hline 
-  \hline 
+  \mmioreg{Name}{Function}{Offset from the base}{Direction}{Description}
+  \hline
+  \hline
   \endhead
   \endfoot
   \endlastfoot
@@ -454,7 +454,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
   \mmioreg{GuestFeatures}{Flags representing device features understood and activated by the driver}{0x020}{W}{}
   \hline
   \mmioreg{GuestFeaturesSel}{Activated (guest) features word selection}{0x024}{W}{}
-  \hline 
+  \hline
   \mmioreg{GuestPageSize}{Guest page size}{0x028}{W}{%
     The driver writes the guest page size in bytes to the
     register during initialization, before any queues are used.
@@ -467,7 +467,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
     Writing to this register selects the virtual queue that the
     following operations on the \field{QueueNumMax}, \field{QueueNum}, \field{QueueAlign}
     and \field{QueuePFN} registers apply to. The index
-    number of the first queue is zero (0x0). 
+    number of the first queue is zero (0x0).
 .
   }
   \hline
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

