Return-Path: <virtio-dev-return-11739-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7534AC6FD1C
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:00:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C6CDA41EF9
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:00:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BA6D19864BA
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:00:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AD651986460; Thu, 23 Mar 2023 01:00:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8C0CC9864A3;
	Thu, 23 Mar 2023 01:00:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkvSNXzQCU4JzHkBoOzMdgdZMSGQz4H+Fx6QSNL2mucgNdMiDXwc+2QxyXMKrM+YM7cBcdW2EH9uVxpcRzlNbV4XGzU+oTgfZnKG3tP8Omt992OXrqC/PUSzxnlONK9FX3BDBXcFAtIuiySdIjuDU5G0XTYG/JQI1D3uFlghLXE1EP2ujtzfwKzj9t+MiJIa5XI6XcblAq8+LZwbI8xnk/PfDidDglx33nWJXXtULVnGjc/WDonuq8651GrHO7b15dfpOOu8oaRIwMgoGhY5W9aOIp8YQebEG1+nC6XD+szUp+OE0EIA9MoMLXj+vQpzymQTGIgR3B16Aqj5rDmvlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9rv62A6GUE0xs+vJ9ZuoQfMlX6hJBVsIC9G2phIbuo=;
 b=A0VwTOswoa3HmGO1nJ3XXKlVq+x7YfYoe1nD473ehRcCmcJrK/ZTKVppn2D3QO4LfH2KOJz7U76X0cbQxxOBsl7irsgjJrSF8Q7R9lm4JVisOelmD5wGRVnYvU17sK7oq/GkNbv6bzqeS99XRy+imgfq3TfD69ag7Va0tthLtgvwfNL4xU3msSkYcYiLGsbkvFJwq+1m5u1U2Th1gIeaD6uOUP1LdAsO21vGM1qSPn5DLVekTm1ilAQCjjbz7yzfNB/pHtfngil3k/exmBQUOfYsDdmRUfuFvg6+AJpc/W41DTRI6pxqBVcFo2/HAdZNfoptVEz7UVTYHME0wrD7gg==
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
Date: Thu, 23 Mar 2023 02:59:41 +0200
Message-ID: <20230323005944.262738-6-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C984:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0dd2ee-6131-4861-d553-08db2b39ffae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RRgYpB2LXx/FttMJM15YvazyVhxXitWVK0XtkNUHOCXlI38whFQYe6cMSxKviRL6ZnbMMTY4tbjeucS6QMpln3+SuCFgAKrfCP+/cStG5WAlSZjGBm1Gdg46E+IgTGF6/Z4w4IkSQX+FrKFJVhNjs2CGVi5AqJ35mGlcy2s+NPxwin+/YiXO7SNYh5h5HL1BzMsdKy2CcHlOe7Av/jZwktI3jS2rfyW3c8+AXgCVWyPRIv1S7jYpJOqDL6tlkaPWaWPf/4PC3ikymcCZSH1HyC6wMH51iCAFb7eWWawa+1Su9vemGu1CauhP5aq0ePwD5afoFYBVrW0OyjmWNp7azQM24tFfyBkbCkANpFwIroDhqKV0lCXY9VrA3VcMGJoF5Rq/TpWlBWh9+ik1tX3moF27titqFonntRFrQe1CGnzFuoKHKc19amPAaLdzLz/e7Q02i0WX+c2HirpgPg+wGTTK7sW+Bg1m3e/l1uP0EIjt/yhYdRGD3EjmOmE02SJ7esLAJcEYifzUJ5MnOtQEwWMw79Z0V2OYuHVhoZ3YM1r0+R4MRDBUyfwITwtgeYaUlMwKnX/CbBxwkuCRbpnG3rlgx7U2e1ZLn7uOnTmA2uWM8BYWIqfi8UzMeuw/B758sX8umSDYJzF1G5tKkT2E/uUsMJFTOHQUiQgqYKZ1YRvN2TU2+QmvKZsG4U1HhKNJNQBl9k4tT/bqozb/xVxcERMJxc13wkzz5zGc5HZtbHFLdYQRwefODHluc4boolRbknFdkXHQUbm3s+Vj3pmMgqbTuaB0+uTrrEIuLXjPHFM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199018)(40470700004)(46966006)(36840700001)(356005)(2616005)(336012)(107886003)(82740400003)(6666004)(966005)(26005)(186003)(16526019)(1076003)(47076005)(86362001)(426003)(40460700003)(2906002)(7636003)(83380400001)(70206006)(4326008)(82310400005)(54906003)(316002)(478600001)(40480700001)(8676002)(110136005)(5660300002)(41300700001)(8936002)(36860700001)(36756003)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 01:00:30.4741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0dd2ee-6131-4861-d553-08db2b39ffae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C984.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428
Subject: [virtio-dev] [PATCH v5 5/8] transport-ccw: Rename queue depth/size to other transports

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

