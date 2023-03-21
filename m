Return-Path: <virtio-dev-return-11690-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F525C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 908647598E
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A7A29864AF
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6F96E98643E; Tue, 21 Mar 2023 21:59:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4C65C986528;
	Tue, 21 Mar 2023 21:59:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6LIscsir8dGtXdr9SdAxH7Bi2nIx6BA32VRqz2gGta3hnP72JdDAu/9hrLmJMz8refc7y7Klkirm9jCIG9RZowKUDKxYwtzEM3OMoxDL3kl9Jm355+CQQ6IGUk/hTxgCU85vkqh4jo+fCb/Yug+X9MALEGgKCe93GlkDDEsDX+TxSHDgsC543GLLiV7n7FjaOiOal5d8pbXh+w0M+xle2p3yKhZIZOlIDyU6BR8lj/4LJm5hm25vPmrZho4MVDju7AQP394ArcLM1/yTrMAoYyIjgRC1ekosgGo2ukCD+A+Qr63G2FfXtRD2q6/KbaxHnJlrkAxRpOWf7IWJqnuOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0o3TZKqi2ct+fRyEFw6Q1Yk4foQ4VDK7Dk5W30dV2M=;
 b=jiBmhTDLZRQZfpwYQob+Vozk8EF9NcClaELmmyUvwWsHGQE0wGVPkRMklXLjJVehXrH0qW3+A2O9Z4+92eevoUaDXy6XAcSU5iD3m/JVLiktO6FIwZzJiFJ9CuUOVtKnGhSXiAsAlb3HrjtPRQmnjPr7YW28Za98gJi+2zkVphBXo8Y514LdR47yGOTNQlfX5oiH4hQvXk/7Klcx/kj+YkkytuB7yH0PEWAQvU91yabWO4PmoypR6Ul7jAUsIIEpMsbXzqxokHXjhuz6QKd+0oO8jQIiTXG7cCq7T8T+d1QnjHIhbh/TAb9+fyCou5IPFtcvdxMNqcmYrTTvwNgePg==
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
	<parav@nvidia.com>
Date: Tue, 21 Mar 2023 23:58:31 +0200
Message-ID: <20230321215834.225856-6-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230321215834.225856-1-parav@nvidia.com>
References: <20230321215834.225856-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT013:EE_|DS7PR12MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c37d7f-9078-4ee3-c369-08db2a577f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qxCE6jB/oluTZdDL/tTZmjwtQYPzZVZTsHRH7bYeT2ON9W9xqIKckIYuHQI4++uXoZV2cTY2OOpL0M6yWF/7V1x1OU1p2gfF+GfiWBzgV1Bc0iRqxfytz5cY85HhiTETix2sKSOm3WUum7XTtn89bE7pEjgUGD4onSTJehb3TV9ye97UP/9VqCLb1v1fi1sDlxHuSwXdOEwV5cCIQCNjaq0lrJwxbkiis52gTGUZkjPc19mo/PTYlV3UEX0fJn8AbogAxbiZFnTwYNM4gjvjXwKI3C6RePwftAU8hochqy/aNSwCAxpQlhv/9hWxNQvXdxiBuWf9l1MfB66a/iKXziVKRFgE3c1Ol7MFXSfCVHTg0XvpRAx5/dvCXIj7AAS493vN2D0X17XqhBDAJe4dvQzKzj6VZ2jL24GdbxZYh79BtVy6O7BaD1wcT0WlMh45IzS5Dv9LUfAD9W84Z3R/ursKGbXemePgj0DEHkgYfz8M6hkRnTg7RMangZE6lQ1grCOhfb1sZlF4fbxFutu9jfKSM8OjOB3vBbXK5soDqsilPDwjUW7TAxvYCJM9MY5nNp4CzEat/+/BBxPdalIrFYklyavamKbDbCoHbz8U4hxiRrMIW3Q+Xhk/SdOqJfQpKrG7y4A7LxWcmwFM3+rv+h2CmbUKF46+i/CC7oamEyGMaaIWfAaiHGdtqmQIOl4fOl/FSfLM87ZKCyVb7yGrelYx/2nNCSgG06MXMB4P8g78UV12cB7xuUUA4PvLqtBWnJZ8A+IPdY5Bj9WKVDyghVC5ZG8V7jAFXiqLBba/adI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199018)(46966006)(40470700004)(36840700001)(966005)(47076005)(356005)(82310400005)(336012)(26005)(1076003)(107886003)(6666004)(478600001)(316002)(426003)(110136005)(54906003)(16526019)(2616005)(186003)(83380400001)(5660300002)(86362001)(4326008)(8676002)(70206006)(70586007)(40480700001)(41300700001)(82740400003)(36860700001)(8936002)(40460700003)(36756003)(7636003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 21:59:08.4042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c37d7f-9078-4ee3-c369-08db2a577f11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310
Subject: [virtio-dev] [PATCH v3 5/8] transport-ccw: Rename queue depth/size to other transports

max_num field reflects the maximum queue size/depth. Hence align name of
this field with similar field in PCI and MMIO transport to
max_queue_size.
Similarly rename 'num' to 'size'.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-ccw.tex | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/transport-ccw.tex b/transport-ccw.tex
index c492cb9..c2e60b6 100644
--- a/transport-ccw.tex
+++ b/transport-ccw.tex
@@ -237,12 +237,16 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 \begin{lstlisting}
 struct vq_config_block {
         be16 index;
-        be16 max_num;
+        be16 max_queue_size;
 };
 \end{lstlisting}
 
 The requested number of buffers for queue \field{index} is returned in
-\field{max_num}.
+\field{max_queue_size}.
+
+\begin{note}
+\field{max_queue_size} was previously named as max_num.
+\end{note}
 
 Afterwards, CCW_CMD_SET_VQ is issued by the driver to inform the
 device about the location used for its queue. The transmitted
@@ -253,7 +257,7 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
         be64 desc;
         be32 res0;
         be16 index;
-        be16 num;
+        be16 size;
         be64 driver;
         be64 device;
 };
@@ -262,7 +266,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 \field{desc}, \field{driver} and \field{device} contain the guest
 addresses for the descriptor area,
 available area and used area for queue \field{index}, respectively. The actual
-virtqueue size (number of allocated buffers) is transmitted in \field{num}.
+virtqueue size (number of allocated buffers) is transmitted in
+\field{size}.
+
+\begin{note}
+\field{size} was previously named as num.
+\end{note}
 
 \devicenormative{\paragraph}{Configuring a Virtqueue}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue}
 
@@ -278,13 +287,18 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
         be64 queue;
         be32 align;
         be16 index;
-        be16 num;
+        be16 size;
 };
 \end{lstlisting}
 
-\field{queue} contains the guest address for queue \field{index}, \field{num} the number of buffers
+\field{queue} contains the guest address for queue \field{index},
+\field{size} the number of buffers
 and \field{align} the alignment. The queue layout follows \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}.
 
+\begin{note}
+\field{size} was previously named as num.
+\end{note}
+
 \subsubsection{Communicating Status Information}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Communicating Status Information}
 
 The driver changes the status of a device via the
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

