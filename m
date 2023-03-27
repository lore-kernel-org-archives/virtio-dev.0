Return-Path: <virtio-dev-return-11788-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF3AC76195
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:55:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8CA9142BE7
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:54:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 84B85986491
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:54:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 784949840C0; Mon, 27 Mar 2023 20:54:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D97BB986479;
	Mon, 27 Mar 2023 20:54:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYCG6+zHm+t5okAEZe0H5BlQNo9TUVHSsn/MZbCNM9rBTnudxaltdTTd0q1nKGXroFWsIOaNsTkEcICsw3p/thheglR4CLb/N4lFGnKbsVhQX4usimoA6hlA9s04yKYTgQ/23KUlmQBPv62sNmPBqWw/DzdjET9ywxZxmNnunQzSDdgSMHQ1XBd5zhWmRc8WI72YxhhAHLDk49Zy3pPUm0+XPfYm8+aIauc87aacShzF3NVhQyisAoGsfZMJA0GwFxRezB9iB75RDVacxo9w/7yJg+NhTMUc5/qjGO5gIbMTsjnaA6uCAc320943Lcu5FDHlwBYkFh0FPGY/LPpMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=airtlll1gtet/B6KKmqxtGiV85mQTkCQdAIwFUWD5bo=;
 b=Vqv5LumsOk+MXnd2ATLSwkCqpgqYmINhpyGcMwGGMxc6HH3budlifTT2oOdtCM1NNFFKBxjb0SW1aTKluk54A9MdJX3Tyb7+I3hnqlYJCmNHIyVMdwHy0NNaYIy+0YzzopNvk1GQ6XnKYQ1ZdlBfHtdSuTV/7uTiqo1ztDBWoah/07X+x0J+qUdq7xIwbzymsRVMCG1DwxradKGvNG06OMXZBMgrgAfaMJlG00+q5C8iALWF48utyy1f8bxgxGOea7EGlKwOp0vyrhpAeIdJRbm6vX6cwuv8hZDuxmb7GJkOTgU5E0p3RTFSrRj6JXoCIWnltazR/SqUEMPY53YTCw==
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
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Mon, 27 Mar 2023 23:53:57 +0300
Message-ID: <20230327205359.406605-7-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230327205359.406605-1-parav@nvidia.com>
References: <20230327205359.406605-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E630:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e6a568-8ea5-4137-3ae8-08db2f057503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cioFZ2isvQPsyutrqYn2B5KOAMvKDmFu1BYo5JafHvP6sLzPWNnajf7XAt2TXprThPeBA3CY4Cr07maq1QxuKvvgy0Y2Y+43GJAhntiZGsgCHC0taOhkY/NNQRq6PaEX6/1ah8T72QtzDaGwQ8yITubQ8jNR36w01mwLrh1DF1TzCPpHbiOXkY4V8pXP8Kn/+6/Z6skyAL5oTZCSYE+eLCp4Tsn8te7czlyruNa1cdt8LgA0zYcbiOrKSA6f+WyvbF+5pB94Plbirb/ElHbAoeSUKFak8e2sVjLMLedsemiIWELw+TZKR/UcGDP9SKqcRwLjyMnMKPVdP65voMUYwYtJOoNGKQ0fyYRRZTBSFZFk5Vc/9XcSSNqKu8vmkXjhwJafx4Nce+AivujaBwPdITv5v/vkIe966N4EhMBDz24IPO8/2JeeByDLys8zB6sXnUWt/f/wtMc8tBEnYPhUj+g+AamAVRjBl8NLBsOK5ArDq07sFcNrlC+fOJPFumSytckWo5+8JXfZ3aGRxBtx8xBEG887gmpgjm6hbssyZ1Y5UaCS7AGFQ2EKz+KxExSiUddyKzPn5ka5qaEgggGY7K5vyDo20Ne+PA23KAHpcpO/dlr+HDqvmzIYk60ab2le/UedmYIqW19mQWJ6sIwQx2TTSe+ufJmlDpOY+gq1yX1C8y/RPOio5Ck+H0jWCxSB8FsVlw1FYgEO3N3QyMSfeLryCOVcZ778wMxSXyhZm+di/f0uZZlKYtAHPPFoPIUWglQvOJSl4R2qhzA9CmXNhbaiFU4KHZsJGGd4uqWye8E=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(966005)(7636003)(4326008)(41300700001)(36756003)(82740400003)(70206006)(8676002)(36860700001)(70586007)(356005)(8936002)(2906002)(5660300002)(40480700001)(478600001)(86362001)(316002)(6666004)(110136005)(54906003)(107886003)(186003)(16526019)(47076005)(82310400005)(426003)(83380400001)(26005)(336012)(1076003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 20:54:28.6138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e6a568-8ea5-4137-3ae8-08db2f057503
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0000E630.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217
Subject: [virtio-dev] [PATCH v7 6/8] transport-ccw: Refer to the vq by its number

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v3->v4:
- moved note to comment
v2->v3:
- added comment note for queue_select similar to max_queue_size
v0->v1:
- new patch
---
 transport-ccw.tex | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/transport-ccw.tex b/transport-ccw.tex
index b4bc83b..b405db1 100644
--- a/transport-ccw.tex
+++ b/transport-ccw.tex
@@ -236,12 +236,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 
 \begin{lstlisting}
 struct vq_config_block {
-        be16 index;
+        be16 queue_select; /* Previously named as index */
         be16 max_queue_size; /* Previously named as max_num */
 };
 \end{lstlisting}
 
-The requested number of buffers for queue \field{index} is returned in
+The requested number of buffers for queue \field{queue_select} is returned in
 \field{max_queue_size}.
 
 Afterwards, CCW_CMD_SET_VQ is issued by the driver to inform the
@@ -252,7 +252,7 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 struct vq_info_block {
         be64 desc;
         be32 res0;
-        be16 index;
+        be16 queue_select; /* Previously named as index */
         be16 size; /* Previously named as num */
         be64 driver;
         be64 device;
@@ -261,7 +261,7 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 
 \field{desc}, \field{driver} and \field{device} contain the guest
 addresses for the descriptor area,
-available area and used area for queue \field{index}, respectively. The actual
+available area and used area for queue number \field{queue_select}, respectively. The actual
 virtqueue size (number of allocated buffers) is transmitted in
 \field{size}.
 
@@ -278,12 +278,13 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 struct vq_info_block_legacy {
         be64 queue;
         be32 align;
-        be16 index;
+        be16 queue_select; /* Previously named as index */
         be16 size; /* Previously named as num */
 };
 \end{lstlisting}
 
-\field{queue} contains the guest address for queue \field{index},
+\field{queue} contains the guest address for queue number
+\field{queue_select},
 \field{size} the number of buffers
 and \field{align} the alignment. The queue layout follows \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}.
 
@@ -571,7 +572,7 @@ \subsubsection{Guest->Host Notification}\label{sec:Virtio Transport Options / Vi
 For example:
 \begin{lstlisting}
 info->cookie = do_notify(schid,
-                         virtqueue_get_queue_index(vq),
+                         virtqueue_get_queue_number(vq),
                          info->cookie);
 \end{lstlisting}
 \end{note}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

