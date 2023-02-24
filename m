Return-Path: <virtio-dev-return-11267-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C86C6FA8E
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:27:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5A60C68476
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:27:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4ABE29867C1
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:27:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3D79198678E; Fri, 24 Feb 2023 22:27:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A0BC98668B;
	Fri, 24 Feb 2023 22:27:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnxeFHDWdmOXwTwLOiSFgntMqt7h1yW2yRQlnwuTU9RooDe6q+d8B9igQsNEpaUAU3WkvZA+XMWSQVvyZcEiWNC2mvdMvY0seyaRAK13Vr9VLo4YsxeALA/JBUwWOuyQN+fBhqU+FSnpzxQA4kHat+RqRSwBu4SGPTnR2DPU2oLWA6hm+ccpOlhav8VwF3O/N41JCmaBYYnftSPgMLz142uydnn8h4Mn3qGqoca5zpeDPNOBPWfcHGgjE4yhUhZsx3BwSsXAWdUnnX1FOBoN8IVww/aNhG+g49KIqRh17wpZXuqc4TNEC+wWMX1DapeOJbrpQVnsu95UAG99/DWI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zu6RxljZzZXF6VH9VnVX3XkBGS1VsYBPYUP8GpnvP4=;
 b=BZr4rtZmn6kdWPihjzAZjUTWlDg1rAWKThBJ7cL4GqFB/kJDhabOJ0P3FnBkFFlNERc9vSOqEZ6EA+iwzy8YWUS6puMy8uMWrL6pcazQMFH43Tb8x8q9LxaOuDulTmqxKf3ObaBO8TcCAGj3cxTEizhgoifVzTmupKoovRtR+on2gGQDyM5ZVZaQYa1N8RmHJGTGBOjNp8gJIBR8WsBpZQtdqZxozB7rEBYjrvbfT2QbRi5YpO85DNrSuXeSo4ngAHOZf0458JnnZnMz6qIwyMu6s5xFcqVEhC21rMnWMzOsifd4CwosRCaUxO4MvFUBhh5ksI4Ggy0JA790lDWG2Q==
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
	<parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Date: Sat, 25 Feb 2023 00:27:16 +0200
Message-ID: <20230224222718.339883-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230224222718.339883-1-parav@nvidia.com>
References: <20230224222718.339883-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT021:EE_|DM4PR12MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c3ad39-efb6-40cf-6a34-08db16b65a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ioSMT0dXncVZxPollKhvF9koPhYzrJ9A8ObFBrpXzy7QDVIhbDehBE9+Y9YWuPJ+NEQpnRmYf7z7rH6/BQUQOOLq+OOYKSapHly4gsWgDi4C/9n1/OKfYzb1Y+UbLKzr1d4tT3M8garkWvxD/XVCKaM9cO9EBKEarZ+xpUzGyZnKMtCrsPDxIFDAmU+Or6Rl03tf9m7uLtk6/C88GRivlg3+DgpDI4MtrEjW675m0UE+sOIS9yWV4RNvYKEinMK0QQKN/wu0sa+0w/fG8dxryVWt/cF9qA1mQPu97Nz81sF21lcICOARClG9kfF0EvgS3yRVGHitWrKsg5BX8AcKMfTth9hIUva1CGWvs2SBzjXtZwCI2XKxcFjq/R67vdrPXr4yHaP8g0TjazVpJweuQhDyTEMPb7WkXcWMIPWeYl3pbA/488ChXDK6LKuy8Mukjt2+vWPTzb3c1rhWmVWQJGImg9MiJusWz0IOI/o1bo9Gai3+bxeev6DPnC9nJDk39DljerXHblYd7ZisCf3xu56AqhdIgqLujV03d/o45whIWXYGDcaVbaNaBtksljfPT5fh0TrZUTG3E4SSAHENdA+lkB7W/7J1a/Sj2aCgrJT85bT0MVZVUPfFDE0RSEdVBp3hzWfrH+J4MBQD0uAw0nfG1rQloEgQO5/Fm9RnFX/LkIlpJR9cOZTIC+F6rTWgaUNkAKfgu8e/ctXPzdyv58XRL+tfVExzTEtaq/ifD+5QBb70VqRjDAH6jAz3SoLB0VX4HWt3eBGnALM9h3ssTPg4gkJhGa9te10v+Ysjiba/eUvs+v7JFiGRNw8m76PP
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199018)(46966006)(36840700001)(40470700004)(86362001)(966005)(83380400001)(47076005)(426003)(16526019)(36756003)(2906002)(5660300002)(6666004)(110136005)(478600001)(82310400005)(40480700001)(186003)(107886003)(54906003)(41300700001)(82740400003)(2616005)(7636003)(336012)(1076003)(26005)(356005)(36860700001)(34020700004)(8676002)(8936002)(40460700003)(4326008)(316002)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 22:27:45.5907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c3ad39-efb6-40cf-6a34-08db16b65a4d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5988
Subject: [virtio-dev] [PATCH v1 1/3] transport-pci: Refer to the vq by its number
Message-ID: <20230224222716.JH3TCOBMPUJCsyzsfNCAmBRYe0J202cmaVEDc677kT4@z>

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

This patch is on top of [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-pci.tex | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 01fb652..0642107 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -1005,7 +1005,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 The driver typically does this as follows, for each virtqueue a device has:
 
 \begin{enumerate}
-\item Write the virtqueue index (first queue is 0) to \field{queue_select}.
+\item Write the virtqueue number (first queue is 0) to \field{queue_select}.
 
 \item Read the virtqueue size from \field{queue_size}. This controls how big the virtqueue is
   (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues}). If this field is 0, the virtqueue does not exist.
@@ -1035,7 +1035,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 the driver sends an available buffer notification to the device by writing
-the 16-bit virtqueue index
+the 16-bit virtqueue number
 of this virtqueue to the Queue Notify address.
 
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
@@ -1053,7 +1053,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 If VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
 \begin{itemize}
 \item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the driver MUST use the
-\field{queue_notify_data} value instead of the virtqueue index.
+\field{queue_notify_data} value instead of the virtqueue number.
 \item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver MUST set the
 \field{vqn} field to the \field{queue_notify_data} value.
 \end{itemize}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

