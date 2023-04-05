Return-Path: <virtio-dev-return-11996-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC0AC76188
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:08:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5A1B6419B3
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:08:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 48D079865D1
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:08:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3C2A4986595; Wed,  5 Apr 2023 01:08:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D7B05986629;
	Wed,  5 Apr 2023 01:08:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8iobOUZeVJ9yLTAalyhLx26xq33NYFVHd2roZmsGPw/G9vwhnzzulwj67pMpFTHlhcCNos9Ok2Y05oVOlNo07gH6JDkYdzc8Tn1dkOlW2Pq70M81NzpgMAwHQA9uSAxhAoE06xegpl1hezxa/b+tr1580ox/J9G42F+bzDvrHeKD56a2UYwvRD085WIH3Kgh8uqxrROAEW20rTwB+Su5GPErj1LYKvdLft0EIME0s2I9DhnYOADjzTpOZpORXbMfWHLZ+gFtO9/NwYeNjdwhtDo9BLE6DZBrYtELBHi9QntTwpynq2k4hWOZPFfU3G8cp+LIdQ94e645VCj4/wbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9EKa//6z7Ixgq6+lg15Qmmjc67yBf4hxC2DHEpVvLA=;
 b=BxrQJyMdvPSR6wMSbUQO33GlZwxSz5HYZ1caanBGBBxfKET0knBPXvuU7+XBNgrlL7iWDb5sRWgaLD9ZhjPw3keXBjYRyVsnlgnNBcQ3M6SbZ1azvFKf2e0KhHXJB0vCNBuMt/uWHmVHUN4RP99ZBW9HKuhMYW9GikkOhKJ6e+tNHmkLowq3PK629ueJ8jrDZy8RTWtzJ1r++uLd+ZKygpABIJurfUHsDLfF505/YBsw/bLyiwaInGcAuc2xxgE5EkStdWQK4k35/XMu623rIfbkBMfroCImwZnPp8zzgxgOh6s8RRWMiWGDuOlUTxZKJ4RkWXAPgIsmhcXY+HrQog==
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
CC: <sgarzare@redhat.com>, <pasic@linux.ibm.com>,
	<virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Wed, 5 Apr 2023 04:06:54 +0300
Message-ID: <20230405010657.612529-8-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230405010657.612529-1-parav@nvidia.com>
References: <20230405010657.612529-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT017:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: c7545246-868b-4a74-f3c8-08db357220e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ue6Z4nXuilUDKq+qa6fr3XDOTDG3ICCVhHjJ8d7JjhoUsXWc/jQ9NgaN8xgP+BCNLfjbfr4f26wpSIarN5o/hC2vrG0yri/PxSzD+djDVku1m90/Vuj6KAU2tlTJiNGXZ5w781rM6ExMD6nirUKFgxnAeVDHjbAGtwjnuz6O1sMIlAayJs18vtkQnaJikYE8mS//dSnSvu5RS4UVVVrkCa6KM+iB3rOgDtOPIei50dXCfU0+jlTy0QZJ0cfMkFrdZTgn1KgKXwUt/li4OHDHS+1Vsuo+3TV1SGoBBTMaMFSQr3GKYeIwRiMlQFwBqox0cq2oywmHez07zj7Nfdy9K8iy+MLlSoo/JPzrLvCp5y+sZC5+5dKYlptV25u78nz2wXtgLneJ5PxbKzy85EKlbgkuiq3Js24FFym+bM/m82IYI4vznN7WxFnKj00F3guDYuAjZkQU1dtCpjx08k/FNDPvCVW3RIQIaUhRaGRQUzyC/nLeggXn48hqov8m5btLE1aEThKGl5qC+KvNzraX193X3dgQmZ7AyekMvD+p0mBmSp8de9f+TEOdqwD36XN48D19IXlyZBipMma/LvQb7EBgua89Tw8zya+Tyx4DHD2A/QLhVpCzXG+2eo3gyFQ1gFbF5zw0AG735W4fcbeTY1l8Hk8wCu7Gtdj85PwD8KznZz1N6JxOCh4Ntao2d/sBREFJMMxXPYSNaALvreb4rRcwDES4/ZcZyAp7gGirGkSHBPSVUJ1jTItug+NngDkrha0sn06qJpeF/aefTg4VNg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(46966006)(36840700001)(40480700001)(4326008)(110136005)(54906003)(966005)(8676002)(70586007)(70206006)(316002)(36756003)(107886003)(186003)(6666004)(83380400001)(1076003)(26005)(426003)(2616005)(336012)(16526019)(47076005)(41300700001)(82310400005)(478600001)(8936002)(36860700001)(86362001)(5660300002)(2906002)(7636003)(356005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 01:07:29.5783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7545246-868b-4a74-f3c8-08db357220e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273
Subject: [virtio-dev] [PATCH v12 07/10] transport-ccw: Rename queue depth/size to other transports

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
 transport-ccw.tex | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/transport-ccw.tex b/transport-ccw.tex
index c492cb9..cb476c7 100644
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
@@ -262,7 +262,7 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 \field{desc}, \field{driver} and \field{device} contain the guest
 addresses for the descriptor area,
 available area and used area for queue \field{index}, respectively. The actual
-virtqueue size (number of allocated buffers) is transmitted in \field{num}.
+virtqueue size (number of allocated buffers) is transmitted in \field{size}.
 
 \devicenormative{\paragraph}{Configuring a Virtqueue}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue}
 
@@ -278,11 +278,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
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

