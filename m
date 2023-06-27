Return-Path: <virtio-dev-return-13111-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D94CEB64DC
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 21:11:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6635542A9E
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 21:11:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 13E9D986847
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 21:11:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D95CE9868E9; Tue, 27 Jun 2023 21:11:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7572D9865CE;
	Tue, 27 Jun 2023 21:11:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKrTufOwXJNWC7bDbmJaJibVDC6X6APn/rrxYO4r3tacXUOsBj7hFtmEJ52rcAZYy92y7/WrC8mv+8Df+IgbePGId99gRB5jSuGXtqLaCXTFClbnWbUbSzFtYS0nXzhzJqbID3unvfYquXpIGY1QNWyp+gIupFPI19QFA5CY34gEsXqldL4B9ErLMy9l+po/qZf5ABj4xFywk7GctR4UPazZmyyLgH5uBcJQTkZMWG3eQmfHVclZCHptryFlFAHw6AkFsR7wYEVNP7vMhIPSbIPhCnH34uQ4O+GOjgcF7vLrj6Uo8wpueQXbvtIO8pJCycIWi18xPu2s9KgzNMcv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9reK888s+NeDR1cB7g5MUc1AwfMTCPQ8bNWJZmNKjDM=;
 b=CjO9hTWCVQDU2BJmA2l43VnMJ7F0NtUB6EzHVwHA0lkNGjziiJuvaqdIkzVfsDHMOyYvaK0OhjrM0efiKD5kM7XaifCfBu8KYK6NjBsoElJktFR+ekD5LCqrlwWfAxc4443oRv3oenrSglJsDSTYFF50HktBkYSEXnEt5q2NSxJ1sYg8Nl8SXEO64d6yQTBvn3L6uzLG1ZfRGyiK+r70uXVA0RAgXIyi2SjunAyzxJ+nKAMYxuWSU/7CuN/VNp2/5F9xc/Yj4XSgaVNkNl4UWEwKIEwecdbN+wEzVode/cMF7nBjV5PYLM35pMdIamZwtF6tGKm9QYqefF7mS7pOpw==
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
Date: Wed, 28 Jun 2023 00:10:50 +0300
Message-ID: <20230627211050.1527507-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230627211050.1527507-1-parav@nvidia.com>
References: <20230627211050.1527507-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT098:EE_|DM4PR12MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b34a651-c037-4726-b9d2-08db77530dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CruyV7wEHBV72ZgUV9ru2CbafgWMIOMWLM1N0UHaxYOlkTWHUQ+NxYql2zIoIe1FVSivxtNiUstyJIhj8dneOM5HGoZszo1tw2OGOm0ZyjEjRF5Sip4OBW78DYOiLcRRmrXoKS7zKHDhhDA/ZbOX8LtP/RLxkzPw9kn2YMI4gbUnJrqswR1aUI003Nz8lTETVFwg0AceLyDSBCbPhqJLyJE9lSxWVfo72tlfmKODcXZp9vUnmUKH9ExbPKqZJkfR3dCYt53ni4uMhZlBtS7T1PebWLTLVjjo7FdZTFKNAqNlyUHrq/WeymFGjv9zwKWum8bGRzE0ES0DvqpC58G77Hq9ei0JLX39GeChSbiTcL1mMhtTLFa1VZUdVAEbq/TZkzY2VtYnYcpYbFxAlfGrMy2L91cVBUY/KP0FfVPDpaPi4u7FQjl4VIzFDvr19qQELOfHEza4USNw2GqYoc2Imj+uiLQoYhH9S12K/tn5B1qNOEorThivNPjal0s8y3YvIF3CH2IC38eGnTcca8O53ZJXtqzWcigsEflUNG2tg6Ck8geFQ6oYtqHsnOaZTYgWUp7onnRKaZo1Ponuvaceapxe4+Rsg2FkQcd4ow8q78BTAPlrRFtRssKNV6VWUt9MK31XLZz/XwfDG+6F/OlfsOm1ZzEpdCyuzIsDI3Oq3/UulTQ2GCyUpQDVkwET2irJmvb5OjIVG/azvhL6Tnol/ta/eBsME6aHWUSfnL+soC6zX//gKKDF1F8xLzAWIGmauK+Jke38vIj8V7oO1KwHTA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(41300700001)(26005)(82310400005)(186003)(2906002)(1076003)(47076005)(107886003)(426003)(36860700001)(40480700001)(5660300002)(83380400001)(8936002)(70586007)(70206006)(16526019)(40460700003)(356005)(8676002)(36756003)(6666004)(82740400003)(2616005)(110136005)(54906003)(7636003)(4326008)(966005)(336012)(86362001)(478600001)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 21:11:19.9228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b34a651-c037-4726-b9d2-08db77530dcd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5214
Subject: [virtio-dev] [PATCH v7 4/4] transport-pci: Introduce group legacy group member config region access

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
 conformance.tex               |  1 +
 transport-pci-legacy-regs.tex | 43 +++++++++++++++++++++++++++++++++++
 transport-pci.tex             |  2 ++
 3 files changed, 46 insertions(+)
 create mode 100644 transport-pci-legacy-regs.tex

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
index 0000000..9559768
--- /dev/null
+++ b/transport-pci-legacy-regs.tex
@@ -0,0 +1,43 @@
+\subsection{Legacy Interface: Group member device Configuration Region Access}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interface: Group Member Device Configuration Region Access}
+
+The PCI owner device or the member device or both supports driver notifications using
+a notification region defined in the \field{struct virtio_pci_notify_region}.
+
+In \field{struct virtio_virtio_admin_cmd_legacy_notify_query_entry},
+\field{region} is defined as following:
+
+\begin{lstlisting}
+struct virtio_pci_notify_region {
+        u8 owner;    /* When set to 1, notification region of the owner device */
+        u8 bar;    /* BAR of the member or owner device */
+        u8 padding[2];
+        le32 offset; /* Offset within bar. */
+};
+\end{lstlisting}
+
+The group owner device hardwire VF BAR0 in the SR-IOV Extended capability.
+
+The group member device does not use PCI BAR0 in various PCI capabilities.
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
+The group member driver SHOULD use the notification region supplied by the group
+owner driver.
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

