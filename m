Return-Path: <virtio-dev-return-12567-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD24C77B7C
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:48:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C5335370E8
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B8E8B9866C9
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ACC3B9866B9; Fri,  5 May 2023 01:47:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E01389866D7;
	Fri,  5 May 2023 01:47:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0jGuwwnkxzRkMtUu/B4ydtyTG7yN9/go0yfoH+rbG/Zkiwxk7J501sqmrdcnxUB3fQF6MvExnzreutZlKfCl3S3BF9Nc3CtMwIPOvpfIfTk/nFYutvjg2RFSkpcYqFhSuWvZG7n7tN3rdeD1WBsCtb42LWiEzNm0uEYU8pgVXOlH7eF3h4EN2oQ6M+rrb35nqPUFYB+zqNBlIJCI96af7fFRFRUKX7hKLdTMgUZS1Ccjj5wx1wxyh0j0/4q5bUTQPCoOT1e+19imfWdx0lY+MX/ZcZAlRXCB7inmptaG0/1PQddXb0X3dOJRnEvKwzBip1bqaSLVNbR4tAlqWSQrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/gxVEomAIBIObxKbr7H1TnTopsNeP4mUM/LT13yx6o=;
 b=MaTVS1G04rlM3rjqnsVQYJB0BdI40mEAr7uzASOdhmh1LSxvIik5bHWwn+JICjT73Lv8VJot4O93BqYA5ktyyHvR/W5NN4JFtYXeieIOLG57mYj3RfOMa6E9xpJ/xOMucEXotuxFwBkZukEHMRFTmz2idX8Y7FT2SGcMerKCcH+3A0//ltDsmf4SpY4DLG7EjTrINMtqes4e7f+V0XKZICsoLf7/UPvE8F59JutUjkwFGzdGc84PVXK+bu6TJXdBmUl3F5QTyH3Ks3+SzOymTcwzVUSk38oOBRWmf9RnSt0zV5kxI1SdQhjtFBWsLcZlcBIe2JmPpzT0YMZSosdFyw==
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
Date: Fri, 5 May 2023 04:46:09 +0300
Message-ID: <20230505014614.571520-7-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT060:EE_|BY5PR12MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: 60de7f5c-5fa0-4085-c70b-08db4d0a9cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e9yVwGoYV0h9txA12/f+7uYzUF8njHxhv4J88yFI5tC7qdaZPBUfWiknwx/jLNajiVyRB0aukaBMmSeGPqf1kW7bFQ7PbsrECcZubW6AMqyzetXk5JtzX4sublSCneCuB0K9ypiccMcBfGekPkYBcBpu7Hp/j6My24m+33r2duvgpBqD3QMGfTAMlopKDEtnLLR/33hPuc8ZSuhI6BcBHRz4Fweewd4DR3gq7+geM5M6ntGFcDs9NxKxiVw5YkVM9YU8Ub9y+S3bW986uBgZnXcW7llr1tmCq8bltspfFFFplNUlcfVRUGR2lbnXabDm06EulQhhb2+e0GcdNTz6RBG6kYLaAts4BcQhXxrG6gzjz8giyD7f/d2CBY9z1y0KP0omLvuOBVtWgbROhev+h6P02xLwA0Kqm0s+ap7jDDJo91p2QhWYXzTHShvNe/P5WCMf4tg6JUBQp0McajUFmDor2VCGppZ0v8boxV6epF1HfmqvNl2p64pM/3GrsAbhcsIGDE3kli8CK8/S8cjc2+1ra/mJAsWWowT/BWMkes34AGiEUbhk6dzxfgClfLXPcoBG0Ln7Vvwr82OrhuH7VpOf6szWzoTxc/AVcy+Am6OFRo2KQYc7/Dq8EEr2jOlL+7bL9BCxf5hMSkegvOM6DJH168QaN4/WFj8NvNi0wmPZ9wOURnm4BS6syG+ozolwnFEtxvrmWxjN5REu0nWcuycdmlK/fBXZiA/+GAeQSrU50apiWcJ31dDosEDCHftK
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(966005)(70586007)(70206006)(4326008)(478600001)(6666004)(316002)(110136005)(54906003)(86362001)(36756003)(47076005)(336012)(426003)(83380400001)(107886003)(2616005)(1076003)(26005)(36860700001)(8676002)(8936002)(5660300002)(2906002)(41300700001)(82310400005)(40480700001)(82740400003)(356005)(16526019)(186003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 01:46:57.6214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60de7f5c-5fa0-4085-c70b-08db4d0a9cbb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324
Subject: [virtio-dev] [PATCH v17 06/11] transport-mmio: Avoid referring to zero based index

VQ range is already described in the first patch in basic virtqueue
section. Hence remove the duplicate reference to it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v12->v13:
- corrected number to index
v11->v12:
- remove changes related to 'vq number'
v8->v9:
- added 'by' at two places
- replaced 'queue number' with 'vq number'

v6->v7:
- remove text around first vq as it is already covered in the basic
  virtqueues facility section
---
 transport-mmio.tex | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/transport-mmio.tex b/transport-mmio.tex
index 164e640..2d24b4c 100644
--- a/transport-mmio.tex
+++ b/transport-mmio.tex
@@ -113,8 +113,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     following operations on \field{QueueSizeMax},
     \field{QueueSize}, \field{QueueReady},
     \field{QueueDescLow}, \field{QueueDescHigh}, \field{QueueDriverlLow}, \field{QueueDriverHigh},
-    \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset} apply to. The index
-    number of the first queue is zero (0x0).
+    \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset} apply to.
   }
   \hline
   \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
@@ -363,8 +362,7 @@ \subsubsection{Virtqueue Configuration}\label{sec:Virtio Transport Options / Vir
 The driver will typically initialize the virtual queue in the following way:
 
 \begin{enumerate}
-\item Select the queue writing its index (first queue is 0) to
-   \field{QueueSel}.
+\item Select the queue by writing its index to \field{QueueSel}.
 
 \item Check if the queue is not already in use: read \field{QueueReady},
    and expect a returned value of zero (0x0).
@@ -474,9 +472,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
     Writing to this register selects the virtual queue that the
     following operations on the \field{QueueSizeMax},
     \field{QueueSize}, \field{QueueAlign}
-    and \field{QueuePFN} registers apply to. The index
-    number of the first queue is zero (0x0).
-.
+    and \field{QueuePFN} registers apply to.
   }
   \hline
   \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
@@ -550,8 +546,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
 
 The virtual queue is configured as follows:
 \begin{enumerate}
-\item Select the queue writing its index (first queue is 0) to
-   \field{QueueSel}.
+\item Select the queue by writing its index to \field{QueueSel}.
 
 \item Check if the queue is not already in use: read \field{QueuePFN},
    expecting a returned value of zero (0x0).
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

