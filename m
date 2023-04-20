Return-Path: <virtio-dev-return-12327-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A64C77B73
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 19:52:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B67CD42564
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 19:52:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AF4FC986651
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 19:52:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A3D60986637; Thu, 20 Apr 2023 19:52:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 052A99866BE;
	Thu, 20 Apr 2023 19:52:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K26ls2DLUVg/ANtfkAh6SsSj6fl/jtsYWikRA9ZBAAlD4YT8JMiz1j1yVdRnwLGMVHymfD9eriuvUpBt92jxiliPlBg3jlmZsX3+KYE8wTmLY4l2+PnHjdzr6vKcrPyDftTNi0UmmCzhb0W9ZCOpcMv5pjm7zmG63FbPyzn4/eilr673Bo3VIfIjOORJoLVGcsK5zwYEA854QnWFke1/8w/6nQnhK7XveGJ+vFMYBZh84pHKD4N3T455VhGmhliX1UFdfwnhfqUZQF6usX3byzgFe84RTtwNQar5ldYXQMrVFEnNkhvgIFKvuRf4E/tJAj1wHBQ1igOmNR4gUPQ+IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qir9rysNOg+FquHyaQgCylgY88A/Pm1Sh0YqrzFNS4Q=;
 b=EtJxlfT4P1JCemS5VHt61JZSnjBD+fbcdkAi0JV3/fvIU2ZN4Hup93xQevCcGCouDcJvRA9JvNMF6v4gN0fRbSE7DO0D1JZjAFdvswJNPc1bbZ4bF/PrKKWOrUNTphtZH+CB4+yBwk5n0CPeKoY8nnlUSOmirp6Gk5emDvJudIMD486xsWx96cJI2a5STd4RKKpmZvtvQVq2fT0fmJjPq1bd3ezGakCMFvu7aXysYOuOjCdnzuTA9OWrPW7OyLDS0lC/d/d1Kd8vAdfTnfnZYTPdG/6WpGS0cGm8nBW90ViH7Xl29uHGPL/YeFVyZK480iEA3neHuqK75V4dMHianA==
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
	<parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Date: Thu, 20 Apr 2023 22:51:58 +0300
Message-ID: <20230420195158.69737-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230420195158.69737-1-parav@nvidia.com>
References: <20230420195158.69737-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT092:EE_|DM4PR12MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: dab0e524-e37d-4dfe-7c8e-08db41d8c0a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JlFfMStSsfloduo0gcq0yw03zdhnAhna34al5/SXVCdPx1Ipg0Punyhj9xVKjsOrWEtp0pbIY+F0ezQG0dwrlVaRoL64Z0dHitxphMcJ58cv+d0V2oLfyEP5r/lghs3xWUuvY2yhDkFb4qB+HhdsSP5O8+2uvCxQA55EI0Em1nJL0MYnz82UN/7TiQcEewhmNT/2B7DK5WnsbA7E9jlxKkZ7rISBwSjDTaMu4MoKui4E/zeS8tKKjw+Pt8+jjSIRdsfoolWXClMAohM2fI7+5zc6GZtD/nhIVaMjJLC0MhMyioKOJXAkrNi3433TQUBu5XQkxIljqP2w7f7LiNAk2kKNCoToOlvKf2BsIDjTyNQp9lr8STdoMttaK/JULXBUWdtiW+DElWvNmx8UGk9VRaFhKqpZQVuMt/gtkrdA8wjuYn0fJ4onmQGYW1DCNnZwNavn3tozPxYhlPI38dTwqT/nGay11T5jyqiGSKYB7YJNUhzqWWluBaUgFWQvMwHiEsqGG+D3JuUVODsltcKsbAq+rS9Y8cRzojqA2KQ0IE7wlTCl3/o1jt3KGu/8x03/rkFnduf02lmuP6+rp0Cjjyo0uDYEjmpjC99nUcBVaLL2wrMw9P8k1kb4AjXHWX91b1tdp+gg84csIOIb0mCi+DzZIVWTjafKN5+V8pwCCRqevHP0lWrNvV/shSOV0cFH+2OLRryQ0EmFcBQHlSNPOkGY0uVD5V3074UaXB+XY11P6xbtHuSVg/iOybPKXA8/7B2U5pjU2Y666D5XfgxdNbVVBEKEMauG7CZjWhzMKWg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(34020700004)(54906003)(83380400001)(47076005)(478600001)(36860700001)(2616005)(40480700001)(1076003)(26005)(107886003)(6666004)(316002)(4326008)(356005)(110136005)(186003)(426003)(336012)(70206006)(82740400003)(70586007)(16526019)(5660300002)(8936002)(2906002)(8676002)(40460700003)(7636003)(41300700001)(86362001)(82310400005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 19:52:20.2503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dab0e524-e37d-4dfe-7c8e-08db41d8c0a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889
Subject: [virtio-dev] [PATCH 2/2] transport-pci: Improve queue msix vector register desc

queue_msix_vector register is for receiving virtqueue notification
interrupts from the device for the virtqueue.

"for MSI-X" is confusing term.

Also it is the register that driver "writes" to, similar to
many other registers such as queue_desc, queue_driver etc.

Hence, replace the verb from use to write.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
changelog:
v1->v2:
- rewrote to indicate MSI-X table entry index
v0->v1:
- added 'here'
- dropped 'receiving'
---
 transport-pci.tex | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index cf2c54d..afa082f 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -367,7 +367,8 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         A 0 means the queue is unavailable.
 
 \item[\field{queue_msix_vector}]
-        The driver uses this to specify the queue vector for MSI-X.
+        The driver writes the MSI-X table entry index in this field for
+        virtqueue notification interrupts.
 
 \item[\field{queue_enable}]
         The driver uses this to selectively prevent the device from executing requests from this virtqueue.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

