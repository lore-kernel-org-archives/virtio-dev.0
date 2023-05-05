Return-Path: <virtio-dev-return-12566-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1698C77B7C
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:48:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5E88F16E5BE
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 558C29866DF
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4914E986654; Fri,  5 May 2023 01:47:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C2F88986768;
	Fri,  5 May 2023 01:47:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebDqAtEJPF//xakOxlckTl6Pj79ehTY9C1g4BYNWNvCPhSsNsoEndNkguvp3BVPQjjGae6HkTh28ND2Sb5hMgXOumB0b6SZFKQt2vvkWWFo+y9zhVIzE2HTGumEbZZmbPQ+kfH82wIClxk1CQGEPbZzsM9TMuuA1AlvCnVwBxZF3+wKmyunQ8/U4QkMrnkBazhnjOoJSJkkD+NyYRfN6F0Ko+/DPGWIJT1PedHz+6SD13k0krBJ9HI6OZshJlnc4A1JUD3KPgAVmEbiATE2i8zgpGCqDLqwvtxtYWk+tlwBqL17K38bVkx5ThRP8Dxr1zxbgFONpuZooRfsMqJESYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1ecDeLjYH/nHANlEMIl6D9vxLvlHPoLugLS7uiWEu0=;
 b=d1buNrzm/lOCZ9E7GfznsodWwKQRm3m5EoTZvgiTmZ3xiKuvabICDZGM8w0jl6h3TmJSQX+3wSCBStnF0lgM9e3H6wFUUpIK7rVDJTGADpJnU2WFau2K/i8f/fqT4NkkvP8wiW01sNELY0ld2uEUrkc62pOvopJgL73/tNHbnIbOKSk0SrbGe10PMQXJ0nfloPvSfIQaQf3P4Ch/HJDfY5X4ODDHeM+EF3zUiplVtfX+Z65DDhS9sKOHxqzwdftsunGvY/jIPPmIE8JEKTNvG7jwFHk0D3Uo/qBY2Tl8WzLCDJ7kzpIbSWxETH9XeglDJ3KD9CuFZyijZHiOCqmXzw==
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
	<david.edmondson@oracle.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Fri, 5 May 2023 04:46:14 +0300
Message-ID: <20230505014614.571520-12-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230505014614.571520-1-parav@nvidia.com>
References: <20230505014614.571520-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT088:EE_|CO6PR12MB5394:EE_
X-MS-Office365-Filtering-Correlation-Id: 241bf952-81b5-46b2-a079-08db4d0a9efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h2GMTmD1VB8UMCtv1MaXu3cNlMXd4kbe5OY+AU/ZIAq8sAG4/8yuefDiY/d/Jq4hv9mgkmtSB/WFAaIdCab45NDP0wbogdTvNgFqvEDtEwe1IdVpApMpMpUwcEYlO9NIoVcn7CFHZ+qdqpBenohqLXOaSj2IA2n/ZdU1rVMuGT2l9TJZRO/NKdZaGHCWBPb6lCmT4JxEXuwyE5RW4uMFzyCfTGAYZPgX4rjVpdR/DKxvLV7ZWQUA/bUv+p/YyWGskapwlk6OAt1pR1ITpazTrrCGgIADVtYysp53XI8Qnj7nKYDauVgvmUi5wF7A8i/p2qtnR8BapAQ1zifLJv4mOfsbqVIWUHZafN8v+C4TV7RsEGceaws8SHu0GP0IO9BbflSk/JIYTp8O8kPMB+omxnLopWiongMAPFCxXNe1xr2T7nQ/TvIYoMQeslQOufTIWLy28dLuNJ65XEMI2Ntd27cFIrRvyjwMDV+ntNCxhgyJthH5WWU1WxbuE7JqUtz5PA08BdETlJeGtqaOjUJGznDEr4TYN6Q5GIR0wtYMSOCVdzr3nGkEp32HGHET9fB2uiw8gIzQQj2PhZlSDp36iaks/WkLQXEcUlb4tb/v7z/IPT16SGqcGsCWJRIL4bA09rSLNU535sQfa8TFwXxTPJ1cD0hNSs2WNsbJCRv9HeffQrwzTnqC/OZFH0IXLo8xHXOQXid+iBI9/41BHby6SUiXtqJG3U3saLzZVoLGcfGQQvdoMTnzhIEpnqZaMash
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(54906003)(316002)(478600001)(6666004)(70206006)(966005)(70586007)(4326008)(110136005)(86362001)(36756003)(47076005)(426003)(336012)(83380400001)(1076003)(107886003)(36860700001)(26005)(2616005)(8936002)(8676002)(40480700001)(5660300002)(2906002)(41300700001)(82310400005)(15650500001)(7636003)(356005)(82740400003)(186003)(16526019);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 01:47:01.3993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 241bf952-81b5-46b2-a079-08db4d0a9efe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5394
Subject: [virtio-dev] [PATCH v17 11/11] virtio-net: Update vqn to vq_index for cvq cmds

Replace field name vqn to vq_index for recent virtqueue level commands.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
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

