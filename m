Return-Path: <virtio-dev-return-11826-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C698C76196
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 20:18:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3463F7A054
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 20:18:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 29251986533
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 20:18:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1CFDB9864D1; Tue, 28 Mar 2023 20:18:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0862E9863C4;
	Tue, 28 Mar 2023 20:18:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIS9Xwlz1aJW79RCn9RezlLL9Z2HL+0nvsfCjsPaDge6QjWYuS6TSTDcw4D4sO1BtB1Vd4N1w/07e/Fc54edOT23wkD3+Sgs6KJD6rGPONpoEbQory/0Gn2BDOzmsc66bxf3SBlBBXyzABxY/YJ6NTyK/yS0Z8RQYMh3ZrCZHfnlkXsuaXw7qX+CtteCew4pW1hSMhRnYR9WaO0qi2MGzm+zu4uIJPdx6sWkl58pjfSwzNSNDXjoXnw7C2uDX9q01Fq0J3zK/ck5E9eBjrbKkvUGSBRxc9WKZZJ9qm9JQcJ/U6nvMJ4CGgCkrw7zEVHxptFjuwFsM6lgUUjCC7XUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIOnMpHrp78ckFj91nknkysgVqT93tDWcGS96VAdzQM=;
 b=EXLkkIeUGZfxWnziWNfmhVch+q0GcnZ103pAXVaf7zO1mRjXnWtpXBGorDRRT2Z/vP0q03Nl2LSImrwJtR2hC8cXVNtdfHYFxbLu1uoCJ4/GfVTdBYS28rFmabg2GTC2EsuZHXqnOg9mBGC0/eoMvy/mpw/3+yTmXxl1vBYBMuLo4KglyjBi7E/6lHaRf55dMsjZtXZnFjt7+k3jJaDzP9z7MxSCA2i7ETDjOMz3ACgPLtkGFnKbCpHJ5Fhlj4K6vxT8UjCE5QB7O2a34IbDpEJnox8nv02XNZgTi1nAfO7Ej8wBmyauZTz5XOSAkTCZBBwLvmICpt2j+oLykGOq5A==
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
CC: <sgarzare@redhat.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Tue, 28 Mar 2023 23:17:51 +0300
Message-ID: <20230328201754.440974-6-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230328201754.440974-1-parav@nvidia.com>
References: <20230328201754.440974-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|SJ2PR12MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f427d4-6100-47e4-a9ed-08db2fc9967e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1YpmJC3fkUgpvgbtSSZnFEird9hycpulDGOBdG7EUnFI/d9RGYu+2JJKk+o6dW5I1RPLH+joNRtJ4/kyJzpo3h8+3rZOZL6IGKwn47nYqdKfAQPVYI70SP5LH74Pzbvc7k+GVQQayhd3Gg9CdDywOYmgoc4/ZsqsYLHHAprFNPM3WKSpXpkBgqWL7+2YMk7DsexXrJXx0z3PnyIjbvpd6WO3JagD2+txraSOav9CCo6C5+RRM1wgZDSvJsVs4ZXiuxxPY1n0WsVZacFI03x4DF2Yu7RPA8omJb4pgxGalsujNM2lDlsDDLPVEavWCXvhnZdKhSFIZQ7NYq9vYqweoicsY2LJPzLRHOMDQTejTVceX5qHddbPPV0IFbccYNX482gOqTy9jq3X4kCVCvE3F3D2ESqOTyHT44NtE7vgh60UVaZWJUAbOYni0T3IDHvGKmukmscnRQ1Jz+06/pb2fXQUUrQqElIQwVpOtESJP4VmxVE55/WejzL5EC1X84leuYqZawleK55l3NUhn/dRYdPyIc+qXkWCVnYmynsW0P4RFsQRXbIZaarKHqwC4M5PK66CHe9xQ2O8hhrMFPFT7XHyrbGx3t9EoQXsrMCsQY9FSLadsE7jy71lEj5dy5u9GWJ51SxHmCrWas+sPIT68c5cGgSbqxsf4MgJF128ISyvrlJC5TGBwGDJmExpU2E3wRCn9Dy3V/M1WsQF9KK3XBIAgRuKBwnkJFKBZVGuwD9pGXi2oK6TawPF0BSbA4TTqucVhX8B8fPxXfHd1ZaaMR9B+5jtL19evwPzxC4Aif8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(41300700001)(40460700003)(8676002)(4326008)(70586007)(16526019)(70206006)(186003)(2906002)(36756003)(426003)(336012)(83380400001)(47076005)(82310400005)(86362001)(5660300002)(7636003)(356005)(82740400003)(36860700001)(8936002)(6666004)(107886003)(478600001)(54906003)(966005)(2616005)(40480700001)(26005)(316002)(1076003)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 20:18:26.0528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f427d4-6100-47e4-a9ed-08db2fc9967e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8941
Subject: [virtio-dev] [PATCH v9 5/8] transport-ccw: Rename queue depth/size to other transports

max_num field reflects the maximum queue size/depth. Hence align name of
this field with similar field in PCI and MMIO transport to
max_queue_size.
Similarly rename 'num' to 'size'.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v8->v9:
- replaced 'named' as 'known'
v3->v4:
- moved note to comment
---
 transport-ccw.tex | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/transport-ccw.tex b/transport-ccw.tex
index c492cb9..488c46c 100644
--- a/transport-ccw.tex
+++ b/transport-ccw.tex
@@ -237,12 +237,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 \begin{lstlisting}
 struct vq_config_block {
         be16 index;
-        be16 max_num;
+        be16 max_queue_size; /* Previously known as max_num */
 };
 \end{lstlisting}
 
 The requested number of buffers for queue \field{index} is returned in
-\field{max_num}.
+\field{max_queue_size}.
 
 Afterwards, CCW_CMD_SET_VQ is issued by the driver to inform the
 device about the location used for its queue. The transmitted
@@ -253,7 +253,7 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
         be64 desc;
         be32 res0;
         be16 index;
-        be16 num;
+        be16 size; /* Previously known as num */
         be64 driver;
         be64 device;
 };
@@ -262,7 +262,8 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 \field{desc}, \field{driver} and \field{device} contain the guest
 addresses for the descriptor area,
 available area and used area for queue \field{index}, respectively. The actual
-virtqueue size (number of allocated buffers) is transmitted in \field{num}.
+virtqueue size (number of allocated buffers) is transmitted in
+\field{size}.
 
 \devicenormative{\paragraph}{Configuring a Virtqueue}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue}
 
@@ -278,11 +279,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
         be64 queue;
         be32 align;
         be16 index;
-        be16 num;
+        be16 size; /* Previously known as num */
 };
 \end{lstlisting}
 
-\field{queue} contains the guest address for queue \field{index}, \field{num} the number of buffers
+\field{queue} contains the guest address for queue \field{index},
+\field{size} the number of buffers
 and \field{align} the alignment. The queue layout follows \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}.
 
 \subsubsection{Communicating Status Information}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Communicating Status Information}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

