Return-Path: <virtio-dev-return-12499-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D48DC7EE22
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 03:27:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2B026370F1
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 03:27:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 198E098657E
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 03:27:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0DE399864E1; Wed,  3 May 2023 03:27:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ECD219864C4;
	Wed,  3 May 2023 03:27:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gj1Ujc9jCJVM3jwuKzEf/hfeRPCjz4R3qLC7rxjFk6tC8U0rr55Nm+6p+1IX0tc2ELIbK8P6BCX45Zl1JOGRFKVImn/gRv0HOsLfqsoKEAAixQrz5PioEpc/gSKd6nfupg3rC7Iw67nfR3CvR/pthSj1WF2+SMa2b9Nkt1+Psl1Bpu4gzuOil+tWyGU67hX5/cCQbEN2Ix4BKyuZhoIrrC8moC7biSF93+fHqkvbPgxGKV5PXw3yJdNliHPLH77DKrCaIuvMNajwDt2pBpEQ9YoBM9XkxA0DoPo4A+icc8XXJ7iZb9aXFSXgCzK11alG98lDeOszWhPLm2nIYTIVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UN6uPy0Zc5tlskukJ2f/UdlzqKeHB+/b5I+KZZfdNP4=;
 b=K6t9fOnYcb+4y2fXFfHN6NS9dc0taqq1s3S7YN4C8ZLTmR5AbqVzqQbn47VPBqsKfUe/Jsx2/rwHIXa+m1srql5r6Q83UQcX/VEIYVYU5AVHgS5UvicFV2roo6OorgEf0Ux2VGgsdA1OO64fl9K4a6sWkedBgc5LNvzt/TYkODoHIEGeyCorkTpV3jPfggXiX+s8kKDdgVB56evdb/+rHEzvrwD+KV9nSyL1KYWCLF2UDBbFmgNXNXgmCH71/L0JOcBVkviPWEwcj8ExRhpm3ajPuzR/wNjlGBaH8h/qKMgQHnfH5LQFdxIqZq0rf7sGhvJf+STW2P8vevL9izz6pQ==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>,
	<david.edmondson@oracle.com>
CC: <sburla@marvell.com>, <jasowang@redhat.com>,
	<virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Wed, 3 May 2023 06:26:58 +0300
Message-ID: <20230503032659.530330-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230503032659.530330-1-parav@nvidia.com>
References: <20230503032659.530330-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT059:EE_|PH7PR12MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 458f0151-5115-48b0-7cbc-08db4b865633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oiSCkN/rogqIPwpQ3KR/2whUPuk5XpJr4sipNKkqRVZ5d+kgCNxUdLxY3aXwqAxPH9iszvyiqJ9cvuZKOcaUovNAhtW/fL4G48xTI+F1MNFM3TDoywRpAjNb2ouldBE0qbjVKrzJc2N49ILFwr1iSWjvYOByja95ubdm3XAuMhi8oQagEMmb+MftDPASk8JWtyhXaLev3WuFLcrTu/7TPBMA9Y/jTdFhZZg0FEq4OkU1oDaTzGIYB5NnMkk4wvlVILIrQh0ubika5Fr6TughF7VqQ91X/+elCM0f3Z8FA1j7YjDjDFnJND3bk1iGhkTY5GIVjq2UsVkAXePNeD6tt7MnLstGLRxFNBBtGoH19jpM9eJlZHEl83ePW3XdsloIqnQtmSQcjTac2OQIt7TTBJJvCeRmhBcRRORxVwEzALJZrVOt2w0bnxHhH0W3Wtq3rUZ+gmFgVVLUZS9swgbUnQp57Ibcs+HaN5e1pybo78gAZanbgIUr7RRM0ogK2Wco4tywiU7tUn35DaByYyTAUMTafGs2z7RqB8sc3kkbOjHc044KCfC+nPruc12/nk9fusMTQ4xkT1z8XY943G3oskoDV+qGJYbJZ5NsYhZEcxPc64TEwYsgbWa/z867KMaak9RoDEFrgVUEJULxxwYSNaypLTtb6TTT1Zq3xG86a92rZPL9KrcDbNbtLiCwKiAMh3kYv0sriPAsxMwQidtBlAvbhviUOIxKWYp8x63Z+JRuSiLk9zItu8nHwmgbYfDw
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(83380400001)(47076005)(2616005)(107886003)(426003)(336012)(16526019)(26005)(1076003)(478600001)(186003)(40480700001)(110136005)(966005)(6666004)(54906003)(2906002)(8936002)(86362001)(8676002)(356005)(7636003)(36756003)(5660300002)(41300700001)(70206006)(70586007)(82740400003)(4326008)(316002)(40460700003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 03:27:34.5566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 458f0151-5115-48b0-7cbc-08db4b865633
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925
Subject: [virtio-dev] [PATCH v1 1/2] transport-pci: Introduce legacy registers access commands

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

Above usecase requirements can be solved by PCI PF group owner enabling
the access to its group member PCI VFs legacy registers using an admin
virtqueue of the group owner PCI PF.

Software usage example:
-----------------------
The most common way to use and map to the guest VM is by
using vfio driver framework in Linux kernel.

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

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v0->v1:
- addressed comments, suggesetions and ideas from Michael Tsirkin and Jason Wang
- far more simpler design than MMR access
- removed complexities of MMR device ids
- removed complexities of MMR registers and extended capabilities
- dropped adding new extended capabilities because if if they are
  added, a pci device still needs to have existing capabilities
  in the legacy configuration space and hypervisor driver do not
  need to access them
---
 admin.tex                 |  5 ++-
 transport-pci-vf-regs.tex | 84 +++++++++++++++++++++++++++++++++++++++
 transport-pci.tex         |  2 +
 3 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 transport-pci-vf-regs.tex

diff --git a/admin.tex b/admin.tex
index 648253c..852ee04 100644
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
diff --git a/transport-pci-vf-regs.tex b/transport-pci-vf-regs.tex
new file mode 100644
index 0000000..16ced32
--- /dev/null
+++ b/transport-pci-vf-regs.tex
@@ -0,0 +1,84 @@
+\subsection{SR-IOV VFs Legacy Registers Access}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / SR-IOV Legacy Registers Access}
+
+As described in PCIe base specification \hyperref[intro:PCIe]{[PCIe]} PCI VFs
+do not support IOBAR. A PCI PF device can optionally enable driver to access
+its member PCI VFs devices legacy common configuration and device configuration
+registers using an administration virtqueue. A PCI PF group owner device that
+supports its member VFs legacy registers access via the administration
+virtqueue should supports following commands.
+
+\begin{enumerate}
+\item Legacy Registers Write
+\item Legacy Registers Read
+\item Legacy Queue Notify Offset Query
+\end{enumerate}
+
+\subsubsection{Legacy Registers Write}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / SR-IOV Legacy Registers Access / Legacy Registers Write}
+
+Legacy registers write admin command follows \field{struct virtio_admin_cmd}.
+This command writes legacy registers of a member VF device. Driver should write
+appropriate register \field{size} depending on the width of the legacy
+common registers or device specific registers.
+Driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LREG_WRITE.
+Driver sets \field{group_type} to 1 for VFs.
+Driver sets \field{group_member_id} to a valid VF number.
+
+The \field{command_specific_data} has following listed structure format:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_lreg_wr_data {
+	u8 offset; /* Starting byte offset of the register(s) to write */
+	u8 size; /* Number of bytes to write into the register. */
+	u8 register[];
+};
+\end{lstlisting}
+
+This command does not have any command specific result.
+
+\subsubsection{Legacy Registers Read}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / SR-IOV Legacy Registers Access / Legacy Registers Read}
+
+Legacy registers read admin command follows \field{struct virtio_admin_cmd}.
+This command reads legacy registers of a member VF device. Driver should write
+appropriate register \field{size} depending on the width of the legacy
+common configuration registers or device specific registers.
+Driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LREG_READ.
+Driver sets \field{group_type} to 1 for VFs.
+Driver sets \field{group_member_id} to a valid VF number.
+
+The \field{command_specific_data} has following listed structure format:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_lreg_rd_data {
+	u8 offset; /* Starting byte offset of the register to read */
+	u8 size; /* Number of bytes to read from the registers */
+};
+\end{lstlisting}
+
+When command completes successfully, command result contains following
+listed content:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_lreg_rd_result {
+	u8 registers[];
+};
+\end{lstlisting}
+
+\subsubsection{Legacy Queue Notify Offset Query}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / SR-IOV Legacy Registers Access / Legacy Queue Notify Offset Query}
+
+This command returns the notify offset of the member VF for queue
+notifications. This command follows \field{struct virtio_admin_cmd}.
+Driver sets command opcode \field{opcode} to VIRTIO_ADMIN_CMD_LQ_NOTIFY_QUERY.
+There is no command specific data for this command.
+Driver sets \field{group_type} to 1.
+Driver sets \field{group_member_id} to a valid VF number.
+
+When command completes successfully, command result contains the queue
+notification address in the listed format:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_lq_notify_query_result {
+	u8 bar; /* PCI BAR number of the member VF */
+	u8 reserved[7];
+	le64 offset; /* Byte offset within the BAR */
+};
+\end{lstlisting}
diff --git a/transport-pci.tex b/transport-pci.tex
index ff889d3..b187576 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -1179,3 +1179,5 @@ \subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Options /
         re-examine the configuration space to see what changed.
     \end{itemize}
 \end{itemize}
+
+\input{transport-pci-vf-regs.tex}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

