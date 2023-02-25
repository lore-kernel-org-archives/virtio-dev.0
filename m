Return-Path: <virtio-dev-return-11284-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBA2C64EC7
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:30:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EC42477FB
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:30:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DA4759867D2
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:30:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CFD4898679F; Sat, 25 Feb 2023 22:30:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BB0C698678A;
	Sat, 25 Feb 2023 22:30:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fib7RuTNQ0SoH9jqyw01zRWmVLTrRFxr0tDIiRobl/fQ8CZa97oz9+A9FjGhzcvnRudOhvAENGU8Tr36ea1be9SgvI+h5Q5tOXvtoQDCpsMMGooKwXRG/K+jjeZJZFSPkYkNfWVnYJaeCrrptkKOZcAeDN9bZVhvw/sIdtnbbE3F8Rd/sH2D+maSkMTFKPCUYaJ975UF6s8RheLpU+Wy+B9kPilsKTZpyuLQ0deOTFVhwTKxPGWdmwG2TbSU31xggOu47WuYWgUb7FEDT0qCmskdBiqlMqWfRnwtu1kfKycTgsAuViHnmu3BXGnrTz97NsW/ldPfiR3nx7dkjXjzjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBNEcviay0WTnSkKBFBl971/1oAjy2g+8+muxbLgLk4=;
 b=CN1ClYnIg1IZZ35NRlvfxrYoWSR1L+9B77Vm5yEC919c2ek+Yoe3NO788kHUrcxRGjHh85fovDok3BW7keWj1AsAg35+WpUYtpTLdpyvjJjQ2XpEPsskwojZh3L7vQflQCq1+AnkNvOIvTfNKCPY7dEe0pSdXVAxwoPP8cz/SPjCOeaNiIsGVmUw//u6bTdIO3g92mih1CgjLe81YPCaPtkbcaJzJrglNbkq+40Gf9bFo60yafZMmXLhj8c1sU3cw1pIAuyi9LjPTVgZITvu/FHN/Ticm8xVK9R/RGEz1B7O93HDVP+zNQFhdwrS81WHXcVGHCoHrSTJvy7L6FZ3Lw==
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
Date: Sun, 26 Feb 2023 00:29:59 +0200
Message-ID: <20230225223001.430522-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230225223001.430522-1-parav@nvidia.com>
References: <20230225223001.430522-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96A:EE_|DS0PR12MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e32e629-0728-4417-987b-08db177fe5ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o9j7M1ZypiMHG7ffhYfMcHTgPV6SBl55bu4By0aVY/5ye4BwRHSNLuDFemDIjFMRw0W32Wock8DLuxpNJ9ZdVRpruapbQCoiglUzKqSsMAWQCRlt4ofQXZ+hNayKAfwWNqcDSTgQV1ZzxdyeG7z3R71tlLngpXcDYkkUi88Z3023H6SI2HIz4EOuWSy08xAoithdLHU3t2FuRuv63ytmZz61aff2uERo3dAiNU3/QFyHoHAfoV4dPgtojVSDaCOBY1d8LZH276rK1IRsFMD7RNMGmi8VPX/8lN/jkTSog8KF09vBNDzEmfLfJnAHBuqh4khVMbysrNY3rn0tFoh3ZZEPZncU18A8EE+dNs+fc9j2mo/oQ0Ha4enVTjKJj7az/wjLkt+syfrtogbDXmicIryprMaBlNiF+r7LyqN3+nmqAuaqcku2TLEckMt0WVqt8f59qm8XaVqoPYkitnzHV+M7ovPbBxIUSUdno2M6bY2zZiv7m2KQfyxLOKrWERsYlkKtxfU4p86TpnL0oNYS7uynOHxmW7/tq25HrHniN77nSa7mxPU8dVXNHUgYogKFBFlYWBdP02jLRE4EiTi49O9bsjHTFO2wyOcvrSZNNY+Q87dMTiHCfbu/GajY18NCpWSYbf5qG1/CIuLOK1cper2dyWfq2aMVteIdUQ2bujlKlVa2B2ieveT11QAf15D9H7PdohqdKDvleCzOKbt3em7TOcoeaRwDU/z+WjxxWWHZ2BSRYYJpB9yK8sEzimLK
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199018)(40470700004)(46966006)(36840700001)(8936002)(5660300002)(2906002)(70206006)(70586007)(4326008)(8676002)(110136005)(54906003)(478600001)(316002)(966005)(41300700001)(107886003)(36860700001)(426003)(47076005)(82310400005)(6666004)(16526019)(26005)(1076003)(186003)(2616005)(336012)(40480700001)(86362001)(7636003)(82740400003)(36756003)(83380400001)(356005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 22:30:28.7137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e32e629-0728-4417-987b-08db177fe5ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C96A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7535
Subject: [virtio-dev] [PATCH 1/3] transport-pci: Improve PCI legacy device layout description
Message-ID: <20230225222959._dABRnw-kKs7XZ1lUeLegCTjX83xbGoFwL4_RSGqptI@z>

Legacy interface PCI Device layout description has following issues.

1. repeated 'structure' word
2. virtio header was defined the 0.9.5 spec. In a legacy interface
   section it is referred with different keywards
   as (a) virtio header, (b) general headers, (c) legacy configuration
   structure, (d) virtio common configuration structure and
   (e) other fields.
3. Driver and device requirements listing is intermixed.
4. spelling error of structure

Hence, rewrite the description to eliminate above issues as below.

1. Removed repeated structure word
2. Fix spelling of structure
3. Place all device requirements toegether
3. Define legacy configuration structure that consist of
   a. legacy common configuration structure and
   b. device specific configuration structure
4. Rewrite section around above changes

This is only an editorial change.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/164
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-pci.tex | 93 ++++++++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 41 deletions(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 5d22e6f..9ee37ba 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -769,25 +769,19 @@ \subsubsection{PCI configuration access capability}\label{sec:Virtio Transport O
 
 \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
 
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
+The transitional device MUST present part of the configuration
+registers in a legacy configuration structure in BAR0 in the
+first I/O region of the PCI Device.
+
+The legacy configuration structure is described below.
+It consists of two parts.
+\begin{enumerate}
+  \item Legacy common configuration structure
+  \item Device configuration structure (optional)
+\end{enumerate}
+
+When used through the legacy interface, the legacy common
+configuration structure has the following layout:
 
 \begin{tabularx}{\textwidth}{ |X||X|X|X|X|X|X|X|X| }
 \hline
@@ -801,8 +795,8 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio
 \hline
 \end{tabularx}
 
-If MSI-X is enabled for the device, two additional fields
-immediately follow this header:
+When MSI-X capability is enabled on the device, the device MUST
+present two additional fields immediately following the above fields:
 
 \begin{tabular}{ |l||l|l| }
 \hline
@@ -814,14 +808,12 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio
 \hline
 \end{tabular}
 
-Note: When MSI-X capability is enabled, device-specific configuration starts at
-byte offset 24 in virtio common configuration structure structure. When MSI-X capability is not
-enabled, device-specific configuration starts at byte offset 20 in virtio
-header.  ie. once you enable MSI-X on the device, the other fields move.
-If you turn it off again, they move back!
+The device configuration structure is optional. Its existence
+is decided by each device type. The transitional device MUST
+present the device-specific configuration structure if any at an
+offset immediately following the legacy common configuration structure.
 
-Any device-specific configuration space immediately follows
-these general headers:
+The device configuration structure:
 
 \begin{tabular}{|l||l|l|}
 \hline
@@ -833,25 +825,44 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio
 \hline
 \end{tabular}
 
-When accessing the device-specific configuration space
-using the legacy interface, transitional
-drivers MUST access the device-specific configuration space
-at an offset immediately following the general headers.
-
-When using the legacy interface, transitional
-devices MUST present the device-specific configuration space
-if any at an offset immediately following the general headers.
-
-Note that only Feature Bits 0 to 31 are accessible through the
-Legacy Interface. When used through the Legacy Interface,
-Transitional Devices MUST assume that Feature Bits 32 to 63
-are not acknowledged by Driver.
+Note: The device configuration structure byte offset is
+calculated dynamically; when MSI-X capability is enabled, the
+device configuration structure is located at byte offset 24,
+when MSI-X capability is disabled, the device configuration
+structure is located at byte offset 20.
 
 As legacy devices had no \field{config_generation} field,
 see \ref{sec:Basic Facilities of a Virtio Device / Device
 Configuration Space / Legacy Interface: Device Configuration
 Space}~\nameref{sec:Basic Facilities of a Virtio Device / Device Configuration Space / Legacy Interface: Device Configuration Space} for workarounds.
 
+When using the legacy interface, the transitional driver MUST
+use the legacy configuration structure in BAR0 in the first
+I/O region of the PCI device.
+
+When using the legacy interface, the driver MAY access
+the device-specific configuration structure using any width
+accesses and the transitional device MUST present the driver with
+the same results as when accessed using the ``natural'' access
+method (i.e. 32-bit accesses for 32-bit fields, etc).
+
+Note that this is possible because while the legacy common
+configuration structure is PCI (i.e. little) endian, when using
+the legacy interface the device-specific configuration structure
+is encoded in the native endian of the guest (where such
+distinction is applicable).
+
+When accessing the device-specific configuration structure
+using the legacy interface, transitional drivers MUST access
+the device-specific configuration structure
+at an offset immediately following the legacy common
+configuration structure.
+
+Note that only Feature Bits 0 to 31 are accessible through the
+Legacy Interface. When used through the Legacy Interface,
+the transitional device MUST assume that Feature Bits 32 to 63
+are not acknowledged by the driver.
+
 \subsubsection{Non-transitional Device With Legacy Driver: A Note
 on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio
 Over PCI Bus / PCI Device Layout / Non-transitional Device With
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

