Return-Path: <virtio-dev-return-12326-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2080C77B73
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 19:52:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0B3D426A34
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 19:52:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F0CB6986656
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 19:52:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E4C5D986634; Thu, 20 Apr 2023 19:52:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CE809986635;
	Thu, 20 Apr 2023 19:52:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9LgxzbScZ3+p29TmIaZ5DsRBDpEK2OyyzE4dlIyvCpkTt7vRfzIYVXCknWcOQyY/3m0kLFvtA3QOHjPtkgfdCcsaz3Xt6Qk5bRSUmyPZOUrDwkf4GgNnNggEunFuoanea6x4izJ32gnkOFyZPod/yfhpgGE/aGymNXIMfSUPJAbq+NWJ1m076fYpY0yXCKXrlGThW4+TH/SY/BYYXikPXApHAzF2KaaqjeRBHCIETq8DEu2VxJjPzDh+C4IgV6wMOZeQlvw1It24J1feee/byFMOXPKIl4fI4WO+dVS0CpWO/LD7Doe8yBBIClN++NSYc1Xd1NOyCizkCx//bg0Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oo59g8iy44mqEQ9oqFSI1a3OoHL1OdhIAUILsb6jZg0=;
 b=MshPJGUSX/5ybZq61V41eZ2vOjfZ5lKFTPNE58mZx4ifV5dMWHerJbr1HuMl3hyByg+dilPioIuX5A9bRVeKsCQ0rXSmsq2uKJfp8EW4B0/lt6ZAKZ5HgOQC2rwpZTucczY0Ot+oll+V8qtbJqhkBbd5McQ/F1+k49Lvd0KKBm9WyK6O1xoYAUJpk51vu7PqloxhfcIiShpc2hptPHnrmQSjY96IbVArqfFAUQNYSMEGKajj7jJn9j824ffs0iD7099ipb8eVHzQCyO7AbVjFHEZFTo+mGtB4UwUFmRx1oiNCUbhvQGz5z3BQAXGdw4K6zpy1I96vxziQUnS3udHqw==
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
	<parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Date: Thu, 20 Apr 2023 22:51:57 +0300
Message-ID: <20230420195158.69737-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230420195158.69737-1-parav@nvidia.com>
References: <20230420195158.69737-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT086:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: fd9392ab-71b5-499b-95b5-08db41d8bf67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nxjgZBwVo+V3Uh5bUo8KsUmmuDlNhOYDw5aCD+4QJFbgS8B+hW6woshDOwVa+EY0AaSDRRLC+v0cGWY2nekKV+xSQXmWY2penvmHtfQC9NBCi3L2oGuFcdegK/uXZ1ARDc7FFwD/+LuKinMCLtlvkXImvm/FAmViNlr+N2aid82HMWhGPeEaj8Xih6GqvgtPa+V2l+TI9tWWc8xSzHyAYHqOHHhglKeAsGwVUkRHQ3ZGeKF3PLrBwsIT+yJzUlRDmkCHPTwTVsnnKu6QauDEOk2rwj4gcH9FkmyfBjTk1X//KMfPyT/uRaBRVui9QMpwS8dgxM8sQMLJTXUa857k+BdA5eP6sC71eTxgKEWt/WPxvrLPpLKtd1hEEvZUIKj6JCzyxO10MYDieZFAXAS0iAkIp/FuYofm+v1UzOZe5MfsY/Rt4bx7gKLs2FAeK4C9oqJVosjh6AO/+3Meelx0V5o99Zarcu2RJo/0HNPVxl1x1R0G8zuJt7ERrMV7hnOYMOZAmohNBCAaHD11lVUGf7ByE0IV6nLGMvmcBJEjjidbqEFQHGlzIlfi6JfaKqceye1Rym3+2VJayUJQAfIBIQBkwI0cuQigP6SZy68q4vrbSss8MF/Xw8aAsLN8B8e5rBMpx2FlXXhY7/qy2aI59HF4+PH510vLNWG3f24UYu4O+6MJF+FsmZc3xrjOdhrOP4r01C9ExjC5ZtB3BolSwp3rcEcWn+MbOIHETXyK1swpL91I4izG7HTdU8OBywPW+Cc81vGF/muW2eRs3xILCq4JWuKzW2D7abMBDvZxHiM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(36756003)(2906002)(8936002)(41300700001)(8676002)(5660300002)(316002)(40480700001)(86362001)(70206006)(70586007)(82310400005)(7636003)(356005)(4326008)(83380400001)(47076005)(36860700001)(336012)(426003)(82740400003)(34020700004)(2616005)(1076003)(186003)(110136005)(26005)(107886003)(478600001)(54906003)(16526019)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 19:52:18.1473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9392ab-71b5-499b-95b5-08db41d8bf67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441
Subject: [virtio-dev] [PATCH 1/2] transport-pci: Improve config msix vector description

config_msix_vector is the register that holds the MSI-X vector number
for receiving configuration change related interrupts.

It is not "for MSI-X".

Hence, replace the confusing text with appropriate one.

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v1->v2:
- rewrote to indicate MSI-X table entry index
v0->v1:
- added 'here'
- dropped 'receiving'
---
 transport-pci.tex | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 1507c69..cf2c54d 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -343,7 +343,8 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         Driver Feature Bits selected by \field{driver_feature_select}.
 
 \item[\field{config_msix_vector}]
-        The driver sets the Configuration Vector for MSI-X.
+        The driver writes the MSI-X table entry index in this field for
+        Configuration change notification interrupts.
 
 \item[\field{num_queues}]
         The device specifies the maximum number of virtqueues supported here.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

