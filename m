Return-Path: <virtio-dev-return-11998-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE36AC76188
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:08:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3C67369F9D
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:08:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 366B7986601
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:08:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2A33698658F; Wed,  5 Apr 2023 01:08:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8CC49986820;
	Wed,  5 Apr 2023 01:08:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6JIw0suT1fdia5nJ685dabpM4Vta4cWdafdTGh7eeIkW+Iklk+Z2c7iQymxYJWbSfSIVukN/ZtNUEr2iZawZawkAtTRSad8wi07KdOCEiHt7Owu1RSJ1zK5vMZwUal7aQA8fJxcI55BWYw2wWRJOynW65P+1IAoQ9SXDO56tSJq37faZuhBiTu9oXFZRklaVuPhepYXRUL5VqiSDiOTcEwjEDxy+T4z7br8BgtmlAmKh1tVmE0qo0yNsgSvEtQSbjq5LL/eOyepgCWKz+ns6yNr7va7j1wi1ZUFtOyFXujtKyqoXylZn5Ibkj7QLivkBVOHIdUHbI1tiL7F+JIutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwNrv3SafPxGrq6svTaTHMAA+cpxczfOMCxAfk+bYGk=;
 b=fqv2EPuWzEpUFWvMhTW5agzYszJuJbANZHF6P6QtoJRljc3ox4c9odxI5+8kHid0758SaqMSM5xDcKsvknIYPKxtpwVyWglHbNlx8qlH5NnxpmwjoYZgAOs5rrAz0IM1btGqd7ddM0QcxqzOe5m1Q1rtWGEAvvp1CPEX9JT1/RjzrGC6vSbn99/zmHyy3TjeBeedJwi4Ysd32glGjh7/pJPp5NBHn6E2dJPIauuZn4vDVKto/9YW6clstJedOaozdATzUbKt2ZLDLp+slQVetjlDqCzU5pwnjqR6HmrtYBk0xOFke6qEildwcc2T7+n1V+hHHB9+UFoer5t215RnfA==
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
Date: Wed, 5 Apr 2023 04:06:57 +0300
Message-ID: <20230405010657.612529-11-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230405010657.612529-1-parav@nvidia.com>
References: <20230405010657.612529-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|BL0PR12MB4930:EE_
X-MS-Office365-Filtering-Correlation-Id: a201c85b-edf4-4474-7afe-08db357221c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kAJGSjw+3t3bBzYwZagAtMMBoix6XorjR938RRl5Qj6NWUN8zieJ+DU3ysz9FSbC4b9b0rYO50ndR5HNGA6tzN/Gd9jL0oRhsQo1ufeGaU5pKcq2e4O1BX5NYTQSc2h6Y0W9+B4nFeHiW1D8CFuIkEowatk7VRnvgkj1qmesdIF/XU5spRcCh+cMM44ZhUOgy+FY67LD34aKkog0UVzGVARt85CqfthM7ecsAsubC5eW3dPb5p5zLm+TVOXTh9wYQ3+wMjzO6/8FiCIbiK9Ic/K1lOhy22CkQ+cBkalpwBpXLo7b/miVlYpb/zhFMM/mn/Bn9t+m9PXYLtJmvHJ4ZSJ8/jMoP1CVkILjtcwvZWMHOv+FNO99FecwUJsRqecUu1El4Bh5pCYAM06mLrziGOzdFt74o8wO3z6a2bxm9X8nA7oMvnusVu7Di1BEgkxMUO6rIzQXzHZpzvv8YcQWqYHXVFd4svoEQsKPWGNV2TeJbn+H+9RwCy9wuogTjxv21mRe5l0JFT0MlkLcnjzSVD2Fta8C8N0RtTp0byeVPheEa27qOVdWvVAJaogv8xlLHGMUEgMA/Ifzd4CxvsjC4Rx251akCyWXhDNqw+4eA7YPitw12T1jtG0BDWSmYJG5gby1wA+Pny8mXt9bljj4/LINJn/u3fRIyp7bjnb6PNrnL8X1I1cviLfrpRs61iOmI53FxvmNJahYlTOGc7flvktR0iQAJ+R5+9hVQlD5o+O3PQiQNQQAlOz2jfajdqj1
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(46966006)(36840700001)(26005)(1076003)(6666004)(107886003)(36756003)(86362001)(36860700001)(478600001)(40480700001)(82310400005)(16526019)(966005)(186003)(8676002)(70586007)(70206006)(2906002)(426003)(7636003)(356005)(336012)(83380400001)(47076005)(5660300002)(82740400003)(4326008)(316002)(2616005)(8936002)(54906003)(41300700001)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 01:07:31.0356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a201c85b-edf4-4474-7afe-08db357221c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4930
Subject: [virtio-dev] [PATCH v12 10/10] virtio-net: Describe RSS using rss rq id

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
index 435c1fc..4eb10d1 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1423,11 +1423,16 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 
 Driver sends a VIRTIO_NET_CTRL_MQ_RSS_CONFIG command using the following format for \field{command-specific-data}:
 \begin{lstlisting}
+struct rss_rq_id {
+   le16 vqn_1_16: 15; /* Bits 1 to 16 of the vq index */
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
@@ -1442,10 +1447,15 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 \field{indirection_table} array.
 Number of entries in \field{indirection_table} is (\field{indirection_table_mask} + 1).
 
-Field \field{unclassified_queue} contains the 0-based index of
-the receive virtqueue to place unclassified packets in. Index 0 corresponds to receiveq1.
+\field{rss_rq_id} is a receive virtqueue id. \field{vqn_1_16}
+consists of bits 1 to 16 of a vq index. For example, a
+\field{vqn_1_16} value of 3 corresponds to vq index 6,
+which maps to receiveq4.
+
+Field \field{unclassified_queue} contains the receive virtqueue
+in which to place unclassified packets.
 
-Field \field{indirection_table} contains an array of 0-based indices of receive virtqueues. Index 0 corresponds to receiveq1.
+Field \field{indirection_table} is an array of receive virtqueues.
 
 A driver sets \field{max_tx_vq} to inform a device how many transmit virtqueues it may use (transmitq1\ldots transmitq \field{max_tx_vq}).
 
@@ -1455,7 +1465,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 
 A driver MUST NOT send the VIRTIO_NET_CTRL_MQ_RSS_CONFIG command if the feature VIRTIO_NET_F_RSS has not been negotiated.
 
-A driver MUST fill the \field{indirection_table} array only with indices of enabled queues. Index 0 corresponds to receiveq1.
+A driver MUST fill the \field{indirection_table} array only with
+enabled receive virtqueues.
 
 The number of entries in \field{indirection_table} (\field{indirection_table_mask} + 1) MUST be a power of two.
 
@@ -1468,7 +1479,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 \begin{itemize}
 \item Calculate the hash of the packet as defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets}.
 \item If the device did not calculate the hash for the specific packet, the device directs the packet to the receiveq specified by \field{unclassified_queue} of virtio_net_rss_config structure.
-\item Apply \field{indirection_table_mask} to the calculated hash and use the result as the index in the indirection table to get 0-based number of destination receiveq.
+\item Apply \field{indirection_table_mask} to the calculated hash
+and use the result as the index in the indirection table to get
+the destination receive virtqueue.
 \item If the destination receive queue is being reset (See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the device MUST drop the packet.
 \end{itemize}
 
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

