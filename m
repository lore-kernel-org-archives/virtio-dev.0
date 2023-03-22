Return-Path: <virtio-dev-return-11731-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9154DC74A5B
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:54:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 09502874A8
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EB18A9864B0
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E186F9864A4; Wed, 22 Mar 2023 21:53:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A543B986585;
	Wed, 22 Mar 2023 21:53:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Au8Ocxfly/4+f5O31AEMH0IGlh/Zf68a7mgm1tTOGTvQPUDvGq0NcBnuF5quY4emmrcmGkZ86iBkEeSnzlD4RziUoOxK5HUaNGbUsWI0yghM14Q6n0kdEp2mSAcY/cnp+gs2E9O7IVlrYS/02fV6F0hN3XGDBLGoAwj5N4CLeYSMyVvPLSd5vYAyQw4Ix2UaNoARjIdLMo4HuoQPvqh4wdbovUfbpZwKuGD1xirFZ+tQcO8GIFogFYw+X6RcCrgo55Xy8PbjdiBt1dT+nyqdHWWTeOBbNL9aOxtVvcdFiYnZfa9tjf58/x6Xf5ZaSKV9W8+B7GcbLqQxkmbIPHZGjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvhFB6QZS+Ibex79lZB9x76wX8DyZrZkxU9Jq7IiN4k=;
 b=DnGF4h4PVkS/RIAzwiN1yUhnMLlM4B2ZFC+uQqaWU7QefzIJ1RDm2F+itiyCjDyYlIm/yI2DYxCQsySYGTx/q+Akuh14DUy0RxeNOPOWowC2Hb6JhCzHvEbvR4CevMRND/YJPuGmvu347vkNd44ZynDHjWvvMGmgD1WqYcQIXyGqW4tbqox2arkwqRGbj9Tfu1k9A/wu1s1iplJsSBgWoYLCZRhxV3G1qfNDXHUEn05x0iKyDIFd8IO0SoCG5L7PPIGXsyt++9E29vaZy2KMRQGDgt4ga/TnkUhk91A2HkDV3xg7kpDuKzSwax+LWAREey6kVqPSFIZHlrgZTVe6TA==
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
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Wed, 22 Mar 2023 23:52:43 +0200
Message-ID: <20230322215243.249524-9-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230322215243.249524-1-parav@nvidia.com>
References: <20230322215243.249524-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|BN9PR12MB5036:EE_
X-MS-Office365-Filtering-Correlation-Id: 446d9091-1a8b-4074-33df-08db2b1fd551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Iyb+F6JYWHd2NBF47yc7p67hozpMcvDnN3ImdWyOSYL044eUW6txYuTH4kD10ZDbbG/O9RNf+JAeRR22AT0UhjR83kVlYq/Bc/3gbr/sqUOhz/tBlQqR24kBPrFZfGHrnibf2kC42+Pp5SNthd32v1wTJM/OTHvwyQvDiXHEItI4J7+/qV3UaMUAYp2t/9Gu1SdVcP84iI8u5J8MchJ3B5WU81nI84w2Tn622UY3FBMu1TwaL5vPpZFhtsKqHB9LTZAbUemlss46bk8pUGvYcbzPcvnA/cl/uGMxUbIngEUCt9gRdrgv/7ZpEmb3PG/Y0wtn8X4bt2ABVfEIX4s+GqBn8M2hTEXFpUJeqSC4dDYMtDbg0bGIgsUnSSLsYLZNZXwWPe+8qGYLviLAF2mmwRJHFnBPg7OwlX6Doq1AAzD24I3kc8Ll8Q5hz0IKzE7ypUwwHWCRFrTgRtx614bOSkmoUUOjzVKj/RRLjSJNqBkxPHn2Q7xFjjxtJiMNeIZasKwbpAe9ZXvPhA8s/w9Z9FXCpvbDZqhHyQ/PJNBo/0U7LOrFIWet4MFyGuFTs3OwcfK+sL8lX36sLAjiuuU+D11qoJLdFQE4cJvzUt1Jkmprvfi13HJ2AF8eIa4NOMcUyikeL0u+FTVPjADuXuijj+l+tsNdd5lG7Br9M/cA7T3BhtVI7HreB0o9u5sA7ENWvGxxr2jqkP7jfH4R0CpDTBmYgYX2DNrHTNCJbYjxBSBebnWp8jQsvSj3/X6YjzeIXIkadiVvjO1vfH3EFr3iT5cUHNtzjva0Us+sRdTP9HI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199018)(46966006)(36840700001)(40470700004)(2616005)(186003)(966005)(47076005)(107886003)(16526019)(83380400001)(478600001)(426003)(6666004)(1076003)(336012)(70206006)(316002)(70586007)(8676002)(110136005)(26005)(54906003)(4326008)(36860700001)(41300700001)(5660300002)(8936002)(82740400003)(40460700003)(7636003)(2906002)(356005)(86362001)(82310400005)(40480700001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 21:53:12.3719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 446d9091-1a8b-4074-33df-08db2b1fd551
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5036
Subject: [virtio-dev] [PATCH v4 8/8] virtio-net: Describe RSS using receive queue handle

The content of indirection table and unclassified_queue which are
based on math calculation historically. To better describe this, to
avoid intermixing array index with virtqueue index and to use virtqueue
number

introduce a field rq_handle (receive queue handle) and refer them
to describe unclassified_queue and indirection_table fields.

As part of it, have the example that uses non zero virtqueue
number which helps to have better mapping between receiveX
object with virtqueue number and the actual value in the
indirection table.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
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
index 435c1fc..8b560f3 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1423,11 +1423,16 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 
 Driver sends a VIRTIO_NET_CTRL_MQ_RSS_CONFIG command using the following format for \field{command-specific-data}:
 \begin{lstlisting}
+struct rss_rq_id {
+   le16 vqn_1_16: 15; /* Bits 1 to 16 of the virtqueue number */
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
+consists of bits 1 to 16 of virtqueue number. For example,
+\field{vqn_1_16} value of 3 corresponds to virtqueue number 6 maps to receiveq4.
+
+Field \field{unclassified_queue} contains the receive virtqueue
+id \field{rss_rq_id} described above.
 
-Field \field{indirection_table} contains an array of 0-based indices of receive virtqueues. Index 0 corresponds to receiveq1.
+Field \field{indirection_table} is an array of receive
+queue ids described above in \field{rss_rq_id}.
 
 A driver sets \field{max_tx_vq} to inform a device how many transmit virtqueues it may use (transmitq1\ldots transmitq \field{max_tx_vq}).
 
@@ -1455,7 +1465,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 
 A driver MUST NOT send the VIRTIO_NET_CTRL_MQ_RSS_CONFIG command if the feature VIRTIO_NET_F_RSS has not been negotiated.
 
-A driver MUST fill the \field{indirection_table} array only with indices of enabled queues. Index 0 corresponds to receiveq1.
+A driver MUST fill the \field{indirection_table} array only with
+the \field{rss_rq_id} corresponding to the enabled receive virtqueues.
 
 The number of entries in \field{indirection_table} (\field{indirection_table_mask} + 1) MUST be a power of two.
 
@@ -1468,7 +1479,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 \begin{itemize}
 \item Calculate the hash of the packet as defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets}.
 \item If the device did not calculate the hash for the specific packet, the device directs the packet to the receiveq specified by \field{unclassified_queue} of virtio_net_rss_config structure.
-\item Apply \field{indirection_table_mask} to the calculated hash and use the result as the index in the indirection table to get 0-based number of destination receiveq.
+\item Apply \field{indirection_table_mask} to the calculated hash
+and use the result as the index in the indirection table to get
+\field{rss_rq_id}.
 \item If the destination receive queue is being reset (See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the device MUST drop the packet.
 \end{itemize}
 
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

