Return-Path: <virtio-dev-return-13178-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9F3EB64DA
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 04:20:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2334342C24
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 04:20:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1656198670C
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 04:20:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 09175986703; Fri, 30 Jun 2023 04:20:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E1D089866EA;
	Fri, 30 Jun 2023 04:20:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AO/FKrLSBCC07CAVFvKRBsmZWABEUX8A0mXJprg34AAYBXizYC4Hi5VUxcSGRNuwXJwn9Uu5r/QAfLucaBQrpqHwlas9wcc42MFSqFduSgGIcTystr8YUYmIbkI6bw6nHBK7Z4dkaZ8iBYC3y1JtQUEsShpqJ+qLbQXNCBmaFWk74e9yL8UXPNRvkt6MY2M++FT+9OFCz1YLcKQlwt0TVS4LUiRpIgaJpYN6rvQTG/vQvT67ehTsx0ss70/iOKjkwSSATAVysBL4smLubEOZMP2UqDv1DBceKX4nuoaMHqJcv1w7GEpGxhGWXmqShBKTDsDGOWDww9JXg82zB3tzCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpnhhKY+AZMWGOlUxfddk+CfiwFN+mL4rsv45y7CulA=;
 b=cmSHh4kF27QJnfJiRl2La+ode4WrknagLpdsokXl1iP3Q6J93Tjxfpib5KiYyUv2Xi1M/c2Q8CbNNPJt4Q/6cuwy/IRzIV6L8P985v9/svNoAhQ1gtJ9Kc7kvQZokykbEA+dh2mn2QQFNO/w/InGnecmbKGt5KbWzOCHjca3z5jYB33ebTJgAM5jpbDZGrSw2b5x/LeTTr43Mo4g5+qiAQ9Vrr9jitBTCLB7b+xdAO39d6I3Nn1I4Z/OBrc0MMKIukaSgIkwcr/fOxWGZFWLaZkuSXC/OcqXMYIn1ojV9iaD0VPt3Dnar9x9o5x505zSolmRbxu/wM6TvocF30rhVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.oasis-open.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <virtio-comment@lists.oasis-open.org>, <mst@redhat.com>,
	<cohuck@redhat.com>, <david.edmondson@oracle.com>
CC: <virtio-dev@lists.oasis-open.org>, <sburla@marvell.com>,
	<jasowang@redhat.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Fri, 30 Jun 2023 07:20:03 +0300
Message-ID: <20230630042006.1569920-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230630042006.1569920-1-parav@nvidia.com>
References: <20230630042006.1569920-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT087:EE_|MW4PR12MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: 10762e4e-5fbc-4e36-9adc-08db792159d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XQFXOfmn/UVZz9h7aP4BT3ZVDJUvZdsw5AWWC2kgVWzVum9ihayoOaSr33QPU0UTNiO217G6H7q0cSWHAwe5Qd5Nu59lE8IFBAuy/5LPRSWcFp8nyEdKMBKEBH21NWklIDqcLrhVJzZAoHPdV8KCfOWuWIs9eqQlsuXJxbuE3qcwLV1XAc1q8GCCNpSPGfCJkEEtyn69JeASbo4cFTgRktbLd7ji3kyDAcBZ5EAaU6nTD4KVKH8LqUjV6bXoPjq8VxF8eSFmrkkGIe/57xNxNN2WWC1zF6ZB4vtgzEsr72xNSlay1LUHh80QXBafnIZ34VznupBJnD4VsIjyAxyj8EpnGICnikAxvfUpJIcU5wpCEosKqC12owPG67JKweYsTghdEdZ32uYOEN59bI7FnX3zUJQNY9IZgey1aDTkVhOxxmKIOKVchugqXvHPGXMQzbPUmqr4LoRkJfM4eoqJ3nYuF6CmM/gcC1mZ5RWEuUFsF7uHZWqPOGqrW0BHDwjib+X0H99S7tlCj5CT6oMu3scyRE6/PwBq0a71S00fw7jn00O3+FCrysSXsEYuF8qbGWjPPkA1+T6sMgrUFA/No1Xjnu08OJTQXehLnNCVmq2RnNfTImjUSCTmM0kzWhzPkVO6/p6cAxHzXKs8VjaVYd2cMt+X0X6q8EaLtEQa75VmT11yu17HoRpK5mjSsBNzB4u0oFeHRUCa+fQVd77ngfNg8Kk3ZEA5PJD3QlWdoCNrWVLTgEXJga9VZXsMbQ3c
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(41300700001)(316002)(83380400001)(82310400005)(426003)(36860700001)(86362001)(336012)(16526019)(186003)(1076003)(26005)(2616005)(4744005)(2906002)(82740400003)(7636003)(356005)(40480700001)(47076005)(5660300002)(36756003)(8676002)(8936002)(107886003)(478600001)(110136005)(54906003)(70206006)(70586007)(4326008)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 04:20:34.9638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10762e4e-5fbc-4e36-9adc-08db792159d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7467
Subject: [virtio-dev] [PATCH v8 1/4] admin: Split opcode table rows with a line

Currently all opcode appears to be in a single row.
Separate them with a line similar to other tables.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v2->v3:
- new patch
---
 admin.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/admin.tex b/admin.tex
index 2efd4d7..e51f9e6 100644
--- a/admin.tex
+++ b/admin.tex
@@ -114,7 +114,9 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 opcode & Name & Command Description \\
 \hline \hline
 0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands supported for this group type    \\
+\hline
 0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
+\hline
 0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
 \hline
 0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

