Return-Path: <virtio-dev-return-12838-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A2EC7EE24
	for <virtio-dev@archiver.kernel.org>; Fri,  2 Jun 2023 20:36:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3E4A62B038
	for <virtio-dev@archiver.kernel.org>; Fri,  2 Jun 2023 20:36:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 33CA2986813
	for <virtio-dev@archiver.kernel.org>; Fri,  2 Jun 2023 20:36:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 25E139867EC; Fri,  2 Jun 2023 20:36:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EC41598683F;
	Fri,  2 Jun 2023 20:36:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/MHqB4Jez08l7g53rLe5/BSCJE4BBLr0MRuQCzCSoCVlhzc4q2DfLK8zfOnqpvwTLWK2pYq/xtzs3NQNW06kgWBtyq3W8ObiCGa3mOBpb05HDEv6phyo3m2YZsf97XXHoJLTURmDZDmNMUfL/BzPLxzHoJONV2uPUunBRRrxtSSoplaN90L4JQf4LY3gk9is+CWLT96nsD5sDt5iE6npZdgM6BzzeRrSlQGYNWavt73VGGmP18ttQ3n5btL7onH/f/xOWihrqRWBmcvcA+2jn3z64L1WjRkAulu2jyDpvxPBwBrKyJsVRfWTSvBF3cjQP0em9GziyV0CX70g1umsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fTo/VZh7SSU2K6AwTO669VZgMpqTTGDmLtYLDPmcZ4=;
 b=UVeNsJivAxBbEAG7WRX8I3pmN9g2CEM70OUwS9LgjCiI+HAYJ7jx/E/MITRM39C9qowCeMmpTmmvAXP4O+eEhRx3WEqzOro5KDrd1L5hEW+0i+3tBo5cG/RxYQ8fXUhSjXPYLenOD+0KTWCBeRrTsLPP+4xsp+QfGotOEa2TJQAJwWcIw24HLtNUVXw47lBQX98jKE6kh3CCCTa07XqAexgc1bicoxANfV+o35HajR+dtP9BSeUj+RTcef+VkzHRz1t7xbzXk7hsqKVIIMlt86LlTJrZpxlvgiswbA4Mlmd8HbhcF5XsrE9CAWg+AZmnQAq5dtWesJROBzNbRfmGUA==
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
Date: Fri, 2 Jun 2023 23:36:03 +0300
Message-ID: <20230602203604.627661-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230602203604.627661-1-parav@nvidia.com>
References: <20230602203604.627661-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT050:EE_|SJ2PR12MB9161:EE_
X-MS-Office365-Filtering-Correlation-Id: efd3e2c0-542e-4eef-cf1b-08db63a90cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AmCgB5UG/A4iF1iQZaCa8ZLFeIJUYhZ6PQ6JG2h1bx5ZPCIysUsqkmZIWRWcLvZ2zxG3bAF/1OFg4JRGzeNFrfc8F3InxepwOWXoAnBWNLf8sPWM+zLCoIV9H9TcGy4uhyCtpXifvRVZ4P3RK/TWtUeEErApSSYiurLzyiDcVDZqDcXmTLxBbCJQqPv1BYC34JwvrzQM7rd1TeHoHlAu9/thEcpNxhBDT8gqyoBr1lhA3bwqUmLYUkHCvXnEyZZebG57rCAGH5/2JFsad0Rjh4VlZUHiNQkDLRZ15CbfeJt2Vnb7Cj7Ss8GRRgGIQAgK6n0SExkwdNcHQo8MP2rixMGCX0PbW+7djXafET1IqZDu6p9VkuuhaLY3MK3vWJP/cp+d6plH/oaJPhNNsWSoBMBqfoZFNnA2AWde7LMyycF6a5haVcYkLgEVw7weUfnQP2mCBct7A3E5VnoKLFcZq8s9HxAJxGePk5u945miP5noIZm2fYP14fRqpM55jO6XNjV9M2s/bA35jmi1srwU3HlLOu1yESEHYlXqbWQShNxWgTQkwdAGk+/WMkfIVYljWdToVacjhsIPvhCLwVpPrt7Ld8TxKZbMfK8Xm/gafsivZ560AlU2U8EGGIC49YHdDK3SV1JvSN2W60r7H1F0oqhyPsqdFrXZP0OLeZovBs3eghvbFhP8hSsJKteifVXCj2e1i5bXtFnqsw85J/IKRzW1emNu3xv6+hsJ3gneMKtvQ9zhMYqVlXtggNBxrdMDaDM4S4C8Vq3PR7NOqoo+mg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(5660300002)(70586007)(8936002)(8676002)(2906002)(30864003)(4326008)(316002)(41300700001)(70206006)(54906003)(110136005)(966005)(107886003)(16526019)(186003)(40480700001)(2616005)(83380400001)(26005)(426003)(1076003)(336012)(47076005)(36860700001)(86362001)(40460700003)(82740400003)(478600001)(6666004)(36756003)(7636003)(82310400005)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 20:36:31.7199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efd3e2c0-542e-4eef-cf1b-08db63a90cdd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9161
Subject: [virtio-dev] [PATCH v3 2/3] transport-pci: Introduce legacy registers access commands

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
 admin.tex                     |  12 ++-
 transport-pci-legacy-regs.tex | 153 ++++++++++++++++++++++++++++++++++
 transport-pci.tex             |   2 +
 3 files changed, 166 insertions(+), 1 deletion(-)
 create mode 100644 transport-pci-legacy-regs.tex

diff --git a/admin.tex b/admin.tex
index e51f9e6..5bcde98 100644
--- a/admin.tex
+++ b/admin.tex
@@ -117,7 +117,17 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
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
+0x0006 & VIRTIO_ADMIN_CMD_LQ_NOTIFY_QUERY & Read the queue notification offset for legacy interface \\
+\hline
+0x0007 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
 \hline
 0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
 \hline
diff --git a/transport-pci-legacy-regs.tex b/transport-pci-legacy-regs.tex
new file mode 100644
index 0000000..948ac73
--- /dev/null
+++ b/transport-pci-legacy-regs.tex
@@ -0,0 +1,153 @@
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
+\item Legacy Common Configuration Registers Write Command
+\item Legacy common Configuration Registers Read Command
+\item Legacy Device Specific registers Write Command
+\item Legacy Device Specific registers Read Command
+\item Legacy Queue Notify Offset Query Command
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
+	u8 offset; /* Starting byte offset of the register to read */
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
index a5c6719..72c78f6 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -1212,3 +1212,5 @@ \subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Options /
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

