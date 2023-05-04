Return-Path: <virtio-dev-return-12536-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5A9C77B75
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:31:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 525EB42B85
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:30:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4B70B9866B5
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:30:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 400C59862A9; Thu,  4 May 2023 02:30:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 25FFF9866B8;
	Thu,  4 May 2023 02:30:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgiPWxlzmS5AAkVjNnymoBchqWfFsJtR7KVHrbQbbqeTApxXa16o+dXl9WTgL7hvnsycqtDdel7t/1zzrnW9tfV8pUzef4daRiKjkjwNeiw6tI/AV+EZBaFifpGNrgCdMVJMtxlsqq4zkcNwR9NB42PkfWJ369/5J1nA2RnAgHlSfsPSokEwKpjxsiCUmAREwsyUHqvgunlZOza6TazWw7HBzghBpK2HSRtRkVrTNoCXM5PxA8GhSRtROuhOPMutaNmarHEqDVmg/7h/rSNol5fAjOrOfgr3oF4qmxsQVPeXHrx+tOnUIQqPbFuILBHBeS1LW6hZpmBqN4rCrH6UOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyiYCV8DWPzI+TZH2pQLE6WBzTYCoBeSdD8mDz+/HaM=;
 b=LP+QSzn985IOgyAS29WoHksQaZt5aUUg83AJ0QeZ2up12U0xK89Alu6YrnhA9JcL7Je+crL0uRkzDzPUsXYQofZNOYbAlWlZtAWsBpLlzjLPzuDm3/3OhwnERQRpji2eF1kp3ik6blPscuheOww6UPy/zpFDYRhkplJ2GPEo0zLz7wquzoaLi0UH7XFvEEwvttQL7TscVzEQN06D2qUhSBBIE8FfvKhPl7vDktQQ2Ep+LUKPVzMgqIZxGE6QB7wcDp7Ght0u/oxN+5uRgGgS1x3HMxOHnmZhC/ec22mWeuITY48FY3kIuyQ+12bOTecGlnLS0G3E07gfldsmisMWgg==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <sgarzare@redhat.com>, <pasic@linux.ibm.com>,
	<david.edmondson@oracle.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Thu, 4 May 2023 05:29:52 +0300
Message-ID: <20230504022959.547025-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230504022959.547025-1-parav@nvidia.com>
References: <20230504022959.547025-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|IA1PR12MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b961a6-1b48-41c5-8db8-08db4c4788da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gr6PFiD4gyoW3xauXgWhunOdOI+cI/JRnKIbpPjSrwEkNB2zIUmRZygkKUH7G9zip7HFUDNdApE9esegagWAuWX2Rz7Oe0SOzTyV9isGjIAouRSOVWsMCKGrQ+N9J5UuFBEW6h02XxE2jAZ0v16oIjRJ8NJOw1qugrrB+AS5UdM/KTt8uS7AyMcdvN683L73hGyNOLgnuS/5ACmEW2FME1wtPUz3D4tpDT9BS0R8HwcPNITnLPibu2NI7trdBusm4aiF5dH6gJQUGYOfzFoyoVEYZOsEYnYxBBTUHPkzaLeVan1qXXplzuXNV0czLAsknlBQM/QYGusNowXFGCZ2gLT1D+0mxyB8784m9o5RbGX9NU6f2usQ+bqQ1t0nMsi0MU6eeWOYcd8sbN+7taI/yUwAZ/NhCB/d9+hns5ln1CdmQndA03M/ykBHWjnKabPEljYf4oWOFual8z8OQrHTV5uL8zVV+BytqPnzFlJdvIGXcySjMB6StADnlnz+ZNGAvoYP5vB3z4IPYP0Cy/IvWV2zqzdkCcSW46Z9SuySE5FQbwCCnH8IT0G/CIrAIui/3/ripm3o+RtLQCceMyy+K9iCKXhRbzg0u3e7EwZ26z7VpBMt8dKEwxcKg1UX3KyY+E2BTy4IscDSZaH0Gwb+8bRYoVhfoCGw8J1J5+zXDKY6hXnsMT1Vl8FpICNgfzqnbrtbl8E/xnYTQaRfaZClVxMsfOfK32T5LHfv+H2iNHoNU5wgu6vbpVO9IHVq93Jn
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(40470700004)(36840700001)(46966006)(36756003)(478600001)(356005)(7636003)(40480700001)(966005)(82740400003)(8676002)(5660300002)(8936002)(40460700003)(2616005)(110136005)(54906003)(82310400005)(26005)(1076003)(6666004)(86362001)(70206006)(70586007)(47076005)(4326008)(336012)(426003)(83380400001)(107886003)(316002)(186003)(16526019)(41300700001)(2906002)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 02:30:32.4533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b961a6-1b48-41c5-8db8-08db4c4788da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8238
Subject: [virtio-dev] [PATCH v16 04/11] transport-pci: Avoid first vq index reference

Drop reference to first virtqueue as it is already
covered now by the generic section in first patch.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v11->v12:
- drop changes related to vq number
v9->v10:
- updated commit log to drop reference to old patch
v8->v9:
- reword the sentence to avoid future tense, like rest of the other
  fields description
- reword the sentence to avoid multiple verbs use and put -> uses
- use shorter name 'vq number' instead of 'virtqueue number'
v7->v8:
- remove note about first virtqueue number
- skipped Max's comment to put word 'structure' in same line as its
  crosses 65 chars limit per line
- reworded queue_notification data set line, as '=' and vq number
  wording was odd
v2->v3:
- addressed comments from Michael
- changed vqn to virtqueue number in the Note
- refer to vqn field instead of virtqueue number
---
 transport-pci.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index aa9842f..cfe3fe2 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -1011,7 +1011,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 The driver typically does this as follows, for each virtqueue a device has:
 
 \begin{enumerate}
-\item Write the virtqueue index (first queue is 0) to \field{queue_select}.
+\item Write the virtqueue index to \field{queue_select}.
 
 \item Read the virtqueue size from \field{queue_size}. This controls how big the virtqueue is
   (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues}). If this field is 0, the virtqueue does not exist.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

