Return-Path: <virtio-dev-return-11843-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DF3C77B60
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 33EE267041
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2C4F698654E
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1DA699864EB; Wed, 29 Mar 2023 21:24:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5A5E9986641;
	Wed, 29 Mar 2023 21:24:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYtLIdubFGQ+zkRyyuCvt8/yvBtMrMGVdQNXXJADhItEp0GwCVgDoVKSP5HB5aZELQsj6NqPtxbdDb696wFD45s5GitYycpwMeUwbEHmyAQOsRZrwyhm/vznFyzHEWeZnVA/mUSLqGLyXx5iz6WhrPipNBnzlYaXpF9AaJVI5lz3r3rwN0c+uXkt3Cyb9oPUHSayV5x5/k4asKkr52B/S8+3chMZx13MkvbY7YzHtvqkRDIz5RNGepeF8SFrFgjm84ZSs4NGRUw01ZaMhllqd5P23mqXZ/efCRr1vn1HS2E6cqpNevEM5CMbZf9mDU0qAg9Vxd4fBchz45zDt5A8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EroGu26SB/Io0LPLfrU2p+qnIVo8C8m2zZq/bubG3bU=;
 b=UytBiIkjLR9ho7o4VFkfl8+DCXBK8bBdSFkQPRy/2xNKpGYkTPytIkJT2HiT8sMT0IpHcb/+OlZ1jqNcJP1Xk2tJ5dbJPrfb7wQdoLhSVJM6zCa3wZqx0AuYrup5tC261sAn1GXb+QLWESx+yx1FAjySNWDgcbWTcM/U7z/XOHmvgPtNWD50FyhRwAek9eWt4/vEGRfGFdGWtqXaUiESZBfosFj+unq0cbcfJHt5kQ9odJIwvKWcNHrNoXhTeyZ+rky99kBVE7bS+JWU2twft+fS0ucAdj78ePpVbp328wAtXGbBzAkmwExvG8HiuQetBWcSjhVVeXxFOKaWAo1IDw==
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
Date: Thu, 30 Mar 2023 00:23:41 +0300
Message-ID: <20230329212341.465843-9-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT005:EE_|SJ1PR12MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: c1668546-0c46-4e91-1c0e-08db309bef5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NHIBltYe56iAKGBgTnuJ0dBYEbSErc7tbVzBC4N8oeUnE2q3GdFlaRTp/sZaGdnpTxc5HEyWQM7fJtEwKEb1YK0AY+rO9jUMSNLEF9j5P5x8BzDqmY/uiJxE3SkBzp8QOGGKBXAcc2qA88gZ5wRMMjRV8aZKQ7eqpReWx7SSrbcK2TJcAC5rGgzdI3Xn/y0Tqs6W2q3QkYbDm0QVUlHEqFeF9XzyP2NzA7pkFXn4OyCT0WUDqjyoxxT/iWVhdOK2uxaSG1mL7wDBja1IRhcmLtincRYAILtKDJXljdzi50XZ1AftnLYHRJ2/7vyHiobgJxvB6+mbqWR49D5sSCNBKclZRa8aFh2dvwLP3S2TrR7ejxoUFrifBparwKuqMx9GMPaQLbehEbmdgeyzOWLiRug+0fWVqrYFxLZHTQauZd87rCq3PJWhP4NVsMoTRNxXW+i90UR9copMkmxYq2D10f1+jsrpclVVqQdFOwPxnrbmYECA/If6+puA5HlmST3gGus/kopjdtdiuQCIXDJkPgUCCTynGImE/QFISmdhWjKGXeNNZYuhNkeTV5HvU8+H6c7SZbfz3GXAH3UMRQYBe7pf6C30HAyMVbra2uPa+mtkpuMfW01MhK0byRXBNa8EHfORb0COeOT4r3XMPPexXR53/iWkfv3sCZapLdTxKb+m2Nb7Ki0H40aFIstbotGrtTwjKOVkO5BuNDtIg8U0gjZDQxuIQv1B3ZiTYk9L+5XOf4MJ+Og2OJkF0aXC+8fbRcYunXaly5Znh9kQWaPC2rE065XXTBl6nEuYOqRfhdN+r2ngY+Ghu2tvBGms9Q/7
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(86362001)(36756003)(82310400005)(478600001)(40480700001)(40460700003)(54906003)(70206006)(110136005)(82740400003)(70586007)(4326008)(36860700001)(34020700004)(8676002)(41300700001)(6666004)(1076003)(26005)(336012)(107886003)(426003)(16526019)(47076005)(186003)(2616005)(83380400001)(966005)(7636003)(316002)(8936002)(356005)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 21:24:09.5077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1668546-0c46-4e91-1c0e-08db309bef5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6097
Subject: [virtio-dev] [PATCH v10 8/8] virtio-net: Describe RSS using rss rq id

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
index 435c1fc..c64335d 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1423,11 +1423,16 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 
 Driver sends a VIRTIO_NET_CTRL_MQ_RSS_CONFIG command using the following format for \field{command-specific-data}:
 \begin{lstlisting}
+struct rss_rq_id {
+   le16 vqn_1_16: 15; /* Bits 1 to 16 of the vq number */
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
+consists of bits 1 to 16 of a vq number. For example, a
+\field{vqn_1_16} value of 3 corresponds to vq number 6,
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

