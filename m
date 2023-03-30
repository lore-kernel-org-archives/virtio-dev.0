Return-Path: <virtio-dev-return-11871-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDB0C7619A
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 23:00:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1B0BF60276
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 23:00:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1417D986585
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 23:00:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 08DA5986569; Thu, 30 Mar 2023 23:00:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E738298655C;
	Thu, 30 Mar 2023 23:00:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4MwxZBmoM4Yh5d2FjL0pPKwSJX6vmZfJ6143pxrAwN3/oLVo+qMXzYtXrdX9Sih2l+7Unr5mM+Lu1j53/CMRmGhn2CKGtasmczJ6+erv9FpTJyvW/D5d7pUkizckkwncZZuoLtJZOSQtXWcOmNg2ckQp6sgFi7litX0oT5PUU1P4mx2nOF6qdX/uGTciBDmlsyQIWSFEsSKnH+EjWO5dMr2bCniwgeEQxcjDZ3u6iZFTlRPJQffeWQvRJSiSLhhUPXA5pg6xcUcHdyQuQ+ekxLMvtBK5LCu+wV3mJJfiTvYVkJxkfSoQa6eKTkcMxk0MR7oHDfK6p6jmobPGYg6qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Va6trDQd5nurv28mFgtbTFXm5DbZk1sqr3JOtsYxJLA=;
 b=Qjca7imvsEZx+G2kDunIjNMa1V5OYlAjjVf3+NNxbBPOYcOnkxd0CeGSRjj6Jz9i9OPyJqwS6cPFtIvQOnH/uQQbKpnANK9xwc3d1RebSREuMg91DXSSw7uZHRcbW9JLeUJF4/icSasIQSk0lCApy7y2Y+Xqh1s9dEGC5dpQrB7n0j2ChJHNuodOz3oRk3jecmT8Pa90NVfjyfk5ybc4Mb9dGIt+LHsiI19lheToV2USbvlRFPEkicNlWZyGkw4EO6aQN9UdS6KV/O+gyQpLMZcQj8aO7dCv59ojXn/pOR0MR/6svShMzA0oaj+nevuSxR+turfOYZyrm2rOFHGY8w==
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
	<parav@nvidia.com>, Satananda Burla <sburla@marvell.com>
Date: Fri, 31 Mar 2023 01:58:29 +0300
Message-ID: <20230330225834.506969-7-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230330225834.506969-1-parav@nvidia.com>
References: <20230330225834.506969-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT086:EE_|CH3PR12MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: d248972c-f149-45e2-d462-08db31726be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uomXUXJ97cgPNFMrI+1Fv+/nMZYpKccpFjZXeivIJc2CALYqeMV1VDT1NbcE1cRstsC1HZVxYEXkuM/vifqx+KaZ206EUt8ZG+M8Ky/IxIXQJ3bbCJSiTgf++jJpWtD4IAdd5w3uj0xYRbFOUthefo/Z1k+N/LIUe61RJNk9Gu18FWjARBbZT7vZu2NdeUVXAdZTOfQE9Zt/gy8luHpd8uWZcs98faVwldCUkEuIeZB3i9fsSuuGGcd+N7gPgmOlirFsb2VWZNkagayo8DG5s4wNe/YQZfPBbfEsj5zcI2NRF9giwM5NxpSAuF4ETJ3E3hnjaRtiGzQlKa7SqI7mMxiRdKH/Ocd7rfE2StvwYDS5HaI9JY6gMB//7QWU34uT1CiRbmYtveEqsjGhmiwzddyXuHyjToPq7rrzRy9OrmHDZvibDlQNOsQPMMF0jF6MKAu6+hfW/aCgEiANSJFePUmDwgRFN6jr78xb/k1LqHczAPBkthBFmXEfSXmgCZd4SiAvpWk7Wo9/1v3hLhlk/gXtiiwYLxjty3qJWL2jdqufWHhJJLMbO8pDX0iD0CY8+psTkwmOnkoEixOMvIbFPqDJ4T6ex0a1rZuap4z30S9v2UPM51rgc9OGf29kN8wYAe1BYkfNe1JjYb5RXfoVr0pH6c9oWlOPVuUn5dSc1w6K1vlvokDyJPjgMAlOJmcjluOY0YeT4+qzoqrDhwPMx3vBWmZxAqjJUBz2EzPibIM62Hmtj49Gy7vjMPV6/ISMr73hFajbelAXFnKBrJW1c1TqjihZCP+i3d0o8lSwkp4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(7636003)(83380400001)(356005)(82740400003)(426003)(2906002)(47076005)(336012)(2616005)(82310400005)(16526019)(86362001)(186003)(34020700004)(40480700001)(1076003)(36860700001)(8936002)(26005)(478600001)(316002)(54906003)(6666004)(70586007)(5660300002)(110136005)(41300700001)(4326008)(36756003)(70206006)(40460700003)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 22:59:30.8013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d248972c-f149-45e2-d462-08db31726be9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8073
Subject: [virtio-dev] [PATCH 06/11] introduction: Introduce transitional MMR interface

Introduce terminology for the transitional MMR device and transitional
MMR driver.

Add description of the transitional MMR device. It is a PCI
device that implements legacy virtio common configuration registers
followed by legacy device specific registers in a memory region at
an offset.

This enables hypervisor such as vfio driver to emulate
I/O region towards the guest at BAR0. By doing so VFIO driver can
translate read/write accesses on I/O region from the guest
to the device memory region.

High level comparison of 1.x, transitional & transitional MMR
sriov vf device:

+------------------+ +--------------------+ +--------------------+
|virtio 1.x        | |Transitional        | |Transitional        |
|SRIOV VF          | |SRIOV VF            | |MMR SRIOV VF        |
|                  | |                    | |                    |
++---------------+ | ++---------------+   | ++---------------+   |
||dev_id =       | | ||dev_id =       |   | ||dev_id =       |   |
||{0x1040-0x106C}| | ||{0x1000-0x103f}|   | ||{0x10f9-0x10ff}|   |
|+---------------+ | |+---------------+   | |+---------------+   |
|                  | |                    | |                    |
|+------------+    | |+------------+      | |+-----------------+ |
||Memory BAR  |    | ||Memory BAR  |      | ||Memory BAR       | |
|+------------+    | |+------------+      | ||                 | |
|                  | |                    | || +--------------+| |
|                  | |+-----------------+ | || |legacy virtio || |
|                  | ||IOBAR impossible | | || |+ dev cfg     || |
|                  | |+-----------------+ | || |registers     || |
|                  | |                    | || +--------------+| |
|                  | |                    | |+-----------------+ |
+------------------+ +--------------------+ +--------------------+

Motivation and background:
PCIe and system limitations:
1. PCIe VFs do not support IOBAR cited at [1].

Perhaps the PCIe spec could be extended, however it would be only
useful for virtio transitional devices. Even if such an extension
is present, there are other system limitations described below in (2)
and (3).

2. cpu io port space limit and fragmentation
x86_64 is limited to only 64K worth of IO port space at [2],
which is shared with many other onboard system peripherals which
are behind PCIe bridge; such I/O region also needs to be aligned
to 4KB at PCIe bridge level cited at [3]. This can lead to a I/O space
fragmentation. Due to this fragmentation and alignment need,
actual usable range is small.

3. IO space access of PCI device is done through non-posted message
 which requires higher completion time in the PCIe fabric for
round trip travel.

[1] PCIe spec citation:
VFs do not support I/O Space and thus VF BARs shall not indicate I/O Space.

[2] cpu arch citiation:
Intel 64 and IA-32 Architectures Software Developer’s Manual
The processor’s I/O address space is separate and distinct from
the physical-memory address space. The I/O address space consists
of 64K individually addressable 8-bit I/O ports, numbered 0 through FFFFH.

[3] PCIe spec citation:
If a bridge implements an I/O address range,...I/O address range
will be aligned to a 4 KB boundary.

Co-developed-by: Satananda Burla <sburla@marvell.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 introduction.tex | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/introduction.tex b/introduction.tex
index e8b34e3..9a0f96a 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -161,6 +161,20 @@ \subsection{Legacy Interface: Terminology}\label{intro:Legacy
   have a need for backwards compatibility!
 \end{note}
 
+\begin{description}
+\item[Transitional MMR Device]
+       is a PCI device which exposes legacy virtio configuration
+       registers followed by legacy device configuration registers as
+       memory mapped registers (MMR) at an offset in a memory region
+       BAR, has no I/O region BAR, having its own PCI Device ID range,
+       and follows the rest of the functionalities of the transitional device.
+\end{description}
+
+\begin{description}
+\item[Transitional MMR Driver]
+       is a PCI device driver that supports the Transitional MMR device.
+\end{description}
+
 Devices or drivers with no legacy compatibility are referred to as
 non-transitional devices and drivers, respectively.
 
@@ -174,6 +188,22 @@ \subsection{Transition from earlier specification drafts}\label{sec:Transition f
 sections tagged "Legacy Interface" in the section title.
 These highlight the changes made since the earlier drafts.
 
+\subsection{Transitional MMR interface: specification drafts}\label{sec:Transitional MMR interface: specification drafts}
+
+The transitional MMR device and driver differs from the
+transitional device and driver respectively in few areas. Such
+differences are contained in sections named
+'Transitional MMR interface', like this one. When no differences
+are mentioned explicitly, the transitional MMR device and driver
+follow exactly the same functionalities as that of the
+transitional device and driver respectively.
+
+\begin{note}
+Transitional MMR interface is only required to support backward
+compatibility. It should not be implemented unless there is a need
+for the backward compatibility.
+\end{note}
+
 \section{Structure Specifications}\label{sec:Structure Specifications}
 
 Many device and driver in-memory structure layouts are documented using
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

