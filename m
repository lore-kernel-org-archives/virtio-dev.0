Return-Path: <virtio-dev-return-12704-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54F2C77B7D
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 03:02:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 41BACEEA0C
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 03:02:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 350BC9866F4
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 03:02:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 29B8498651C; Tue, 16 May 2023 03:02:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 11E94986510;
	Tue, 16 May 2023 03:02:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLGMrHeefmQ+nsqpGABSSdx1rMVDkgNIWprD48gXYepqd6qUexIj3VvxTh2cF1n47l3hxDOU5BNt0J0sH7BNZtZOdSjTV3hbZTmaK44GZc4NJSEgeUf+FxOWsWehrvmDHtIQSsSC8wFmY3G0mPugNky83vnGV0mjZav0TIP4tx0d9geFL6tagpdw8CrDkz/IIkfxXQJtvW6d8wDDwxFvcOxT5BrmhB/zRcyoIWXUBcXjEawujGXjhMqxe2o249J0NRYaHYM770Xg6ABBYeoCpgWp8Xof3UBiohDjmlZefL3cM3CoNPjrtiXqCJjgoiDZ77Ov3dhoO5uxkX9xjMwYVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWSifepU46sERcmtzI1qdnA5lkoKOgDfx59GYAJIjaE=;
 b=IzvUNKv+kUb7QY9EMFcCOu7sxmCmGKC150zLODPkZyy9wyKr0qo9ww6Y70KE2syrNtu+906asJLXQL6dMkwhNcpWn17JQahBOzJPEeLZr+AGuRuZF+1zVDfqQec/3rngHOb/LnCpc1gsXT9LFgVVulGAKRic1QmC65l0evVWj/IWwvrTIlrr/JKzL7pg+mEIQPzwpEJIjbBPXiHWMWu1KxW71dTQsp15HQXTebyN6WkVZ8OCBGfVpqUF2woybC1BeZfX8LVcyMH97Iiy5HNA7MJAraCF/9pLbv51nbQ0pVovTtNzCaDogSUeo4XVf9ocfw7ihTv1SCF3yHYdAD+wUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.oasis-open.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <virtio-comment@lists.oasis-open.org>, <mst@redhat.com>,
	<cohuck@redhat.com>
CC: <virtio-dev@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Tue, 16 May 2023 06:01:39 +0300
Message-ID: <20230516030139.767838-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: d30b4878-612e-497c-f20a-08db55b9ef5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xu+tpM3se4qGRJ8KK1n3EfJPnibEgBdQYZXehGwrJ9GqH4JLzB//zLoz4eA6z/d36BydQClUHD1METtFpGDS2gZGIf6yxL2tMvhelW7LecFiv4qYzXYnFXBrR8vz/nhdOJkRryQjclzUcP8aIF22d6VoPj3PskSnOkJ/LgPubF6teSv0B/Nm+ZBkoNBt7vU3Bm4/h1R/KuUOW/KLoBq4D9Tb7VNxRrYJv5RpK8yRQQxIx3tUWSFIL5l3+J2YlvNeLXMr9Bb5pNkTqXAxKvhXgfkr1Mzjnrhznko4DKbiYO3SqWASO8x/1huSdAIM3FPjbed9bohJLgo1yzHyM8dJ0pRITqYpsyeR3qjMNKW58efz4YU6OrkHXgEwXszqpgoLiUQY/+Is5x1Hh0cS2EJm79SsD9nD6TFfZE24bb6by4uMI+t5wI6Cf0JTvm9hgZZTvRC62fgSKeZSZMWEvEN0EsbSdTE1S/MrSi7aXpd57VjaFJwa+LMsQ/XTrbgUOO0VoJgvIO4A07e4XtOuboa5kZKI99fGMZgyfTqcme7poallp1rTx+mO4I9fAgku+6hhzUNbB2gAIcFf0zmS8DjHmv6Zky5aGI52wsgeI6JYPQASqF2AZ6Ws9A+QMHcfFYLNqm+uwcQp27IF6i23YP4YF572qwfNUZwc69gCQXqDE/C1f19ndbZJLWiH/exA2zs84z1XEQM+FgwtsVdck1IevRNacsK7Axv4CEx3izCDZH3hBkp97t97XgJ2qSaTPGLg
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(70586007)(70206006)(478600001)(4326008)(316002)(86362001)(54906003)(110136005)(36756003)(426003)(47076005)(83380400001)(1076003)(26005)(2616005)(107886003)(186003)(36860700001)(336012)(41300700001)(6666004)(5660300002)(8936002)(8676002)(82310400005)(2906002)(40480700001)(82740400003)(356005)(16526019)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 03:02:07.4207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d30b4878-612e-497c-f20a-08db55b9ef5a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629
Subject: [virtio-dev] [PATCH] content: Replace guest OS with driver

Currently device status field description and driver requirements
section uses mix of terminology for the driver. These two sections
sometimes call the driver as 'the guest OS' or 'the driver'.

Most of the cleanup around 'guest Os' was already done around commit
212c0cf3 in past. Clean up the remaining few references to just
refer it as 'driver'.

This is an editorial change.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 content.tex | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/content.tex b/content.tex
index 9df81b8..417d476 100644
--- a/content.tex
+++ b/content.tex
@@ -26,10 +26,10 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
 following bits are defined (listed below in the order in which
 they would be typically set):
 \begin{description}
-\item[ACKNOWLEDGE (1)] Indicates that the guest OS has found the
+\item[ACKNOWLEDGE (1)] Indicates that the driver has found the
   device and recognized it as a valid virtio device.
 
-\item[DRIVER (2)] Indicates that the guest OS knows how to drive the
+\item[DRIVER (2)] Indicates that the driver knows how to drive the
   device.
   \begin{note}
     There could be a significant (or infinite) delay before setting
@@ -473,13 +473,13 @@ \section{Device Initialization}\label{sec:General Initialization And Device Oper
 \begin{enumerate}
 \item Reset the device.
 
-\item Set the ACKNOWLEDGE status bit: the guest OS has noticed the device.
+\item Set the ACKNOWLEDGE status bit: the driver has noticed the device.
 
-\item Set the DRIVER status bit: the guest OS knows how to drive the device.
+\item Set the DRIVER status bit: the driver knows how to drive the device.
 
 \item\label{itm:General Initialization And Device Operation /
 Device Initialization / Read feature bits} Read device feature bits, and write the subset of feature bits
-   understood by the OS and driver to the device.  During this step the
+   understood by the driver to the device.  During this step the
    driver MAY read (but MUST NOT write) the device-specific configuration fields to check that it can support the device before accepting it.
 
 \item\label{itm:General Initialization And Device Operation / Device Initialization / Set FEATURES-OK} Set the FEATURES_OK status bit.  The driver MUST NOT accept
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

