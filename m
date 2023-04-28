Return-Path: <virtio-dev-return-12467-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F29C77B61
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:21:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5387B335C8
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:20:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6E7699867DC
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:20:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 307EA9867C2; Fri, 28 Apr 2023 04:20:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB0CA986689;
	Fri, 28 Apr 2023 04:20:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlF3N2QQwno1Swcupyd9Ts4P8S4ImUo3Z8fnxBPQ3t2tkQZBW8tQBxAOO6jEu4TBe7nqRD1vEmrWIHm9PQVnvdwhmnXDOK1RbQddAXrJyMluY3h9R9oePzt0DIm6ELWZ/tK7eQqTNRHWHIGZlsHh6oKREyE4vmsDTGRuW53D4zaskuYKcsx8UKreI5oVR1uVyRVIyeot/+irP9WKJqMlx8m5N0D7xniJ/Wc27Ey9QUB8G5Grbhuyc1woAfiAYxIIt+jlKV+fOS5UhYQCUSXjNM9Rz8AjJ9grauIMZCxAJgW6Zz3G0WDaAwe0zgSMJ1G7oESpNGxvCkfTOCatTZLcug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxvZhsnOX+L7Tt2qdQ/LCPlYhzGsiY+5jm6N9VZEtBA=;
 b=Gjs4NS/E/ZsZa3RFK4UTg8NigQHDERyO5fh8RvD/8eTdvDSnWLIeKgIU3uzJD/kv4TWHtS6gVMfjJGuD4w7BhCikzgReqzqQODaKwtc83TmbpdfDJxaioSsf1OyXTiyFY8HTVJi6g7KCMa35JFn48MN3eYqnZ8EDA4+tcPis4KUf1U/f/nbdShHpBi4q6I7aDGrM9J/gr/kWRxX0vkQf98c4SWLAFYmEal5GRLOJqrJfrWF5iyPqdJjXy0fe9r6M4fYYkoGQI0sKDqw0wYUb9NMKG2FIyjjkdS10LlJxcuN9E7tqm/x9y4QIiuw6/F0BURjNROR9PxR2DITUdeG75w==
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
Date: Fri, 28 Apr 2023 07:19:44 +0300
Message-ID: <20230428041949.411221-7-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: 87012ed9-8d94-465f-2cef-08db479fe194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yvT53F05Eq02+JHy2/X7dUqn33Q+Sovy7STl2Rwjvme2LqGnQ1PMJdmmsijKkdtfon9jJt0gwmojmHq6bRMgmKrAI3sGZcbdhuKAUHR7Wd85WRJqf2aMpBXp+GAcWT8qB2RGhymFy1o0JhqhnaOXudRN/BD6b9MIuw8X2/LWdXhfrrl+UmxdEjXqwaif6ahE1zAHdvDlC+keqJDICPIyGWop5Nt5Ch6zCeV/e0ITBdBYjVJz5HyJOZM8dECIsq1VsQd95f2FZGCllp7U6j3TtWUg8PPQx6Mb1VfVgGwCrbEl/4FNMxLHLeWPU6coA2Tc0Sk9bGHdjeGhr7FJPdZpDGvK4hqLApnb8dL4inkcSO4XmxYUW+DeOuEK/sKvgYnJe006YWk+RHGWuEXL2FVdPmrCBRoS5MYYnItxfrsrqVk2eONqJb+hid0BrNjBORNLtdeLRlbJ+p4x4JWcTMvoUI+Wb1LNo2jiIbTdLmGoR2wRm0URR/xLDMdeMMMSBD3d/ViW2phHBpSckWnuDw7R3TCLKM8ZB1kypU/UovfKSvXUxdx3WMpv679lvV+YiPqfpimsJit3ZxOSW1Fu02bG72D4jLqvH9qXqbXPBeZIRAISTL75+Ieg/7DL5tJjucCqY6/kTawVP7Q32/gZeKunQhW5429Eju298Jg1mxqVYwocfBEd6TCGOUgFdywHmGag4A6Hwf1CP/IFu+v/Srcz0RfcLe0VZmVce0rub97Wjp8D7rPEr4Dac7ZazdO4HneP0KIXBAvG8ehnw4moLMi1Dw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(186003)(16526019)(1076003)(26005)(41300700001)(107886003)(7636003)(356005)(6666004)(426003)(83380400001)(966005)(36860700001)(47076005)(336012)(2616005)(34020700004)(478600001)(110136005)(54906003)(40460700003)(82310400005)(82740400003)(40480700001)(4326008)(70206006)(70586007)(316002)(5660300002)(36756003)(86362001)(2906002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 04:20:21.0982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87012ed9-8d94-465f-2cef-08db479fe194
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308
Subject: [virtio-dev] [PATCH v15 06/11] transport-mmio: Avoid referring to zero based index

VQ range is already described in the first patch in basic virtqueue
section. Hence remove the duplicate reference to it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
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

