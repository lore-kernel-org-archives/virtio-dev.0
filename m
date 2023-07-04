Return-Path: <virtio-dev-return-13224-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D738EB64DD
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 23:37:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9ACC088E2D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 23:37:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7686C98685E
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 23:37:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5F868986855; Tue,  4 Jul 2023 23:37:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D59A998681B;
	Tue,  4 Jul 2023 23:37:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXV5dJ9Bqsh3GwyYtWjDqzAob8Kdf3eR0x5cB2EvGshflRWJ8hL6hONMs6b/mY2g3Fb4nWbSjfcIuTw30sWKiIwEK6eBvLTTTMZjGiyRyblJEehmGql+jPUMIWa3Sj4d1rhyp7s7wzywPpSxUqcFHGgYDkkLtYYPeTXi/5eO4M6V/4LDTftNrxKsElwkT3m/snK+YzNADnKT5IJtrMiImQBcLLB5a9TuJEqMov43VYZcT3a32hBnGCe/BHvcjjej8uEvbcKOnXCN63oU8FlZYEZRw2B7Bz99fTTKBnxzDlHdirZaV29dg1rrA3nBkjAsWcMcW8fnHDDeRiyRvMVc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfiNPY3tXpCUvKA2M+fLaf5dkhEDCtonHS2XbVvF10I=;
 b=Cx8Vpp3qTwRHf0yZaJBdi80XQeZfRJbbnM3fW7+Al8700umZDGNhQV8MaT87Q0NaMaQ/AJX7UQUSzRelViQAM0iPXnxd/VIoqa89tJWeqKrlYwiwfJuBrjFrT+ZT23TGS5vnn0X0M2oSVw1Fk7rVopjRrcHz8CVvIgFkKNeQ8TjIUCDbJnk8UZWgjQluEFYkz8sM27nubpZV0G/54CJnuV71rfVZ611RhrzWXHucWuarlQk5Zsnmj3FpwErL87OWL0FLMqh5H6vRUJSH9hJaoZoFnLMv+XyWGN7OoVesTleFqm/l2qwMJ2eel+F2Y71w7flwKIEUsDuuSGHCh768hg==
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
Date: Wed, 5 Jul 2023 02:37:24 +0300
Message-ID: <20230704233724.22394-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230704233724.22394-1-parav@nvidia.com>
References: <20230704233724.22394-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT049:EE_|CY8PR12MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: b768dd19-b726-4cfb-99c4-08db7ce7ad36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xoUe7t8oBcBm0OBTpGXTcXR5a356w1KKlj/PV7LAgMnqOuwy8XVmzcmSkiuRnJhKDN0w9WuVPtfaA8EXH6xwG0XI1WMWpjNsYExIrHSazQI9vU1U022WPHUrT1qd/+Hr4n8Nio/ifVg1D223YssPT/tJ3gTkMYQ07ms92K9X0VL4NgJZaM46hkENrm+fp8O2cq65DbEcCHZ6xtYgqW9P3hLFGl7Awxzw4CEMWTP85VMpvC0mAKggfwAknrf7Yduid8iY+JiMb42rm4E5n2dFMamZyjKxt/CzutgtVOAh+7eA8D8HaEp0Fd4QIphkVlQMeH6V0Bdv/ORVfBW+q0DuyRXNSDofMaRatH8Ra+tiVmyGOYrKWq0mkRJYVGzyw2Wfr9LgmPLwmzY19pJJvHfXhSD3TmkhG1SHhbR+wYd+4lxtLXR6mGYLHOtwknb0m80ETB6u+cdkCms1wdcyfMACt67kckvWVukroreXiuz1HhoxIolN1BAsaGfw+1oO/SdXMvdQsETfEwFhl5rlYI2Nfbp8e+FBzSTzqBRSycOZakd6TeXBFB7ytseG1HYjFDd22/w6tK/nf+1gpPoSB9UNnNuNLJblYgJRSwBsX6DeccNNpH+peGdQv/3ni/d6uRonvi2SnlXhzVMksX81HeI2L+A9hpuq44RIdN9nYQ8AlJ1mPQFrNt2pM8PVm1UGb+q+9M0z+J7XxXdKlsRzSbWUlh4/jRP+w9oXJ+xhHPMiCOuXNwZxoi+S7cdi6dpZeU1BxXahN/rU9AtwGC/DD6BX/r/x7rFhDJ3PpkZcHml5xEM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(110136005)(54906003)(2906002)(478600001)(26005)(16526019)(41300700001)(6666004)(86362001)(966005)(8936002)(8676002)(5660300002)(36756003)(316002)(40460700003)(4326008)(70586007)(70206006)(1076003)(82740400003)(7636003)(356005)(40480700001)(2616005)(186003)(426003)(83380400001)(336012)(82310400005)(107886003)(47076005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 23:37:48.6977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b768dd19-b726-4cfb-99c4-08db7ce7ad36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8340
Subject: [virtio-dev] [PATCH v9 4/4] transport-pci: Introduce group legacy group member config region access

This patch links how in a PCI transport a group owner can access group
member (PCI VFs) legacy registers using a legacy registers access
commands using administration virtqueue infrastructure.

Additionally it extend the PCI notification capability through which a
PCI VF device indicates to the driver which PCI BAR region to be used
for driver notifications.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v7->v8:
- addressed comments from Michael
- made bar offset 64-bit
- prefix legacy specific structure with _legacy
- moved generic normative from pci to generic section
- added link to virtio pci capabilities when referring to bar 0
- remove 'should' from generic description
v6->v7:
- addressed comments from Michael
- removed driver normative about I/O BAR emulation as it does not
  make much sense for the spec
- removed references to administration virtqueue
- rewrote driver legacy region access without guest and hypervisor
  wording
- added normative for notification region
- added normative for PCI IDs for device which support legacy commands
v5->v6:
- aligned pci capability to 4B as required by PCI spec
- added text for the PCI capability for the group member device
v4->v5:
- split pci transport and generic command section to new patch
- removed multiple references to the VF
- written the description of the command as generic with member
  and group device terminology
- reflected many section names to remove VF
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
 admin-cmds-legacy-interface.tex |  2 +-
 conformance.tex                 |  1 +
 transport-pci-legacy-regs.tex   | 41 +++++++++++++++++++++++++++++++++
 transport-pci.tex               |  2 ++
 4 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 transport-pci-legacy-regs.tex

diff --git a/admin-cmds-legacy-interface.tex b/admin-cmds-legacy-interface.tex
index 09001d5..571b256 100644
--- a/admin-cmds-legacy-interface.tex
+++ b/admin-cmds-legacy-interface.tex
@@ -150,7 +150,7 @@ \subsubsection{Legacy Interfaces}\label{sec:Basic Facilities of a Virtio Device
 by the device.
 
 Refer to the specific transport section for the definition of the
-\field{region_data}.
+\field{region_data}. For PCI transport refer to section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interface: Group Member Device Configuration Region Access}.
 
 This command is currently only defined for the PCI SR-IOV group type.
 
diff --git a/conformance.tex b/conformance.tex
index dc00e84..b3f2c92 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -267,6 +267,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtio Device Configuration Layout Detection / Legacy Interface: A Note on Device Layout Detection}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtqueue Configuration / Legacy Interface: A Note on Virtqueue Configuration}
+\item Section \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interface: Group Member Device Configuration Region Access}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}
 \item Section \ref{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting the Virtio Revision / Legacy Interfaces: A Note on Setting the Virtio Revision}
 \item Section \ref{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue / Legacy Interface: A Note on Configuring a Virtqueue}
diff --git a/transport-pci-legacy-regs.tex b/transport-pci-legacy-regs.tex
new file mode 100644
index 0000000..e4f70c9
--- /dev/null
+++ b/transport-pci-legacy-regs.tex
@@ -0,0 +1,41 @@
+\subsection{Legacy Interface: Group member device Configuration Region Access}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interface: Group Member Device Configuration Region Access}
+
+The PCI owner device or the member device or both supports driver notifications using
+a notification region defined in the \field{struct virtio_pci_notify_region}.
+
+In \field{struct virtio_virtio_admin_cmd_legacy_notify_query_entry},
+\field{region_data} is defined as following:
+
+\begin{lstlisting}
+struct virtio_pci_legacy_notify_region {
+        u8 owner;  /* When set to 1, notification region is of the owner device */
+        u8 bar;    /* BAR of the member or owner device */
+        u8 padding[6];
+        le64 offset; /* Offset within bar. */
+};
+\end{lstlisting}
+
+The group owner device hardwire VF BAR0 in the SR-IOV Extended capability.
+
+The group member device does not use PCI BAR0 in various Virtio PCI capabilities
+listed in section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}.
+
+\devicenormative{\subsubsection}{Legacy Interface: Group Member Device Legacy Configuration Region Access}{Virtio Transport Options / Virtio Over PCI Bus / Legacy Interface: Group Member Device Configuration Region Access}
+
+When a PCI SR-IOV group owner device supports
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE, VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE commands, the group owner device MUST
+hardwire VF BAR0 in the SR-IOV Extended capability and the group member device
+MUST NOT use BAR0 in any of the Virtio Structure PCI Capabilities.
+
+The group owner device or the group member device or both MAY support driver
+notifications region.
+
+For the SR-IOV group type, the owner device supporting
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE, VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY
+commands and its member device SHOULD follow the rules for the PCI Device ID,
+Revision ID and Subsystem Device ID of the non-transitional devices documented in
+section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}.
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

