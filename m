Return-Path: <virtio-dev-return-11990-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D3BC76188
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:07:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9414B3E335
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:07:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 88DC498658C
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:07:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 792A698638C; Wed,  5 Apr 2023 01:07:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 62CBC98659E;
	Wed,  5 Apr 2023 01:07:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGMy1MgCpL56bs+UozTG62fOLj+U2yATCfLK68fZZqRTPWqRL36H2rMpVjXONNaF5ZvsMV64tSpPg1rPBPzQOpx2zZhPw1lk01W8/GqSKzZeRSRq+6qlFM8mIRfduimMPMVNLzwmEJA8Rph4dQ/mQNlEgqeu2mfSojLXhWyg8RYs8wKjcfWY3zbwbNYlBKrdw30mdGSjYHAsj13WPoQP+/7vITp6P4fk5kwQxd9bj5LCwO2egCNvn86YIjS/u/ffFcmIH64RJfMNIntfR3veXZK76Qi8oCrNaCroMgQyAaLsGL/lq6Tz2J9D4gTlL2CQkiziXDXfs/xJvmqnCd44bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSBs4KPxOAEzzAijzeN/wr5biXE8W48tecW02bq7LBs=;
 b=XvmnJbJHjROOVYWb+y5iGFpm9DEADAj5hzgnDpYGhWFf7pL6QVBZ8je/rEtT5QTXmrSzfjG8k1juBKxoe+f2kFyW8GDb+eiwx0dBED0n2Rv2xismL+M+ohOD3KpyJ2odGo4iXbr2AmeRacy6sja4DloIClhErKxilVhZF02uIDQp9u0p0OR9E84jNOR8u9V8I/RfJsHxVxNYuA9feR+MZ5V6jIdHFfEmqkfii8dxp8ISV3M1wuKyBswv1MBpjsXXX8t/rX/sY/Rz7Q0vFaOrEvdCSOCbptsFR/otpZQYT/BMcarlR4lZvqf8adEtCPqkjN9KJZ6pEvNm0vfZnUHGaQ==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <sgarzare@redhat.com>, <pasic@linux.ibm.com>,
	<virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Wed, 5 Apr 2023 04:06:48 +0300
Message-ID: <20230405010657.612529-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230405010657.612529-1-parav@nvidia.com>
References: <20230405010657.612529-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|SJ0PR12MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 10cf20d2-1246-4efd-838d-08db35721daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Avg16Ug6PlJjYHUCydsoVeAdf3wIswQ/az28qWOessSQf78GDutud/062KA9jNyJKCFWasARQ3prA43VxhSMr2awTG2MOQ3FmdgAfA0aNcH6Uxfm6RUh7pGCFGPu31Ol1RexzY0P65kLRqQYmf0YTWL3pZ/4qgJ3Le4D1bw6SCmj3Atb9qJn5FtJbjziEAjDHBKkD4xOfz+gxPdqC/FI7L4fxAD2iQX+mZercCOYOkNOZRhq9ndmeAuKgJIJWMySs15zG7qADL+3oi1iUHRcU5xr/1sPsEyGjBO67vsxGp+IoMNt8F32xH+138VstI+GTwUlkpMw6uVcN2hi9kbXmv5Vn1jnfd5Jmk3T3tFu78dMc7pH6nWnSE8maxTlaky452BoCSY7+7mh6iBOql/mpzxR2JxFm5LTLGdmg567+2T1Jlzv3xG/VpN7VqTXcczdk0rRPPAoEhHBlPlPeUNHhpH6budnsAO1SqGlYmNxKvBPBUPJiaj7z9Jz0tSVynfaQiWWANDdqU/SGX5nyF3qNvenK8lgg9QGMkRTlXKIS1T+Qd9mMcL8IX3xqUoSPjAudluRiUV/gv2WtZMCMKV0RPtD+JAjIN1aYJeDyuXMwST3dmDvHJbPaSHwsj3BQqPLCy3uKRzuXKLyjtJE7ltuhVH55HHi6tpqQD1BM1fFuUD14Z5La5FBCVuDMyMLZ4pbW56ZS2TQHuXThGmqjSHJUw0Gts8vcEi1tuL/aiBQ/OkOHyGATw3w8u8dfOTsZtcNfrZRsLvhiVbQ5T9axb7b4Q/s2EmIT2xM3ddoWEjPjDI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(8936002)(82310400005)(40480700001)(16526019)(186003)(107886003)(6666004)(1076003)(41300700001)(356005)(5660300002)(86362001)(26005)(426003)(54906003)(47076005)(70586007)(40460700003)(336012)(110136005)(4326008)(83380400001)(316002)(2906002)(966005)(36860700001)(82740400003)(478600001)(36756003)(2616005)(7636003)(8676002)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 01:07:24.1611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cf20d2-1246-4efd-838d-08db35721daf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686
Subject: [virtio-dev] [PATCH v12 01/10] content: Add vq index text

Introduce vq index and its range so that subsequent patches can refer
to it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v11->v12:
- renamed 'number' to 'index'
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
index cff548a..e64115c 100644
--- a/content.tex
+++ b/content.tex
@@ -298,6 +298,10 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
 virtqueues\footnote{For example, the simplest network device has one virtqueue for
 transmit and one for receive.}.
 
+Each virtqueue is identified by a vq index (also referred
+to as a virtqueue index); vq index range is from 0 to 65535
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

