Return-Path: <virtio-dev-return-12293-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E45C77B75
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:48:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B33A1EEA1C
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C420E986809
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3849698675F; Wed, 19 Apr 2023 01:47:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E9FDE9866A7;
	Wed, 19 Apr 2023 01:47:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kllorii28Lm0nfc1sfWmUOlmxNNZeQoS3WJuXGeb36heRcJXhqbimhzKJHELlmDJCJi1RP6XI98Oyjzf0cAWkAKjL4EsLZ0gKfGgp8K6jJL1mRflVXPH03NbYf1DeB0PwYhcoiLyo/+21pzHCwclyvAitxfzHJoRfaDfYsGBe8wgdZL1BGCYbqfwNKj1YhC2A+UUdNx2yeqkg3/W8YSX6J3L2K1EHJ2nbrZwt9qjO4BohKt1es9QGlutt0/zOMjhS2c9m1xRL6csYhfi0/3vKJl/5W3ZlLNi4UhxwZi0UgglnGlHPJ7i6O9MqLnXFjAGXM5JwzCztRrAYC8I1kx52w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ieOfD8TvsPSS4zRZTyl+CE/fdHT6foNhDvw3rkLg5w=;
 b=OnPGup9WwcC6VMNETJ9YYUuEMQBfj0sMtKX5cuF8vSgO9DLKCroOKKDmXrr2hGI/c71dzVL/0Ffzu4FlV8V+76Oszdfva1KLmRdebLD9kJXsqmR7fMfHV+ByGber5Y2M1FF+AUH0pdcDAMi8Peb7hjSl2ZDeZV17NBpVQ4HIF3NJf1ETgGZ2phspLj5YwEy1VyW1vS7W749X3rDe/SBvJ9vYvPBmhMydUGMFfZr8sTqgcQlKtIs9EI8d2CLEVWhs3lWU/6DqbEkAVF03A2bsVBtG/oaVhIz5uPXV8/9Ggb1JQKNliz7Ov5MNSXYM303mPyt6e+crdZ9Y1cgRPtmxig==
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
Date: Wed, 19 Apr 2023 04:46:39 +0300
Message-ID: <20230419014639.919458-12-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230419014639.919458-1-parav@nvidia.com>
References: <20230419014639.919458-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT116:EE_|CY8PR12MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa59fef-8096-4e0b-d69a-08db40780062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ifAHfyrdvU4t4iL652y4k2+x4QrP3h7WamIxqAplNuga5vVYn0Oq8suL/La8wZ2d6wyE8gpZbH6Itwy+5azoboyvg1Ia0r+yfcbXEWf5WB6KpHszKZE55DS1edLDhmsRGHPK5Y5gZQeXWiRVlRJVaOqZc4QUAHjuvJiwbLuSICYMN4XE6HsO3C4yC1v7we3N8xUFAIbD7/x637DlhD130O6p3WSBfE0rbSyPSz8Alq5J+4VtqYt7kyd1KtIClbS9mN7/rNB2jHAC68vf97QZhSlSC4WXtkTqz9GCVqdL5rQg0xGmDBo+0zTFBpfvDDa9yB9NU7qBGk06NC87VTxwBOF0K/sWPAmSnnEI0Fs+agVRNFoiKIRPiXNjRZLOWg/riYt6/OZ0XPymfB2H3U3Ft/CrajGCG/P/ESkTp+A1mhiVOjCOOqoQjfLjuLu0DBwVtSSTIu45ux/h1h3GuGlIuKxw7fNlcSOMZkAbK7epTjUUE2YWkFdhZRqHE0X2e/PtcBgT7olxhXaE0KIUzqTUYxWNmLSCeZF46kUNeJL+njYfjU19uqcohoKQ37+7eP9buTzLrNHgLMIRJ4NY8EngG+z8smPzw8BkX8vr/lumk+JvFYPOPLdf1QtCvjqhtUh9R2qs8fZJahHhmgRnShdI7KcD3CS6yhwOoZXwoxm3bOmODGO/7hS3Xdrd1usX+phKmasnrvus/rP9qyiuQcX0Iugpgaj0D80ju+0QZsNxUJGUarJiJeI5jh+tTJKRh9TdrUWgzb9AsD/EoL7BbGKKQZJ1fLimyYAvsZSrWmuxZ/BRr85RnJI4EKCAKmngxaTa
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(2906002)(34070700002)(2616005)(15650500001)(36860700001)(40460700003)(478600001)(82310400005)(6666004)(966005)(86362001)(1076003)(26005)(107886003)(36756003)(186003)(16526019)(40480700001)(336012)(426003)(41300700001)(82740400003)(54906003)(7636003)(356005)(8676002)(8936002)(47076005)(4326008)(110136005)(83380400001)(70586007)(70206006)(316002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 01:47:14.8225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa59fef-8096-4e0b-d69a-08db40780062
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683
Subject: [virtio-dev] [PATCH v14 11/11] virtio-net: Update vqn to vq_index for cvq cmds

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

