Return-Path: <virtio-dev-return-11270-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA1AC6FA8E
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:28:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 60A3E731B3
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:28:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 59A96986794
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:28:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4F0D79840C1; Fri, 24 Feb 2023 22:28:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4752D9867AB;
	Fri, 24 Feb 2023 22:27:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MntUdsBPHSsd72fva/b2oe4bEkXaCojhyeUM0VnHNvGQd+/3F7JXCnpkjJyicf96bVZ+C/68Mrs+a0F7scWjX6wZQJWp0apv4d64E5sHpFeTrNZNAKmijWSepfz4oGaVF4QkJETJ120fIw0HhFfd7X+Qpv5oNLV36L/YezHfDg631QBxKLWafYdHxqqMEBx2/2i8qH+md0CzRCxoBgRNW7v11lqZsYq+z4gJ5g/llwzyVXtDucoQAD1ga0QNpdBSEi6fu6u/+4PHWuBEex397lnN4+ZYtNU8h/95JHNZnBnI6w5dHlH6hFqz+rxV/eCYMnXVWTDB1naQrfMa9fZa5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6veOilgGYLT29abpwBKxhkc5O6vNypjjoZ4weQwZK78=;
 b=avR6NQcxWy/uGhhnkQjKPDsxiAKaHycxRiug7LDoy3qEZyxZ83H73J5Ap+rgOHGmk7dASUg0j7HBXKJ0JgrbbYR87P7xxMMFdnLLn3YQ/VL/n/4U8dT8iN+q9hiEnMEbuvemhNv3vjhz9P3dsviZhK3O8TUkPEwtgkoHnosJNTJoYI1956EbVwZM0nEYD6VKbqNtL1P6H2gF+93qkZtEipDDyBg4fxdMlKN8DwYzq59GQTceMAWa4wf3sstQRWivP9BRL8eRFohxRZSPis8Nbqtl12WlC1tu0MpyHRZNs5Syq0dV5Sm4odI3JOQAxBHEL8QILdDUy2ZYm5qUncQhXw==
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
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Date: Sat, 25 Feb 2023 00:27:17 +0200
Message-ID: <20230224222718.339883-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230224222718.339883-1-parav@nvidia.com>
References: <20230224222718.339883-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|CH0PR12MB5217:EE_
X-MS-Office365-Filtering-Correlation-Id: b90e65d0-dc4f-444c-d075-08db16b65d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7fGdUGAtw9YBIcgIXrMxLoXxBL3f9kv4t5WVs/ZJkRGd2/DNbxeTPhbjb14G50nwqcqxd9BaGsWvOwX7o+mINf776gpQ9uKoSs2vw/EEmCLcxil4aJEwj+kdyWhwI55SgUwj2zh3CTTJAXABUimV190lwFjqTiwtURTh1wE4tsLnG8kvfLh6AvM9/scpxk+OeCJvK1PQOF4zC+Izrks9tH/jHMUtFNot+h5/+qIuI/Ybeie9OPpffunUzMwURYhybmOmUAP0ezbAPQAjUw1V4KmGD9UaeHtRaV8k9tJ1xxCdBBaLPypPTUTi70c0uaJxDQW/TLyhezKRGzcTaNUv8BvR1SfcPAJofyOmh8z4WVw9dsFcnzgQ98DrR0TBZAO9QoX/8TwWbhRvdrItETN9hAqDzlfU4E/Z6q85Rsk5Goyimb/pjVxg9lEiaO46v/Qd855tydNB/hkYjsFKWDsd/ZIQopQkZJ7U20b3nRlzqAcvvfPcX0G1iqrbNfY1t98xHR2v2wNekkf7H+jgIpd/on4zcMdJaRbTd3yt7hV75fM2ibdzJho7vmhEQQNDW9f1QmGGiEXmiQiFlXpXXx5JpyB+AMUMoap4n/I1WoclmCKAEEbwxEfyuQZqWLrl2vy6WyFOYEcYJLyIZYATRfqoCqfcplfoRLXAieMMJMtUdPWIs9F8IJOgl2wyDi0SMH+k8N/QIGR2j4+Og1MJU3MLueY10noH1gwa+2odi/1uX+9pAwlKRIP3V1owEKGNbC37D96EcteUZcPykkFIUYjEanwE8cYmHpnfIzpJy23EUU55Y2GT+F3ZiLS54f2wRLzb
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199018)(40470700004)(36840700001)(46966006)(8936002)(2906002)(5660300002)(70206006)(70586007)(8676002)(4326008)(110136005)(54906003)(478600001)(316002)(966005)(36860700001)(426003)(47076005)(41300700001)(34020700004)(1076003)(186003)(26005)(6666004)(16526019)(107886003)(2616005)(336012)(82310400005)(82740400003)(86362001)(40480700001)(83380400001)(36756003)(7636003)(356005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 22:27:50.1809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b90e65d0-dc4f-444c-d075-08db16b65d09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5217
Subject: [virtio-dev] [PATCH v1 2/3] transport-mmio: Rename QueueNum register
Message-ID: <20230224222717.Hd3oND8m-4cGQQiQNfKU2ADjX7UFxS7HZb2AJJlkNr0@z>

Currently specification uses virtqueue index and number
interchangeably to refer to the virtqueue.

It is better to always refer to it the virtqueue in consistent manner.

Two registers QueueNumMax and QueueNum actually reflects the queue size
or queue depth indicating max and actual number of entries in the queue.

These are further named differently between pci and mmio transport.
PCI transport indicates queue size as queue_size.

To bring consistency between pci and mmio transport, and to avoid
confusion between number and index, rename the QueueNumMax and QueueNum
registers to QueueSizeMax and QueueSize respectively.

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-mmio.tex | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/transport-mmio.tex b/transport-mmio.tex
index f884a2c..1bcc194 100644
--- a/transport-mmio.tex
+++ b/transport-mmio.tex
@@ -116,14 +116,14 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     number of the first queue is zero (0x0).
   }
   \hline
-  \mmioreg{QueueNumMax}{Maximum virtual queue size}{0x034}{R}{%
+  \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
     Reading from the register returns the maximum size (number of
     elements) of the queue the device is ready to process or
     zero (0x0) if the queue is not available. This applies to the
     queue selected by writing to \field{QueueSel}.
   }
   \hline
-  \mmioreg{QueueNum}{Virtual queue size}{0x038}{W}{%
+  \mmioreg{QueueSize}{Virtual queue size}{0x038}{W}{%
     Queue size is the number of elements in the queue.
     Writing to this register notifies the device what size of the
     queue the driver will use. This applies to the queue selected by
@@ -471,7 +471,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
 .
   }
   \hline
-  \mmioreg{QueueNumMax}{Maximum virtual queue size}{0x034}{R}{%
+  \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
     Reading from the register returns the maximum size of the queue
     the device is ready to process or zero (0x0) if the queue is not
     available. This applies to the queue selected by writing to
@@ -479,7 +479,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
     (0x0), so when the queue is not actively used.
   }
   \hline
-  \mmioreg{QueueNum}{Virtual queue size}{0x038}{W}{%
+  \mmioreg{QueueSize}{Virtual queue size}{0x038}{W}{%
     Queue size is the number of elements in the queue.
     Writing to this register notifies the device what size of the
     queue the driver will use. This applies to the queue selected by
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

