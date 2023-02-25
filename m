Return-Path: <virtio-dev-return-11286-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE39C64EC7
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:30:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9F02F7605A
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:30:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 31F00986826
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:30:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C5F7998684E; Sat, 25 Feb 2023 22:30:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0DC63986795;
	Sat, 25 Feb 2023 22:30:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csx/rsssNvzLgYsxPgu5X8LWLlSszmO8QHJoYCI2TCq+wzX1IHJpX78XT1h7R5ZJhntH+aoPvOCh/0eyvlwhIqQufkT2tnI2DY+0ozkWSRkrkeDfiBhq9ljHLTIv833cpdmSihTznlrRU6L/WtY37UA7TRD3abjT1stSC9gO5WykKELfGPpwqes4P31YWvjnZ6Q4eTbOYhXTIu1YIJhDZekueK5CRFWojsc+eEBhsPfH+zNSfjb+tqcVOaliBSlI7FAQHnMMoe2gFsI11tcd0AB2gMj0XLWbTnNnic4IjeLX8EQFkW+Mncg5+Qcgp0vJ83tZGmt58pNAAkM/uUgQ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67m8/5XuVC4Feznn09ypfihvyO4gpGdNwK7I6MDMOOY=;
 b=Wzk9aEZRBZNYyTgTLMfItRgvRHstGYAQcAGynBQByajDZPe4GjLrtnGjOZwLwonun1Dapio3pyB/7S0Hb8kALjhM4CU75nJ1uRZI9QSmofZsTn5pmy5B0unmvZNPfjudLY8SJWazAJXZswcHF2P9ML0a7spAEw9URWOZ24lSV+J5lIwY1TaBlOEknhW8eLAg6PaorIroLdRUUSzKhQkgnJ7b1kY98FZ4rxtuqIRCgJztiLk3BsWk2jL23ywy0lf2S1QxoGddK+X6WzB47GfiMfLEPHYv9d0ncw/EJjxA1qc381O33feVxQ7Rb/qwD1txCc6h8L5DFsf1VfN9ICHOzw==
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
Date: Sun, 26 Feb 2023 00:30:01 +0200
Message-ID: <20230225223001.430522-4-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96A:EE_|PH8PR12MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: e2eb2260-bcc7-4431-9aa9-08db177fe7af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	32ombCoj89qrdGmlozIw4Ybu0XqaL9ElsQfyivHOo7PZLsrwINjvzraq/5iDponGrCYRuMFdWP2Ma2pCJTVCeV4+m+HKu3KEpUkhOaJ7px4m+5czLfkvgBCw8cG4d5vCauIXXgRtfSlUohVrvbslIVGAf39lHuCUZtuGtSZGMnga6QohNy0yci2X6QRakXgXYamEnuPiv9lTOBqT7Df52652TyOE77LRJzc4TO8lEnZOOjwX2tYi3sXlawMQyPyuihkm87zaO4i5xsb22IXVw3OAPksUuWefyHo903I0pI5AFKdcAUBWE8z+ebmyz8c3gnbiNuJVVBuBOVaxhYsxGpKfnv/6EPpZCG9SwPSCl2mLMAkjVHeLFruK0IyTGYnU3FweOKCiV9QsGvhRUuFwInp9VklegRxVaTQ9dg/cmXy9pDq1rZOR1kKAsby1aqDXfJgQvasSsOu7//fzMR6PLQI73hWduSRCNwdnRf0pU8/5RieCvXs6M2Uzbk7NWLlAJ5LEDEL556hhqsePN8br3RF2SJElPKjNqgXyP5Z5gEbCQVhnIbh1HAi9cu2goJvHdgdH4ShG8pqnw9V4HMxHS+7ovsQ86OgOOEo5NXYC2MfawT22DH5cXt4+SCLlvttZePzJn2D3G08SroBJaejvtv9v+CE6sLjcP5kDKWbr7Du4ga1UUzyfaYhkW3FDUR1IcTtUel7Ekk6dO8Zn7BintTlwBmWt7SIAnIuD3sEOlvqCOoG+RxIxZ+sbN4JZGK2e
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199018)(46966006)(40470700004)(36840700001)(40460700003)(16526019)(7636003)(82740400003)(356005)(8936002)(70586007)(70206006)(8676002)(41300700001)(2906002)(36860700001)(5660300002)(30864003)(336012)(40480700001)(4326008)(426003)(47076005)(478600001)(1076003)(6666004)(186003)(26005)(107886003)(2616005)(966005)(83380400001)(316002)(36756003)(86362001)(54906003)(110136005)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 22:30:31.6824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2eb2260-bcc7-4431-9aa9-08db177fe7af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C96A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7231
Subject: [virtio-dev] [PATCH 3/3] transport-pci: Relocate common config legacy interface
Message-ID: <20230225223001.yeg6IOVFAnYUgG6SRuiM_aPRTxw9eNTyRturddR5ltQ@z>

Relocate legacy interface section of common configuration structure near
where 1.x based common configuration structure is defined.

This aligns the spec to follow rest of the other Legacy interfaces
section.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/164
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 conformance.tex   |   3 +-
 transport-pci.tex | 186 +++++++++++++++++++++++-----------------------
 2 files changed, 95 insertions(+), 94 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index 0d3616f..b654fe0 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -262,8 +262,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Message Framing / Legacy Interface: Message Framing}
 \item Section \ref{sec:General Initialization And Device Operation / Device Initialization / Legacy Interface: Device Initialization}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery / Legacy Interfaces: A Note on PCI Device Discovery}
-\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus/ Virtio Structure PCI Capabilities / Legacy Interfaces: A Note on Common
-configuration Layout}
+\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Common configuration structure layout / Legacy Interfaces: A Note on Common configuration Layout}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Legacy Interface: A Note on feature bits}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtio Device Configuration Layout Detection / Legacy Interface: A Note on Device Layout Detection}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtqueue Configuration / Legacy Interface: A Note on Virtqueue Configuration}
diff --git a/transport-pci.tex b/transport-pci.tex
index 9d4c713..19375d0 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -494,6 +494,100 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 were used before the queue reset.
 (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
 
+\paragraph{Legacy Interfaces: A Note on Common configuration
+Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus
+/ Virtio Structure PCI Capabilities / Common configuration
+structure layout / Legacy Interfaces: A Note on Common
+configuration Layout}
+
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
+When MSI-X capability is enabled on the device, the device MUST
+present two additional fields immediately following the above fields:
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
+The device configuration structure is optional. Its existence
+is decided by each device type. The transitional device MUST
+present the device-specific configuration structure if any at an
+offset immediately following the legacy common configuration structure.
+
+The device configuration structure:
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
+Note: The device configuration structure byte offset is
+calculated dynamically; when MSI-X capability is enabled, the
+device configuration structure is located at byte offset 24,
+when MSI-X capability is disabled, the device configuration
+structure is located at byte offset 20.
+
+As legacy devices had no \field{config_generation} field,
+see \ref{sec:Basic Facilities of a Virtio Device / Device
+Configuration Space / Legacy Interface: Device Configuration
+Space}~\nameref{sec:Basic Facilities of a Virtio Device / Device Configuration Space / Legacy Interface: Device Configuration Space} for workarounds.
+
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
+The transitional driver when using the legacy interface MUST
+the device-specific configuration structure at an offset
+immediately following the legacy common configuration structure.
+
+
 \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
 
 The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
@@ -767,98 +861,6 @@ \subsubsection{PCI configuration access capability}\label{sec:Virtio Transport O
 specified by some other Virtio Structure PCI Capability
 of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
 
-\subsubsection{Legacy Interfaces: A Note on Common configuration
-Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus
-/ Virtio Structure PCI Capabilities / Legacy Interfaces: A Note on Common
-configuration Layout}
-
-The transitional device MUST present part of the configuration
-registers in a legacy configuration structure in BAR0 in the
-first I/O region of the PCI Device.
-
-The legacy configuration structure is described below.
-It consists of two parts.
-\begin{enumerate}
-  \item Legacy common configuration structure
-  \item Device configuration structure (optional)
-\end{enumerate}
-
-When used through the legacy interface, the legacy common
-configuration structure has the following layout:
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
-When MSI-X capability is enabled on the device, the device MUST
-present two additional fields immediately following the above fields:
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
-The device configuration structure is optional. Its existence
-is decided by each device type. The transitional device MUST
-present the device-specific configuration structure if any at an
-offset immediately following the legacy common configuration structure.
-
-The device configuration structure:
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
-Note: The device configuration structure byte offset is
-calculated dynamically; when MSI-X capability is enabled, the
-device configuration structure is located at byte offset 24,
-when MSI-X capability is disabled, the device configuration
-structure is located at byte offset 20.
-
-As legacy devices had no \field{config_generation} field,
-see \ref{sec:Basic Facilities of a Virtio Device / Device
-Configuration Space / Legacy Interface: Device Configuration
-Space}~\nameref{sec:Basic Facilities of a Virtio Device / Device Configuration Space / Legacy Interface: Device Configuration Space} for workarounds.
-
-When using the legacy interface, the transitional driver MUST
-use the legacy configuration structure in BAR0 in the first
-I/O region of the PCI device.
-
-When using the legacy interface, the driver MAY access
-the device-specific configuration structure using any width
-accesses and the transitional device MUST present the driver with
-the same results as when accessed using the ``natural'' access
-method (i.e. 32-bit accesses for 32-bit fields, etc).
-
-Note that this is possible because while the legacy common
-configuration structure is PCI (i.e. little) endian, when using
-the legacy interface the device-specific configuration structure
-is encoded in the native endian of the guest (where such
-distinction is applicable).
-
-The transitional driver when using the legacy interface MUST
-the device-specific configuration structure at an offset
-immediately following the legacy common configuration structure.
-
 \subsubsection{Legacy Interface: A Note on feature
 bits}\label{sec:Virtio Transport Options / Virtio Over PCI Bus /
 Virtio Structure PCI Capabilities / Legacy Interface: A Note on feature bits}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

