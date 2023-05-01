Return-Path: <virtio-dev-return-12484-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07ADBC77B7C
	for <virtio-dev@archiver.kernel.org>; Mon,  1 May 2023 22:44:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8724C3DF5A
	for <virtio-dev@archiver.kernel.org>; Mon,  1 May 2023 22:44:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 544B49864A5
	for <virtio-dev@archiver.kernel.org>; Mon,  1 May 2023 22:44:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3BDF298484C; Mon,  1 May 2023 22:44:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2119B986466;
	Mon,  1 May 2023 22:44:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCvDBoJ9QEMNLegvSmBPJc/ZN/+1kQX4Z18vkT+WVBDPjydpZSJk7FBSpBnDA4EJLos7ANRj38wBsEfCzKsXu4ZwLIkQuOaZBWTSlhX4e1CNXXXP3MsIdi84+LmO8Ru2+BTzxRB+UXdGMxX2gRiJGUeQOqMWvN45s/8mmg+s+hoHwn4b29YzgLv49CzaYaPiMhD4OMF+kUAtvGU0JN5YZv/BvdR7NPSeK+eaa5KuGs2ilqycLt9GSQFpUYrqoUNG+Y61letI79MKq10/L9lORfBxwh6QxEmF4E2SqYdp73qlbFPjLcwp4sYbX6k/JG7gTT/9lvJX/qbyK5E+oSzPnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XH3peg9pvZ7K5S2i8tF5D9wpezi9poGWYek1G1dH4V4=;
 b=B2ppCmjwlqq84gX8g6WCXS9l2DF/chk0Yv/d/X3XIfyLQkAnxJwJgZIt92+6kfXyJ3TYjG3EBuNfwzqbo0WAIU5IV/h1pGuLSnbuFblf9sBFrJjBs9Gx0EEpBDd1wzg3VwPrJDZBGjry+7D9t1DRerXrwOopGNoeD0v5Dsmc8grClEsHdi0KWjpe42Mes+FKEYszGXQZ+31faXWdf9m2Eg1fCnuaJ4bu74W63Rpz/aUxGE3OkBdI9AZa1g9ZFgR56Ang7ooxBytdTBPx//YqmQj8eNzH4Wsyv46o7VQRiPIZXQvX/x72tJO2dhcUEx3tgdnxmC4pAhw0WUzbPHzzug==
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
Date: Tue, 2 May 2023 01:44:29 +0300
Message-ID: <20230501224430.485139-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230501224430.485139-1-parav@nvidia.com>
References: <20230501224430.485139-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63E:EE_|MW4PR12MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: be1df04f-7038-4c69-c236-08db4a95aa67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i55o3AovPHaVHWI8bSpi+dFOiZcOIoC0mJKyCqxH5wP2CvAgRoTg31+FrC2be6PYCwLOxE9qHZ9J6hjUSzDq29x5k+yKx2ZmYrBMHoZ0kqu2UljUjrc+fxDH8Vlh1qs/mVKwlih4GO1tekJbk0XEG7ujpnxZs8LsbFKoX2iFdsoygwhfPWezUMcntBIHczSyNbfAQ+pCte0/Z4wmphpz01qOILTHg63jbu7BWWFo/3YYM6B5V8+Nh8Wn1rSPKlXbQd9YNvoY6BpWcitvGaycko+3mD6a0wRCbyyhy3/VBe8ejf2qJpcs5L8TxYRiVfX0moLdpBiaNtuURQuG4D2g2h3znZ1UA8BazehoHNVSS14vuMrNXNSFZpDT/6VR1fJWYUH4tc0vpDyodcb5cAR1EluR6p0nQEaf4W7/j5gZz6/UQ4QtUrEFXjQe77cMhu4VMPBnuoOpcbRlE1l2QtzBJ8M9eFJsf/jYnQZfAyAmahqMwPlLnhD438xGEsMu8ihbCQ0q2FfWB8ElE2U+WIw1cvOf/QlUgmJZqqNvTV9UJXq+F/AeJ88En95Yl2IIoe3yAiG6KHnplbF4GK8V9nNMYRqx4ONQuCfCWQKUxUY9dW5TbsAjODdMZMbZstwonJY3VrZIzH3IcOmJ+dBcWWXXAussV7Y27cO7cECLfllRlXuJ8Wy+bTvWdFqP0WkdW1nXajArAoYipuC36HgFuN2Ezq27S4M5TC5zMWwig1KjkgYBpWYiGhtsNUR3FN3hl5f/
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(316002)(26005)(82310400005)(1076003)(40480700001)(8936002)(5660300002)(8676002)(86362001)(186003)(16526019)(478600001)(110136005)(70206006)(70586007)(336012)(426003)(2616005)(36860700001)(47076005)(83380400001)(41300700001)(107886003)(54906003)(356005)(36756003)(7636003)(2906002)(82740400003)(6666004)(4326008)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 22:44:47.1003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be1df04f-7038-4c69-c236-08db4a95aa67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0000E63E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216
Subject: [virtio-dev] [PATCH 1/2] admin: Remove dependency on the deprecated register

'VF Migration Capable' is already deprecated as per
PCI base specification 6.0.1 section 9.3.3.2.1.
It was long ago deprecated which was meant for MR-IOV.

Hence, remove virtio PCI specification to not depend
on such deprecated bits.

This patch is on top of [1].

[1] https://lore.kernel.org/virtio-comment/cover.1682354275.git.mst@redhat.com/T/#t

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 admin.tex | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/admin.tex b/admin.tex
index 2efd4d7..037e2e6 100644
--- a/admin.tex
+++ b/admin.tex
@@ -372,9 +372,8 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 \field{status} set to VIRTIO_ADMIN_STATUS_EINVAL and
 \field{status_qualifier} set to
 VIRTIO_ADMIN_STATUS_Q_INVALID_MEMBER;
-\field{NumVFs}, \field{VF Migration Capable}  and
-\field{VF Enable} refer to registers within the SR-IOV Extended
-Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
+\field{NumVFs} and \field{VF Enable} refer to registers within the
+SR-IOV Extended Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
 
 \drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
 
@@ -423,11 +422,9 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 the driver specify a value for \field{group_member_id}
 between $1$ and \field{NumVFs} inclusive,
 the driver MUST also make sure that as long as any such command
-is outstanding, \field{VF Migration Capable} is clear and
-\field{VF Enable} is set;
-\field{NumVFs}, \field{VF Migration Capable}  and
-\field{VF Enable} refer to registers within the SR-IOV Extended
-Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
+is outstanding, is clear and \field{VF Enable} is set;
+\field{NumVFs} and \field{VF Enable} refer to registers within the
+SR-IOV Extended Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
 
 \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
 
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

