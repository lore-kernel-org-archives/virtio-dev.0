Return-Path: <virtio-dev-return-11848-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28AFC74A5B
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E904619231B
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E246D986566
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D67C79864EB; Wed, 29 Mar 2023 21:24:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BF69598693D;
	Wed, 29 Mar 2023 21:24:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wa7Bv6V225oswg4nnH9MEpHdpNsFQ+OT0GehyTrms6gVFhpakBCyPLDv0FFIDaceihoAyyCLzjezSPx08WaXlDi9g6vs/HwjypvnBaZd7MaFBFTvebOEd8EjE/bC8u41IL+nRV00EHAxYZaWQgqlqNsGbcDA2siu3t6Ie+SxZdanB21OPzaqW8NxMBAxFKeqzQVxn0WAigbHgX/NCs2hEbQr1yquAPK5osPhWD51H0bOtL/o+dELj1ctC8kOhDy4aAS5+5WJpn3pU6tcJ2KnvNpAD/2aAX7CHx0bIzPm5CRAP7oJW04HhLX+gGxt5l57CxqGitmdqho3TRVB3xd0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwjgU+GWnUxwrG94XcL5q0nafi+KfCBcygfX2MA+ToU=;
 b=Vlr6ogaxTsGNKGmJ6Uey49PF2vvh4x8mgB5WW2td3GCAyRGkTELV9NLhZfMTxYObNzxAFJPVAKBVhQrKuZ3ak4ZIoUqNUcRR3OMeOKi1g3IS3B2CMJFpkbicK1d5nXRZz/0M0hmxVSlQBGwdhWJcAQYPsQX+VmtNd4PDg3ral9HwV2kNEp4mK7RHiDYYCh5nsBRlMCbuIR/apOl392qt2UT1V8SekK4Mb6QYDm7WBCMxuAaQNJR3hA/0MMzNJ9gZcdDpTujfzTIJkmnjXkw32RlA3oZ6AK/K6PrjD7qwHj4Ri/y+sJcUv31ONnNanfbzt0RqjgTt+qXP5061eXJB0g==
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
CC: <sgarzare@redhat.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Thu, 30 Mar 2023 00:23:39 +0300
Message-ID: <20230329212341.465843-7-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230329212341.465843-1-parav@nvidia.com>
References: <20230329212341.465843-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f2449e-f601-4d8d-084e-08db309bee90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yQy2UsHgSQRVq5fjGb3fK3MRn4mJHM49rXoLFGq9qgUC7eYVQzyJX8ype3ZicKV/zctXNgw56dZ1opuO6I+a+9bvwSEPqdpbMGiJsQHqKMfJnE4RokYVZoakPAz1v52EmOAhGIcVKKRNJ0Sn3jRbBBOzbGw7BA9TrgxbagUKYDzGUGZLHUkj+XfJRneVOGAp59l7WoHB5lJNDdt4sVXcy7KqiDl+pcRu/4wixfa7hoD+cUr+G+LewsYH11kOzdctB8JBLeE8bNM1SHYnU2k1ZtMRGD0PQ1CqZYC7yLusTV3A5l7eXgLaQeT0aroPe+ComzLplIdL8d7/pX50eEQ1AZcIR2lkgnGMdGn2kEGs1JCw1j/BYiR9Wxw+zj3k1V3cVH627Gcu+SacuunpJcJjZDx0YBmnB8wiOH/vRZB94iSO1pKfbnJetBUgzexqpmhUSU0ce4k2XM9+xlCosT6EahqxH0WnUZKmzdx3GdOfpT663G3tC1MZ8aeWHIwv+J23MGw8QhHxYxvkZ1yh5grpbhhGqcybrxMhuIwHK0PlukMe70tyQ+j73pUud9Fsrm6pGe6dN1QgucL0f9PlJQqC06Evd/Kg7wkh9MDJIFqxEG/1nNJND1UI8yC18Wf4150zRVQGIpP16750OMCPQymTMJxCju8N/OsnLT5qqRg9tNXFoTP2yxDwU2sTLO7IxBKpUwMFwgVZYHzNEFQ5PxJDcm7GbUwJpW8IecsZERFpy8eNvy/oRHHLmKrXFNMX+q0zzAvq7Y/B6ZAQwVVtJrfzwhsLUhNsjgWW8OsLZn0TmOJ1s9ouYiBDs/hD/b390qybqNkPH5mxGj8kx+FO8rVtTA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(186003)(2616005)(336012)(36756003)(47076005)(426003)(16526019)(82310400005)(83380400001)(1076003)(26005)(966005)(86362001)(54906003)(478600001)(34020700004)(36860700001)(110136005)(316002)(70586007)(70206006)(8676002)(41300700001)(5660300002)(8936002)(82740400003)(4326008)(7636003)(356005)(40480700001)(2906002)(6666004)(107886003)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 21:24:08.1350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f2449e-f601-4d8d-084e-08db309bee90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877
Subject: [virtio-dev] [PATCH v10 6/8] transport-ccw: Refer to the vq by its number

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
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

