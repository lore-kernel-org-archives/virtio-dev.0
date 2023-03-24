Return-Path: <virtio-dev-return-11755-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF6CC74A5B
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:06:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 284E1759BC
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:05:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 19C33986829
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:05:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 713D59865DF; Fri, 24 Mar 2023 01:05:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BE2E2986460;
	Fri, 24 Mar 2023 01:05:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4hArpZgWv/PYHh2SxBAmCI0SX2nSgOuHJKrnE868FXgnu027PQNZtvWN77oYJTEycK4Dxtr9EcKAsbusqH4mtDpIcZEOajNYuYPO1eaqdEb4sdpsb2dCqmnpoCnk4BKK74gMfXmbfaYLZb/VYMQ7nb3VRbSGue8/lTzHRncHuuQJrrs6voR4Gdt3YZpju0aMIqaDHHVc1PbySecbqborQAE4m2toimyBsQC7++XPdTikVY2DSLd7wT5JJIrn8TuC05E7LbVo8ysKweIiz7OWX2CktkZbT3Hjj1nJ/d3ifZ60pggwgSIkbBTORd9qw/UwCbMjX/z0d99hnkTcCWJfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9rv62A6GUE0xs+vJ9ZuoQfMlX6hJBVsIC9G2phIbuo=;
 b=AKPkyMoBYrJJ5o+IMlZhLQDATBHgNjvz5sKsck3vNFidfnJ/6LNPgFLafOhZFdwliGgG4XJCKGOxiAxeIz8uNK8wZOc9QIM6SUB35B3xuPj0fypcJh+JAFWKI4siont4uV7T+kfOUxMsebk3/cZmeKcmqldShFYJfmtOwXA0WS4ULyovwafkikg+0NDuIn+dnjn7SA6WiP5O0Klyg6ooMiXeuIKtuFbojeqY8Ylz7LrqczJzl8mBJXOZCOovvspe5P1Qt3rfP1uPIHQzyojdbYZ1D1w9wd0M9/hJY2cjc7iL1HMDVrWDmLpwi4sLlnvwjBDHrbOzIIeK1n5trRL3RQ==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Fri, 24 Mar 2023 04:04:29 +0300
Message-ID: <20230324010432.280330-6-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230324010432.280330-1-parav@nvidia.com>
References: <20230324010432.280330-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT067:EE_|SJ0PR12MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: c63e08d3-ac42-4abd-7d1f-08db2c03cb2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AafFsK06QSG5VcFFArO9KrC15A+DMq0m6YUegS+Y8xgzls8LFfVYlHM1wuDWLvq+CGa/EKsZs0pEuhV+YuAdY7UCZBDpQL2VUn3pCAwUmBJ4hSz5M6WIKi2/dlxnn+U0e8S1aLXM9TC80THh/t4Ei9/a36itxqWxm37s+TvGFqxBO8puDIzwEoEw1OH2BUMkk+I8ofOhJo0133k4mrWBQTjI1vIQOKNIItZXQuLm8Nayc5qeF3nStMuWByop80Mw7+k9cD8cIGhIJub7J5s908XnSRULZww06Ih7C90k39w2DOu0llR883MP5tNpfI7DAHKkovanZQAnzAjYbn9VOUO1Hky4tUuG8djN1vxZYzuFo2Ic1LK+3YmoSYym+AAVX7GLubwt5cOLomza8IsbMecfkm7ZalNCzdZ1P05wKsVQSMJV0SfDAl+bRF4vOZ939EcjfgW0EEf6GXUEt9pwCpGOa1Xs/0rwP504q2Tt6vegNNmgPtELvXohawNjsYl3CDVloeM6uKoA2y99Q1TngPtjU5OVNPphFCDprwa6JMtPqT0zMt21xPVUjgThCeF/t9hwtr2+8Pg50B8F1wXRB/APPMSOMK6p11kxKWphOHc8m0bp5aSQWj8mmH6rsop+m3ysVVYRY80qICeTdCjnD3zx4cV8uwYwGlfuAOQyZR88OrmGf0Vfdf9VPTeE2VA8BD/ip61OnCOIkrmRPlOaASn4ow5gcOJMPxmFJI+3rrYv4EKMChx/QknkKOq9xZY85Zv/8kkYhPf0yYWMDw9qxmBu291pUv+XIBKRskrSJzM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199018)(46966006)(40470700004)(36840700001)(36756003)(40460700003)(8676002)(54906003)(4326008)(70206006)(36860700001)(110136005)(70586007)(41300700001)(5660300002)(82740400003)(7636003)(8936002)(316002)(47076005)(426003)(26005)(6666004)(1076003)(16526019)(186003)(478600001)(83380400001)(2616005)(336012)(966005)(107886003)(82310400005)(86362001)(40480700001)(356005)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 01:05:00.6840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c63e08d3-ac42-4abd-7d1f-08db2c03cb2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137
Subject: [virtio-dev] [PATCH v6 5/8] transport-ccw: Rename queue depth/size to other transports

max_num field reflects the maximum queue size/depth. Hence align name of
this field with similar field in PCI and MMIO transport to
max_queue_size.
Similarly rename 'num' to 'size'.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
v3->v4:
- moved note to comment
---
 transport-ccw.tex | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/transport-ccw.tex b/transport-ccw.tex
index c492cb9..b4bc83b 100644
--- a/transport-ccw.tex
+++ b/transport-ccw.tex
@@ -237,12 +237,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 \begin{lstlisting}
 struct vq_config_block {
         be16 index;
-        be16 max_num;
+        be16 max_queue_size; /* Previously named as max_num */
 };
 \end{lstlisting}
 
 The requested number of buffers for queue \field{index} is returned in
-\field{max_num}.
+\field{max_queue_size}.
 
 Afterwards, CCW_CMD_SET_VQ is issued by the driver to inform the
 device about the location used for its queue. The transmitted
@@ -253,7 +253,7 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
         be64 desc;
         be32 res0;
         be16 index;
-        be16 num;
+        be16 size; /* Previously named as num */
         be64 driver;
         be64 device;
 };
@@ -262,7 +262,8 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
 \field{desc}, \field{driver} and \field{device} contain the guest
 addresses for the descriptor area,
 available area and used area for queue \field{index}, respectively. The actual
-virtqueue size (number of allocated buffers) is transmitted in \field{num}.
+virtqueue size (number of allocated buffers) is transmitted in
+\field{size}.
 
 \devicenormative{\paragraph}{Configuring a Virtqueue}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue}
 
@@ -278,11 +279,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
         be64 queue;
         be32 align;
         be16 index;
-        be16 num;
+        be16 size; /* Previously named as num */
 };
 \end{lstlisting}
 
-\field{queue} contains the guest address for queue \field{index}, \field{num} the number of buffers
+\field{queue} contains the guest address for queue \field{index},
+\field{size} the number of buffers
 and \field{align} the alignment. The queue layout follows \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}.
 
 \subsubsection{Communicating Status Information}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Communicating Status Information}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

