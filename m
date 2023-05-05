Return-Path: <virtio-dev-return-12564-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC011C77B73
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8E354FD58E
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 847D49866E7
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 79FA19866C0; Fri,  5 May 2023 01:47:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 79B8D9867F6;
	Fri,  5 May 2023 01:47:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhCPsPCbOYUfSvYPG2yQ+pQW+03Y/q2SywsOuWtUVG4GloSF9tSxUckP64GdxLrjTIvG2FVNYT1nUqd3Da0VPC0cykWsgCKKTpTPGNz1ZnvFIcKuAlCReWL7ulTDGNXqheQGNzPU6SpkJyWm67DztMHlnD48grpfkiEDnY3DypgARJSvLYft/6tMsgaDO7C+y23bHlcli4hUUtHyU4SQFtKCGi2NzYK0OxEYdM527r3Ed4eGDzPK2GlCnPGX/iiVQhT6fXw/ofmdlG++VP9lJ29vAvLl98UU7I7lyOdWr4QElg9y+pSEgPVLN+Ze7XwjRccZd2+5bJQchTbf8BoxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5zjPr1hILUa3mmHXyMonCeas/WpC4Jg8KnXSkayjCs=;
 b=EN53/N73qDWHCOvTYIrZnGzQ4iK0EY/kVj0LJYqJgoKvu+EMx6dFsAC71YgPqhiNKmZ958nUkZXSeMHtLoG8MfVU7SAWzGBnzEIg8sX0XrOkdOfysFoFLRKZEAVev06US1OeR2ivfe+SqOb/e5p28Z+F87/hKr0g2s8eP5XAkrn6URNnhghX6hodKSkbLkMNxWhZ/cboiq2xEHr/sMpr7Wyq7zyWRsLFPbor/hMjBfVch/oDyCvqZzECuTeYAk2B7NRL6bgYvSmexeYZe9v+N/yi67PZtV4SXjth8DHD7+Jeg38UjIDPcGPu5Cfo/9Ehfys5/F6srMqvTG4m905v+Q==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <sgarzare@redhat.com>, <pasic@linux.ibm.com>,
	<david.edmondson@oracle.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Fri, 5 May 2023 04:46:13 +0300
Message-ID: <20230505014614.571520-11-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230505014614.571520-1-parav@nvidia.com>
References: <20230505014614.571520-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT051:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: a54deec6-aec4-404f-d0d8-08db4d0a9b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vufMTirmve9BkHdPpMxIYZgQA0gbsJkBkz/6OMaMzpECZN0/QrCPwGcRMLKLYPEmcrZy0xjjJGELM0oGhLYoBoAVttmOnogTcZmctNQP9FMCe/iPzH/F0goMNlHZi3JlKqhew7eL/vgZWjO+5g2t9OQaagiAdFPiKpFVlWJVX2M5LdbxLDLVixpySl4D/CxJYky7ANagBN4+EPdmAGq4fI/Yqidhfb/HVNMYAGz7h0Y79JUVUekNE/ystWaf7BufkjK3so9ZzeTmbj0uW+2TpVIvrsNVxgmOl04nVvKJnr5eldZokjxYqt9YxA244R+Wg6TSJ5l0ZjVeKPSD1X7oLzU5rPGx9d5jW4xpuW9UW1pkQlrrHdyAQYh6hZei5DBtK7afkRpz6Ag6CgNOf1L0Wik+LnojQnHcMJAu4roj7apPCDfA8uuO87reyYX5mc0+3vca0T5/rYhxwtlGSnSPtH1bzhgoJKWV6dGgbmgGd2WWOX3rkmi7E6BUra+eYOgEBGEiBJwTL0+cYLflFHlNxOkGXnQJOFUrEWboyYSypZI/QxRzJmWLDVg8I3MVQ82SoIilkDQtsRtw/RvxSRieglEujwAAcrOtFIKjwKQgtfk+LXhhkV+Apg2DaK+NOegbO3zvtwRMq/Osk5paRpmryPzoY9nH5zelhM/qD0BJ0Lp80uSUS+XxldG+nArKZH1whZYk/SuRUljshPRdEZBCq1qfQHiHDcBR0Y+BSdCLcJL46EbDs4/4Xgn24TRR3bCr
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(966005)(70206006)(4326008)(70586007)(6666004)(478600001)(316002)(54906003)(110136005)(86362001)(36756003)(47076005)(336012)(426003)(83380400001)(107886003)(2616005)(1076003)(26005)(36860700001)(8936002)(8676002)(5660300002)(2906002)(41300700001)(82310400005)(40480700001)(82740400003)(356005)(16526019)(186003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 01:46:55.5517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a54deec6-aec4-404f-d0d8-08db4d0a9b78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
Subject: [virtio-dev] [PATCH v17 10/11] virtio-net: Describe RSS using rss rq id

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
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
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

