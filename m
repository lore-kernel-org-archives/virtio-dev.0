Return-Path: <virtio-dev-return-11723-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F75C6FD1F
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6AAB73E30D
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 61AEA98657E
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 21:53:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 533F0986474; Wed, 22 Mar 2023 21:53:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A6D01986455;
	Wed, 22 Mar 2023 21:53:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIkO4dsE8KI39Tr7IOagn5MCbnI/FuuuFw3trMSrqxiw0E65VJ4Q12/SfSqQyzxq/jL/3mqpwPhvZNA60LHWy/deWlYfaA1HMcZdzHxwnqwX5ok7KF0c8t++rgY02hBSaMt6xDDusXHLWx5N0a4GXnZB2fcFL54K4RAWR6yqZj01CMlGTxJD3cg8YMOtg9tpeKCHKKol1zqE1d04khA44sYxq9ri2mObnxM7ccpiNK4x0ZGUoNr/FtSllibpzbbLkM1SYtyfxbT+AtfDagluVA8QY3Ibcm8zvLLlw2F2gb0FlAQ7MXXJt2AppQ0p8z9W9wi4K0bNAqwOZP5PXxrMDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JO0DHbe+iJsy95bVg7a/Jpr1wYJjMJf0ZzMr66zqsA0=;
 b=a8l3/LBnddGlt6RJdtcp/1xPel+ZlImDD7XL0l8wJdkRld0rYPwcEA3L3Juxdf5cLf/FW0jDjL+D9N3n6cCFD1xheAf9uul19qAXE2nOQiY0vaCxZ3oaGQuPyK5OnOTxkqQ1PCOMZ29CX/pZiIrAvlOxQ8veSc5HERG+KUz33D6xROIOElc08faRPKxVoab+0vtZ5JuxxybX4rk78HCjn3i+hCe5vXoxqD7n8yvIlcFLYR2eDaxM4Pv4x32+M/uh3nhEolz0AUWS6U7z7M+X8JUq8UkJduTHqYIGrzNL2/KLJQDuchRG+D+XQdti1ZXxI0SM3WeOHFvGUwghX4zChw==
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
Date: Wed, 22 Mar 2023 23:52:35 +0200
Message-ID: <20230322215243.249524-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: 78fd15c2-943b-4433-e90e-08db2b1fd087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FXzE2d2hqHCiisiYwQf6FhxV6JKXKJpE5x2/gffytdNoBPqKK6y56WWhlK997/o/Q2PYD0Yg2IWfjzaE9rRjQCrn9PnwTnQrItfUANIBeSOgapwL8PErryQSHa6YuIyCj/HBvUEzRhrxPhhVSFyetNr0lgHlG1ZTpDPCSmeNQEOCESTLBWJ/124NzTlfm8mLgECc3BeUyg09cm/mCSQc3ONZnVcVLEN1YYC+LYb9zcnd0vrl8vaoY7BDzgcOYmfY9vscYiwIued4YY1zyX0ZRNvnWsmGweX4iUWdzT449IxRWTtosrxd+TF/GnfSEfhXLByJoCFfB9kkCHXXmNJ7aJ3HC3Omk+2ZzNt3C5dR1xSG6L8m/CsK5ODfQU4X/IHD3Wh5gVPhzDbQN90ZlGB1WSzntr9WCx1UYuRZgUUh3E56jAvYNvFxqPX+bT6UWuo65zFf1g2eFqnWrVGX7wQSbzFZDz2emUxnSFigBthVhsnGq5hfOqD06ZY0s32RqSGL79D4AlyoFH5zQgZmQ2m5e7VIAc204XxKwgDQLAVccLSwCWt4J6dA+52RILoCQCea/Hz7N1ge06M9ZVQe5uUGqcvf9nPcZ3Cv43Cmgp1fW4VMKOXgV3XW7juglOEwm0+FTO1jioKmGvjkSPOzZ3w0GyEMbNFnq0FyeM//duARpz+LBdob2lIWO3djUsfM6UC+XZeWcfsqE+d0qISUZBM+lTQRCIbAhoIWeXT19ty88bMk9KW5mOLEwzh4oQoJC32sHnltcuLyAZ6tIMBroKL15KDCDp8qkSWGU/y0rFnNR20=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199018)(36840700001)(40470700004)(46966006)(40480700001)(6666004)(478600001)(83380400001)(40460700003)(316002)(8676002)(4326008)(70586007)(70206006)(110136005)(54906003)(41300700001)(36860700001)(186003)(2616005)(16526019)(26005)(1076003)(336012)(86362001)(82310400005)(82740400003)(5660300002)(36756003)(2906002)(426003)(107886003)(8936002)(7636003)(47076005)(966005)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 21:53:04.4043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fd15c2-943b-4433-e90e-08db2b1fd087
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041
Subject: [virtio-dev] [PATCH v4 0/8] Rename queue index to queue number

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
patch-1 introduce vq number as generic term
patch-2 renames index to number for pci transport
patch-3 renames mmio register from Num to Size
patch-4 renames index to number for mmio transport
patch-5 renames num field to size for ccw transport
patch-6 renames index field to queue_select for ccw transport
patch-7 for virtio-net removes duplicate example from requirements
patch-8 for virtio-net updates rss description to use vq number

This series only improves the documentation, it does not change any
transport or device functionality.

Please review.
This series fixes the issue [1].

[1] https://github.com/oasis-tcs/virtio-spec/issues/163

---
changelog:
v3->v4:
- moved note to comment for ccw
- renamed rq_handle to rss_rq_id
- moved rss_rq_id next to rss_config structure
- define rss_config structure using rss_rq_id
v2->v3:
- addressed comments from Michael
- added previous definitions for ccw fields
- moved rq_handle definition before using it
- added first patch to describe vq number
- updated pci for available buffer notification section
v1->v2:
- added patches for virtio net for rss area
- added patches for covering ccw transport
- added missing entries to refer in mmio transport

Parav Pandit (8):
  content: Add vq number text
  transport-pci: Refer to the vq by its number
  transport-mmio: Rename QueueNum register
  transport-mmio: Refer to the vq by its number
  transport-ccw: Rename queue depth/size to other transports
  transport-ccw: Refer to the vq by its number
  virtio-net: Avoid duplicate receive queue example
  virtio-net: Describe RSS using receive queue handle

 content.tex                      |  3 ++
 device-types/net/description.tex | 29 ++++++++++++-----
 transport-ccw.tex                | 27 ++++++++-------
 transport-mmio.tex               | 56 +++++++++++++++++++-------------
 transport-pci.tex                | 14 ++++----
 5 files changed, 81 insertions(+), 48 deletions(-)

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

