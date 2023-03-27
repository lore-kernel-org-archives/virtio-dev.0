Return-Path: <virtio-dev-return-11800-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92751C76195
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2382A1CA274
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0CB6E986597
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DC0EA9864E5; Tue, 28 Mar 2023 00:00:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C43429864A4;
	Tue, 28 Mar 2023 00:00:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLt3s3eEJyUQpCg+W+EZId3BO5L0tHiX+T/1AoWwx1K5OFETE5oR7AzvZcCWzCDZXxJD0qsLL+5i7mNRSCDqX2AjfSZth8yaP1j8qrYrOUBsdeiX7CUDTVFl5mjG2qLzekUJa2QmKtkn6MVFFe7qz2Yxbt6YN73VJZwcXBpisp6j0d1YHTkuBDMbi4MxYALySd8SJdWxQcB/O7WZz0gLGcvQMD4f/zLMMFbRR/f5Tqyzq+qdoki3tcJYbbGxcX9lQfWhmOvHCs6Ibey1K1cQC9SAdpY99oLazhvIkIUIRWAUV5R9P5cF0PMroG69RZlZOWYMBCPHVPco43auSrYb9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=airtlll1gtet/B6KKmqxtGiV85mQTkCQdAIwFUWD5bo=;
 b=HcUHHaWSQsJ4r2839KjL8x11W06BqsdAJU2C2K27U1eIiqqlNwlOEsH2CV07BoUiMP3l8Ar7/sgz5laTPZ2MYdjy1C2vaZJ+5HeH1b6KLgyBWVmAr8YuOcdfdo5OfV5mMRLqwAzM24IGh0zNUJLjYK3+cbmJ70iQUncRrwyndWzHMqK0weQGjp4qFOY13VJfk0UhlSg10cYU5KS9jE6j00u+6BXvgk+6cZPq0JbqbdD6BQF5yZAEpL9YpQKyXKoAidV9oOOZzGVmZOG+FY2d5qiGF6VJp1WqVCKXFEPoug//eQH+gpk6Gy8rDhPIwlrdqsngY+yZ41OYYFJ+f5nkHQ==
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
CC: <sgarzare@redhat.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Tue, 28 Mar 2023 02:59:34 +0300
Message-ID: <20230327235936.414196-7-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230327235936.414196-1-parav@nvidia.com>
References: <20230327235936.414196-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|MW6PR12MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: 50fa6d2f-6b96-4e17-c50a-08db2f1f6526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5j4pR4BoOBiWzkTYWcpQ48BoHIIdnmoHF4crfT4K3EznrnWEBUrHt0xL5HnxC3EMXXKrHDycPiPp3/5fxvS+f3on8hBKrfV3W+Ye9cNnS2JHUHiUIoyfiadSgWa9OUbdsTrNlf6UBNtbmG3DUTbF8YW2JTRgzH0NY8brXmPgeGgG3aA9ylpiUyBxzOCtlxCi0MwyDtRt283s85MhONwe2XD4sgTwesOUWtdNFapPNHSuqX5PsEmiHwv91MwQ01QjJsRrtMOF7a9cy1My7Dc7ifqC3f7zXR1hYQ8FU4ERJ9b6Wc+OufwCxUI/IJQVd60pICwm/ubfot0bjkiD1a6ISGcqvW0sdX4wj+sN/IcCVTNIi+VpuFCUHWlVFafe86xj4RGLrjPMQh/cRH5AK2LR643NOSGNZCp1GgxnjGvVtNIxY4Bo8a4UgPlTf7YTlY3hwjN/OhyrU0PpMyFqwhU8e5ZUD07UhW4lwOdckC4hIhNAVnj6smguCmKrD2yjrK7YYfz25Mb8mGhFiC3brZwPGNKWqfShKTysRZ7cAFznBoJFASTVx/clH1gxFmgQRe/TFSTBYq8cHad6zQN0UlzI9nb2FIcxbQ/qZPyJ81h+9ZjiqMcviQW+qaSkmXclYi+lPOidHrVF44edRs5pCkXD61GgPaawOoBb2sqxi8mzVry24rKUyD217tACwW7fkevcTc5P8cdx8oCa0CkIGbl9F6Bvvd41cExZdy2Fk1w/I/UKQ199Bxh4z2Gl488AEU0wTW/NFR9DBFfF58ng7Wer+AU3LZwjcuQV22fXlzzyOSwUUaldVD+IkN9yMbhj1wpJVJnGUDg/tnAfpoN8OJ2LAg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(86362001)(40480700001)(82310400005)(36756003)(2906002)(40460700003)(478600001)(107886003)(966005)(6666004)(2616005)(426003)(336012)(47076005)(54906003)(4326008)(83380400001)(316002)(36860700001)(70206006)(70586007)(5660300002)(34020700004)(8676002)(82740400003)(26005)(186003)(110136005)(1076003)(16526019)(7636003)(8936002)(356005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 00:00:08.8557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fa6d2f-6b96-4e17-c50a-08db2f1f6526
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8998
Subject: [virtio-dev] [PATCH v8 6/8] transport-ccw: Refer to the vq by its number

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

