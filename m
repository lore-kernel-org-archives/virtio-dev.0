Return-Path: <virtio-dev-return-11743-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E69C6FD1F
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:01:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CA035370E5
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:01:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 733419867E3
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:01:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4D1909867D8; Thu, 23 Mar 2023 01:01:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4D550986617;
	Thu, 23 Mar 2023 01:01:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUksntZYxVycFY13163tp1DIGw2pOKivN+9pDP32kxXbcCopYnGncSRCATqr1oKJxDtNLO0QomZlBDImiBcm8k8srpmKUS1NuTXN/dEmTXEr1B38ts2rLtQOUb35LfBZVZSgYdrq1OTGeahe9vP6ywyzAtRNX7V4pLUC5jcZ1RNgpjsU1LyyB4EyHTEwMSBytmYL9bumdHi73qfX79vM5b5Totlhfc2JuzqTg0tCf+i0zL7x5oCXHPe1Ln/deP/PQZaN5y3Xv1Zg8krILcyXXBOkQy/2aoq8KuOZZHTD+FwyNSYAoY6F/rGUltwRPQVGAPxUHtrZpK0a0B/GFcT2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auaXE3m2ufrOU8jg4DAORV49SujWR9c6uL2GASlpDeY=;
 b=AtovpKboM3MuPkBj9JShiburO2ZiOp6Q0vDF+WDjGFqXRrMK0/ppfG4bFQysd5uBDCqUm/9WqEGC1kbjNYJMb3fNBQhBDK+UUsBEpY3wBRND6AA+thv2yzoGVhG4nc4PiCrcwc/v1ENgVRr6OgIhd+Qub6j7eX2MZ6yqfmLhpFMjJRcJgP+rh5tIrACtTL8+JaHv2bWbneyqZ9arfdES52dT9dFPDsbwQ8JPmlMoTdGm0K6pM7yORxmEDQbeIf8S3xquRhF2L4PyUB8t4qdoDUM8hA+TAl27SAwkRxhMK788/uYG3OXPUtdmlqqa2Z/K+W+uD+eLSh1VOSCn2f7RZg==
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
Date: Thu, 23 Mar 2023 02:59:44 +0200
Message-ID: <20230323005944.262738-9-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A62:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: 926d53e6-d3d0-470e-a295-08db2b3a0336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XjXCkRecUmv7vQGPGgbnMjm9Wp5pPjbRXbdvR6gD55xPEXAJWbgQ8f9vLYX/2jeRAnxUx59DmOpt9ThFZ1fyJifm6tVJrDPO/ISIJrLs7SXi2+vt7y6CYttkk+uvvKULqjxvAdaELwjSNbPv6gfS9kIvy9tNPoMo2rxCb6VGv37CluJJfY0zUBIB5HKkoTA6ZrPXVyz3cBVf2rACon+fenAG/XJtAo7Nu1Vw4qzNGut8L9EQAltOKSMhWnbVxNM0o9M1KtzFB0+9cuSddgF/hGURhBGGQEf9I4mZ577ObqJkLrQIDdQxwlfI+g+tnhIGCfy6Ks3oXLiBKRzcxTdAC8fwWS9/sUKKoCwEcASm5x7qSvqxadxkACAEvfmLjrOcTKgevcVucMY3hkDopNq1tay2XoqtEq1cmsjVlUH+LJlLhKG1DoFVmo23ENZK1pRIa1fosu8+suakPhxbUtI5qduQeFFRwWPMmvTTrOFhu7WlH8kTqfCmh6lbu9ANeEW2lIjAzoAQftJSngTb4VmMQ0h7oZff9y8vVi5DVXrF9syuwn6w7awyn8qa/jILru105PQ9SQSEvZ0GUrUqlmDhP5QMAzfe/AH/mHSoF88wauaEaU4P0F71WNwdwvKZzZ4C09FpNsMwVBQzkEryXzj6q4qhiTVPNL2pMl3QD1pHhgbKn8GCFYzl227Ehu2WfJApZE5fZp6ORH1MgshTUnbhRFby5CJUr2gl7SZ1FxSrLEaEKoZ0/wTdKdHXOX8CI1i9s3xC7iGIb08SumR0qlMSt3mPmErN7FkgzbfqkSw2PQc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199018)(46966006)(40470700004)(36840700001)(86362001)(82310400005)(40460700003)(40480700001)(36756003)(4326008)(426003)(8676002)(316002)(83380400001)(186003)(110136005)(70586007)(54906003)(478600001)(1076003)(336012)(2616005)(16526019)(47076005)(6666004)(966005)(26005)(107886003)(70206006)(356005)(5660300002)(82740400003)(8936002)(41300700001)(2906002)(36860700001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 01:00:36.3504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 926d53e6-d3d0-470e-a295-08db2b3a0336
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00001A62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597
Subject: [virtio-dev] [PATCH v5 8/8] virtio-net: Describe RSS using rss rq id

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
 device-types/net/description.tex | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index 435c1fc..d6dd897 100644
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
@@ -1442,10 +1447,14 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 \field{indirection_table} array.
 Number of entries in \field{indirection_table} is (\field{indirection_table_mask} + 1).
 
-Field \field{unclassified_queue} contains the 0-based index of
-the receive virtqueue to place unclassified packets in. Index 0 corresponds to receiveq1.
+\field{rss_rq_id} is a receive virtqueue id. \field{vqn_1_16}
+consists of bits 1 to 16 of virtqueue number. For example,
+\field{vqn_1_16} value of 3 corresponds to virtqueue number 6 maps to receiveq4.
+
+Field \field{unclassified_queue} contains the receive virtqueue
+to place unclassified packets in.
 
-Field \field{indirection_table} contains an array of 0-based indices of receive virtqueues. Index 0 corresponds to receiveq1.
+Field \field{indirection_table} is an array of receive virtqueues.
 
 A driver sets \field{max_tx_vq} to inform a device how many transmit virtqueues it may use (transmitq1\ldots transmitq \field{max_tx_vq}).
 
@@ -1455,7 +1464,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 
 A driver MUST NOT send the VIRTIO_NET_CTRL_MQ_RSS_CONFIG command if the feature VIRTIO_NET_F_RSS has not been negotiated.
 
-A driver MUST fill the \field{indirection_table} array only with indices of enabled queues. Index 0 corresponds to receiveq1.
+A driver MUST fill the \field{indirection_table} array only with
+enabled receive virtqueues.
 
 The number of entries in \field{indirection_table} (\field{indirection_table_mask} + 1) MUST be a power of two.
 
@@ -1468,7 +1478,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
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

