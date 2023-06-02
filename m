Return-Path: <virtio-dev-return-12836-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1F6C7EE24
	for <virtio-dev@archiver.kernel.org>; Fri,  2 Jun 2023 20:36:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EE6DE60359
	for <virtio-dev@archiver.kernel.org>; Fri,  2 Jun 2023 20:36:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E49619867FA
	for <virtio-dev@archiver.kernel.org>; Fri,  2 Jun 2023 20:36:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D89F89867EE; Fri,  2 Jun 2023 20:36:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ABDC998680B;
	Fri,  2 Jun 2023 20:36:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkhP5q5OBxgjaVmuFna8bWY/Va9PhMU8/DVafzZnXuvhTKKyC1KG1jnue0Uk114mEXbKPgh3A9C4wW1tBjN5W6PdGZsSiJJ8KK+8JA5n0aa7FiBZuT50x2Jemo41A5ivg/3BlqTZ+kCFwb8jjKGncl/jcnKE6q0n2T49LlSy7GPVYFsGPHPZoyAdL6kXXf642tJnsVQet3dhjMEQO4+U1wJvrnMNKQAgtXAzQ5pAgsrCuWpKLkM4ojpnhcnYJ4Y0fH2ckhPa1IgobZQYxFQskP2DWhmruQVjVHJEBdmN2YOlbB+cENmTxR8u0BjJgqsv2wwxmDk03wOrBr2FP0l/tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpnhhKY+AZMWGOlUxfddk+CfiwFN+mL4rsv45y7CulA=;
 b=iMmHj+6wpZ5HgkMXS18yAvHm/npztJeIoXtcc9nssrVLMsyvrIcsaNAEh7CS1bbZF89sFiU/tmXc5FLEEZB1vBROHWxxWP0W5QPAPpqluH3WBgY9/zBD8n8hc325n5O6ulrVVn/SDqKM42LJQALZ6gFq0RrHH9xvjNxTBOO+UC0Hx3/e3IkhJ2BHgE0NKMofUAa/2VKt3ymkcX9qdghDvTgrA15FqrjF8ZGFMxRp04bsVMjVOvji0KN2+82ORR8paagoLS6OmBstIrP2iCVqf0dsaeJMmUBRC6SnWXNMYCl7ygTtPXh/TQNLvn/Y/QBxl9BTADnBnpRwvezFpVxy2A==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>,
	<david.edmondson@oracle.com>
CC: <sburla@marvell.com>, <jasowang@redhat.com>, <yishaih@nvidia.com>,
	<maorg@nvidia.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Fri, 2 Jun 2023 23:36:02 +0300
Message-ID: <20230602203604.627661-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230602203604.627661-1-parav@nvidia.com>
References: <20230602203604.627661-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT104:EE_|DS0PR12MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: f625263e-548b-46c7-d136-08db63a90c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2uEpPJC5ppNJXRC7iXx1HVgDdz7icmeRR/ZhLoiUqKLj28XSfA6Sd+vczlFVbXtUCVSblxvgoEo5JXgs5L2vyzoSP3OwAAMWiYv7+VezflGZ6ttvvNmDTWjvhQP2FjJh2UywyN2PW9g3yI9pB17byRv2C/mo+VSnJx/xZJ7c6ogEDu2HCoCDoIo/2zPR2ier14pN4BhhXIFWtvg36JnJezzmJIytGXzYJ/b5H+zT7pxCClZGtdAMi/laDrAE4NEqKoJusiP0x6g1xEH4FkPjQOwkw5v3pAA+PEtPeBkx/9CRtWpUOEMdifIyuGIHOnM4bIxJ8mrMnOB9as5+vEV/tFEa9EPtMYsCA3aPtiEZasY+3QgAStiwCbIcHYIQ6ugjRZ/SOYsdcWP/TZtNJFxVFNx263q2uwmTHw+PKwsZzx3orZkm0sFGUacmH66L/X/zGivHVx4X7q3NWeAuFSrvHO7D6iq1TadkO/ZMPq+vklm7xYR3nZUz/mlVIZiifYpd7m44o1xgpgIHHyvFPN0by+OrJr0DI0O8IH6JNg5MRSd1skto7OWORGS+4vhj+0Wm7h9f/aroP1oWbCFIK8hNYowtbY2Ki2wpzGm2e0zJZsUQ6etfXNRYrpaOy7XaPBj94j+dVnWMmo252n6F5Dt2BHln6rj9fgXRo6Y+6M76o/4r3t9shQ3DGM3WM9SiRNT0FPKKgfEz5r2fcwGWqGCQXKCDxNSDzhRUzqj5r1ZcHDF7kXliyVDP3b/nyz+e28vA
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(54906003)(110136005)(36756003)(6666004)(40480700001)(4744005)(8936002)(8676002)(2906002)(5660300002)(41300700001)(70206006)(70586007)(40460700003)(4326008)(316002)(426003)(336012)(478600001)(82310400005)(86362001)(2616005)(356005)(7636003)(186003)(16526019)(47076005)(36860700001)(83380400001)(26005)(82740400003)(1076003)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 20:36:31.0590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f625263e-548b-46c7-d136-08db63a90c71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218
Subject: [virtio-dev] [PATCH v3 1/3] admin: Split opcode table rows with a line

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

