Return-Path: <virtio-dev-return-11269-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13297C64ED8
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:28:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DC5253252
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:27:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D18039867AE
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 22:27:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C71E798668B; Fri, 24 Feb 2023 22:27:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5C25D9867C3;
	Fri, 24 Feb 2023 22:27:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuM3qVnDDmx7AXAsQe/Pp/QWARkO3s7bkEjk/E+W6Xa4blNz5H/dgR4pvlOIp+BdkvmwL2IB/iHekHcShjw9NI/CDkDHEAYIuJnpI32g6Fkbp034oLNYBwUz1d2ARzFguouteYoGxCTWO8TYVVrI/uOfTLcV2y5C8HMZN8QoWTpIid3j7J4qhPmQ4i/XRZ077VJWg4z+bCO2da8sjMiLN59JUTOUdcnht4u6ZVku1kq/kwVwWA+PUo1Gv51fMNTMnTrlSUGX/mgiD/BKIMzl6a9uGaoxXM9RIzAPVhE8eVyOKAtfqFM9GMKDUKrylcUMu7IsAc5meqzAaJps/p2zKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IG7OZFzWBPJZMNLx9u/r7iut/l+4S77g9HBHM0mX30A=;
 b=RAl/onqqNWcDmPJf7yq3QNU4Tz6ufyHP9z+Tm6Eygtl47ZnTEiEZPJG/2r4b2lCBHfka4JSqm1UyEeZJc0gtd7MQA46CKhuWjAuLkFBKn9mE7dsgrGM58j9DDDzbd65z0n71+g6A5FTKzLS7YHECvYLV7R9M6+unhBt/CwwO+ly2R+gX/0jNOK4L3LtE3IpVtWZIdO02d3cT802bqCktFsglfHkw/glr4BwrLutXDYVkvOcAtLobkHn5bmvIbQEjZiy53R08oRnxVVkIPQwKt3Vd0+H4vfYzP80B0MiKrN2vNBpcs+/blJ7vQumQn4/ogRT/JTgwmhrPqB1wrn/cbg==
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
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Sat, 25 Feb 2023 00:27:15 +0200
Message-ID: <20230224222718.339883-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT087:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ab42c5-5789-4a8d-ecfe-08db16b65bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ytmFAiFFnRLy0fUm2/O/ySY+u12/TznxKzVDRwJ6V7yKSGksl25Bezrgwk2zjQrIUQTXouiVZQh+P4XT8TVvid8KEYl0SPR+vpXAGZUPx4nauGgKBU9iZGROojTAQe0CfbRLg55klDOluesYcbbVOQjgqHHupaOEBZEtaA+MNgFdAzCjVQgcO7M+8DpMMnUHMpIY+cz+ViWL4a6SrK0zKwbDr+usChErqJII9Q/JniuzKwzeu8iTuAn7bAZYPdU9joZIgM0UHtSG3fhGg5QTjnTcOCAitqtOL8vqXIUc6aYOMwXqKNfJf6gHfm59YJfQNXRZRPtt45ZU58e3EnSn6U9h5jEAfIymno3gSf6vM9UDlI5pbpxGRayhuM2CGxUNIptOeuDzyzs22BfWENva6tbm0TK3OZhTpnYQa83bDsGcXllHH1my+bYsaroHUZiwWBRHX+/1eS2qJe/TnoJ8mzHFAJm13qiWN/hEIWKlAIuOUwqX7czZTKk49MeQGv41SfITla3mIulSHwh8iQIeahzCS6fBt1SzFH5L98lgKJpNxHkpT5XeqKX8VK27XIAjnBS38zNau8rOEg0KPBOx/BLhV+xJbGc0+kh+JT0LAjfuyrCluvNPWiVWnfIqjnEmUX6TCj5xp7ycRs8Hm/W+HGZapOVwzHK1Na4vb5XmfdNu0eqij374wmH9e8PMNjpOyUWQ4MwdKIwAuxx0DTCQdvbDoxwmlq98+SKEuMyCegIM5Lw4Zqsd2l5g/gfgcv9KFHo7EOYn8EReqfbXXwHTihh204hb9Q4SLCzJ/dO0iTodCvOUh3EFvoqSjNXR2bJO
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199018)(36840700001)(46966006)(40470700004)(2906002)(36860700001)(7636003)(82740400003)(86362001)(478600001)(966005)(356005)(336012)(26005)(426003)(47076005)(82310400005)(16526019)(40480700001)(36756003)(186003)(70206006)(54906003)(83380400001)(40460700003)(70586007)(41300700001)(2616005)(110136005)(1076003)(4326008)(6666004)(107886003)(316002)(8676002)(8936002)(5660300002)(34020700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 22:27:48.1041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ab42c5-5789-4a8d-ecfe-08db16b65bcc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941
Subject: [virtio-dev] [PATCH v1 0/3] Rename queue index to queue number
Message-ID: <20230224222715.Jdfdnbvg83y-l0CF4VJu4h2wNLSSKWvJViLvavp6oj0@z>

1. Currently, virtqueue is identified between driver and device
interchangeably using either number of index terminology.

2. Between PCI and MMIO transport the queue size (depth) is
defined as queue_size and QueueNum respectively.

To avoid confusion and to have consistency, unify them to use as Number.

Solution:
Use virtqueue number description, and rename MMIO register as QueueSize.

Patch summary:
patch-1 renames index to number for pci transport
patch-2 renames mmio register from Num to Size
patch-3 renames index to number for mmio transport

Please review.
This series fixes the issue [1].

This series is on top of [2].

[1] https://github.com/oasis-tcs/virtio-spec/issues/163
[2] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00578.html

changelog:
v0->v1:
- rebase on [2]
- added reviewed-by of Jiri

Parav Pandit (3):
  transport-pci: Refer to the vq by its number
  transport-mmio: Rename QueueNum register
  transport-mmio: Refer to the vq by its number

 transport-mmio.tex | 16 ++++++++--------
 transport-pci.tex  |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

