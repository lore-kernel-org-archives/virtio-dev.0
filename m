Return-Path: <virtio-dev-return-13226-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7420EEB64D9
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 23:38:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D954A2A821
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 23:38:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB503986726
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 23:38:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BE95898671A; Tue,  4 Jul 2023 23:38:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 56B89986814;
	Tue,  4 Jul 2023 23:38:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T049rydUQc1UWC/uRuczRRuHi1X5ih0ToTTvcoWaBMYFlXVPfDX9gqfjMRfscjf42tzD1g9zq2+xILO0KKtbeFy3ud9MxgeF5n0+9zOsXVkl9iuXcYXq/VX6Vr7te+iDfNo/mnvv9V0Jzx09txXXOmC0/Oh5991zUxRRrrgUohe0qPt1/1TdtPVKo3g2B0BrRLqOk+53wvji0ZZUAR2qPE2LJr8gItks0jqCslWCStoXZcpSi0xPcngdafU+SJYR203zyoDz5I9joFBfENshPXDwB2DoGKD2rTPt6iXS+tV8dJ9YcTByML0i5OFMz7uVddaa2jVlik9YuAHBSZQ4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqevPKxEkTPCChAP37x59otVRoyPWa9+5ZWKgGRrKtY=;
 b=N8wdiVG77Bs3QgGXX6d9eA08tBXIGaXIsSDGgEGcSMG1d3dnn6IpXA5j/j4jFSL1TzKtg8V/evYGon0asvrjc1ehclR/C3K/FfiT0Sg8M+7FalQSKfZoacfexL0g6AJVAcRdIFtd9xBca0alA3nYwQu0skGxtdKWlq2jN1lJor0Siv61hlZ/Qnlw8QGbpzLkwWNfGVCEQLm5m74xIuUyjikmVoRu23BSH6BhT5nm6OoszT54RC45RAydArsOFJH2sGbpOOR7NlaMxHNVnu1NznOzvVXN4WbHtG8FCGkPnp93hI23ElhJOpjI5Q1lO/TCl9Szt4pnmEIaoTQf85v/sQ==
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
Date: Wed, 5 Jul 2023 02:37:22 +0300
Message-ID: <20230704233724.22394-3-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT036:EE_|CH0PR12MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: 9465c309-5bf3-47f7-1daa-08db7ce7aec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ayi+1tsSm0kr53jFvJqZN6PurHPDz9ywQn88BZvqqYLLbbMzjsc59Iuw+YntH4GV11r5z9Ia1iMdgvUcIIMX8cwFrUgT3cS8PMfb13hJMJcCaFAucPL6cJOetnYbC8ZwRZhrbsDobWxVRFDuPWb1o4Pm6SAtj/51O5YAIdXh83/jRi2w9RWq+hrPK+JfMSev/FSyv4JpQcsQy9YHoiM8E/gsbaE7n4CcVpjW/pvjbkurBoO4V/YC28dKeDGxMnHvyQeubICCOK2uSwgx0JvT/N/fPsv4lKpsrUOhnw8XI69NVaePUkvXk0sHb8nGJ6lPnnM0md3U/7e4yWxjSpNSJAmCaCAVRhRL7Y52gQnBj+EFd5Q52fd5PM/61YQhi43ja+CfLM8/nReAM36MjtSoR5nwJhRKC4vwhGag6U0xFd8xezJmNYGSekEk3whckH9WmfBR+bQ6FBJJqHodeS+jXMSeRUZk/1Z6bq2bP72BlgpFMkE8dXVXaySceMirvhLzW148gTbHTDZeeQK/Y/ZH97apAeTGcNQ3NLrDqbw2Q8843Z6g8zZrxKu6+0CS5gGbiwa+zKqZzItR67zBKr/2ziX62s13pLBsqyTgHKdD9uGOdor/h9is9IRXWB6FiZ+tZyQ/eveuVLjmY3RFJM/335xgeiKjMc1u47ArvovYjTZwljP/nYgxdekzpd+r5xGaYAgCOtoHKY3w+F0rDBgFOGgDE+OiXcJS2WRgIkeFjlRv+OIPA0bLgMqHGSQofEOS
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(107886003)(26005)(478600001)(1076003)(82740400003)(6666004)(86362001)(2616005)(16526019)(186003)(54906003)(4326008)(70586007)(36860700001)(426003)(336012)(356005)(83380400001)(110136005)(7636003)(70206006)(316002)(47076005)(8676002)(8936002)(40460700003)(41300700001)(2906002)(40480700001)(5660300002)(82310400005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 23:37:51.2600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9465c309-5bf3-47f7-1daa-08db7ce7aec7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5170
Subject: [virtio-dev] [PATCH v9 2/4] admin: Fix section numbering

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

