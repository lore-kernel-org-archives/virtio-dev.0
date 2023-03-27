Return-Path: <virtio-dev-return-11801-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB746C76195
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 238CB29FD0
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A72998654C
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0EC0A983E8E; Tue, 28 Mar 2023 00:00:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E91C8986546;
	Tue, 28 Mar 2023 00:00:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iP0S/SzT4ztTaQeBVSWbDy+zE/1QB5zYGaQAeH7u0n6Z6rwmuk/SQ4YGsG3DkrHezx/PrPLMH4lv1O80Gde3QXw23CZbZT/5ZvPBOKF/JP1IjwjhTgLUzHrGH4tQgXhDHbwY3gwBdjKkju71OIBgyheuQrzZbfJG4OI7qBtZC99urT6cmCtwA5yTHDjRLLT0NB4hC7JeLPatQxiLqw3++MeetxTPLJ/HFuFx0UNUIr+rkrx8fBpYPMly7MKZJ2WYZLd4n6G8ebhtkiDjmVsdkHzzqt8vQ38HmhpoExhmEyzCvyLeRsMv5G9TKh2K1RruIMcsXSb3+nObWx7KFYRdxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auaXE3m2ufrOU8jg4DAORV49SujWR9c6uL2GASlpDeY=;
 b=ChtFTfvuRBrqE1euoBceVwM6JnRD6W9pieMyZguXbiiBbnVYznwQDPXUUNlhlbhV4EeLZcod0AcPAcrojip8GkF+kc0u+2t5PUSoGD3F5E+x9nAAuTgmlZgmcSBSlbKm3tf4CDgRCsdQ5Klb8c/3vQquoKdXmG1lr6bqEMrFInGmv5LRkKxY7RVjYlz9R0xzGMe/xkB8TomkvIXcAbeOU/6THiQbLIT3y7fZp4ZnYm1DdDkV/OT11EH0iNPkcrbsiZQ8gDVwKoZAUp0VMHdfsY8cY/S85mUBEp2F6fm2gh/KASOCUZQD0009nOIOZc/9H0h+b7zwMlLcFqG7N4+Bew==
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
Date: Tue, 28 Mar 2023 02:59:36 +0300
Message-ID: <20230327235936.414196-9-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3C:EE_|DS7PR12MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc38e29-30f0-4603-28f9-08db2f1f6452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A6BmBHeWcw34UYeethpDtJokPm69Ipy4P5w9LSQ9nZJTDz/i6JsNTxa39+Lb2c5xg0QuPe+O+SJgljE8wnFH1P0oNRqxywwdedi9+oQfHe8mgKeWGV7/PByMFMvL4IGz6f3afpEkdNvrqZCVM+nwPF4JWOcSAtxiGqw+4dtzjyOUZjPliDh+U8uOj2DHuCeeCNcZ0K4cGrgZUymfQdbaz7j6VVrVG36Fmw6Jq/VGD6BT/ByjnBpV96LinvwDrdORnI1Kj/KA2mWe7mxPi9Ul4FX0r/xo+wEci2HQ73tL2ey1td7q5KAMLeG4KO6O4GFo6yU6yskkwP89cglzS9XVLojcHKsnDIfKZcqw6FtIM2Y7TFpZTqXqj+H9efxo8Ol2eaX5z/7fRprKFrtCVJoHnSlt2yqfLdwF5Tj8sXsb44zv6NrEEHUHK6fRmDmDpOzzRKC4iZ1UB86ZaCkTO3jE7i7ezhyDm0dOrY3REAI0CXIYvpaoy39V06romRnlavAS0vFaDcoEfN0gT7si1pcX8eDD+7N0NenlZn0TxWHjbrUKJtjXQ0vVFnph3jHLryQtLCtR2c0gBuQjbD6Ei6hHOFcG5JyGjXSwlzPsUmyIn0zZJNw6K4CH7z+LAjZEPr19dVOYA+KQ1bv2rMe/xPLS9a1v/0+kq0nGGiVe3CF4sw79qByghFZpaimDaJheuke/1R8PxZQi7FxqC1i9ujtiVYE4/jMdPtSlJmAKNYapprFmKDUiObXlFOKWOofd7yEcmrHHORDXiuMhSdbCq9VQMNMmSYAdZwp11TsLmqqUiic=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(26005)(1076003)(107886003)(6666004)(70586007)(70206006)(83380400001)(426003)(336012)(2616005)(16526019)(186003)(47076005)(316002)(110136005)(54906003)(36860700001)(41300700001)(4326008)(8676002)(82740400003)(7636003)(8936002)(2906002)(356005)(5660300002)(966005)(82310400005)(36756003)(86362001)(478600001)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 00:00:07.4623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc38e29-30f0-4603-28f9-08db2f1f6452
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0000EE3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023
Subject: [virtio-dev] [PATCH v8 8/8] virtio-net: Describe RSS using rss rq id

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

