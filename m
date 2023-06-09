Return-Path: <virtio-dev-return-12907-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2B2C7EE23
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:03:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BAA1A68466
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:03:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6675D9867F0
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:03:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 24EA99868AE; Fri,  9 Jun 2023 02:03:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA2759867E0;
	Fri,  9 Jun 2023 02:03:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYOcSYFMYsaE3zLaFAkQnwTZkI3mSIuBEUes5cnZYUMNKcFQcff4nlP0r5SXxMypznUYU8xoU3sY/UEHair+KUsEJwl+hgxnYF8J3ib8FKHyc27+TljbMaTSybV898QoVmmvnKHKRlzbAZ9EYbrTSFRyqBwirQKorU5u06yy3GjIpUSKOBMtWWkIbqd8zhXVMWnUECMy2pdzr9lhZ5jmTdqPSEtIwIuipOmpjYv0WM1+rh6+fK6TKpAWHTaaBBHpjnhE6M/Fv2A0G2Q83VjuQWsJ+hcummnL3/NzktAqXGzTkYshKYoUW6VAo8FRlQyURRtsK4QZscKGm7mi6LMqOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJA/vC1fbL9OxKo4WMXrwjBIEiWmO/wslHDFjK4j/Lw=;
 b=jIpjW57wehclnKkVgLDFYoT/gD/y/4V5ZuFphbrPtehkk45lWCxOPy0cUjtSYM0CRTJktVcRIG0P+swGdhzkbkDi2liE1yl5nMMRDox07GruAoalqe4isQ5TrP/QGouzkGMtycZycxuyUJkUlBzA/1Ikgg/0j+a9GgQ4nwzR/T/ixcDaDDqW9YVlYJYJJmH1NDF7jFVU0Sh3koDeJxbU+MNARJsqIH00HcIFU8MXX2nihHUQitAgCNtkaHdapIsaHiARdvpUq+/RIznfxZtPa1hWajrjsmpY9KBA2osK8YHaPymr1vbgoTgj7lJ5s1cutkFaRzAVfEaHltX8eN+g8w==
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
Date: Fri, 9 Jun 2023 05:02:48 +0300
Message-ID: <20230609020248.869700-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230609020248.869700-1-parav@nvidia.com>
References: <20230609020248.869700-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|BY5PR12MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d0fb4c-1a4c-4cfd-b788-08db688db585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6dVBZ5ieWY6G67yhHZ3Puu+VnGIXKIh6fnsX8OvC5wQYrDVRNjGUejGAXrw+wdREn02rBTVz6xEzoE36bCPay6sdxHBns13H4F1X5T08cOxCsm/gYzoKgqwAGXX7g1cKLUr7ImLW6tTH14MWesL03s+g3xZLx4I3nJdf/QcxuG2zvNMONQSwVSJl1ypzlumhOnaXYELn0eGxCMkJAi0yOFVmrdcXK1oObiBwIwkM1fzWGAHa6yWwHOosB1g/tJz4yNPA5J6kaeNKxmAW1dV/AZR67BvWdb/XdpStunB5bkEe/L9rKuCtEYLzLJkfzfhQzB0EfnCWTugLBPoVvUAVCSHQ3TDbtNFb2ES3rVK9Trg/TOx1JoyxLHngTGY8S5Imx3VLkVjNtVmcNmgsU9hVMQpG/+Oz0T3wLoUnkg4vfFSnAO9t7L7jUhTRbUNMaYVbKFeVguy5lTDpZwzl6oMBOZzpMpPLxMw+Rg/QFOFXFeCAhg7uG+7TXO9V8KqU+JEtG+Pb6Tm6+u69JO1QlvKOQg3bgrfRLOKyvZha6J1kpdJNn2/GIb8tOGIks3sJDVhgNpt/MX1qTDrFhi81wo1ZI0kxxaEbOMnlkPp427imwpXQG11SlzNY2LP6T5++D8S1sLKo60UK68GvO7pirTKpC/nSRtQJHMDzduhxgzfptXHwokrSJDsHYL8ipT6e24Bhqt+4bYszp6y6aJ2KQgyD1mgy0lqBLruCyTuQRKUsxwY6LYyqzwzwgjOMr/h6QkEbOYQ3hL5Kh8jVOAbSdc0+/LWf5KPvw0VdRXL6WuBN1XY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(107886003)(186003)(1076003)(26005)(16526019)(2616005)(966005)(82740400003)(426003)(336012)(83380400001)(47076005)(6666004)(36756003)(54906003)(2906002)(36860700001)(82310400005)(8936002)(8676002)(110136005)(40480700001)(478600001)(41300700001)(316002)(5660300002)(40460700003)(4326008)(86362001)(7636003)(356005)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 02:03:24.6611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d0fb4c-1a4c-4cfd-b788-08db688db585
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4886
Subject: [virtio-dev] [PATCH v5 4/4] transport-pci: Introduce group legacy group member config region access

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
 transport-pci-legacy-regs.tex | 46 +++++++++++++++++++++++++++++++++++
 transport-pci.tex             | 19 +++++++++++++++
 3 files changed, 68 insertions(+)
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
index 0000000..a25b586
--- /dev/null
+++ b/transport-pci-legacy-regs.tex
@@ -0,0 +1,46 @@
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

