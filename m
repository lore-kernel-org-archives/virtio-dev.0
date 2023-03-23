Return-Path: <virtio-dev-return-11738-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21674C6FD1F
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:00:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7BE2E2AC75
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:00:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7438F986460
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:00:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 628AE9860C5; Thu, 23 Mar 2023 01:00:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4B8B5986456;
	Thu, 23 Mar 2023 01:00:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EB5CCjkHK2vbwYXfoHKgXyWFgY3A4BsLPy5HX/gTtKOLjncjg78nA2YnLMJMeLFzORbUEpCxVAy7eyJGIfheElbvo+hR/+oGDgncllAn19csxxnFiGTZvgJgCahgQhQjYj+xd9eu/zRYipE+5+sSO8CdsIwzXBOZYcNqdbmTQ5UUiB9n+RZJwZfvT++S568ZJbKO/2DVfPRqsjOs9vg3ONLun9+FrJcc02WtbQVch4GoXV+k30g+Zud1MeQP95MBYZP1wlcjkBwoNhuLVGQcn4DtbiwaA9v3fJCsWeUOEIlEskZZgfoVhsqfu2AerjKKBiLIud2jEuSpbI4zZGbW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zScwm1MtdLjw4GnXL0eryLQ3iiS/+EeFqnSFtrsCQjM=;
 b=OHJrhzYZSkkkX48/F6CLFhgk50p3M59rSxPT6PNj7AvpVnOx/EpnCvKhZLS3Tl9PPqts7rr2xyFaKyphqcJM2fgCyT4tYoZGRSbrQttYszGoG2fRFjGSF2ud6V89QD4fQTGPiFFvIafKUs7cUAEAy2gcAovzYCgcxO2nM5kufHtukIGuGloT8ZRPBrA6vFhcTfuurAiOIf0ROBZ9eY9NCpQammaBsMpZBDh+EAQWzQ9Vkovm5qASbEKbmgeuKxw0Lh9VmgKQwyfbbjgY2SWtX13jdoPI5DDYK6lm2ckMdp+8ybfyeWCMuPlJMZsLpdDKLOwYoQ4H2jsvCWO/2AGkAQ==
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
Date: Thu, 23 Mar 2023 02:59:37 +0200
Message-ID: <20230323005944.262738-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230323005944.262738-1-parav@nvidia.com>
References: <20230323005944.262738-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C980:EE_|DS0PR12MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 1852c57d-c943-436f-0ad6-08db2b39fcd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JP95IYr7qlqTPovQIJ71+Z1ZyxiWJAU+FHQDLw2bOA0hY5to288V5Q4BCxfzTcVOEh1RVf5OnbX4rga1GSjzNSJU1nJdfE6ZEZv6O3vN21qgHU8e5gqGYYkg/TKXQujtuY/JpAakbDMRjY6SErY9x7bI4CyDkjZCY/2CQxzl4QY1zZAUY0UeScgR7yiRb31NUqbaeW5bW9qfqWsQkjKZqnA1cXKMpEfmJ0gNcQwgDBDLLSQITcL6kxx1rvh6kOrbe0AqucKY9eZv9werzLPSmam4AQHsFdVOUWuGBp4YJSgBVpy3yZ6H+U5WjqA/oKnlaOvCifkAsrjgGfWSD3F0y+NpBsbMYyBboTD5TQzh2fPEGxmUWXpa782nHyRlGBEXrdrtE32BaT4zHG3Th7y38/obd8ov8DQws0QbagFJ6BDvHe4EtCyk4824kbDNJ+lWDwkRo6wYpwRHsTUsLB72SQwqLBKuV494IrPiO2d1APjgEDFLqGIpOuXMAPptZNZP5qgDopK0DfDUraB4bKJT44mrkh+tqp/IX0fq+M9NlEgckMaqPaY8psNXe+KHNA1X8O+Pf7HRkSuvL7CG8F0IZ+QIZYYelcyORBxwDzWJ1vaCLv3b5+QSPi6GjzoVHrbZh74kaptN8YAIPNFuXYcDH1xBw9ZoGjoyLbCKPBH9EUvrhUaldNZUIUy6utyPhQRZOLerkHr3fIEVNhk16D6l67cRV/pX+/j/CPcqw7phiJPhgE4ryL5fnmtmvWD6iaUO3yCIHwlYrtq2U99FSoYzww01oIQ386Ef/fENW0jUqFo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(26005)(426003)(6666004)(1076003)(107886003)(47076005)(16526019)(186003)(83380400001)(336012)(966005)(2616005)(86362001)(54906003)(110136005)(40460700003)(316002)(478600001)(82310400005)(70206006)(70586007)(82740400003)(2906002)(7636003)(5660300002)(4744005)(8936002)(8676002)(4326008)(40480700001)(356005)(36756003)(41300700001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 01:00:25.6625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1852c57d-c943-436f-0ad6-08db2b39fcd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C980.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927
Subject: [virtio-dev] [PATCH v5 1/8] content: Add vq number text

Introduce vq number and its range so that subsequent patches can refer
to it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v2->v3:
- new patch
---
 content.tex | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/content.tex b/content.tex
index cff548a..1ab7794 100644
--- a/content.tex
+++ b/content.tex
@@ -321,6 +321,9 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
 VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge
 might allow optimizations or simplify driver and/or device code.
 
+Each virtqueue is identified as vq number or also referred
+to as a virtqueue number; vq number range is from 0 to 65535.
+
 Each virtqueue can consist of up to 3 parts:
 \begin{itemize}
 \item Descriptor Area - used for describing buffers
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

