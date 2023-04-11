Return-Path: <virtio-dev-return-12140-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E07C7619A
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D15BE42A9C
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB2E99865D6
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BF811986371; Tue, 11 Apr 2023 19:24:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 55A57986661;
	Tue, 11 Apr 2023 19:24:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZayAE0m1lUz93oOeu6ylhSlh2VEBwsDjSa0wJfb+FlTCaKHAHt61NIm0hE0i/KL7W63OPcPw2NEv2/l7VmvhAQOZBJ02UZSfpssX+L8s3l9uaclZOVH2kqIGJ4fboGwNoYO15oI01SwnMx/rzgpRVQ+IkzRKAtRf9X3aZTFPqqRadnP9Z6dqB6Dyse3f17TdeDIZuhuZdiZRr0OZpAhTlgjWP/OFePIJAdwK5ZtyA2UvuIFYs0CCMr8JEP+p17oDxQPgF4t4E/A19JDqIMvoKMCJSpkzjQhOCYBmewTJvtw1aaVEpUDSEE2TfBNcYGeiUh8ap2WQm7iRAZdZPg7Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ieOfD8TvsPSS4zRZTyl+CE/fdHT6foNhDvw3rkLg5w=;
 b=nB19O22XAvGQDu9blTPYXiH1gSKtUZj/ORTMJfaieLzo+rYjSsH5k13KL8Ue6QfhOGQ0C8zyZh7FcOsSaGc7dImnQB6jH3+VFfPGCvPTbpfuQB8jSjDy0pp2z2OgK4OFjJFHn/lOGmJrWnEnIxzTX9Zr9yyZFvJVQbjajGdEGhkbsdb90qfEy3MM0Cb6O3xFfQZm4Xa7JlY7Jk/8p9qm14GPDS+N6vSDCwCWUL0W0tqrxUI4nBcVjc720gViXAOIjEjgJ6oSp+8aFRQEPpzA6NIu8xpKxEa6khKQYY3+Y7OglX0cr7hQmGWqKk0Fkki9EwHSDCLU8YFI+lGbYBKCAA==
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
	<virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Tue, 11 Apr 2023 22:23:41 +0300
Message-ID: <20230411192341.751841-12-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT016:EE_|DS7PR12MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a4452e-8c7e-4473-e244-08db3ac25596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QwRh6TvchT8TWX09JRo4K0wcBiR138YFSm1aF0FIq+Cq0UFJI5o59fUebQN+4pxS4eg311wMnJagKW5dxdUAQ8q4Eia3iAweQAnGbPu8SUSBvDdhOPK8pH8BrPNpzOadT49KtBJ7tF3yvvbMeLnno+Yt5h1pJqKpVQhq8ahXt5A47/ifus0B1CuAZtJwYfQvdd1eLxCOGK3NmwM/5Meu6wWoh/542pz1gI56w1VvYVjlQjyu5auoMXCEl3YYV+kft0tr9vP7HIxvQtc83p+tornDZQaERYDgP1kMQepXvGv0SGA3diWd8fajh8Jg3sZetP2BjXI6Orjy1MkIzjiTghX2B8BVcxDHEzhfRahkuPrje/RW4q2IPvafPpK1kKVSs4UC8em9Dj8mE3sxZbsTaFgBTaLKm+75ykqsvSY6B7SVu+v+Zd5LCnBCrV1gc1W0NtTGGLD+QEMP/N3EBHZdKKr4cgrXZI7XpCiPuLmwVhwqNuKvUcTn1NFZmRrdVDeHE+UBqRcwSN14DZhw2S/JeGNRwHb/uOuXGrQTj6Jrw5h07P8s3QezsdD9S99/5EnUPxRB044lcuLeuMXpLtv9ngKj0iSl77ubqMAyYuJEzU6LTvU/PXq8WzJyhmw33xeILAxEZXdslNwwq6D9gv2QDZJCl3jX9iImXred5HUHYVGg9nKDXXEh0g4Kgwwe6WIgwibjWqhDmjUb76IIdy5A8Qdnue5FsrQPCL+FnsR8FLQyzx20LtPNubBalnZ7phmkW801diQLLILGQ771S1r3mkb9shxOAR7yqYdTKPlMkTWaNzQHVlsUFHarwVy4Rx13
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(36840700001)(46966006)(40470700004)(36756003)(86362001)(41300700001)(110136005)(316002)(54906003)(8676002)(4326008)(966005)(70206006)(478600001)(70586007)(82310400005)(5660300002)(40480700001)(36860700001)(2906002)(15650500001)(8936002)(356005)(7636003)(34070700002)(186003)(16526019)(82740400003)(6666004)(107886003)(26005)(1076003)(336012)(2616005)(83380400001)(426003)(47076005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 19:24:13.5825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a4452e-8c7e-4473-e244-08db3ac25596
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335
Subject: [virtio-dev] [PATCH v13 11/11] virtio-net: Update vqn to vq_index for cvq cmds

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
index e4d236e..a55554c 100644
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

