Return-Path: <virtio-dev-return-11665-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A92C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5666D29FE5
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 228639864A8
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 04CDC986451; Tue, 21 Mar 2023 04:11:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 65B0698654E;
	Tue, 21 Mar 2023 04:11:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuoBjz3aOvMG3PgLFC/iG7Ktg3Pz99yQ5LtElvQHBYEtdgrikR6LM/sAGzCenjoiC0zEmCDLTyguQnmkyM9eVMm824pB/p9cM8LYJXZgA8cPQpXiPYe2snMIvX3BbZ52Ej7t/QmI4rzciPO+uRfhUCMB0cmYjpCpsdwTr9c0aKaMxYhia5Yl93lB6GTDTWxMewyP6DahHq4OYMHKT3YboGRDy9cizpp7hcHv42nsC/c/YNi6MAwzaRqo0Ppy3GY30EMYuW5pInOPwkn449eklUZcRDSBYxgJyj7Bd6uZMVsVg3hcwZYZ+o5Jm/lF3T1z7wxFHTaKK1CUxJOKqtSXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0o3TZKqi2ct+fRyEFw6Q1Yk4foQ4VDK7Dk5W30dV2M=;
 b=kWAyDvgLm0QJvkmy+UojvtvFqibAnVWgRCauj2Wk4O7iSEZsYpgRce2fzs0bMULYCw4XGyzZ3AyvNehnndGLi7a+7JmHsAAUXPzM8R5FFfL96vd8AVWI4BHePQJbj+BT9G+gCcHkgS5ss/+EPKfYTvby0thHsJ9pFgR+VY+9Kd7WZbMJmB4037CgR3TGxjsIeeSRfnO3Yt3gUSvjfvsg5DzE/gSaqCrtsAggTKK5ytC0rIoEwS4W50YblMnyDxYMwwFSsRy2BMnwzqdRlHbQfbTDkUIuAtbPBU0aQO9efH4Elg0QpF3DPsXTNxKU87xapyPMBSnHZGIIMLkd1FbmpA==
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
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Tue, 21 Mar 2023 06:10:33 +0200
Message-ID: <20230321041036.201439-5-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT058:EE_|CY5PR12MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c5e71d-415c-4ef2-36e5-08db29c24c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PqldQW8HBgmXnae8gBFu3/sjSC4mEVWeluNnjlh6lTC9PWN0n43Onn30b58/+tAQ2zqYtwJ3SGDmnsGDSP2ooWMT5SEB/datzukN5d02ZGx/Us5caSJ5tEuQ4evhMXUj61NXGXgT9vfq/w7GY2DslKZHnKlvVAOkzdXNo/G0JLEQbMHsx67bCooKZFYBPedBOLYV/V9h1rb3y9MY5l1eKXXXNMBphYzgzyS9j1suiuzVliU0wkNo/icjfKu3zxIG88LlSJoBy9mNUGdMS3V0aH/nWj1bnucxZstUPXWDhlENyl4FHfJxicKuC9KvH3Q461NqHGcPRzqRR3jfI7urdS3usfOQR4IGGC5yld7bh05NjrIcTqUQrx9K6pXSBJYRp5MFPR5RWzlz87ojPxeZARddfojKe8WWnRtybaeXYZtIFwXpBhduEInla1xuNXfTynZT/kof9kE5aORpOUZsjRke/egq9xmQFSb4H4UEh9l/SOcFwSDPMdI8ZV/UiqjoQh29eLvd9x9utxqAWAFGxJnmvdeRvHNQBwPsEQhq0TlMpq9WjvxpqWxrIrUB33yDijmqT1Z1cjFbTfZC4Tg+GjYkwqG2BwFW9MSUsNM8oIHacrI1wGyZYoNW8PMs2UzdQsSdLPqbHl2HtPoV4dmE7NvKsEqthP3cnWBEje0Nc2NPxyJQTUrBW0MP2hwqXBEgGNbYnVcEt4+TF/nHla/lHWbqSSk3SNirNEnBtWg0nvxOIs6bTQxBCWOeYNdaykDOB7rkn5/RnZV/s/e3V/mig47eJld+umP0VycytVcU3N0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199018)(46966006)(36840700001)(40470700004)(316002)(40460700003)(86362001)(83380400001)(16526019)(40480700001)(36756003)(336012)(26005)(41300700001)(186003)(1076003)(8936002)(2906002)(426003)(4326008)(8676002)(70206006)(70586007)(6666004)(47076005)(107886003)(2616005)(82310400005)(966005)(82740400003)(7636003)(110136005)(36860700001)(5660300002)(54906003)(356005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 04:11:08.4170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c5e71d-415c-4ef2-36e5-08db29c24c75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6528
Subject: [virtio-dev] [PATCH v2 4/7] transport-ccw: Rename queue depth/size to other transports

max_num field reflects the maximum queue size/depth. Hence align name of
this field with similar field in PCI and MMIO transport to
max_queue_size.
Similarly rename 'num' to 'size'.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-ccw.tex | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/transport-ccw.tex b/transport-ccw.tex
index c492cb9..c2e60b6 100644
--- a/transport-ccw.tex
+++ b/transport-ccw.tex
@@ -237,12 +237,16 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 \begin{lstlisting}
 struct vq_config_block {
         be16 index;
-        be16 max_num;
+        be16 max_queue_size;
 };
 \end{lstlisting}
 
 The requested number of buffers for queue \field{index} is returned in
-\field{max_num}.
+\field{max_queue_size}.
+
+\begin{note}
+\field{max_queue_size} was previously named as max_num.
+\end{note}
 
 Afterwards, CCW_CMD_SET_VQ is issued by the driver to inform the
 device about the location used for its queue. The transmitted
@@ -253,7 +257,7 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
         be64 desc;
         be32 res0;
         be16 index;
-        be16 num;
+        be16 size;
         be64 driver;
         be64 device;
 };
@@ -262,7 +266,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 \field{desc}, \field{driver} and \field{device} contain the guest
 addresses for the descriptor area,
 available area and used area for queue \field{index}, respectively. The actual
-virtqueue size (number of allocated buffers) is transmitted in \field{num}.
+virtqueue size (number of allocated buffers) is transmitted in
+\field{size}.
+
+\begin{note}
+\field{size} was previously named as num.
+\end{note}
 
 \devicenormative{\paragraph}{Configuring a Virtqueue}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue}
 
@@ -278,13 +287,18 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
         be64 queue;
         be32 align;
         be16 index;
-        be16 num;
+        be16 size;
 };
 \end{lstlisting}
 
-\field{queue} contains the guest address for queue \field{index}, \field{num} the number of buffers
+\field{queue} contains the guest address for queue \field{index},
+\field{size} the number of buffers
 and \field{align} the alignment. The queue layout follows \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}.
 
+\begin{note}
+\field{size} was previously named as num.
+\end{note}
+
 \subsubsection{Communicating Status Information}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Communicating Status Information}
 
 The driver changes the status of a device via the
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

