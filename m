Return-Path: <virtio-dev-return-11693-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EE8C6FD20
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9777D68473
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8DD1B986463
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8354E98643D; Tue, 21 Mar 2023 21:59:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 312DA986573;
	Tue, 21 Mar 2023 21:59:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awmZh/hGPjwKnnZzDykgYFPANH1ME+TMt8nCCno34G8hydnJNth+GtbeyuDllkE4phAVg6keq6Tea3XKIZXo7NFpPnEGaARgljpCINu2NZuclRdIr9Eemj5a6fgLz5XnI0ZM0NXZc/3TOUv1ByoMl3XN7AFlDaw1SzFn+EiqC9UcLC8Ckz89FltWv270f8XABnfscA/ukwUX53DIO4t3kSzAq8qtezEmpTFT1OUl2ooIYfoJsXZbqAdp3v/oZyQQ/vNdxFMOvUD6G9Gwze175rtYSlyaT2SZ51+ydXJFrWU0a86MaFXtK9mxf10rgGCJcxHlH9FWrnsgQgnKHoCYCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjgNCV0JXv7LHdfBOnCVYKnrVr4fqW1q8ia6q5iNhC0=;
 b=S3vlp0w66A978oZ5EEhe6Cl4a7uuVcg47fvEjnWZIOCiIadhEDQ+j5KDlQSDd3QD5Z0tucrpw3qraI0vYdiI2tAld1aKiYMG4xNyzQ0Mt1cSxSZONwkfBVYUwxLy0IpIxDNpPlUOAallGx5wTJ7DoLfZHtBYMHHWYYYKQTbfpSI1ZOQa7hapr1dZn0L5mt/FPnMNIZHZ92+8IZHcK686DqG91tabkvt9txoOWJwkHOKpSN8dx+7sgZ6mJkV9Nkm8jFSMrz4EWhIUwXzkYVQHO/5QuD8G4dHw14HYFIGhTLnONkZ46pDl6lUQ530iCsO6F4exwuNAwnRxudRrKhQgkQ==
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
Date: Tue, 21 Mar 2023 23:58:32 +0200
Message-ID: <20230321215834.225856-7-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230321215834.225856-1-parav@nvidia.com>
References: <20230321215834.225856-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: c70eac00-4df4-4c46-0dcd-08db2a5781ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0fGazK5LOj6dcVkXioo50b6IJg8EMv3FJ6yDgDiCS8HG8zUfkuWORE/uvnkv7Aj0fKWlRggfuPZAHRFLUpp7Sxsn4DB/dvNvNk7w+xyIxad8aunykjYSK9DrW/99t+bGJTzZAh26D23EqUA10pF7wcJZjMyOMKJxcS2TR/44WsvxX30QZpjpYSeEWElJTHCiPFZlRjcM2BxPKhlecqpgIvj7hbuuwsSA0sRbu2ed9R4X2lGn3mabDy9WY5x04YZSkmeueqSvRcS+cpsc7DwITvqlg139/3cjyCu6xVtEzh9dqsWh5lOcbQBeKE9QlF6VTiFRdHh5xVUwvBzhrc485F+rkOh1LGS2vLqhazNBpOfYaqER72kr0zLIWTiu3VD2ar0CjdwCYI8AOdkiNr9/n8JE5M5pkags3NgZjd+RAaqoZ8IJxyU0469BgfU+Atd8qLJWAWVGdQS7gRxXnFMMxP1+7rhBLRIdDAj/u+tWS2u9rzaZjoWG4Kg6NzvOgKax6NChbzDufxzx8151rMe0GmhCsxHizoh3u3WJ7fAJ/h3a/6AYPZjDUyivdlIK7/ElpUk1BnBmnQ7eLwJMmgb8u2UFZLlqvPRkIoPQvyknElttZIP6Q2IOZTT2HZV0prtP9hEJaqpyc6wBLMyJve1qXY0bBVA2jVZ/LUhJ134iBudWBYx+kPiwAl4qklqRcuYLjgovqJFph1s0JrUNdO81dHWtXZhdd7PR87BlErLkm1sOTWvY7gHTegsA2kq4FFRgkCU5qqznGZIG2oiAc5aI+bhn43TnIAUrdFqM75WyS0o=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199018)(40470700004)(46966006)(36840700001)(41300700001)(40480700001)(8936002)(5660300002)(36860700001)(356005)(82310400005)(36756003)(86362001)(4326008)(82740400003)(2906002)(40460700003)(7636003)(1076003)(83380400001)(16526019)(478600001)(6666004)(107886003)(426003)(186003)(47076005)(26005)(966005)(8676002)(336012)(70586007)(70206006)(2616005)(110136005)(54906003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 21:59:12.9780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c70eac00-4df4-4c46-0dcd-08db2a5781ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601
Subject: [virtio-dev] [PATCH v3 6/8] transport-ccw: Refer to the vq by its number

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v2->v3:
- added comment note for queue_select similar to max_queue_size
v0->v1:
- new patch
---
 transport-ccw.tex | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/transport-ccw.tex b/transport-ccw.tex
index c2e60b6..880b87f 100644
--- a/transport-ccw.tex
+++ b/transport-ccw.tex
@@ -236,14 +236,18 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 
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
 
+\begin{note}
+\field{queue_select} was previously named as index.
+\end{note}
+
 \begin{note}
 \field{max_queue_size} was previously named as max_num.
 \end{note}
@@ -256,7 +260,7 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 struct vq_info_block {
         be64 desc;
         be32 res0;
-        be16 index;
+        be16 queue_select;
         be16 size;
         be64 driver;
         be64 device;
@@ -265,10 +269,14 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 
 \field{desc}, \field{driver} and \field{device} contain the guest
 addresses for the descriptor area,
-available area and used area for queue \field{index}, respectively. The actual
+available area and used area for queue number \field{queue_select}, respectively. The actual
 virtqueue size (number of allocated buffers) is transmitted in
 \field{size}.
 
+\begin{note}
+\field{queue_select} was previously named as index.
+\end{note}
+
 \begin{note}
 \field{size} was previously named as num.
 \end{note}
@@ -286,15 +294,20 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
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
 
+\begin{note}
+\field{queue_select} was previously named as index.
+\end{note}
+
 \begin{note}
 \field{size} was previously named as num.
 \end{note}
@@ -583,7 +596,7 @@ \subsubsection{Guest->Host Notification}\label{sec:Virtio Transport Options / Vi
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

