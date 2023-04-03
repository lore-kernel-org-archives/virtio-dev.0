Return-Path: <virtio-dev-return-11942-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23400C76188
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:51:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9C6721CA243
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:51:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 95D719865B3
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:51:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 89C3C98644F; Mon,  3 Apr 2023 22:51:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F3EE598658A;
	Mon,  3 Apr 2023 22:51:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4Iascchbed8j1ES0ycbK7qLryG+4luGKQRhQs0AZk+JfVZMnm/y29u/6n66CH6Tzvv4kNKwN2jA5M8WpBpu9aWBRD3Xub+juaQ5aOg8+9aR2+c3stL+PwCuXheBrqpCE9iX7/DTDb3CURZT3AGSjumw8wSQUNeaedO5jWwb6frRXzP9ET8P5PGhSiipSbiyUSt+jDGWtv598QBd2wkj064s7I0+JZoe9zAjOL5bjfTcEUcyZmzf3ee9x+8IS4kXm1g2YyfRNm7fTF3GBFkJoGY/K9vTE6Q2PJRorgewwgJinZFfu8IQbV/Vim9F4ceyRwV+hA3C6ShhiP3L0npjfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eg3ci/HIi8FOn8mBjaiLPD38eXJQgUN/3j1xIKxPEDY=;
 b=CHHwhlsG2qfYINu1/F5mFQS9hdKyl2kFRyU4QT3+IB1EKrRyKXVgmyWRF6c3+ogjjAodUt/b1LpI2MUuUgIn3SqpgaHniOjcs307vKxbRTHWB6AGbPPryXHobQyF6gRfE0p7nFveKyLSv1Z7j4mefKR7CRXZZ5pSsToI36tPdn2Cg7Y/y+yWd1px82BkcaOViErsse8iKPT795kt+e4GBq1xRPQy2BQgE+XGYQTnDBxqIZhJ6q9B2OSik2J6idqp4YF7oe1ISYNb9XGHe1nmYYFba1rgQ+0S9E/r8W007xmZZfnq1DIXXQ2hn0PuBxwq2HwBjWK+XGH1gpxhl+23Xw==
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
CC: <sgarzare@redhat.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Tue, 4 Apr 2023 01:50:44 +0300
Message-ID: <20230403225052.585498-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT042:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: acad0b77-09f8-49e1-ddd8-08db3495f2e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5bGidijSp2KbWj6K7R3SrnbIVJh0erMKSO9YfcPKShLaGYsRWyKTJHzRr2Tmhbtj3wc6TrSiii6w5K7e0rpDID52MSGq1dzoNSJuNUMIiTSN6zT/t1lHu7H/jvcfkWGkxRcvBhCe53YSqQkEhs6/+W86MEAuOjP7eIoq7YksqSgBJI7qXVmeJ3s7Zk0pHirC62tBc3g/b0kVcCRHhplZEKm2Y0kOLwnQddQjTtfoeS7fXJHKIOXsWep3W+jE7gTmVVToO0xrEItK003ca665u7VhLse85Cpj/yIs0SUVxxJViTRf4FsNdKFfiwY8IjSnduqWfQ/u75RERq8BIN6njP4n60nKfJ8E6WFcGtItevpMeq6Jz8VpX/SlIKyMg2tTWLKWnNuMxUC3ndu0XAlfBI1UR6HvGzy+tdW06R90p8Pw6TA25i1MxxAck6hm84N6jGIxdNYrMdZZk0ElwRnep28vOtPblHsE8o8GmW8Y/aoV6jty2J6+L4JG43cNHZ7OKisydSUI/V4D6POVEIwEPENTzseVwt2B9i4msVGPriQpy/NrlMzv/XkpTUU7ORw0/KhHl7axRu+Ck6PLvVbS4DrJxNL7DAdE3S1F9OwHeIHEgJDGmErt3iiAZtXgyXKNFLQtBrQ83LKYj1rtKv8I8A2rAshFid2ikyGxNBU4P1d2KqjyrK+VcHhmKkw1ZMfkD2JCLhkFPGM2VAvQFJ+nkA/Z6Q3wJUPlz7GApnG7IMAbu8bPAnNiQRiYolj7xCtQ0kyxKQtaxh0nixjCoCCWaMX6TlMZlZlmROM0JWKs11Q=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(82740400003)(8676002)(478600001)(4326008)(70206006)(36860700001)(70586007)(54906003)(316002)(110136005)(8936002)(5660300002)(356005)(41300700001)(7636003)(426003)(83380400001)(16526019)(186003)(47076005)(336012)(107886003)(6666004)(966005)(1076003)(26005)(86362001)(82310400005)(36756003)(2906002)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 22:51:23.0882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acad0b77-09f8-49e1-ddd8-08db3495f2e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590
Subject: [virtio-dev] [PATCH v11 0/8] Rename queue index to queue number

1. Currently, virtqueue is identified between driver and device
interchangeably using either number or index terminology.

2. Between PCI and MMIO transport the queue size (depth) is
defined as queue_size and QueueNum respectively.

To avoid confusion and to have consistency, unify them to use Number.

Solution:
a. Use virtqueue number description, and rename MMIO register as QueueSize.
b. Replace virtqueue index with virtqueue number
c. RSS area of virtio net has inherited some logic, describe it
using abstract rss_rq_id.

Patch summary:
patch-1 introduce vq number as generic term
patch-2 renames index to number for pci transport
patch-3 renames mmio register from Num to Size
patch-4 renames index to number for mmio transport
patch-5 renames num field to size for ccw transport
patch-6 renames index field to vqn for ccw transport
patch-7 for virtio-net removes duplicate example from requirements
patch-8 for virtio-net updates rss description to use vq number

This series only improves the documentation, it does not change any
transport or device functionality.

Please review.
This series fixes the issue [1].

[1] https://github.com/oasis-tcs/virtio-spec/issues/163

---
changelog:
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

Parav Pandit (8):
  content: Add vq number text
  transport-pci: Refer to the vq by its number
  transport-mmio: Rename QueueNum register
  transport-mmio: Refer to the vq by its number
  transport-ccw: Rename queue depth/size to other transports
  transport-ccw: Refer to the vq by its number
  virtio-net: Avoid duplicate receive queue example
  virtio-net: Describe RSS using rss rq id

 content.tex                      |  4 ++
 device-types/net/description.tex | 29 ++++++++++----
 transport-ccw.tex                | 26 +++++++------
 transport-mmio.tex               | 65 ++++++++++++++++++--------------
 transport-pci.tex                | 13 ++++---
 5 files changed, 84 insertions(+), 53 deletions(-)

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

