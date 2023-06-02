Return-Path: <virtio-dev-return-12839-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F679C7EE29
	for <virtio-dev@archiver.kernel.org>; Fri,  2 Jun 2023 20:37:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 127C542571
	for <virtio-dev@archiver.kernel.org>; Fri,  2 Jun 2023 20:36:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 04D02986832
	for <virtio-dev@archiver.kernel.org>; Fri,  2 Jun 2023 20:36:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ED39B9842E9; Fri,  2 Jun 2023 20:36:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D045B986827;
	Fri,  2 Jun 2023 20:36:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdzZYFFSwdptLKwU/ObLDfrXakcCQP8it7sdHI/0fs00r/VFgqWrQiMNbUnJwOy+CaZpVqZD/GoCgSEw1CZ6IfQLKlmW2nY23+3xdtwZ7K4JoG1m3R/QoZho+IN3Yo15ZGhs1Wy9hBdK6m5y0gy4jNyyxdFWe7eM3QXUZoiayKZ8WsIwYWtwimPOm+r+oaeJhKB7Bt/bp1SPcEEApXNqj+9pPMIdAbhXM40ju0w0E1LovifyqeL+duhSsQYa7a89buf9dOE4XV9Sf++fAI1xReJPBmAmnVXBoL4NRVcloF0+UPkNjqk6hxC3EyBXB3f61bWRGRQJE5qm/5lKw0PT9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTT9gDX+6bzu1FmTZUTRa2ociy/49gqYfc4gE1yQ0P8=;
 b=G3y3AU/Q/CUUpr7CdJ8bqk6uCS0n39DY7WeZC/tIEPYJ7NXl/oS2l5CfvQ5wtFj6xGVhgFDZP0tRHt97IHhLLp0QvGqHuUoBU0QbSAjZQbncitgEJDFOK0KVsuNSGP+lNZIHDgnDGHsxSiUPgE4tM/NhYiKGn+fglKbovOyeEhH3Y6vy/woAYQg9QV/uTNe7gNq9Ljm3wopCl3JyxUvLtr0iXm/ldlYSySHwBujzNbCAfaI7/CDFlccWnk33c+jQiy3VQvXUyL64YHy82cIq05fh9nnq+CkZvxdq0Be72676n9ROcRg9Len1QU78AJdslU5lt870KNqd8aQKYt7uRA==
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
Date: Fri, 2 Jun 2023 23:36:04 +0300
Message-ID: <20230602203604.627661-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230602203604.627661-1-parav@nvidia.com>
References: <20230602203604.627661-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: caf6b185-dfbd-4b2c-6d3b-08db63a90d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S9tm345wFE/DfN2t4pMwOd9nLtSbMMxcriTxZ0TCkM7panvF++djGJ5clXrkpCOaor5YzvuPgTRcbjz3wj3/WQYd4LZkxunxliKOxJrHPmg6o/6IeJk/5V6XOZvzj7kDFOAmWVEiDWivKjSvPXLCeoPrr1GQ+//HBGSjcAyrIZe19F1B0MIyb37HPAF7DUxTqyCl5cK5g1y4QZAOBBnnOtL76ay/tpJSeFClCqK3G4AKqsJxRq71yZY0duX96pY27v3CEfqfKWdrz6YZl7wf7/mcbceo2KLG4wpKhpPEcsNFKZ+JJPh77pKxkKIJ5sAwa1ZI29Uxh1x4Bb2htIPXlgSuQ6Wf2J1c+xT7MZpXUqJJdwWrtmezScX4r/s+2w1G+/njdzY3jIL5r6PgL8+1uLqH03gaq2nauHEJJTFBfBbGJvFH3ZJbVcLzAagDN9tAxxadaHklCOf/eOOlPqAxWwUD0cKu5jXYm3o7uHwSKlOyR2zn2m7t99Q8hc+NLI6X7yOn0L1MWwOJL71MeTpQ34mgo0viDhZLsIFBcLQp3lw4kY4WMYCvuUPPHQiKVx66Uuqt6ZcVjq3ZR0lsnBL32G7tgX05oluz6DWtK24M/XvFE9NI9XY1PHrB/NjQFXOxuet7xcb3/b3n/ULl9ARaRGm+lv1Pr0C7lVoQTU1IqfMHGAR2PrJAbtznDgBjXMTiBCFZ4SSlStRyXOd7MK3MA6TMRPLh2rOtHs62lqmeqrG7lNPctWPMv4zdE8cjnkmKbzSxrA1GS6jLFjFi6XMvdw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(36860700001)(47076005)(40480700001)(83380400001)(426003)(336012)(82740400003)(356005)(7636003)(41300700001)(36756003)(4326008)(316002)(6666004)(1076003)(26005)(966005)(107886003)(70206006)(70586007)(40460700003)(2906002)(8676002)(8936002)(5660300002)(2616005)(54906003)(110136005)(478600001)(86362001)(16526019)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 20:36:32.9646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caf6b185-dfbd-4b2c-6d3b-08db63a90d8d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
Subject: [virtio-dev] [PATCH v3 3/3] transport-pci: Add legacy register access conformance section

Add device and driver conformanace section for legacy registers access
commands interface.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v2->v3:
- added normative lines for two additional commands
---
 conformance.tex               |  2 ++
 transport-pci-legacy-regs.tex | 38 ++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

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
index 948ac73..f3dbf45 100644
--- a/transport-pci-legacy-regs.tex
+++ b/transport-pci-legacy-regs.tex
@@ -136,7 +136,7 @@ \subsubsection{Legacy Queue Notify Offset Query Command}\label{sec:Virtio Transp
 
 The driver that may use the driver notifications region of the VF device
 returned in this result likely attain higher performance or the drier may use
-the VIRTIO_ADMIN_CMD_LREG_WRITE command.
+the VIRTIO_ADMIN_CMD_LCC_REG_WRITE command.
 
 \begin{note}
 The device and driver must encode and decode legacy device specific registers
@@ -151,3 +151,39 @@ \subsubsection{Legacy Queue Notify Offset Query Command}\label{sec:Virtio Transp
 interface I/O space BAR and passthrough other PCI BARs and PCI device
 capabilities to the guest virtual machine without any translation.
 \end{note}
+
+\devicenormative{\paragraph}{SR-IOV VFs Legacy Registers Access}{Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces: SR-IOV VFs Registers Access}
+
+If the PCI PF device supports legacy registers access for its group members,
+the device MUST set all corresponding bits for commands VIRTIO_ADMIN_CMD_LCC_REG_WRITE,
+VIRTIO_ADMIN_CMD_LCC_REG_READ, VIRTIO_ADMIN_CMD_LD_REG_WRITE,
+VIRTIO_ADMIN_CMD_LD_REG_READ and VIRTIO_ADMIN_CMD_LQ_NOTIFY_QUERY in
+command result of VIRTIO_ADMIN_CMD_LIST_QUERY in
+\field{device_admin_cmd_opcodes}.
+
+The device MUST encode and decode legacy device specific registers using
+little-endian format.
+
+The device MUST fail VIRTIO_ADMIN_CMD_LCC_REG_WRITE, VIRTIO_ADMIN_CMD_LCC_REG_READ
+commands for the invalid offset which is outside the legacy common configuration 
+register's address range.
+
+The device MUST fail VIRTIO_ADMIN_CMD_LD_REG_WRITE, VIRTIO_ADMIN_CMD_LD_REG_READ
+commands for the invalid offset which is outside the legacy device specific
+register's address range.
+
+The PCI VF device SHOULD NOT use PCI BAR 0 when it prefers to support
+legacy interface registers access.
+
+\drivernormative{\paragraph}{SR-IOV VFs Legacy Registers Access}{Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces: SR-IOV VFs Registers Access}
+
+The driver MUST encode and decode legacy device specific registers using
+little-endian format.
+
+The driver SHOULD send commands VIRTIO_ADMIN_CMD_LCC_REG_WRITE and
+VIRTIO_ADMIN_CMD_LCC_REG_READ with a valid offset which is in the legacy
+common configuration registers address range.
+
+The driver SHOULD send commands VIRTIO_ADMIN_CMD_LD_REG_WRITE and
+VIRTIO_ADMIN_CMD_LD_REG_READ with a valid offset which is in the legacy
+device specific registers address range.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

