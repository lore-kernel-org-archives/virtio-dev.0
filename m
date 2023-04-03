Return-Path: <virtio-dev-return-11945-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6627CC76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:51:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EFA393240
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:51:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7605A98666F
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:51:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3E2F798675B; Mon,  3 Apr 2023 22:51:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 709CB9865B7;
	Mon,  3 Apr 2023 22:51:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALYOCUQKD9nIv/iG6grFPvaldzgmTA+ygsGb3/coPf2zu8WRItiZxVqVFzkwbDv+QvUspTmS3rFWYvzoFVrqKDfN2rOVc7WOMPRnYS4H0Nn94e7Gr5r3EixEBTIwjgUKdc008y8KNb6pKUS21pXU1cdf98L5ON4lzgzklft3m5L1LSBvnPtuF2awB6slUTrd4564sth6N5ow7MZS/dfCX/2+q5wNKX1gPfWIoPN1giwB6dMzRx3vPZK0YGJximovILUepqi6Hy3HzpqqZUjvsVHi3tMGZUIzP/fa1SmWH/p94qcFJbY3eoyVl5tvnufbi5jo31856Q2Nt3JVAigl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRsaR8t0uaAwJJSNkCWUcVoNEeTcLGuIw56aqkh6nGM=;
 b=RQcpcqdYgs5C0keAhRlHHTNUYMQ6GTAaLCIm5OTguXSlXgU3qlo6ioM5FVlzeqSWCe4hVn4Pea2y6AH+9XBzr/fHAre62BkNZMgqljcsPBFe5weHZdqkMV7M82BGcZ4Hi3Hc2Fg2XLHrICNWWb2c4HvX3MChrIS780+WY5qv9dBsX+CWO8/sowd2v5ojsfVgShIl19AnhbBP04XvTpV6jlMOPrUu9rJBNE33J/9dcPHvLtF3ZRkF83PxKCuxOrKc2t1JNaNBzItfirS5Aw49fWG9NO2gbwLTFEP6/wevA6yW/y1fo1qgLpXVpcXnfJ17d5FLNVUHROfYvRGycfyqYA==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <sgarzare@redhat.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Tue, 4 Apr 2023 01:50:49 +0300
Message-ID: <20230403225052.585498-6-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230403225052.585498-1-parav@nvidia.com>
References: <20230403225052.585498-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|BL1PR12MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b184b6d-a1f8-4e20-ee89-08db3495f6db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4FHRpPpZzbNmwXzTE2QnFEbRztpVKZ4OyLGlLCdX+Z3kghSyArz0a+2lCSq7paf1dYljzOZbLcBOSnpDn2FE6jfdtDMnj/ibkNMtYZCzIj6pWNQKzkcbrvxYfttEaEUG7QEfxITH53T9cDUhqMwaUAiTdkQOWJf9HAYVHX6tPNncrA24qyWtDG51ub/lucF2+qr1SF69F0kp35xd5R2yUBmpjZjrfaKXT3J2imASSNNLokkVnbcH7qjyvi68NJVZSOL4q5nSTt15hl6xCrRgumFOaS3mCCX3VyzQhKM+OdGxf27Ms8wjRqoZjYwliwKCk7mEBDnJmPeBOxDalu8QtGNZpl1qOHuwvPLcZRNPQgC0hNG4NUK7wrzQdBqfc66l0TKPg6FHRYHJYYQ7nd+YVrdSiJXgPq6IxUTjcstSBvdPNb+O2B/VqHArxvtEYmmWYGPdY75B8Nrr935tsaJZrGc613iBHs3y7o/D14Y6ndCJBIQHRTcY0Y0Wh6j+S4rSJOytbHvxSjh40+MnNsIJDxfAB1xy0ZOg6pjCb/HvSoL8r/srWPVSxKFvNEcO+eyVlpX8idCSZgZHt1J8CDragDtBDgAV7o8x8Q7Xlsr4I+svdA7dzsyiuIXatsr+PErxtazlmY2CdJfKbUDAJ4xb8nJK1st6Nc2ot687nUS5TMqPwYPz4bmeSakUpFCoA4akGQAYE4Hi63UKLAqubL7PCABznay4psn/A1FBhMfejrb9Rj2kan/bzYafLt2zbdn2iWfEMfIyNA578EfrjhPe761bXGmIA8FPVJ4g2lC/v90=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(41300700001)(4326008)(82310400005)(8936002)(82740400003)(7636003)(356005)(26005)(316002)(110136005)(5660300002)(86362001)(54906003)(70206006)(70586007)(36860700001)(8676002)(478600001)(2906002)(47076005)(83380400001)(426003)(336012)(966005)(40460700003)(16526019)(2616005)(40480700001)(186003)(36756003)(1076003)(107886003)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 22:51:29.7406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b184b6d-a1f8-4e20-ee89-08db3495f6db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5803
Subject: [virtio-dev] [PATCH v11 5/8] transport-ccw: Rename queue depth/size to other transports

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

