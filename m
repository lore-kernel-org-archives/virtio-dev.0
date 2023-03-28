Return-Path: <virtio-dev-return-11830-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B13C6FD18
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 20:21:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 23F3660087
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 20:21:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1ADEE9864AD
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 20:21:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0EEF2986494; Tue, 28 Mar 2023 20:21:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 284999864C6;
	Tue, 28 Mar 2023 20:18:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqxsulMxDAeAZy7e8XIyY7xDeuzfLsURHBQ7JRoNAnj+xZ00Y3zbYJ0yo4t5DV0BDU6WEziDIsXZTtTeEUD2UqTr1SggMjTnJgiXOXUkVFo+LvLLY+sE8Efw+j7njWfB3xwjaGO519M/iS5X4IUXPahjIX2+Vqa3PhjSdSuc4YeTWLld9Zi+I6i5zjZf54RY7snmMMxU0VCAJCMNmCMDxOAMYXxgC8SieKvBuBjjsf1/cO0XOdq2MeZAW4MKTWTraQKAgwQdDDkvR8hh1GTmIwR8OEidDSYnYD1qzmL0IvvdeirgjWOpnfbkwGkqlOVvTyVheRHorFsey7ttrOREiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbXJ0y2CEor+YEO4/wFmKcCHZ5+GNeUczIX5C7BZfj0=;
 b=iEPztwYGLX9RCnVZJbT+CjPFJUkMp0lrhHjjRwQsGWd39flbY5bM1SZ7aIuPOq/rejb2A/ocsY+Agrs1lGttZAT++gikK4nN5SvebCv7Rv/HJnnAC7Z3IS9SRG6iNSBYIEoQvbS400eWp+3Mh07Dmu8VB5w6NJOk2Dx77wi/3N5vUHLxo+tbiu4xAS3JG6OHcGd6QLLUhMdBUChrraHsAI+HxXNVZ1QiXwk3aP/3epAPC2fSdW4uQkGfnlCSs4E48oUJSg2TMBUMM06YNDJZE7yXOV56oOTyN/Ov8xVikiQP3WCi2YKnRY0os1YIKwgU9MTZyrjcpJsLVaC2aO5Ijw==
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
Date: Tue, 28 Mar 2023 23:17:52 +0300
Message-ID: <20230328201754.440974-7-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230328201754.440974-1-parav@nvidia.com>
References: <20230328201754.440974-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97E:EE_|CH0PR12MB5371:EE_
X-MS-Office365-Filtering-Correlation-Id: 5945923e-ba31-470d-127c-08db2fc9988b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/uHXzCljDqa2LGIo5Q5iMdxNSwFKbzj61ehsmCz8exWvE+Ui5B8nUtCMbIHz+qJXTBOLGOCaZxyMfGnUhIpFjt/zA8f5mOpeHGozlXgYx7mCKOcbgPVqXxWEvfaIyE8vYNyJIpp8ochTbnOOFWK08s+jiruGPj0CqhLIccqPElqniN/AO4Zrq+TdpyUFidUNP1CtZCLsardOXPjSCeTW0tREjMzVoNKx8dXEPW1lzizQzsiWGonnlToYRgo64KSoNXslBD/sPxQXDbNAD140MzGlxAQF6/shRq7sQ4jt4UrIWR5FxEVoF6/R810XLl8/yZ0fuf0o2UkExHspXCkEHajXxfP+TQOH+8Y11RFV1U/Nm/pfwu4rkJTxTwwpB//kyyR1sTqRp0rEkSJ6eMsELYtNj+ca+ilZPODrbmZIQJtrW2hYVBQdeQ61AXc4wsXCvY7NENpSlEHBTXrLKZlnmEqkbafYYwUzkY1c5JvlandcKvyWDcAa0BJoM4sbgXJ8+wERxSQyFF3c8HPPvbilUruwzpAwd93Igh0UG+A/p/iVAcyahcfxnMB1T+QRsp9Qdvi8kIAApwmZfXA+mKprkThBiOnARmtP4gvIOdAL+Xha2y0TT1BwZEP5Daeb1r6S+p91AXfrQaqaBUyjYXzSbCDvDJ7bYV1GJJ0Hhom7FbXzySvEQ4DT24E7M9daUGmWW0eQDpfNH1ncsKTSeqPAt0uAiGhdB9pkdDNA+IMy+aKBwVvYGAUIl3apBXvk4gZIPIAC5elLK2HRcOoGoAiOCZ/NroWpwPVi3Su+Rvs1rbk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(36840700001)(46966006)(40470700004)(2616005)(40460700003)(966005)(26005)(36756003)(1076003)(16526019)(186003)(82310400005)(47076005)(107886003)(40480700001)(6666004)(86362001)(70586007)(336012)(82740400003)(41300700001)(70206006)(4326008)(8676002)(8936002)(316002)(7636003)(356005)(5660300002)(54906003)(110136005)(426003)(478600001)(36860700001)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 20:18:29.5677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5945923e-ba31-470d-127c-08db2fc9988b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C97E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5371
Subject: [virtio-dev] [PATCH v9 6/8] transport-ccw: Refer to the vq by its number

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
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
 transport-ccw.tex | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/transport-ccw.tex b/transport-ccw.tex
index 488c46c..0240db8 100644
--- a/transport-ccw.tex
+++ b/transport-ccw.tex
@@ -236,12 +236,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 
 \begin{lstlisting}
 struct vq_config_block {
-        be16 index;
+        be16 queue_select; /* Previously known as index */
         be16 max_queue_size; /* Previously known as max_num */
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
+        be16 queue_select; /* Previously known as index */
         be16 size; /* Previously known as num */
         be64 driver;
         be64 device;
@@ -261,7 +261,7 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 
 \field{desc}, \field{driver} and \field{device} contain the guest
 addresses for the descriptor area,
-available area and used area for queue \field{index}, respectively. The actual
+available area and used area for vq number \field{queue_select}, respectively. The actual
 virtqueue size (number of allocated buffers) is transmitted in
 \field{size}.
 
@@ -278,12 +278,13 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 struct vq_info_block_legacy {
         be64 queue;
         be32 align;
-        be16 index;
+        be16 queue_select; /* Previously known as index */
         be16 size; /* Previously known as num */
 };
 \end{lstlisting}
 
-\field{queue} contains the guest address for queue \field{index},
+\field{queue} contains the guest address for vq number
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

