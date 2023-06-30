Return-Path: <virtio-dev-return-13177-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F65EB64D7
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 04:20:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A861C3F8EF
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 04:20:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 942D6986723
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 04:20:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7E8E3986706; Fri, 30 Jun 2023 04:20:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 09C2E986812;
	Fri, 30 Jun 2023 04:20:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDJuzdI3dMMtf6np0hNQ70Pw9vd3CkRYiZLln0b1zihqreOH+irOJNYvTDTDABlpjuO3v5+fYkQerbakOkbVYczZ6qnIGDx6wxJDI6ypD+Y5eGdUAhvvT6byOeBRsPtUaJZ2nqXoZWDjvV7eewzRh0LgJgy7ukeqeU4NrjhS9qUxUV4o+wtQDSCg2IhZFaeAWtxMccD1fkey0mW/15erb3rk0/scExprUduNrwFiyn41onxW2eiMm7efeXr+HEJRXdW/gJpXUxgwU1l/NySzb966pI/NVsHy7QA28lsud8IM3A1PseuBlQvxjmEmcwkx+ZTsTZZKfm4aN1AOlZVAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqevPKxEkTPCChAP37x59otVRoyPWa9+5ZWKgGRrKtY=;
 b=NOLPoLox25B3XYNyYHAn0j8iW48Kd+wwJVTsww0YX5Mrhe/6Z7VaesOzmRwB6CWvZl4tSSelXZgD9RqvSnWbno62+vkFGYFLf2q2O7hwJ1WabFfVnXAIgpBdU3bmhqw2Tlb3NK07QKK4gn3hO2B/07YbICNkv0eisEEw3fbNMUdDnqupOmFvycEpUR5QyAATBSbF4t+XhReXGu+j5CAoTytIYc/SZBY3Cb72tWgvmYRCY8AnzaVwyET7oJJmtk5OsH6BV4sMijfT9rA2+tR9jPtYsbNg5ctg15zk3lzJNx+2H1Llp6gEOC4LFK2eB2IE2TT/BGIV8/5GRK62hQJ7AQ==
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
Date: Fri, 30 Jun 2023 07:20:04 +0300
Message-ID: <20230630042006.1569920-3-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|BL1PR12MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df98d21-c7da-4830-4ca6-08db79215aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7ztFrPlLLc/IoAqMWCAh711dLe563ZejHtpi/vgn7doNEiaLBPks3ZA1Ts4nqzCIiuSHK7L8OezjCQW4A327p0LTznVoMgZFaL7GYFRzyxFRFxYy6hZpKlydrmVfF+2W2qCFJ7NcqQ3vtB/NSnMiMPhHXsbrw3y7AfQLpukYk3LH4XOVwcN+ygHIIiBIMfU80PZl/CyKV73TIPn4WvD7mo7GgqqanwKqCTKC8ye0UJAZrBlCWatAaIXRUXD73qCi6TJ9UliD7oMhlB/zTRNf72YotNKK3qbKmchLj2ydsavSxgoPivn3YnpxK/xZVNfwPnOeo4ZuAycF+vZ/PmZGMo7plSAiNz1el7ipJMKVjTO9jl3s2Wvt0Xqpj3eAnyjYN2nBDNDR4rpB/S+Ds4nW2MqDoPlXu0m+8WrtHdQjOQvVCpXI4oG3/mHWAb+2bQL/l07+2OHZ0CFPsKz3CzLkkS4XzyL9a00N+wwhZPtwEXepjZImVmHhzF5O/thr+1f7ExdUhZ4l3sN65DjSIAD0OYDLUBIkPpTi6DKowqoxDDfQlb4ppN8eB1Ahkb+5sfY7h3suKZTz1UNqqp4lWrfydb4UfGsOw1GlBenWnROB4+NzTRPGgTHB8LJP48mnuLzZJKPJuPWcOeDyrqMCMmtQqDTF7FQAFSnhaFzs3HnVukWkToQ+ElvjDR9fxHPFOHmvtkrmbRWoQ2Lppz3OZWpRFYTefgGQwLkV6Gh8FgrLGL1ucKDkR9B4fSJggor8TmnK
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(26005)(54906003)(110136005)(40460700003)(356005)(16526019)(82310400005)(6666004)(186003)(107886003)(7636003)(83380400001)(2616005)(426003)(47076005)(336012)(82740400003)(36860700001)(40480700001)(86362001)(41300700001)(2906002)(478600001)(316002)(70586007)(4326008)(36756003)(70206006)(1076003)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 04:20:36.3289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df98d21-c7da-4830-4ca6-08db79215aa7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
Subject: [virtio-dev] [PATCH v8 2/4] admin: Fix section numbering

Requirements are put one additional level down. Fix it.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v4->v5:
- new patch
---
 admin.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/admin.tex b/admin.tex
index e51f9e6..fd3b97d 100644
--- a/admin.tex
+++ b/admin.tex
@@ -286,7 +286,7 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 supporting multiple group types, the list of supported commands
 might differ between different group types.
 
-\devicenormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
+\devicenormative{\subsubsection}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
 
 The device MUST validate \field{opcode}, \field{group_type} and
 \field{group_member_id}, and if any of these has an invalid or
@@ -378,7 +378,7 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 \field{VF Enable} refer to registers within the SR-IOV Extended
 Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
 
-\drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
+\drivernormative{\subsubsection}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
 
 The driver MAY discover whether device supports a specific group type
 by issuing VIRTIO_ADMIN_CMD_LIST_QUERY with the matching
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

