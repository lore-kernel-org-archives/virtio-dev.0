Return-Path: <virtio-dev-return-12909-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BE8C7EE29
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:04:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5E566183AF2
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:03:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 53CB398669E
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:03:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 473FC98668E; Fri,  9 Jun 2023 02:03:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2FA459867FA;
	Fri,  9 Jun 2023 02:03:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+wfkXHLoXLHFXJxRFhShhxN70pZ9xdxINPf6zPNHOQp5DZIn8V1j6DfUXvCiDCBvYbjmJnTvtALdjT36s+L4kD/uLKcEM340sDVUA88n3S8GDlSFLxlllyn2FYH08HAVJ9XFrdsvDm60nfYl21LlDSxAqTpmQly47sDNwy5l9IdLNL80gmNqDNyIPhnCKeGqdT7nHmwnaOYb/ieRjAFAxNOudnmwzyh2i4WB+HLZI0qlCLyo/1SIg09TylU4o71k4RGzcGknMjhPZUcKCiylwzy/5Eawf0jUAiQZACyd+5TeroTiywRUCnCDSrd8tXrNDlNFzK73NjRu/EJmJq4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+F3kiJHcgK/DrBYo4wxUn/QduBShmP3J5oufEL1wqU=;
 b=ChMiGwocYC6e+Yl8D9IsT0n6xOhBSRbhWMf3Fi16BHqL0IB+ReQAaUkVkCugK1zJJW2pH5qBe7jYLSEthI6jMO6GJOzSC83bF80Dj31yzTlA5DBXoBUF7NmKRyNyXvG0g3AsyVCmcLKAF2GdDZhf+8Eju50El/ue9SN2zRhtz2VHHqGVyG7G/IZz6UROcw0/j7DIvF//iIwaE4soj+D3cKqMIy1emUM71gxYV6S1Gt0ljnCVgelp5+9yx5MUMnCcLiqruQfIwGU7FQUqKCpG6l+lBLhAC46sTX+tp/asFz5lf3KodsGS6zKpnoo2ndw5b17HHwHF6Y5ESIh3FbH2JA==
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
Date: Fri, 9 Jun 2023 05:02:47 +0300
Message-ID: <20230609020248.869700-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230609020248.869700-1-parav@nvidia.com>
References: <20230609020248.869700-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT011:EE_|MW4PR12MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: f63b1701-1656-42c0-fc1f-08db688db295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Oxb8rt8njWEf4282M1tY1uQglzpGkABkiX7mYP2Yyc13byfLB4MI57PU9qs9ZZzRru4e6siBBmQk/g2B00wSzw5zz05EHd3Ykj77NTyfSvnV0SJbFr+SgWKggvBmdLTo5aDo3dJF/29FeX4PUgnvw2sueCKdSMciqYzxMKWGsjzczdTjnrLc4fIvzbKwg8Iz/t9sxo8ZF26Zl5ScmCsoNJ8oT+oXjRZGJNvOx5/n3s7k+0Uynckr/u6UJrPdXL9TfThhpAEVQykYZDK52VqkVVTPI/zULsziqWye48JYlSNvHl8UhaexNkBeEbHTxXXYsLd5ZcM9F9SLtYdezmkzBXi3S0TpDNX+gABKu/wy9vt7mP3m5H81lkM0qs4LpXaDw7sZW4tcC2RO/zUF8po/Cbco2sT6p/xcW5bX0dDMCfGWm+oGQpa+eh7EOrSpOUgDtcqqcG/TsSA6tVlLALeimm8seafUrJ+QUGmkm/E45OuUYlYNoP+88j71P9cQD7IH//uxEj4aPKVh5OML56PVbMy88Pj/BDqvc8orQ3awjzYC3lWuObaxrusOqeie2I7dFnY5RicRWM/zK6l/4PVBQ3vHUva4SZhi5yOgjQC4Uw3raunj+STOS090rCZwbG//ezVf9ftA15nXFRiw7YUf4YjfODSEaLtA7cfXU26P0ay77ghaJvyU9tgnfE3f7di6VmSlfyeIKS/ETQWY5s3Hhn3Jxi64TaBwJVrlXxvjutxEZh24oYRv1fJYbwN9VPbukwDDv/kucmAOZpGirJq/Rw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(70586007)(70206006)(4326008)(36756003)(40480700001)(5660300002)(41300700001)(8936002)(8676002)(316002)(54906003)(110136005)(966005)(30864003)(478600001)(40460700003)(2906002)(83380400001)(6666004)(82310400005)(107886003)(426003)(186003)(1076003)(26005)(336012)(36860700001)(2616005)(7636003)(356005)(16526019)(86362001)(47076005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 02:03:19.7502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f63b1701-1656-42c0-fc1f-08db688db295
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167
Subject: [virtio-dev] [PATCH v5 3/4] admin: Add group member legacy register access commands

Introduce group member legacy common configuration and legacy device
configuration access read/write commands.

Group member legacy registers access commands enable group owner driver
software to access legacy registers on behalf of the guest virtual
machine.

Usecase:
========
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
=====================
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
=========
Above usecase requirements is solved by PCI PF group owner accessing
its group member PCI VFs legacy registers using an admin virtqueue of
the group owner PCI PF.

Two types of administration commands are added which read/write PCI VF
registers.

Software usage example:
=======================

1. One way to use and map to the guest VM is by using vfio driver
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

2. Continue to use the virtio pci driver to bind to the
   listed device id and use it as in the host.

3. Use it in a light weight hypervisor to run bare-metal OS.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v4->v5:
- split from pci transport specific patch
- split conformance to transport and generic sections
- written the description of the command as generic with member
  and group device terminology
- reflected many section names to remove VF
- rename fields from register to region
- avoided abbreviation for legacy, device and config
---
 admin-cmds-legacy-access.tex | 136 +++++++++++++++++++++++++++++++++++
 admin.tex                    |  12 +++-
 conformance.tex              |   2 +
 3 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 admin-cmds-legacy-access.tex

diff --git a/admin-cmds-legacy-access.tex b/admin-cmds-legacy-access.tex
new file mode 100644
index 0000000..bcb6d9e
--- /dev/null
+++ b/admin-cmds-legacy-access.tex
@@ -0,0 +1,136 @@
+\subsubsection{Legacy Interfaces: legacy configuration access commands}\label{sec:Basic Facilities of a Virtio Device / Device groups / Group
+administration commands / Legacy Interfaces: legacy configuration access commands}
+
+The group owner device can optionally enable the driver to access its member devices legacy common
+configuration and device configuration region using following listed
+administrative commands:
+
+\begin{enumerate}
+\item Legacy Common Configuration Region Write Command
+\item Legacy common Configuration Region Read Command
+\item Legacy Device Configuration Region Write Command
+\item Legacy Device Configuration Region Read Command
+\end{enumerate}
+
+\paragraph{Legacy Common Configuration Region Write Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group
+administration commands / Legacy Interfaces: legacy configuration access commands / Legacy Common Configuration Region Write Command}
+
+This command writes in a legacy common configuration region of a group member device.
+This command follows \field{struct virtio_admin_cmd}.
+This command uses following structure for \field{command_specific_data}:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_common_cfg_wr_data {
+	u8 offset; /* Starting byte offset of the common configuration region to write */
+	u8 region_data[];
+};
+\end{lstlisting}
+
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE.
+The driver sets valid \field{offset} and associated \field{region_data} bytes to
+write to the common configuration region.
+
+This command does not have any command specific result.
+
+\paragraph{Legacy Common Configuration Region Read Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interfaces: legacy configuration access commands / Legacy Common Configuration Region Read Command}
+
+This command reads from a legacy common configuration region of a group member device.
+This command follows \field{struct virtio_admin_cmd}.
+This command uses following listed structure for \field{command_specific_data}:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_common_cfg_rd_data {
+	u8 offset; /* Starting byte offset of the common configuration region to read */
+};
+\end{lstlisting}
+
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ.
+
+The driver sets valid \field{offset} of the region from where to read
+\field{region_data}.
+
+When command completes successfully, \field{command_specific_result}
+uses following listed structure:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_common_cfg_rd_result {
+	u8 region_data[];
+};
+\end{lstlisting}
+
+\paragraph{Legacy Device Configuration Region Write Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interfaces: legacy configuration access commands / Legacy Device Configuration Region Write Command}
+
+This command writes in a legacy device configuration registers of a group member device.
+This command follows \field{struct virtio_admin_cmd}.
+This command uses following structure for \field{command_specific_data}:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_ld_reg_wr_data {
+	u8 offset; /* Starting byte offset of the device configuration region to write */
+	u8 region_data[];
+};
+\end{lstlisting}
+
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_DEV_REG_WRITE.
+The driver sets valid \field{offset} and associated \field{region_data} bytes to
+the device configuration region.
+
+This command does not have any command specific result.
+
+\paragraph{Legacy Device Registers Read Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interfaces: legacy configuration access commands / Legacy Device Configuration Region Read Command}
+
+This command reads from a legacy device configuration region of a group member device.
+This command follows \field{struct virtio_admin_cmd}.
+
+This command uses following listed structure for \field{command_specific_data}:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_dev_cfg_rd_data {
+	u8 offset; /* Starting byte offset of the device configuration region to read */
+};
+\end{lstlisting}
+
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LD_REG_READ.
+The driver sets valid \field{offset} of the device configurationi region from
+where to read \field{region_data}.
+
+When command completes successfully, \field{command_specific_result}
+uses following listed structure:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_ld_reg_rd_result {
+	u8 region_data[];
+};
+\end{lstlisting}
+
+\devicenormative{\paragraph}{Legacy Interfaces: legacy configuration access commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interfaces: legacy configuration access commands}
+
+If the group owner device supports legacy registers access for its group members,
+the device MUST set all corresponding bits for commands VIRTIO_ADMIN_CMD_LCC_REG_WRITE,
+VIRTIO_ADMIN_CMD_LCC_REG_READ, VIRTIO_ADMIN_CMD_LD_REG_WRITE,
+VIRTIO_ADMIN_CMD_LD_REG_READ in the command result of
+VIRTIO_ADMIN_CMD_LIST_QUERY in \field{device_admin_cmd_opcodes}.
+
+The device MUST encode and decode legacy device specific registers using
+little-endian format.
+
+The device MUST fail VIRTIO_ADMIN_CMD_LCC_REG_WRITE, VIRTIO_ADMIN_CMD_LCC_REG_READ
+commands for the invalid offset which is outside the legacy common configuration
+register's address range.
+
+The device MUST fail VIRTIO_ADMIN_CMD_LD_REG_WRITE, VIRTIO_ADMIN_CMD_LD_REG_READ
+commands for the invalid offset which is outside the legacy device specific
+register's address range.
+
+\drivernormative{\paragraph}{Legacy Interfaces: legacy configuration access commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interfaces: legacy configuration access commands}
+
+The driver MUST encode and decode legacy device specific registers using
+little-endian format.
+
+The driver SHOULD send VIRTIO_ADMIN_CMD_LCC_REG_WRITE and
+VIRTIO_ADMIN_CMD_LCC_REG_READ commands with a valid offset which is in the
+legacy common configuration region address range.
+
+The driver SHOULD send commands VIRTIO_ADMIN_CMD_LD_REG_WRITE and
+VIRTIO_ADMIN_CMD_LD_REG_READ with a valid offset which is in the legacy
+device specific configuration region address range.
diff --git a/admin.tex b/admin.tex
index fd3b97d..49a0b6f 100644
--- a/admin.tex
+++ b/admin.tex
@@ -117,7 +117,15 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 \hline
 0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
 \hline
-0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
+0x0002 & VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE & Write legacy common configuration region of a member device \\
+\hline
+0x0003 & VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ & Read legacy common configuration region of a member device \\
+\hline
+0x0004 & VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE & Write legacy device configuration region of a member device \\
+\hline
+0x0005 & VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ & Read legacy device configuration region of a member device \\
+\hline
+0x0006 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
 \hline
 0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
 \hline
@@ -286,6 +294,8 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 supporting multiple group types, the list of supported commands
 might differ between different group types.
 
+\input{admin-cmds-legacy-access.tex}
+
 \devicenormative{\subsubsection}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
 
 The device MUST validate \field{opcode}, \field{group_type} and
diff --git a/conformance.tex b/conformance.tex
index 01ccd69..6bac4b0 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -260,6 +260,8 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}
 \item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Endianness}
 \item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Message Framing / Legacy Interface: Message Framing}
+\item Section \ref{devicenormative:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interfaces: legacy configuration access commands}
+\item Section \ref{drivernormative:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interfaces: legacy configuration access commands}
 \item Section \ref{sec:General Initialization And Device Operation / Device Initialization / Legacy Interface: Device Initialization}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery / Legacy Interfaces: A Note on PCI Device Discovery}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

