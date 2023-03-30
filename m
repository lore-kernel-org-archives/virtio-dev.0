Return-Path: <virtio-dev-return-11869-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1404C7619A
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 23:00:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 24D727E2A7
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D8F1F9868A5
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BF2289868AE; Thu, 30 Mar 2023 22:59:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC4A698675A;
	Thu, 30 Mar 2023 22:59:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmKc7I4eRhTqheZjsQFUIYKkZirn+eM1Z9eoKiUOzeY8wLtlmnFK+Ex1kdHOaiFleEYbqfcsUS0HdTQzWZMIW1x4vG5zQDPW8Ml0WCa/73MVVfFBdsuoD4curHOYBvv7t+qQqPYpcqTxmaCg1/0oKlQ2q4FfJJz9VqbfeuleW61Q+MAxvfn/+Am5+zyQnHfcQEUXEvU9x624YNqTUizScPUdclHcHfnSHU0L9HVdI0cQifvtXfErmU9EAtyxuPERe/jYRmywKwNNeEDZPbpT31bdgK7S7RwXB7LgYiKJtBDvmaRhKO5jr79gkShslRnTllrbktYGvNKQjghmTl7xjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/blO9pq15sQ/uC5nG/HcVldLTaq8TzaajKAIURUVYO4=;
 b=OC4HLjnPfswy+IsxWpqSlqgtKqrQkvufHAiaMBKKxYETj+PbOeTH/kVlF/fFcL3lBcf3poLysgQri8u8xgPwkQwArxZj89mXUGv3Cga4D2tTU7RlRRYiVe+jQsFGiwqklb7969hoabTga2o27GFhEauDXHDGFqeU7Kd/6I8YgqrSWBsb6OfrtR75NyckURFDK9N4viB00luumADTz8b8RJhmHGVNad7M8aZ242ZXaNyH4wLW+4S0MtNRhUei2Go91pZhZpd3/kDdhTq1cFm9pcEU2t5tHRxXRnihICDZRkhFQj/ZCwcuFswMiazRUQyQWQNXt8gYZIx/eOalyYzAlw==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Satananda Burla <sburla@marvell.com>
Date: Fri, 31 Mar 2023 01:58:31 +0300
Message-ID: <20230330225834.506969-9-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230330225834.506969-1-parav@nvidia.com>
References: <20230330225834.506969-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|DM6PR12MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: 88faef2f-178c-400a-e871-08db31726a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xjnJFIV0Erxo9Mvip7Ab/54edRU07OxJCsYjSv5FRo5b4u95ZscMmLQ3CNwgRGR54UYkCHI1sAL7u1zTo/Xa1igk4K3hqo8tNXDJg/Ov7I1fklYRgh1qmq9vMWya6MUEFg8r9QRm1heMw6rkMB8uy0Ef9/DwCHTyObEezPni2lvuu12OLZ7lPBHpY5dQmXiOYkCIPv7aFL2LGMQWdbe4ESuHkE98uVUT1cWgP7SIB8kkWEvSgUU6LhyNZHqmB0ZQ5ANKY0IGhpBVVNfYU9oat41DElVEO7KWyR7Wq/670XEVvJJpci7eqURcpatY3WxVxbletYMGv9EL4D7VsZ3ha0b38oXiAlaiFyoeioEXEbXh12hGqHsUspOINggMX7JOB/lC5KJcvGTYHucSEBfxqJLvTBKi+C7S6I02w59I0md0dTZz09xTgxlBa9yyVmIhq8gFwv8WZUISpTMGfWgkmuW2Isz2w1aCTGafc2DdQiFuQumuKeDCjiqMjObC2xSKgObq+GLEoO+DPeHNr90I6yDNZtF+KIyQhXlS5GE8Jjri4nWePTtxIfBEVWnx1iHByIgg7VgbBj4j9CrIr47ybjJFU/EOlgqYLakD2e/MTbwhvC+8cBxH9i2PwtWNGvuPnudFHcxxEqkzhmHB2hwafwiqnYkehE9bKybiYz+8SMxtXMLjPtVsR/TG72yUJvjt52jVgdAturqEDMyCoYKIOqsA9mXRZkn2xoSTryrZWGDYeFMDNoBFgh1mPOUdXgIY5xKvcuQUu23qV/abo7yOsTYscvjLhWSwF6U8NL1dKk8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(47076005)(34020700004)(2616005)(426003)(36860700001)(83380400001)(1076003)(16526019)(110136005)(316002)(54906003)(478600001)(6666004)(26005)(186003)(2906002)(5660300002)(70586007)(86362001)(82310400005)(7636003)(36756003)(356005)(8936002)(4326008)(8676002)(41300700001)(70206006)(40480700001)(82740400003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 22:59:28.4123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88faef2f-178c-400a-e871-08db31726a7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
Subject: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio extended capability

PCI device configuration space for capabilities is limited to only 192
bytes shared by many PCI capabilities of generic PCI device and virtio
specific.

Hence, introduce virtio extended capability that uses PCI Express
extended capability.
Subsequent patch uses this virtio extended capability.

Co-developed-by: Satananda Burla <sburla@marvell.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-pci.tex | 69 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 665448e..aeda4a1 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -174,7 +174,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
 the function, or accessed via the special VIRTIO_PCI_CAP_PCI_CFG field in the PCI configuration space.
 
 The location of each structure is specified using a vendor-specific PCI capability located
-on the capability list in PCI configuration space of the device.
+on the capability list in PCI configuration space of the device
+unless stated otherwise.
 This virtio structure capability uses little-endian format; all fields are
 read-only for the driver unless stated otherwise:
 
@@ -301,6 +302,72 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
 fields provide the most significant 32 bits of a total 64 bit offset and
 length within the BAR specified by \field{cap.bar}.
 
+Virtio extended PCI Express capability structure defines
+the location of certain virtio device configuration related
+structures using PCI Express extended capability. Virtio
+extended PCI Express capability structure uses PCI Express
+vendor specific extended capability (VSEC). It has a below
+layout:
+
+\begin{lstlisting}
+struct pcie_ext_cap {
+        le16 cap_vendor_id; /* Generic PCI field: 0xB */
+        le16 cap_version : 2; /* Generic PCI field: 0 */
+        le16 next_cap_offset : 14; /* Generic PCI field: next cap or 0 */
+};
+
+struct virtio_pcie_ext_cap {
+        struct pcie_ext_cap pcie_ecap;
+        u8 cfg_type; /* Identifies the structure. */
+        u8 bar; /* Index of the BAR where its located */
+        u8 id; /* Multiple capabilities of the same type */
+        u8 zero_padding[1];
+        le64 offset; /* Offset with the bar */
+        le64 length; /* Length of the structure, in bytes. */
+        u8 data[]; /* Optional variable length data */
+};
+\end{lstlisting}
+
+This structure contains optional data, depending on
+\field{cfg_type}. The fields are interpreted as follows:
+
+\begin{description}
+\item[\field{cap_vendor_id}]
+         0x0B; identifies a vendor-specific extended capability.
+
+\item[\field{cap_version}]
+         contains a value of 0.
+
+\item[\field{next_cap_offset}]
+        Offset to the next capability.
+
+\item[\field{cfg_type}]
+        follows the same definition as \field{cfg_type}
+        from the \field{struct virtio_pci_cap}.
+
+\item[\field{bar}]
+        follows the same  same definition as  \field{bar}
+        from the \field{struct virtio_pci_cap}.
+
+\item[\field{id}]
+        follows the same  same definition as  \field{id}
+        from the \field{struct virtio_pci_cap}.
+
+\item[\field{offset}]
+        indicates where the structure begins relative to the
+        base address associated with the BAR. The alignment
+        requirements of offset are indicated in each
+        structure-specific section that uses
+        \field{struct virtio_pcie_ext_cap}.
+
+\item[\field{length}]
+        indicates the length of the structure indicated by this
+        capability.
+
+\item[\field{data}]
+        optional data of this capability.
+\end{description}
+
 \drivernormative{\subsubsection}{Virtio Structure PCI Capabilities}{Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}
 
 The driver MUST ignore any vendor-specific capability structure which has
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

