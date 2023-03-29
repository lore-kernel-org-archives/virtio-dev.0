Return-Path: <virtio-dev-return-11841-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918E9C761A6
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DD1B52A81F
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D94E8986589
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 21:24:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CE53A98654B; Wed, 29 Mar 2023 21:24:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B62639864EB;
	Wed, 29 Mar 2023 21:24:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4+VzyL7teXQ7q0rvyuoDky+84vIfYzN0sC9Nvloi0PbxnltjGBdWdCozdp0yT7E92sa4vrpgkvFPvRuphxVo8gh3eZELbctitxJMoahapbxqQcLcirHB6ZE6Ho9qQk6/jZrdhF0zzGxKlcPrHlWgcdvbUe1/EZ85fz3sRUWyqW8MBoMpB/gUfL+hmO+EbcnWtZhHawqL3K5vYi+bb2G2u4bdaNyf1aDz7r+cm45S14xslTU2auUq937Zd3HXYQgpeT2ebkdfeuJhou3Fqmer6oK1ShGFxnJ1Pg5FmFBIrhnvC6YR7OO/0ZeBLBnwqwsNdtjVYXalYPJzib4T9zB4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAFUaA6s/7J3hL0rkPvjg0l0gGJqh5t2lfy383tHyUI=;
 b=HY67Opf8KV+GbVBzmJnEC//XpTAgRYpZzUnbJrx8FWPPAbGtG3LIhDgy0mTKxjHQMt57xwE3a6uPdhd/aGuAxCDJErFamXyYRhPU/Hz0BIMmlSOZAPBcXwP+VStYprcBlZ6iJmWDalIqI1FXqdZPVw0tgwHZioz5iouBEhvA84WtaNUQJbQxKcMz+gT6X0mEWN1ONZnDM4VhXpeE4YSmRje/dtemo+E2rr3mTkyD1IhJwVLdSMDVkdi2isWRZ2mjc6HiqJqzuQsNdustC0drSQJ0TGK9l9wVhYTIKEPTHJoKXhAgS5UUdHF0T49GbiToqJtIUNo7fbvLMbG12twSqA==
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
Date: Thu, 30 Mar 2023 00:23:33 +0300
Message-ID: <20230329212341.465843-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|BL1PR12MB5380:EE_
X-MS-Office365-Filtering-Correlation-Id: 7addb7be-246e-4aec-5b55-08db309bec06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6qnvUbOTdYhkH768NNOPOslklVqoNErgwlE6Nxqgwz+RHk5KwUvjvAD/fU6m1VO/8gFGQkJX16FkSmvGbdciaqbU1CJ1Up0h6V/6gC6vyaFvYiMgCXBaLAUPxiyIuNBr4twR6HX3qGvd3VsdpfJy37qzijUsMQnMZJ3d94X2xLWrjMxJHb5d3Lbi7i8aRzzJnfR88g6W2MZ0whpqpeT8p7vxAzCc3qgH9o1aRrtqTxe3fBWKnmzuWJGzRLb1TT7HDe5B7nXTV7g4x/aSnv88TKZMGBZl1CmFW9yas4QMQrPZvWMLK8slPeCQL91L2Vx8mYODzWLVeqr56QNkSr0aGovgDLLyt+RgpFcxLHebD5nAEhsDDCBb5/w+e7owJOSRBDWMbNvvi3fCKRzO/vW4snJm2OrHsDzlzrvYsWgAMpfJxGrUugrH3VGl2IxbeSuLUwDmOaZ4G6qgOCTXWVDb9GLYH9SgQWGeYw5Xus9Vq1D+WrjkwPrFMdwliipMK/vFILHPSOeicSZH5gCzAgmnYaiwPUibiB6teR1vJkkcvIpwuObzp672qlmFzXioaBe6JH0zOPlZaBoWzZkjd5bUEpmBKfJ/KmLbwgIqsJbthMkKij/jvbSL1AQPKQkChUBXQj8PF8sqrDXhqrVcVT5AFtvmwGOFkdWlNOvPfP4rqdOWaXunC1Y2SJW+i1/daNAoj8gkFQO6bllVgKTdS0+/NToh4f+lai5/GJJJuVd72HMdi/tfQqC0TWEoFA6SbUlcfdlfYkyFgAe1u8wr6XjA7scefv6cjPUkyVJwFMkKAl2VOoLRvpijpildMnAU2XjhqUB5B5xOK2kSCc1n8VhiJQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(83380400001)(107886003)(6666004)(1076003)(356005)(82740400003)(7636003)(26005)(82310400005)(110136005)(316002)(54906003)(70206006)(36756003)(8676002)(70586007)(40480700001)(86362001)(41300700001)(4326008)(40460700003)(2616005)(47076005)(478600001)(966005)(16526019)(336012)(5660300002)(2906002)(8936002)(36860700001)(426003)(34020700004)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 21:24:03.8929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7addb7be-246e-4aec-5b55-08db309bec06
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380
Subject: [virtio-dev] [PATCH v10 0/8] Rename queue index to queue number

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

