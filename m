Return-Path: <virtio-dev-return-11730-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C19C74A5B
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7007241A02
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C0CAB986852
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1E9D6986586; Wed, 22 Mar 2023 21:53:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7D55B9864A3;
	Wed, 22 Mar 2023 21:53:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPhtU3gcy8e0iHUHPTuWgZNvfm25IGYCALB5G38Z5bc91SYOUezSdX2uUcPFySPHyif7SHVBNA4E+NF8HOJINyQ/sqkzEAnMooM6F+Kh8+RWQY1r6rvM6DYN9HFrjsMBo1PIeVi6CE3JArT0qR2oNtcywdxQwLMXDEWsMaNgIcMsdRVXcMwrapt6YRI0qXbNV9rbwhgFcMfP3D7n+edr8QNMeyDWGfGp7IAEdWPn2v/BAIz0kozpkXVALsZeGuRgRf1Vw3iaNmqsZ+hpfKqWVJNtnoVGGA6BlFTmRGikAc2YJCnaRBtbbQdN7lIM1Bct5mma3hOqlQ4VIUMQexjwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcyMZN0RuyQjhc65CB01H31HgGj7Oro9NQwIVEqgGQk=;
 b=gLZQMC9gSo3MhyxXIPnIQILMV0TRHD+EtINONSJBr7qJw7DS4M6VZMU+l0oku1DhIzJF9elOyI9VyPhvimX9L1Z6u3vbMqHNJm2sHdWIca+QnlcLASBKfZXu3qV6rcB1Cm/DLmLh+y8nZYg2R3AXgJXPMDGI8BHSgaPmB5LnPtWc1h1Ndx7mpTwIoHqBKqUoD6EYaWwF981u1bQ4mS58Kkh9p85szhM7VY4ecmh3trwTaEqBnlEOeoGD+IPvw3kKhvazMcJhAJ2ajdfoeNypANJXOYwHcZdHK3wbMnYE+9acpLJPLVhX2P8iTgF6H5CzFs4yQauPcCQpfFWofxjrrw==
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
Date: Wed, 22 Mar 2023 23:52:42 +0200
Message-ID: <20230322215243.249524-8-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|BL0PR12MB5011:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b69ef3-63fc-41c5-f43a-08db2b1fd469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rE0lOWpdmkIUN7x3/SDUk2SWY7d6CXx0GncAowEkhH7XrztgQWW1yKmlVSO4PHb/jRz8LNi0+72pyZMH07zFrG6+RgnruNeSfZYSM4wOK5RHahWYa9SCrDf2sMgCky9DpuQ+xOHlUt1JM1epq3R/JsHLEP7z6JZY7TcaX7Z4/R+IXInz5gvE3a3ZsZqL/eXJosMaZVL6Eh6ttG6Ry7ASAfjaUpxcf5OJcMgTPcl2UJUkzFPlnSzzj+L0TdeFgCUyG65GCSARzh05fIZ2nDdidnEnmTF0XGyYBjZMHCVY5yRJ4Dg4BO+qq6fruuM0isRbe85sKsipcTZuAxyj3izC2wTIefENeK2QWwqRr6ePR/maSoW915sVvImaem3rsk6Zbat2OaWAp0jUgpA9BsPaVAvq8ReehKfo2gh4mhLsgRNsXrlrqNbWe3u7vTQQWbojABJ/ztexMQAuHpp1NzdmxNAQaSSx3c5HkZYVlmMb0C+lZEPDAU+IixbAKZAeBXs//GHpmUMJfgavwKojTMJEY+pQQsP7Czdkp8e9PdvJ9se75dy5kweGzjvwnNaNOS/lEWo+kYTqbFkZENy/8vcUlG+lKDQNReD5U3mjS4V6Y8aYVVwlBCVpXHkuI77DTwQr7o11r6DuH5XhJn816qOu1ErFfZOWQe4Zl8i6IKMblJyBOwP5yiRqaamqTvrg/DhPEvOpvECd9naNxZEOfWjguKulH+GkHSPG1oRxuzdze388HJoeD7SXxmc6UmoLyS2O
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199018)(36840700001)(46966006)(47076005)(426003)(83380400001)(2616005)(82310400005)(107886003)(1076003)(16526019)(26005)(478600001)(6666004)(5660300002)(186003)(966005)(316002)(356005)(110136005)(86362001)(70206006)(7636003)(336012)(36860700001)(82740400003)(70586007)(54906003)(36756003)(40480700001)(41300700001)(8676002)(2906002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 21:53:10.9345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b69ef3-63fc-41c5-f43a-08db2b1fd469
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5011
Subject: [virtio-dev] [PATCH v4 7/8] virtio-net: Avoid duplicate receive queue example

Receive queue number/index example is duplicate which is already defined
in the Setting RSS parameters section.

Hence, avoid such duplicate example and prepare it for the subsequent
patch to describe using receive queue handle.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 device-types/net/description.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index d7c8b1b..435c1fc 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1467,8 +1467,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 The device MUST determine the destination queue for a network packet as follows:
 \begin{itemize}
 \item Calculate the hash of the packet as defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets}.
-\item If the device did not calculate the hash for the specific packet, the device directs the packet to the receiveq specified by \field{unclassified_queue} of virtio_net_rss_config structure (value of 0 corresponds to receiveq1).
-\item Apply \field{indirection_table_mask} to the calculated hash and use the result as the index in the indirection table to get 0-based number of destination receiveq (value of 0 corresponds to receiveq1).
+\item If the device did not calculate the hash for the specific packet, the device directs the packet to the receiveq specified by \field{unclassified_queue} of virtio_net_rss_config structure.
+\item Apply \field{indirection_table_mask} to the calculated hash and use the result as the index in the indirection table to get 0-based number of destination receiveq.
 \item If the destination receive queue is being reset (See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the device MUST drop the packet.
 \end{itemize}
 
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

