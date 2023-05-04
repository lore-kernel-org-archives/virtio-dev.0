Return-Path: <virtio-dev-return-12540-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E53C77B7F
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:31:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EB97B17917A
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:31:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7293298677D
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:31:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 900B298682E; Thu,  4 May 2023 02:31:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3B2B0986718;
	Thu,  4 May 2023 02:30:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFaYAWRL5WZ4vWV/5+52HTzLHmtH4wv3fo4iu/c1NsL2WpGwrFQO1an+AxCwWxORwEEWxI8BoT9EMhBWQVLpv264ShzPbhIpatT5EU+1T+k6+gF+kUcKuTtbW0ZgUq4l7/F41a61sCkP8R/uNSjaHUKtIgbH+FjBMdt6NSlTpXBAgaq5/sBaJpp6ab2N5PP+kMRO7qsqG+udva1ZTS6kQ42qtj4NVStWD0bxeNi8/3F6jsbJ3a1cRmnGEpzECNZPAsdF7MVSybewUOsrDZ6jp+zEK4vDXpKbJ25TNbendLdmYN9af3aLNRVmNS67MwEDxB73ZfZD6uzuaAwmWQHnIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxvZhsnOX+L7Tt2qdQ/LCPlYhzGsiY+5jm6N9VZEtBA=;
 b=aC8zts+IT5V1ppqrw9lr39wan1p0XhL5LgZ9sIwQ0OowjzsrvC8M+uHqtKflhmYwXxcUIgc8wGsQnZVvkituWZ4LZ4a8lxQ8GhGu0aWmx5iEThpsIrKoum6M70BNmf5k5F9cGMyAY0Jn8lJKf+TuskbQ2uqkLWykzdWqBME+cAm484ZP+SR64guE+g06jJlDbQkRDzMz8gh8pFWdb1lR2yob3zLiTWy1MbD7NwRWGX5TUT8FHqp9kq2DWKQO/JbtuvyZXH2BPFMupfUVcAHMJCycgspQyLIJZmmI+OQvvS+f3i8Oq9Rpz+iQXEDGLH48zu0y240d4QbBka2HnsawzQ==
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
Date: Thu, 4 May 2023 05:29:54 +0300
Message-ID: <20230504022959.547025-7-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT073:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d35c9c-a0b9-4d45-1ac6-08db4c478a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N4sFa5cmmFpW8ySvHwPl5E1geAjRWZ67QzTfA1NJIxbRsbaL68VfKW68uFcDvWQbDC6vwuwC6rvUr2e2hZw2OEqqyKMD9TGCNVWEIrjGXYWanljEUQcEBjTbadBhWQNVREhFkLQ4bpgiREIFTexPAlbqJptFDzzntDbY/0tZGGHqkAJm3Ff5qgHCZ2PEh2Nl5F4SA2d1UtwzEZEk+0ZxIO1cRqaH5yb0hFCoxDXXS9V6rxkBDBigYjgaFlkxuDkjdNBsUjrcBesjj8RfivIThOMActHWHqY/K738+ZjdQwpDSOxBiLGeviaOkyRWesliq0qNzToHnSLNZEgcggSF1ViNgrM2ixDeCeaXvcNofbiJYk5RDgW2MhEfYr+GHsAOMSrUM47AbsDx3a48QSltmGu8IfRCcz0ND/Ak2EwnvhEFZ1cZPbQ9bIL3qvfoEspkcgoKgSvprRodIJikvtLgMFPEIR3NiILPMpQZhMBGePC9P8geQ8Oytbgo73Yqs6Og5rqWt2XTx0gH+ANnrh0J08UWHht00mIhfVLRFMMAHrG+Ti4A5JHDov5oK5nHMqnGAw2d6XXMPZ0EFeETO9rB2/Vd/gMazJkAEiGe5UNtK/ZB/+Bn+KlSEYLg68011INO3WL8MXReuk5W7+j/v7jVWn1kJpA9IVWq1+Qmowuh2/CtSofdYzW4+Xc3uvLaC5qPiSTtmi7BWRg125RJpsPaDSwtOZZh7RWl1IRMBoMGlCcSWvj5/EVahQK1o2YMH4gf
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(8936002)(356005)(5660300002)(8676002)(7636003)(82740400003)(41300700001)(40460700003)(316002)(86362001)(82310400005)(36756003)(2906002)(40480700001)(36860700001)(186003)(16526019)(2616005)(478600001)(83380400001)(107886003)(6666004)(426003)(966005)(26005)(336012)(1076003)(4326008)(54906003)(70586007)(110136005)(47076005)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 02:30:34.8031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d35c9c-a0b9-4d45-1ac6-08db4c478a41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807
Subject: [virtio-dev] [PATCH v16 06/11] transport-mmio: Avoid referring to zero based index

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

