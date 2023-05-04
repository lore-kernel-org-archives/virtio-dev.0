Return-Path: <virtio-dev-return-12541-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687CFC77B7F
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:31:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AE48A370E3
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:31:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A67049866DA
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:31:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9A36D9866B8; Thu,  4 May 2023 02:31:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C8FFF986813;
	Thu,  4 May 2023 02:31:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5/sJZQhfv0ojAEX+ze6ZO/o2k2v3EkuQso44G6qx9UoQ0TSwpZq5k2jmL+TxQKN1x12XUb5qpdHsMLwavcNlqA45iyW90MEJzJjcA/0LRJ9G1VmDrGSRi+xV2DwyAZ5EFtm32VXw3AnUhrSFt8FfrPzMHGNv4jf1X3C7gD9CORBFIEIt/uMwchmyjKAjDIG8aObDXMmCX0B6kDK7a6fQe6XQPx8r325vyq7dmAhANrTazXG4wi2rrGMJ3PueGeUjr/d5suqXbV9SQGW3TGDIDzpTZ4ZcpuAC9/jRIuvhH/CDR12fkAsVtjmgEv55qGQcIHPAEa+mgS8XtrSu7Msmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q406ff/+rL2bNbD/kk13stnf2xsQqSQR2UX2HdcoGzI=;
 b=bHhtaiyLeN+DJWUOZWhD51/Ris/T0fXGcyhpfRDK0tYP95TQEHJIBHxvWAtrwWm7606YojBRG5rHvtWkEvBexG/lwNqDrmx5PnbwxHyYct3HpJ4gLFexNnzKF4H6oWYROvEDJ0ULHzLK+A2Wz5YAat0BWQVEofbWXKQWDwPpLQSeVcbYXBLaSNNUwkFNHW6lfhqM95bqjfhdF3wa0I1hhgk0CaOh52bGnDu9JmB2PEM28+gkaLazHWGwobU7s4JeyPX7uj3eHkLj08ye/8ERKhW53tmZdYQ8nQUo0NCDnchOIZMAETcCKXnwNNPJh7jqqIdpnve4Xc+XkGjslGwIZw==
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
Date: Thu, 4 May 2023 05:29:59 +0300
Message-ID: <20230504022959.547025-12-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT065:EE_|SA0PR12MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e5e97a0-d43f-4f82-c2cd-08db4c478dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Xofiaa9xLnf0P7pUKhph2GRDpi0G8C+kPZCNvikcH8AOcl2/3xPSiVuzsi2NdUoAlOlO3XgLeYv7NjySJGVzAuBtRkGMuyiEBjQT5ovcTBSyOCDFUEb6jDJ7LN3mi8Pvuwoaazyf+j52ScD60pJCq05Jf1hL9I+udO6PVw7LE+m+RH5wz/F4y8xmWGSfIR5Ecb31YsqJj+An8hL85rxBdRv1CuVfzfbJeNRCaNvvTWCZaubA4NgAa7LW1vqXkPk4INXo5prVsPsBOjskAQEQYnxYJMPY4y2LH+AsVpIsMSrgUm0wqduGqIy0pG9o+Z7Li3lcukIOsmqOJQq37hmF5cdCCgdxaA+IdvjqIS83GEt/jbuZOpoVKcFrH7Io28XqPlL+oOKbknj14PZ8J/K8CvmTECmQf6enErUdvE6637LNf+ZGbNYTWvZ6+eFXbo+5Ejrj/veDAT3/ihVLMdFSdgRdaD5IvAomiF8AuU8M0nASMQyA0wb1TFxDtoyvbyjzDxXw+3Wc5S0SIVqgfTpDBECo68CKZKOLX66ywJymgjtC8HRDaLqdZiWZ48LtaFGIm6uNEOyXDIaW3zB8C0Yui4Wda6qkxReZkD6Nb2eWfLzP0PdTWjxKCCUlUbaooC98wtLsZRcHDjowgI/qRS6IpJkzVhTpqpk9aJSm4b6GETDQKaOxhoC0udiXBZmofStbRtYHGgvRuwT4MOBshWwceSKUsfv8fzWPeirspCatbh7sVSN99RlJxI0UzBQipoK
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(8936002)(8676002)(426003)(1076003)(26005)(2616005)(966005)(336012)(36756003)(40480700001)(107886003)(356005)(2906002)(15650500001)(83380400001)(47076005)(186003)(82310400005)(16526019)(4326008)(70586007)(70206006)(6666004)(478600001)(41300700001)(5660300002)(316002)(54906003)(110136005)(86362001)(36860700001)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 02:30:40.9743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5e97a0-d43f-4f82-c2cd-08db4c478dee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
Subject: [virtio-dev] [PATCH v16 11/11] virtio-net: Update vqn to vq_index for cvq cmds

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
index 83bdaef..3030222 100644
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

