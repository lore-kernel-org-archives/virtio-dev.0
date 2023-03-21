Return-Path: <virtio-dev-return-11663-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757DBC76195
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5BDAA120D74
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 507EA98659F
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 44FA7986579; Tue, 21 Mar 2023 04:11:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E58FA9867BF;
	Tue, 21 Mar 2023 04:11:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PP8Tt0+OCFOzf99LaGNjEkOAGSBz3s0C4jVguSzkBk6xKw98FhYAGu4Q94Lke8vbZ9C8qU88HjG/kcCXSSCAiWktTFlwlp2NPiAUfJqADtPUyMddQ8p8ho1YEt804PVhYx6BiQTuYcdwSbgCw/c6NFe7Ytiv15wauOUsbl7K+0SvjC9nj3ZHErtOR/G4hrNb6IS1n89GE+kr0x7jJs/zOCU86qZnUzDYOf2gVwciPRis8kKQ9or46mcFVm8tJY58dNnF55UD5uNQPznYRyu+OkILPkPIV2HIUIedvGKuftxV3kPqcTmnMDg2QPxzDzBtknq4fO3e8xB+9ZJFUGWNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/u9qcgE1c9nFaEWnKicCAcbzCAuhhD5p5Mn5o8dqgc=;
 b=gmQeWrcJD0EfvM9dvw6MrzNJ11gHkksn4yFPvUQSoMinofl9jQ+uGnztedN2TW8TKAisr7W8rIKaXOGY73KNo4lqyeeagEGmv3bmXpxnJEAhEDNB1rH8kgd/4m3X5xKrPYU2hqdSAZRZ7AEl38L2+bRXvSuA0TAOfDyFj/zJLAH4mAS7w1BAU/k0DB6VfVncmZ5xkzG6ZUKyYNXQadtDesq8UtsHEzLp6BYRzsyrGaxysbnm+kGBFKV5zASRb+0epfDUBMyslZaYcZZM2YMFDlse00IT4or7juiDQmMnGy2qBi9uB8Jtt52mbl+mj6h9yqZvj0v3FALMx1POPQ+prA==
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
Date: Tue, 21 Mar 2023 06:10:34 +0200
Message-ID: <20230321041036.201439-6-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230321041036.201439-1-parav@nvidia.com>
References: <20230321041036.201439-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f7960f-a497-446e-8a36-08db29c24b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iBycLJk0HqsXeEpoPUhbo/+MWgIHZdDz5Jb0KGk84DbqMWe+VbWIJHFrUcauFq09+7DR4Gu19w/3Fd3PwajdJrdbAFY0fiMjbbflmM5evv26O9ABM7rq5Hxv2CuvOp/kf2BCHTfZ3Zc9+iYK5FbHSB5zAqFXeWsvbaySkF33LyFK6MkThIgES4sZMJQLSwXx4c+L0Rn0et33O90c5CA00EkECNFIAoLe2+lV8d874V2ExoRmlcVPds6kNFrSRqsioW6yUGbXyJpYickNtjUEfNh5e5Alvc2aTUkJ8QBsLJLQtBefcwD4TeFvxpr6JXKtI8aYVaz3M65ZrcqZp7QSdAyhSwMXJ2UF+TNkhUR+Z5MehN8kaEh7/HKBp2csUeOcNU9kN90W1kdY2xsDdfu0xTv+f8/BBZx0I8+twL5hta8R9Nm5S1qvveEJbMmHCcyVD4H7CS2ByBUCU4KEebMRNa7k4ATZhGvTO12uVDJw0k25gl1LDQ+hpfl1WvsG/GaQ5mdEY0i9kzlX5lyxgvu1WFYpz5iNfuSdDqnXXPB8idR5DzzuGD0mYfD2En9s96s0Ne/hGu+hzb5NGX4ZAtbBmaeYHWeh9VztsOY19XbUrVRMX3z5j/vvKxqd1uCLzQLOahtDUG5eqRSVmuk9WITvYGrKaD1+v/vXKfCqtPfvhnLWcw/sYZQoHYUvlGjy6DJaih4EVkz1b1uQgIdNltjvxUdaEBKm9EwQv+lGlsAjPFyX79fgr7qAwamp2kDYXp1VM3g+oK+hcJt5G7+9TnyoLDM+SBXQ/aDX8bWUky7RiPg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199018)(40470700004)(46966006)(36840700001)(966005)(82740400003)(356005)(478600001)(7636003)(54906003)(5660300002)(36860700001)(110136005)(316002)(86362001)(83380400001)(8676002)(70586007)(4326008)(70206006)(40460700003)(2616005)(82310400005)(107886003)(47076005)(6666004)(426003)(336012)(40480700001)(8936002)(36756003)(16526019)(1076003)(41300700001)(186003)(2906002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 04:11:07.1038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f7960f-a497-446e-8a36-08db29c24b9e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128
Subject: [virtio-dev] [PATCH v2 5/7] transport-ccw: Refer to the vq by its number

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v0->v1:
- new patch
---
 transport-ccw.tex | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/transport-ccw.tex b/transport-ccw.tex
index c2e60b6..b8ba0b7 100644
--- a/transport-ccw.tex
+++ b/transport-ccw.tex
@@ -236,12 +236,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 
 \begin{lstlisting}
 struct vq_config_block {
-        be16 index;
+        be16 queue_select;
         be16 max_queue_size;
 };
 \end{lstlisting}
 
-The requested number of buffers for queue \field{index} is returned in
+The requested number of buffers for queue \field{queue_select} is returned in
 \field{max_queue_size}.
 
 \begin{note}
@@ -256,7 +256,7 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 struct vq_info_block {
         be64 desc;
         be32 res0;
-        be16 index;
+        be16 queue_select;
         be16 size;
         be64 driver;
         be64 device;
@@ -265,7 +265,7 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 
 \field{desc}, \field{driver} and \field{device} contain the guest
 addresses for the descriptor area,
-available area and used area for queue \field{index}, respectively. The actual
+available area and used area for queue number \field{queue_select}, respectively. The actual
 virtqueue size (number of allocated buffers) is transmitted in
 \field{size}.
 
@@ -286,12 +286,13 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 struct vq_info_block_legacy {
         be64 queue;
         be32 align;
-        be16 index;
+        be16 queue_select;
         be16 size;
 };
 \end{lstlisting}
 
-\field{queue} contains the guest address for queue \field{index},
+\field{queue} contains the guest address for queue number
+\field{queue_select},
 \field{size} the number of buffers
 and \field{align} the alignment. The queue layout follows \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}.
 
@@ -583,7 +584,7 @@ \subsubsection{Guest->Host Notification}\label{sec:Virtio Transport Options / Vi
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

