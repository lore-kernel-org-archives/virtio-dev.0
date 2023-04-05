Return-Path: <virtio-dev-return-11995-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EABC76188
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:08:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C618B7A0DD
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:07:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BF0C8986599
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:07:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B30D198638C; Wed,  5 Apr 2023 01:07:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 713B59867E6;
	Wed,  5 Apr 2023 01:07:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1zi3GduH5YrzpKSwubcpL1EQmHytkvTicRIgafzkKzY5AAvXVt4Cncfi2ARvxhMYTV9f+67HMadcL1TEno12o/0p+PQbyFk00SpALTOc67519/zJdAHU1BFLUkxpx6tE2Ujn7A61TzX0Gp7R74gT/X9ODjrmRaoec5FWRmuIomPp5mxujzV//VzVw20x0gFrATEfPHudmRd6iQMUt6f67E1G/8+LAOGoUosCjBgoPdzUx+91us5x05h+P4fdaoVL3ir5RNmVnwOxz+wvM4ji4f9fCRzVS9mkE8i3CIwSLfqKlOjqySRBIijYOALzQ5gxfjO4EhMg/ndtQJLgE7ZdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/U+SXHlDZQ7/XavZBL7izBufBp3XOBvHqNPBU4pKmNI=;
 b=jnwIVLCdnxgNLUFcLavKR0vJLmCWM3+iNv1Y+TGe8d0T0f98DNyDypEtLeOgiM8ogqWpsRte95E9G1SaNOpnzyYSeG0km3bZgil68IcmyqzppEvhpF7gBWQn+CjtMOnHuUdflqBV2Eayuxp6fkFbg6BYJIKytNyIiAhHhBwu6LBVUGG+sVAW/TXGpF2Lmh1ow0SdI6jtLRVApp+VZHALrWMsVXat9Gnhe6hLlOyQe5qGTmZ9+8mYh4h7JVben+oZkcNfKTT3WOn6DsdqBXN7+KzO8quTp7FrgC0hpkFBNq6HHLSqyP5wxDfCfPv3jVGyztsWb3R66dTHIZ8R4ZDewg==
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
Date: Wed, 5 Apr 2023 04:06:49 +0300
Message-ID: <20230405010657.612529-3-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT017:EE_|PH0PR12MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c23f97-0b4b-4a3c-8a56-08db35721e80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7uAbJ1Zl/cGXoCVTUnrxnCrjjVDkHp2WYFAeyLJhlGpE1TolCSrv+9Oq4Rr3FqlAZbkyMeA0wBfTv4iQQ3QtMsqqIAed7ndUS749jP/lyUHxamoBPSdjeLVrk+fN7obS5E3lb1Mb5SlnNeuFoyiJKJSHD6lKTDyWrv8SlyXGD+ks1QY3oTm1tV2UHTSk60GVazbSBiiRCVFrxM00vzjtztA8BX+yd5tB4f4qzfwFXpGF6xibsBUfGRyA9/Tp7+3qHG8FxmMob27GZOvJ+dOhgtw5Gz13hegSZ+pi/CDkhK9r3/UVqAgaX61WQEITbKZjq6wILwFof3D+NgWbMz96wASdH4XY6POMNeENnB0SlvanvBOtBbBRjrcGAzKWail9mSWsntLxmS+weHZr8ClCVqNW1ANA3/MDAU3GmWKhaI9726Ek1xEqJMJROebAWrZbcBEeXJiQF0V3F5EfcCPMCkn6xDOAd/RWPLlB034TbUb45hVWYoxkzu/OAN2mNeNyilt8jHpuVMmEwDJV7sSXIkHG6z0BI3LRx4y1C7d75dzzaepKbpdGYrOPghDlilLyUGXHtFJQcHSv9jR74PlWznC0rr0u3NRqljZCl0X/uwMilc9dxk0HrWLBRJytcS0XtFHxUC2Ouov80HLvJFDPK/EwlKD+S6ucBOwNBLiYgR4ImlZtKFLyxydEJp5RDZCpLGl+GI2LhYcdVFnEL3TBLCz00XqGulwEYR/3xg/U2diZ2mZO88vRf8Ot2KW1u0xrGM4e4Nh2lyF82qOliAqkByLndYYNPVbP/BHdTv/5Mf8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(36860700001)(54906003)(110136005)(83380400001)(47076005)(86362001)(26005)(1076003)(107886003)(6666004)(966005)(70206006)(70586007)(316002)(2616005)(426003)(16526019)(336012)(4326008)(186003)(356005)(82740400003)(41300700001)(2906002)(40460700003)(8676002)(8936002)(7636003)(40480700001)(5660300002)(36756003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 01:07:25.5935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c23f97-0b4b-4a3c-8a56-08db35721e80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8049
Subject: [virtio-dev] [PATCH v12 02/10] content.tex Replace virtqueue number with index

Replace virtqueue number with index to align to rest of the
specification.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v11->v12:
- new patch
---
 content.tex | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/content.tex b/content.tex
index e64115c..cd93db2 100644
--- a/content.tex
+++ b/content.tex
@@ -406,7 +406,7 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 this notification involves sending the
-virtqueue number to the device (method depending on the transport).
+virtqueue index to the device (method depending on the transport).
 
 However, some devices benefit from the ability to find out the
 amount of available data in the queue without accessing the virtqueue in memory:
@@ -790,13 +790,13 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
   buffer notifications.
   As mentioned in section \ref{sec:Basic Facilities of a Virtio Device / Driver notifications}, when the
   driver is required to send an available buffer notification to the device, it
-  sends the virtqueue number to be notified. The method of delivering
+  sends the virtqueue index to be notified. The method of delivering
   notifications is transport specific.
   With the PCI transport, the device can optionally provide a per-virtqueue value
-  for the driver to use in driver notifications, instead of the virtqueue number.
+  for the driver to use in driver notifications, instead of the virtqueue index.
   Some devices may benefit from this flexibility by providing, for example,
   an internal virtqueue identifier, or an internal offset related to the
-  virtqueue number.
+  virtqueue index.
 
   This feature indicates the availability of such value. The definition of the
   data to be provided in driver notification and the delivery method is
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

