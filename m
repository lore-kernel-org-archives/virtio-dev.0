Return-Path: <virtio-dev-return-13244-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA25EB64DC
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 04:20:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 50FD918C9C3
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 04:20:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7945698681B
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 04:20:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D45F898672A; Thu,  6 Jul 2023 04:20:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2E69F986725;
	Thu,  6 Jul 2023 04:19:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/6jfYFmU1sAITJlJnENWyaXtSqx5lISPnhXW7No0Lk7qhZPLYU0/p4qx+s2j/JeTVUD52y3JlsTQYvlDZQ6+e1anHlLw1TR57UN3AMv/y7o1R/M5oEuSZo9Yk+pFJ1kne/+Q8TjHC/7xd3gRBrcNInJPHqCBOaoPO48f8tkxqqF3769FPNmFshKzncr3W9Odnw+3CiziOdcPMIybdoNHwz/DdRrr758j01Wxu5hkmX6vzQ7DtWUDpVDx+wyw+8k8VvyegcJI0x+PN3xo+aAA6JkOj1pFwyRL/9ZcFPSLMN6SlckEo6uE4/99A6xZhtpbJuE9JorA0eVWEd3MYbz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+tiM8hcNaLLS6qgjYuIMhJIeqKXlUtcKH/iECCiq+w=;
 b=dPB8ITozxmNR4rGzDISWegZ0+0Pbr5puZppEpR3BoFisuJEBTed2zPw9E29fTbmgx7dSCjuz9QERgl4HGCW+ct5xvj/4T3P73mYE4ZTGVGZJ8Ix4QpLUcQvT8OkUCcY3mYCzeQLLud4EeXxhcIhtXfvO7BcqhsAFg38XwyXg/+HRarknMDnMbqh6UqZAcgT/4gk3YIhIMoGaJJ12nCGpwPO9nBYAHfzPKHovd4JDZP+G77scUsnADtI+uun6Tm1RTOj+Z2gnEtlUnsyyncrWAD55SHztTth+n+q8W4bpy1pou65GrOJF9D8whWxN4qTvpqToDd3Gu6g7LxMMypNTLg==
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
Date: Thu, 6 Jul 2023 07:17:13 +0300
Message-ID: <20230706041714.65600-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230706041714.65600-1-parav@nvidia.com>
References: <20230706041714.65600-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: a7fdaa90-efc3-455d-e203-08db7dd822dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cQ1W7l+kq77yDhje3kgsydjjszaC2kL++P5ITWAh2PPqq9wO+QVDG/0t2W8XPJQcrgkej2SP892r5s170pKZN+dzaTSBspaev4dgfWOjEz76C4g/bd+UcepEGaXRNhJSTOeI8gLyAC0WP33Svm6T5VtsIzs6aYy6uo+6bQwzNRuo8tvEHlDavvz2pIeL2gciA2njKd4AYp2bPKYdvpfNn4PJl/swBViIDV6mVYpo/7FUZYJycOJagvtjtd6CKnWjZfWjGsDkxLbEjBR0Ob64uD1tVCsw1AfpWtkCLIcgM5oZLvtCazPelvt7S4FQE6vvXWs3N4yzfXhsqDsK/KN6elSw61yTrOUsuX6aQNUVC01TKKjO2MkO8FlPuq85pNAES+HF2BHTVbWdVajnFM7eVMMNW1KlYayFQCS82wPJ/PqF5CPzpgPI/etzNNTJe5mxBuAwBL6M1rx6cTiNYdNx8fsG8O16yR3ACBpsS+wB6BsZUijuEsGY542yxIC0c264sGkERsBjoWSEGs/lP4VaDb3Xb+aid9ixK90rqn6SmJUI9+p1RZY7d1PZEQXKw9Uk9rrdb+imMvQ2SE3GLalFqFKvwuJSPVlwCc9ztev0Z5QwHUuLkz2xTbgZeFH/nYbUltodokMaZXui0kj8Q+5yTvq7bafJ0MorSuxfPPZEPcUNuoCwoZFxqrUPIs4DFIXQejI1QpMulIYMW8c83VV7Dd0UDoda8hmMsOHghYPjyEvZMQ2Mct/nZ4aKV1pdXOyClY7SpMajTtptjQC9SfOw+RlJt83u3TRiEYflrFv5Q6o=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(47076005)(82310400005)(2906002)(2616005)(40460700003)(426003)(83380400001)(336012)(36756003)(86362001)(36860700001)(82740400003)(7636003)(40480700001)(356005)(107886003)(6666004)(8936002)(4326008)(1076003)(5660300002)(966005)(41300700001)(8676002)(316002)(70206006)(70586007)(110136005)(16526019)(30864003)(478600001)(54906003)(186003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:19:05.2400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fdaa90-efc3-455d-e203-08db7dd822dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236
Subject: [virtio-dev] [PATCH v10 3/4] admin: Add group member legacy register access commands

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
v9->v10:
- added white space at end of line
- addressed below comments from Cornelia
- added missing articles
- reworded description for notification query command
- grammar fixes
- addressed below comments from Michael
- added description for member group id setting
- reworded device and driver conformance statements
- opcode table description updated
- fixed label for device read command
- length alignment restriction text added
- data length described for read write commands
- notification description added and refined
- reworded text around command specific result and data field usage
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
 admin-cmds-legacy-interface.tex | 261 ++++++++++++++++++++++++++++++++
 admin.tex                       |  14 +-
 conformance.tex                 |   2 +
 3 files changed, 276 insertions(+), 1 deletion(-)
 create mode 100644 admin-cmds-legacy-interface.tex

diff --git a/admin-cmds-legacy-interface.tex b/admin-cmds-legacy-interface.tex
new file mode 100644
index 0000000..dd01c0a
--- /dev/null
+++ b/admin-cmds-legacy-interface.tex
@@ -0,0 +1,261 @@
+\subsubsection{Legacy Interfaces}\label{sec:Basic Facilities of a Virtio Device / Device groups / Group
+administration commands / Legacy Interface}
+
+In some systems, there is a need to support utilizing the legacy driver with
+the device that do not directly support the legacy interface. In such scenarios,
+a group owner device can provide the legacy interface functionality for the
+group member devices. The driver of an owner device can then access the legacy
+interface of a member device on behalf of the legacy member device driver.
+
+For example, with the SR-IOV group type, group members (VFs) can not present
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
+These commands are currently only defined for the SR-IOV group type and
+have, generally, the same effect as member device accesses through a legacy
+interface listed in section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout} except that little endian format is assumed unconditionally.
+
+\paragraph{Legacy Common Configuration Write Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group
+administration commands / Legacy Interface / Legacy Common Configuration Write Command}
+
+This command has the same effect as writing into the virtio common configuration
+structure through the legacy interface. The \field{command_specific_data} is in
+the format \field{struct virtio_admin_cmd_legacy_common_cfg_wr_data} describing
+the access to be performed.
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_common_cfg_wr_data {
+        u8 offset; /* Starting byte offset within the common configuration structure to write */
+        u8 reserved[7];
+        u8 data[];
+};
+\end{lstlisting}
+
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE.
+The driver sets \field{group_member_id} which refers to the member device to be
+accessed. The driver sets \field{offset} which refers to the offset to write within the
+virtio common configuration structure, and excluding the device-specific configuration.
+
+The length of the data to write is simply the length of \field{data}.
+
+No length or alignment restrictions are placed on the value of the
+\field{offset} and the length of the \field{data}, except that the resulting
+access refers to a single field and is completely within the virtio common
+configuration structure, excluding the device-specific configuration.
+
+This command has no command specific result.
+
+\paragraph{Legacy Common Configuration Read Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Legacy Common Configuration Read Command}
+
+This command has the same effect as reading from the virtio common configuration
+structure through the legacy interface. The \field{command_specific_data} is in
+the format \field{struct virtio_admin_cmd_legacy_common_cfg_rd_data} describing
+the access to be performed.
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_common_cfg_rd_data {
+	u8 offset; /* Starting byte offset within the common configuration structure to read */
+};
+\end{lstlisting}
+
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ.
+
+The driver sets \field{offset} which refers to the offset to read from the
+virtio common configuration structure, and excluding the device-specific
+configuration.
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_common_cfg_rd_result {
+        u8 data[];
+};
+\end{lstlisting}
+
+When the command completes successfully, \field{command_specific_result}
+is in the format of \field{struct virtio_admin_cmd_legacy_common_cfg_rd_result}
+returned by the device.
+
+The length of the data read is simply the length of \field{data}.
+
+\paragraph{Legacy Device Configuration Write Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Legacy Device Configuration Write Command}
+
+This command has the same effect as writing into the virtio device-specific
+configuration through the legacy interface. The \field{command_specific_data} is in
+the format \field{struct virtio_admin_cmd_legacy_dev_reg_wr_data} describing
+the access to be performed.
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_dev_reg_wr_data {
+        u8 offset; /* Starting byte offset within the device-specific configuration to write */
+        u8 reserved[7];
+        u8 data[];
+};
+\end{lstlisting}
+
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE.
+The driver sets \field{group_member_id} which refers to the member device to be
+accessed. The driver sets \field{offset} which refers to the offset to write
+within the virtio device-specific configuration.
+
+The length of the data to write is simply the length of \field{data}.
+
+No length or alignment restrictions are placed on the value of the
+\field{offset} and the length of the \field{data}, except that the resulting
+access refers to a single field and is completely within the device-specific
+configuration.
+
+This command has no command specific result.
+
+\paragraph{Legacy Device Configuration Read Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Legacy Device Configuration Read Command}
+
+This command has the same effect as reading from the virtio device-specific
+configuration through the legacy interface. The \field{command_specific_data} is in
+the format \field{struct virtio_admin_cmd_legacy_common_cfg_rd_data} describing
+the access to be performed.
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_dev_cfg_rd_data {
+        u8 offset; /* Starting byte offset within the device-specific configuration to read */
+};
+\end{lstlisting}
+
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ.
+The driver sets \field{group_member_id} which refers to the member device to be
+accessed. The driver sets \field{offset} which refers to the offset to read from
+the virtio device-specific configuration.
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_dev_reg_rd_result {
+        u8 data[];
+};
+\end{lstlisting}
+
+When the command completes successfully, \field{command_specific_result} is in
+the format of \field{struct virtio_admin_cmd_legacy_dev_reg_rd_result}
+returned by the device.
+
+The length of the data read is simply the length of \field{data}.
+
+\paragraph{Legacy Driver Notification}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Legacy Driver Notifications}
+
+If the group owner device or the group member device support driver
+notifications via a memory-mapped operation or I/O operation, these
+notifications are sent to the device via accessing such a notification region
+using a memory or I/O operation instead of sending the notifications through
+the admistration command.
+
+The driver of the owner device can send a driver notification to the member
+device by executing VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE with the
+\field{offset} matching \field{Queue Notify} and the \field{data} containing
+the virtqueue index to be notified.
+
+However, as many administration commands are used for slow path configuration,
+a separate fast path mechanism for such notifications is desired. For the
+SR-IOV group type, the optional command VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY
+addresses this need by returning to the driver one or more addresses which to
+be used to send such driver notifications.
+
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY.
+The driver sets \field{group_member_id} which refers to the member device to be
+accessed. This command does not use \field{command_specific_data}.
+
+When the command completes successfully, \field{command_specific_result}
+is in the format of \field{struct virtio_admin_cmd_legacy_notify_query_result}.
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_notify_query_entry {
+        u8 data[16];
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
+\field{data}.
+
+This command is currently only defined for the SR-IOV group type.
+
+\devicenormative{\paragraph}{Legacy Interface}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface}
+
+A device MUST either support all of, or none of
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands.
+
+For VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands, the device MUST decode and
+encode (respectively) the value of the \field{data} using the little-endian
+format.
+
+The device MUST fail VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE and
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ commands where the value of the
+\field{offset} and the length of the \field{data} does not refer to a
+refer to a single field or is not completely within the virtio common
+configuration structure excluding the device-specific configuration.
+
+The device MUST fail VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands where the value of the
+\field{offset} and the length of the \field{data} does not refer to a
+refer to a single field or is not completely within the
+device-specific configuration.
+
+If the device supports VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY it MUST
+also support all of VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ.
+
+The command VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE MUST have the same effect
+as writing into the virtio common configuration structure through the legacy
+interface.
+
+The command VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ MUST have the same effect as
+reading from the virtio common configuration structure through the legacy
+interface.
+
+The command VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE MUST have the same effect as
+writing into the virtio device configuration structure through the legacy
+interface.
+
+The command VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ MUST have the same effect as
+reading from the virtio device configuration structure through the legacy
+interface.
+
+\drivernormative{\paragraph}{Legacy Interface}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface}
+
+For VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands, the driver MUST encode and
+decod3 (respectively) the value of the \field{data} using the little-endian
+format.
+
+For VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE and
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ commands the driver SHOULD set
+\field{offset} and the length of the \field{data} to refer to a
+a single field within the virtio common configuration structure excluding
+the device-specific configuration.
+
+For VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands the driver SHOULD set
+\field{offset} and the length of the \field{data} to refer to a
+a single field within the virtio device-specific configuration.
+
+The group member driver SHOULD use the notification region supplied by the group
+owner device to send driver notifications to the device if
+VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY is supported.
diff --git a/admin.tex b/admin.tex
index b0a1a91..e2134e1 100644
--- a/admin.tex
+++ b/admin.tex
@@ -117,7 +117,17 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 \hline
 0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
 \hline
-0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
+0x0002 & VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE & Writes into the legacy common configuration structure \\
+\hline
+0x0003 & VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ & Reads from the legacy common configuration structure  \\
+\hline
+0x0004 & VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE & Writes into the legacy device configuration structure \\
+\hline
+0x0005 & VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ & Reads into the legacy device configuration structure \\
+\hline
+0x0006 & VIRTIO_ADMIN_CMD_LEGACY_DEV_NOTIFY_QUERY & Query the notification region \\
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

