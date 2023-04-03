Return-Path: <virtio-dev-return-11943-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0ABC76188
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:51:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 767CA33567
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:51:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 51FC5986638
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:51:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 366B3986756; Mon,  3 Apr 2023 22:51:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F12AA9863E4;
	Mon,  3 Apr 2023 22:51:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfUKPmHGn9whfJoupWbkL8da2fA/vt0cuTzwmtHhTdZq40swNgCMrYMANF7/KH7IZukNj2TCs+CXHg2fPosmSRw++l/Wj+k1n054Z0ZXZxk9clC5dYdnGM2huwZoWUuvla9U2cU9Lts5vex++ULPiWQt9A+idYOd4kxAEM7RofAIpuxcN+lDqUF/gswmVoYN6RKQ+C+koK1hMuXiVpPwI9FEEcfKstNopGI/delEs8N6a/9+QX1K9Ue1TDcO6nibH5CgqYHovDHbSeJOEtbq7ZUIMD7EXlVhGV/WINF9DesJ5SN0CZAqlz3DSEXVzpvI638oWuYccAZ+oBPcNSEQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60FISabB5pRW6101vBImzvcoqbHBGwmDDwcvde2FgIU=;
 b=eueobMwrMT0VvUhDxboTQmVX83UFRzMVqPQ+m4OXmJ1PyzGBE5Sr9j5pyS7eMO+bWHQRED5/tV8CVAo9TfcUDsrv7ETIJHSRAjwWQVy7hPfkMfRpyGor/IP1409E5stQatuo2Sba/KhxqnT+bxUwT15C2aJTyRVOJzo9UI504XKK1p8u5o1uz/JpzX81fz1H6UZMboxtH0CCYwcv0pn21au/86xcXKdBtziK31jAoAz0pHidWcilCnKeAX2LEHP+9rTmmImKxrIqxZqDh8ZMkNJrsxNvS+fMxmxcv+WjvThLPFGCiaLYq5t4PzzSe6GdoHF7Db3/PtWJnYN33Xi/Hg==
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
Date: Tue, 4 Apr 2023 01:50:45 +0300
Message-ID: <20230403225052.585498-2-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT049:EE_|DM4PR12MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a58eaf5-09f3-423e-18ec-08db3495eda7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ruumTcd5OzD9c5wXr4+PYJdb9DQzbPTMyB12CSXR/QCOEMsRFeNJTFZQ2BY73bN/82lLlANcjiNNsfcqlZkIbca+8pI6YMdWWtJWrUbIzisyHd5ZtkHVFQpe2G4LbbKECSxBn+bQ1sa/Mz6DmQVsLCSJ/tUcH5xL00QCVhxPd4qWXpOPwmbB0eOxdHFpZ9ayVd1DcmRAjFWRk6uchL6WNiEvyteQRI1JcPlOatT16KfOfDuwMkRDMxfKp6tn06nwMrSCnl04lZufrG5rNUjUJy8oNff9SkCMsbyjvktQHB3wBtaZZ5S7Z5egT34ud1VR/+9tUrgN01VfU4s4PkteDw5srS8GtPxceZUN9NzbkvLGH28tEH229siZqR5hagjJH6GMcVpPR9Omd+UoEG2B7OwfAGVDL6KgMHHheq/lagjhF349DbrUTedgi1aBb4hkJlqce8VVgacVF4QOvdKWTg/cHXaOfdQvcoFtwz2i/1uVI7nUQk/8vmv/GkrTI4muYXB0ageEIzyr/4i22dsEwfApuvSuW9s+SuoeZBn3nwIp4NVZoFuolwsM2Ph7NSQB0+GjtyfipdWDDLxK14h0K9uOftQXFnmjX3SlyvzxmxYm73watxvemHQHUYeoGYfQgshH9jsN+fSfpiLhKYRDf02Z9X3zIQfutxQQKACr9akInnogqmsdSDaEo8MHJUTIRLfrAFOFEUbIdl/+iINbn3M30A0fEUrcOr5RVfU+4jVp1g4yIN2gOpRt6QCE51zUF/5VfBx0jbSaa4m4m565vUYCbmJOvUvcC04vAkNO1kE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(966005)(6666004)(4326008)(110136005)(54906003)(316002)(41300700001)(70206006)(70586007)(86362001)(36756003)(426003)(2616005)(16526019)(26005)(336012)(1076003)(83380400001)(107886003)(47076005)(8936002)(2906002)(8676002)(478600001)(36860700001)(5660300002)(82310400005)(40480700001)(82740400003)(186003)(7636003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 22:51:14.3417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a58eaf5-09f3-423e-18ec-08db3495eda7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7669
Subject: [virtio-dev] [PATCH v11 1/8] content: Add vq number text

Introduce vq number and its range so that subsequent patches can refer
to it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v9->v10:
- added braces around vq number wording
- added vqn as another term for vq number
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
index cff548a..7bac167 100644
--- a/content.tex
+++ b/content.tex
@@ -298,6 +298,10 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
 virtqueues\footnote{For example, the simplest network device has one virtqueue for
 transmit and one for receive.}.
 
+Each virtqueue is identified by a vq number (also referred
+to as a virtqueue number or vqn); vq number range is from 0 to 65535
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

