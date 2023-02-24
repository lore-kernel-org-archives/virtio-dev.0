Return-Path: <virtio-dev-return-11260-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAE3C64ED8
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:23:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2E4F842B65
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:23:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2070D9867C6
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:23:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0CA7D9867BD; Fri, 24 Feb 2023 22:23:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B53479867A5;
	Fri, 24 Feb 2023 22:22:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyS+Yd1OD1QfzIjdZ8Oc9P2kYAh4x6ZF+rJ1RfX3CU8uzOQ9MyadjG0gqptYkTuS0SXHT2Td43o1bZPbyQHVoNhq4zZt1mu3PVswpEznyByJlQxMMx39ezjujERbZ+5PHt7+k+Po0ZAaMcTYIHRyTQDQq96CaoBe23kkmqzrPu/QdjMyY1A80eauGCHm+t4Dcn/M6rixwLe2YxuyZCGQVngdLMr+bZ+Lci4qt1EqQ87DmrUqBB+qAlxn8pCPsuA2wegsu06/gAEHI5nhOz0qgC6eiH5U64qYQqWnM/+L17NmLJ3P2ftl4zp4NOienBk66/7zA0Dr1tRip5VOHe1bug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDjO2qZa51JNx0cbGDHaJXOWXiH/kBjd4yRKmJjXNrM=;
 b=AR6qyZhvJYqLWMvaSM9ZVuEiOGGLqjqxrESrgyntLYimDc1tPzXyYJSOotb2EFxDf4pR7KGTE5ErmP5bFJjvWs3kBcmFhiRlb+y9VAhc97GCj4I8b4x5G8TwBTg5jbQIY2+O3vBSPhIA8fxg1I6XBLdh7UY02t4arYieJDNGFCeewayKdkXsA24B/NxV7K4Q33Jh0TRWeKXZ83fP3ANELfREzH4DKqbBYgf4nXqLDvWEtb0DX3h0rhc91Mli4XXxr7Mf/2IMbluecVpwB1Dg8q1Rsr2haLP7FFELRd/i1UlfP1DCmwx+9kKLFqk82dSpVn/Z5r0UGhSnFenMxLDb5Q==
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
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Sat, 25 Feb 2023 00:22:13 +0200
Message-ID: <20230224222215.339715-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230224222215.339715-1-parav@nvidia.com>
References: <20230224222215.339715-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT069:EE_|IA0PR12MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb10770-071f-4dc9-a228-08db16b5a6c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lJrVMoK1WAELnjieOYzkzaNfyEe5G8HeVQME+PAJTUMNkFJ0GjjsYobHtsTrGNweZPHTW5UiwhklD1Sf64I0dyIT2/0uftfwPMAL4SLADuhdLYQvmM3urTwSwdGnydB3F3IJHvtwfXPzyO2aau1mBIkhQL5LtDmhnRxtg2OtVBZJ5vRHho2Zxoj7IGvaGLmnF50F8t63+KKmH+hD3yZ4tQCgHJr8vNs8zZcNUn/Qnrqs+UhtMT6PNM/RHLsuBOFap/0vN57YjifRHv46GEnjzr8Jy2n3cFs+1V7Kgt4aUsnmV5XE+88NxcHuWMCudS9at1Lmm3DmGgPrtJZEUZMe1Ma5Og+JtsxHXDpqB4cqtNEcWY7yn57BCg5F2oBlMkkzy0E56iQxUnR0tyeu9TJsU/+yLsGI4USFxkzdWGsdYHBGmAOhWgxGzTbOPi4srPWxk5hYgPHHboKeS097uMIfTjyGaqRoRpNM71/zcJGQQLTdNdY2VoWDZvDjG8YhnOn73RtBhpUOQVRz+ywwHL3w4Hnq/Q6xBSI+1M5Gy4fHwj9/vNhyUxHqZwfZ4Kguunru64rD8leK6kHPBhgobHU9DGRpAV7dD1B1OwUgdjLT06wK/s3Azh8ufHAkPKOg9qBhlYdqGn/F7ZbXNJCMR9jTok5SYawm82xedsH0hB/mC4w5MDDr3rohBdCUkxS77KCnBDqeCnc0DqyahkhgZmxj9Oetn83VurGYBlohjmYQ39Gm1SLZmTMkNv4+r/EDea3wP7uNB/AUnQZ43Lhg4Hx1mg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199018)(40470700004)(36840700001)(46966006)(4326008)(83380400001)(82310400005)(86362001)(40480700001)(16526019)(186003)(7636003)(34020700004)(356005)(36860700001)(336012)(110136005)(82740400003)(47076005)(54906003)(316002)(2616005)(8676002)(6666004)(26005)(70206006)(426003)(1076003)(70586007)(478600001)(966005)(40460700003)(107886003)(5660300002)(36756003)(2906002)(41300700001)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 22:22:44.4149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb10770-071f-4dc9-a228-08db16b5a6c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651
Subject: [virtio-dev] [PATCH v5 4/6] transport-pci: Fix spellings and white spaces
Message-ID: <20230224222213.7glbBgFvJqGMNp7aqXSHk2ES3GWqMvvkcd3xyiiz4sQ@z>

Now that we have individual files, fix reported spelling errors.

While at it, remove trailing white spaces.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/157
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v0->v1:
- removed many trailing white spaces
---
 transport-pci.tex | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 9c820f9..01fb652 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -5,7 +5,7 @@ \section{Virtio Over PCI Bus}\label{sec:Virtio Transport Options / Virtio Over P
 A Virtio device can be implemented as any kind of PCI device:
 a Conventional PCI device or a PCI Express
 device.  To assure designs meet the latest level
-requirements, see 
+requirements, see
 the PCI-SIG home page at \url{http://www.pcisig.com} for any
 approved changes.
 
@@ -14,7 +14,7 @@ \section{Virtio Over PCI Bus}\label{sec:Virtio Transport Options / Virtio Over P
 guest an interface that meets the specification requirements of
 the appropriate PCI specification: \hyperref[intro:PCI]{[PCI]}
 and \hyperref[intro:PCIe]{[PCIe]}
-respectively. 
+respectively.
 
 \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
 
@@ -586,7 +586,7 @@ \subsubsection{ISR status capability}\label{sec:Virtio Transport Options / Virti
 
 \devicenormative{\paragraph}{ISR status capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / ISR status capability}
 
-The device MUST present at least one VIRTIO_PCI_CAP_ISR_CFG capability.  
+The device MUST present at least one VIRTIO_PCI_CAP_ISR_CFG capability.
 
 The device MUST set the Device Configuration Interrupt bit
 in \field{ISR status} before sending a device configuration
@@ -945,7 +945,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 \end{lstlisting}
 
 Note that mapping an event to vector might require device to
-allocate internal device resources, and thus could fail. 
+allocate internal device resources, and thus could fail.
 
 \devicenormative{\subparagraph}{MSI-X Vector Configuration}{Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / MSI-X Vector Configuration}
 
@@ -973,7 +973,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 unless it is impossible for the device to satisfy the mapping
 request.  Devices MUST report mapping
 failures by returning the NO_VECTOR value when the relevant
-\field{config_msix_vector}/\field{queue_msix_vector} field is read. 
+\field{config_msix_vector}/\field{queue_msix_vector} field is read.
 
 \drivernormative{\subparagraph}{MSI-X Vector Configuration}{Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / MSI-X Vector Configuration}
 
@@ -981,7 +981,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 Driver MAY fall back on using INT\#x interrupts for a device
 which only supports one MSI-X vector (MSI-X Table Size = 0).
 
-Driver MAY intepret the Table Size as a hint from the device
+Driver MAY interpret the Table Size as a hint from the device
 for the suggested number of MSI-X vectors to use.
 
 Driver MUST NOT attempt to map an event to a vector
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

