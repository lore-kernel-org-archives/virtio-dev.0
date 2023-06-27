Return-Path: <virtio-dev-return-13110-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472C8EB64DC
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 21:11:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 84445171D25
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 21:11:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 785C1986677
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 21:11:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 667D0986431; Tue, 27 Jun 2023 21:11:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 320A898683F;
	Tue, 27 Jun 2023 21:11:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmmUtvdp1IneP4j35MTlD+WwHqyvexZFEvDeGIlg6/90ZOshXhjX858DaSi89NN5VaZ4bpmFpjkHUNhW1T45kluER0ynf6BB4fXBOtVWMVKoZsNP0BCEb01m4kuE/qIZdR/mvZIBONE31gE9kb/pfE9Yc4dVkfNXDQYpUQ5um7tFXc9y1Knvlr9Dzb3m9B8UHsIK+MmAlD5Qea7Q7u73uXs9OeBSXGb1POjPELzYsfowloP3ORkTu4xb27a/wDrjSDMPMpgd4HHlYk41m47JiTDB80PWZJmie9yqM/qPpybhRdomyW4v1FDc2h79Mj/DPJin1kgYKM4gA7nEVtrSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8HRNhtd+RGu0HPK28c26KmV93fSznof/lKgEqW6ujw=;
 b=cy5xpkhDCnuZv2FM7lbfIwSgaftIQWkubOWmeCDhV8H0NYKe8p8rKEkyHgrG9Bg5n6/WeT528ndky6KhZr+zY4AM2K2Ml2jycCljln9HIACHQv1PaCx1LXe2j2nuqHatQy5wJbQH9RY1LSNQ+I/EoV/n2Y8QFqFIT4GPNBUrDAR2xOfCIeSc0qMhB3OzvYw+4ELgeGglFO/t8aTEeSBwp8aXcMMvdMoM3jUCdIkCQpsmO4o9aP+kUT50crmPf0jBtZBGe5x7jom6jdwmnn8UnSRHsiLgnYKn4ZffMP/t1vusXZdneyVb0YayG4mTQX1oo1/I38Gnc+6u1WwzgrWJyw==
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
Date: Wed, 28 Jun 2023 00:10:49 +0300
Message-ID: <20230627211050.1527507-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230627211050.1527507-1-parav@nvidia.com>
References: <20230627211050.1527507-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT060:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: faf9a819-150f-407f-0271-08db77530d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J3pN55lwgB3shLOgHCfreeWP7g1tqAnD/o0SHnsAlEdSUsFz4fyXARppB4JUl1ETI7ITLnIGdgb2xR3v56li40ya25g6hvN+ADw01suSUO8g3krE10OIObZZ1OMeRFUK7Sax1IYY+r3Lkr1uL5PgZKVlH+VklZ4gi6w34k20x6gd1RFEnrhrXnTEUGpYijlq6A256f4mX9rKGzGYAlUEpnysUP+rawaXiKNzaO26HcgGss/1OSWzFADjW6d9iDVA7CGH0y+T8cxVwkkzm5dMblgYMoooETDrXXVLnJmYtN9yzhBoWKe15UQ6ExrvczTcaaRyWTIKScaxe6ACRXrSo8XVhkV/4XSSxQ12jwy5y2RVpPJchE+ABqdxQwkJsHLgG8GQdjybSP0pMYz258EY/h3NuISe06WszgxWVHc2edKaQbvknRW2tIoMfBwcCVzDT0wRCbX1lMZpwb7giKHvyTqe7uephZjw/WNIQIBym6g8AZNUKrzgnSLz7sFrFjdMYbgoncpGpFHt8wrztYfwFZ7qYT88cj8BpoWTr8Pj1a9DHrjavN3qPEXHs33LtFg3809slcOiMc+frOKk3tPrV49mK0V7RFPqKJEL7gU/OmiaBcsZOafIE7mcvzfl+EYrdMc7DH9tfBiuChiUc7sFlf54ylRqzw2Eow0ndY7sOscZrL56n+QI/9fBePD+wtKwfKNYwsAOr8Un3sVcL0FyfuTlz/VHBMcM79QAXAjoZlX4Tx6HkLZtaRx/xYd1FzumxHYjBWqT73+JF1AcDNsiKgUr9eSA/mi0zdJk46jCZqA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(36860700001)(107886003)(47076005)(36756003)(110136005)(966005)(1076003)(6666004)(54906003)(336012)(478600001)(2616005)(426003)(83380400001)(26005)(186003)(16526019)(2906002)(5660300002)(40460700003)(70206006)(356005)(82740400003)(70586007)(30864003)(7636003)(40480700001)(8676002)(86362001)(316002)(4326008)(41300700001)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 21:11:18.5645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf9a819-150f-407f-0271-08db77530d08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200
Subject: [virtio-dev] [PATCH v7 3/4] admin: Add group member legacy register access commands

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
 admin-cmds-legacy-interface.tex | 204 ++++++++++++++++++++++++++++++++
 admin.tex                       |  14 ++-
 conformance.tex                 |   2 +
 3 files changed, 219 insertions(+), 1 deletion(-)
 create mode 100644 admin-cmds-legacy-interface.tex

diff --git a/admin-cmds-legacy-interface.tex b/admin-cmds-legacy-interface.tex
new file mode 100644
index 0000000..48d40ee
--- /dev/null
+++ b/admin-cmds-legacy-interface.tex
@@ -0,0 +1,204 @@
+\subsubsection{Legacy Interfaces}\label{sec:Basic Facilities of a Virtio Device / Device groups / Group
+administration commands / Legacy Interface}
+
+When the member device cannot support certain transport specific
+functionality of a legacy interface, it is difficult to compose a
+transitional group member device. In such scenario, a owner device
+can provide the legacy interface functionality. With such support,
+the member device driver can utilize the group owner device driver legacy
+interface functionality, thereby it can supply either a transitional device
+or a legacy device for the guest virtual machine. For example a PCI VF
+group member device do not support I/O BAR region functionality. For such
+limitation, a PCI PF group owner device support accessing member device's legacy
+configuration region using the administration commands. These administration
+commands are executed by the driver of the owner device when requested by the
+driver of the member device. For example, the member device driver
+intercepts configuration accesses done by the legacy driver and forwards
+such access request to the owner device driver; the owner device driver fulfil
+such requests by executing administration commands on the group owner device.
+
+The group owner device support following administration commands for legacy
+commong configuration and device configuration region access:
+
+\begin{enumerate}
+\item Legacy Common Configuration Region Write Command
+\item Legacy Common Configuration Region Read Command
+\item Legacy Device Configuration Region Write Command
+\item Legacy Device Configuration Region Read Command
+\end{enumerate}
+
+Accessing the member device legacy regions using these commands has the same
+effect as accessing it using the the legacy interface defined by the transport
+of the member device.
+
+\paragraph{Legacy Common Configuration Region Write Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group
+administration commands / Legacy Interface / Common Configuration Region Write Command}
+
+This command writes in a legacy common configuration region of a group member device.
+This command follows \field{struct virtio_admin_cmd}.
+This command uses following structure for \field{command_specific_data}:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_common_cfg_wr_data {
+        u8 offset; /* Starting byte offset of the common configuration region to write */
+        u8 region_data[];
+};
+\end{lstlisting}
+
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE.
+The driver sets valid \field{offset} and associated \field{region_data} bytes to
+write to the common configuration region.
+
+This command does not have any command specific result.
+
+\paragraph{Legacy Common Configuration Region Read Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Common Configuration Region Read Command}
+
+This command reads from a legacy common configuration region of a group member device.
+This command follows \field{struct virtio_admin_cmd}.
+This command uses following structure for \field{command_specific_data}:
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
+uses following structure:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_common_cfg_rd_result {
+        u8 region_data[];
+};
+\end{lstlisting}
+
+\paragraph{Legacy Device Configuration Region Write Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Device Configuration Region Write Command}
+
+This command writes in a legacy device configuration region of a group member device.
+This command follows \field{struct virtio_admin_cmd}.
+This command uses following structure for \field{command_specific_data}:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_dev_reg_wr_data {
+        u8 offset; /* Starting byte offset of the device configuration region to write */
+        u8 region_data[];
+};
+\end{lstlisting}
+
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_DEV_REG_WRITE.
+The driver sets valid \field{offset} and associated \field{region_data} bytes to
+the device configuration region.
+
+This command does not have any command specific result.
+
+\paragraph{Legacy Device Configuration Region Write Command}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Device Configuration Region Read Command}
+
+This command reads from a legacy device configuration region of a group member device.
+This command follows \field{struct virtio_admin_cmd}.
+
+This command uses following structure for \field{command_specific_data}:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_dev_cfg_rd_data {
+        u8 offset; /* Starting byte offset of the device configuration region to read */
+};
+\end{lstlisting}
+
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_DEV_REG_READ.
+The driver sets valid \field{offset} of the device configurationi region from
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
+\paragraph{Legacy Driver Notification Region Query}\label{par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface / Legacy Driver Notifications Region Query}
+
+Even though the driver notifications can be communicated through the
+administration command, if the group owner device or group member device
+supports such notifications using a memory-mapped operation or I/O operation,
+they are sent to the device by accessing this notification region using memory
+or I/O operation.
+
+A group owner device optionally support querying driver notifications region
+using VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY command.
+
+The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY.
+This command does not have any command specific data.
+
+When command completes successfully, \field{command_specific_result}
+uses following structure:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_legacy_notify_query_entry {
+        u8 region[8];
+};
+
+struct virtio_admin_cmd_legacy_notify_query_result {
+	struct virtio_virtio_admin_cmd_legacy_notify_query_entry entries[];
+};
+\end{lstlisting}
+
+The driver should pick the suitable entry when multiple entries are supplied
+by the device.
+
+Refer to the specific transport section for the definition of the
+\field{region}.
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

