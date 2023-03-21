Return-Path: <virtio-dev-return-11662-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C0DC74A5B
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A8CBA68487
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F048B986752
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6E72298645C; Tue, 21 Mar 2023 04:11:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DD86198642A;
	Tue, 21 Mar 2023 04:11:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWIWxrl4E1h9YOqoMWfzLsWwWRsU9h/Rnn7eFwW+AQ7WApD14zj5TsAD1isHIwY+tQI3gjscu0IHWDXtPFnbBoUY+q3v40OqiTk1EY0ohnwKqMOcOIr0koxERTdMqFVx9ml8PIMpY3DVdZxTjbGUcRBI9zPbeqLxcK0iOb+7+9Jm0zQFj3rewSk5p7pL91uIR76xErJeVT6la8Dcassgz8oLWrhidRHqDxBCOXgAANVt5doD1pSqJy9SJ3zd++le9/kTXnoxAxQeb5db0gBorhS+mcI5chfBLW/AGkgO/0r6cgZtSQkkRasERtmMY7VjFwjRDbidr2tM13BTcjqFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhFKObljScUatxq76KD+G53gLHB0HS1WNpEAaEmeudM=;
 b=Bk2g/GhnzB+Sw401YNBTzsTxf/9pXoAswz602p/Ao6tUB+SVdDmEdsJ2IcwXvXUjbyX5Ygm/dmGa+LrtlBUVy2D3j+B0U8Ai82enOxWB4fyMkRMkkj9CWMRkWcz1tKO0ut7bOcoxQIA9lDUOLCVfHKczGpurW5c6kGLZrk8hbg3SuaLWitNVRnlEj0f7q0g7zFw+lUL1/aKgMpDoqwbk3TbKI+UQELpvWysK5Ai3pRAptb+UCsYMt8XUSvqU3B5q120RYVpZ/qhdDaVG7vyHGEL/NzWwetwaxvhhKRYUvCaT12BjTb42Vk9N3PA7HVuyglaAgNJWqAMFQzrp9NsolQ==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Date: Tue, 21 Mar 2023 06:10:30 +0200
Message-ID: <20230321041036.201439-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230321041036.201439-1-parav@nvidia.com>
References: <20230321041036.201439-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT113:EE_|PH7PR12MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: fee64525-ac04-49b5-5129-08db29c24a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7gWPomxC31jU/eCm0Pbjf1PYVLys5l2hopaVCEjmDmz494hnFB4+crp6Kp7QqUQt1L05sCXCFly/PLiu1JWcaBODLIhrdIxytrxzJu/0HYeMb74Roz9woG3XBkjqIEvTnq5NP5rkXvHgqQhbxzRZVD7OjoFqZc93TLaez2TVFNm2R5IcKxMBef5a9VK5yXqhcaovrdlPj5rOaRlN5a3Pd+BkMnaxHD0CY7vCfzBFXHTCw9vXscRx8HeVoPBQr9BC1cOtiiO3uJd2dxmUupiOlgQ8sAKblkb5EsciLNAzdFpoc014R9vM5hx5GJ1jueWJWwVz/6a0L3CvfsmaDz2nqBEN1u3SLqNpVHpd75OwTdJqUnaQr7djq9VCAWOdQgOMuU/rMsQGty5VCZXFfD+MVfhrFjV/e21yIBsA56qOCLoHm8m6ftiZFyLDvoZXUJ8e8RacXNfuLpS6LElkZDTn+d7UgAMf9AS3x3X06m8wkPkqSzE0BA0vh6PW5/9jAIAVX0fLd+p6Yk5FT1IPYrCSZbuy8kJgLlmrlX0MOIgB0xMCrzN0UkeCeuYScU2sJLO/SnZau/wkq3gRDW4OeemWdUjfeGPzr0s0olQp2LfYExZlB16GVhLsHIgQwfBwdUAhPQBTpsmAWd3WiRm0Qd6u4oqxrGNbtXxV9aHVDrefTGSPAY6rzpHb91CAVHMeI8jHOuJPok2UoHd1HHRjxvAtDOQ9N5jS3m6HK4Ejf+DqHlvJQJZIklTepaIZy7+H+X5Z5MUPqlI8kXbwhvR40OKAGSRdzYNAi+jQ867kofdC3EU1cCpVWmZJ8XZ+ztO4bWsBvHbtQ8/dxFaW/5VI/MWBUA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199018)(36840700001)(46966006)(40470700004)(316002)(54906003)(6666004)(70586007)(70206006)(8676002)(4326008)(336012)(107886003)(478600001)(110136005)(47076005)(82740400003)(426003)(2906002)(7636003)(966005)(40460700003)(36860700001)(356005)(41300700001)(86362001)(26005)(2616005)(186003)(16526019)(8936002)(83380400001)(1076003)(36756003)(82310400005)(40480700001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 04:11:04.5924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fee64525-ac04-49b5-5129-08db29c24a1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610
Subject: [virtio-dev] [PATCH v2 1/7] transport-pci: Refer to the vq by its number

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
index b07a822..dbd3adb 100644
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

