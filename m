Return-Path: <virtio-dev-return-11822-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733EDC761A6
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 20:18:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4C5051EDF9
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 20:18:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4229C9864D7
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 20:18:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 368329864AD; Tue, 28 Mar 2023 20:18:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1E946986492;
	Tue, 28 Mar 2023 20:18:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQpJFJrRuwbr+Bz/Ccm+sQAeHhIkvmwwUt16kwTvnS90ZjMOQTRil4tuur08efAo0yfHMDl5zIKMr9njzRwWe5J4ZrygO23PjlQFvS2kAz9G8+AsTAs4VShHziHUE2Sz8OriWbmAhCd4tk/r+pYc/w/6MLr3SI5q/nRnRI9GD1ere5kyDuxIK6kqL1HALk3I5q4bEDyoxXsSIX/KQOU16uwVqAeBDjnSk2tuoAEDQzTrHw9WX5ccI7TP8yvz9QOdZ088ORKkgCP0e29YnM6bLXM3Tvl1Mz8Mp9Jf+0qEZByPi2TLvza3Fz8EYC5vfSxs4lQlF0PCJo6T945PEfFXXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGCDo4OvQtyOe1XKSpsrPkoix6kGf9mCoqMe08Fi9bo=;
 b=bvF8U1YZMiyS75tt5bcz+qr3qVszTloQKAbEGX0pp1phaaMs8qr7tW0JvKZYwg5ZjztJ6Z3RdcQe/d0SBIHjEetvwmUW6blvi8LkCtDgKPcf/C8Bi3ndKoii8Q32CUCMCarkLTKSEimVKKvgQDUd+7dMk1tKB5kLJGkgfJ0IrWSLvi8s4/8ACrjh9f6O9+wtVOlCXNnRUIZBN139tlPejjBnmA7RrPkoXx1oBcrme+5vSsMVsk6KoADjwZzjr7WLeynpo/ZPki7JNArdTPag0Zx/wDeHZ7k9At7KgvsZYl278fPYlWYL1fyixm9ylZQBrSRD0UX6Q+vFTMlNvSHB8Q==
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
Date: Tue, 28 Mar 2023 23:17:47 +0300
Message-ID: <20230328201754.440974-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230328201754.440974-1-parav@nvidia.com>
References: <20230328201754.440974-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|SN7PR12MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: b37885dc-e0ba-484b-cf27-08db2fc994fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7D7h3ahaYqY09VkNNoxeb7vtNnvL7flih5MzK9zSX3lH37JyLiZO5pmqiAabi4sLpIcNnr9az4q8SDW6UAVQnAynnMcxBAq97nEJ4LkP2hcuoPOFCyPeO6XY4UcrDKZigJVwOx2axe/BSb+q4CFd6UHVFPP/2tUSWcMgavti0nFabCWpKxdEfQPmlWt8UXDoaTfeyehv60uJuxDR1bi6kPeIF+HwRz9sSg2hGRbQCcD5NngGtCoXMZpK6a/pMVBegXMviQi3+ZLwtnF8y4y9fjOXzdOBsQWHbD0zPQ0YRZWmY5YvNbu0ptNTu3hD5wDzPZREib0mq1Dr283E1231fZiq/CToIQUMGJ0QaiLCOY0FIiNXdX787l39b/X/RHjyCuy9Ty3A87WECLF9hhMHhwwZJi0AtfbKa02+vcpzdlolsVd1bKG70BGccGNjbqhthG+0A4TZnnQeLDx7BYy4cT/5N/uWgjWdOTnzvdhL9XM6ro6fm97KCyvMzENaGnZ7uVRGnCHjWJAoXubGFU0zcBgZU8Ct2Q3RUd7FSlNB+0PQleC0W1TtnS455mE0jK8FJF5hLtmfDOOrmihmtZztIJ0FSN7SLGxi6S6M83FBz4o+UjqlYsp+Y/nR/ZS23KlKku8KeaQ8kAXMpTNBBGNQ997KIVvNiHLpMZ0Mr++xSbkw0+UPB1sPAFwgcdCabJP4DE1cl2CrPOUPn3y280QIc2we5dQ+X7tRa+x6cKZAIaoZxdpr3rR8d0e/2yo0g24a8ksSaCm0Cp0d4xUkZ8t7Mc4KYhm6j3U4xrSMEXLVklk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(8676002)(36860700001)(70586007)(4326008)(316002)(70206006)(82740400003)(8936002)(1076003)(83380400001)(356005)(5660300002)(7636003)(41300700001)(26005)(186003)(54906003)(47076005)(2616005)(426003)(478600001)(336012)(6666004)(107886003)(966005)(110136005)(16526019)(82310400005)(86362001)(2906002)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 20:18:23.5528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b37885dc-e0ba-484b-cf27-08db2fc994fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6887
Subject: [virtio-dev] [PATCH v9 1/8] content: Add vq number text

Introduce vq number and its range so that subsequent patches can refer
to it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v8->v9:
- added inclusive when describing the vq number range
- skipped comment to put virtqueue number wording first because we
  prefer to use shorter vq number as much as possible
v5->v6:
- moved description close to introduction, it was in middle of
  queue data transfer description
v2->v3:
- new patch
---
 content.tex | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/content.tex b/content.tex
index cff548a..3766bf9 100644
--- a/content.tex
+++ b/content.tex
@@ -298,6 +298,10 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
 virtqueues\footnote{For example, the simplest network device has one virtqueue for
 transmit and one for receive.}.
 
+Each virtqueue is identified by a vq number or also referred
+to as a virtqueue number; vq number range is from 0 to 65535
+inclusive.
+
 Driver makes requests available to device by adding
 an available buffer to the queue, i.e., adding a buffer
 describing the request to a virtqueue, and optionally triggering
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

