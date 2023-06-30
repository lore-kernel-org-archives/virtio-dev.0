Return-Path: <virtio-dev-return-13179-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FB5EB64DD
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 04:21:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 893D77E2B1
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 04:21:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4B3C398688A
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 04:21:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1C40F986905; Fri, 30 Jun 2023 04:21:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4CED49868C5;
	Fri, 30 Jun 2023 04:21:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYqvkXkzXiQjxVl3RcTRYy+MkGRPLjjtuXnfVVvD8uZcRL7UT2zxbYSE+B3dkh5LIGF3REdtFecWNDxfat433p0WUXJsQiP73x0BcdidskLndzwamjW97Sr3olCvRvNHuYOXBMT8ij8tYqsJOOSEpQY/dyhNnQkUmVsZcGO7Kme/gHYtJ7qNxDVSl18x/bf22jliLO0AlUnQX2x7E5Ls6R9GnFmpZXbtItM0gUPNZVNVn5o2WMMwIZCntTgbH1P7eh5ItRGWg80GJ97Wo3aGgxJfRTj7GhXHcLAxBuRxRZcDl++aNgfolTMVMb2rIBI/g42u/dLDR5iTrlkbCU42fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrWO6CC+Ua1ldPnoBgAPp0Bd1I2cqu3bZl5jyina4rM=;
 b=n+ThxPBdggXhvOjupnNhiarZ6f/B3OGU3eqig0UEooBzYGvH9t0ro2CnWtesEqQm/0K9xa+XCqg1j3/1BTlthXjOOHBpTWD2TqLttVO2TGrW4gIeDxLeZlU/1hrRMME94kMLm8zsxY7I8CTiYwLrkhWxIA6N0uJ51wjh6/49t7J5/7K9zQGjnRbJQa8uQLm90eUSNNrMCqAHA1/tJ+2X6yMIgwqusuX72P6etmmPAoQERZLmiTPFDhJ844aUm3OR1VkJrD8ZeI+4ne9yVaXsLYSakTxN19A20puNrLJekeahAePdvW5RtT5ru8vmvcYw0qZpYKqg1B+OlMFTAKP4Fg==
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
Date: Fri, 30 Jun 2023 07:20:06 +0300
Message-ID: <20230630042006.1569920-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230630042006.1569920-1-parav@nvidia.com>
References: <20230630042006.1569920-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT095:EE_|CH2PR12MB4907:EE_
X-MS-Office365-Filtering-Correlation-Id: 21150389-13c3-4129-e02c-08db79215fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fM5vSP1PTQs8qbAeU3dpbdlrZtZg5QJHelDbjsm007IDaucSHbTOdUyffSQ3TjJF08hwp645dYgdZfsjAW6b4DsmYaQ3Uf/GPaPY/YqdKcr94qUbxMKfZdLw6+3sp9xrXWnzu7cVbqsbQ1hMJy0Ks5Tdh3DQk8vvf2apFnnd2+dYnCpEvT2es6GzhWAjEN5o/LvQlhZJaDZ2s4Iijw4kG6eGdetS/9lnU/2egLRK0o3nAxijevXZMwXAR8+dvlO0O6DeuoH3u2ObxrWsu8e8lgTmonWsd/0G8gVwWzN7mDO9m3R4A6r9VDOyrA08Wd9t2SkqBwfzAtK4ArzXtda+1cTHM5FIPhIDtQFH8Hezk67lLQUPYUAX2a9hIALKUC6UtaNhWAHMfYRbn/QlYOgJmqP/eZ9CbRHd81q0tR9MovrEBqfdVYeWWYXNrYalv4m8H39ByL4JLsQAGAPvOuaPxpg3em3ciYMhwdKTdSnpQluvQdJJ0U+ymAWPgO5zCreYMCnGJUR4z3ta9zm/YpXKodZvhO+cXubLH6y2d/UQ3a7H6dUijX6T/DvB5+wnEdu06orLVqirCy99WrFgGWbr/4ptiN+8ExhK060uyJmq33S/EniK0341JbCVibVEBrkrYeUxRrd0GsxvxZRvZ57JNI8filU1+rcQuxgHPmgu9fYGsbDie+ctUfx/r8jZVdwRDJakrlxXoHT9vhbn+HHrSinEy/rxJCbjXe0X8yysCYvqZHv9EzEKjj5tur9ew5ko1dKr2gomwxIuAUUnPk4ypj0z1IHZC+2BJ5QW7xeaNGU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(36756003)(82310400005)(36860700001)(107886003)(966005)(47076005)(336012)(83380400001)(478600001)(26005)(54906003)(2616005)(6666004)(426003)(110136005)(186003)(2906002)(16526019)(1076003)(356005)(86362001)(316002)(5660300002)(7636003)(70206006)(82740400003)(40460700003)(40480700001)(70586007)(8676002)(41300700001)(4326008)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 04:20:44.6886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21150389-13c3-4129-e02c-08db79215fa2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4907
Subject: [virtio-dev] [PATCH v8 4/4] transport-pci: Introduce group legacy group member config region access

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
 admin-cmds-legacy-interface.tex |  4 ++--
 conformance.tex                 |  1 +
 transport-pci-legacy-regs.tex   | 41 +++++++++++++++++++++++++++++++++
 transport-pci.tex               |  2 ++
 4 files changed, 46 insertions(+), 2 deletions(-)
 create mode 100644 transport-pci-legacy-regs.tex

diff --git a/admin-cmds-legacy-interface.tex b/admin-cmds-legacy-interface.tex
index 8036a0b..f5d7d08 100644
--- a/admin-cmds-legacy-interface.tex
+++ b/admin-cmds-legacy-interface.tex
@@ -149,11 +149,11 @@ \subsubsection{Legacy Interfaces}\label{sec:Basic Facilities of a Virtio Device
 };
 \end{lstlisting}
 
-The driver should pick the suitable entry when multiple entries are supplied
+The driver picks the suitable entry when multiple entries are supplied
 by the device.
 
 Refer to the specific transport section for the definition of the
-\field{region_data}.
+\field{region_data}. For PCI transport refer to section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interface: Group Member Device Configuration Region Access}.
 
 \devicenormative{\paragraph}{Legacy Interface}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Legacy Interface}
 
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

