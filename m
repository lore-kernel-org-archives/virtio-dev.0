Return-Path: <virtio-dev-return-11947-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430ADC77B73
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:52:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B42A56E6DB
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:51:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A74B998658B
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:51:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9A4329863FA; Mon,  3 Apr 2023 22:51:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1C29C986739;
	Mon,  3 Apr 2023 22:51:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWlNADkZPAFkn3/OnzsQvZQyVGIKEvBtXBkm/sxRZY28jCetChupyFz1WZ7WthL64LQXAtdjP896BDraQ6C7/xfqVgpkoT0INzBbeI6yv5AYdEAN/zVH4sIVGBcDr2tENvK+dtMjSSUBcSrT0EEUYwGij4ydSGQl2yIJcySlGwXXJ6MjvS5cl3P7zLFPBJ6r5KqK59lwhEfaDr7zRuAbozp6kzUM60qzuXjpycvlCVnyVb7k7u0iCd5FO6iupohcdqlLdE5g5gtG+jtxLTifjvE8g9/ttmWvge0UD8NAE+R8WZZgpbaEVOoPHFDJ/AKv6vOsaNFijhDjQkSNuOtDbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsOW4RsZvkXimo94ffZN/zCDd6xAEYpRHeg5aiqWB+4=;
 b=mZ9tHAyy+Y5An9kiv/lhCBgRbxGxnuBPSV/lVusDXrSys4PorD1VEtj7f0+Zn3HL7WXSet7pafPdF7OjufukRnFdp9O/29RBliFwT4VSZhN+I0ZzddKOCCZrMYcBgH7tRp8e3mX6UaIEJaijdqlXASWqQoZLYWi5+7UZilANU3Ll8Yu7Qg3JmHPkrC8u68/HsRbFgsElhs30PSDCy7fF8+Hg+zzDq1jU0wf9D0WNsa3tQ13/RMl1DfkpY4qF/pqmuQ2SRdexkKOPuP3eZB5gsW+iXWARuogtuTIo+cNfJ7jgpeycNAr6pD7dFHqV8JMN2nnx+kVMn1/dAO4QG3rq7g==
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
Date: Tue, 4 Apr 2023 01:50:50 +0300
Message-ID: <20230403225052.585498-7-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230403225052.585498-1-parav@nvidia.com>
References: <20230403225052.585498-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT042:EE_|IA0PR12MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e80a272-cb5b-4d65-9044-08db3495f79d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UYTtJStBh8aGLmud5KT2fL/kT73XLoQ0QGzg9RUwg0laxwfMVhMlaE3vrJ1xDq+6/jKKoyl4OrH+MPcxqOD1jcKic8/DeuLvpG1hlnFh10FT4avo9UvVHzjLsYQwSxqxCwhfE8+zyPqQzHBry1WZdg8n5e1L2wmXPvrK8vIx2qtcNGSdNx0kAzGPIgAUsLTHD+x4NdlIZq3/Te89TCkF2KVvGulpzStQZLnpjz0U5bb9WV6PeniKvUXsPhq37xNnOEb6VZxJqy+C1uLopm2L/7DTXH44zVNRCuXwOP6G/hV4tL27qDfUt7i9aV9yQk9cLEmcza3ziEf6l2pTXm3QWXDWoOD7R7EE/HbjIyrwhOQbCbL/1ElMhH7m1iEpF2G6e+Od/aZW/f8Tkt7nYC2GEtCxZKOCrYddOWj1QrNXOZZeBxlO5sWnXRGl/r5ob3ObVPEV+vv9Q3IpEWvZnMZ1cTmNNqDqLreGYROm8IBwzGqcCDEn5MU5juHeIc1Lri9J8T1fw6UCjAuTQVE9mej2riYFuAFMsfFLoAWFH92K6VwaMwI6FAJf+NNWlQZKmwp2MiVCKfMuZXupp6KIK2BFjIbCDuZb8d43jAcAVpjtk+1M4xAaVHtDlj02E49ehfd6Rm0HeWnTHEX6NgpyvHLmUGwF3azgy46A6eGJZtarav2xO57QX97ysXYuZu4rqQlmFMeeeaN+CmHZ9T1tAHwl2LKM0JNH3P9Rgpt1qwA5StlwMNIlMPYVPBXTg1EdD5y3JiZoKAyQ+cW9ih9iAfSvLsxKI7y81oxPsDeMda1quq0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(356005)(5660300002)(7636003)(2616005)(336012)(426003)(83380400001)(47076005)(82310400005)(54906003)(110136005)(316002)(36756003)(40480700001)(478600001)(16526019)(966005)(186003)(86362001)(107886003)(6666004)(26005)(82740400003)(41300700001)(40460700003)(4326008)(8676002)(36860700001)(1076003)(70206006)(70586007)(8936002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 22:51:31.0095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e80a272-cb5b-4d65-9044-08db3495f79d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976
Subject: [virtio-dev] [PATCH v11 6/8] transport-ccw: Refer to the vq by its number

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v9->v10:
- replaced queue_select with vqn
- used lower case letter for first word in comment
v8->v9:
- replaced 'named' with 'known'
- replaced 'queue number' with 'vq number'
v3->v4:
- moved note to comment
v2->v3:
- added comment note for queue_select similar to max_queue_size
v0->v1:
- new patch
---
 transport-ccw.tex | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/transport-ccw.tex b/transport-ccw.tex
index 3ce3f9f..23a6483 100644
--- a/transport-ccw.tex
+++ b/transport-ccw.tex
@@ -237,11 +237,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 \begin{lstlisting}
 struct vq_config_block {
         be16 index;
+        be16 vqn; /* previously known as index */
         be16 max_queue_size; /* previously known as max_num */
 };
 \end{lstlisting}
 
-The requested number of buffers for queue \field{index} is returned in
+The requested number of buffers for queue \field{vqn} is returned in
 \field{max_queue_size}.
 
 Afterwards, CCW_CMD_SET_VQ is issued by the driver to inform the
@@ -252,7 +253,7 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 struct vq_info_block {
         be64 desc;
         be32 res0;
-        be16 index;
+        be16 vqn; /* previously known as index */
         be16 size; /* previously known as num */
         be64 driver;
         be64 device;
@@ -261,7 +262,7 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 
 \field{desc}, \field{driver} and \field{device} contain the guest
 addresses for the descriptor area,
-available area and used area for queue \field{index}, respectively. The actual
+available area and used area for vq number \field{vqn}, respectively. The actual
 virtqueue size (number of allocated buffers) is transmitted in
 \field{size}.
 
@@ -278,12 +279,13 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 struct vq_info_block_legacy {
         be64 queue;
         be32 align;
-        be16 index;
+        be16 vqn; /* previously known as index */
         be16 size; /* previously known as num */
 };
 \end{lstlisting}
 
-\field{queue} contains the guest address for queue \field{index},
+\field{queue} contains the guest address for vq number
+\field{vqn},
 \field{size} the number of buffers
 and \field{align} the alignment. The queue layout follows \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}.
 
@@ -571,7 +573,7 @@ \subsubsection{Guest->Host Notification}\label{sec:Virtio Transport Options / Vi
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

