Return-Path: <virtio-dev-return-11872-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9107C6FD1D
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 23:00:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 933BE7A06A
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 23:00:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7532B986970
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 23:00:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5FC8C986586; Thu, 30 Mar 2023 23:00:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F312698662D;
	Thu, 30 Mar 2023 23:00:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsFdpO2be6UNunefFkkRZrbD7vZD2iEQATWGanWr8G44mbMEcgv7yol5tQp7ldni9AC4f/792y4dQIwhl8Sd3ZkIfPZTpOSO6YydBm4paCEYhd7H4MueJuk9mmILpynUVUuAXQ+Vmn1l/QRq9PIwPvHcf9PIv9echfnFwrrpzt/9EsRbsdIF2e4I4JDd5fXn5CYERJxIkO7Vu3RJ5xq5ngvk5CzPmdQyx9y9h2l3uEMBuvqLulyK6WMu2dqqqk6Jqv5j/WLC59PuV9aEsP3SYRHYYMQFxzXr4W56WPa5rgxiBbjxumeP2fHQdlOdILOIDkDdvpYb6wfpFaQ67BFAFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLP8fUqFnE83979XhmH/+lOzOhbYIMih79jrsSP+BMM=;
 b=oSb4gvITQta4V5QYkUTnwlO96hfJj/cfzOd5Bmy/13IrDwC7dSHMEp0h/L4+5OGiGXWTK1cEZ4F0t7EP8A8VwCPwgH4/G+sUHiUxurzXVz3v3cUjlQGQxhnNwLLeu7ma6X1QcZRBGiFj5CHx9s+m6Y6w2NOdg1P2u9VeFp2dNkvNH0EjRWliktxPwKima0rz8Euq/vQu0t0AIJq44hbFLgftZAO0591y3RUYYQLYQyOcEXGSFffcIhIumDCoKzRcbgEl59bSMHZFYMW7DOESPY0c72v5sn/itNWKB8DrRwy7G8b60H9lq4szSZadTUrRdF85Cwr/KSlIt+PlWVpg6g==
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
	<parav@nvidia.com>, Satananda Burla <sburla@marvell.com>
Date: Fri, 31 Mar 2023 01:58:32 +0300
Message-ID: <20230330225834.506969-10-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT086:EE_|DM4PR12MB5326:EE_
X-MS-Office365-Filtering-Correlation-Id: 278c845a-a69a-473e-c941-08db31726d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lW/efizUFAf1ozChKMQuSsd56F+oQD2XW15mlz67RVhBRRRNO3CTBHFHzCHLLtoqQmuMLS8ikeofAG+0CXWiG9YJrnca0gOdf6/kpxj0Jh7YJJ9xP1eGkzzAei9dfnMj0EINBlTdm0Lb4wbb+ICn2PeYs3gfu5rWPIqtHVFmy+jpJoJb6NFaJdAugv/E8kigGeEalcXkkwA5EGLSmrkTMxAaWhEuwVetuBOHvkFwSe4V1/CwyYEo/NPYptN6zMggxEc/LGn9F+gTfmUrNuaI+Ze4vdCZXQAFzhdWwUYPmIUuf54hi4VRkijNP9PeNlb9NCAyl17dTf3AHMcBz+2/Cs/H4IBMksgxS/I38zNfhxMH76T/+rRsFfLUvH0azbu4mpi2y7h/O+OBVRufarYyu36SF7xsLXoGSWB4n5x8HyO4WcxzKCTNoYwbzMWO2B7jH5o/TnFLZrIcBw+oufD40XTHkzGWnl0o9AM6n9IVPoS+3dbP0NYbbhGz+UCU/Pi/j/0gI6hKqSb1tdyxRbHTphgTDb5GNNYQjVq/CNDQaoCqr/o+pWTDAon9YV/6xg9WvQMuqm54sJmEOGflITYZqWqBG2JQPaTgRKjNuddaoFVGihbIPyTej33k7/C0GtwAXoEmhkpDhHgkVNAe/6I7iAyfU/Q+UNAgDQMpDbxqp1xVbacYyShi5SdMlGz8ldLC4joCijMrLJkouTeG9RN2e3YOHsNyiqOfA+idAQRmQvGgiZE2d9ZtL6YtdUTG2UIxfNdpUlhQLqNkWblTpcFRpvKpeSahZ/9c3JknHuaP9Eo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(110136005)(5660300002)(8936002)(2906002)(316002)(40480700001)(186003)(70206006)(41300700001)(40460700003)(86362001)(26005)(70586007)(54906003)(8676002)(4326008)(36756003)(478600001)(356005)(7636003)(2616005)(16526019)(1076003)(82740400003)(82310400005)(83380400001)(336012)(6666004)(47076005)(36860700001)(426003)(34020700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 22:59:32.8324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 278c845a-a69a-473e-c941-08db31726d1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5326
Subject: [virtio-dev] [PATCH 09/11] transport-pci: Describe PCI MMR dev config registers

Legacy virtio configuration registers and adjacent
device configuration registers are located somewhere
in a memory BAR.

A new capability supplies the location of these registers
which a driver can use to map I/O access to legacy
memory mapped registers.

This gives the ability to locate legacy registers in either
the existing memory BAR or as completely new BAR at BAR 0.

A below example diagram attempts to depicts it in an existing
memory BAR.

+------------------------------+
|Transitional                  |
|MMR SRIOV VF                  |
|                              |
++---------------+             |
||dev_id =       |             |
||{0x10f9-0x10ff}|             |
|+---------------+             |
|                              |
++--------------------+        |
|| PCIe ext cap = 0xB |        |
|| cfg_type = 10      |        |
|| offset   = 0x1000  |        |
|| bar      = A {0..5}|        |
|+--|-----------------+        |
|   |                          |
|   |                          |
|   |    +-------------------+ |
|   |    | Memory BAR = A    | |
|   |    |                   | |
|   +------>+--------------+ | |
|        |  |legacy virtio | | |
|        |  |+ dev cfg     | | |
|        |  |registers     | | |
|        |  +--------------+ | |
|        +-----------------+ | |
+------------------------------+

Co-developed-by: Satananda Burla <sburla@marvell.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-pci.tex | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index aeda4a1..55a6aa0 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -168,6 +168,7 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
 \item ISR Status
 \item Device-specific configuration (optional)
 \item PCI configuration access
+\item Legacy memory mapped configuration registers (optional)
 \end{itemize}
 
 Each structure can be mapped by a Base Address register (BAR) belonging to
@@ -228,6 +229,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
 #define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
 /* Vendor-specific data */
 #define VIRTIO_PCI_CAP_VENDOR_CFG        9
+/* Legacy configuration registers capability */
+#define VIRTIO_PCI_CAP_LEGACY_MMR_CFG    10
 \end{lstlisting}
 
         Any other value is reserved for future use.
@@ -682,6 +685,18 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 Configuration Space / Legacy Interface: Device Configuration
 Space}~\nameref{sec:Basic Facilities of a Virtio Device / Device Configuration Space / Legacy Interface: Device Configuration Space} for workarounds.
 
+\paragraph{Transitional MMR Interface: A Note on Configuration Registers}
+\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Common configuration structure layout / Transitional MMR Interface: A Note on Configuration Registers}
+
+The transitional MMR device MUST present legacy virtio registers
+consisting of legacy common configuration registers followed by
+legacy device specific configuration registers described in section
+\ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Common configuration structure layout / Legacy Interfaces: A Note on Configuration Registers}
+in a memory region PCI BAR.
+
+The transitional MMR device MUST provide the location of the
+legacy virtio configuration registers using a legacy memory mapped
+registers capability described in section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Transitional MMR Interface: Legacy Memory Mapped Configuration Registers Capability}.
 
 \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
 
@@ -956,9 +971,23 @@ \subsubsection{PCI configuration access capability}\label{sec:Virtio Transport O
 specified by some other Virtio Structure PCI Capability
 of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
 
+\subsubsection{Transitional MMR Interface: Legacy Memory Mapped Configuration Registers Capability}
+\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Transitional MMR Interface: Legacy Memory Mapped Configuration Registers Capability}
+
+The optional VIRTIO_PCI_CAP_LEGACY_MMR_CFG capability defines
+the location of the legacy virtio configuration registers
+followed by legacy device specific configuration registers in
+the memory region BAR for the transitional MMR device.
+
+The \field{cap.offset} MUST be 4-byte aligned.
+The \field{cap.offset} SHOULD be 4KBytes aligned and
+\field{cap.length} SHOULD be 4KBytes.
+
+The transitional MMR device MUST present a legacy configuration
+memory mapped registers capability using \field{virtio_pcie_ext_cap}.
+
 \subsubsection{Legacy Interface: A Note on Feature Bits}
-\label{sec:Virtio Transport Options / Virtio Over PCI Bus /
-Virtio Structure PCI Capabilities / Legacy Interface: A Note on Feature Bits}
+\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Legacy Interface: A Note on Feature Bits}
 
 Only Feature Bits 0 to 31 are accessible through the
 Legacy Interface. When used through the Legacy Interface,
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

