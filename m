Return-Path: <virtio-dev-return-11864-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C196C7619A
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7E7DF4259D
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DDFC898661F
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C32219867CE; Thu, 30 Mar 2023 22:59:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C868998658D;
	Thu, 30 Mar 2023 22:59:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sj2mSUraaJTNx3CkDgbGOTVdlAU2T2QzLPUaw6coFB4aA56hpxG2PjtSkmCA357XEBSBqLO5UuliDDHvV2tuGKW9ifUoGypzrWRpeYMUeyQFq8G0K5pmEBzhaL4kGZE2SVp5Rl0tyXKkF702jiWNQTiX2dY5rcsOAId2rWycEHwgBSEPMdCooab5fX1Lmv2VXh46HJAlSGxxuMn4J7yRlJDsuGogWc92NJaw/+ZTEOTPZ9eHxqwsOCKgYFq79eB5ycOA3PkKKHLjmkIkkE1A+za9M/uSHzxMnICRBX5JSNHBPXPyYXQQghZ5Tm/pKMli5h9Jf1jEdk8kPbgi88/E9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8ZCiiY6OxxGAoj6bGL6tkweMKigcRibdvh6ExyQd4o=;
 b=SdigsWfKB+ne9BAeIzZkqahdQ+LrlXimkQct3rMkw+dteVNok0QyDRq7PB2TsopyIsHGaJWo505nqNLywaNlG1bzW/s1SgPvEXtLrzBruQtvNGknk1Zm6TpRh1iUjmBzTEJDssa7LG2SyO/+s4cOyBa43WwOIKEIg+j+iWdixJdN5ZIqD3hX/QkGEuUFgXP22UYEHPNmv2R2eBUmmxTWDYFP/RBeruZHvXXwxTvR7+LsYOUSpOfMlPNnyus+zLiRfpzl8YaY3q1ESWeKLZTHCELGdIuzEzRVk7l2W5vl5iauWXhjy3Z30brf6YJy9E5YPDoKn4hoVjiMNyzwDNArhg==
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
	<parav@nvidia.com>, Satananda Burla <sburla@marvell.com>
Date: Fri, 31 Mar 2023 01:58:27 +0300
Message-ID: <20230330225834.506969-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230330225834.506969-1-parav@nvidia.com>
References: <20230330225834.506969-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT114:EE_|BY5PR12MB4869:EE_
X-MS-Office365-Filtering-Correlation-Id: 175cd3c3-eab3-4c31-fc27-08db31726777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JHZ5RotojNOundutc0PaxR89C0zG457cLLInI7ntb3qEh7Ih7IJE5t9afMomZcs0Cod8RZsO858wrwilXsUBViCakMWYeSrzZqVsIT3haB5LQc60JqPivydm5OIpnPALEvRJYAt1MyZzDzkc02SPcbsspn/BxvhQ1Np8R7Syw7ZEYZlAoPwa4KT2aJ3G+bIkd83nl5APZMzuAKrNBBjfIL3DSQz5gVigD+I4x3aYajJmuaaCPu0t1onDIPSiqA+zSiB1MR5f1VHoI1OL3Lk7wI3Ep+cBi/qm+dexuCbreMjuqM5Z03jVml9WtHqEKOaDPKTVUQxlX5ZdNNBqurqX2ZXCmyayjq0ETKQR/pUP68wWNzU21FR9slTUZFSTEETvXpV5JL5n0FV8/bNQf4vY0azvIXOno//P6UUZwZgH6FnP/QLEXZwsaz1XNueJZ6fzK+CRsxddPNjoviAKVbzmVG1zOgMXSsHsMtw68vXB/HLEoRN87aFb3J+2z+kTuWlQMrVeuucpFVuCwzmTtyDI8p48faA2Vs+spLKFIIrnMeYHSh4PZyPI7st+zJcsVwAi+4iHfWYZhlTB5jb5RmsWvzJYElFixnlJiMg9GpiDgQ6CGyg3kYk1xPJ+fOf8c9BUZ7jDZ9rNeV0yi1jGkoDtHOepH+bB7wZN66HoYkIaeeM8FCoxNDy668YCuJL2bOBvRvKbxfy+hSdqR5YRUub2X99XdUa/+JJkzgy+hJAQ8J9KwYFuBYu+LfwKpFzzsIym
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(46966006)(36840700001)(8676002)(8936002)(41300700001)(110136005)(5660300002)(82740400003)(7636003)(356005)(86362001)(34020700004)(40480700001)(6666004)(70206006)(4326008)(336012)(54906003)(70586007)(316002)(426003)(2616005)(36756003)(47076005)(36860700001)(83380400001)(16526019)(186003)(478600001)(82310400005)(1076003)(2906002)(26005)(30864003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 22:59:23.3444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 175cd3c3-eab3-4c31-fc27-08db31726777
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4869
Subject: [virtio-dev] [PATCH 04/11] transport-pci: Rename and move legacy PCI Device layout section

Current 'Legacy Interfaces: A Note on PCI Device Layout' explains virtio
legacy registers which consist of common configuration structure and
device specific registers. It has little to do with the existing
PCI Device layout section.

For example, non transitional device's common configuration layout is
described in 'Common configuration structure layout' section outside of
'PCI Device Layout' section.

Hence, to keep Legacy common configuration registers section consistent
with 1.x, rename and move it adjacent to 1.x common configuration
structure.

Reviewed-by: Satananda Burla <sburla@marvell.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 conformance.tex   |   2 +-
 transport-pci.tex | 162 +++++++++++++++++++++++-----------------------
 2 files changed, 83 insertions(+), 81 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index 4f724c2..ccbc9bf 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -262,7 +262,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Message Framing / Legacy Interface: Message Framing}
 \item Section \ref{sec:General Initialization And Device Operation / Device Initialization / Legacy Interface: Device Initialization}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery / Legacy Interfaces: A Note on PCI Device Discovery}
-\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
+\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Common configuration structure layout / Legacy Interfaces: A Note on Configuration Registers}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Legacy Interface: A Note on Feature Bits}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtio Device Configuration Layout Detection / Legacy Interface: A Note on Device Layout Detection}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtqueue Configuration / Legacy Interface: A Note on Virtqueue Configuration}
diff --git a/transport-pci.tex b/transport-pci.tex
index 65d9748..ee11ba5 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -497,6 +497,88 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 were used before the queue reset.
 (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
 
+\paragraph{Legacy Interfaces: A Note on Configuration Registers}
+\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Common configuration structure layout / Legacy Interfaces: A Note on Configuration Registers}
+
+Transitional devices MUST present part of configuration
+registers in a legacy configuration structure in BAR0 in the first I/O
+region of the PCI device, as documented below.
+When using the legacy interface, transitional drivers
+MUST use the legacy configuration structure in BAR0 in the first
+I/O region of the PCI device, as documented below.
+
+When using the legacy interface the driver MAY access
+the device-specific configuration region using any width accesses, and
+a transitional device MUST present driver with the same results as
+when accessed using the ``natural'' access method (i.e.
+32-bit accesses for 32-bit fields, etc).
+
+Note that this is possible because while the virtio common configuration structure is PCI
+(i.e. little) endian, when using the legacy interface the device-specific
+configuration region is encoded in the native endian of the guest (where such distinction is
+applicable).
+
+When used through the legacy interface, the virtio common configuration structure looks as follows:
+
+\begin{tabularx}{\textwidth}{ |X||X|X|X|X|X|X|X|X| }
+\hline
+ Bits & 32 & 32 & 32 & 16 & 16 & 16 & 8 & 8 \\
+\hline
+ Read / Write & R & R+W & R+W & R & R+W & R+W & R+W & R \\
+\hline
+ Purpose & Device Features bits 0:31 & Driver Features bits 0:31 &
+  Queue Address & \field{queue_size} & \field{queue_select} & Queue Notify &
+  Device Status & ISR \newline Status \\
+\hline
+\end{tabularx}
+
+If MSI-X is enabled for the device, two additional fields
+immediately follow this header:
+
+\begin{tabular}{ |l||l|l| }
+\hline
+Bits       & 16             & 16     \\
+\hline
+Read/Write & R+W            & R+W    \\
+\hline
+Purpose (MSI-X) & \field{config_msix_vector}  & \field{queue_msix_vector} \\
+\hline
+\end{tabular}
+
+Note: When MSI-X capability is enabled, device-specific configuration starts at
+byte offset 24 in virtio common configuration structure. When MSI-X capability is not
+enabled, device-specific configuration starts at byte offset 20 in virtio
+header.  ie. once you enable MSI-X on the device, the other fields move.
+If you turn it off again, they move back!
+
+Any device-specific configuration space immediately follows
+these general headers:
+
+\begin{tabular}{|l||l|l|}
+\hline
+Bits & Device Specific & \multirow{3}{*}{\ldots} \\
+\cline{1-2}
+Read / Write & Device Specific & \\
+\cline{1-2}
+Purpose & Device Specific & \\
+\hline
+\end{tabular}
+
+When accessing the device-specific configuration space
+using the legacy interface, transitional
+drivers MUST access the device-specific configuration space
+at an offset immediately following the general headers.
+
+When using the legacy interface, transitional
+devices MUST present the device-specific configuration space
+if any at an offset immediately following the general headers.
+
+As legacy devices had no \field{config_generation} field,
+see \ref{sec:Basic Facilities of a Virtio Device / Device
+Configuration Space / Legacy Interface: Device Configuration
+Space}~\nameref{sec:Basic Facilities of a Virtio Device / Device Configuration Space / Legacy Interface: Device Configuration Space} for workarounds.
+
+
 \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
 
 The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
@@ -770,86 +852,6 @@ \subsubsection{PCI configuration access capability}\label{sec:Virtio Transport O
 specified by some other Virtio Structure PCI Capability
 of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
 
-\subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
-
-Transitional devices MUST present part of configuration
-registers in a legacy configuration structure in BAR0 in the first I/O
-region of the PCI device, as documented below.
-When using the legacy interface, transitional drivers
-MUST use the legacy configuration structure in BAR0 in the first
-I/O region of the PCI device, as documented below.
-
-When using the legacy interface the driver MAY access
-the device-specific configuration region using any width accesses, and
-a transitional device MUST present driver with the same results as
-when accessed using the ``natural'' access method (i.e.
-32-bit accesses for 32-bit fields, etc).
-
-Note that this is possible because while the virtio common configuration structure is PCI
-(i.e. little) endian, when using the legacy interface the device-specific
-configuration region is encoded in the native endian of the guest (where such distinction is
-applicable).
-
-When used through the legacy interface, the virtio common configuration structure looks as follows:
-
-\begin{tabularx}{\textwidth}{ |X||X|X|X|X|X|X|X|X| }
-\hline
- Bits & 32 & 32 & 32 & 16 & 16 & 16 & 8 & 8 \\
-\hline
- Read / Write & R & R+W & R+W & R & R+W & R+W & R+W & R \\
-\hline
- Purpose & Device Features bits 0:31 & Driver Features bits 0:31 &
-  Queue Address & \field{queue_size} & \field{queue_select} & Queue Notify &
-  Device Status & ISR \newline Status \\
-\hline
-\end{tabularx}
-
-If MSI-X is enabled for the device, two additional fields
-immediately follow this header:
-
-\begin{tabular}{ |l||l|l| }
-\hline
-Bits       & 16             & 16     \\
-\hline
-Read/Write & R+W            & R+W    \\
-\hline
-Purpose (MSI-X) & \field{config_msix_vector}  & \field{queue_msix_vector} \\
-\hline
-\end{tabular}
-
-Note: When MSI-X capability is enabled, device-specific configuration starts at
-byte offset 24 in virtio common configuration structure. When MSI-X capability is not
-enabled, device-specific configuration starts at byte offset 20 in virtio
-header.  ie. once you enable MSI-X on the device, the other fields move.
-If you turn it off again, they move back!
-
-Any device-specific configuration space immediately follows
-these general headers:
-
-\begin{tabular}{|l||l|l|}
-\hline
-Bits & Device Specific & \multirow{3}{*}{\ldots} \\
-\cline{1-2}
-Read / Write & Device Specific & \\
-\cline{1-2}
-Purpose & Device Specific & \\
-\hline
-\end{tabular}
-
-When accessing the device-specific configuration space
-using the legacy interface, transitional
-drivers MUST access the device-specific configuration space
-at an offset immediately following the general headers.
-
-When using the legacy interface, transitional
-devices MUST present the device-specific configuration space
-if any at an offset immediately following the general headers.
-
-As legacy devices had no \field{config_generation} field,
-see \ref{sec:Basic Facilities of a Virtio Device / Device
-Configuration Space / Legacy Interface: Device Configuration
-Space}~\nameref{sec:Basic Facilities of a Virtio Device / Device Configuration Space / Legacy Interface: Device Configuration Space} for workarounds.
-
 \subsubsection{Legacy Interface: A Note on Feature Bits}
 \label{sec:Virtio Transport Options / Virtio Over PCI Bus /
 Virtio Structure PCI Capabilities / Legacy Interface: A Note on Feature Bits}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

