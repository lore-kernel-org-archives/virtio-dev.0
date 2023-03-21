Return-Path: <virtio-dev-return-11660-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E61C76195
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AC84C41F07
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 95E1C98645C
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 04:11:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 85BBD98643F; Tue, 21 Mar 2023 04:11:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 68C5E9865E9;
	Tue, 21 Mar 2023 04:11:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR6WnwMbwupYulcFJTq0ivZ0imAOMwJKVfffAsI1g3E+ZxsE6qrLbuCfQdmQ4GkvBFnZM4+MCDTDNEL+PeiVuDQEv9ptDFL80Rz+J/qkjwhjBHRdASnvIBqOi/gUEURzmZq3/d8P/fBc15Ih9E+8R4pGtzhue4/y1Rzq2rqFauycWTbLgePOlHGa5iPBjGt5lHAH0rgdy0WUu3OeGod1BIHnxqyoGJuku160Xo2AbkElRaB0XcVPhvEiF/Cx6R5RedPZB53imSBm2DscwIJCw3TwQ75cyxHtsoHHRMokfzoKJpAAGni646LC02iu2w+r5DdfqXK5cLBrJrnhj+794A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgKdrQ4wtRr/YZvJb+9iHvPA2ga25E8CeJ/lX9rNIUE=;
 b=aSumVo0OBzq/aT0f+Deo0dSFMaMNyxhBKpxSV/vRf39Qjr9BWESNmDa8UjEwefwxjgmCSpAwgcEbS4l2jaECbKC+ShGOYY8piquRNozBH1nUHhvPCPYP58zQ4JPSUVQpCYOox+hUoAZWSr55eRqP08MN7Os2DIxhrB1O8GlAOsR4T/m2RJnrNYqsPlMddcMkTmpGmUl5M6KlqAIcvBw9+pmn6Vmpi6nCPETKvS89+gHAPuIUUSloR4P9LMZsbpPjO+bv72PnS1r0+0SQnyOChrBWVKIWzzph/ew8fgTD1e4pBxha/u/5Fk9pGlK/qPcbS4hlXxcy6bzvL8dv1RiMtg==
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
Date: Tue, 21 Mar 2023 06:10:29 +0200
Message-ID: <20230321041036.201439-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|DM4PR12MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f29e1c-3a55-46fb-e69d-08db29c2498a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mhU9VxG6s6OS5H2VSUAqvcO+75T0kBRICObkULZVu14ukpPWm6VnyU9B+urffc7M721eb7Pdo/zwxqWje/5ObT8yK1b1vjyIbtiJ05RkTkLSUJjvpaALAWHczmENvogkKIBg6UTrsjtK+BHlUghrwAddq2KgerdmGkSdU5VuYbuBE6bxiCMo1w6k/opwFMrg9Nzu2FSUnm78BCfWcnT4ykiH0xZqHSQjxXTFv0h14G2L6Gy4PHMJBZq5K2WyJTvCcwk/j/z8P2x+6TaJWU9CDvbIWdoWgu8elBxwU3g/fHzaCWOkgrrRGnAf40ngrgTMSoHRmwsXpRbuqisqAL2ERM22pFt91cH1LVKLthcD+v2nKfkFdZ8iHPCw6wmesKsTL4+sG6GbOXTnU8A2awsUVurxeSU+x9XENglhWl0owv3YVAkrRJp1xyIWucU0RsahR/H0vnz2pi6HT3i+CzTDXAb2NkNPhujrfRW/PFPLw3X7DRBMDCKaQwNVDZ4/8VRPEyXkMoQZyB7ZUrPxAJzn6p2YzemqmiAIj18uTM9l8EECR2CsQVzh05/g/AkUOXDdGtxCCFd9Zn5Vzuc2iz0g9ZMlIiCpKwTlmHE0XBX+mLnNMTvYdmmFxDDY/fZQOeQ/WIDvI92AUeXxH7VzfyA6c1gBewuSWHUlWHbgloXpiNhOucsHJGIK3xnThHoZGBlVH7VTg9+aM758Ls+HiEMSDvlmupEa/Vk2CqDQ90j1/RRxfc2pVVfPTN37bchCmtmMCGB0TJAiABwfDPRG+DNDThDuZiPBlYF6LcNBsZE2Z4M=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199018)(36840700001)(46966006)(40470700004)(40460700003)(41300700001)(36860700001)(4326008)(5660300002)(36756003)(8936002)(356005)(86362001)(2906002)(82740400003)(7636003)(966005)(6666004)(107886003)(70586007)(478600001)(82310400005)(2616005)(40480700001)(8676002)(70206006)(316002)(110136005)(1076003)(16526019)(47076005)(83380400001)(426003)(54906003)(26005)(336012)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 04:11:03.5416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f29e1c-3a55-46fb-e69d-08db29c2498a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5165
Subject: [virtio-dev] [PATCH v2 0/7] Rename queue index to queue number

1. Currently, virtqueue is identified between driver and device
interchangeably using either number of index terminology.

2. Between PCI and MMIO transport the queue size (depth) is
defined as queue_size and QueueNum respectively.

To avoid confusion and to have consistency, unify them to use as Number.

Solution:
a. Use virtqueue number description, and rename MMIO register as QueueSize.
b. Replace virtqueue index to virtqueue number
c. RSS area of virtio net has inherited some logic, describe it
using abstract rq_handle.

Patch summary:
patch-1 renames index to number for pci transport
patch-2 renames mmio register from Num to Size
patch-3 renames index to number for mmio transport
patch-4 renames num field to size for ccw transport
patch-5 renames index field to queue_select for ccw transport
patch-6 for virtio-net removes duplicate example from requirements
patch-7 for virtio-net updates rss description to use vq number

This series only improves the documentation, it does not change any
transport or device functionality.

Please review.
This series fixes the issue [1].

[1] https://github.com/oasis-tcs/virtio-spec/issues/163

---
changelog:
v1->v2:
- added patches for virtio net for rss area
- added patches for covering ccw transport
- added missing entries to refer in mmio transport

Parav Pandit (7):
  transport-pci: Refer to the vq by its number
  transport-mmio: Rename QueueNum register
  transport-mmio: Refer to the vq by its number
  transport-ccw: Rename queue depth/size to other transports
  transport-ccw: Refer to the vq by its number
  virtio-net: Avoid duplicate receive queue example
  virtio-net: Describe RSS using receive queue handle

 device-types/net/description.tex | 26 +++++++++++----
 transport-ccw.tex                | 39 +++++++++++++++-------
 transport-mmio.tex               | 56 +++++++++++++++++++-------------
 transport-pci.tex                |  6 ++--
 4 files changed, 84 insertions(+), 43 deletions(-)

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

