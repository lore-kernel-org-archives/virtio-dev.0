Return-Path: <virtio-dev-return-12291-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F65C77B76
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EB9BC77C07
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 687C898650A
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 365DC986712; Wed, 19 Apr 2023 01:47:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8D3B1986659;
	Wed, 19 Apr 2023 01:47:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYvs+qD8mSdBZMQHyxn1PyiGiR4xHCWGR4X3h6NNKYSlGoKXisZ0n78FluQxEYKwWYrMXaF/MQPT0WZYkCSWaIwlUIuHQtPLKMc9xDqd6z6dae5G8B8sBvO+JE8DUA0wL/1QAjBSfjSILe/0v9E6dK9luFE+Ka1zaLt0rwsJXOG26fWzb8gYV4OVxwjKNCcJCyEJYdAZ8/biShSym0hdg4EBmhIReVqzBPz0ivAll31T0n56EH1Xvvytt+ETPkvza47yoQ+UY8TAAvxOmfGTl67ij5f5DV9eXfP79wwxZ1VwBcQyZLynjfZ61L15MxzNQjzNxKhb8UIZz4lt9mryrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9EKa//6z7Ixgq6+lg15Qmmjc67yBf4hxC2DHEpVvLA=;
 b=T/c0HOdPFn43eY1IQiYHNNSbd6d1m05ozGyS+P0C1XaNDVYIbfs/079804HuDPzUKyq68qUiutSYkhnZclu6o1mp4rn4lpS/YoXQggbflYSwbMHpTA0z0gagzbdAmHq3ZqWy2lRv+XKARDye1fcfQkxHpf725uJ/8lJxXsILXAZwsXaobZDq8ciCSRGAtLsbjq8J7oqBUes5TDukd2BQLr/Atw9dG8AD2j2ETXVeEIypmRByrTxN0aLsqU1ZHV6wUknCj052hahD9bZjfi9gUmNe2TUpPzy+evIMp8cj9dLLiM+8jw6fe1MdSMEZMzzSFa9g6BEsc8C7OVvyVCVzAA==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <sgarzare@redhat.com>, <pasic@linux.ibm.com>,
	<virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Wed, 19 Apr 2023 04:46:35 +0300
Message-ID: <20230419014639.919458-8-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230419014639.919458-1-parav@nvidia.com>
References: <20230419014639.919458-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|PH7PR12MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b902db-4696-4d11-9c76-08db4077fc81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5FDiieajCS9CO4hAFBD4yYuKJtsxRba5OxZY/1H9F5EboFPXTJ+6sXoDYZFjLGkW8xkYhDf5E3rXZoCv/zUIB8XGiFDFD4P9FoMUnXt8pr7YO2u/o4pIvLj8EOgtj+xM2vaQ82gu7oqO948+o7+F7tbBOMpemp20SQHh1ugKleo+/O3qqvgbiNyiREup1nw0nyC6aflTkTW6f2+fU2ZHSBl8uvj/lP43StqAXFsmOU3jl2oiBYIO5mDuFvSMCu64fpwtA118hGYudbP3WErlQm596HpDovGu0QrQtnX9ZBBtI+SMKEY+/CubS8TVeHoIH3r0aRUFWwlFlQnOU+f9/GQ8eDwxHhpm6vD0qvVk7ooSf4JKyc0OnoEOuwhbK11FtmkCL7U13LkodwGwQ7sX4bIFu7QDhtoQv3qKhqocpRZv9rAohOjoZyusjrVPlWeHDfoYxkIlLcly7rbEpqeCLHtgzq9Qw7mz1pJ5vJPCdPA1l3LSbeyillOa5kRDbuozz/MLU450lYwIic5WviCe2UOLOKRX7DAtk1ouDRtYAd5FAIz8UsmX3lBk2AODchV4ybJJYuGvHhja9Qggilwwck1RkUO+Ogo1ah9pqwnSMAQmGiKJi/5IQab83mwpTdzu8HUx/QcgROVBKJ9NOwKNeRGufSt9EH+WE5Ly0bkDG0NEVcxbDXBGL7G+rUc1omO/8zXCOJF2vsM1HaHerV6p9Q2oW0RJPdNw2cG0QHTsf7WSLFOYwXR6GGb1vEP3VEQiz42nqXoDfMXc9UinOA1y3i70J/AgL2pJ/R9b+3lfbHGa6mrq1HKDSFp2t7v9GINrQs+ceJflLAaAW8hGHRj7HQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(34070700002)(478600001)(40460700003)(316002)(54906003)(110136005)(5660300002)(8676002)(36756003)(8936002)(2906002)(86362001)(82310400005)(40480700001)(356005)(4326008)(7636003)(82740400003)(70206006)(70586007)(966005)(41300700001)(16526019)(83380400001)(107886003)(426003)(186003)(336012)(26005)(1076003)(2616005)(6666004)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 01:47:08.3133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b902db-4696-4d11-9c76-08db4077fc81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831
Subject: [virtio-dev] [PATCH v14 07/11] transport-ccw: Rename queue depth/size to other transports

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
 transport-ccw.tex | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/transport-ccw.tex b/transport-ccw.tex
index c492cb9..cb476c7 100644
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
@@ -262,7 +262,7 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 \field{desc}, \field{driver} and \field{device} contain the guest
 addresses for the descriptor area,
 available area and used area for queue \field{index}, respectively. The actual
-virtqueue size (number of allocated buffers) is transmitted in \field{num}.
+virtqueue size (number of allocated buffers) is transmitted in \field{size}.
 
 \devicenormative{\paragraph}{Configuring a Virtqueue}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue}
 
@@ -278,11 +278,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
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

