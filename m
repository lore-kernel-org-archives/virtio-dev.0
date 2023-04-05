Return-Path: <virtio-dev-return-11989-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461A1C761A6
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:07:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9500C29FD1
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:07:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8C8319865E0
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:07:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 808759865A6; Wed,  5 Apr 2023 01:07:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6547F98658B;
	Wed,  5 Apr 2023 01:07:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ho+8X+aUrw4aQPiRSvfR1d8bE/w/67f1Tj9mnMvDH6ePu9tBgwEuxXgWej4d+LLBVSfHuXCDb44FDasOapzUQt9F9q16CPYnToBgXAgbPomAlw+LPIkOJxaxhMd+NiCADe0cqC4TcZFL4lFc2QhIdESvIpQ7rs+xxNC3C8NsDsz/0+h/KiYFj5rKoJAZSbgEmyZ8jLG4OpY2XBitDGzbDths0WZU//HAutKAUzzV38dw0ea8yRLBt2VCFEYVqppFmpMiZmfozdu18rmv9VgkN0Ag2p2bu2MolAd+p4p9Pm8KYpwTBf7I/9DkimHvWeK9mo6v7zsqsqOU4zGv3jcVxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRme//Z3ZBV4TIXk8oyhaTbRe4YJZlWhKX/31oHcvUc=;
 b=Wstxg2Qs22QsZJ+aDK34VN6tthsQ2D1P71pA7gFA9kL8QP1xdeCFODD3gjrLF7kkVput+hbTAg1RW+o0Ydd9l3ZnhgFiZP2JN9PgntizQxTNxFOpj2z35/KQ7IKULZ4qhsWv8lcqTQzqgDHtf8OdvODGJ0ImzOI43gEkNLzH/RekIz/JaIy9mHwpdlg8IxA7cbytbGO4cNzKqvuw46kEAWMIBZ52hJVdSeVRfWzzZULGEWTzpsvxJ6WhuCmH7cMC1bdDqYD1WLcOtFGT0HMudhqKmjTMjOqKyiEPXP1Ey4LACatKUkl/w+tFjZXvILEKDmLXL2KoDkC11fndPJHTlQ==
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
Date: Wed, 5 Apr 2023 04:06:47 +0300
Message-ID: <20230405010657.612529-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT093:EE_|MN0PR12MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d03b3e-9aa7-4349-628c-08db35721ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WRw3P2ncWHM+zF9Mvaw3ByNonVxa7NFOMTatQXB0EmYWIICxm1H3qLBqaRh2lhh239AijybSEAkm4FSAw04qkMXpmv5CPgnFQl1LZtiqfZVERMpE9xmkWhVdAY5i50gKNm0XiSV5IYEmeOkFJbamkQws5cQk+UrghT3rc/d1aSKWx4RDnRzDJcPJgp2n+x/1pxw+DOs5eNPP2NR62O7X2wsnAcPOCxYi49JEE6+X/zDqeqRmPM1ijeWwDpaftZY3DYcKNaW4uTM6xT1wusA4yl1FItDSHQFXNmQys1ckpBs2gnmcZDdz8296NgukSIesV0Gy18TVgyuhR0x2P75oH8jsx4IMJ93ay40WftWoQJh5THFLtpyxu6GaEdRTwEahRqpKkLUCeN5RcYLf33U6v5BnEdteHKFyplzZCBcCYY+anz0Gfxb6VpFvWZ7LcisHqnEtKQcvvuwuLhltSvgst4xnuZ7j1FF5IeTnkOB0fZKhpvCvYQF3CPQjJLhHaU6id1EZ96nGl3knKC7DSjGdH711D8BW2y3txA7XyxkFPregnQ6aWLzm/yFPszldZv99QTHWfZNVqWXZAZYhVyD+KHkd6Thny7Tol08FqAYq8WoftBz32QRpIeGeXyR6GqDb61O3CEuXU+BKoDzh0r3v3C4CWiMD5J/jKIWN0l/1KxC2T+Gq0lc2eTskimINwSI3hYzqyTVks/BYhxsOwQVx79T9PAF0GfVLT8v/EUFL7crWb49fQIL9bmuFaGBVS7unzovBJjS4u+a5h22+vBkyJzlNpHCDcgGiFHnw18PMMgM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(82740400003)(70206006)(40460700003)(36860700001)(4326008)(70586007)(7636003)(8676002)(478600001)(41300700001)(54906003)(8936002)(316002)(110136005)(5660300002)(356005)(16526019)(6666004)(186003)(2616005)(966005)(426003)(336012)(83380400001)(107886003)(26005)(47076005)(1076003)(86362001)(82310400005)(2906002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 01:07:22.4795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d03b3e-9aa7-4349-628c-08db35721ca5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317
Subject: [virtio-dev] [PATCH v12 00/10] Rename queue number to queue index

1. Currently, virtqueue is identified between driver and device
interchangeably using either number or index terminology.

2. Between PCI and MMIO transport the queue size (depth) is
defined as queue_size and QueueNum respectively.

To avoid confusion and to have consistency, unify them to use
index.

3. Filed name vqn in the driver notification structure is
ambiguous as it is supposed to hold either vq index or device
supplied vq identifier.

4. Device is really supplying queue identifier in the 
queue_notify_data register, and this often get confused with
very similar looking feature bit NOTIFICATION_DATA.

Solution:
a. Use virtqueue index description, and rename MMIO register as QueueSize.
b. Replace virtqueue number with virtqueue index
c. RSS area of virtio net has inherited some logic, describe it
using abstract rss_rq_id.
d. rename queue_notifify_data to queue_notify_id
e. rename vqn to vq_notify_id to reflect it can hold either vq
index of device supplied some id.

Patch summary:
patch-1 introduce vq number as generic term
patch-2 renames index to number for pci transport
patch-3 rename queue_notify_data to queue_notify_id
patch-4 remove first vq index reference
patch-5 renames mmio register from Num to Size
patch-6 renames index to number for mmio transport
patch-7 renames num field to size for ccw transport
patch-8 renames vq by its index for ccw transport
patch-9 for virtio-net removes duplicate example from requirements
patch-10 for virtio-net updates rss description to use vq index

This series only improves the documentation, it does not change any
transport or device functionality.

Please review.
This series fixes the issue [1].

[1] https://github.com/oasis-tcs/virtio-spec/issues/163

---
changelog:
v11->v12:
- replace number to index
- avoid confusion around vqn field and rename to vq_notify_id
- rename queue_notify_data to avoid confusing with NOTIFY_DATA
v10->v11:
- added Reviewed-by for all the reviewed patches
- updated commit log of patch-8 to drop rq_handle reference
- skipped comment to further use rss_rq_id, as rss_rq_id usage
  and structure are self describing
v9->v10:
- added virtqueue number part in content in braces
- replaced queue_select to vqn in ccw
- avoided aggrasive alignment of 65 chars
- updated commit log to drop reference to already merged patches
- added review-by tag for already reviewed patches
v8->v9:
- addressed comments from David
- few corrections with article
- renaming 'virtqueue number' to 'vq number'
- improving text and wording for rss_rq_id, avail notification
- commit log of specific change in individual patches
v7->v8:
- remove note about first virtqueue number
- skipped Max's comment to put word 'structure' in same line as its
  crosses 65 chars limit per line
- reworded queue_notification data set line, as '=' and vq number
  wording was odd
v6->v7:
- remove text around first vq as it is already covered in the basic
  virtqueues facility section
v5->v6:
- moved the vq number description from middle of vq operation
  to beginning of vq introduction
v4->v5:
- fixed accidental removal of "unclassifed packets".
- simplfied text around indirection_table mask
- removed rss_rq_id references as indirection table and
  unclassified_queue data type is self explanatory
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


Parav Pandit (10):
  content: Add vq index text
  content.tex Replace virtqueue number with index
  content: Rename confusing queue_notify_data and vqn names
  transport-pci: Avoid first vq index reference
  transport-mmio: Rename QueueNum register
  transport-mmio: Avoid referring to zero based index
  transport-ccw: Rename queue depth/size to other transports
  transport-ccw: Refer to the vq by its index
  virtio-net: Avoid duplicate receive queue example
  virtio-net: Describe RSS using rss rq id

 content.tex                      | 27 ++++++++++++----
 device-types/net/description.tex | 29 ++++++++++++-----
 notifications-be.c               |  2 +-
 notifications-le.c               |  2 +-
 transport-ccw.tex                | 15 +++++----
 transport-mmio.tex               | 55 +++++++++++++++++++-------------
 transport-pci.tex                | 26 ++++++++-------
 7 files changed, 99 insertions(+), 57 deletions(-)

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

