Return-Path: <virtio-dev-return-11994-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CABC76188
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:07:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1182774E57
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:07:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0542E9865C3
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:07:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EE96198658C; Wed,  5 Apr 2023 01:07:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DD694986596;
	Wed,  5 Apr 2023 01:07:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwXB5wczdTgyqsH39tHXueZFoARqIzO+vPwLcDCUheAuLzSyolxluDIBg38FVWPBLBibN3wMji0/OlTSm4mmCq8fFPjTSK2jRiL04IdkuWTTHzRvOxQH5YJYL5WQN8GnzdAblDJxk0YPFLwxaotY7RB/JfbOBCaMGWlhgFcijqf/yjrQQi2hKTHr09Xbe9nD157xsesqnyfeJvCzfk5E0dZFEy/xixdNMouyyy+CwHu8aPGQSCK2BUntWH1RHp0/Z9qGYv7KpGojLk+b5KLMSOCwefu1ONsMpbHy3jIy9EM0hFJU6PD8GsLvvzJoEfvGUwbxiOwIK9/fe2Nf0L4doQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8riYe9hb2luKeZS4CL3hACP8LTpo80aJXCHvNB3BDM=;
 b=ejsMHWFtZ0IbHm+8zhQaIFrYWkktAbYb2aHnKxDwy0XNnNG/xr4cW5I8tbWwqg7vzNoB82YgedpjIMib4tGEoScPaSBI5O2gyVpwG6kFN8gqzpgdcQvEBuex5ffTOM8rfyGWRmjPDeAJNwrpnnGFOfOI+qXH5FPbXSDPsdjfKPtT7LA5/XRBqB5pd/RS5TMdSdiI0N0GHHB7igOTE8jTGshkRXR3kzqeezvfSTzos0t2a398f+xF9JxuwHc0JyBmq6IvOvszQFNqOlZu5vK5MVEz3flnuGwfYxVOfAx2IFqIzuQ0kkCssR9B0rWx+tMuVGf+FHtoKZSkg9R7Tq7ZLQ==
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
Date: Wed, 5 Apr 2023 04:06:53 +0300
Message-ID: <20230405010657.612529-7-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230405010657.612529-1-parav@nvidia.com>
References: <20230405010657.612529-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT103:EE_|PH8PR12MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: 363eaf07-de8b-467c-948d-08db35721fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	shT/XJCGJn1C7XMmhHXW9wySdEPNe3Vlr8LgjfmPjQ3GsJ4LlBb3Td+tTKTGXqXcUNr2JVb43El1qDn8cfp/hl+z8t0YNNewXeCoauMsoPZhOkmTp9obA1Zhk1e26nE5zA3c+nVsG6d/arorRlPznGnLlGbE8pIUSepHkYmkMjQ735OL0n8tEczSMz2KcyaGxzX1N6h7FHeqArk04yELTTQtajgzAyfrn+GykDUD0xOnOQA9jKxxsMV8GoBmsg53nmScM3haO1YQfXZJ3nsGzYb3SCN0A76320Wy6FHhMM1h1jrSihU6aDV60br9YhCrRO/7dn0hUW17rOTo9I2TDpui60U8EA1FrFecnwIyUtp3OqnZYmvhfg7iJ/efg4IRVS8dwoHYqWhmJ2WrmuOpGC0wSqMOrCBTvNyPbFCxxjqNSixWpcidJbEIUo4xml8UJS+BHxclEC6ReotIDhNpV/xYw/djvDit9JN/6N0aCQCSjfkn/v/W7k+Q3ZleWoJHY2SY29F1Q6JVqrw0BZG+lu4tLOvAFFGpafqvA+IwpvJe8LFWPDDmrZNqGSXrBKU5JE2tXrCkP4TOIJv1ErVPyx55nSNSCo6/U5b6L0+C16VUS5OYD4jZExYUENq+ml24XfMUZL9yI7zpSIk6HauvwhxrMt8hO//gT7Rnu/SNZ7manVx8ZGEPUyYn0SfjWJbQhGQRV0q8Q9va/WhiIDQcjdOk4F01+o2IPHGv4H82tX2stWXeUX46VsWpPj9tawcrkcz03HEERkOhpuqrmAMu7mvcG6uut8udKp2eQF7NTIM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(36840700001)(46966006)(40470700004)(70206006)(110136005)(54906003)(316002)(70586007)(8676002)(478600001)(426003)(36756003)(336012)(1076003)(26005)(16526019)(186003)(2616005)(40460700003)(83380400001)(47076005)(6666004)(2906002)(82310400005)(4326008)(966005)(107886003)(7636003)(356005)(36860700001)(86362001)(41300700001)(8936002)(82740400003)(5660300002)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 01:07:27.6692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 363eaf07-de8b-467c-948d-08db35721fcb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723
Subject: [virtio-dev] [PATCH v12 06/10] transport-mmio: Avoid referring to zero based index

VQ range is already described in the first patch in basic virtqueue
section. Hence remove the duplicate reference to it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
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
index 164e640..da58612 100644
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
+\item Select the queue by writing its number to \field{QueueSel}.
 
 \item Check if the queue is not already in use: read \field{QueuePFN},
    expecting a returned value of zero (0x0).
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

