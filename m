Return-Path: <virtio-dev-return-11866-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24131C7619A
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 07730603EC
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2F35F98689B
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CC7C39865DF; Thu, 30 Mar 2023 22:59:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 87F8C98657F;
	Thu, 30 Mar 2023 22:59:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyFo48aHIpzaxWgaBFItoBTbEDClOGie8/LljUmDGmsIoDlkPekuneAk7pVOXcM/s+s9TlgPAhgnvyjhfJSl3NEkk6Qczi4PlTRp90TN+TE7MGXEUs40tVyf0lYv+uO+XeL5aer65T/aFIiFl+nn2RHnE5FUR70nxgdTHZ14vJ9wkEJnoiOCbg1vpRAvEGn1tb5yBXQwnJdwgqfRENp+Xf+H+cTmuRxSoRvgWeRZVsLmezwiqLOJ6VAH0CmFw5kzRweTAulMCbQtPbyrutKUcJNasLxJzA9IE49LsOkmPRonvQZRuS6SLvppkb4GTpet74hzHuJzpEsZR/TPohSg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iax1Tj8Wg4J7CfqJdQt7tn1Hghk9RAubz9ID7QJ145k=;
 b=aweMmQoVQGd/LcHIg/4QvQ+4WRAQ0G5CY6RoEsSHwBhTzstyUNW03LhXQVhDuhlZPemFUCB99Pvxclw5Ony6Qs8QWc5R2561MeftxEHtmer5Rg5QeKIPV97yGCl3mn7LimIUhAJ8qX0AgpFbalNMIIe7/YbWcAA82OaDvn4LGYn8r6h8a49lmA9euD2c5U8PZviHGdEJpyvwx5SsNMjR59SZ8RcrTBteFVZWsRrW8672srw/OsaTZFceVOJqQwwzhmtAAsH/Hvi/oJBsvrHI1bt9gxeQToxnNoepiCpV1YM0BpgCU9ADwJXThATGuliGwG5hu+TwCOwOPcdOAO+qkg==
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
Date: Fri, 31 Mar 2023 01:58:25 +0300
Message-ID: <20230330225834.506969-3-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed32155-421d-4a34-e943-08db31726881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SttUNO000uYK1eVY6BYfNT3DwDu8yHwIXzEmg3vBwBE5KTjP1Lh8ibTWQPy3h+0ibvgd5e6SuUIc/jtilcfivf4Gx8Q5nJ99w3PiZCkhd2jJPArfARk0+KyM9Vy/yifJjAu4kZab4Y5uQLYl0CNYpvdpReLM89buv0ejXXyFyscztpAmW18Zg2FxMDJWExuLAzDd9Cc/XH/s1un3UjNzKFbTWsFWhVGhW67zDiZBpIGwuynnVoGvbDXD9ur0yzJ9xvAwxIakAw9abLI0o3AtdWNVOM+4dHZjcp924bVQuKFnMUeNlAWiasRlp7tljrRh4cyIEsF/d+Ec1LISkw4VdBzK4zQvDNIvJ5V9ezjS1uDP8ED1rzYT4Z1kubHDR4ntZKY3qfVctkmxdcDIuJbkIzYHnXU1sKlizIAyfHSAzkFGoy1tu9uY25ij06r3v2wyPH2DSeikLlETtPukRNdvj0JjL5eX32FFTQF8QdXQomeyK7HgTFE6Io5GwO6tfQd4Seka2mywN/dA0ZSQHelvpb2QRCCbdxRGtPmIjr+7gsdyG19hRQX/O1wgOcFn7jbSD9P/85Ai4PuIQOxr0ZRncwuFJesJuYu2tYRaVNqkkcESzw0PAC81jle/oyLq84OGtzrwXpY82nwzu+qblVn8vIGckIlwcL03hytDpwZitU/B3cL49E0fW+OCyFM9DF8o88Ew9oV7WoRtYItXeAPUaxx9KqHH+Y9L0KKpw1Cv3C9FVVAkzB7W2dnhXpr0W+K/9LrgBD3Mr7Zfmp5ckNTR1w06jbJdAcjLhHdRzLztnYo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(7636003)(82740400003)(36860700001)(40480700001)(4326008)(40460700003)(426003)(34020700004)(356005)(36756003)(86362001)(47076005)(83380400001)(336012)(70586007)(70206006)(2616005)(2906002)(8676002)(16526019)(6666004)(316002)(1076003)(110136005)(54906003)(186003)(5660300002)(41300700001)(478600001)(8936002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 22:59:25.0871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed32155-421d-4a34-e943-08db31726881
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979
Subject: [virtio-dev] [PATCH 02/11] transport-pci: Move transitional device id to legacy section

Currently PCI device discovery details for the transitional device
are documented in two different sections.

For example, PCI device and vendor ID registers are documented in
'Device Requirements: PCI Device Discovery' section, while PCI
revision id is documented in 'Legacy Interfaces: A Note on PCI
Device Discovery' section.

Transitional devices requirements should be documented in "legacy
interfaces" section as clearly mentioned in
'Legacy Interface: A Note on Feature Bits'.

Hence,
1. Move transitional device requirements to its designated Legacy
   interface section
2. Describe regular device requirements without quoting it as "non
   transitional device"

While at it, write the description using a singular object definition.

Reviewed-by: Satananda Burla <sburla@marvell.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-pci.tex | 70 ++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 7f27107..1f74c6f 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -28,46 +28,24 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
 
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
 the range 0x1000 to 0x103f.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

