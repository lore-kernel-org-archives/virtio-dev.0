Return-Path: <virtio-dev-return-13639-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB32EEB8FAD
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 09:43:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 486DF2B050
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 09:43:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 324B09865E3
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 09:43:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 18B759865C9; Wed,  6 Sep 2023 09:43:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0833C9865CD
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Sep 2023 09:43:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4x07w0xAOPK1sW+cJ/sPlhHF14lXliqlrROg7d4nKdkKHkRN8BYSzCEooykrA8h36z9FIJExvFFn5i4JF2e5pxG7Ug0ti0uhLzEnNeyU/9UqYCnoHAZON6vhXpbov95IyTawRwWuhumKNEoDV75Jus/TlJbxpmUZLeTiWlyaTvitRSZ938pqlSljBWxJ26k88/LJkR7mlmF+0Hs7BNdvHauzcjfkKT7E0SaGiZfL14EZb/ubQXvX/QnE//FJVVHIEGjE9u9qK2O7FA92eDLvOZWCXG4OK+lTziq+RH+fr+OO22mmTMeCYyDqVPFCJp8ya6qiS72vyJXpNQogyV9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RyuKkdsmKH3rI+EYHDYEIrFcOnksYkYU8NarrAYMNc=;
 b=nWSikEHIUTVoFsOKzz7ilKkaeNngimrwWLdF+AghvLkG2v26hUYN16fU+AiOr9lmLrR91/xjYQO5bhCR7uj1Di7ReGBwN4tJ7+RLHaG5rbBnu4JHuNaGGdu+Qngmz63T03QGhKM0d9AMX8Je454xi7ueVCJCtW8IrYSzvJGcXo38ua3Js84Y1P7WUOhSbJ4T3HoyPYfcqCm6D6aPdbYfzWOBr123UAcXtjmSkdaenqM8Qp/gNv25LcxRK/+tsz9aVSj4zMezgVrOsaQKX1uq9Gf9ttUS7RAdZnBaKiJYKVUpKHpsdRnjcWmCz6/b4vO8RHDrtuw2dd+41cYp7EOkFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.oasis-open.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
From: jeshwank <JESHWANTHKUMAR.NK@amd.com>
To: <virtio-dev@lists.oasis-open.org>
CC: jeshwank <JESHWANTHKUMAR.NK@amd.com>, <Mythri.Pandeshwarakrishna@amd.com>,
	<Devaraj.Rangasamy@amd.com>, <jeshwanthkumar.nk@amd.com>,
	<Rijo-john.Thomas@amd.com>, <Nimesh.Easow@amd.com>, <babulu.ellune@amd.com>
Date: Wed, 6 Sep 2023 15:12:52 +0530
Message-ID: <d38932451104835ebe23acfc723dc3f0a9f43b98.1693993329.git.JESHWANTHKUMAR.NK@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: aea7ee35-53fa-4aa3-7009-08dbaebdb46e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uTdSFkFaXTQ4vlIka5l8GT4D053JdMi70d7ZiAn+WhPKis6u8nQRsSXVYlrAgbQw/h1O16Jhoyk5XbqGx3N2h7qe2vD339NBb9pJwkXsmohK1KzLR2KLfm1/do+WzZ2oxgA1kKpLB9CUA+L1pDyHPOfRyEeHka/ioYlGSMgstA+5X3kxAqOhfWzXLaRA0a0NNcPDRcOl2F7OZw/7zrqO4xmeNd6RgXFmztUURO8ZFVYgvI7OBj5aWZkLW3PLzVfq3Kygux+2HIRVRjwPfuu3tISBy8eqB4cibpGYuibvDgqk74wQrwm0NGiNs0WIg3comHnvoTc6M/e6vpFWI/piNRGpxWGY9Dp1Cv+CZ1vqeLVahOTucTqVFpVpxRq+DMFbeqlp2kzxQMaB2KyGpcmPCBBJKuDaj3aGWdVTkDkN+hgXv1uNvSGaR/MaYnKIch2m1SBjm0NwqXGeJijpNDNSqda4kEdu+SmxkVhqHGN49E5ctFt3KRD+rczMlLvnPf2fSnNuzx1sHCH6s03uAxqv63umII0AdpozcSu9VnEUVhW4tylpfbr8lgthPcQeGyu2qQqx9GJX87uaJ78oDZ3jH+3oNd4gz1/1ey6OoXaUbpiaVFhfXGHOW6pGD3eCY7VN0wxG+TSAbuCYas5He9NcHhQOjJQ26pcN5D/n9yUNN9ySDcHFEEkWHtW44yxPrUwSZUl44pff0uWKmYlB/QXTCYLj3gdN0hoasv2wtz8gHi07VD1P9yW/M9ru1O6zSUWGTAAcKfo4rriFSYPrRNWtKmJViuZ2ExEUPAqMXOw4vXw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199024)(82310400011)(1800799009)(186009)(40470700004)(46966006)(36840700001)(7696005)(6666004)(478600001)(83380400001)(2616005)(26005)(426003)(336012)(16526019)(4744005)(2906002)(6916009)(54906003)(316002)(41300700001)(70586007)(70206006)(5660300002)(4326008)(8676002)(8936002)(40460700003)(40480700001)(47076005)(36860700001)(36756003)(86362001)(82740400003)(356005)(81166007)(43062005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 09:43:19.9120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aea7ee35-53fa-4aa3-7009-08dbaebdb46e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078
Subject: [virtio-dev] [PATCH] virtio-tee: Reserve device ID 46 for TEE device

The virtio-tee device allows guest OS to access the TEE
present in host system, to perform secure operations.

This patch is to reserve a device ID 46 for virtio-tee device.

Signed-off-by: jeshwank <JESHWANTHKUMAR.NK@amd.com>
---
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index 0a62dce..644aa4a 100644
--- a/content.tex
+++ b/content.tex
@@ -739,6 +739,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 45         &   SPI master \\
 \hline
+46         &   TEE device \\
+\hline
 \end{tabular}
 
 Some of the devices above are unspecified by this document,
-- 
2.25.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

