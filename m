Return-Path: <virtio-dev-return-12142-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBABC7619A
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:25:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B9395722B6
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B0329986656
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A40359863A7; Tue, 11 Apr 2023 19:24:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F6019866A2;
	Tue, 11 Apr 2023 19:24:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7K5vrvOHa113lVWGZrPUHSNECc7pgZxDybdpA+Lui12SdxdjGNxZJo4ZwzcCDvud7pwaCrI/VMPJ/6Ejh8NEyzX2ZrRPOW3mX0mI1IcTPkfHXV7L6RNN+J1/g628G+Z07eRsF50WeKvKOd/AOYLnSUp/3z2Pf6cV2bRAUHlMfA8itD0j8JRtq9zcoHaEeNQCwecWIC44pweHd3LDAqMptlC8UcuFiP8s7H3DS3boIHYBXKhYA250pPSPVt9zgifyI67IoY6D/6uwS3QenMNj6AFkw7/Mj7R3a7jge9VzyMu76dhvNu232RDFD8TR9/kJd6A6DneA3MbiRiDmjFXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxyYBEj8K+WLVtyH06p8h19OFabUoragZNKuBCxbtvM=;
 b=RMVGhmdxh5gSunSAFlbsDyvnn4VKi4rwsFBWho2qXi8LhGPyQzwTy65zHWkyV5WntV7KKN8pTVEVZwFo7JUhfEqIigj5549/4oW3whAObIPqB37+8frQFlwnt8ufJgsxz61Y4tTcholL8eeFaOlj2cKspyYqyX/VlcQS07LPQJBmq3BjnktcInGjHDf9RHdd73my15gQ8Z7E/6vQQ91fExqS+wpDoaTg9dd7qMNvxLs7SNgNgW+GP7P4oo4FE5AV07W1gOchTzPWRMD8TBbdXIHYP0CgJD4UR5vwrKAvZR6w/O5WX1HvxkXmz83bSLMFrBYgeFwDmGyVvy1sCz8yng==
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
CC: <sgarzare@redhat.com>, <pasic@linux.ibm.com>,
	<virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Tue, 11 Apr 2023 22:23:34 +0300
Message-ID: <20230411192341.751841-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230411192341.751841-1-parav@nvidia.com>
References: <20230411192341.751841-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|SA1PR12MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d6b60a-f4fc-4b85-3621-08db3ac256fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PDedZ08wuCrJoA9cdBLmFMXaGmBfIt5AVjqrx4JFLQQJwnP9LuQkd++4QTdgTnpy1ooKf9URoQ8DjjVDYAMtvJz2Udbum5re47Zu8aiih2cw4WCZWMRN9dzp7Lq3/kJ3CG3JUAJ46wCzNTbe+F1nDDXdn1/Dm/yzpzNkYsvR9sKpnSJoXlJAwse5iz/Y7Sj0XE3lfQOK9TOq2Md9SzoGfgI9cFjSdJQ7ImBzGrQY2Gl/HhHdqgh3SEGbPNk3g6aGmYXKKYvUZHcxE1uGpNpxM8rxgNWLPfTriL6aIVllAjsSNanO0HBb0tdfrqQzPA2eMw58xy6NXg7Bw/LUV2kvRbjad0kDQixri7MgqALAAUjuldwSgsvFlgFKSUxfB4iFZ3kgEC8qrvB6GyCRS+c0iMS1YksX0QQ6/3zzueuvyu+6enBztq74T/KQuywFjd+jW7yVZgQCJmqrzHT+009nBfuLWfA7NuHMK9w7T1qNVm5tszCIPaxmA/vW3oZER42oK47m4uA0zZsRPX7PPvwjvybfeYbLgyBG9jMXJ8IBtOaBRUF3DaW1QkcId8EeQlRUTNOY+yvYYbTY+YxivuFgJV0Ba65D79j7rY8KrEJN2vjlgvPJT2yrbDfiDgwliHLL09SdsSKRFl/EzqiTFDtjyzmkeZsMjQPUBgvBsVyUSiu36qhtwmgAk0KEcUF9gi2K6rJlsyYvDKl2nxJ7h0XMSXmLzBofHCthyb1JRXHpHb5afahkcRhvJDqKiBZl/FIC3iU1/ymH2eXwf7EqPBWXxBJYucl9WDQB3D4qBCV5T6E=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(336012)(54906003)(110136005)(316002)(426003)(16526019)(186003)(82310400005)(6666004)(2616005)(36860700001)(478600001)(41300700001)(356005)(7636003)(4326008)(82740400003)(83380400001)(966005)(107886003)(47076005)(1076003)(26005)(70206006)(70586007)(8936002)(8676002)(5660300002)(36756003)(40460700003)(2906002)(86362001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 19:24:15.8592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d6b60a-f4fc-4b85-3621-08db3ac256fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7151
Subject: [virtio-dev] [PATCH v13 04/11] transport-pci: Avoid first vq index reference

Drop reference to first virtqueue as it is already
covered now by the generic section in first patch.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
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
index 53c8ee6..42be072 100644
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

