Return-Path: <virtio-dev-return-12534-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5072C77B7F
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:30:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1357B2B13F
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:30:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CDC7E98675D
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 02:30:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BDF4498670A; Thu,  4 May 2023 02:30:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9968398663F;
	Thu,  4 May 2023 02:30:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbkiKpccwvZ7nv8d2r43RbKNj8mD8dghP3BlK7zRL8KhCfTMdstwpC1KbR4eEvtxbBGreLU4odymJZEcNCF8YTyXW9uL+VnA45lfeUO5U2SM8BwW9N8nDwUrATYSTiiXYUQ/0MnUOb8W+yXo8Tnye6TRkjfqNJ7HW/KkLwZRr4QQbKUWby2luXXD1ofovKSHz/O3Pls3Vzulr9XgqfO6guza+bgx2nbczXE8neBcuxZMQ16AOIyWYZjwW/0SuyLUxJ8Ez8O9BWSPxbb0BULzmzsMpCnYct0I+BwIeCosUudMBFSRUGKy8iYIw3ujmNNh9KMvkOrct1ToRqSgyvET8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQGCatKQYBi2fpYzB7eO7vc5M2cQQle54Dmv3jfws80=;
 b=KxNuzisuyQZUB3mGpDfiYZI2GneLw3f6e6y8Xnc9vLSd5+gD+Zg5jTfFJyNOe7wwNHOPXgN/KWq2Z1AahSbrmMKlnnLeanPvOUOaqLaGFqH39pVVQk6pauCoWeQVV6TswexovFFQh9ufH7kK8PIE3rfEUGA/2DRjVWqx3nKrBlBUha686xXIzQX7gxlMZQN4zbMy00ImJRmdGQQK9PASlvUe2cj/ixOPXX3kDjMlouf9q+2SyDchyYfO2JTSs5Rjd+9OwREwkLqQIjzLKvEnglJZ/E2e/OLn6hG/b7+i7AGbgwZ9+1aCTqLSG8GlNey3+rqHko4Jm3cR4BUfWlieKw==
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
	<david.edmondson@oracle.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Thu, 4 May 2023 05:29:48 +0300
Message-ID: <20230504022959.547025-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT057:EE_|CH2PR12MB4906:EE_
X-MS-Office365-Filtering-Correlation-Id: 442ee1c1-5f52-47f0-7279-08db4c47848e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EezYh/iltB46Xfw7WghlMZRXeN2hsXsA9YYXGQdkvnsnqLXtqVi92decOd4aHv/yEkTVdy5K6CtzrHp9fRHjMYdRTo4H2+eS+XCAkLzabjLGif/V0d8zimQ60yPJtfge183wHGvA2Ow24Uvzm+aHgKEYGNlxA40CU2mJkRETyymqgsRHtp3FSATk4lb0FtFOFH8eZHwuKQFN47E6/HltGd9I/k/ZVG9rQfNn9hFZPHGq/zr1VHU1TD2C2FmAahp9VpQ7aR2oCGnAjw5aEJBZenqTEtxbR41I7VslQlv6ySVkpp6RYn1uISefreq/ZDq5HvcAAQMOl0EBo6PXhddwhhzUJpCK88kBMopvPbvTjEu+PSSzg9xi+iCtpbcIyhX5T0iZxTQVsfacbHU//2C9HoA23FHEFyLFzhGuR9LNAJiXAZlbntUdTtjciigu++kAIDPFThpvkrUFeSjQKvww5ABO6b0KIqBIVXM+KlOZ4xZW5HyEqR8AXlYzsH2MekmLxelvHUcnn4An/IoUIM1NPmwwGySdmh6KuawdYIJznS35LRcDkqjdOHR8ZCbkXToj8V65LXyzhHjDKDd+gzg7Xn3kda3UEh0rLSYDIroKLCbI28CY73TPZ3CAgGdJmV52nGA6/Rd9BTKqBab6mlJrzfq1fcKbxn0tyvjZqfLhKypzfSF3TzUKouWqXB4NhZzEHKkeetRKw2MxhZjlYzADq4CMTKN+3RIJeoC3OqTSI343Y/rm6g7NR1SptWk3Vw/3
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(356005)(5660300002)(7636003)(8936002)(8676002)(70206006)(70586007)(316002)(82740400003)(2906002)(40480700001)(40460700003)(4326008)(41300700001)(86362001)(107886003)(16526019)(6666004)(966005)(1076003)(26005)(186003)(336012)(36860700001)(426003)(83380400001)(47076005)(36756003)(82310400005)(2616005)(478600001)(54906003)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 02:30:25.2436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 442ee1c1-5f52-47f0-7279-08db4c47848e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4906
Subject: [virtio-dev] [PATCH v16 00/11] Rename queue number to queue index

1. Currently, virtqueue is identified between driver and device
interchangeably using either number or index terminology.

2. Between PCI and MMIO transport the queue size (depth) is
defined as queue_size and QueueNum respectively.

To avoid confusion and to have consistency, unify them to use
index.

3. Field name vqn in the driver notification structure is
ambiguous as it is supposed to hold either vq index or device
supplied vq config data.

4. Device is really supplying queue identifier or a opaque data in the 
queue_notify_data register, and this often get confused with
very similar looking feature bit NOTIFICATION_DATA.

Solution:
a. Use virtqueue index description, and rename MMIO register as QueueSize.
b. Replace virtqueue number with virtqueue index
c. RSS area of virtio net has inherited some logic, describe it
using abstract rss_rq_id.
d. rename queue_notifify_data to queue_notify_config_data.
e. rename vqn to vq_notify_config_data to reflect it can hold either vq
index of device supplied some id.

Patch summary:
patch-1 introduce vq number as generic term
patch-2 renames index to number for pci transport
patch-3 rename queue_notify_data to queue_notify_config_data
patch-4 remove first vq index reference
patch-5 renames mmio register from Num to Size
patch-6 renames index to number for mmio transport
patch-7 renames num field to size for ccw transport
patch-8 renames vq by its index for ccw transport
patch-9 for virtio-net removes duplicate example from requirements
patch-10 for virtio-net updates rss description to use vq index
patch-11 for virtio-net to update cvq notifications coalescing commands

This series only improves the documentation, it does not change any
transport or device functionality.

Please review.
This series fixes the issue [1].

[1] https://github.com/oasis-tcs/virtio-spec/issues/163

---
changelog:
v15->v16:
- rewrote vq index range for better reading
- fixed adding article
- replaced is with was
- fixed incorrect type of 'not'
- replaced receive virtqueue with receive virtqueue id
v14->v15:
- added RB and ack tag from Halil to several patches
- fixed next listed comments from Michael and Halil
- renamed notifications-pci-le.c to notifications-data-le.c
- removed unwanted \item tag
- fixed white spaces at the end of lines
- address next comment from Michael and Halil
- changed description of unclassified_queue to use 'specifies'
v13->v14:
- added Halil's RB tag
- added pci transport specific union structure
- added normative lines for case when VIRTIO_F_NOTIF_CONFIG_DATA
  is not negotiated.
- added normataive lines for clarify bit-width for driver notification
- replace left over _id with _config_data
- use _notif_config_data name to align to feature name
v12->v13:
- renamed queue_notify_id to queue_notify_config_data
- added patch to cover notifications coalescing commands after rebase
- fixed left out virtqueue number to virtqueue index
- dropped abbreviation of virtqueue to vq
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


Parav Pandit (11):
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
  virtio-net: Update vqn to vq_index for cvq cmds

 content.tex                      | 21 ++++++---
 device-types/net/description.tex | 53 ++++++++++++++---------
 notifications-be.c               |  2 +-
 notifications-data-le.c          |  8 ++++
 notifications-le.c               |  2 +-
 transport-ccw.tex                | 15 ++++---
 transport-mmio.tex               | 55 ++++++++++++++----------
 transport-pci.tex                | 73 +++++++++++++++++++++++---------
 8 files changed, 151 insertions(+), 78 deletions(-)
 create mode 100644 notifications-data-le.c

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

