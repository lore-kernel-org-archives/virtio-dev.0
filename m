Return-Path: <virtio-dev-return-11759-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FFFC74A5B
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:06:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 337BE1EDF6
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:05:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C9F9E9867FF
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:05:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F0D7B98684A; Fri, 24 Mar 2023 01:05:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C92C4986471;
	Fri, 24 Mar 2023 01:05:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9+k1YH+FOxYxsvQtp5AtWUQdeBgdrtPOrlzL+3zKrGGMP5kXRypIktLQ50Hy3wuHVBN9LUbpp2RrGPAupoL9k2sV4JfCjOD4RU5XFGs9UAAIwVDZJktt9CEZVu+MZN4WbBU92/pOflh3+6HEF8Y0daw35OtAFDsZ8TnkdmyEpbyFWHxUzwREduqLceTV3K3//4Z5gimbIZRGO6yHfD1BD5VciWNxzIvUpQWpp+FmRTBCsiF0x12SHiw25DSRv9Fy4zwaH0GMPb4PKkUqUfuAWFYVePsusVXmc30SRRnhszv2T1qzxkFfovVxvbGtDhHkHrzxD9mIxyZz2dKqXnkRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auaXE3m2ufrOU8jg4DAORV49SujWR9c6uL2GASlpDeY=;
 b=CJq6CLVLveiG8XQDHFo4IDKY8Y0VHeK1z0PL0qp/v55L79qy1OxlKfVK/VR3c9GkgGRlV03xqstJGBmswV2DtHOyfxNe9y9E+PoTVEsfGnmOEaL6fMYhulM4u5MJs8gL1y6oAlmMUyUg9BDIwfPc4FtkxVFrMpQM1Hnv7R/BVuJ4g+ueR8w222OXuSZ1pHLqngeBH6KYzQRwSfV0lk8AOfVWF9NGVLF/KpTUbecOEpgyyhszbxJRHynl3taSh7hY+87lrhIOuCc7jN12HIG6Q8Vu32jMJeK7nNKreKiWvWpz8BVMbACz3XFPQnyaC5p87oBGqY6bshLXUiRcDrQtJQ==
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
Date: Fri, 24 Mar 2023 04:04:32 +0300
Message-ID: <20230324010432.280330-9-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230324010432.280330-1-parav@nvidia.com>
References: <20230324010432.280330-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT067:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 0250999b-6a85-4a8f-7f94-08db2c03ccd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YuGKXtt+Trz1UjS6fSWSfsilbrnEoZFAtOW+f2R0tlwgNon6Dmy3pOGNhRNCj0eNeTenuJOmkd1vRDyloJchllNyfAIEICoI8hbWfyYwWyxg09cgkyTh2c2mGNvFQsXMqZ4iCSbdo/Ti7Sgmlepd5/bfD8FgRuRynl2IjzWvfPWTdpODrgwPD3MMK1h0l24vkDTd/UIF36Ij6NPJiFkT3ZooWSLSHk2LBgTvuYSIFiAeXPx5/m4+ANv6ee8/PpmM7K0RW3gQL/2DfiAYf3ft33sboMqRxPb+GkdYHHSbOog/K1WFMwG9cXQgplDA1HIMIIL5a4KFzc63V7S8qeXsfpt8DnRsBaU/ZB5rwUF87G+dKQ26UO8pCwxlJwher4YaouLgyrDBi8R8dktt0d2EMs6z27F6+AYp8T4tljNa+xtybArqXgQcI/ZthxITiVEweEEM/7zQHQD1iEb2W29Lij/DkyPxG6AGMzVKXBeyCwy7Q0XetOfVuPH26oTucvIDsopGROwqfv6DpOpUtFdQWW1QVUJ8y+Y1kJ02mY1I9zawQs1BaztnYxU9fepInoidF9LSHyg4uhYnXfehdy1egvyc45Cm422ruFbWOv4J8nBQey83FB+VFgKorgw+dWG9UEOGIPgeupbjT7w8ECqg2Prqslb1h/l0jMphTk/0tRszpBesfIsdx9nzXZWPeglfSM6Zi5oFWFa7kB1lA5YC5oDrDd1ePaYy8lw7legtFZhGE8lqjUsUMiPkdRcGfdxPJ6IafN2aAqm+AsDvaKNTJqhslOdagKvt7P99LAV7OI4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199018)(46966006)(36840700001)(40470700004)(40460700003)(36756003)(86362001)(4326008)(8676002)(70206006)(8936002)(70586007)(41300700001)(110136005)(316002)(966005)(54906003)(478600001)(2906002)(5660300002)(82740400003)(40480700001)(26005)(36860700001)(356005)(7636003)(1076003)(6666004)(107886003)(16526019)(82310400005)(186003)(426003)(47076005)(336012)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 01:05:03.4497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0250999b-6a85-4a8f-7f94-08db2c03ccd4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689
Subject: [virtio-dev] [PATCH v6 8/8] virtio-net: Describe RSS using rss rq id

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

