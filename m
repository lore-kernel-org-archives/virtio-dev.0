Return-Path: <virtio-dev-return-12594-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F59EC77B7F
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 16:37:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6E63F2B244
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 16:37:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 657C69866E4
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 16:37:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 59DAD9866C4; Fri,  5 May 2023 16:37:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4672B9866C5;
	Fri,  5 May 2023 16:37:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxO7mZz5Va7toprT473OWNVVWl5bWrEHLc1HCLTTJkX76U6zWWwjDfTt7A5IkM4+lOZcTiylRZkP8Q/nIpd9NLlCimBfeOIt9N1ob6ylTOk9x1A6qub8/GcACRzzq6j/ATyeiU/msxV5B9qvGgBkncyyVk3Etpq5ivjKYuPGPtKnkU1xLg47k38jXtQaEeT2rFgGdqZeUDz/bIUME/fN9CE6yX6AqWIW6uzJp2GWeehIVl7d4SPkBRnageEPjzXdSA1tKG65/cB0C3bcqdVEwF/Dzqotnz8yuJPiTZwJoNbTP3g4tsxHVhlotZZIA7QS1c3qEW+1jPysGOA12Z06VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0KXRSwAj7ubXimFSlsVzT0pDHI7PDBa9uKq+bmR1P0=;
 b=NgkLTNKD1rEJ5DwR45PKWd89Fab2BYb3+juHftamhc1yQuG/EvnoVA/Xi1ROaGvZXtq6woWkNNYB+kZ1Uemd40dBcL8RFYad6khPVWNgwogch/OEBUPEbZyI5VwgbKQgJpAuGgABhBEt6SLY6qycnkZs2qeHxYhr0pKSBpL3U9KdLW4v5qBLwEN1suOYn3OvsdyAjSyzOFu70H8n5ClfONKtPM87jc9xKk7lIMWbRWuD9r+HCsydlntZcNHiOXzZu+jUzu4P6hPOxqAoFgPHWLC+m7BwRxalImrUqF/ULoZjby/I18NIeyCLBLgfg9czwHUrE6as2EFp2WdVMgdC7g==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Fri, 5 May 2023 19:37:12 +0300
Message-ID: <20230505163712.589460-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|BN9PR12MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: 9355572b-b40d-4fa1-9dde-08db4d8706c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6MDuOnBy6kNeJNS8M8mNr+5q7axvlsuEgA8MOSGry0Vnw82LLpN5GTP2YwQFzHXrkdcme6zo3Y34VoiPyJquvqgqvDrONHu7W6LeKWXv+LV+qcrOwKbAHN13Th2POfCgIoErRUUgTRhfXTRNDgVTELzO9uKBPIbQfKGl1NIlvBpG55RmZ+GhEe3H1W1eONH4DUMwFDe9p1hjaL/75QqahlJCcJ8HMoUwUFSON6xuIT+bKCBdPZ6apf8mFV+BHXVfFZq2zUhTM5CVqhbsRao6xy0SeSrEsaWe0M+g66GH9qM2KtQ4VJH7HQehNh443J7b4i1qzsZvNZ9Ua0cYhQyfrjNxwDZ/zewyFra8U/0wV6UyDSwNzXTZUM1uFrpTgz2cqYOAWItnXVs+IK716omtbwU6PbcCo3bxjZ0f3Te0HGwQ40Cua5O/PLdHJUOAhL2AXyDgQNwIcV6Fp46Cc7RQVV3Wjq3eY9OTBLDey1xv8NUyGtHpinNDjNvG1op9CHYswK+QZgEUD/QNiLqsxHOqBg7do2q93bqHjkDGtapQ+QdKQ8AgoItAZLAH8yloQ7PpKzcTs5+Hs4zhxGNevG+K+kYwNFKjfH71e0/rpVBOvP8xYRcOMz59XDuXW87IWcIQmcIC7uNII5rskwkUhcMT+OcCl8ccOHQQNwP1+a2nOKfIaAHocua5jcee684sBLGu+6NVqfnggEiOFlmSzSPSkifLntCmH+sWJuRDqYV1RIvFLZC3wtyoymNt6QzwjMEs
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(36756003)(86362001)(316002)(110136005)(54906003)(4326008)(70586007)(70206006)(966005)(6666004)(478600001)(41300700001)(82310400005)(40480700001)(5660300002)(8936002)(8676002)(2906002)(82740400003)(356005)(7636003)(16526019)(186003)(107886003)(2616005)(26005)(36860700001)(1076003)(426003)(47076005)(83380400001)(336012)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 16:37:33.0720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9355572b-b40d-4fa1-9dde-08db4d8706c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5241
Subject: [virtio-dev] [PATCH] admin: Fix reference and table formation

This patch brings three fixes.

1. Opcode table has 3 columns, only two were enumerated. Due to this
pdf generation script stops. Fix it and also have resizeable description
column as it needs wrap.

2. Status description column content needs to wrap. Without it pdf
   does not read good. Fix it by having resizeable description column.

3. Fix the broken link to the Device groups.

This fix is for [1].

[1] https://lore.kernel.org/virtio-comment/cover.1683301091.git.mst@redhat.com/T/#t

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 admin.tex | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/admin.tex b/admin.tex
index 6bfc1c9..47556f3 100644
--- a/admin.tex
+++ b/admin.tex
@@ -109,7 +109,7 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 \field{opcode} specifies the command. The valid
 values for \field{opcode} can be found in the following table:
 
-\begin{tabular}{|l|l|}
+\begin{tabularx}{\textwidth}{ |l||l|X| }
 \hline
 opcode & Name & Command Description \\
 \hline \hline
@@ -119,11 +119,11 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 \hline
 0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
 \hline
-\end{tabular}
+\end{tabularx}
 
 The \field{group_type} specifies the group type identifier.
 The \field{group_member_id} specifies the member identifier within the group.
-See section \ref{sec:Introduction / Terminology / Device group}
+See section \ref{sec:Basic Facilities of a Virtio Device / Device groups}
 for the definition of the group type identifier and group member
 identifier.
 
@@ -155,7 +155,8 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 is reserved and set to zero by the device.
 
 The following table describes possible \field{status_qualifier} values:
-\begin{tabular}{|l|l|l|}
+
+\begin{tabularx}{\textwidth}{ |l||l|X| }
 \hline
 Status & Name & Description \\
 \hline \hline
@@ -177,7 +178,7 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 \hline
 0x08-0xFFFF   & -    & reserved for future use \\
 \hline
-\end{tabular}
+\end{tabularx}
 
 Each command uses a different \field{command_specific_data} and
 \field{command_specific_result} structures and the length of
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

