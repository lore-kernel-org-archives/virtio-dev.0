Return-Path: <virtio-dev-return-12299-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A333C6FD18
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:48:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 77EC642BC0
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 708AF986623
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6568798641E; Wed, 19 Apr 2023 01:47:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9694E986614;
	Wed, 19 Apr 2023 01:47:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdXL1Dm8yMOtssfwvN4yWvRZGiWoJTXKMFPHjYQPhbXGhZu0NUNrk7XacgwfrrFB8M0ucihUNoXchLwnMLzXUaCHM3zTdj0Hl/iKdn1F1hfTs/nAJIhb+Yta7a1oF63Bg5iU53sdowKZT0p8E/Vb5sv52MOIZ8kf1t3OUkkHr7CvwgiARGJbKoGkC2YAMAjwvveymSZR+K9fDcw5fR7DjXErp18wWxiNTj94V/Dt3Izj0MXxui/+lBr5YBt8n8pXyWLjRpLB6hBfVDqgEERidnpd+NUY9KNIQaULzeJgE/mIqbrj6HoFHbObjoXylZX9Lpb/ACMuwGeewg0OZRYSTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIN8jpTOh00yQlguLAiHhRucEChcb+MWs1iXVndAypw=;
 b=EREh9eMnl0pJUFLTMd6BtEfH1RufAzH1VnRu4ZYZHKQb9jj2HZRAMQtIvx0JGouXlfo7bIQiWNydqHCklOUrmZHR+JxbWcz2C7DIs2LXgd62TRanE3odxkEYE/yUnwT9DEH0z8Lxy1tKTYy1O44l/2m0JgHo+u7NEBQv4j+wDoIU4b1HAgEs8BXaxNe4U7mRMl3of7MfU+rMSn0eXZhNuNYMJ+Y4XfZoml7yw9RWRB/oPTwT5tNxQ3jgzmX20jxoHOhaBv29qNtaGiyv1i5AhhhIY6GMPmVbmdhqg25xgpU+umODvmQJ9NuJth3q+rlpeLmXMxf5iWeRJgOYxacZSg==
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
Date: Wed, 19 Apr 2023 04:46:38 +0300
Message-ID: <20230419014639.919458-11-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: a1126874-3834-4d46-1ae0-08db4077ff16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fH1Lg/1CmR/xQDyORPZQbDADgPC3YKPy+M1dSVud42tqMalc02su4mdR8TBiqBCTG7WXTRzrHCGx31eTJxhx4uqSpNipk002Dxqgy09lN7uau4ZlogWZrx73fQ4bfArsMIKxwPTQWOSmgDEIqXNdkfdkTQoGXB7aaqOhy+08AdVy0NLkyDS0Tq1OtNzdu5Wm6KPrqGn/5HJt7+Vasb+6p1d4CJdOoBECPvM3W9vBLkaNxSerdi07s+qwoYOI9aZYbIQtz12fUOMZcHgaDWKkyiRFkFWXL8FJLja9KXn3NtUw/JmoL4BJYfNooHPsUABSqXXIUBn/WHLMP893fBEYJ8M1SEQpl0G69T4ZRqRZfm8tHP3yN8eb9R4eprklOj0E1qa9RD2+3lXVxcBTULFLy5J0XAqFaKpcfWcu/yHA44vs92WZyX4oAuWW/61XW7eWKClz1o53LuJpgfaXT6WDs5dtrBW9twCxtaSLP9ln6PEgNrXBOvQeiB2aK5qRaVF2tKXhKfvPLQ3osQWxKE/Hm6YUbGoVKqoPbKUHarhIh46huztUMFaQrG3KW/clsWzVExWkOagiRmCNb4OF5CVy4h4D+KwCBL0HGez5FC0hnUkPIuUKOuhHkau6Vvv+AXOoMQPIf/8J21Axyv8HLMWRNBR7aHva43TYJYzO3vYslh8eBF3SuHkpimtdCCH2VW2Mbyq7z3Kop3Pz7dEdTboB79DV52ex5etL5MW+rn5hbdA/exXsnhTwfCnw1OUWKSLDIOmTYUg8MQs+EWJ+22SzWnsS5BzbztTYRSlgHmBRg6jt+MWngsFvI5i9sOxrL+Iy
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(966005)(54906003)(478600001)(34070700002)(2906002)(40460700003)(6666004)(40480700001)(316002)(110136005)(36756003)(186003)(426003)(82740400003)(336012)(16526019)(5660300002)(8936002)(2616005)(7636003)(36860700001)(356005)(41300700001)(8676002)(82310400005)(83380400001)(47076005)(4326008)(26005)(1076003)(86362001)(70206006)(70586007)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 01:47:12.6419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1126874-3834-4d46-1ae0-08db4077ff16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862
Subject: [virtio-dev] [PATCH v14 10/11] virtio-net: Describe RSS using rss rq id

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
index f3f9f1d..e4d236e 100644
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
+Field \field{unclassified_queue} contains the receive virtqueue
+in which to place unclassified packets.
 
-Field \field{indirection_table} contains an array of 0-based indices of receive virtqueues. Index 0 corresponds to receiveq1.
+Field \field{indirection_table} is an array of receive virtqueues.
 
 A driver sets \field{max_tx_vq} to inform a device how many transmit virtqueues it may use (transmitq1\ldots transmitq \field{max_tx_vq}).
 
@@ -1466,7 +1476,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 
 A driver MUST NOT send the VIRTIO_NET_CTRL_MQ_RSS_CONFIG command if the feature VIRTIO_NET_F_RSS has not been negotiated.
 
-A driver MUST fill the \field{indirection_table} array only with indices of enabled queues. Index 0 corresponds to receiveq1.
+A driver MUST fill the \field{indirection_table} array only with
+enabled receive virtqueues.
 
 The number of entries in \field{indirection_table} (\field{indirection_table_mask} + 1) MUST be a power of two.
 
@@ -1479,7 +1490,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
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

