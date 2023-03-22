Return-Path: <virtio-dev-return-11728-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6950C6FD1F
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A9E742AD63
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A30F8986528
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 983C99864C3; Wed, 22 Mar 2023 21:53:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7617698672D;
	Wed, 22 Mar 2023 21:53:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFtE8v4X3jZ9kpaA1oVyX11hgfCsWrxCpuZK6ayAMGqa3S78912pJuET0GW36aQ40PsND86LUcbfy7cIiwv6Dk+NaTW29vNHBQQzVh/7P8QsCaHzkl6YVw/1kW2zerY6nKA0uXTrRmzXohvPW2LJXNv2V6B6pMKo9/J7FojJiQjbidqtrTB98NqLz44CXVdpltEPN6YCKY8xCXiad1ESqh1QiwH+sgZHbtfWiaIf6eZ2B3ZJrf/5lGJVZE1gxjtt2OJ+LPOrw8zeCRAdiHujJnexrz8VnrgwZA94VKb3blTxDvtEXyJmP4mz5x//zovPOX6hhYczA+g0w9O7Bk0zTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=airtlll1gtet/B6KKmqxtGiV85mQTkCQdAIwFUWD5bo=;
 b=gR8IwuCPE7qcvl9/atKZz+w51j8etbjUgFlc25RmINv1/NW38QXd7U8OjIqFmnMTuJ40xBwjWnbRDkBVUFcCKnpZANtuHxOaIagmCBwSIqsnShCoN134FaxdR1jrOdIHOqxvJelWaQGhb8hvvz6qhkVyguafybk+jwzlqLZ68WK7PZtZgAbzphK+iUKQFVyyRo/VLigFRmA4wJAz3bRKfx6BHuSqRV/x3fiJE99QmF7ePPcySOQiIJtQFlutAo6WUJ1aE/rWxyuwxXmXor03eB4uxRI+InVA8AQ7xdblinH5ZDw/UuCgchRQ8aJbLLGlDm324OARKyygCZD2aRgAhw==
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
Date: Wed, 22 Mar 2023 23:52:41 +0200
Message-ID: <20230322215243.249524-7-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230322215243.249524-1-parav@nvidia.com>
References: <20230322215243.249524-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|DM8PR12MB5413:EE_
X-MS-Office365-Filtering-Correlation-Id: 590327fd-b2c0-43ce-3e95-08db2b1fd3db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2odHIjpSWdw6eaUPiZHplYq6sawN3KK0H+cRKgdTk67Q7McpNvckF470eOE2EE0kb4aSnNXq+QweehgOCBKpcgt0h+/0B8DyRv7fofAou1eBz764xTEUBJCs2YEsR74rmrmibBtbRlHCdl8FkYuTUvyFnnt0qwtbMARqIqk6wXZHjQ+dNRqMCX6zOeWos5zHi3j3mDy+ReiQAJgdW65EyHM/u4GdjPJmKBvsKhTpmkK7VRJeXYafQiP5/rx2YnfYMZEs7/HJIYCHu/eBfjHo4ZLNGkni/B32OooxSKSYOOWlexK99JKnRyYz10DWdVct4TD0/ixXZAyyhU7LapzQ7iPyrqGFCQ080XNjSz6a9v4yWE9apAfQ+Zij8eGCkjJ8A5bRToh04pOkLvMXoCUFRj3U0W8LOwsY3ttYAMBC5sPjHhbvt2tzU5YyNS7E+TR8MT3ZsXTBtPlGvbtczGX42e0mTRFWWa3t7xJwonLqecCPRGx7vY8fHzGrBs03RrVhYK7maY7Fp+Vnrn+avUEIbAgY1uEySG8Z6V0oKwElQHPpLut5enb31H7+X6ZKK+0rwN/I1ubJOLnYPwDD6jKMNjCiHdmJLobqtknsioRLSdtRDXFaekr03awy2YH7SEdvumv3doa9fQjGqfQnIO2awd/d0CHV4a0uVs8c8ZKYmf3jBnMlkaRh7nH7KPRmmI6WBAhWrojoJOnmmXbRDUItw2pgKfjkw/ukv5MbkuQR+Oa0Vg6iAMIIcjuU5rKh1zDDoE5VtvOYAofRCjKFaHWF3vBffmtQ7YzeVlVG4zAZc/g=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199018)(36840700001)(46966006)(40470700004)(356005)(478600001)(7636003)(2616005)(110136005)(316002)(82310400005)(16526019)(186003)(2906002)(70206006)(82740400003)(8676002)(70586007)(26005)(83380400001)(54906003)(4326008)(86362001)(36756003)(1076003)(107886003)(6666004)(40480700001)(41300700001)(5660300002)(47076005)(36860700001)(336012)(40460700003)(426003)(8936002)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 21:53:09.9836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 590327fd-b2c0-43ce-3e95-08db2b1fd3db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5413
Subject: [virtio-dev] [PATCH v4 6/8] transport-ccw: Refer to the vq by its number

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

