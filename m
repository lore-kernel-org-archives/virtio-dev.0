Return-Path: <virtio-dev-return-12603-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03123C77B75
	for <virtio-dev@archiver.kernel.org>; Sat,  6 May 2023 00:02:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6F84342B89
	for <virtio-dev@archiver.kernel.org>; Sat,  6 May 2023 00:02:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6A6EB9866FB
	for <virtio-dev@archiver.kernel.org>; Sat,  6 May 2023 00:02:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5E54B9866DD; Sat,  6 May 2023 00:02:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 33774986742;
	Sat,  6 May 2023 00:02:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQ/QyJr4XSI6ctFBLJlBw3TRsiL9r8qXvYKcP+qap6QZ+NYPIxQwFfn6CW2WVfKMpEa1ykA2tSc6e7khnZEDr0TuwEgFCdpFMuJFRKXlao61T+dnK4oXm1Jl/LXodzpYUXMILeVZXknGoNRbcIxjU293enuKOTKVzQgMVWLa0h6ZJhLjXjPYFRJtbP/AB5ljofEiMKV/C4kEa9kRrtdfidci9Wja6+cfTum+j89o/rTS8FTqezi3xsRbov7R4h007s5WkOUREqgz1fuaIKrppK/QnkMNCK+ty+unRA0O2pH9+/QhenCIpkkq2O+aa52UFjeeDewNf1Sq2+Brdk4G3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6tyanz3qEW1KbSWYb9anVarbNF0kVOCIbKBallM4ik=;
 b=PQBXznadBenYZhkVBdGphevVzcTLTwbDE55SBVHVd1t8DdpbEYrVTyXB+Hknu0jCYKBFWVVm0JyQfbvbfkGETJ8xoGGW/uoIPVMo8kOZ+puO/8hZm7obTHs+clsFKPh+xXTcSWQ8OuY9YMMKrD4gnXbyKihqQdkti6UluJhLDVSzSjwK5tTAAK3eoHgLR3IZVHqcsWy3pLxrVZEhqWKw61ndEGgLL60MqvAyTZgToTZQbif7zJC/5Oiy8JUYUupMnZD3n4NwFl398CwRS1Nd1qWza6D+ajc21GRqZDm/5olp9y5c7yfaAVndqSAHRC1zJCAp936/ONk8g6vLxvsZdw==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>,
	<david.edmondson@oracle.com>
CC: <sburla@marvell.com>, <jasowang@redhat.com>, <yishaih@nvidia.com>,
	<maorg@nvidia.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Sat, 6 May 2023 03:01:34 +0300
Message-ID: <20230506000135.628899-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230506000135.628899-1-parav@nvidia.com>
References: <20230506000135.628899-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6fc2a5-4173-4385-15b6-08db4dc51e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N8/cJTQEaEwKZ2QBfO65tVNZcJffSTyz4ApT+ps5rlff6blKsJOVveVHOe8Ad32pJdho5s/Vy8Ij+Cw6w0FMmeboWWISmiX8d8XIB+jnBIyvpaQp0KhTQQtUKmxAJ8cuQ1AMVnvC6ZHb4HOhqR3F1aUZaRy2RmU/EbXShLy+FRc7eOreGzShIJbc8pflMiQw6T8RJD8ow0PKfsAQuMG1gbyD/eg+/AlDgdzAw1gm/BLvZNXpm632S14Dzhumb9PBz079wwfOnkZ6ymWfw/ydsbyrJNWQp+D0qz4u/FB+Upi/hgCraIXSFiKTF5QtwQb8QbPvJUfKdGKDSjN2PhZIfBGZc9cKA4gtV7F7WUXEmUNA/deevMpqk2hO8v4Lu9iMWL5WI4AbliBphutKglxePpo1XjYhoqCY8dLeYyDG/YwHWDNlFJHYsLyndJfIub8jMvBQEjxjDLwocZek5YMJ0UAkAFK0/xcIzqzqm3pzfMwHw/GpuEQybK73rEAVu+kBW0E2A/WgRETjtAzlM2rIqASX9FdNz6WjIloWz49uduCin+5KOFVuT6oRZqudDNH89z/n3K8rNnpz9WHHHUm3oT9cAOjsjd7nTk+1+5vUJPzi67WzmsITtAZTL/2P5w7LlO0m+NIDcTgbQHMl15sLTxMmbfoqvvQZfS1KEy0fuYugnrr6JKokzXo0GPdWVec2ooICc1OPYqrItLUMnSbjfw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(316002)(16526019)(336012)(2906002)(186003)(41300700001)(6666004)(26005)(86362001)(1076003)(82310400005)(30864003)(54906003)(83380400001)(107886003)(47076005)(36756003)(70586007)(70206006)(426003)(4326008)(36860700001)(110136005)(2616005)(40460700003)(478600001)(7636003)(8676002)(5660300002)(8936002)(82740400003)(356005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 00:02:01.3204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6fc2a5-4173-4385-15b6-08db4dc51e3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567
Subject: [virtio-dev] [PATCH v2 1/2] transport-pci: Introduce legacy registers access commands

This patch introduces legacy registers access commands for the owner
group member PCI PF to access the legacy registers of the member VFs.

If in future any SIOV devices to support legacy registers, they
can be easily supported using same commands by using the group
member identifiers of the future SIOV devices.

More details as overview, motivation, use case are further described
below.

Usecase:
--------
1. A hypervisor/system needs to provide transitional
   virtio devices to the guest VM at scale of thousands,
   typically, one to eight devices per VM.

2. A hypervisor/system needs to provide such devices using a
   vendor agnostic driver in the hypervisor system.

3. A hypervisor system prefers to have single stack regardless of
   virtio device type (net/blk) and be future compatible with a
   single vfio stack using SR-IOV or other scalable device
   virtualization technology to map PCI devices to the guest VM.
   (as transitional or otherwise)

Motivation/Background:
----------------------
The existing virtio transitional PCI device is missing support for
PCI SR-IOV based devices. Currently it does not work beyond
PCI PF, or as software emulated device in reality. Currently it
has below cited system level limitations:

[a] PCIe spec citation:
VFs do not support I/O Space and thus VF BARs shall not indicate I/O Space.

[b] cpu arch citiation:
Intel 64 and IA-32 Architectures Software Developer’s Manual:
The processor’s I/O address space is separate and distinct from
the physical-memory address space. The I/O address space consists
of 64K individually addressable 8-bit I/O ports, numbered 0 through FFFFH.

[c] PCIe spec citation:
If a bridge implements an I/O address range,...I/O address range will be
aligned to a 4 KB boundary.

Overview:
---------
Above usecase requirements can be solved by PCI PF group owner accessing
its group member PCI VFs legacy registers using an admin virtqueue of
the group owner PCI PF.

Two new admin virtqueue commands are added which read/write PCI VF
registers.

The third command suggested by Jason queries the VF device's driver
notification region.

Software usage example:
-----------------------
One way to use and map to the guest VM is by using vfio driver
framework in Linux kernel.

                +----------------------+
                |pci_dev_id = 0x100X   |
+---------------|pci_rev_id = 0x0      |-----+
|vfio device    |BAR0 = I/O region     |     |
|               |Other attributes      |     |
|               +----------------------+     |
|                                            |
+   +--------------+     +-----------------+ |
|   |I/O BAR to AQ |     | Other vfio      | |
|   |rd/wr mapper  |     | functionalities | |
|   +--------------+     +-----------------+ |
|                                            |
+------+-------------------------+-----------+
       |                         |
  +----+------------+       +----+------------+
  | +-----+         |       | PCI VF device A |
  | | AQ  |-------------+---->+-------------+ |
  | +-----+         |   |   | | legacy regs | |
  | PCI PF device   |   |   | +-------------+ |
  +-----------------+   |   +-----------------+
                        |
                        |   +----+------------+
                        |   | PCI VF device N |
                        +---->+-------------+ |
                            | | legacy regs | |
                            | +-------------+ |
                            +-----------------+

2. Virtio pci driver to bind to the listed device id and
   use it as native device in the host.

3. Use it in a light weight hypervisor to run bare-metal OS.

Please review.

Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v1->v2:
- addressed comments from Michael
- added theory of operation
- grammar corrections
- removed group fields description from individual commands as
  it is already present in generic section
- added endianness normative for legacy device registers region
- renamed the file to drop vf and add legacy prefix

- added overview in commit log
- renamed subsection to reflect command
---
 admin.tex                     |   5 +-
 transport-pci-legacy-regs.tex | 106 ++++++++++++++++++++++++++++++++++
 transport-pci.tex             |   2 +
 3 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 transport-pci-legacy-regs.tex

diff --git a/admin.tex b/admin.tex
index 47556f3..8fef32d 100644
--- a/admin.tex
+++ b/admin.tex
@@ -115,7 +115,10 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 \hline \hline
 0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands supported for this group type    \\
 0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
-0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
+0x0002 & VIRTIO_ADMIN_CMD_LREG_WRITE & Write legacy registers of a member device    \\
+0x0003 & VIRTIO_ADMIN_CMD_LREG_READ & Read legacy registers of a member device    \\
+0x0004 & VIRTIO_ADMIN_CMD_LQ_NOTIFY_QUERY & Read the queue notification offset for legacy interface \\
+0x0005 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
 \hline
 0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
 \hline
diff --git a/transport-pci-legacy-regs.tex b/transport-pci-legacy-regs.tex
new file mode 100644
index 0000000..9088fe6
--- /dev/null
+++ b/transport-pci-legacy-regs.tex
@@ -0,0 +1,106 @@
+\subsection{Legacy Interfaces: SR-IOV VFs Registers Access}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces: SR-IOV VFs Registers Access}
+
+As described in PCIe base specification \hyperref[intro:PCIe]{[PCIe]} PCI VFs
+do not support the I/O space BAR. A PCI VF hardware device that can support
+legacy interfaces cannot be passthrough to the guest virtual machine
+due to this limitation. To have a transitional virtio device in the guest
+virtual machine, a PCI PF device as a group owner may support accessing its
+group member PCI VF device's legacy registers using an administrative
+virtqueue. This enables minimal intervention in the hypervisor only for
+the purpose of legacy registers access.
+
+A hypervisor software accesses the legacy configuration and device specific
+registers requested by the guest virtual machine using an administrative
+virtqueue. Even though virtqueue driver notifications can be communicated
+through administrative virtqueue, if the PCI PF and VF devices support such
+notifications using a memory-mapped operation, such driver notifications
+are sent using a device defined notification region.
+
+The group owner PCI PF device can optionally enable the driver to access
+its member PCI VFs devices legacy common configuration and device configuration
+registers using an administration virtqueue. Such a PCI PF device supports
+the following commands:
+
+\begin{enumerate}
+\item Legacy Registers Write Command
+\item Legacy Registers Read Command
+\item Legacy Queue Notify Offset Query Command
+\end{enumerate}
+
+\subsubsection{Legacy Registers Write Command}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces: SR-IOV VFs Registers Access / Legacy Registers Write Command}
+
+The Legacy Registers Write Command follows \field{struct virtio_admin_cmd}.
+This command writes legacy registers of a member VF device.
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LREG_WRITE.
+
+The command VIRTIO_ADMIN_CMD_LREG_WRITE uses following structure for
+\field{command_specific_data}:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_lreg_wr_data {
+	u8 offset; /* Starting byte offset of the register(s) to write */
+	u8 register[];
+};
+\end{lstlisting}
+
+This command does not have any command specific result.
+
+\subsubsection{Legacy Registers Read Command}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces: SR-IOV VFs Registers Access / Legacy Registers Read Command}
+
+The Legacy Registers Read Command follows \field{struct virtio_admin_cmd}.
+This command reads legacy registers of a member VF device.
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LREG_READ.
+
+The command VIRTIO_ADMIN_CMD_LREG_READ uses following listed structure for
+\field{command_specific_data}:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_lreg_rd_data {
+	u8 offset; /* Starting byte offset of the register to read */
+};
+\end{lstlisting}
+
+When command completes successfully, \field{command_specific_result}
+uses following listed structure:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_lreg_rd_result {
+	u8 registers[];
+};
+\end{lstlisting}
+
+\subsubsection{Legacy Queue Notify Offset Query Command}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces: SR-IOV VFs Registers Access / Legacy Queue Notify Offset Query Command}
+
+This command returns the notify offset of the member VF for virtqueue
+driver notifications. This command follows \field{struct virtio_admin_cmd}.
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LQ_NOTIFY_QUERY.
+There is no command specific data for this command.
+
+When command completes successfully, \field{command_specific_result}
+uses following listed structure:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_lq_notify_query_result {
+	u8 bar; /* PCI BAR number of the member VF */
+	u8 reserved[7];
+	le64 offset; /* Byte offset within the BAR */
+};
+\end{lstlisting}
+
+The driver that may use the driver notifications region of the VF device
+returned in this result likely attain higher performance or the drier may use
+the VIRTIO_ADMIN_CMD_LREG_WRITE command.
+
+\begin{note}
+The device and driver must encode and decode legacy device specific registers
+using little endian format. Per PCI VF device level big endian format support
+is left for the future.
+\end{note}
+
+\begin{note}
+The PCI VF device should not use PCI BAR 0 when it prefers to support
+legacy interface registers access using its group owner PF. This enables
+hypervisor software to operate with least complexities to compose a legacy
+interface I/O space BAR and passthrough other PCI BARs and PCI device
+capabilities to the guest virtual machine without any translation.
+\end{note}
diff --git a/transport-pci.tex b/transport-pci.tex
index ff889d3..9b58a57 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -1179,3 +1179,5 @@ \subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Options /
         re-examine the configuration space to see what changed.
     \end{itemize}
 \end{itemize}
+
+\input{transport-pci-legacy-regs.tex}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

