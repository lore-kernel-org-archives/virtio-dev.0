Return-Path: <virtio-dev-return-13223-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B10DEB64DD
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 23:37:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F3774755CB
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 23:37:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E9FE098672E
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 23:37:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DB1AE986680; Tue,  4 Jul 2023 23:37:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C6B62986637;
	Tue,  4 Jul 2023 23:37:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A55j0CSvv7+Sz+r618KU0LnrYrt6IxzI8J38Tx24xl6kCwuBcY0dMxS73L95Q14LxqUyuz2va8hp8mA/tsuZN4LBao0PD1q5K/1FiRFP6qD1dRr6TtN0BzevCoCWDOk2qScN6HCXR27ayaKUj9i7/q8EpjSo7iMEX+gibk6hI+GMk0HkkmEnePEpEIS6Zj02XcWK9dFfZsVRPLn8c29d1N5ker5fBBqQcZub5qY+ZwrsyLFXTKMDNLsH5kY5GQCmkV36JhSz/QKAKPo4JO9Vtw6dhvYwgAbPuvdUEhcT4U7yulzd8oJMQUICb4SNagSEegUoR+fJywNCi7RKa/LIoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpnhhKY+AZMWGOlUxfddk+CfiwFN+mL4rsv45y7CulA=;
 b=U496kqRWvbeSqFDkiR7545ZrD2AMeApRxCCp/bSGSD8DzHlNX7cB1usPUvYr1eplfJiij/UHa/aYZtrQfUrjQlU/JqhiWEAoKgo99QBc2Hzy9y3TiaHU+E5xI9X8ULJDlKpz6ykrwllnzYJUn0uSupKwb6dHyVnXPZfdH09f1nAXyObs4FH2ce5qmfOA0A+xcXvfCgiIP5huucEWFdlKvw72paOq6ZnOSWxEQ4KNsbMKivK3er5M8JqaGIrfWUblzGKmwsBxnnFnpIVhCd50irBAi3nYoj0V5/xaBCxEHjKrRm+0TEM/5JcTimV5koWthC9ygRG/rocbNW2IyyV1Rw==
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
Date: Wed, 5 Jul 2023 02:37:21 +0300
Message-ID: <20230704233724.22394-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230704233724.22394-1-parav@nvidia.com>
References: <20230704233724.22394-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT045:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cfda257-f02f-45fa-498a-08db7ce7a96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZcreIYlv7G+YPAd93jgK7P7Y3cFpXE1WeYeqrY8Ibu8fcoQQUp+h5Ibj0Q5XKwMWqfgNmQIBaFpNrp7FFwPIOu8aZFOo3CrXG3q9WlqrrHTk/478tgdHRfrJfDyQTNXMflDdsXr+AhSHru5dzVfIC0LAuumzW8PZqzX+ltEwnkRSxnyR0cBl3dnapOh2/Qs/e3KY4RRahLnbxOHUJweOSRUo8J/CxRLuqu/+atj4Tn3LYhlT+X6SeKzPDC2iau/u0JuF07y8CYe+SvOnMegvnvvYrNgYHBMjc9jd1l3G+XVFNSNbcV2pSqwKagUn2Jiaot/Ji1sLs9ToDvCeTeQO79IHBWEsCzYvKC62qVJEOreu8qB9ERkYMxyi1n/C34x+vb+B0TvzWfb8Yv9x6g93Lhbra6Zymb8qRDnMKqbtP/GDb2LM/D8xWEQ44b71z7sK4CYs/7fVK8NkQ5cqWqIbAQ5nXTDpnJoDUugqilJmR2jQlDPgr6cqpGsFyKHCcefGT9ovQJM9/fWQ/JC2XLuDiVWQP094qPcnsUkZ5FRJ540r69aBr0GvdKPXZU1GCpjQeqKKL/YjXOJcFGbg3JfRkLTO0wV9kjpfNNUWciIk8WFwgJLWCDu9aw7HrtDTzYR9wb1jp6LGCDMGCXQgc0a5qFl88E/MlIfUXoDK4RKbAypke/5Jg36KQR9jsievqhKau1cqF+aJ6jwr4ylYr2MvP5PUUO9b5I79XzJI7OtrOMPDaozHjOBQzr5eewf3+4As
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(336012)(186003)(40460700003)(41300700001)(4744005)(6666004)(82310400005)(7636003)(356005)(16526019)(107886003)(82740400003)(2616005)(83380400001)(1076003)(26005)(426003)(47076005)(40480700001)(36860700001)(54906003)(86362001)(110136005)(478600001)(36756003)(316002)(4326008)(70206006)(2906002)(70586007)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 23:37:42.3427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfda257-f02f-45fa-498a-08db7ce7a96f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
Subject: [virtio-dev] [PATCH v9 1/4] admin: Split opcode table rows with a line

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

