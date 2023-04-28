Return-Path: <virtio-dev-return-12463-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563ADC77B61
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:20:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9CF9C3E315
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:20:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E87B39866BC
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:20:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 73F05986747; Fri, 28 Apr 2023 04:20:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 37EC5986682;
	Fri, 28 Apr 2023 04:20:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFEPzoYY2WNfYkjnWl8aW+V2/ZECTMnAtWjeCPe/EmQH/rNRMiDsg5kJeKSbFOuLKCEOr0wzNZR/8ZFc8Bh7DjcrZXTiJ643ck1zxGyVsXO0RIxlFXGlqCW5YM3q922NztqB3LzMMMmrxTVwLp3qa14tCVA8Ub6Pf35/xczigMkW2rSrzgArVyCqGHs/UrSm9mJ6eC0Fwq4I1MrN+i0FqU9VjA2qSNMScXMFM1f1URGEcsSarI/P6h4rvilwcc0N0vfPOakGXqSdX1hkurM2zuH0OUmX4VeHul3cVsJMkKcrGn32OKo4p1d2zoc6PJ6UB68SU3lZRQugjGrSwYhFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGWKc8AnLLhWKfpBIHC09GfPObFGhYr9rn7a2JTMNbg=;
 b=JHKctrpaPj8k2ZZUtzZ+UcgeM+AmLMbFrrTD+gznoXuZ/2SLBLGAmwT+9GmpQHr7fcTBeJIPEiDerZykQ6Rftpm2w+VroUlHljE6uwzDhiZWsg6nKAdkkA1RabdfR6vnGzHmM0xuWSvBHpf1jBcpP4oaZsdIi4H+lmXGc53g1SbmBP6KQWGsLakdM3WX26i9+iYsilGFawdZmLDI9nHj7O9J2lsJPN7NrPrXYlPbhqZq0e569+67KhUt0cts3NtkP/MuRwXY9ZJF44za+ACD49lfNPvoBD+oi7Zz6PZy12pDX9STcG90uEhmPmZl4NMGw32K3I2Y5+PLFbLoBe5unw==
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
Date: Fri, 28 Apr 2023 07:19:40 +0300
Message-ID: <20230428041949.411221-3-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|BN9PR12MB5098:EE_
X-MS-Office365-Filtering-Correlation-Id: 28afec1d-f94a-4db5-8382-08db479fdf99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yQ40QJxT5w/cgIZXewLGFEQ50sX8+S13BA6vJhTvpJrEpVkt6h5MG3Qoo4RDRmIyEFA9vddzJS8omUSiWbHGuAOAeLU19EmtIiA+7vwJqKy49uw+IRuMCjKY2WuddI+pb8fU3CVOFutTmPsah83lhJMcsrfAAAVoeoQenKlAPvWs9CQz2cVFTNYYuBVxr4PvDB+VawNsRAHQ+Ur1f165F2AxZsMRJxl8yGFmwkJ89YNjdvTziIcxVJEy2XJfFD6zVDiUfIV4jaEpF1Du+liVtOhjDm+IIbiRXmZea4qqCw9krquiKbropjCxtHyq0SptWA8sTpzwqKaYj+en3sX/RJc6r35y6G4nITUFulUMSpVpe3dLsnUvhNJ1I8ryXYBeYbOruqeNO9EuwFB8oMNLS68Oz6UtLjg4y3ag+HgVrLkvI3SSNRdPZ+micnOrwcTSAQbuVk8RIV/6hA9ii60ptbiKQxT+Og/WoHMDAgWUGMpVms1QijNBXaf9JVymgESDMITeKNHrtQfI2yzaO+2cRu0ZWqy0Z6NlC7W4NwRn68/C33nF6Uf1Tj+T4nN1+67ajSR6LCkcMNOhkroSGPJakRanXAqfH8zwl1HeE3RvIUcq63+X7mb7Z5H9RQM0B/1eJZl3Ml+3bX8HUGoBc4nIx1Xz3piVGU1VjohnGVHRat0cRkITKP/VCTgckbsnbjxgAIOqXVyVnwTeT8IcyJgA2PnRtmiOgVV7yFRAsJUmdXH4Glak2sIM6FnSqY3b07QaUxaa4wF/q8fZm2aN1/cgxA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(2616005)(7636003)(5660300002)(26005)(2906002)(36860700001)(47076005)(356005)(41300700001)(1076003)(82740400003)(336012)(426003)(8676002)(83380400001)(8936002)(4326008)(70206006)(40460700003)(316002)(70586007)(36756003)(478600001)(40480700001)(86362001)(16526019)(186003)(54906003)(110136005)(107886003)(966005)(6666004)(34020700004)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 04:20:17.7934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28afec1d-f94a-4db5-8382-08db479fdf99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5098
Subject: [virtio-dev] [PATCH v15 02/11] content.tex Replace virtqueue number with index

Replace virtqueue number with index to align to rest of the
specification.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v11->v12:
- new patch
---
 content.tex | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/content.tex b/content.tex
index 43be58b..e79d722 100644
--- a/content.tex
+++ b/content.tex
@@ -405,7 +405,7 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 this notification involves sending the
-virtqueue number to the device (method depending on the transport).
+virtqueue index to the device (method depending on the transport).
 
 However, some devices benefit from the ability to find out the
 amount of available data in the queue without accessing the virtqueue in memory:
@@ -789,13 +789,13 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
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

