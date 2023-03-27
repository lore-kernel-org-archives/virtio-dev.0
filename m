Return-Path: <virtio-dev-return-11787-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEFEC76195
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:54:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 29A15370EC
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:54:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1AE4598649D
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:54:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0FA11986418; Mon, 27 Mar 2023 20:54:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 62951986611;
	Mon, 27 Mar 2023 20:54:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1hkXuKB6CM+JqysprzGWRAVjkylHnnLHoXXzvJ33BTQDyzME9C8SkF0weazpuO6L26HPc1wfD1fPIOulLE85t1Vq8Qb8Fr4Exivq99qT7D8r7L6nVM4AbpByyRklNhxQfFyj4M21okVDZW9JE58LNerJbDYymAY/ZU1ZS5NHX/r5/4XTBPBV/X80m2Wvg8dA5pDVhGHMFWCLp9S+vmNm9DNtYzbqa4CAxLpY5zUcY1xhJla9K6xYqufS/YD7/CE3Ncn/3rBKdKlpAqvMQxRRY2OatsRYJrGawBh7O8teLbzsOuPgQkVQZwpSo7bse+C8UX1pzLf7zP0SUZaaANLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9rv62A6GUE0xs+vJ9ZuoQfMlX6hJBVsIC9G2phIbuo=;
 b=RTgYFUgcXUwGatQ/eFmiX+GFIUwftrBRDxD1zEEOCQTpdUoHRmt3aEtpPCkMDsdE1FTKrAhT6Hey7BItaKmXXflbSklHFsY8mXGwOoS/vaq1iwDkXxUW3LLsjczXU5SOL97jXl6m3cCXGewRjRMSooEYfaJlhRjbZhzJT5lt4HeMZI1hen/k1Ue7r1aY8AoOrpBi42fWapfBVt6jGbcgjKQvwtyQ3pR9xAYtz8EQFMBEiJfmqmZBXsSTlIumCIMa6ApuOuJ5ChkQneicgkyu0pYm8FeFfXFOwCwG4U238fvU4FZltZAw/XTSLDewxNG4DFsbdeFPA0SLD/2pgyRkQQ==
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
Date: Mon, 27 Mar 2023 23:53:56 +0300
Message-ID: <20230327205359.406605-6-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E631:EE_|IA0PR12MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f9e3f0-762e-44c0-2381-08db2f0573cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6F6gGUakNnV7asCnKTKs00kQKoYHJy5Y6eQI5S2bV8TbPu8zYmxKc4Ki5tA9Gt2vLQuNMOFOeU6PeTC+MgsMxWjb3GzZnMmJu+TbW4rMSNZ9TQU2elPoMD9KwpxP4QjuzbPK0cdV4B95zpeUZJoT4eHd5q6nTLeKB0l01pQ2sNccd8dmVe3KHFommhTK4FGWdlZZ4ZUR4G3YNCosxqTnaz7Os4UE3w+n8jdjlTK1X71nRKZGzoSxI3AmAJsKybznkwKjHaaG6cYkw8VLpmeV6Tkz/s0r93n31hAk0+DKP+zu6GcgfOyHAY9FKtjqqGffSi/BvjTfLfGLImZO+zdvPYFM3yb2PtV80uBzs/Kwxyzqor5S1ud8zXiNU8yXikYz6u2m80eZXoSqE40LRy2/oaISDUP/OcB634YGG8LRAW2e/nWM+PsaB3xLeGw8oUIuynKZmuvxtGKtJ3JBw5mIAsrarIwyHXaM6TZC5STPsPxP/VmHY2mJdBas6bxsjdGf0SXX9/BPV+CnMI/QS7NESl9S5o29Xc0TVdlzhMx/8QDexmLaQW/NzuIyu9IHlutdwtQYsWV8sSgJ9krvpLCZv2AHFe3HJ9oXqMGecaJdpxaydnOzBz1WF5eCv11gNpEIUZopKgeHGRa75vR4fQu0QnR9EGcu/BXiIjVIp2boOG+36HeKCcVdi0FYDuaqaSMGFSced+xITTknzD3TNQYVAryQ4uE8ly/iBog+WSrjsk0e67MAtSWJNAFDTjO6uYqc7nbF9Uq1zl4jv97lhNlCzJf4CuzolMR0cFw4VwP/F9A=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(16526019)(26005)(426003)(1076003)(40480700001)(41300700001)(186003)(6666004)(107886003)(966005)(83380400001)(336012)(2616005)(47076005)(478600001)(54906003)(110136005)(316002)(36860700001)(40460700003)(4326008)(70206006)(2906002)(70586007)(8676002)(7636003)(82740400003)(356005)(36756003)(82310400005)(86362001)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 20:54:26.5685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f9e3f0-762e-44c0-2381-08db2f0573cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0000E631.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749
Subject: [virtio-dev] [PATCH v7 5/8] transport-ccw: Rename queue depth/size to other transports

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

