Return-Path: <virtio-dev-return-11285-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9840C7EE2D
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:30:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 553B2676F0
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:30:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EE0059867F0
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:30:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CE2C39867ED; Sat, 25 Feb 2023 22:30:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A9F8B986784;
	Sat, 25 Feb 2023 22:30:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEctgXPiVLrR1GUbpokHHx2R4ca3hZRPt0CB49Hfk57DJFEwhHxnjmgHKvzarpzi4ih9gvU+oqRHfKy/RSblR7VcOBTrzNGeWxtp3RwXt5Sxitl4mAVoDuXcwBKgyhbj5eXpsfwosTyThYvftepwcT24vbAGUD9u++07Ky0cof29EzVF93kymYSzX89BDX4Bz+/YSjnE4G6pD+YBxMiOHGrX+ssHS6oup6OJ2PzM+CHClRbDm6UbuEsg6+Q0t7nnpkRvvv+2Fpj3MGztx8D/y5+LIUj2gRRbAGCsYflmx5e7aVz9o+n5eSunP4MbYdxz5FN0vYYhnfEHrfYqmpOD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tNYFm8XOE+0AZ/51LHPtOtGGGBNqX+jRk5+HEzsmUA=;
 b=YO7FWzV7l4VwwFqvyVHkbQwB0DpzrL1wYDTYWrpUL33IDlT44WrPeqfB/QA9zpWShfEXXm6VwPzFTWW/H5Ts3Ggy/dPhVwtwJDtn9blJ8nDcewNS+GL0Piy5alxpJx2Bl60uFL/dWgvPqn4pjIESbe5gs8GMVlJlv92fOYPa92DhcLmgFAcCoJwKSBrAsnkActbXwQuGJjov2XM6OjDh607hGYhRDrhDdonkU0adZEI5l+XhvxGViQN7G/GLEFc1GDZtm/CsCP4NeulhVDYUdEsiKXD2ocrWMXMBFiXewA/wJvXsZZkzPwcsnTWyGYQw30KvtEVU1hJ25Wh39wu13Q==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Sun, 26 Feb 2023 00:30:00 +0200
Message-ID: <20230225223001.430522-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230225223001.430522-1-parav@nvidia.com>
References: <20230225223001.430522-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96A:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: c11fdb33-aa82-47f1-6424-08db177fe719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o2Z5bDQrPVz04HIQ5eFo2nhsspetUZ6unXjQF3vk/sARehdgNl3NKW+cizyFK2lcXeh3GYn4BD0BbQvQX3pxIXpvEMPJ3fE0EP3P0Jbz/k1NaLhBSGVJcAc500LE4yICHy7Uc+anbRkC00lkISKD8m6oEsMoB1czJBUyKEiBbcCaegOJox5UdVWfwo2wJOur2m+7XFtA/+Q4IM90RZG+rjnw97zWwtRZfxp60qllEXAURp3ppI4oGMAj9FOsspdYnnOTsN5DTjTrG0i/bjHWDR6+FBU5DhrlduVaRXcebE8MGeYH4phq5E1RzcbuigqkSuujLmY+KBdiK/eXPPvMPTNJzyDs8AIwPaStW3RQWF5aUM8H9D+jDxUiLbeA41bV5n2l4WttRG1UZK4apQ/3935CcNBsk0lOxcnMF5fxwMlsXAzr0NulRywvyFmV4gYhmuyE0lU8Yr2I01YqgvTTNXAYDctz0FrIwmxAu7oVIaC0OaJ6GE7c0vKIV7C072Nqqkdr3ub6NsHYnBROUKK4UGACHJKvMM7kCKoJzJSQNw58VAZEjHkHvomBBfo0UWApwe/rC55iNIDa2W3TJ2/zBiul3xDDiiFDOQ100APnSOIXEZJajq5gOJEp/FXG7rs0n7c4rWtf6/vbiXAHMNTmz3XRUAFJlRTIVDZq4kd6meu7I1nzCzivdUx4znPiW74xogdZYr+C/PLeylWVJqXOHPGY+W/fJnwHTQ84r1XjpidK+Ag2ZkkTOtjzs9rIAHxj
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199018)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(8676002)(26005)(186003)(16526019)(6666004)(478600001)(1076003)(426003)(336012)(2616005)(47076005)(107886003)(4326008)(316002)(70206006)(70586007)(966005)(54906003)(110136005)(7636003)(86362001)(82740400003)(356005)(83380400001)(36860700001)(2906002)(36756003)(41300700001)(5660300002)(82310400005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 22:30:30.6980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c11fdb33-aa82-47f1-6424-08db177fe719
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C96A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972
Subject: [virtio-dev] [PATCH 2/3] transport-pci: Split notes of PCI Device Layout
Message-ID: <20230225223000.sn-9SRLVmBup81S-rgZRKvoPxXncYrcc4d5V2ZoMyKU@z>

Currently single legacy interface section describes PCI common
configuration layout and feature bits operation for the
legacy interface.
Secondly common configuration structure description of legacy interface
is not adjacent to the the respective normal device requirements for
same.

Hence, split PCI Device Layout legacy interface section into two
parts. First subsection for common configuration and second
subsection for feature bits.

Subsequent patch relocates common configuration legacy interface to
appropriate matching location.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/164
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 conformance.tex   |  4 +++-
 transport-pci.tex | 19 ++++++++++++-------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index 01ccd69..0d3616f 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -262,7 +262,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Message Framing / Legacy Interface: Message Framing}
 \item Section \ref{sec:General Initialization And Device Operation / Device Initialization / Legacy Interface: Device Initialization}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery / Legacy Interfaces: A Note on PCI Device Discovery}
-\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
+\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus/ Virtio Structure PCI Capabilities / Legacy Interfaces: A Note on Common
+configuration Layout}
+\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Legacy Interface: A Note on feature bits}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtio Device Configuration Layout Detection / Legacy Interface: A Note on Device Layout Detection}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtqueue Configuration / Legacy Interface: A Note on Virtqueue Configuration}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}
diff --git a/transport-pci.tex b/transport-pci.tex
index 9ee37ba..9d4c713 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -767,7 +767,10 @@ \subsubsection{PCI configuration access capability}\label{sec:Virtio Transport O
 specified by some other Virtio Structure PCI Capability
 of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
 
-\subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
+\subsubsection{Legacy Interfaces: A Note on Common configuration
+Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus
+/ Virtio Structure PCI Capabilities / Legacy Interfaces: A Note on Common
+configuration Layout}
 
 The transitional device MUST present part of the configuration
 registers in a legacy configuration structure in BAR0 in the
@@ -852,13 +855,15 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio
 is encoded in the native endian of the guest (where such
 distinction is applicable).
 
-When accessing the device-specific configuration structure
-using the legacy interface, transitional drivers MUST access
-the device-specific configuration structure
-at an offset immediately following the legacy common
-configuration structure.
+The transitional driver when using the legacy interface MUST
+the device-specific configuration structure at an offset
+immediately following the legacy common configuration structure.
 
-Note that only Feature Bits 0 to 31 are accessible through the
+\subsubsection{Legacy Interface: A Note on feature
+bits}\label{sec:Virtio Transport Options / Virtio Over PCI Bus /
+Virtio Structure PCI Capabilities / Legacy Interface: A Note on feature bits}
+
+Only Feature Bits 0 to 31 are accessible through the
 Legacy Interface. When used through the Legacy Interface,
 the transitional device MUST assume that Feature Bits 32 to 63
 are not acknowledged by the driver.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

