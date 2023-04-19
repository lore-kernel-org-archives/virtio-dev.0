Return-Path: <virtio-dev-return-12294-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2F7C77B76
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:48:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BF17C2AFFE
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 973C198664F
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C8113986655; Wed, 19 Apr 2023 01:47:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 05789986671;
	Wed, 19 Apr 2023 01:47:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUDo0nyZ47gsKicJ++XsRcgeIVuCKLAokOQ0F3PK/lj3hQtF5w9+20X0r51f3LIG25epiI93NVh9K9pLp9n3aIaf4jDEogj3ytuw1kk482Kjj0cFJV0nRG6UHBopd0exhkvjV6d74eoYkwA0sm/QvzYOBfqsTqk3Da/87erWkeptoU9L53Ok1SqWBnml9n79qK4vbVwPVcdJa4P0hnUjhL+IYG4t6IbKVGa/qZrycFPTIIYBTWEXfHrUt3lJzMCMvOkOIael97twc4PyktNW8U5H7A4td3hpJnXSdrZOsdQjlmZaViEAiuY2OWKIzHJxo55zKqW8qOgKTMnFpZFjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWaxBKNF8KScQrzzpB92CrLpVDN3G3mnaFckBMfIBok=;
 b=oVNxABiKbCu5jd4DoB0QQxeJeUslaZlh/mtDBuh2cAKGGEGTsGCnto9xw9nUFFGxr1HPYgKxgXDHgXewd+Dr39l/rjlNOukDPdLrlrD16EK3VNqetlzM/PJrcD7sQ51In1a31pTHjLWwPiLAfoFlQyYlsX+Umy0Uj0fXyHtiZbdnHBGWK5B7FQouBctQZjxWaWaczcJZeatINXEHdxOjx0YnGXF4Qi/799BSYKqrgaLM2istbvrSyRofF277++c+zXngfOEO7oMBIVdQdNxu4kN/AYOdFP6oo8iHzGWSRtDQgeF88sND5I0uE/sz8616x4JqPko477NWQg3/6Yjxxg==
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
Date: Wed, 19 Apr 2023 04:46:34 +0300
Message-ID: <20230419014639.919458-7-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF000145BA:EE_|DM6PR12MB5520:EE_
X-MS-Office365-Filtering-Correlation-Id: 1643b3c7-13fa-44c8-4ff6-08db4078000f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ei30X5wTYt5AXEPrZFXDK/eXUvbu5TlLw6Hxu0mEdSD1bKNfdThNSiDA0vSmflSF8a/XkEJ6zxhkfYOhd8iSqQ4p1YoZ3q+d6x4Fk87GWkuVP3YE3OYHXEBQGp8c1VMJgpRyngMO80SbSbdKnVEYA7zY/0BVAA0YXNvKyslFvcdFoyZkEWKEUuI4wZxFzwhAEjUOYdUGhgUGQ1JfsH+NPymWRQSnm3HETjPPkIf+rgZe/e4FTAJNNnoHsT/JDQKtF/K9yDXLmQA8m8P9J4KihWoTI4MLjnEshKaAC5HAOTlXd0wiM6zEjOHJTu9TL/iesh4SG7BMPONSryt6fYUTaEOhmqjVxLt2+v/KvD3iueNx8I4qA7whPhDzAEABXFfS/odl4H9ZfCMkHdC6XvJzYpYzzuWLhj4XCma0nNQ9KX3iZLw8FC4kSRUY/EU11BwwcFKxaK4IzVkCMacN4vqNkSjMoXxSJsmmU1IaOYq9N0MM2P0lubDTZzZCKJadXIAR6/UBq82ZdfnNg4xEXExbvD2TtFoO8SDZFON5IxxLg+xPQm+tfmHqEhrJG+AzirG2gThV1HI96J3aaMp0mUzFRN2bScQZMSgalwi+5p+iG0x9DXvG0WOQtB2kgla8VHG7EJLhggRN2r32F3Ps85Nx781v3e0xRtq7v2kFdFOmDDbvY+ODiMO5AjNdOwn6Nhzpd7gtXxfQY0A+8wB44orjYiAKRYpzQwLiNizdek1GzxVj+ps0iozRksbXrcKkVap2p74tL9pis5xK251lqVLKBbXWPwdU5YbZOwLMvAD00Fo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(336012)(966005)(6666004)(110136005)(478600001)(86362001)(2616005)(47076005)(36860700001)(426003)(26005)(40480700001)(107886003)(83380400001)(16526019)(186003)(40460700003)(82740400003)(1076003)(70206006)(7636003)(356005)(70586007)(316002)(2906002)(4326008)(5660300002)(8936002)(36756003)(8676002)(41300700001)(82310400005)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 01:47:14.2282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1643b3c7-13fa-44c8-4ff6-08db4078000f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF000145BA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5520
Subject: [virtio-dev] [PATCH v14 06/11] transport-mmio: Avoid referring to zero based index

VQ range is already described in the first patch in basic virtqueue
section. Hence remove the duplicate reference to it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
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

