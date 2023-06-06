Return-Path: <virtio-dev-return-12873-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B84BC77B7A
	for <virtio-dev@archiver.kernel.org>; Tue,  6 Jun 2023 20:16:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 79E3B3431
	for <virtio-dev@archiver.kernel.org>; Tue,  6 Jun 2023 20:16:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D270986660
	for <virtio-dev@archiver.kernel.org>; Tue,  6 Jun 2023 20:16:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5FBF89865AA; Tue,  6 Jun 2023 20:16:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AE315986673;
	Tue,  6 Jun 2023 20:15:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQXYBfqTCrbHr/YNZ8/zkPfSkWOMmcxtfLtnwUWQqb8ezlCqSiYdyirJbIhytOYsmVywAqj/0yz05i6dWT2nQl5JoxF4DM2M4RTrQeIO6ox6PAjyTnU7Va1dOizfqwKgg0KMqhRLZOuBhnXryTRMjqABVjxxjbE3EDqetm6cYVUIDcCFdW9dDIDTMduAGDWTsgFz4qrsnc9IvNMyPj5PpWjaiayVWcAxdoudBeVdabQ+inwdRHH+Vut1FcvoHDRx0G8fbKH7HSQREV0yA6ubfcdLlzSF1/hfo3xjZypyBEKw20YDOE3Rdhjl8KtXvS83p1IvqVoXmrk4WYZV5Lcpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRnNqqX+oUuyqxMy3AHLiYuyGy9/cX/5f18lGD/DUWI=;
 b=F8R2iqnMdkoQe6swLkx13ve6wcnVzfJW3J3XFD3kPxSzrHRqAv/7L+hsPo8KOlXRDYAf+nePkt6k6tSk35388MQJz+z4AoK6f814p5E76Bm1BJegunLOQpnebk5LYwZIsE1n1E+HP4JuyIOALc2XLKiM9107+nAvbeMoXC09yWTEtIcXuqaQoHkf9/Asj7lEwb4vXr5AQOHtSM+h2nUZTwBWTLjiiWvxlA6oidKr2owFUU/q+aLcOHfWrxDlkSb8R2dqUn9YrQj+QEx03En2a2NxaftPe+s9sIywy/u6ssDyT3kXhLwdGYpBBPMJKAi01yTd4g4+mzQNyJeG1mO6ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.oasis-open.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <virtio-comment@lists.oasis-open.org>, <mst@redhat.com>,
	<cohuck@redhat.com>, <david.edmondson@oracle.com>
CC: <virtio-dev@lists.oasis-open.org>, <sburla@marvell.com>,
	<jasowang@redhat.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Tue, 6 Jun 2023 23:15:14 +0300
Message-ID: <20230606201515.775121-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230606201515.775121-1-parav@nvidia.com>
References: <20230606201515.775121-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|BY5PR12MB4934:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2bf153-a6b4-405c-2a68-08db66cacfb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S26Y0JFwOUal7bQDFHsgwT7dz/m14sB7Y1SkkxEDUKC61KCFTRmGvdTeDDitiyo8TPhBM41+ShAGH7onF+8GCXnFiBYqv8W5igRdVCMlU4gP0ztx+FR4Z2q8b0GxG8YSOfs4XW/u0kej0ySLAqC2xhRa5rpHiDtOhpWtC5dNznP7ToamgEPEpK429tIhLTR/unbjsrjvp2qEgKy0CHqHBrAANxRqaNmVRhERhxAoeywaSeV8s+fe4p4iSXi+36l86cW9yB4c1ykCUpgOH1EivA0C0DvPWZSIn05Cobkiq+TsX7SLyj3s/+QPk+xG/f5IQeG1wGn3320ZaX75OMke2NHWeL4bh3Dc855XlHpTNfIgZhLQIRKTySRCMDiNTilViMLKvGDqySDdWafH7rZUiAONT5tRvAYJ/YTChf8cbVSV0kZe61LeiMfJ9XJ7yCvcE1saHxsDWPzntcTkXl4cXcCPQvkdF1b0gCCL9jIKQW+2dxrqkMO9WNAGnnJcByF1dCZTTf6JwK4U9Uj+cXho9Tczjk5gQysqKLALJ+Qst00H5zQUlWnXrQdZKdH2GDb+TYBCcP3qKHrbb8M5vMkJ1C9UtDi3ler1AeYfnA4BWmwmTL2zVyOkhXHYzYcW1ixV2oG5iHbHjd33XBS0rfmanqaZ31aq0I57D//WK37Cp2iCVi7INqNErnzqZYYN7J9zy4UL5Nr+xLc9/As4Eb8y5GrZWgwgdSBOeRTA5c9lXYNgZ0ZXvgTHpSck/n2XqhqJeN+mApkMP+L6kYYiyPR1zJc+qbJL/Md/YAPeHJPhH78=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(107886003)(186003)(1076003)(26005)(16526019)(2616005)(426003)(336012)(966005)(83380400001)(47076005)(36756003)(6666004)(36860700001)(82310400005)(2906002)(30864003)(8936002)(8676002)(110136005)(54906003)(40480700001)(82740400003)(478600001)(4326008)(5660300002)(40460700003)(86362001)(316002)(70586007)(41300700001)(70206006)(7636003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 20:15:45.6056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2bf153-a6b4-405c-2a68-08db66cacfb6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4934
Subject: [virtio-dev] [PATCH v4 2/3] transport-pci: Introduce legacy registers access commands

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
       |                         |
       |                  Driver notifications
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

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v3->v4:
- moved noted to the conformance section details in next patch
- removed queue notify address query AQ command on Michael's suggestion,
  though it is fine. Instead replaced with extending virtio_pci_notify_cap
  to indicate that legacy queue notifications can be done on the
  notification location.
- fixed spelling errors.
- replaced administrative virtqueue to administration virtqueue
- added queue notification capability register to indicate legacy q
  notification supported
v2->v3:
- adddressed Jason and Michael's comment to split single register
  access command to common config and device specific commands.
- dropped the suggetion to introduce enable/disable command as
  admin command cap bit already covers it.
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
 admin.tex                     |  10 ++-
 transport-pci-legacy-regs.tex | 122 ++++++++++++++++++++++++++++++++++
 transport-pci.tex             |  19 ++++++
 3 files changed, 150 insertions(+), 1 deletion(-)
 create mode 100644 transport-pci-legacy-regs.tex

diff --git a/admin.tex b/admin.tex
index e51f9e6..8f55bf4 100644
--- a/admin.tex
+++ b/admin.tex
@@ -117,7 +117,15 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 \hline
 0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
 \hline
-0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
+0x0002 & VIRTIO_ADMIN_CMD_LCC_REG_WRITE & Write legacy common configuration registers of a member device    \\
+\hline
+0x0003 & VIRTIO_ADMIN_CMD_LCC_REG_READ & Read legacy common configuration registers of a member device    \\
+\hline
+0x0004 & VIRTIO_ADMIN_CMD_LD_REG_WRITE & Write legacy device registers of a member device    \\
+\hline
+0x0005 & VIRTIO_ADMIN_CMD_LD_REG_READ & Read legacy device registers of a member device    \\
+\hline
+0x0006 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
 \hline
 0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
 \hline
diff --git a/transport-pci-legacy-regs.tex b/transport-pci-legacy-regs.tex
new file mode 100644
index 0000000..2a464da
--- /dev/null
+++ b/transport-pci-legacy-regs.tex
@@ -0,0 +1,122 @@
+\subsection{Legacy Interfaces: SR-IOV VFs Registers Access}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces: SR-IOV VFs Registers Access}
+
+As described in PCIe base specification \hyperref[intro:PCIe]{[PCIe]} PCI VFs
+do not support the I/O space BAR. A PCI VF hardware device that can support
+legacy interfaces cannot be attached as passthrough device to the guest
+virtual machine due to this limitation. To have a transitional virtio device
+in the guest virtual machine, a PCI PF device as a group owner may support
+accessing its group member PCI VF device's legacy registers using 
+the administration virtqueue. This enables minimal involvement in the
+hypervisor only for the purpose of legacy registers access.
+
+A hypervisor software accesses the legacy configuration and device specific
+registers requested by the guest virtual machine using an administration
+virtqueue on behalf of the guest virtual machine. Even though virtqueue
+driver notifications can be communicated through administration virtqueue,
+if the PCI VF device support such notifications using a memory-mapped
+operation, such driver notifications are sent using a device defined
+notification region.
+
+The PCI VF device SHOULD NOT expose PCI BAR 0 when it prefers to support
+legacy interface registers access using its group owner PF. This enables
+hypervisor software to operate with least amount of complexities to compose
+a legacy interface I/O space BAR and passthrough other PCI BARs and PCI device
+capabilities to the guest virtual machine without any translation.
+
+The group owner PCI PF device can optionally enable the driver to access
+its member PCI VFs devices legacy common configuration and device configuration
+registers using an administration virtqueue. Such a PCI PF device supports
+the following commands:
+
+\begin{enumerate}
+\item Legacy Common Configuration Registers Write Command
+\item Legacy common Configuration Registers Read Command
+\item Legacy Device Specific Registers Write Command
+\item Legacy Device Specific Registers Read Command
+\end{enumerate}
+
+\subsubsection{Legacy Common Configuration Registers Write Command}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces: SR-IOV VFs Registers Access / Legacy Common Configuration Registers Write Command}
+
+The Legacy Common Configuration Registers Write Command follows
+\field{struct virtio_admin_cmd}.
+This command writes legacy common configuration registers of a member VF device.
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LCC_REG_WRITE.
+
+The command VIRTIO_ADMIN_CMD_LCC_REG_WRITE uses following structure for
+\field{command_specific_data}:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_lcc_reg_wr_data {
+	u8 offset; /* Starting byte offset of the common configuration register(s) to write */
+	u8 register[];
+};
+\end{lstlisting}
+
+This command does not have any command specific result.
+
+\subsubsection{Legacy Common Configuration Registers Read Command}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces: SR-IOV VFs Registers Access / Legacy Common Configuration Registers Read Command}
+
+The Legacy Common Configuration Registers Read Command follows \field{struct virtio_admin_cmd}.
+This command reads legacy common configuration registers of a member VF device.
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LCC_REG_READ.
+
+The command VIRTIO_ADMIN_CMD_LCC_REG_READ uses following listed structure for
+\field{command_specific_data}:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_lcc_reg_rd_data {
+	u8 offset; /* Starting byte offset of the register to read */
+};
+\end{lstlisting}
+
+When command completes successfully, \field{command_specific_result}
+uses following listed structure:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_lcc_reg_rd_result {
+	u8 registers[];
+};
+\end{lstlisting}
+
+\subsubsection{Legacy Device Registers Write Command}\label{sec:Virtio Transport
+Options / Virtio Over PCI Bus / Legacy Interfaces: SR-IOV VFs Registers Access / Legacy Device Registers Write Command}
+
+The Legacy Device Registers Write Command follows \field{struct virtio_admin_cmd}.
+This command writes legacy device registers of a member VF device.
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LD_REG_WRITE.
+
+The command VIRTIO_ADMIN_CMD_LD_REG_WRITE uses following structure for
+\field{command_specific_data}:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_ld_reg_wr_data {
+	u8 offset; /* Starting byte offset of the device register(s) to write */
+	u8 register[];
+};
+\end{lstlisting}
+
+This command does not have any command specific result.
+
+\subsubsection{Legacy Device Registers Read Command}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces: SR-IOV VFs Registers Access / Legacy Common Configuration Registers Read Command}
+
+The Legacy Device Registers Read Command follows \field{struct virtio_admin_cmd}.
+This command reads legacy device specific registers of a member VF device.
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LD_REG_READ.
+
+The command VIRTIO_ADMIN_CMD_LD_REG_READ uses following listed structure for
+\field{command_specific_data}:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_ld_reg_rd_data {
+	u8 offset; /* Starting byte offset of the register(s) to read */
+};
+\end{lstlisting}
+
+When command completes successfully, \field{command_specific_result}
+uses following listed structure:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_ld_reg_rd_result {
+	u8 registers[];
+};
+\end{lstlisting}
diff --git a/transport-pci.tex b/transport-pci.tex
index a5c6719..42bc104 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -541,6 +541,7 @@ \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options
 struct virtio_pci_notify_cap {
         struct virtio_pci_cap cap;
         le32 notify_off_multiplier; /* Multiplier for queue_notify_off. */
+        u8 legacy_q_notify_supported;
 };
 \end{lstlisting}
 
@@ -560,6 +561,14 @@ \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options
 the same Queue Notify address for all queues.
 \end{note}
 
+\field{legacy_q_notify_supported} when set to 1, indicates that the device
+supports legacy queue notifications at this notification location. Legacy Queue
+Notification address is derived within a BAR for a virtqueue:
+
+\begin{lstlisting}
+        cap.offset
+\end{lstlisting}
+
 \devicenormative{\paragraph}{Notification capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
 The device MUST present at least one notification capability.
 
@@ -596,6 +605,14 @@ \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options
 cap.length >= queue_notify_off * notify_off_multiplier + 4
 \end{lstlisting}
 
+\paragraph{Legacy Interfaces: Notification capability}\label{par:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: Notification capability}
+
+The device SHOULD set \field{legacy_q_notify_supported} when the device
+notification location supports legacy driver notifications.
+
+The driver in the hypervisor MAY use notification location for accessing
+legacy queue notify address when the device supports it.
+
 \subsubsection{ISR status capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / ISR status capability}
 
 The VIRTIO_PCI_CAP_ISR_CFG capability
@@ -1212,3 +1229,5 @@ \subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Options /
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

