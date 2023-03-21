Return-Path: <virtio-dev-return-11664-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686EBC6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5F5712AEE4
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 547F49864C3
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 46D3D986458; Tue, 21 Mar 2023 04:11:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1C0849864BA;
	Tue, 21 Mar 2023 04:11:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUPUTd+dQ4O0kILKKcx49vmntOTfGPkd+ykBACyl9epYxZLeCQFEDWgFiMzEMJ1YyuE4Q7ASuRIoZ7vfPbpBERAIFA+RD3SqHMs5rmVZUcRDbuEWlo9hdwYVktdmDzlPHCetVIIsuaqTcJmbidrjRwnt4klTcGs9G4y6FFyxKGVEJqzqaZBsTy6rrWFETOW/MfhWpAE91y91uXkrwGRu89WpFQ7fHeqDlFvg+Ywjt+ArzJWv/xfEaqyjLxDkMVlEF6qoV1vaH9oAVBoCbN0Pjr7csU/D1ipLNYtUA35j4dLDpYrwol1Ud/jAm+lQNZHnr/2qKxA3nNxA0VPLtWU4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+v32Tc5vgRnnRgDCn+CpFg9ZTltk9hKXFx7MvjJ0C2M=;
 b=m7d0OJsRLsVJSnmdHuGBD2wj36N5jLRgSUWHKVqK0BbkoKJwBAAgBUHnN91i6TyAxz0baFK1pllVphpIxrkgfMxpsi0j/IWuYxTx+/EY+GxQTPimvX8KAJlec5OELkkqrtnbDVUi5CroKrcP8/D7IvKYezh4LyPTuQMHYBELDxYKY1lakPYY45AaWqseDd3S6pH1Bar2Zo1+Es0VRgzzjkpNYYn0BbWdBSX5yfmsLotEfH0Akoog+Q0J3YGECmb5X7bcCm8f4N1cPOeA+lIUwQDPZOyyXRkStgBWLzrjs74cMOHTAUWkXqRsTUPfLQOQy3+NCPBgorjiTKrJOT14/Q==
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
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Tue, 21 Mar 2023 06:10:36 +0200
Message-ID: <20230321041036.201439-8-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230321041036.201439-1-parav@nvidia.com>
References: <20230321041036.201439-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT113:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: b4fe422f-ec39-4a90-7d14-08db29c24c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DiFtl0anMNf3cWBkKt4p0WnmbxT3l2v3d+WqfJ1kKE19cp1gH1BC4Xdri6owMWGhvaX7HH41YmK0IicR6PENXUImzh01iCTrCFpWedk2zIct1UscTW8Za9l6gh2CtEKRzicYNgLtIkMIaYRy2JIWj6qmtpt28MWreQKo/iEgcxUQmPo3Uh4TYF772coobxFTwBKT0+seG4lHHT+IFbpmuwdGaha+7FTuSXhKuq/ubWIPixUbnFjwMLEoV9VlK5mTVjviMb1BLjlB3g0hmPNIiN8Bk+vf+Zeb9QRiX/rUIkWSgzwcfAUMdbsVxzwWMkeFb8IveZ5zk6jUv3j3/DEojCr+8IDjfMXiZxxe4enPFDCZ4zhehEMV7gsiTgvQF0hpF1739Ln+L+rXihGzAtwpY+Hc09cX0LgbFJKkvkFOES4jyw2zLvHVqcv6yo0d4+oAps8THVMv7Gvhkb5wqZ/Bu6AszGtHAbma/QKpPo5kszMCKttrcUQ62P0a2PiHV/Or5lqJRNilXWd8g9K+axhnZ1YO86Qjamf2/BrptPy/MAYgh5tuM6F+I7t5J0wFLdjiXVOlKgMSvOMLRItz8lgIQ5V1g+Vie87unsWfex89xzG/In827zsyho7bbC28Zas2iEcYzU+JiCfDTl+U/2P+qgxmQXdLE31J3oAwjOnKBBvrHYodwJf+o8sCsok8IAETccfRferkeXMpMS7Kwu56FaGqCKBW/9RC5eNBAcDmwIOkhSkFFlq5mu7RS4IEQLrFaKbr7l8ZCAJgjolxza6sPWq0HmNbeA2kJXZR+ZJiaqs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199018)(46966006)(40470700004)(36840700001)(8936002)(5660300002)(41300700001)(36860700001)(4326008)(7636003)(40480700001)(356005)(86362001)(82310400005)(36756003)(40460700003)(82740400003)(2906002)(54906003)(83380400001)(1076003)(478600001)(16526019)(336012)(107886003)(426003)(6666004)(47076005)(186003)(966005)(26005)(8676002)(70206006)(70586007)(2616005)(110136005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 04:11:08.1546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fe422f-ec39-4a90-7d14-08db29c24c3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
Subject: [virtio-dev] [PATCH v2 7/7] virtio-net: Describe RSS using receive queue handle

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
v0->v1:
- new patch suggested by Michael Tsirkin
---
 device-types/net/description.tex | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index 435c1fc..fa9b4c7 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1442,20 +1442,32 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 \field{indirection_table} array.
 Number of entries in \field{indirection_table} is (\field{indirection_table_mask} + 1).
 
-Field \field{unclassified_queue} contains the 0-based index of
-the receive virtqueue to place unclassified packets in. Index 0 corresponds to receiveq1.
+Field \field{unclassified_queue} contains the receive queue
+handle \field{rq_handle} described below.
 
-Field \field{indirection_table} contains an array of 0-based indices of receive virtqueues. Index 0 corresponds to receiveq1.
+Field \field{indirection_table} contains an array of receive
+queue handles described below in \field{rq_handle}. For example at
+array index 0, a value of 3 maps to virtqueue number 6
+which corresponds to receiveq4.
 
 A driver sets \field{max_tx_vq} to inform a device how many transmit virtqueues it may use (transmitq1\ldots transmitq \field{max_tx_vq}).
 
 Fields \field{hash_key_length} and \field{hash_key_data} define the key to be used in hash calculation.
 
+\begin{lstlisting}
+le16 rq_handle;
+\end{lstlisting}
+
+\field{rq_handle} is a receive virtqueue handle. It is calculated as
+virtqueue number divided by 2. For example a receive virtqueue handle
+value of 3 corresponds to virtqueue number 6 maps to receiveq4.
+
 \drivernormative{\subparagraph}{Setting RSS parameters}{Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) }
 
 A driver MUST NOT send the VIRTIO_NET_CTRL_MQ_RSS_CONFIG command if the feature VIRTIO_NET_F_RSS has not been negotiated.
 
-A driver MUST fill the \field{indirection_table} array only with indices of enabled queues. Index 0 corresponds to receiveq1.
+A driver MUST fill the \field{indirection_table} array only with
+the \field{rq_handle} corresponding to the enabled receive virtqueues.
 
 The number of entries in \field{indirection_table} (\field{indirection_table_mask} + 1) MUST be a power of two.
 
@@ -1468,7 +1480,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 \begin{itemize}
 \item Calculate the hash of the packet as defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets}.
 \item If the device did not calculate the hash for the specific packet, the device directs the packet to the receiveq specified by \field{unclassified_queue} of virtio_net_rss_config structure.
-\item Apply \field{indirection_table_mask} to the calculated hash and use the result as the index in the indirection table to get 0-based number of destination receiveq.
+\item Apply \field{indirection_table_mask} to the calculated hash
+and use the result as the index in the indirection table to get
+\field{rq_handle}.
 \item If the destination receive queue is being reset (See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the device MUST drop the packet.
 \end{itemize}
 
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

