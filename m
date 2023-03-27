Return-Path: <virtio-dev-return-11783-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1924FC76195
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:54:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4A42C72282
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:54:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4038598648C
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:54:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 354779863E4; Mon, 27 Mar 2023 20:54:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1DA7B986318;
	Mon, 27 Mar 2023 20:54:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXFW+94tgb5vmr7b7IFNci8xbS+gHjcj4tpF5T5N9x24gNvvscEhiU160EMw5Pi7DOpa7HqvC1/4Juv5U+DJsVo/A8D+vopBscxULj5MWIY8gXCKDYQ2KFCTw+2YoYCrXS2AB8ZhM5nDykU9BGgCFQc9+10YTxZOGjTtZIIzNbBttUr4exJyvB1+qKaY3yGdISVW97fIpyYULhEauB9hMiQaxZmDYslgEk7/vAMgxpmG3HwXiZfIqxXeDPWBxS3zNZYTKexcSBaMZTqXS4yAZX43BixXI2nz4V2kRvCo9qPNXcMQxCOsH+l8XO3m3neVXIqMgbaHu+LxfrzxHvTmPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pv/QXA9hS/AwFYlegISNQ25GEnz9PMI64eQQMoAaRuQ=;
 b=WD2wAoc0Fp9s2EpRpPcJXTKuyUVbslsqc2lzh7BzEvbXiW8qB5AZqLvj/JOiq9vZGiz06aBADzkT+Fz8sYXnat7fERPg7q2UIQzIlgtczm025gkcz/khMnM1IkTVPpl6oCRIg62Y2pxVYqllJbg/zgsh61egs80L/jsrnPUjgSiQ5jytOZPp5fcXtPXpnu69dhI5GFufTYJAYPXU154zs4ILxGnkor4oL/yfSrFquKWE7ivTR97vjCuAaSsiuyoxW0Lme7DsQ8Q7HEbQ4hV4Hu9fJP9Dw83Ck6V3MrGSB0iR/Gbjy3rN0ocT0SMqvBfe3ekWxwsrbd/hVv4EOgwENg==
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
Date: Mon, 27 Mar 2023 23:53:52 +0300
Message-ID: <20230327205359.406605-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230327205359.406605-1-parav@nvidia.com>
References: <20230327205359.406605-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62F:EE_|IA0PR12MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8a897e-617e-4f52-5c40-08db2f056df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y1sY3Aj1okb/0Cw3A5bHKdrsgpdrBdfEjsm8S8HiDhCgke9ZnI3+JWTWnFPxnEs7neQV6WH4Fmsk2QeCA2zwiLUqcQ7DKuSxkjBoLgGkCjAxIue3u5inZPq7w+kZPdn0hGgSNPIh1Wx3OP4xJYJFaGo3lIspskDv7+ct3qu17+p48GdgTeh6nhDwCeYqbHmZT4aYWtfJyo0jpxAB6PNOyJVh1OS5mF25SNwRDWmpbQ8IZf2AsK2Fsd+5uFwzP1RFbeQmiumNMFAsI9b5dH0esBe0NHVaFKVecJ8db9N0ZS+kkMPwdfGjRonrt3yIQHiYfaKE66JQF0TOhfOJvO1m/9dE8crxFDKpvkYuK70yU16i1o2ncL/W3vkxLf9nvjgk73XV37G1ZY1jjX98SmPT1pxKZy4XRSdbYKA6sD9vuCGmul5rTW5tq2vtsT8cs7M3D0jufLEjxdcYd4dDA7NEoASL6hKWO/JNhdjyF+jHzxrh9dNLw7DwpBTYxISKpyPqo35Ofhd9nM/2Fb2xpSdqqrza45cE7lbcFeHaEifvxRYZq4dac/xxpgMy5eGEjRd4iMZjMm4Iaeupi7Z3L4OzHAbgQdictjGriBfAlSGGWGQGrjVBq8JyPdELCY4Q+lPToCbh2uEb5BG1GNcBeYGMA5ELvvq5qucLZTRdahnO0SBjPFcer5MAbOb0rLVZNlGu0tyo0fUs5ytkbs+37wmql30QA89NRk9f9eY4+yq1hm2LA0aqzwEpLaE0uhj9QDfEJar3TG1ECYIGtmtLoe8QmwKhp2HMmrp8EqvWGcaib80=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(82740400003)(7636003)(36860700001)(356005)(40480700001)(40460700003)(82310400005)(186003)(8936002)(8676002)(41300700001)(26005)(4326008)(5660300002)(1076003)(336012)(36756003)(2906002)(16526019)(2616005)(110136005)(54906003)(478600001)(6666004)(107886003)(316002)(70206006)(966005)(86362001)(70586007)(47076005)(426003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 20:54:16.7723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8a897e-617e-4f52-5c40-08db2f056df4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0000E62F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508
Subject: [virtio-dev] [PATCH v7 1/8] content: Add vq number text

Introduce vq number and its range so that subsequent patches can refer
to it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v5->v6:
- moved description close to introduction, it was in middle of
  queue data transfer description
v2->v3:
- new patch
---
 content.tex | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/content.tex b/content.tex
index cff548a..5171c12 100644
--- a/content.tex
+++ b/content.tex
@@ -298,6 +298,9 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
 virtqueues\footnote{For example, the simplest network device has one virtqueue for
 transmit and one for receive.}.
 
+Each virtqueue is identified by a vq number or also referred
+to as a virtqueue number; vq number range is from 0 to 65535.
+
 Driver makes requests available to device by adding
 an available buffer to the queue, i.e., adding a buffer
 describing the request to a virtqueue, and optionally triggering
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

