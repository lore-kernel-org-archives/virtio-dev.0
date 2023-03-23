Return-Path: <virtio-dev-return-11742-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C03C6FD1C
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:01:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 621451CA27A
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:01:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5C18A986727
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:01:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 30D5F986528; Thu, 23 Mar 2023 01:01:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 204CF986732;
	Thu, 23 Mar 2023 01:01:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUlC2qWvMhkjiNeVvie1J8hR0EGQ3aEvXMp/z+88UWbu56FZhLsn8zTVLx+U1RcpjAevxF2T6oG+IuHjIckPQZAGrc7OCjTO+ViNJenLquJuYcrwKFyKtkVIKqPpHYEbWNt3vxdel9vwekgbmq8pWIfQS6RDPDr6d/JSC7gAHCwHV7YPoemw2kLf4yTsg8pDGkAJ2b4AwXEGjofPZND1PQkswv7Ls6rmUn9knUFLh7h5xfkgyMZNT4HBVidBzcg5SKy1d+tXWJebvyTFIrgmDflrI1/h135hkYLaSvXUevJ9dXg/XafkfHU2pN1dwANo5pPUxR+fg/ZXmrmJIvA8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=airtlll1gtet/B6KKmqxtGiV85mQTkCQdAIwFUWD5bo=;
 b=E4WjTlXYRablvWkcY47pSq9a25Nodoygby8vGlSaj2uISJELCab/VpCT7XjCFIxdNVIdg/6bNzHVRe4H07zLU6Uel6iCApZEe5OPXRNJa6uYExxeHnTw7XDXmOSx4iQHC+HTaW3TS8p+XIDm3Lu+Ybv5dIUmTBNq/nNChWWWZ8NWMA/dEDLdcGpoqPSPN/pb37/7bg117FALOSEqj1mH/SskrBw57acqkH+EVnQICad2xzZCdZOQ/rsuesQUec/z5+TtjsQ45lhT3jjKxYChSTJjf+zDeN9OHpNxSIU5z/RfOYzMM4KVA5CdQzAwJCg9dW5UM0EHSJvirhE4uYAY1w==
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
Date: Thu, 23 Mar 2023 02:59:42 +0200
Message-ID: <20230323005944.262738-7-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230323005944.262738-1-parav@nvidia.com>
References: <20230323005944.262738-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5F:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f25bf1-2ac6-45ec-8261-08db2b3a0208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QOvrX6AGXXxElp8eF8Xek9EaDbrkZhPxbIrDUBrAot7x5FKkL4oJyBUplISEb2aYBUH4PwlUB28rahnG2RhZItpOEgE9iDsaV9NmSQv8uYrbEYXYk//kXQ5Me93idheNnYpbZ3yBQmsMRVxxzMJ+dFLu/aMht+jHyCFGlMr3DXiwVBsF3kQ10jlsdN1BQZMA7T/zwLi8ltmhwrM5N3j4eSb7Jja2OcW8+AXBDoqy0As0gsuR+kOimQKbdQMSrtAbqqcDotfy70FmYCTtV5yPI69DaTDgKJEX4rHjj1U50Z/VR75W7JfSVZc0KbzJjSNPHry6LgCvPgki3G3CP229DQinPLa0TLLX4Bq46T/DeE0bN2/L9hF/ynTH3C7r6EE2Jsy7J4JdcR7uLEgLQADzFlMrKRHbCq0kKY644gCcA7LUJ7LfP+NidwqDs4UpJ47ng7uxY/u2qilOh//yYanPOo8r7ZVbnhu3GOY3FGNc5TIBxiUZnLxImBBbRMpYDrWWoaykcOGFl+asv0ZrJz23vKIaYbxG3s+HoLDGWljVf4Iqa+4peaQNrj+LnJkYXqe34fHsNNDFfsLVf+CPaO2DAWl8HOlzaBgOwv4v9Nibzwk8HarI8tDtv0ZMwACE8S0klrDOx+hF5qIZVx7KKz9WqnQdftiruLO2xRT3xGQWxqqtUYCNA0R1QoWNBymH4fxB95sOGYYBguoTbjElVdzMXehLsRnmAzBIgCMy/frsWyl7tUffCFVkQsYHWqQtDT8x5JFNk6B+G9E06xW4sJuIJsCLvpW/C4JHYUwz6dFvcBg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(186003)(70586007)(110136005)(356005)(478600001)(8936002)(8676002)(41300700001)(54906003)(4326008)(86362001)(40460700003)(36756003)(70206006)(316002)(5660300002)(107886003)(6666004)(40480700001)(26005)(966005)(1076003)(47076005)(7636003)(16526019)(336012)(82740400003)(2616005)(82310400005)(2906002)(426003)(83380400001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 01:00:34.3547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f25bf1-2ac6-45ec-8261-08db2b3a0208
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00001A5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368
Subject: [virtio-dev] [PATCH v5 6/8] transport-ccw: Refer to the vq by its number

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

