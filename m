Return-Path: <virtio-dev-return-12601-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CD4C77B7C
	for <virtio-dev@archiver.kernel.org>; Sat,  6 May 2023 00:02:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 074432AC5D
	for <virtio-dev@archiver.kernel.org>; Sat,  6 May 2023 00:02:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E9F959866E7
	for <virtio-dev@archiver.kernel.org>; Sat,  6 May 2023 00:02:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D507D9866E4; Sat,  6 May 2023 00:02:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ADC109866E9;
	Sat,  6 May 2023 00:02:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbyAQ5VaUvZKLm/agQUC02L42yzErLWc8vew+sOdQQb9PrMGVbSa+22/52MFkWgZK0ayuIe2+az58mgLssD+qrxI0h076swmF/rpRY7bK6uciBCScL7Ng4Xo4JqMHdAGf6SSwnp6JYg3lv7pZciTuLQZ0epHq4yFhCSXdVaYxSXWXUEz0LqiS1Ny13ZhJWOzXIcoJ+fzfbbF7ylb86ABtMbznajKgUjCuLL+ZNVdcsuFp1ks2yqZl563eEPQLqZW/fyXRBnlDNkR8RN6nIkJFYxxaCoop3Z3zzotlP3uYt34sdBQFeBxz4L8I+7DF5OlgGFxWW/SxU/+7T89a4PayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+rmA27nqQ3aX+3ZmFA2+y3B7gdrSYy43R4RrSlQTJM=;
 b=MXZ1wovBqqon+YcSGkjYS8PLCGbFEhglWalaOYjdtRrJYDQn33P361/yI5tTclj2buJROyHPRiloSrjSB+QztMDPbyp4L17Qjovomh50b+ug4JWDM6KzOZ+yC2PRrnIFIlIAy0N4TwzQ+1ZjDBC3oEUPNPpZy1B/rwcwWwYoZANVq0OHlOkBX3D9/hylM6ym/RJ8vkniyKwjKLG0R0pN4pZ/5YvsGHUPop2kqtmoSVPn4rKRBo03J4TwO+bERlu2CootFO4r/vtVzD4B8nZRSuBz6iPlG23zxpkF6VT5WHo1e8L++TGiK0tATI72BSPS6k4sw+LQrx6WtiHFSIFeGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>,
	<david.edmondson@oracle.com>
CC: <sburla@marvell.com>, <jasowang@redhat.com>, <yishaih@nvidia.com>,
	<maorg@nvidia.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Sat, 6 May 2023 03:01:35 +0300
Message-ID: <20230506000135.628899-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230506000135.628899-1-parav@nvidia.com>
References: <20230506000135.628899-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT008:EE_|LV3PR12MB9095:EE_
X-MS-Office365-Filtering-Correlation-Id: 886be52a-3e0a-4004-af69-08db4dc51ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dbMr7/Ezqvawwoh75vOh5kVAq5oyQWJOjQExfgE/XYT/zLvdQ1Rrr3mO6m/NEfpb8Y4z82Ti+mdXY1JQE/bMWGQwg5cn6rVrmKnO8I5G9JoqK/gHmuXD6c8JIWmA4z+E+esqju7n2DmYJX98CZvFvgW3aBYwozovzGbONZDGt7yF1hmaPWX7/KeP3WJAcFVJT9zTJEV3Cc4B7c/zyuulxOX5MGCRQ3Iw4Lc+0pfB7C3kYqEz1UY3CswJlMxyBFYvmkth0EecV5fZXlFFu1fbxBdsJ9XvGQr33FhQ8GclCImM6H4fcbnKYXk+agw6keCsNOkUsytJF0XzS48GCkJKG0vVrwIiaP/o59FXyIifefEA+t3xtYi3b78Fpc2XlNQ/vsFx131l/8r9rPDruONQg+mkqagIRXjbS8hhRl8NR1V3Rho5pFE5/AgGc6QL0A7YrsTjGwUj2loiOpV3NlJP4VQ9MLrJM19NMFw841tKLF8w43Wzyt8toOxkzF5gwrc6e0m3ceEvzjFImz4O/g8omw7YgVQx7PloiaV0Lua7h+7xcqGMCstpyMqGWeBmrHXkpbE20cqXCLENQtT2gUwWo+HdX7VfDcp+VULBP4PN+f6Ond4538vlw8b7CJTBFpKSO6xT5aKwTJiVhRl3L3V4Vl1XG3AiipGHY6QFcp14sWumLIShvAVsnun2LMz7Iy9xA5qQAce6BYDedKoJ8XfKvw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(83380400001)(2616005)(336012)(426003)(186003)(16526019)(36756003)(36860700001)(86362001)(82310400005)(356005)(82740400003)(40480700001)(7636003)(47076005)(8676002)(316002)(8936002)(2906002)(6666004)(41300700001)(5660300002)(478600001)(110136005)(54906003)(4326008)(70586007)(70206006)(1076003)(107886003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 00:02:02.0982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 886be52a-3e0a-4004-af69-08db4dc51ebd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095
Subject: [virtio-dev] [PATCH v2 2/2] transport-pci: Add legacy register access conformance section

Add device and driver conformanace section for legacy registers access
commands interface.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v1->v2:
- addressed comments from Michael
- removed duplicate and contradicting normatives to existing legacy
  interface section
- added endianness normative for device specific region
- updated conformance links
---
 conformance.tex               |  2 ++
 transport-pci-legacy-regs.tex | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/conformance.tex b/conformance.tex
index 01ccd69..3f2d49e 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -109,6 +109,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / PCI configuration access capability}
 \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / MSI-X Vector Configuration}
 \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notification of Device Configuration Changes}
+\item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces: SR-IOV VFs Registers Access}
 \end{itemize}
 
 \conformance{\subsection}{MMIO Driver Conformance}\label{sec:Conformance / Driver Conformance / MMIO Driver Conformance}
@@ -194,6 +195,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / MSI-X Vector Configuration}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Used Buffer Notifications}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notification of Device Configuration Changes}
+\item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces: SR-IOV VFs Registers Access}
 \end{itemize}
 
 \conformance{\subsection}{MMIO Device Conformance}\label{sec:Conformance / Device Conformance / MMIO Device Conformance}
diff --git a/transport-pci-legacy-regs.tex b/transport-pci-legacy-regs.tex
index 9088fe6..4db578f 100644
--- a/transport-pci-legacy-regs.tex
+++ b/transport-pci-legacy-regs.tex
@@ -104,3 +104,30 @@ \subsubsection{Legacy Queue Notify Offset Query Command}\label{sec:Virtio Transp
 interface I/O space BAR and passthrough other PCI BARs and PCI device
 capabilities to the guest virtual machine without any translation.
 \end{note}
+
+\devicenormative{\paragraph}{SR-IOV VFs Legacy Registers Access}{Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces: SR-IOV VFs Registers Access}
+
+If the PCI PF device supports legacy registers access for its group members,
+the device MUST set all corresponding bits for commands VIRTIO_ADMIN_CMD_LREG_WRITE,
+VIRTIO_ADMIN_CMD_LREG_READ and VIRTIO_ADMIN_CMD_LQ_NOTIFY_QUERY in
+command result of VIRTIO_ADMIN_CMD_LIST_QUERY in
+\field{device_admin_cmd_opcodes}.
+
+The device MUST encode and decode legacy device specific registers using
+little-endian format.
+
+The device MUST fail VIRTIO_ADMIN_CMD_LREG_WRITE and VIRTIO_ADMIN_CMD_LREG_READ
+commands for the invalid offset which is outside the legacy registers
+address range.
+
+The PCI VF device SHOULD NOT use PCI BAR 0 when it prefers to support
+legacy interface registers access.
+
+\drivernormative{\paragraph}{SR-IOV VFs Legacy Registers Access}{Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces: SR-IOV VFs Registers Access}
+
+The driver MUST encode and decode legacy device specific registers using
+little-endian format.
+
+The driver SHOULD send commands VIRTIO_ADMIN_CMD_LREG_WRITE and
+VIRTIO_ADMIN_CMD_LREG_READ with a valid offset which is in the legacy
+registers address range.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

