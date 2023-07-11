Return-Path: <virtio-dev-return-13338-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B0DC001DC
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Jul 2023 15:02:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 24C352B05E
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Jul 2023 15:02:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0249C986651
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Jul 2023 15:02:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DDE62986608; Tue, 11 Jul 2023 15:02:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C64E4986610;
	Tue, 11 Jul 2023 15:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHboyadhTxU2rqPFvuTZeTag7IxzeZx84v1FgACuuGJFqswxE/UGs1AlcO5FHcryKYLMuxNgy79x7mv0pyuwWMqG0RKQ/R/P1bEIkSj94xUpaUvHZANH14l+CtrxB0P7gclGhpWHLmLJhdrKwCmVokNd+HJk3cSjiwRqeyVojBJrJH3dAOTnuc7mpJZSO/71d/mYA8etSi9+L4VkW8evegcUl3o2dPBGY4K3NJy45TNpTuLH4IuIiba2k7og40KzZ1G5P0Oyeqkl3XggHBMpXDdlFTc4Wjro9YvmFr3GEVluA08Nq7dkr5CPQ2NSEvIHzgmh7HI/04cFTCdAIcAWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyraFV6Z2Yt3vXiuKF5OBiSejNaDdHGT0fdK8TsNL7I=;
 b=D/q6lrRJYSmPhCKn39denc7X6LIVra1b3BvCJrREszNdN8bOSWj0Uo02yALQntVZRX2AnxA3aIsgImhWFBQ1Us73P2Uch4kFQUdnDN95TLYyoW1M0OL0VBaBpvAA2Dqlm5xp1+rjanp9t3xg5MviCsw04n5FB0BFCFZbGrR26axxp0baRfEtA6B8YkGwMDdBMS4MRT1kdUadV8DJUfGkw8wsLjiXxbq+fKMlptrjdR2Gy76JYPo6zws6meGmBXn8JS6uWTPf71SNh3hVBRh6tfqXLAyvplhrsJCSKCXXHWaI7UolhIsarVs65gIJY8LX4rUTTaSrSjMYJ10fbL8FZw==
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
Date: Tue, 11 Jul 2023 18:01:35 +0300
Message-ID: <20230711150135.222793-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|DS7PR12MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: 2795b104-c46e-4ae0-7630-08db821fcd4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WQ5g2OlqUXGYorEKzRMlXaTm0NFRpEOD6M4E+ul7jVQr9u+8QZ2M/1SwnvS7vJO8jK07IDZ7sOXI7fL0kgznWGzRdS/MJ/nAy74doaNLtUGzqoN2NviFUQUNCa9O/oEpsb08RnKGcgKatRpdNzXjJoRSg3n5ccx/xPduyEV38wfcxFjDOniArx6NTScd5RY7IC2qWPdFSmPCniKMuSMVWR1iTui9enpzdr7kPlKpsEF5daM8/bNC9YuWOU4Po5FX/IHnCqjF7XOeOL6/oCPZtM7DDNK8Vnam4+Rixk+yMLE9V9ptb6Y8MRauNrSyyAaDWmzkJheGSyOpXZR1oaRgEInt6cj4V56nuFaXSkfWThrb7ZQzLmLiZb/zYiadU59Bbxo2aHhXY1GBKmjkXzU9+s0TyH1cCm7v0mkPOhsOQPEmxIH9ENN6RltaPKEAZw/b7nD5zUWdFwePIncdBRHPdEP0P5eHnpgwgA8kkZwE89faGGCzliE4tAlcp/SGqntCZBbxdiDQqu7kKYde4nx/XSKYxQ4WYq89ozheF+2KX/q10GauH2yF2ofZtbbfg7WDaYnSoNOSipzCSP6b+PLOcPEYX6rcFKwdOAWKKfojoS8W57Ad+Q4dLMH1uKhRhNkcAr7I82dPD4aqGnmCkTJnur+NTaIKhMYjmtzPkuLcIcdawKaLK5ur9wuQYZZFNCoppn32UKIsK9EIIB866uyhFsOkzSot1lHh4qlYoIvt1J8heQWgVCDgcc/f4RXJLOSPS3M5AECCxEt8tPm/GPViqskcAupsClLT0oUmW5QrBNQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(336012)(426003)(41300700001)(107886003)(26005)(36860700001)(1076003)(966005)(83380400001)(47076005)(16526019)(2616005)(186003)(478600001)(82740400003)(356005)(7636003)(110136005)(54906003)(6666004)(40460700003)(4326008)(40480700001)(70206006)(70586007)(316002)(86362001)(82310400005)(8936002)(8676002)(5660300002)(30864003)(36756003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 15:02:10.1653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2795b104-c46e-4ae0-7630-08db821fcd4d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120
Subject: [virtio-dev] [PATCH v15] admin: Add group member legacy register access commands

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
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
changelog:
v14->v15:
- addressed below editorial comments from Michael
- replaced 'is' with 'are' for command description
- simplified wording around ignore and skip to just use ignore
- to -> in preference to
- small rewording for flags description
v13->v14:
- addressed below comments from Michael
- reworded BAR 1 to 5 text as_is suggested by Michael
- added text for skipping invalid entries
- replaced 'contains' with 'contain'
- removed 'related to the base address associated'
- addressed comments from Cornelia
- added article the at many places
- replaced does not to do not
- reworded the driver normative for flags parsing
v12->v13:
- added article
- add hyphen between little and endian
- mentioned vq index depth of 16-bit
- rewrote alternative approach line
- mention vq index, length and endianness in mmio description
- fixed padding bytes size from 7 to 6 bytes
- rewrote bar field description
- offset alignment text added
- added text to ignore reserved notification entries
- device and driver conformance lines added for notification info command fields
- dropped group member prefix to the driver
- reworded text for flags requirements
- reworded to say all driver notifications in conformance
- itemize conformance section under command to ease reading
v11->v12:
- added missing article the at few places
- rewrote group_member_id statements like other existing
  commands which is cleaner and shorter
- added length and alignment lines to multiple commands
- rewrote fast path to separate dedicated mechanism
- rewrote example and description para for legacy notification command
- made separate paragraph for the notify info command
- dropped citation to virtio pci capabilities for member device
- notification region changed to notification address throughout
- added description to all the fields of the info struct
- avoided union in spirit of keeping all for pci
- used single listing
- moved description to end which was in between two structs
- added 4 entry and preference description
- added conformance line for notification via mmio works same way as
  admin command
v10->v11:
- replaced tab with white spaces in read structure
- included pci fields along side other generic fields to avoid
  indirection
- merged pci conformance section
- avoid using definite in starting introduction
- replace 'all of the' with 'any of the'
- changed drivers notification normative to indicate use of
  NOTIFY_INFO command
- renamed NOTIFY_QUERY to NOTIFY_INFO name
- merged 4th patch with 3rd
- added normative line for notify_info command
- reworded notification region command description to be more verbose
- merged flags and owner field to indicate end of list
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
 admin-cmds-legacy-interface.tex | 362 ++++++++++++++++++++++++++++++++
 admin.tex                       |  14 +-
 conformance.tex                 |   2 +
 3 files changed, 377 insertions(+), 1 deletion(-)
 create mode 100644 admin-cmds-legacy-interface.tex

diff --git a/admin-cmds-legacy-interface.tex b/admin-cmds-legacy-interface.tex
new file mode 100644
index 0000000..b9c96d4
--- /dev/null
+++ b/admin-cmds-legacy-interface.tex
@@ -0,0 +1,362 @@
+\subsubsection{Legacy Interfaces}\label{sec:Basic Facilities of a Virtio Device / Device groups / Group
+administration commands / Legacy Interface}
+
+In some systems, there is a need to support utilizing a legacy driver with
+a device that does not directly support the legacy interface. In such scenarios,
+a group owner device can provide the legacy interface functionality for the
+group member devices. The driver of the owner device can then access the legacy
+interface of a member device on behalf of the legacy member device driver.
+
+For example, with the SR-IOV group type, group members (VFs) can not present
+the legacy interface in an I/O BAR in BAR0 as expected by the legacy pci driver.
+If the legacy driver is running inside a virtual machine, the hypervisor
+executing the virtual machine can present a virtual device with an I/O BAR in
+BAR0. The hypervisor intercepts the legacy driver accesses to this I/O BAR and
+forwards them to the group owner device (PF) using group administration commands.
+
+The following commands support such a legacy interface functionality:
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
+interface listed in section \ref{sec:Virtio Transport Options / Virtio Over PCI
+Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout} except
+that little-endian format is assumed unconditionally.
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
+For the command VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE, \field{opcode}
+is set to 0x2.
+The \field{group_member_id} refers to the member device to be accessed.
+The \field{offset} refers to the offset for the write within the virtio common
+configuration structure, and excluding the device-specific configuration.
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
+        u8 offset; /* Starting byte offset within the common configuration structure to read */
+};
+\end{lstlisting}
+
+For the command VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ, \field{opcode}
+is set to 0x3.
+The \field{group_member_id} refers to the member device to be accessed.
+The \field{offset} refers to the offset for the read from the virtio common
+configuration structure, and excluding the device-specific configuration.
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_common_cfg_rd_result {
+        u8 data[];
+};
+\end{lstlisting}
+
+No length or alignment restrictions are placed on the value of the
+\field{offset} and the length of the \field{data}, except that the resulting
+access refers to a single field and is completely within the virtio common
+configuration structure, excluding the device-specific configuration.
+
+When the command completes successfully, \field{command_specific_result}
+is in the format \field{struct virtio_admin_cmd_legacy_common_cfg_rd_result}
+returned by the device. The length of the data read is simply the length of
+\field{data}.
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
+For the command VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE, \field{opcode}
+is set to 0x4.
+The \field{group_member_id} refers to the member device to be accessed.
+The \field{offset} refers to the offset for the write within the virtio
+device-specific configuration. The length of the data to write is simply
+the length of \field{data}.
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
+For the command VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ, \field{opcode}
+is set to 0x5.
+The \field{group_member_id} refers to the member device to be accessed.
+The \field{offset} refers to the offset for the read from the virtio device-specific
+configuration.
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_dev_reg_rd_result {
+        u8 data[];
+};
+\end{lstlisting}
+
+No length or alignment restrictions are placed on the value of the
+\field{offset} and the length of the \field{data}, except that the resulting
+access refers to a single field and is completely within the device-specific
+configuration.
+
+When the command completes successfully, \field{command_specific_result} is in
+the format \field{struct virtio_admin_cmd_legacy_dev_reg_rd_result}
+returned by the device.
+
+The length of the data read is simply the length of \field{data}.
+
+\paragraph{Legacy Driver Notification}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Legacy Driver Notifications}
+
+The driver of the owner device can send a driver notification to the member
+device operated using the legacy interface by executing
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE with the \field{offset} matching
+\field{Queue Notify} and the \field{data} containing a 16-bit virtqueue index to
+be notified.
+
+However, as VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE is also used for slow path
+configuration a separate dedicated mechanism for sending such driver
+notifications to the member device can be made available by the owner device.
+For the SR-IOV group type, the optional command
+VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO addresses this need by returning to the
+driver one or more addresses which can be used to send such driver
+notifications. The notification address returned can be in the device memory
+(PCI BAR or VF BAR) of the device.
+
+In this alternative approach, driver notifications are sent by
+writing a 16-bit virtqueue index to be notified, in the little-endian
+format, to the notification address returned by
+the VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO command.
+
+Any driver notification sent through the notification address has the same effect
+as if it was sent using the VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE command with
+the \field{offset} matching \field{Queue Notify}.
+
+This command is only defined for the SR-IOV group type.
+
+For the command VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO, \field{opcode}
+is set to 0x6.
+The \field{group_member_id} refers to the member device to be accessed.
+This command does not use \field{command_specific_data}.
+
+When the device supports the VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO command, the
+group owner device hardwires VF BAR0 to zero in the SR-IOV Extended capability.
+
+\begin{lstlisting}
+struct virtio_pci_legacy_notify_info {
+        u8 flags;  /* 0 = end of list, 1 = owner device, 2 = member device */
+        u8 bar;    /* BAR of the member or the owner device */
+        u8 padding[6];
+        le64 offset; /* Offset within bar. */
+};
+
+struct virtio_admin_cmd_legacy_notify_info_result {
+        struct virtio_pci_legacy_notify_info entries[4];
+};
+\end{lstlisting}
+
+A \field{flags} value of 0x1 indicates that the notification address is of
+the owner device, the value of 0x2 indicates that the notification address is of
+the member device and the value of 0x0 indicates that all the entries starting
+from that entry are invalid entries in \field{entries}. All other values in
+\field{flags} are reserved.
+
+The \field{bar} values 0x1 to 0x5 specify BAR1 to BAR5 respectively:
+when the \field{flags} is 0x1 this is specified by the Base Address Registers
+in the PCI header of the device,
+when the \field{flags} is 0x2 this is specified by the VF BARn
+registers in the SR-IOV Extended Capability of the device.
+
+The \field{offset} indicates the notification address relative to BAR indicated
+in \field{bar}. This value is 2-byte aligned.
+
+When the command completes successfully, \field{command_specific_result} is in
+the format \field{struct virtio_admin_cmd_legacy_notify_info_result}. The
+device can supply up to 4 entries each with a different notification
+address. In this case, any of the entries can be used by the driver. The order
+of the entries serves as a preference hint to the driver. The driver is expected
+to utilize the entries placed earlier in the array in preference to the later
+ones. The driver is also expected to ignore any invalid entries, as well as
+the end of list entry if present and any entries following the end of list.
+
+\devicenormative{\paragraph}{Legacy Interface}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface}
+
+A device MUST either support all of, or none of
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands.
+
+For VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands,
+the device MUST decode and encode (respectively) the value of the
+\field{data} using the little-endian format.
+
+For the VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE and
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ commands, 
+the device MUST fail the command when the value of the
+\field{offset} and the length of the \field{data} do not refer to a
+single field or are not completely within the virtio common configuration
+excluding the device-specific configuration.
+
+For the VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands,
+the device MUST fail the command when the value of the
+\field{offset} and the length of the \field{data} do not refer to a
+single field or are not completely within the virtio device-specific
+configuration.
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
+writing into the virtio device-specific configuration through the legacy
+interface.
+
+The command VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ MUST have the same effect as
+reading from the virtio device-specific configuration through the legacy
+interface.
+
+For the SR-IOV group type, when the owner device supports
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE, VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO
+commands,
+\begin{itemize}
+\item the owner device and the group member device SHOULD follow the rules
+for the PCI Revision ID and Subsystem Device ID of the non-transitional devices
+documented in section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}.
+
+\item the owner device SHOULD follow the rules for the PCI Device ID of the non-transitional
+devices documented in section
+\ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}.
+
+\item any driver notification received by the device at any of the notification
+address supplied in the command result of
+VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO MUST function as if the device received
+the notification through VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE
+command at an offset \field{offset} matching \field{Queue Notify}.
+\end{itemize}
+
+If the device supports the VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO command,
+\begin{itemize}
+\item the device MUST also support all of VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands.
+
+\item in the command result of VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO, the last
+\field{struct virtio_pci_legacy_notify_info} entry MUST have \field{flags} of
+zero.
+
+\item in the command result of VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO, valid
+entries MUST have a \field{bar} which is not hardwired to zero.
+
+\item in the command result of VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO, valid
+entries MUST have an \field{offset} aligned to 2-byte.
+
+\item the device MAY support VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO with entries
+of the owner device or the member device or both of them.
+
+\item for the SR-IOV group type, the group owner device MUST hardwire VF BAR0
+to zero in the SR-IOV Extended capability.
+\end{itemize}
+
+\drivernormative{\paragraph}{Legacy Interface}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface}
+
+For VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands,
+the driver MUST encode and decode (respectively) the value of the \field{data}
+using the little-endian format.
+
+For the VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE and
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ commands,
+the driver SHOULD set \field{offset} and the length of the \field{data}
+to refer to a single field within the virtio common configuration structure
+excluding the device-specific configuration.
+
+For the VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ commands,
+the driver SHOULD set \field{offset} and the length of the \field{data}
+to refer to a single field within device specific configuration.
+
+If VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO command is supported, the driver
+SHOULD use the notification address to send all driver notifications to the
+device.
+
+If within \field{struct virtio_admin_cmd_legacy_notify_info_result} returned by
+VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO, the \field{flags} value
+for a specific \field{struct virtio_pci_legacy_notify_info} entry is 0x0, the
+driver MUST ignore this entry and all the following \field{entries}.
+Additionally, for all other entries, the driver MUST validate that
+\begin{itemize}
+\item the \field{flags} is either 0x1 or 0x2
+\item the \field{bar} corresponds to a valid BAR of either the owner or the
+member device, depending on the \field{flags}
+\item the \field{offset} is 2-byte aligned and corresponds to an address
+within the BAR specified by the \field{bar}
+on \field{flags}
+\end{itemize}, any entry which does not meet these constraints MUST be ignored
+by the driver.
diff --git a/admin.tex b/admin.tex
index b0a1a91..0803c26 100644
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
+0x0006 & VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO & Query the notification region information \\
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

