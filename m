Return-Path: <virtio-dev-return-12542-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005BEC77B7F
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:31:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 422B742A85
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:31:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 12C79986708
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:31:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 06CCF9866B5; Thu,  4 May 2023 02:31:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CD818986726;
	Thu,  4 May 2023 02:31:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NS8QwFWlh+1Oab9DkMh1Fa1glV1zun4ixWA9xMf3W2wj4N3PdwCLs6pxhyHXSJl5S2ZQy0Yohbix4NBxB5tvkb6iYDLWrf53A95dk/PPXpmjW7q3h+OeI0y3d3VmFyEkwT0LoOKUEocf/I+693Ogcf5S5RYlk4OLhr4ahbt8e+f9nvsxtOwPcOxgxDuWWmPDSqKBRwonbN2TX7Cq7CF4GQhiNLxbitEh2UwIptCd67rc+kJzpwT4QlzuTr06GWQNJUELaiiwvlhGBzOGIOUeLndlb4FaYQadTGUkLeTzcmxbuvnJPVZBO8Pd+CKNuBHxc50C49DH2AlTEc8Pudtm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhxfWbD1JRF5nR6Ka4DPruodKH5LlnEXdtTONJdYHGg=;
 b=Y2p8lsd6mtH+dD+lW9WBL6k0btGZjZptu6lausTLf300+8nKtf5dbKLiVdy3mQX+mYZhJ32BUtZ1EW+dbnEO+df0XidpJXK7gt62TXD6S5fPYBWo7F2FCjnKVOfcvcaPZSuC68MWur+5pBBEq5xYnvWG2yAmfPeE5Fb7WMGVs+Z0P30NbZ4LVRPQIpFm0cp2VWJVm+ZF9EAEhovPtWMmDLySOZUYTlsa8xMiOs3LZ4CIa0VTyXmOQDcR1az427CeXR4p7QRU/BvvIxCR+JqMq+vwo/KpM1s98y3oEbfDE4j8Q/yW6KEyLpdvpkb7vgxY2sAj88j0JdMPd8wBcSpmxw==
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
	<david.edmondson@oracle.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Thu, 4 May 2023 05:29:58 +0300
Message-ID: <20230504022959.547025-11-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230504022959.547025-1-parav@nvidia.com>
References: <20230504022959.547025-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT114:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 5650e61d-2979-4745-a2e4-08db4c47913d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HD34xblLu/8ycp8hff/47dVJ+aziz/KaqPgAXJgsTjqdRQqCJsJ6MtbqVnQ0sNBlXs1ozETmFLmEemyOQzUmcF1riQc98GyVPeVlXeypMwsuFLTlPdiols4HtexvkdV8RZ5OJ/nAMdv9Q2nP2vkeUmWm1QbDd5Jv5iaUpx4g3jwqhH2ShujkPpxbEVLDeSDVyn5j4wINSBJs0+Jz+p7v6WINbY4fmXeTDHbbbDV3XFnHjQWPiyJz2Bn7f7nM89bIPD48ZVF8ycy7XwyRWy+BysGVWAb0R3JkwNVJ0qGwVso+R0cO0ipJXj/ISK4YpmpLvQUC+uEh8czS/Cz0pMOI1JfZ3drz31c7pYvQrtZCUwr0kA3NKUgjoX4iqnMuwUqM6lS716qCLBZz1EfizQeEpfpBmNPZikAuu6xgyflzCZnEHYMeVc/0yH0rDzYiLnmBdmeZdc47C4L5rPxtY4Th2S8ml2rrR6ynMhVK0YIEoz36WdBsWunpgXaZrMvcWRTxTWTVLV+ycrmd9xR4Pb6FX4zyXfgDXixZ8yn5HD5oNU9okPk56cQclEIfE7MZ5fgM8mIB3bZFrHV2VufKe9WNTgz3XRm/13h7Sx0YPtakEWOv94NFN2AbcxIpIkJ3BxY50hq9qWDXYEfjtxfgqhULTOXVkEuvc5m8U+27GqxiLapIBNvjF1Y4Y12+VhA/L2RsSSfzOhH4nMOOamEX6zqrqeWBBAiYgZG4shqF9HRjYfE7kqXOgAUzD8shTUJnbl9B
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(6666004)(36860700001)(47076005)(83380400001)(426003)(2906002)(336012)(40480700001)(107886003)(1076003)(26005)(16526019)(966005)(186003)(110136005)(2616005)(478600001)(82310400005)(36756003)(54906003)(41300700001)(70586007)(70206006)(82740400003)(356005)(7636003)(316002)(8676002)(8936002)(86362001)(40460700003)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 02:30:46.4619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5650e61d-2979-4745-a2e4-08db4c47913d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
Subject: [virtio-dev] [PATCH v16 10/11] virtio-net: Describe RSS using rss rq id

The content of the indirection table and unclassified_queue were
originally described based on mathematical operations. In order to
make it easier to understand and to avoid intermixing the array
index with the vq index, introduce a structure
rss_rq_id (RSS receive queue
ID) and use it to describe the unclassified_queue and
indirection_table fields.

As part of it, have the example that uses non-zero virtqueue
index which helps to have better mapping between receiveX
object with virtqueue index and the actual value in the
indirection table.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v15->v16:
- replaced receive virtqueue with receive virtqueue id
v13->v14:
- address next comment from Michael and Halil
- changed description of unclassified_queue to use 'specifies'
v12->v13:
- rename vqn to vq_index
- renamed vq index to virtqueue index
v11->v12:
- use 'virtqueue index' instead of 'virtqueue number'
v10->v11:
- commit log updated to drop old reference to rq_handle, replaced with
  rss_rq_id detail
v8->v9:
- reword rss_rq_id and unclassified_packets description
- use article
- use 'vq number' instead of 'virtqueue number'
v4->v5:
- change subject to reflect rss_rq_id
- fixed accidental removal of "unclassifed packets".
- simplfied text around indirection_table mask to use the term
  destination receive virtqueue. This aligns with next line about queue
  reset.
- removed rss_rq_id references as indirection table and
  unclassified_queue data type is self explanatory
v3->v4:
- renamed rq_handle to rss_rq_id
- moved rss_rq_id definition close to its usage in rss_config struct
v2->v3:
- moved rq_handle definition before using it
- removed duplicate example as rq_handle is now described first
v0->v1:
- new patch suggested by Michael Tsirkin
---
 device-types/net/description.tex | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index f3f9f1d..83bdaef 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1434,11 +1434,16 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 
 Driver sends a VIRTIO_NET_CTRL_MQ_RSS_CONFIG command using the following format for \field{command-specific-data}:
 \begin{lstlisting}
+struct rss_rq_id {
+   le16 vq_index_1_16: 15; /* Bits 1 to 16 of the virtqueue index */
+   le16 reserved: 1; /* Set to zero */
+};
+
 struct virtio_net_rss_config {
     le32 hash_types;
     le16 indirection_table_mask;
-    le16 unclassified_queue;
-    le16 indirection_table[indirection_table_length];
+    struct rss_rq_id unclassified_queue;
+    struct rss_rq_id indirection_table[indirection_table_length];
     le16 max_tx_vq;
     u8 hash_key_length;
     u8 hash_key_data[hash_key_length];
@@ -1453,10 +1458,15 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 \field{indirection_table} array.
 Number of entries in \field{indirection_table} is (\field{indirection_table_mask} + 1).
 
-Field \field{unclassified_queue} contains the 0-based index of
-the receive virtqueue to place unclassified packets in. Index 0 corresponds to receiveq1.
+\field{rss_rq_id} is a receive virtqueue id. \field{vq_index_1_16}
+consists of bits 1 to 16 of a virtqueue index. For example, a
+\field{vq_index_1_16} value of 3 corresponds to virtqueue index 6,
+which maps to receiveq4.
+
+Field \field{unclassified_queue} specifies the receive virtqueue id in which to
+place unclassified packets.
 
-Field \field{indirection_table} contains an array of 0-based indices of receive virtqueues. Index 0 corresponds to receiveq1.
+Field \field{indirection_table} is an array of receive virtqueues ids.
 
 A driver sets \field{max_tx_vq} to inform a device how many transmit virtqueues it may use (transmitq1\ldots transmitq \field{max_tx_vq}).
 
@@ -1466,7 +1476,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 
 A driver MUST NOT send the VIRTIO_NET_CTRL_MQ_RSS_CONFIG command if the feature VIRTIO_NET_F_RSS has not been negotiated.
 
-A driver MUST fill the \field{indirection_table} array only with indices of enabled queues. Index 0 corresponds to receiveq1.
+A driver MUST fill the \field{indirection_table} array only with
+enabled receive virtqueues ids.
 
 The number of entries in \field{indirection_table} (\field{indirection_table_mask} + 1) MUST be a power of two.
 
@@ -1479,7 +1490,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 \begin{itemize}
 \item Calculate the hash of the packet as defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets}.
 \item If the device did not calculate the hash for the specific packet, the device directs the packet to the receiveq specified by \field{unclassified_queue} of virtio_net_rss_config structure.
-\item Apply \field{indirection_table_mask} to the calculated hash and use the result as the index in the indirection table to get 0-based number of destination receiveq.
+\item Apply \field{indirection_table_mask} to the calculated hash
+and use the result as the index in the indirection table to get
+the destination receive virtqueue id.
 \item If the destination receive queue is being reset (See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the device MUST drop the packet.
 \end{itemize}
 
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

