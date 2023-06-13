Return-Path: <virtio-dev-return-12945-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F16EB64D7
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Jun 2023 17:31:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5F5AA7A1CB
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Jun 2023 17:31:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4DDB49866CF
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Jun 2023 17:31:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 42D6A98657F; Tue, 13 Jun 2023 17:31:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 16B959865C3;
	Tue, 13 Jun 2023 17:31:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqYUOHm04OUV8IJALlO+m3e4UY79xh1YAGqnmW44mM9M1zHG7XHdiRSG59pE0FyH/ZN/0m0AdQ87E7kuTd1hW8Ka9aJhVdljR+c/5IY05vXsmGt8ytJNm69fMYnKQPSSrg58ADCbQgjXpEik6f0qr2mBI5CL0vl8hHFP41gG1XvpdRp5Lgfu4V7OYLp7/AnKm3OnEJdqnPFZUWAM9ioA7hkq4qclPU503mZwK6Ye9y+qEJp26KkACJZwekYMXPUZYD09qL7WrCxr5Hq3T0nyr9yZyRSu/yK0yWPvOM7fF4/TK+oRKhx2YZpmxAXIsJ2ebA/HLJZTtw/9AbW63ULcIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxFrzordpECGojg+rcsJaowf/1MrCnvOQ+d80b4V2uM=;
 b=kcYQZ5Qy90dNyRgVwTY0p/IwrnqpmnHcL1Aooe8xZ3ZYCLv2FMyiIVJRdishBo37JhkxrufhP9z/BOHAl265adQTVBcw9zjZYJctMXu0bFdgSY0lQUoh9wIH6qxVNgY1IWtxhP++uEccyDY4FFkPrtG9NaAC4J5agolHN074/OFbDqXh2T7jQ+hGg5Nl7cEahc9gI9muWjx+BxgYWNOvVVzOMr/zmKumldkARSlxwkTluDwQD1M3201QaixhAZ6tLD3s+TVcMwHw7PxG8RIg8KuXjH+vv8tTGzSBio5y/Wh4jpUWWrIU/zo520i9ps23ZqWJdFH327lEA99H3ov8gA==
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
Date: Tue, 13 Jun 2023 20:30:15 +0300
Message-ID: <20230613173015.1244486-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230613173015.1244486-1-parav@nvidia.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|BN9PR12MB5305:EE_
X-MS-Office365-Filtering-Correlation-Id: 402557cf-d50f-40dc-23dc-08db6c33efd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qlgbmyw3DYRom7D/SFeDAh1/8sIYc+7bfGoLoExpqjhkPIaa+gCE5se29Ps3sGtXMQOzXJRTPUHwf28W+ixqrUnLtqD8porjLj2mO3zSy6HmV2apUwCY4V3fOpflm8NJ2YSAUyrv1UpiS2Mj65/SyP3G/4IXbxediIFmpXwgrSFXCxFn6inBX01loxX0B3hjxhSRvXuQndxEBJ/yKrXURhxQ/PCQPZ82LN6BdemTnbhH/c6qZXLRC7qf21XRCBPMGdvoCm6ZHOXcDySQ2Nnkif4RNTaLYEQY+3tUOycTE1nm865OZCX1cBBQOtIgPW5xJ80q2H6kdSzUgubBp3gAPR3hARRDCdtnq/vnT9TI+9CdgL6edijTGyGqEV8pxgDXSm4ZycxNcc62tZGGgR4UelWN2Le2jhxjDjaeV2jrgp0TcwAIYj4AF7YaRozttIE96oHY7JCiOF7HKMeSYeVFp6moSC6413EerN9jMJyX7IjfLn9aOnnz8gJave0wQz+Ow0IfL92SnyoWT+M1A/UuACE2O4VRvmvnPn1Ghl9dVB5KRHCEoboUqvw4zS2R20P+aEqfdTM4piWD63Blle03dDtwQ24Rk7a1eFSTbeAMBrBcY11LVK+PRC5rfuFW5kQfesuKuxlnl8t/ZX+snjdSadVjwilUQb3eCm0dGy9IIHDjT93bh0BTTIwjhdOw8SkuAOBFC4vTIZoGHxoVWEdB6D93gWG/kfhUFdrtN4cotPICM0RZ4ZwgDzFq1ckPK7kXwwfcytNdXs0aiSCQBLdkZ2AdS7h2L7K1iY4Mbin5Lec=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(4326008)(316002)(70206006)(41300700001)(186003)(70586007)(2906002)(54906003)(110136005)(8676002)(8936002)(5660300002)(478600001)(16526019)(6666004)(966005)(40460700003)(107886003)(82740400003)(40480700001)(36860700001)(7636003)(356005)(26005)(1076003)(336012)(83380400001)(47076005)(426003)(36756003)(86362001)(82310400005)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 17:30:52.4349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 402557cf-d50f-40dc-23dc-08db6c33efd5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5305
Subject: [virtio-dev] [PATCH v6 4/4] transport-pci: Introduce group legacy group member config region access

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
 conformance.tex               |  3 +++
 transport-pci-legacy-regs.tex | 48 +++++++++++++++++++++++++++++++++++
 transport-pci.tex             | 20 +++++++++++++++
 3 files changed, 71 insertions(+)
 create mode 100644 transport-pci-legacy-regs.tex

diff --git a/conformance.tex b/conformance.tex
index 6bac4b0..93f409c 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -267,6 +267,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtio Device Configuration Layout Detection / Legacy Interface: A Note on Device Layout Detection}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtqueue Configuration / Legacy Interface: A Note on Virtqueue Configuration}
+\item Section \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces Requirements: Group Member Device Legacy Configuration Access}
+\item Section \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces Requirements: Group Member Device Legacy Configuration Access}
+\item Section \ref{par:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: Notification capability}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}
 \item Section \ref{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting the Virtio Revision / Legacy Interfaces: A Note on Setting the Virtio Revision}
 \item Section \ref{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue / Legacy Interface: A Note on Configuring a Virtqueue}
diff --git a/transport-pci-legacy-regs.tex b/transport-pci-legacy-regs.tex
new file mode 100644
index 0000000..b671b3e
--- /dev/null
+++ b/transport-pci-legacy-regs.tex
@@ -0,0 +1,48 @@
+\subsection{Legacy Interfaces: Group member device Configuration Region Access}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces: Group Member Device Configuration Region Access}
+
+As described in PCIe base specification \hyperref[intro:PCIe]{[PCIe]} PCI VFs
+do not support the I/O space BAR. Due to this limitation, a PCI VF hardware
+device that supports legacy interfaces cannot be attached as passthrough
+device to the guest virtual machine.
+
+To have a transitional or legacy virtio device in the guest virtual machine,
+a PCI PF device as a group owner may support accessing its group member
+device's legacy configuration region using the group administration commands
+listed at \ref{sec:Basic Facilities of a Virtio Device / Device groups / Group
+administration commands / Legacy Interfaces: legacy configuration access commands}.
+These legacy configuration access commands are transported via the
+administration virtqueue. This mechanism enables minimal involvement of the
+hypervisor software only for the purpose of the legacy configuration region access.
+
+When a guest virtual machine requests legacy configuration and device
+specific regions of group member device, a hypervisor software accesses
+it using an administration virtqueue on behalf of the guest virtual machine.
+
+Even though virtqueue driver notifications can be communicated through
+administration virtqueue, if the group member device support such
+notifications using a memory-mapped operation, such driver notifications
+are sent using a group member device defined notification region.
+
+The group owner device should not expose PCI BAR0 for the group member
+devices when it prefers to support legacy interface for legacy configuration
+access using its group owner.
+This facilitates hypervisor software to operate with least amount of
+complexities to emulate the legacy interface I/O space BAR and passthrough
+other PCI BARs and PCI device capabilities to the guest virtual machine
+without any translation.
+
+The group member device should not expose PCI BAR0 in various PCI capabilities.
+
+\devicenormative{\subsubsection}{Legacy Interfaces Requirements: Group Member Device Legacy Configuration Access}{Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces Requirements: Group Member Device Legacy Configuration Access}
+
+When a PCI SR-IOV group owner device supports
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
+VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE, VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
+VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE commands, the group owner device SHOULD
+NOT expose PCI BAR0 in the SR-IOV Extended capability. This is to facilitate the
+software to emulate I/O region BAR0 for supporting the legacy interface.
+
+\drivernormative{\subsubsection}{Legacy Interfaces Requirements: Group Member Device Legacy Configuration Access}{Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces Requirements: Group Member Device Legacy Configuration Access}
+
+The driver SHOULD NOT emulate I/O region BAR0 if a device group member exposes
+a PCI BAR0.
diff --git a/transport-pci.tex b/transport-pci.tex
index a5c6719..3647485 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -541,6 +541,8 @@ \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options
 struct virtio_pci_notify_cap {
         struct virtio_pci_cap cap;
         le32 notify_off_multiplier; /* Multiplier for queue_notify_off. */
+        u8 legacy_q_notify_supported;
+	u8 reserved[3];
 };
 \end{lstlisting}
 
@@ -560,6 +562,14 @@ \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options
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
 
@@ -596,6 +606,14 @@ \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options
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
@@ -1212,3 +1230,5 @@ \subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Options /
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

