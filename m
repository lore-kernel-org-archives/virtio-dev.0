Return-Path: <virtio-dev-return-11842-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C048EC761A6
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DB35B42A94
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AB865986652
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 90D2F986662; Wed, 29 Mar 2023 21:24:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9076C986574;
	Wed, 29 Mar 2023 21:24:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFu74HY6zqy/dLhg7JNuuY7grpQ0XHlOIBtrwIPxq1YOFAvfp64BApg61MHYTN9liv1HzdqgQ2vbkrwWa412yIrWx29qndJ1PwsdhKuczpgeqTYRbMEJ4MYZPptaaw6NkNKZHZlCvURJY/XbDuADYs21p15uQne3lF3WcjW0K3DX+8ko9lvn9alRNjQ0qPenF6M93qF5th+4019FENQ3qKBWBK5rZAZHaU6UwOb9l6gK56s8tDJIlRH8JUH8v9Zmz6PRycAPxmqykyGl6Zcs7uFnkdJQ2C/FPokTrrG2feDpPatSu1YmSfbCOVAujVExoAzyr69lbPJL1AdzjOP5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRsaR8t0uaAwJJSNkCWUcVoNEeTcLGuIw56aqkh6nGM=;
 b=RKt3IIEImAnEdu7NDyFSo4lNUrP+nELVEjc8d7dbypWIrb9554uCOPR/Jl+oylHm0eX1FaSdgtz1LtWhgSkJofVe/jh+QcLy4dnkhxYwOXsHrqb7hIyl7tXiyWza1vQyJMc4f9953SqmDjVJojpN8ljg+8KZLLgLTfxFOnQCt+V/pvPLtFEbqAgYS2Vmtb+TzhHDVbqFQxVOp70Qdpakhpv2j2hw6yQfxU4+WpCNSpXFUEH9dZCsAZRm9GJeoHA4R6o9QBaxEfJprSC1EnaWQQp7cuUM/7ZoVNhZh/HRgSenphTJUdlC8owIPZ3DfwruUixCnNk9+my14Ni9m/AiGA==
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
Date: Thu, 30 Mar 2023 00:23:38 +0300
Message-ID: <20230329212341.465843-6-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230329212341.465843-1-parav@nvidia.com>
References: <20230329212341.465843-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|CH0PR12MB5331:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b679e5-b6e5-4c05-978d-08db309bee3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xssE0ViICKNGAxIRb8vRkZBI7fYvjCj7As4OfOYIkf44kD357uNXBSQvQOWpfKY1x67UZ3/Mitmtl/u+bzEpX4xBcP0+ISYAF1qsIw5Bll2SjMXi7wmdRErP4KXo2Kc3f05GuoVD1b2C8hojGIy0hm+aLGTBBEGk4LSBEHqzoS9ybgk4qDqpt2b75mW9Uy6z4OC3Bj5/y+uup9FcWkxoxBPEvVqr9H5wtthdfL7QXzQykonf+iQ20V6/lD1fduZpRhBkU99viymkNcLTswHzewOsKYfpnPY6XbdnwE9cVKUYpTRqolv8Y0X/nhzREeJNbxASD/2w2eFHYNh1UlnlgnfljjUHasM42BA4wDvvb2L1GmWkvbFjOOHSZbhzephoK1D4mwJXftbA7pYks503CoUBPN6+OOKzTCg/vhoeLFiYUWBup0aGuUefVAK/Q3kyT8mokCSFG9ankzv/+gsSLfJAel56fXMInpP5oj6Eqi3PlSgMV3XTDZwXGln3jTJ8ZBWw/Ww4Nt75/aB/i+sZgUxBRGqVsESOeO2oX6Dknk4K2z7SIW/wacNsegdbwmBdwJi9TQOabKR8JNcjmaUvsmzAAvfd7NMDexEbiPj3z2XIoNrfajg+UKTb8nv6XN++vJSnu5vO7z9pJzWelJrCsosAPSSmkrtHmm4xyiWPigc5LVrOSXyKLv4SExLOlufGRaAv3zW9Rk4dK1vzKObOfw/oMfRvDdMhmZgOor8MF8T3S5M2raig3XJosKo1Jo8MDhBK/+Kf2fCzXsGN3QQz/VqYs6Av9oByk6TRw1De3QI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(46966006)(36840700001)(336012)(47076005)(426003)(8676002)(7636003)(41300700001)(356005)(36756003)(82740400003)(40480700001)(82310400005)(110136005)(4326008)(8936002)(966005)(107886003)(6666004)(83380400001)(70206006)(316002)(70586007)(34020700004)(36860700001)(16526019)(2906002)(186003)(5660300002)(478600001)(86362001)(54906003)(1076003)(2616005)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 21:24:07.6038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b679e5-b6e5-4c05-978d-08db309bee3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5331
Subject: [virtio-dev] [PATCH v10 5/8] transport-ccw: Rename queue depth/size to other transports

max_num field reflects the maximum queue size/depth. Hence align name of
this field with similar field in PCI and MMIO transport to
max_queue_size.
Similarly rename 'num' to 'size'.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v9>v10:
- used lower case letter for comment first word
v8->v9:
- replaced 'named' as 'known'
v3->v4:
- moved note to comment
---
 transport-ccw.tex | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/transport-ccw.tex b/transport-ccw.tex
index c492cb9..3ce3f9f 100644
--- a/transport-ccw.tex
+++ b/transport-ccw.tex
@@ -237,12 +237,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 \begin{lstlisting}
 struct vq_config_block {
         be16 index;
-        be16 max_num;
+        be16 max_queue_size; /* previously known as max_num */
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
+        be16 size; /* previously known as num */
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
+        be16 size; /* previously known as num */
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

