Return-Path: <virtio-dev-return-11282-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54978C64EC7
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:07:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E096D729B
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:06:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 50C5E9868D8
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:06:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1D89A9867C3; Sat, 25 Feb 2023 22:06:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3C5C8986788;
	Sat, 25 Feb 2023 22:06:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0JSGH8gdBvgrpwOA2zluObl5M6pfHz5P6TrGVSazi3OxlIupBsT8w/gVFjeGeiliky++fvAMGNDpcjRhE3/eFxe63hihdxPkLRENXgCHF9/Db7m+kzXWgJXMuJ1aDB8+Jue1RWEEs7Czusq+PE/nnzMcUDe8VEDLTe0/NPymqcvrKhiltxW3Y55KLy4TCrEuFQ7DFBEF0l+abwyMYlSlpUghboDXhFx8JqaM9joj9et9MDX8JoEPegZKjK3/hTUgTO+bGogzBIt5FN5B9/n5jwddVsIIHTYJ9l8LbwhL+ScZEiacH4+tjYLHKfhGMNCTvhZlYMwCuVchb9UDSwhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=br2AucgekOwVRVSI8UntzM80zJ92L2QDCjqEznMrJpo=;
 b=eamCJGzgSdEWX1LrQC+q95nyqyiF1v7jxWMflOag1DS/tHGeYirHF1ZgznmoMR30CLJcRT+CCdufpKfoqfVINn0h1XHtx5WhqGGHrhxnF86ZJqgF/f6ZdXMVyhHq189jZ3s6sAzYsZz9IWGBZjLKulKnSe+obRq+0qGeGLBXPBuTTDVIyrgzzhydaBJkiED+O/j16DHnHsznkzhLH9oExVxhGbJe12BZ+4AQU2v0xIlVkQjIvQNU2ShUOQ3AT4dbE7H4h4Wjw5MVWsruoavEPbWY3znwJ1Mr03GTLP3A+aBNCaaY9TcSBnaxIfBePSGJWkL/WHD67zeIhY0gnJ1uJA==
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
Date: Sun, 26 Feb 2023 00:06:36 +0200
Message-ID: <20230225220636.429990-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230225220636.429990-1-parav@nvidia.com>
References: <20230225220636.429990-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|BL1PR12MB5063:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce03a28-0cc7-45a2-97b1-08db177c99d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YzynVnlPc0Sko5p1ZFW7Ay6bYQMVxzrD0UANSZCiRVJQmrEQeJT3Afql1NrsAZWUG6XnVuC8iYCZCJO55S43OIzFX31aQRKTL3n13fUQ0zEfSQAoU0fNfzHBTpTqyl0hUEZ4BOxurQwHaysY4dl0c0XLWSbbyQdQKCCTstZ4kwOX4EFI7ouQVNTeVnAfWEhEneCwRy7c0ZSrl3rXX3TCJZcU1dNo0fqGqxikkIyMzLBt5ZlQbEzZ4QpodwI006XSo2XdSPWx0w7DFER0kqI6glVk6biiMbolI64dy386xIJIcK9/omLwZ21qoD4qxElLW0+ruCnjL26Rs8ruNU/5Fa3sC9j4NtSnbK8mplAmcdTLdWUngVenGzRW0SS9E/VBo3L2JChsX/AzGnYMDtWlnX4MUMm/Ec9P168UPtSXrE80bWgQuwfjgzYJKhG5nBVOevm9JVxU50yLDl7xZhFshNWU0G1287oTyCdMMw0K+aL4StlW0o1Q5wVjkBMiJAd06jPzDP9omQW2zaC4TzgtW8SZ0daTc41obDmhGxvyInY/a30NLb5naeIVZfAT8GDOqXtVVeK6FlNoZWpPmhM6/f8W21GQ+zsBydZ4gdhBDPmfwEjICx0CgGxqfTupWtp+dCoM5GrR/8hZYu59uHX9kCKZ+ILOQ7YTr8io+7V0RiMwEqOa86GPXCHa8ogIWqOlpBBpwGMmtPy628Ik9ERT0jVAtwz715oauhPp/mNMz3agvR65aI7SAcGm2lR9SIMdCPXz9eNTAI4hn9dsG+UeRg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199018)(36840700001)(40470700004)(46966006)(83380400001)(966005)(316002)(36756003)(82310400005)(86362001)(110136005)(54906003)(16526019)(40460700003)(2906002)(34020700004)(5660300002)(36860700001)(4326008)(8936002)(8676002)(70206006)(70586007)(41300700001)(1076003)(47076005)(478600001)(426003)(2616005)(26005)(107886003)(6666004)(186003)(40480700001)(336012)(7636003)(356005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 22:06:52.4903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce03a28-0cc7-45a2-97b1-08db177c99d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5063
Subject: [virtio-dev] [PATCH v1 2/2] transport-pci: Move transitional device id to legacy section
Message-ID: <20230225220636.PMBPMpTbsgcj5BF7bcUszK0h8D1CvmfGcAcZJJMclNA@z>

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
changelog:
v0->v1:
- rebased to lowercase device id notation
- added missing '.'
---
 transport-pci.tex | 74 ++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 9f9f076..5d22e6f 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -24,50 +24,28 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
 The PCI Device ID is calculated by adding 0x1040 to the Virtio Device ID,
 as indicated in section \ref{sec:Device Types}.
 Additionally, devices MAY utilize a Transitional PCI Device ID range,
-0x1000 to 0x103F depending on the device type.
+0x1000 to 0x103f depending on the device type.
 
 \devicenormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
 
-Devices MUST have the PCI Vendor ID 0x1af4.
-Devices MUST either have the PCI Device ID calculated by adding 0x1040
+The device MUST have the PCI Vendor ID 0x1af4.
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
+Types}.
 
 For example, the network device with the Virtio Device ID 1
-has the PCI Device ID 0x1041 or the Transitional PCI Device ID 0x1000.
-
-The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect
-the PCI Vendor and Device ID of the environment (for informational purposes by the driver).
+has the PCI Device ID 0x1041.
 
-Non-transitional devices SHOULD have a PCI Device ID in the range
-0x1040 to 0x107f.
-Non-transitional devices SHOULD have a PCI Revision ID of 1 or higher.
-Non-transitional devices SHOULD have a PCI Subsystem Device ID of 0x40 or higher.
+The device SHOULD have a PCI Device ID in the range 0x1040 to 0x107f.
+The device SHOULD have a PCI Revision ID of 1 or higher.
+The device SHOULD have a PCI Subsystem Device ID of 0x40 or higher.
 
 This is to reduce the chance of a legacy driver attempting
 to drive the device.
 
+The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect
+the PCI Vendor and Device ID of the environment (for informational purposes by the driver).
+
 \drivernormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
 Drivers MUST match devices with the PCI Vendor ID 0x1af4 and
 the PCI Device ID in the range 0x1040 to 0x107f,
@@ -85,11 +63,35 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
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
-the range 0x1000 to 0x103F.
+the range 0x1000 to 0x103f.
 
 This is to match legacy drivers.
 
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

