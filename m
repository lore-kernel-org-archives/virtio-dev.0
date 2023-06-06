Return-Path: <virtio-dev-return-12872-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F8FC7EE43
	for <virtio-dev@archiver.kernel.org>; Tue,  6 Jun 2023 20:16:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 797BC4284A
	for <virtio-dev@archiver.kernel.org>; Tue,  6 Jun 2023 20:15:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F04A98682B
	for <virtio-dev@archiver.kernel.org>; Tue,  6 Jun 2023 20:15:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0A3D59868CD; Tue,  6 Jun 2023 20:15:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C2935986588;
	Tue,  6 Jun 2023 20:15:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOLYABES47zY/pUZnxKDdOfA51AkaO41IxLo+szsLIv1b231uJwUkDQNDF1xzrdrWLOO5kzTgAtCoJP81JYMWIf6ExQE8cn0MZNwsyZJiFiGdooWt6ARfdiGD1EjXUAMXS58OTUq9pJGHqrE/DRj6gt+1sqoRyLT4cJBe53ppUbm96K1L1AUbVtosCuiCvv7QMMXAE0C4dUsk9ChZOuQVi2IB/YSDhVH1YybaHilKj1NagdNgLyuIpPEG2JDGN/h9ih8rWrSj3ft4yaOM4AVRN5SJudr1aSkZx83YnLyu2gw1Udxt6+coyd5hfVsJyFhz3e+waDj/1c0fY5kMIwX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpnhhKY+AZMWGOlUxfddk+CfiwFN+mL4rsv45y7CulA=;
 b=ByanuM7ZQYXjMwMrebxGrq3ABHgyT/tOc52OkTkg//vDiuUqmVs4RPBc5bFzUZzphqyuloZczzW8MXYLUXYWEKPZyxzyI5rXKt9YZmtrIrUR8WHgvj1uKKrJT7Z9R4EMTfL4ugvuliHa996854MyXLUIOiLJwrYSPItkSCf0jHrHevYmGOe5R/YunYKR/G+auBoMFm5pL1LkK3NrRrzoy66mIGh5vnoNMbRPKLZ1eZ+D3XWFi8gXS63ZAgwWRfy40o3Be3dvSLRZWac7HstXi97R5bNlcuGKnFkYwnpzZpY3cuKkTRH8wh2nFlsHUoRYl9pby0q/RxgwyuK0Qur2kQ==
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
Date: Tue, 6 Jun 2023 23:15:13 +0300
Message-ID: <20230606201515.775121-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230606201515.775121-1-parav@nvidia.com>
References: <20230606201515.775121-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: a87f38b4-49e2-48f4-7c8c-08db66cacdc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4HjpPvM28ktbBqbrStIZzvlxvhASfOsUXxOoEm4pIlOSgnTDnoPjQCsAuIJh5SsCL4TwDA09nT1mEC74d8PZtMhL7lVpxrBX1IB0dnxpO7vp/uX1MXJEDu3jwfm+90rlxRM+g7jnuumj0Dpejs32omcpniSH9UAkefvpIyEkocZPxxrWA0ui1mSDzATNk8a0mHAAUnu/LE0ot8pGZN6NZiYXFyK1XuGqi2uOrzYu/FXNO8acQKLQO+iFaDDHJMZcheqWt+K//OULmSi4+iZYRquyxsX9BYAWRRGWbxcpPiaH5Omz6dmF6y1f4tkg+pYJKqqWfRRcsqlruz33erDXWrxVJjY1JbL5ScbssnRHZag7wLhM/Bu35o6hVesC7H0cIUgBTiLEBmlOAi06dTHRupN2Ekg6ekuPmJAIZEKcVxRfXcJjGGiZsJttJ9nB1yrd+FYee5CzyiL+PaIWf7OkBUbGVZv/JjayaqGfj562rt/zmZRTSSGxv9UcY3lezw1VNO+zvrumbDvmzWWfzVwV5e+vPUCkV7O9YKXK7mlilQV14Nvvvcukd2oJhFsgKUj1p8kNMWCazGuSnJGYtGMfFXL37rX/Lf3yVzr1gQWgJk7+JFBFlQhaB6Ra03cMOHRSNe9Nh88aRHDJiB78IPp+TMOeFJDxx4ldM4qq2BjUJk+GgFWfOTJP/x9OmkUtE0poKk5vHgtmeuxqrYocHjPwj3WbDmcTsrUg1n8rSQkgewQitNnNTLVk2FYxIF7FD2s0
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(16526019)(336012)(83380400001)(40460700003)(2906002)(4744005)(426003)(47076005)(2616005)(36756003)(82310400005)(86362001)(7636003)(356005)(40480700001)(82740400003)(36860700001)(8676002)(110136005)(70586007)(478600001)(54906003)(8936002)(107886003)(5660300002)(70206006)(6666004)(4326008)(316002)(41300700001)(186003)(1076003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 20:15:42.3611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a87f38b4-49e2-48f4-7c8c-08db66cacdc9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341
Subject: [virtio-dev] [PATCH v4 1/3] admin: Split opcode table rows with a line

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

