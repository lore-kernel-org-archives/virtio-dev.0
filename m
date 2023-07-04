Return-Path: <virtio-dev-return-13227-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97712EB64DA
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 23:38:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E06EC42563
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 23:38:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D8AD898671B
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 23:38:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CBDE898408C; Tue,  4 Jul 2023 23:38:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0D56D9868D0;
	Tue,  4 Jul 2023 23:38:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L79E358Ifr+u29XwnXjmaIdBXBde0u4vxkAPmz0lHPoQvgLXhziohmQUFiH/0cjG76ZdAfNAbkZ30GgKo6Z3uG4YDAcgwMmEDiOLUVvHOiDSy5um6PHWPEen0IaSfyWddfyHTnCyiST3HDY0a3qd8fZeF9y26tFBYYiVOcTT26oC44m+K3cJak/RsCeHrkRktSfi4B8Um0TTXsWgk3X/VRsbayNdutjk65PP8RqtceZ6Ux3EuVmtOZA6cFHFxObMmC1zd5pwMUZtSui701A2MMz84eLhKA/A6eSaey85o6GlXYsB9hFBMp3i2XwWFc2GO1QN3CIoiNtR3/qGyHJXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDFRd/JZ1t2ROuxXkdwkbh8UwCWiUm252kEE3leFVN4=;
 b=nu2qkSS3Fswqk6szD4diOq0XngvdY1bgvTwCzNCxhNXcGoSEHeXu1TssvbVRML8x85jDSchZ4gWu69ZNMXh/GzfRHUNpkxTTP2lAqGG9ifOxNrILQZq3fCzIrZuJhSQOPKJbywmjEFf40uDy5TE/JwweTQcxCusNv4LR/FBhleM9akCQatpmzYoLgj3YyQ61Ln4M1EEKgrD50j641yBJ4E601tZ4F1BvgqCAxJ81y0EOqQsjs+2oM+yiXaLv0CxrW6eLr+/gqAXFGqMKoyRF73tkT3cNsMscn9sBneA+SJrwwylv/MDuibG9/xJVVjqnL88LSRZWND4uJq5dpYgrKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.oasis-open.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <virtio-comment@lists.oasis-open.org>, <mst@redhat.com>,
	<cohuck@redhat.com>, <david.edmondson@oracle.com>
CC: <virtio-dev@lists.oasis-open.org>, <sburla@marvell.com>,
	<jasowang@redhat.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Wed, 5 Jul 2023 02:37:23 +0300
Message-ID: <20230704233724.22394-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230704233724.22394-1-parav@nvidia.com>
References: <20230704233724.22394-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT104:EE_|PH7PR12MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c8c1c7f-5bff-4e71-9e8b-08db7ce7b00c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xluWrWqiLTt9qzOUqeszZ7efa1bMlcj+eeqUvxgHMZ2RfZ0ur05PIDTDqjz3Jc+yy+G6tPCUPLXhqifn89jtvmXQ8yO102TGTdhRDgWjNPGSJFMHj89Wx4fC2TrR9jVbrLO5qdIYXwm1bUsNKTjaBUpHFSjpqqxQBT2uFG0bqBlxjkLnzgDRBvQP/wz6RkCgJhqLQpSz7i34PLLau4Q0PwUmHK9hFZos18/dCeWXTCAlIl6yEEdY0fbN7AJO0g+Aix8u2Nu47fyBycX3IJGx3o9d1/dksTeusfLvVu3N/xl9Q7Qiv1GmQQe98zO8HRq+xGyeXKNcbqE2Vo3DG8mqNHHG3VOTR+vtAOuI/6oAqD+cNkvaNxVLRt54E/POLVvT7q6+okDTiD1t/I27ClY2UNsiQdOM8zV7/u7qxyoE8CvFoWfRP9pUM1n66wVjgJxFZRt6KGWVi6T3PGdD8Gj4ZySjdt7z8d7IL7OKNg58xYOV2bE+MvNOr5DifKd5plVZa29jTfiXjwYibEsHDMv8ssWYP0ZVb/N+jdHuiEwU/+x7CbRIgQbPPtnV5lRavqdaU6ulh4Q4kXC8B4+EQ6SGmSwNe0KLupwEFY1U8jJLyvWc+NqyCaxz1RTuCpRKzMFgbnDSrCa7AIIBQah9QPrOpDZisCY6eIs6izIBubEE36noryeirKBPQStDn6mXpq3AN4FCb4JHwh6ccOAltYtB5YRQpVXChQu3IYqoskPLTrxD7Ryk63fUHWkLuq1d74NaLwzujVGyBpZP2ckNJtEvgwZwgC/aZc55TiqILnJs1yw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(336012)(40460700003)(41300700001)(86362001)(30864003)(6666004)(82310400005)(107886003)(47076005)(7636003)(83380400001)(356005)(82740400003)(2616005)(186003)(1076003)(426003)(16526019)(26005)(36860700001)(966005)(40480700001)(54906003)(110136005)(478600001)(316002)(36756003)(4326008)(70586007)(70206006)(8936002)(8676002)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 23:37:53.3307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8c1c7f-5bff-4e71-9e8b-08db7ce7b00c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126
Subject: [virtio-dev] [PATCH v9 3/4] admin: Add group member legacy register access commands

Introduce group member legacy common configuration and legacy device
configuration access read/write commands.

Group member legacy configuration structure access commands enable group
owner driver software to access legacy configuration structure on behalf
of the guest virtual machine.

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
its group member PCI VFs legacy registers using the administration
commands of the group owner PCI PF.

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
|   |rd/wr mapper& |     | functionalities | |
|   | forwarder    |     |                 | |
|   +--------------+     +-----------------+ |
|                                            |
+------+-------------------------+-----------+
       |                         |
   Config region                 |
     access                Driver notifications
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
v8->v9:
- add missing articles in notify query command
- replaced 'this notification' with 'such a notification'
- addressed below comments from Michael
- dropped 'Region' from the commands
- added 7 reserved pad bytes in config write commands
- rewrote from 'use following structure' to 'field' has the following
  struct..
- dropped mentioning to follow struct virtio_admin_cmd.
- added note about command limited to only sriov group type for now
- rewrote the description little differently
v7->v8:
- remove empty line at the end of file
- removed white space at the end
- addressed comments from Michael add link to pci
- renamed region to region_data
- made region_data width to be 16 bytes to cover for 8 bytes offset
- moved generic notification region related normative from pci to
  generic section
v6->v7:
- changed administrative to administration
- renamed admin-access.tex to admin-interface.tex
- large rewrite ad generic admin commands instead of pci
- added theory of operation section
- added driver notification region query command
v5->v6:
- fixed previous missed abbreviation of LCC and LD
v4->v5:
- split from pci transport specific patch
- split conformance to transport and generic sections
- written the description of the command as generic with member
  and group device terminology
- reflected many section names to remove VF
- rename fields from register to region
- avoided abbreviation for legacy, device and config
---
 admin-cmds-legacy-interface.tex | 205 ++++++++++++++++++++++++++++++++
 admin.tex                       |  14 ++-
 conformance.tex                 |   2 +
 3 files changed, 220 insertions(+), 1 deletion(-)
 create mode 100644 admin-cmds-legacy-interface.tex

diff --git a/admin-cmds-legacy-interface.tex b/admin-cmds-legacy-interface.tex
new file mode 100644
index 0000000..09001d5
--- /dev/null
+++ b/admin-cmds-legacy-interface.tex
@@ -0,0 +1,205 @@
+\subsubsection{Legacy Interfaces}\label{sec:Basic Facilities of a Virtio Device / Device groups / Group
+administration commands / Legacy Interface}
+
+In some systems, there is a need to support utilizing the legacy driver with
+the device that do not directly support the legacy interface. In such scenarios,
+a group owner device can provide the legacy interface functionality for the
+group member devices. The driver of an owner device can then access the legacy
+interface of a member device on behalf of the legacy member device driver.
+
+For example, with the PCI SR-IOV group type, group members (VFs) can not present
+the legacy interface in an I/O BAR in BAR0 as expected by the legacy pci driver.
+If the legacy driver is running inside a virtual machine, the hypervisor
+executing the virtual machine can present a virtual device with an I/O BAR in
+BAR0. The hypervisor intercepts the legacy driver accesses to this I/O BAR and
+forwards them to the group owner device (PF) using group administration commands.
+
+The following commands support such legacy interface functionality:
+
+\begin{enumerate}
+\item Legacy Common Configuration Write Command
+\item Legacy Common Configuration Read Command
+\item Legacy Device Configuration Write Command
+\item Legacy Device Configuration Read Command
+\end{enumerate}
+
+These commands are currently only defined for the PCI SR-IOV group type and
+have, generally, the same effect as member device accesses through a legacy
+interface listed in section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}.
+
+\paragraph{Legacy Common Configuration Write Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group
+administration commands / Legacy Interface / Common Configuration Write Command}
+
+This command has the same effect as writing into the virtio common configuration
+structure through the legacy interface. \field{command_specific_data} has the
+following structure:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_common_cfg_wr_data {
+        u8 offset; /* Starting byte offset within the common configuration structure to write */
+        u8 reserved[7];
+        u8 region_data[];
+};
+\end{lstlisting}
+
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE.
+The driver sets valid \field{offset} and associated \field{region_data} bytes to
+write to the common configuration region.
+
+This command does not use \field{command_specific_result}.
+
+\paragraph{Legacy Common Configuration Read Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Common Configuration Read Command}
+
+This command has the same effect as reading from the virtio common configuration
+structure through the legacy interface. \field{command_specific_data} has the
+following structure:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_common_cfg_rd_data {
+	u8 offset; /* Starting byte offset within the common configuration structure to read */
+};
+\end{lstlisting}
+
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ.
+
+The driver sets valid \field{offset} of the region from where to read
+\field{region_data}.
+
+When command completes successfully, \field{command_specific_result}
+uses following structure:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_common_cfg_rd_result {
+        u8 region_data[];
+};
+\end{lstlisting}
+
+\paragraph{Legacy Device Configuration Write Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Device Configuration Write Command}
+
+This command has the same effect as writing into the virtio device configuration
+structure through the legacy interface. \field{command_specific_data} has the
+following structure:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_dev_reg_wr_data {
+        u8 offset; /* Starting byte offset within the device configuration structure to write */
+        u8 reserved[7];
+        u8 region_data[];
+};
+\end{lstlisting}
+
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_DEV_REG_WRITE.
+The driver sets valid \field{offset} and associated \field{region_data} bytes to
+the device configuration region.
+
+This command does not use \field{command_specific_result}.
+
+\paragraph{Legacy Device Configuration Write Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Device Configuration Read Command}
+
+This command has the same effect as reading from the virtio device configuration
+structure through the legacy interface. \field{command_specific_data} has the
+following structure:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_dev_cfg_rd_data {
+        u8 offset; /* Starting byte offset within the device configuration structure to read */
+};
+\end{lstlisting}
+
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_DEV_REG_READ.
+The driver sets valid \field{offset} within the device configuration structure from
+where to read \field{region_data}.
+
+When command completes successfully, \field{command_specific_result}
+uses following structure:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_dev_reg_rd_result {
+        u8 region_data[];
+};
+\end{lstlisting}
+
+\paragraph{Legacy Driver Notification Query}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Legacy Driver Notifications Query}
+
+Even though the driver notifications can be communicated through the
+administration command, if the group owner device or group member device
+supports such notifications using a memory-mapped operation or I/O operation,
+they are sent to the device by accessing such a notification region using 
+a memory or an I/O operation.
+
+A group owner device optionally support querying driver notifications region
+using VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY command.
+
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY.
+This command does not use \field{command_specific_data}.
+
+When command completes successfully, \field{command_specific_result}
+uses following structure:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_notify_query_entry {
+        u8 region_data[16];
+};
+
+struct virtio_admin_cmd_legacy_notify_query_result {
+	struct virtio_virtio_admin_cmd_legacy_notify_query_entry entries[];
+};
+\end{lstlisting}
+
+The driver picks the suitable entry when multiple entries are supplied
+by the device.
+
+Refer to the specific transport section for the definition of the
+\field{region_data}.
+
+This command is currently only defined for the PCI SR-IOV group type.
+
+\devicenormative{\paragraph}{Legacy Interface}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface}
+
+If the group owner device supports legacy region access for its group member
+devices, the device MUST set all corresponding bits for commands
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ in
+the command result of VIRTIO_ADMIN_CMD_LIST_QUERY in
+\field{device_admin_cmd_opcodes}.
+
+The device MUST encode and decode legacy device specific registers using
+little-endian format.
+
+The device MUST fail VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE and
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ commands for the invalid offset
+which is outside the legacy common configuration region's address range.
+
+The device MUST fail VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE,
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands for the invalid offset
+which is outside the legacy device specific region's address range.
+
+The device SHOULD support VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY command for
+driver notifications. If the group owner device supports driver
+notifications region for its group member devices, the device MUST set
+VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY in the command result of
+VIRTIO_ADMIN_CMD_LIST_QUERY in \field{device_admin_cmd_opcodes}.
+
+When the driver accesses the legacy region of the member device using
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE, VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ
+commands, device MUST function as if they are accessed by the legacy interface
+defined by the transport of the member device.
+
+\drivernormative{\paragraph}{Legacy Interface}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface}
+
+The driver MUST encode and decode legacy device specific registers using
+little-endian format.
+
+The driver SHOULD send VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE and
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ commands with a valid offset which
+is in the legacy common configuration region address range.
+
+The driver SHOULD send commands VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ with a valid offset which is in the legacy
+device specific configuration region address range.
+
+The group member driver SHOULD use the notification region supplied by the group
+owner device.
diff --git a/admin.tex b/admin.tex
index fd3b97d..0de26a9 100644
--- a/admin.tex
+++ b/admin.tex
@@ -117,7 +117,17 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
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
+0x0006 & VIRTIO_ADMIN_CMD_LEGACY_DEV_NOTIFY_QUERY & Query notification region for a member device \\
+\hline
+0x0007 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
 \hline
 0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
 \hline
@@ -286,6 +296,8 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 supporting multiple group types, the list of supported commands
 might differ between different group types.
 
+\input{admin-cmds-legacy-interface.tex}
+
 \devicenormative{\subsubsection}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
 
 The device MUST validate \field{opcode}, \field{group_type} and
diff --git a/conformance.tex b/conformance.tex
index 01ccd69..dc00e84 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -260,6 +260,8 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}
 \item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Endianness}
 \item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Message Framing / Legacy Interface: Message Framing}
+\item Section \ref{devicenormative:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface}
+\item Section \ref{drivernormative:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface}
 \item Section \ref{sec:General Initialization And Device Operation / Device Initialization / Legacy Interface: Device Initialization}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery / Legacy Interfaces: A Note on PCI Device Discovery}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

