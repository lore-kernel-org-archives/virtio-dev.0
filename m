Return-Path: <virtio-dev-return-11948-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6596BC76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:52:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 630507C9D6
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:51:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 90BC29865DB
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:51:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 19FD3986759; Mon,  3 Apr 2023 22:51:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DB11D986738;
	Mon,  3 Apr 2023 22:51:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X39sNl1cnbkUQWnCdUP9Yl6mPp3d7O3axb1b3DEbaC3JNA7PDLdZvZMhce3SQ+I7wAunaUxkCeRDmxXHDJ38GMEr3V3xjduQrP4X0+25i6Gcc6XB2oZLvnCaokFrHa5yK6pjnzt9U7pke4e3NFnarM6FSriwGSAn+FlYKmEXUKoNkykAbrmqEEnz1+aaqTvFcVEqlh3Ik1Kip3zwuDYMxsk929lGLlYA6E9l+1Hi4OzacqmO2AJKMfhPz9S6dv2gb5mMgGDGgfXuagcpDyNTq3VxXEW9NB/mL9KeqY+nUv3r7XsVh/LF2fSDk/RVK/CnpCYE4o93VhxRISA7/TRPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8nsi+hlZhkecvv3uXftNWPHuaeFOQyy/6fXAW+DGIU=;
 b=CA8oIVDB/w7YKs3eFOotZ4X+2j3M0U1r6YQln8sQnqfBgs05+CXWWka4WGmkWOZ3QulF1QF7KsVgPrPvE5HKR3stBilQ5OX1uMNPZRYqohAKQV7+mf/db7YZVDS7+GFSVPj7YhgI7UiVyRu+NjpJUrJV6iKxjrLAlkd0heOP70itgFYcxlEaq0xO50IogyAk3S5QmWDQe6pU3bIQQz1SS9RKGkP2V6GqujuuEsrASldcnjSn5ndvhxgopF8/ZcyCrVDMel4tOT1Zhgf6Ld9Ip8GURePanE68WklSLJlGJ1TiitzWYFVe6fGA2FgdYRKEuGfSl1LP/6tP8C16NZlsrQ==
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
Date: Tue, 4 Apr 2023 01:50:52 +0300
Message-ID: <20230403225052.585498-9-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230403225052.585498-1-parav@nvidia.com>
References: <20230403225052.585498-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|CY5PR12MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: 3615f850-310b-40db-698d-08db3495f8e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7U5kMbDG+RxWRVe+kfZQ++BmSXLsrIPxfBIaRkCtqxU927xTO8QLwz1bMntb0rv9e9GZ6ymGaiaoixJnJa5DuAeA/mklYdj5ziVV5rIqim7lTOvNSbV2beGo9PkH7Ke5XTzON5cTFe21SHAcHDgAR6NIBO3skPMwpam2M1Jhr7vV07VeaZztPAwhinWNNvZz0Xhtgl5jYxo9mYU5918nYaLd7A0vryWDN80qitJMdpuALnadeHdInjoJ3Mb/Ni8KCtC29MfvftS2xdWoJT+eUOHLM+OmQIbIzJFLloi4ubBFGVx4sQzIqeY7Qv4tgVzLM6RU609aSenc/qKv3c8Ku10BAZZhT4q/TjVIZX1Y7w094ok9joILmVwk6ICOmfvUBllWMsP/Uy0CEziaQjoeFOcWmv1NUIrX27IP9w4tEP6Cco+yvZBtqKIe4G8lneZx/WI5zOMI6zZB0ccojIRvlxsA9LQ8G0lcMD+T0XYTKRgGTl98o70IDU4llR6Bb9PCOD6uHmSew36mBE3dgtZThpFxUn5i5gw/wQM+Lu0DetBi/UEDASoy06gkK0vbBu5oidX4TulwsPPDRpeNMvUpPqMu6Dc7D4YCBNDYPOGCNs3K4Aw5MhDs8aCm232Yvu12/epNWzWB2g/92Dx4/mO9kEUaOH644Oz3yY6rHWGnDkt+clLHjTspoZQUfARYxW28y9LP6OZOMO4BTm8GsYPevKFS+1fjdaLEYJHNo58A9YXKGRabRuPAoQ8nNzVlrMHN9UifPM9ekX/GIvuC4q+1V5ZhuCm0yUWKkorizlWIm+E=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(86362001)(2906002)(36756003)(82310400005)(40480700001)(966005)(426003)(336012)(2616005)(186003)(16526019)(83380400001)(47076005)(26005)(1076003)(107886003)(6666004)(4326008)(8676002)(70206006)(70586007)(40460700003)(36860700001)(5660300002)(82740400003)(356005)(7636003)(41300700001)(478600001)(316002)(54906003)(110136005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 22:51:33.1778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3615f850-310b-40db-698d-08db3495f8e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6406
Subject: [virtio-dev] [PATCH v11 8/8] virtio-net: Describe RSS using rss rq id

The content of the indirection table and unclassified_queue were
originally described based on mathematical operations. In order to
make it easier to understand and to avoid intermixing the array
index with the virtqueue number, introduce a structure
rss_rq_id (RSS receive queue
ID) and use it to describe the unclassified_queue and
indirection_table fields.

As part of it, have the example that uses non-zero virtqueue
number which helps to have better mapping between receiveX
object with virtqueue number and the actual value in the
indirection table.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
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

