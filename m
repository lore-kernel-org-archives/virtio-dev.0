Return-Path: <virtio-dev-return-12501-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CFDC77B7F
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 03:27:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 46AEB781C
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 03:27:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3E4189864EB
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 03:27:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 312B59864C4; Wed,  3 May 2023 03:27:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0F9A2986586;
	Wed,  3 May 2023 03:27:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UateCk+skYAf6NuRnYVMVGFTep7+8kipqFKdYgACkUo+QrtuhNVLfvKNWJmXtP/fQ2oGNwp98nka+VZyHxOhXwg9kDvG7pnfLMrIy8ipcIzpQFwlD4N8PhKXgMwTtacfx2qHQppvPOAugwOmZKFQ/z4j04W6y4czO9i8psgbW3j97f4uX0mS2kRO3uGvfRftJdE9kIUxCh9ABNdH9MfSO6fi9GoHISyzVOiJxk2RRGAh+63o5dO9jOvSyBsC5TlLpgh9Fnd05DXEpcM2tArnpHPtvWhTTemfoRs0Q6C/iENK9z82Feh9hz8shydV4QxB53wspnNWELUvUJdrXi0RqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SpV6C9iFuv4ao8EefuLP9YSzZ9sCRK+EAy7bx3VvgE=;
 b=bHATkPguyNY+DywkELYjW1626WUuOkRt+Z1h0GMjJ9tTOVhxZNe7AbLhNuKR+61siS2HqX1aILKMqmH2JHzvZdsGcM0dzs3FocH8xtY8Cvva7v2Ts7xD95LUD3QReJlOxcvVb2x6ZtEjP06rJLG7OwgRsPezufMahOBsROtx91sB0aJP6ARwP10GQwxLKTg8E0sM0OAv1jQ6lgGQquFF3uMd9rNqDXwhz1I4j0eEJ+wKF0GntPwmJypr/9P4Hxujz7B3OA4ZbKv/cgMcjyHxv3/TO1cftixfArXBu6rlyHqqTtSBUGVSDArvcZv7DM+d5C+1tefC02gWPUYO4crfEg==
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
CC: <sburla@marvell.com>, <jasowang@redhat.com>,
	<virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Wed, 3 May 2023 06:26:59 +0300
Message-ID: <20230503032659.530330-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230503032659.530330-1-parav@nvidia.com>
References: <20230503032659.530330-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|SA3PR12MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ada1830-2162-4dad-b9e8-08db4b8656ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UW8V03yG58CCJNegVdieohZ213P/qsCwHoBSLYWytovXRogZdjkS4kqx6Zvk43NOx9CnvwT9uyhMYFCAWcUCuyS5iLxxeTzMFDU5C6VSeSed9KJ1+n0Wx2hb+lD+gmNTPbTVFp0Q3dn3UIYnCy7W94veKY3qfgYf2ghJSAb7N5rufy/MwZf0pT65E/PTc1Jv8xR3zJmdTEbo94gT3H/ThO8l7lPVC04so8EtyGpv0SWOwSMcsPnDZSmhIshcYEkou/t0ZasXbdvasJgdW7GDqdOX2wvCBYxSphCVfNyc2/bKqw7pKWIVt3kfgqs15EEwz89whq+rhB1CyBSrI1esdFHMavSmPVgSG5pd7qLBo5Qg17J/7KBMpQd5gSnUu4BX8kM5kc5Cot8nKxRlydZWOTJKy8/c0iwgNtYWAsjQ1gq+rQn5gS3RDiENBhFiLwyCklM69Lu6HHulioI9WSj7SgBMsE4kyo6x45rwVXX4PFfRz/+ESl+q+R83GCO6WDAr+WfZDmAQ2yhnLFo+JtglsR7WvA0ZcKE0E1jXANQ74wz3ZQY8EZUmk6/wxV4+pH1FTFLwBiizwDC1ICm4xPkuKS1zujOdmkBVr2yUlKHxxnbloxQJVQjoKjEsARKWsO1cpipQyLvObyXGgSEoe8QQBT6RCMjkbEUDltznBqgaRuXJ7UHBDlT/A5kczMvffLPQrwKorU/bC+5VGv0VUjBsBDWPxrbxuLMHRZM5wJeggmo9Ljmkg0xmAGrtpd/ZcUs0
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(47076005)(83380400001)(426003)(336012)(41300700001)(8676002)(356005)(36860700001)(2616005)(316002)(82740400003)(8936002)(36756003)(16526019)(186003)(82310400005)(70586007)(70206006)(5660300002)(1076003)(4326008)(26005)(110136005)(86362001)(107886003)(40480700001)(54906003)(966005)(40460700003)(7636003)(478600001)(2906002)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 03:27:35.5584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ada1830-2162-4dad-b9e8-08db4b8656ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090
Subject: [virtio-dev] [PATCH v1 2/2] transport-pci: Add legacy register access conformance section

Add device and driver conformanace section for legacy registers access
commands interface.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 conformance.tex           |  2 ++
 transport-pci-vf-regs.tex | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/conformance.tex b/conformance.tex
index 01ccd69..dbd8cd6 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -109,6 +109,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / PCI configuration access capability}
 \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / MSI-X Vector Configuration}
 \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notification of Device Configuration Changes}
+\item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / SR-IOV Legacy Registers Access}
 \end{itemize}
 
 \conformance{\subsection}{MMIO Driver Conformance}\label{sec:Conformance / Driver Conformance / MMIO Driver Conformance}
@@ -194,6 +195,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / MSI-X Vector Configuration}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Used Buffer Notifications}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notification of Device Configuration Changes}
+\item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / SR-IOV Legacy Registers Access}
 \end{itemize}
 
 \conformance{\subsection}{MMIO Device Conformance}\label{sec:Conformance / Device Conformance / MMIO Device Conformance}
diff --git a/transport-pci-vf-regs.tex b/transport-pci-vf-regs.tex
index 16ced32..7d0574b 100644
--- a/transport-pci-vf-regs.tex
+++ b/transport-pci-vf-regs.tex
@@ -82,3 +82,34 @@ \subsubsection{Legacy Queue Notify Offset Query}\label{sec:Virtio Transport Opti
 	le64 offset; /* Byte offset within the BAR */
 };
 \end{lstlisting}
+
+\devicenormative{\paragraph}{SR-IOV VFs Legacy Registers Access}{Virtio Transport Options / Virtio Over PCI Bus / SR-IOV Legacy Registers Access}
+
+If the PCI PF device supports legacy registers access, it SHOULD set
+corresponding bits for commands VIRTIO_ADMIN_CMD_LREG_WRITE,
+VIRTIO_ADMIN_CMD_LREG_READ and VIRTIO_ADMIN_CMD_LQ_NOTIFY_QUERY in 
+command result of VIRTIO_ADMIN_CMD_LIST_QUERY in
+\field{device_admin_cmd_opcodes}.
+
+The device MUST support legacy configuration registers to its defined width.
+
+The device MAY fail legacy configuration registers access when either the 
+access is for an incorrct register width or if the register offset is incorrect.
+
+The device MUST allow access of one or multiple bytes of the registers when
+such register is defined as byte array, for example \field{mac} of \field{struct
+virtio_net_config} of the Network Device.
+
+\drivernormative{\paragraph}{SR-IOV VFs Legacy Registers Access}{Virtio Transport Options / Virtio Over PCI Bus / SR-IOV Legacy Registers Access}
+
+The driver MUST access legacy configuration registers to its defined width.
+
+The driver MUST access device specific registers to its defined width
+
+The driver MAY access one or multiple bytes of the device specific registers
+which are defined as byte array, for example \field{mac} of \field{struct
+virtio_net_config} of the Network Device.
+
+The driver SHOULD access all the bytes of a device specific registers in a
+single access when accessing a byte array, for example \field{mac} of
+\field{struct virtio_net_config} of the Network Device.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

