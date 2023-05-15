Return-Path: <virtio-dev-return-12686-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F43BC7EE23
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:10:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D455744557
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:10:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C9BE4986520
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:10:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B86FF9864EE; Mon, 15 May 2023 15:10:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9CC06986509;
	Mon, 15 May 2023 15:10:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1nYZXOvF2gM4wg009XXCpBaCV1etuHYIYhD7iPnjX2OTXGlSnPYnToeOd9CqKWutSiNvHcv5F5c0HF7Ua7mmkuJKMCaDOJ2mFbVErc96VEbHLxL3E0mFhFMlVLUmKljaqP6JN4TA4Ca45mONqrZNVGrGJSLXFZEzpdSfJI6/L/E2qUTxj2BC2BVe2vWl20MBLkYgt4MhTNZRgPQo1JYhhEJUa5JE8d77pFEdC7E5DZYrA0HLaz8OwofJQ18McOkCfvW+LavfA0wNzPtmL4Ktmrqe1nuv5wDmQiLON68h/hbPY+vqNMosfkC+vC+8STzEk8QwBmeILSt/nC4uX0MJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrtmtH3knOW3d2DAALiKdj7yuZs2irjtelEjCFKOwwY=;
 b=OKddNoE25SlJ5VNvXDatZEhZBcA+5AEXTK7KT5fZmMh+5wsVhCM7xsD6EVFjaO66+4Sskiw5rLzr0OaUsvkPd4qYbESBUfO5TsRi8lwMtxidhAC6Qla7EPYlSE5n3MWCYFNw9RL/I+RM4tkdzbPps/8YTZwejgkg0PRQk9vZKD1guUj8YZfqN9Vyk0H4JhWOb/nxwIuvKiZKLf/+lrFNajg5FrsRZr2l4oEZUYYJNhpfcVLjd4aPQn7+Nl427TjyinM9o18RL30J/NKG/exEb9ynDW9YK2vPBozSW97OzZ54lPEtmWu31fuM/yn3vKwALABIkW753llYdjqVmqKDWQ==
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
To: <mst@redhat.com>, <cohuck@redhat.com>,
	<virtio-comment@lists.oasis-open.org>
CC: <virtio-dev@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Mon, 15 May 2023 18:09:27 +0300
Message-ID: <20230515150927.760716-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C979:EE_|MW4PR12MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: 822aa992-4510-4b3e-7570-08db55567171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cwv767l5z0hducCXDk0QZttB+lMXKXZSPD5w+C+qR9a20JacN9mvA9uuBVc00N8bKi67aIQ5M1slywlpVyGm6d6G0dMLmoL+xX3wORsT4TrOdSNPHK7M+WKM2JEBOwtmSA096Wdi1x01CeJzlJI75dr3/oEvRZlYhtxUOy+MXbU7p057mU7xBCM+T+CfpqF0DCszvFaswGzXndz9b79NM0yabQewUA10xgbNeFiaPg9r2C5s6VPPiADqUrOMDCM8ojYxAmPN1oZxOPlmFIRizfbEK7skNDVNsdnGcVhENoV8guUFGnsYbegKfjyJrUDZu0e8KQEJgiy20/5S8LUX86xFaAUrzxa5kRIRFOdxa235EoxHYol54kqOgpyh0aLWS9LJUMHEkf/L5xZzSakn7hV4/ItevqQHQM9feoYfAZmQokEYTfNw4qhKtHRW/vKB51xCKBrD9J4Fc+PGTOjo/CaDMmDJUPI9sOKPAIH0cyVjcv0im4BYg/wcp9uE/LHghRm4CGaEmFUCnIIZgK8S6bOVpQXGl9AMMHbePd/Ke68J75I5tJtx9t/kasvzBBzic953vn9dp68en+g8OyLlaxJXLDDhTXaoZqOaWHEQZgOMtgsfRoCC6fWcPQWxWJ1UYO41pROQmSgIgfPhbBM4qLQIZ8o8IVxf5ixQfuX8ZKzzqlnj/VDSHp8Zih3VXPSHf1bpOX2dtpUEfSoklIoyZ9SLeZg/08Tgli1bKqs6iXHsSOst8O1O4QpAj74IgWaI3I/U2iFXRZFtBnN2USetYJT6l5Y/SBPkXyYTs6Zu7LI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(36756003)(86362001)(54906003)(110136005)(316002)(4326008)(70206006)(70586007)(966005)(478600001)(82310400005)(40480700001)(5660300002)(8676002)(8936002)(6666004)(2906002)(7636003)(356005)(82740400003)(41300700001)(16526019)(2616005)(1076003)(186003)(107886003)(26005)(336012)(36860700001)(83380400001)(426003)(47076005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:09:56.0304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 822aa992-4510-4b3e-7570-08db55567171
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C979.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7263
Subject: [virtio-dev] [PATCH v1] content: Fix spelling error

Fix spelling error from suppling to supplying.

This is on top of [1].

[1] https://lists.oasis-open.org/archives/virtio-comment/202305/msg00101.html

Reported-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v0->v1:
- corrected subject
---
 content.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/content.tex b/content.tex
index 327926f..9df81b8 100644
--- a/content.tex
+++ b/content.tex
@@ -409,8 +409,8 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
 VIRTIO_F_NOTIF_CONFIG_DATA is not negotiated or device supplied virtqueue
 notification config data if VIRTIO_F_NOTIF_CONFIG_DATA is negotiated.
 
-The notification method and suppling any such virtqueue notification config data
-is transport specific.
+The notification method and supplying any such virtqueue notification config
+data is transport specific.
 
 However, some devices benefit from the ability to find out the
 amount of available data in the queue without accessing the virtqueue in memory:
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

