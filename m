Return-Path: <virtio-dev-return-12562-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E2FC77B7C
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3323860271
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7AFE598673A
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0814B98685F; Fri,  5 May 2023 01:47:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B3A53986766;
	Fri,  5 May 2023 01:47:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1OpEnK8DYPhKrnomI1UiBBWDKSdKJmS6ENuRkLgqbdYU/gW0+Cmt3I2Bf30e5IY9ejjHfVzcNsiTUzQ8sRD1hr1MvZ6xdKTdDbLG37sfR6Z3vDizY/0GI+r3TT2wdtQr5t9/6OAqiqw8AI6VmLZ/adbs2v/MLY3oGoH1Y+js2/YIX+6vXlGmkT1jxusDBJixqqnfMaWoC5jagApgLatalvxOi/LJCXDxTSHgj19kg6Uhqv47NYXlUJgKfpwxyfLDaZ2Y/xEIY5c8qasLLcd+G6cNiEBoHX7P+BAf8PnDHRR/+MMoJKAkNkApeKuHxHYNrCqYh+u4cE/3TDe8llt3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkCKsHnCSdNo6rSCFSv6ARAPg1nQxhHKnhmAbbUdgF8=;
 b=WLYdiP7BHslETY+RVlXI9lc3wbeuqxJ1jZ00DPLL04sxRLx+gzLj4K+HTxi1EkZdx7pf612BjCVnsl+SgaXnb+9tMbM6a3FP2BujVwq0/Mj//aYPvTogQoI/Rl/aMbfpVN3J81jDqkfe6EhCBFILDsmoSWaiLwKTeuwe3AJXaQwYdGOMCe+cryPjElhiII8ZibwGC1Blq9Bt1PG2yQM/T1Ss/pXxa8jXFR9gRQo3QC7st6ZT5HIhHi6pU79etNiistQA4b+V2LPyrxXdHcrymGpOWNuuCD1UrB9jL2giSGKa4qdTnux7PKPwGJjan6eX+S42WS3s32iD9fFhebKi8g==
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
	<david.edmondson@oracle.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Fri, 5 May 2023 04:46:10 +0300
Message-ID: <20230505014614.571520-8-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230505014614.571520-1-parav@nvidia.com>
References: <20230505014614.571520-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT066:EE_|DM4PR12MB5360:EE_
X-MS-Office365-Filtering-Correlation-Id: 317219ee-b28f-46cf-1268-08db4d0a9830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f340DQbBIcWA3TGRu8jvbqq7TEM11dbHuLXVo+ZT9dHfmMMbeh+rGnNm8G6r6kZeWLp8XoePgwAHOmEhwD/09ShVG3k1RbIYFFf1tQvca4Xgd/Ml4+x460+ljnJgkfRyTnc4OmBWpJKiuDjMNjYXrP9C6XKqw+ptGwU8NXZ4wWe5Nw4Sobgopm+Oj31GOMl25lcWYyHfdja1m7fCk44F2i+FGd8uaXa/OGcYbF894VtvQRUBvJKkl/R16F409hCeJsFenr+m///jabhs1axMzNm3a0I5VnhGohgUfNOigRKTzrSpbWvc3TcnUGx3afp9LA0J5z4sq1B6QMFvq0ewRS+KKabIpb5ZkQxVgDpgS8zlXeVnmtFKm0n9DEFbZBTZmYBUatOVnfZ/KX9h0KqTpZ5EVOzF+oV9KHvnxNVW212VQuQ8ERFM9oscU5qpqbebwrXc23xvFGIrcZnuAbM5Uf6beFnNKPnqVMtc6DBX9HQS89OBUxvV17ZbWi1qgbzltNZQ2/vG19cPrY4xdsVdFHtGFjsEtBYtbO+FR7duMmhogY5N0jzilJPm/mOO0eVhhn26qDcAjRvnAlYugU6bSL/OHOAOCtmdaenulZ0QiNh3136RYRSXmvVl2e4Rqb9l54RYQHVdPR644mSTx+WLtSCpFdjz5kYiNtkhJPFZ1/38lvrrzLTsxJcJohU3AdSlk84nRH2OKMCf9LZWbucGm9hCFe/Ty/qBgtTrVd79pEx+2gkorqZh9triarxPJOTh
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(316002)(36860700001)(8676002)(5660300002)(8936002)(70206006)(2616005)(82740400003)(47076005)(4326008)(70586007)(426003)(86362001)(83380400001)(2906002)(336012)(186003)(16526019)(40460700003)(1076003)(26005)(40480700001)(6666004)(36756003)(107886003)(54906003)(41300700001)(966005)(356005)(7636003)(82310400005)(478600001)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 01:46:50.0418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 317219ee-b28f-46cf-1268-08db4d0a9830
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5360
Subject: [virtio-dev] [PATCH v17 07/11] transport-ccw: Rename queue depth/size to other transports

max_num field reflects the maximum queue size/depth. Hence align name of
this field with similar field in PCI and MMIO transport to
max_queue_size.
Similarly rename 'num' to 'size'.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
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

