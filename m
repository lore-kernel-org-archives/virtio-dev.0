Return-Path: <virtio-dev-return-11799-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE50EC76195
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6C14E120D7A
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 62F6B9864D3
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 57979983E8E; Tue, 28 Mar 2023 00:00:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D5DB3986739;
	Tue, 28 Mar 2023 00:00:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOySuEd+lpct6yY1fm5mzHd9yr3E0+HoJ8F5pdTaNUTPbs8RdRUgui0KDGTolIOBnJ0PcJN73kmP96GVZQ+NOFE0L6H1Jo97nIi245ifh8RC9f5bqHmY0zMNhithXrP1KyxaCp8i94iBponLzct8E7Evmoi6bELrb+cv500Hp4LjhWcOd1r0bcBi98+AR1KFfjG8oWpMvRGY765/IrwwNUQsmTI9WKX3GlKhmWkzQO0FYsR22heuKv2zTzf2JqDvbPWqRLnSTu59bvbecTTj5YAfSmuHME08I5BVeNoVqeN8+15dzUG7x+mFTfe4FGWUcu6q+fO8YQ38HeFI3GR/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9rv62A6GUE0xs+vJ9ZuoQfMlX6hJBVsIC9G2phIbuo=;
 b=QzZT4WqKsO/Yxs8ojW9x000/3tb9l4CxYPD/tAf7U7NSea8Q6Rk4KwedacBtxNnGSR7NDUqWvt8BzX53ZEmCpLgmGtAFTwQVFNLl35LnPklfX+J8jIbThzrTQonNWorgVqBy4BL4ahKcfZj13KUQUh/G7tDCbY7s8wO4okRxFcu3ooj2Yv1QqynsJWL0zusqHUz5Fwkihtebl20VFkSMHaxG1vNdJa5oVqA6gMdRKTdll9+6YI4TZvhAE/LQU+qpMS1KuVBVC9NnSVHNs/G6rXA1ycN2+z3Gjdj8Azo/X7SzuKK+tRTSbacJ2Ks94PKPV029oBpuO+7zyVevWWh2Tw==
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
Date: Tue, 28 Mar 2023 02:59:33 +0300
Message-ID: <20230327235936.414196-6-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230327235936.414196-1-parav@nvidia.com>
References: <20230327235936.414196-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT109:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: fda65d07-6237-49aa-542e-08db2f1f633d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7Q4H7Rg8PDAcsK2YZMXdEktIxULq1W1mHrh7xCHke3oFqfveR/URf2il6q/XBembr3DcOm0LpI6bIVNu2bftF9NyABaVbi2z3INmIgsSSm3M7p9Yepvvv24ehz5AnaSo4OESa/maEl9n9G72/5tyiL6YT4pMFG514bKwMrLc6IPj8XFsL49ZHvjVL4Rh0cal32oV7wHD4QaMAO20OmMJfiRujB/uqANkYn9vpHiBYkiZbuGKNHmpfjAk8y0cMacC7AdJvXNtpicg4miC8/rou6L0xeFX2YcWEmP/4bMCfr4Ygj4syl4bZtQ1qGOhHo05YY2mtmHQDHfwOUvA64oZl7/BzuItmUmUn4scc3ehE5i/vBjAhCNmQyHyxJjM08obd8SrCfrviWLxlGKOQNrIX8tglf6kuBUOC4XTGRLpsZ5K4Ls8rPXn0Ec86bWQkO9VsXwTCk+YmaZR13CUp7+ZKQbLrb26vQGFgbPefwPPe+LTPboBfvMZmxAyQsE+MLhAZvHkKitIc7P/iO/y+gFM++ch5Vl2mGD24MkbJXU52zAZFbJzo8d+8ghsd6AUs6tcbI61Jb2At1HyK6Bjjk8PQTotaUrN5/auWz5rDtChQjgzsWJ0kqqNFCu21I7thueCIprDLiXXiKNloG3MWPN8OEeGxnpiAD7mMOaKDRu+GWbeSr5yd3OJvWIhXLw3UgkdAEfmt/WSx9bCIxjzs9kvNsdX973lYy+mvEgeSfk94FdD/OMx2tdgds/K8LBKcF7WYOYfDtqoF4yp/o6qpnKwPwOoMexjBogxKMwYgjCijyPhQLszF5czvOX6sStAHPIV1TqHOkjhcmpXnDiILxOPoQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(86362001)(40480700001)(82310400005)(36756003)(2906002)(40460700003)(478600001)(6666004)(107886003)(83380400001)(2616005)(47076005)(336012)(426003)(966005)(54906003)(110136005)(36860700001)(4326008)(70586007)(70206006)(8676002)(34020700004)(316002)(82740400003)(8936002)(16526019)(26005)(1076003)(186003)(7636003)(356005)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 00:00:05.6481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fda65d07-6237-49aa-542e-08db2f1f633d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307
Subject: [virtio-dev] [PATCH v8 5/8] transport-ccw: Rename queue depth/size to other transports

max_num field reflects the maximum queue size/depth. Hence align name of
this field with similar field in PCI and MMIO transport to
max_queue_size.
Similarly rename 'num' to 'size'.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
v3->v4:
- moved note to comment
---
 transport-ccw.tex | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/transport-ccw.tex b/transport-ccw.tex
index c492cb9..b4bc83b 100644
--- a/transport-ccw.tex
+++ b/transport-ccw.tex
@@ -237,12 +237,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 \begin{lstlisting}
 struct vq_config_block {
         be16 index;
-        be16 max_num;
+        be16 max_queue_size; /* Previously named as max_num */
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
+        be16 size; /* Previously named as num */
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
+        be16 size; /* Previously named as num */
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

