Return-Path: <virtio-dev-return-12906-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D5BC7EE23
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:03:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DDBC34437C
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:03:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D54109867FA
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:03:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C8A08986692; Fri,  9 Jun 2023 02:03:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 167DB986804;
	Fri,  9 Jun 2023 02:03:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5zrvIjLYInu3TJBZnD2Je6YSf7ceM4ODEAcMtvY22CyYyPSpqBteWPa2PebxoRb3X5aMnPuvPrvk2fH4I7gnAhsDxrLhCPtHpG+K7lGo3DWbyBlpgV8M3x2y3blc/W9TfgJj9ceWk2bi/YV9/3Z1Mh6EPzFn6JwHUFKAS2mLiw9QBZNc7YVklPvBc/ZRGKE8G53CSLHWGxVEtGn9mAyuPozyt4Zpcz2aHZXb86m2MKI8Cmaizw9ZXsKi+6KXjk5Z5yw78jpKeDLgwi+wrcjIZjbPhpuhwhKqLSaxS7uh6Eck0oKzDU0rECioMffhQIftyUh0YFVKBkSp3MskCcVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqevPKxEkTPCChAP37x59otVRoyPWa9+5ZWKgGRrKtY=;
 b=bhGGRSboHXfjHyuwyc0ZTfwJ6A6YD+K5e/HuDXg1iajcQojwSXJmxAo3y/tzMPF3dI/GCJ3fMDyOMHTEG4dgq6FyWRnQZK+JtSYKAcpr3L8yMkyzyLEeGDrPPIjVyeqASVZa2SV3P/bYQZztGPEO6GrDbSLcgRBq8FATWXFpZQIFIQdKug/8zNbafw2v8xbuQv2ynUuX5a6zqg84YFdRfUzx20ey5mUiqt13jIaw4EbYykcv5lwRb8xrG78eo46NCOZ34YieyKgrEZs9gOB8khVAlALWViSQ24uDIlAho1uiTln6xdAnxFajdX/NyDfDwTAnQWOK7E7H3zepR92hWQ==
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
	<cohuck@redhat.com>, <david.edmondson@oracle.com>
CC: <virtio-dev@lists.oasis-open.org>, <sburla@marvell.com>,
	<jasowang@redhat.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Fri, 9 Jun 2023 05:02:46 +0300
Message-ID: <20230609020248.869700-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230609020248.869700-1-parav@nvidia.com>
References: <20230609020248.869700-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|DS0PR12MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b69dfd-7058-46cd-7e9e-08db688db509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oz5UnwPYVPqcxRH/Z6IFX8Q9qiYpnPMaMTF5WL5m/ZB7d7xAKIa4kpcu0yEHjW63Rn12m6G3x+I10s9THQhxpAd/6V1+DkYnl55URCPnVdbn4noEAedaSJSS5Pvd8/ZJTW9DM69axK8XF4AY+3e+fhsYPSCC61Qgc8YkfP5rPkWMjGXsH0Yw3VFI5J+elo2EvGgZInsSVtpy+BZJk7IiHC3FwrWo/MKd7TSmEUeJ7uoYc60IBR6dR0wj05g/kMnzhlWOpuu6zr2x1r8IaR2t6ie/KHiv+p1GrHQYa6heJ4GFeyDDbz7Wg94FH+jNLtm+EyhZ+sUTvnj/x/1Al67siVdeQ6CFQ87PHIFXK99uKo4HsDpGdCS09iRhRs9EWEEaBMSz/n5cvJLKSFqyYA/qj/2IcDEHtlsM0f2HQ03jw0vexKdCWDQDm9W+Rg+XuA/drZYpozOAo2Fu2XiYzaK1NFq+ihVVjqKUaQJTznqesf8mEeg+qXoPA1lpMfruUGVv+U7raLS6JimgGKDe/wgx98tHe9Vw4hnQghmQfKYPwtvPZPS9THC0w/GSHyl1lwwoVp5qfmN04gHrO8Yi6JjgeK9aIDNHwrp1cOwr/AZweszV/MCMZ9vkF6WWBmhLrL+mupCsedc5J6ydHveMo65CvIJcI7VAjhQQZxdm2jqe0WGFfEfOezNbeyV/loQ09LGvJmCkurczTWIP81otyTjqcS6UQloosCKPFmNsmgjX5LLqRjHeDojrDGDOQOcglHV1
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(70586007)(70206006)(8936002)(8676002)(4326008)(107886003)(316002)(40480700001)(54906003)(110136005)(2906002)(478600001)(5660300002)(41300700001)(40460700003)(47076005)(1076003)(82740400003)(26005)(6666004)(16526019)(186003)(336012)(83380400001)(36860700001)(2616005)(7636003)(356005)(82310400005)(86362001)(36756003)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 02:03:23.8626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b69dfd-7058-46cd-7e9e-08db688db509
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9060
Subject: [virtio-dev] [PATCH v5 2/4] admin: Fix section numbering

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

