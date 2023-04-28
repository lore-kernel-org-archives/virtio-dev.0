Return-Path: <virtio-dev-return-12472-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5B7C77B61
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:21:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 86AD5127CAC
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:20:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 66341986735
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:20:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D43E6986857; Fri, 28 Apr 2023 04:20:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6871A98677E;
	Fri, 28 Apr 2023 04:20:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM922w/B+Q2h2DOCL7UnKkN4NGDzyEyxy2HTBedHjQJ9iD5Pqom+vDRZJGEmh4Nw6GuCGpwQ6tus7Izioyrwq7wRYsaGUCIayl4lN4YtG3rXzqRPqjAQtRuzOszHh9Ed37nAMqdfEEm7tuu+ByerFm3OSrl6x/hP8xOJIe51TqyCKIS/PzjuGRPeSg+X3ainxR9/MkxfSpMFkzPG4L436diCR9c51Lna4OnGQLaF6uSmg0vi5oicl0bnm5Mh/18X3KtiFMYRHayrfrg6lcBWjCgFUrQCh/bhrNjxu0s94wSphG7YHMgam0HPe5YGMyEadmoLkqfkbHfC1/HW40ra3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goNfXl3K81H2qyq1n3tkctZiKgEwRdcMIGCTr0XabpE=;
 b=JzktTzwJMKTMEd6sCMM17K1FXsmaESsMDdgOc4jPq+bcg20RO4Lao9cMcqBIZjWr2G/l37Fvd/HS1PE/vcpC5KJhaB83tuqB/6FmGjX9FfWqv/h6OMbNWSrqf6xIuGs5QU9FVCXAMhmf1gJZYCDRpqXo0vP5lIBw2ueukvOe5O4ngMLocfNsVude3MzfcWsYOQK3VYyQ8hwZ4lDGgy0w4gkvJjvG+nfriI0r5Nky8p9fa5wOhLptsZik10gsMvXyHtEo8IQjl5J8Kgtck/0lYmVEbGE+0QNMMxO3RErePjra16eWoF3OK0A+dyMMy7L29n0TjL1NW40LXPAvLH0g4g==
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
Date: Fri, 28 Apr 2023 07:19:49 +0300
Message-ID: <20230428041949.411221-12-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230428041949.411221-1-parav@nvidia.com>
References: <20230428041949.411221-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|IA0PR12MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: b89574eb-685c-4caf-8088-08db479fe541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z2LIFzOTQotoml6YLmfDJAm8tu358Quk9n3R8y5Og587Zd0D7cAEBGDyvPB7ANW5+k28IPYdfKaZHBKQZW7Yn9IDDHP694AtaMxAn++C3ULkDlMpvjTacMiuc2DddfwklDZ0ZIrVcr3jHfToLbPWSE8Sgt3+3N0M5gVM0zFU3+Djd2B1KW6BCkYfnLj1ZVUIKvFb46a6skpKhtyf0gEJPeLoNVBWfu8ra7+kWROOohvJ2KkqVSoGAc6QyBmDe2tMKHYGyThNkGj2O+L8rPt/8ry+8dudNQ7YUiiZFaVAgi3fjRgTD7G7Kg3Qz9bSzu8QMQxed5Pfjbnko5iSVUjPzDZzHFiZV8lelG8kh6pCK+aHFQKIk19DCIcC9Y/EuUOdJRW6Q74nCFBsn/qLTwJQP5PD39tBwFnpMKyoM9Sp7sxG4RECjSuFqGTMORxrPS8LDpEQMbz8XElnK8/PFLKmfdi/LagFhDDx7OmAxQX096G0h95b7tOyeL+7QApYyHeV3iBmzr3nf6xkVhigbZrifTQxsm5/v2HEkjuu+D6/+7M+L+1L8SKm12mA35EjitaT/KHoeNAVxOlebbUFaVZC8i4bRf5GlAHh2qHiXTmulo9xPnjDhtOfNfWiis5U78KKhN8kTzZCh3OHXST2mROAlSNHxrSeBw+rIhGS/1ZA75f+73iSZPRin1p/ZwIbsID8yDkqFY9ArmwkVeKm/fLHnT231KGJuVrgiLwndEaDKtQALpFWxwJH6ZEy7nXYZ0Nc6oKJ5som6IO2qtgjMZ9aEg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(70586007)(478600001)(110136005)(40460700003)(8936002)(41300700001)(4326008)(54906003)(8676002)(186003)(7636003)(82740400003)(316002)(356005)(70206006)(47076005)(83380400001)(34020700004)(336012)(426003)(16526019)(6666004)(2616005)(26005)(966005)(107886003)(1076003)(36860700001)(86362001)(82310400005)(36756003)(2906002)(15650500001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 04:20:27.2829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b89574eb-685c-4caf-8088-08db479fe541
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8861
Subject: [virtio-dev] [PATCH v15 11/11] virtio-net: Update vqn to vq_index for cvq cmds

Replace field name vqn to vq_index for recent virtqueue level commands.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v12->v13:
- new patch
---
 device-types/net/description.tex | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index e25a9d0..28dcc88 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1560,7 +1560,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 };
 
 struct virtio_net_ctrl_coal_vq {
-    le16 vqn;
+    le16 vq_index;
     le16 reserved;
     struct virtio_net_ctrl_coal coal;
 };
@@ -1574,7 +1574,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 
 Coalescing parameters:
 \begin{itemize}
-\item \field{vqn}: The virtqueue number of an enabled transmit or receive virtqueue.
+\item \field{vq_index}: The virtqueue index of an enabled transmit or receive virtqueue.
 \item \field{max_usecs} for RX: Maximum number of microseconds to delay a RX notification.
 \item \field{max_usecs} for TX: Maximum number of microseconds to delay a TX notification.
 \item \field{max_packets} for RX: Maximum number of packets to receive before a RX notification.
@@ -1587,7 +1587,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 \begin{itemize}
 \item For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, the structure virtio_net_ctrl_coal is write-only for the driver.
 \item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, the structure virtio_net_ctrl_coal_vq is write-only for the driver.
-\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vqn} and \field{reserved} are write-only
+\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vq_index} and \field{reserved} are write-only
       for the driver, and the structure virtio_net_ctrl_coal is read-only for the driver.
 \end{itemize}
 
@@ -1596,9 +1596,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 \item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: use the structure virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets} parameters for all transmit virtqueues.
 \item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: use the structure virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets} parameters for all receive virtqueues.
 \item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: use the structure virtio_net_ctrl_coal_vq to set the \field{max_usecs} and \field{max_packets} parameters
-                                        for an enabled transmit/receive virtqueue whose number is \field{vqn}.
+                                        for an enabled transmit/receive virtqueue whose index is \field{vq_index}.
 \item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: use the structure virtio_net_ctrl_coal_vq to get the \field{max_usecs} and \field{max_packets} parameters
-                                        for an enabled transmit/receive virtqueue whose number is \field{vqn}.
+                                        for an enabled transmit/receive virtqueue whose index is \field{vq_index}.
 \end{enumerate}
 
 The device may generate notifications more or less frequently than specified by set commands of the VIRTIO_NET_CTRL_NOTF_COAL class.
@@ -1608,12 +1608,12 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 with two pairs of virtqueues as an example:
 Each of the following commands sets \field{max_usecs} and \field{max_packets} parameters for virtqueues.
 \begin{itemize}
-\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing parameters for virtqueues having vqn 0 and vqn 2. Virtqueues having vqn 1 and vqn 3 retain their previous parameters.
-\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} = 0 sets coalescing parameters for virtqueue having vqn 0. Virtqueue having vqn 2 retains the parameters from command1.
-\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} = 0, the device responds with coalescing parameters of vqn 0 set by command2.
-\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} = 1 sets coalescing parameters for virtqueue having vqn 1. Virtqueue having vqn 3 retains its previous parameters.
-\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets coalescing parameters for virtqueues having vqn 1 and vqn 3, and overrides the parameters set by command4.
-\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} = 1, the device responds with coalescing parameters of vqn 1 set by command5.
+\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing parameters for virtqueues having index 0 and index 2. Virtqueues having index 1 and index 3 retain their previous parameters.
+\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vq_index} = 0 sets coalescing parameters for virtqueue having index 0. Virtqueue having index 2 retains the parameters from command1.
+\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vq_index} = 0, the device responds with coalescing parameters of vq_index 0 set by command2.
+\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vq_index} = 1 sets coalescing parameters for virtqueue having index 1. Virtqueue having index 3 retains its previous parameters.
+\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets coalescing parameters for virtqueues having index 1 and index 3, and overrides the parameters set by command4.
+\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vq_index} = 1, the device responds with coalescing parameters of index 1 set by command5.
 \end{itemize}
 
 \subparagraph{Operation}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / Operation}
@@ -1663,7 +1663,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 
 \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
 
-The driver MUST set \field{vqn} to the virtqueue number of an enabled transmit or receive virtqueue.
+The driver MUST set \field{vq_index} to the virtqueue index of an enabled transmit or receive virtqueue.
 
 The driver MUST have negotiated the VIRTIO_NET_F_NOTF_COAL feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET.
 
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

