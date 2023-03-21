Return-Path: <virtio-dev-return-11689-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A14C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0800D44344
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F0BDD98653D
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E5A6898643D; Tue, 21 Mar 2023 21:59:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C6E3E986452;
	Tue, 21 Mar 2023 21:59:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/G0am6avH3030BuC4+eP3yh+2aD71b7r18CcqFBH65fpSwJcjV2htZMkPamMX54a+8JwgDhexk2HOnZPFfoPtEP4IOEx+TSkMLvxb1ExRZ1Z2Uoskr1SmieGZHrnFn9wwFutoQqGTFn1q2dmeEcHw9TSZlq06kVHf26w3SkNIG7Xqo+yoZNt9ux2HQEODWdttgpNYb7tY86yKwUzIiywCzfGDz9+c5RYyXCqpkjY9osDrV362BFdz07eaL7B6ACk4co1hqXL1pZKWJGVb78HNhxtxfedtFnhwW5y1dCkxWifZgtbnk6QXHut/Vfixxft9aXz53L+n6/orxDOhoZqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqyEd8lonfi7og9+CsLWpyfuv0WPDMLnqtmJk7bV5b4=;
 b=D3MStITx5jinI0TP2bhpdRwdktNF1U83LnN6GjdSeWTA4OYeJZnQIIjZxP9iPEwnyVVkhusTr5Sf1IgwATTeUmpTpVRPBqs2+7pSMkOhGELjDZZPDvRUgRk4Ntyjo2hUiaXe0JWIAC1eiGqin9X+8OyQ95Y6SnBiBqdasso4xDD9PMvYaqXbQGG5hiyMwbP1+76+KAAPPsQpQT2IP/t/TavjXEXxfhA3/9CBdbFFAF6cwNQg+F0Cknm4p81pMyIP3jru9DF8AT4VwJ8fn19VK8lAEN20eALVq2DHlz2+exCGaRBuKuZP4DBVuFO8fn/bL3jhqaCg+jroHhNVuQCr1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Date: Tue, 21 Mar 2023 23:58:28 +0200
Message-ID: <20230321215834.225856-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230321215834.225856-1-parav@nvidia.com>
References: <20230321215834.225856-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT063:EE_|CH0PR12MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: bfdfb0ef-499e-4167-5256-08db2a577c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a2WesuFBfQCpnRAPioL+OOUOw3YmeETIxQnsABo1b3z0nJEzeyG5uoEak8VyloFJCOcGtYK3cen+A9hMOz1OEnl9V1IzXbD4J4gKZVB7TEBbLnM1A7dV0XrU4UJlN2XUifqA7wA8HKSurumt0VLZHbJ4QsXbqW/ZgX0fmqz8VSAyjTOuQXkDNFK/tXv1HjkXeyUApXtC6rYWhqAO8wvDJYuJqdIxqGIYAaANjumSlsGueFtZs6bpHg4n9Sesv9S44qarAOREI3mMNE7yTEpte5yuqIi6RGbslKD1ZR+spi7cgZGQC4zOrhEIonqpMNK3i7F3l+L8T0NmejLjn04dBHFyfR/zfYWQYGxL5ly+dlwgGMbKyZiunAwHioBMWovrsrqtJwxHePEp8e86zzUp0yqgruA0W0DSMm5X4UxODOk6ii/l/XvP5eVURHh7QC/lp24slLCryJOlVC8wukbt2s2+u3k0F9kW2AA8iPHGNaY9NKD2XdVBxIyEWPolxpPZFOkXnn7Rta4c2UU6oFEibF5tWJK4wo5qIa5MD20nEXyBYCqEZG1kpceREbjc7v/TdscKS1Xo8wb4kttCu1zUH6+HdlgmEBC6TPDGhIdRQt06uho9kKfE1zSjZFDX4UVprgNx9fQxFZOZVVreqnp73Yi1Cx9H1CdnLrYKP2zk1tSusfCD1tntk6RR7lrGN51qxAF9Bkq4NRjSbyCwam54/mJT9fVlPs1bE7GV0FLnxV3hxLbrwPDYWDVjLYiIJtiBZjdZL4zM5tiW/JvjyJu9wj5C19NwBF0gIdV/O9GkMlYl7kIAj1kWEULxqY5Pq9UcwaHJSiITpuhBABOk60O7iA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199018)(40470700004)(36840700001)(46966006)(82310400005)(86362001)(40460700003)(40480700001)(36756003)(316002)(83380400001)(4326008)(426003)(8676002)(70586007)(478600001)(110136005)(54906003)(70206006)(16526019)(336012)(26005)(107886003)(2616005)(1076003)(966005)(47076005)(6666004)(186003)(356005)(82740400003)(7636003)(5660300002)(8936002)(36860700001)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 21:59:04.1677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfdfb0ef-499e-4167-5256-08db2a577c8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5316
Subject: [virtio-dev] [PATCH v3 2/8] transport-pci: Refer to the vq by its number

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

This patch is on top of [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v2->v3:
- addressed comments from Michael
- changed vqn to virtqueue number in the Note
- refer to vqn field instead of virtqueue number
---
 content.tex       |  2 +-
 transport-pci.tex | 14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/content.tex b/content.tex
index 1ab7794..0f634ac 100644
--- a/content.tex
+++ b/content.tex
@@ -321,7 +321,7 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
 VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge
 might allow optimizations or simplify driver and/or device code.
 
-Each virtqueue is identified as vq number or also referred
+Each virtqueue is identified by a vq number or also referred
 to as a virtqueue number; vq number range is from 0 to 65535.
 
 Each virtqueue can consist of up to 3 parts:
diff --git a/transport-pci.tex b/transport-pci.tex
index b07a822..044c085 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -390,13 +390,15 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 
 \item[\field{queue_notify_data}]
         This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
-        The driver will use this value to put it in the 'virtqueue number' field
-        in the available buffer notification structure.
+        The driver will use this value to put it in the field
+        \field{vqn} in the available buffer notification
+        structure.
         See section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}.
         \begin{note}
         This field provides the device with flexibility to determine how virtqueues
         will be referred to in available buffer notifications.
-        In a trivial case the device can set \field{queue_notify_data}=vqn. Some devices
+        In a trivial case the device can set
+        \field{queue_notify_data}=vq number. Some devices
         may benefit from providing another value, for example an internal virtqueue
         identifier, or an internal offset related to the virtqueue number.
         \end{note}
@@ -1005,7 +1007,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 The driver typically does this as follows, for each virtqueue a device has:
 
 \begin{enumerate}
-\item Write the virtqueue index (first queue is 0) to \field{queue_select}.
+\item Write the virtqueue number (first queue is 0) to \field{queue_select}.
 
 \item Read the virtqueue size from \field{queue_size}. This controls how big the virtqueue is
   (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues}). If this field is 0, the virtqueue does not exist.
@@ -1035,7 +1037,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 the driver sends an available buffer notification to the device by writing
-the 16-bit virtqueue index
+the 16-bit virtqueue number
 of this virtqueue to the Queue Notify address.
 
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
@@ -1053,7 +1055,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 If VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
 \begin{itemize}
 \item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the driver MUST use the
-\field{queue_notify_data} value instead of the virtqueue index.
+\field{queue_notify_data} value instead of the virtqueue number.
 \item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver MUST set the
 \field{vqn} field to the \field{queue_notify_data} value.
 \end{itemize}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

