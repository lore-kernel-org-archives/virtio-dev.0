Return-Path: <virtio-dev-return-11273-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1942C64ED8
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 23:13:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 65CB87604C
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 23:13:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5577298679F
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 23:13:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4A51D9866A9; Fri, 24 Feb 2023 23:13:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 188A89867D6;
	Fri, 24 Feb 2023 23:13:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3Apf2zQnjtG33iFloZUcAd7FDXXiRLsCk8smgoySqrCO3rMRy6IkmRQ/n+XLLzuY495AR/XjfoITUiuGH1ToBouhoSKkIOOrtc2a6jzKedFDWtV4nVAo08HHxa4Gic/BQep8dT05Ow6BJKF4OqKVtNYDzbgEpc2iOciBDvEqESCsS5YrHFNsT+U7rx6FW7SDlsro7VHlM3Rw07M+nRRo6uIirQ2QVkHCHlOYgpgGsJhRLBgU/pnGVDYTlHfevU/BS0Xa9Cs/x4a0z6oUNkDLDEcnrhdmR70Mw8pHBpZpp+Hp3UvOa8RCm6dSUhJMwImFyQX3yIEILRucBSATqFAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tODpBVpZhxGivuYahq6qj8Hn77unJV1pD/EB5PWpb84=;
 b=GGz805djZh/u3RqH22suGOhIQo2AtWo6OBALTgrIOxVJeSA4R57KnGQ7/MJrLJHqVZA9yQRqtekok7zLom28LgotI5nzFfZJkmMBuepOFNi50q/PWWt7iIngvuBGBemlo8p5ZjP8Kqe2KYnP0jjIDhMMxe3dmKsX6QWmIzcJulKqD/GmFRorYe4JhpExQ/m4bkd8zqHWG2+xdYkXP1Pmo5lQxYNLQ4iM+bxpssBEcyljD5Kr52cq0ojEroUlJir/3v4vO96s/r05eD2kzZAclOa0Te0rtVWzARAS2yBc6OBGgOUW2myS0caEA8hQrmShNc8+9LLI6AEcjz4VW9xg0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Sat, 25 Feb 2023 01:12:32 +0200
Message-ID: <20230224231232.340814-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230224231232.340814-1-parav@nvidia.com>
References: <20230224231232.340814-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 drhqmail201.nvidia.com (10.126.190.180)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96B:EE_|PH7PR12MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c84610-aeff-4abe-2933-08db16bcac73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LLIMYw37yB6KuCxG1A/GfNj8VMBy1rAoQRnp0AXRF3AKxV7JsjWx0STYd4XT1JVR7iXbhwChQfPZgrkO5Jn/ykkQuOX2m0gDvosVvZhycr6Xhjp4zAu6zvRsT7qMe0z198sLqsRom74LyZpr+trlxXgPFlW1kq6I/ghQ8ULwbxM+KUi19z1dpL37ai8+bkFZzGej5vY9HpqkZb1cL1RK544aUls6EoR3CRJpaQ+ruYonUER9cIMUZbUsJ6Ho4Wcb+4M8eF2Th2jLFJlfl92rCskJ7GpG9JWHOSkY8A2hqjKuI764EVjpWft2+4mHJHoePmgTgauKnfNStI02HnY4KdqNWUMXhRa1Qnv8mzuLNnit0Scm8QMxE62XZYSclkAmWLv+A35rozdlkdfMEZHh/HCIj0iMBO5AMaMqVR2M6u+M37YcyWs+fu5+mtec+iRpNxzZHEZmbtabeBC3ztFUVSUYJVnLLD+8JqT5FpIBZRcucrFXS+1u0h6a88Vs4miiJ/ioMxR5geh5h/TQQyq36qnrDgf3TdmilMLI+bVKsgAAy5WMNOgBjKRSyz/tfLI19vQn5z+NzKhdch79JXg2aK1DUHJU7ggssUoRk/lXi6gOspyOjI1D7ESH7iosr4XtWV5bWi+8TBCb75MApW38ikA/YGiyeMzlKz5J8Hl0HxZrhCSSwzCq8q3tx+NzN+fRpEafiNeXFkQVhmZ1RrTaAe5bwMqUTm/iNqY2pPT+eTG1H7QaHQyUB6mhXnOIiDV+
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(40460700003)(16526019)(6666004)(7636003)(82740400003)(2906002)(83380400001)(356005)(8936002)(41300700001)(8676002)(70586007)(36860700001)(70206006)(336012)(1076003)(40480700001)(4326008)(36756003)(5660300002)(186003)(478600001)(426003)(107886003)(26005)(47076005)(966005)(82310400005)(86362001)(316002)(110136005)(54906003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 23:13:00.4854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c84610-aeff-4abe-2933-08db16bcac73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C96B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6835
Subject: [virtio-dev] [PATCH 2/2] transport-pci: Move transitional device id to legacy section
Message-ID: <20230224231232.SAIjqg7Gl_QbcMrcDa_iauqrXFKh9G0vrcVRoXgLVY4@z>

Currently PCI device requirements section contains mix of normative
statements for for regular (non transitional) device and
transitional device under one section.

Some requirements of the transitional device are also located in
legacy interface section which is the right section for it.

Hence,
1. Move transitional device requirements to their designated Legacy
   interface section
2. Describe regular device requirements without quoting it as "non
   transitional device"

While at it, write the description using a singular object definition.

This is only an editorial change.

This patch is on top of [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00578.html

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-pci.tex | 70 ++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index e271d51..9686cc8 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -28,46 +28,24 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
 
 \devicenormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
 
-Devices MUST have the PCI Vendor ID 0x1AF4.
-Devices MUST either have the PCI Device ID calculated by adding 0x1040
+The device MUST have the PCI Vendor ID 0x1AF4.
+The device MUST calculate PCI Device ID by adding 0x1040
 to the Virtio Device ID, as indicated in section \ref{sec:Device
-Types} or have the Transitional PCI Device ID depending on the device type,
-as follows:
-
-\begin{tabular}{|l|c|}
-\hline
-Transitional PCI Device ID  &  Virtio Device    \\
-\hline \hline
-0x1000      &   network device     \\
-\hline
-0x1001     &   block device     \\
-\hline
-0x1002     & memory ballooning (traditional)  \\
-\hline
-0x1003     &      console       \\
-\hline
-0x1004     &     SCSI host      \\
-\hline
-0x1005     &  entropy source    \\
-\hline
-0x1009     &   9P transport     \\
-\hline
-\end{tabular}
+Types}
 
 For example, the network device with the Virtio Device ID 1
-has the PCI Device ID 0x1041 or the Transitional PCI Device ID 0x1000.
-
-The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect
-the PCI Vendor and Device ID of the environment (for informational purposes by the driver).
+has the PCI Device ID 0x1041.
 
-Non-transitional devices SHOULD have a PCI Device ID in the range
-0x1040 to 0x107F.
-Non-transitional devices SHOULD have a PCI Revision ID of 1 or higher.
-Non-transitional devices SHOULD have a PCI Subsystem Device ID of 0x40 or higher.
+The device SHOULD have a PCI Device ID in the range 0x1040 to 0x107F.
+The device SHOULD have a PCI Revision ID of 1 or higher.
+The device SHOULD have a PCI Subsystem Device ID of 0x40 or higher.
 
 This is to reduce the chance of a legacy driver attempting
 to drive the device.
 
+The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect
+the PCI Vendor and Device ID of the environment (for informational purposes by the driver).
+
 \drivernormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
 Drivers MUST match devices with the PCI Vendor ID 0x1AF4 and
 the PCI Device ID in the range 0x1040 to 0x107F,
@@ -85,8 +63,32 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
 PCI Subsystem Device ID value.
 
 \subsubsection{Legacy Interfaces: A Note on PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery / Legacy Interfaces: A Note on PCI Device Discovery}
-Transitional devices MUST have a PCI Revision ID of 0.
-Transitional devices MUST have the PCI Subsystem Device ID
+
+The transitional device has one of the following PCI Device ID
+depending on the device type:
+
+\begin{tabular}{|l|c|}
+\hline
+Transitional PCI Device ID  &  Virtio Device    \\
+\hline \hline
+0x1000      &   network device     \\
+\hline
+0x1001     &   block device     \\
+\hline
+0x1002     & memory ballooning (traditional)  \\
+\hline
+0x1003     &      console       \\
+\hline
+0x1004     &     SCSI host      \\
+\hline
+0x1005     &  entropy source    \\
+\hline
+0x1009     &   9P transport     \\
+\hline
+\end{tabular}
+
+The transitional device MUST have a PCI Revision ID of 0.
+The transitional device MUST have the PCI Subsystem Device ID
 matching the Virtio Device ID, as indicated in section \ref{sec:Device Types}.
 Transitional devices MUST have the Transitional PCI Device ID in
 the range 0x1000 to 0x103F.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

