Return-Path: <virtio-dev-return-12138-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB3FC7619A
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3C7D71922E5
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 328889865FD
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 27341986371; Tue, 11 Apr 2023 19:24:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 15D8998638E;
	Tue, 11 Apr 2023 19:24:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iawTrotW9Rep9MItJR91H9Q9wsU7DvMLNJMkD2Vrj7q5f7YyyHrupGD8BPGKSP6FIBNOhF0o6QfJXcXIvQ85+sRuH+ofSb8y4au2gXtyINW1g7abb5ifgDpqQeLiyzorlJK/shdk2a08AyxAJqix8lqWk5SbCwvsTRoXXqA8jDqblEASlWLS/l+KLcJ25wFmKEp8vhTA64jFfzfAOjDTLa0xP9HwwVfGP8VmEWXilN0apPmNVYkpU1Ctt73tWLMe9VSTM7K9JqVoJvYx71BLwQ19oppK7gMD6fSldQ1nApzAJGqAPdb5TDXMXIMrxlbY5zW/aapWMIcaQQxge6/QXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9EKa//6z7Ixgq6+lg15Qmmjc67yBf4hxC2DHEpVvLA=;
 b=npjcrD+eKU972qKiB/eQnxvOLUJjEgLdC5+c2lPrUIyRTZY8A257ChkKcP17hrgIVP3Xx3g3RGqRjy5vqBiIilDsUVG0cOUViAC9eIj+GanSgUIfhARS42lWaG13PAohpSJJcVqOVnX+05PMFzijvwwaF6WFILRYzIR3G7HF+6aKl88mtm6M4hn5xu1CrZsOtEmomx6293xCFjqnREFlm86fBJtN0l4neZyID4ILMsJxD9GaGqVSywWgp/EtOsU2uc62YdklXuO+ZO4Pt/xsZGBjeykpFqTdwmCOp8yS++pFu5yh83FbOczGvL/8YYKj36zBiDVC4FwMzIv9uAYA5Q==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <sgarzare@redhat.com>, <pasic@linux.ibm.com>,
	<virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Tue, 11 Apr 2023 22:23:37 +0300
Message-ID: <20230411192341.751841-8-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230411192341.751841-1-parav@nvidia.com>
References: <20230411192341.751841-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT098:EE_|CH3PR12MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 73847145-4fe4-4d6b-b7a6-08db3ac25350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YIvBDR4Oq03LgESGziysQJ4fAmulOWzjKbSl9bDmBUkHBRhJWMu+rijqHIdNf3xkoZ5u3xHgdlQY0+y0nSkOSi7wL49dwOa7aJSOTfIz9uDdWvabfdRgzOloMrLuD0dhOhlz26XfPoPVV7YXW2rNHdQkNE1Xh44HE6gj7YhvKncwtTqodv2fr7MXiNOFGlTbk1K0tOJL/9IMfIjY9nmVhISOQAbWvljBFNwvSpi3xn1VhlzM+UdKtolOIDvB/90GPGW3SuLjPWD+bb2+tteXXubCue6dx5EmSVekwPr98tbAMrJg1kAaBeRV52AOaLwnDvzzEwnjy+TDd9NvmeoNqqUqtTB56lFQevZFEbkXkvqJXErAMRaBmrVgYaMhTdJ64PdjtwqRslFhs1vqH7Z8yrh/EcRMrrrvQNfka54OOPod8HHEq+yXc7wnm4mGI3CYzUg+cOBHz53xSpgDeg2uOFitJaLCp/R+H/SHG8QiM4gPQbvZhRyAlgxXBkOyjlK6prZNfsjlybZz5sTK0bI4QuM0o8HdeiIQXj898pu7HHivVPf3CN6ahBD+LnopGCFsfazBJptaWdEZB97Lr8jobIwjcs26DsGLI5qcSUPyYfwnEsdva7IQFDhXneqSFu4y1Ip5gJBlAOp+51VpbmYjTTXW0FNq/rZ5jc1df8oori7TGLR28dQs8ntsmdhwjKs990V9tp87NN5CWMp0QN/uXFOjIpQku7GCWdiHVcPhxYoqX9jUv0+NkGqVGX+DYwOUwuMOsEUORutNyrzQ5cIgm1U1mRK3QXGnacaQBEr9K7TV17DTQ755FyqFjd6NHlwBHfsBGMKOc1FWFBoWzOKGvA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(7636003)(356005)(2906002)(40480700001)(86362001)(83380400001)(336012)(26005)(82740400003)(16526019)(186003)(1076003)(2616005)(426003)(110136005)(316002)(5660300002)(107886003)(54906003)(6666004)(40460700003)(8936002)(966005)(41300700001)(8676002)(36756003)(478600001)(82310400005)(4326008)(70206006)(70586007)(47076005)(36860700001)(34070700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 19:24:09.7828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73847145-4fe4-4d6b-b7a6-08db3ac25350
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8484
Subject: [virtio-dev] [PATCH v13 07/11] transport-ccw: Rename queue depth/size to other transports

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

