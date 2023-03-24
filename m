Return-Path: <virtio-dev-return-11760-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43412C77B60
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:06:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 298C042A76
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:05:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6DD7A986B2E
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:05:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 723B29869BA; Fri, 24 Mar 2023 01:05:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4356498646D;
	Fri, 24 Mar 2023 01:05:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAsrH44cyVihD2oPHQ7rVWtMfdxhkKrPazSAFZVa1cjtGr308jUc2HIoVK5au8ve2OpFoIKOMp2NUkdfJRjBTP0rwqL8N4AQBXJG+rzd0MDyafWAXVrsuZSED0a5XB7hS/OR3YyhaS9gQKumV1rDLFL3oTVxMWv9wMF5pDMfTlR4P5vZyXi3AY2B+hYk4Skf7PPiuGKMQ4hlHOdWyxYY7t/bsp+1TypNPWdcKB0xInWN5rCycxYdmWpYqq3CHYuZud9GbAQuuRg4GswrLfvtX4HWTnSNSjVL6dpFDoQRmFLzlXwEW7BAWAHl0dBSH3AicFj4at1FAE4GIr7Mw8XemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=airtlll1gtet/B6KKmqxtGiV85mQTkCQdAIwFUWD5bo=;
 b=ZFHoAMDBO8rYRgoIhF/ABbCam1C07eCXyKrQlFkXUpQ1QC5XUm2aIBBZxg7SosJaBiohv5+tF2CyBhXcLDJCNSLzy7hohjch9UVj/3wzH0XHHrIjDzl+n+JnfeF5tYp1lgPrJIOw1n8cjI5grO/WiksOFsDG834EJeuDOJdegL0/dRmCHJc86euvidKli9CmeOTobs6qzE5d7NxKqn3X8Hchcd4y7YA5828CLpxNNwgOJvfC16UiPEnRoQc40DVUdugB7LlXNAHLA3FaqTpb7W9y2WRact4hUxKagJmMCxroqVbtzmDo4lI4NwHzGEJHGJ0jou7VeIEtBDhTc0w7qw==
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
Date: Fri, 24 Mar 2023 04:04:30 +0300
Message-ID: <20230324010432.280330-7-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230324010432.280330-1-parav@nvidia.com>
References: <20230324010432.280330-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|PH7PR12MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: 149686eb-97cf-4655-ff73-08db2c03cdf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qrJQh6kCIw24TIQz25BqomAx41uZcl8I+ja/Vm/cm78Nmqmlrf1OFp24LxISnLhnIrjCGs5pw06Bpfz/KEGHsFIa4H3tAb3VOU8j6c3qmXU2qAhevnRM4MiDT70G2iqjZh0ChF0Qv61tzoZDRjxT37xCQ6pUUmklnOhqDGAKc+HcYhv9DwCRlobA/DrGFh5b64LsGErYXG7jYfCyhFA1BS1mPufqGFi7p2nlKP8C0qc5TiZ51fSsFJsOHxfDxNunknPEHHlWLULY9Dpm0A/xEagA88NK/jjGKZaLa8s1wzcj2+kJedkJQvYpA67x2Mj5g86gKqhkwHK/Nx4yp2c81sxtaLRin9nZxaClo8SOVY8Ej2GV5AgPh1aAxkkzoJoXAdD84YIJz3mex0NE7meRN49EukQnkYQcnZgOX4YpR09I87CcKBkEw25VyZOsLQfYtzXQCg5V8ICA1Edqea9teyx10Vc8GIoKkCNflKc4MWm2Q+/ZEfBldNNRrJIN2sgn6Z11Ql512Wyn62SLzuADChE+IhsL6rGdIJs72514eieGfXhfnFHjBiOnR+V0SeXog9vq7+neoiW6sgfiNY4DpQ2To0uYUQSSTbISbhVcqZCce+OjpyGYh9GBV22rc5Cf/EzjClVX7Y07vi6GE35h7JWVu+MK+CVs6zz5g/fQYkWNfjIpC0ojbs8ShVA/WtfULRBPEx/qqt5KybcUl53y+WxqCFCLOpii7ekwmSn9TYoezrO4Y4M5U/JlS+3FfIVloN8Jx09XDzSmfPG6ydjSgIEYeivEzf9IIflLA6ffS1M=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199018)(46966006)(40470700004)(36840700001)(40480700001)(2906002)(356005)(2616005)(40460700003)(83380400001)(966005)(336012)(186003)(16526019)(82310400005)(478600001)(86362001)(36756003)(54906003)(316002)(110136005)(70206006)(36860700001)(8676002)(4326008)(70586007)(426003)(107886003)(47076005)(1076003)(6666004)(26005)(8936002)(7636003)(5660300002)(41300700001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 01:05:05.3132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 149686eb-97cf-4655-ff73-08db2c03cdf7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6612
Subject: [virtio-dev] [PATCH v6 6/8] transport-ccw: Refer to the vq by its number

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

