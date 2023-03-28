Return-Path: <virtio-dev-return-11823-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EADEC761A6
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 20:18:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4881342562
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 20:18:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DE4EE986758
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 20:18:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8A85F986565; Tue, 28 Mar 2023 20:18:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 488CA986291;
	Tue, 28 Mar 2023 20:18:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZI7MRMHxRll2aBePmxrYk9rAAXJ0MH7fssAwxkKqOGL9GQ7FgZVFeqxFpdsmDz/rbPr+tc0XCpWBYslP/AIvUr8vsNzh8H1yRIuBZhejo7dDn1swt4FhvOUtWmIa1RBXmdNl3R7dN3UZediOqxTz43VmX2t+1HSZA9GzZLNHLJdygGIp3pclgflxWPTkq8wmNwwOOtuRoTDP36OJsfOyBraCdZzu0ahuNZIAB97hN+CD5iBKoscTc9/ktJ97oeXGhEZMHNJs/nsfDKSSG1Y5dcVghuxdEB+xPEWQWU1mSnvxh7swJGSIU01GIh2gtgyPC4hqVCU2zv5KMffaviiibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BriTeVmg3SnYox35NM3GnlAOCvfsaQef0g3+V8fQmg=;
 b=OIbkSBwgQiVViFwEsee+1ozslifYqReORn96Y4I1d9Zh3r8r+ascgBvjTPjxu57Psvel+pWBQf/pwU9R88eEjAZxHwMMd7MhgnLgtU48cdiU05CRgN2vGNXa2RnrmtdAGUAHWCLKN7VuU+1yZ4X5ZjL3wLWk7+EplzoN6qOq9i6WDcXVkHCk4Y6X3wWiUDdIpA8zAZj8MzmXVyvQE6Zka/8LtHXwOkTiYwWF/oGF9Dhqr2gf6l1xGV2/opcLNpPrHHjtkyIuR4TrwMHfdWJq4oBV4lDjW44m1oyDtb925s5il7V+vDLTToSdhfL/xUcS+q3+oYaJVqpfEiQC5wJyAA==
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
Date: Tue, 28 Mar 2023 23:17:46 +0300
Message-ID: <20230328201754.440974-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97F:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: f8847e49-0bba-41b8-148b-08db2fc993b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s6MTDXuRCpDBX+GnKzfFSgoyxa92hzpzbWFUaO1f0/JKz58jyKgWmNBUEpz+ao92/wEb3B5X1cXLnK2p9L89kTtBrq85+z3WX8mywkpVzvmMfklkkud6QbcmxI1031zLaC0LbrQNvU5utHSsRWUEmzDTDrGttHUZ5U/GhwyykZ9Q3HIoTflpxTnBXJIGavPVOdw4isJpyH8FrZRlJqlPg1mZkMfcKBUrdTG2NqC1ZUUni8MfKd7eOHOqDtrtZCy2oA4kWP37bEBVeo00wY0zfRRzpZ/AjJs2xnMpwc1GS4QsHEmOdR/pL1i4YtJcMzwaP4ZoYhTk2h/Grkv+yHELcWDotgQRKFWPOS6hFRzS0m3c4gAuDh2OebUR67fqqfmGMPM7hyZs5ffD8P3bEW920DEyTCHMZk3Tk6suhMA5ErDZU/om6u3x16yk2JE++nN1wPybOkZASyFasKKHFBbzamQ6icfJPm2dXqoFPP2s5Ki74UIEHQH/nI3gjSn/jks9bKyesvXoYYUgoUKR/Tef8OXOBOnfrt64DPifo6h137+LrKKzjl6krHshUS1e5manjHovHSMlelbsO4RzUzt++WKkv3DVEWtzqjgBpKAMRvzz6oNRMY44fvpSc4qguPQ6OmXeiUu7HWZIbg58taYwxTD+f8kQhvyqxuZA2hsANBIjzNZ3JqtHtGV5l/Ijrczs7JwRmRJ1N5y0gr6RGog57i4+XVIjt996s4MXq2Cdt4J7p6ZF3K/gC5B+IErz9n4zM1dQQX0QZn2vcrR6IsD/9TLDaVUghIJKTFbqzYXy31A=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(2906002)(40460700003)(82310400005)(966005)(36756003)(110136005)(70206006)(41300700001)(4326008)(8676002)(316002)(70586007)(54906003)(36860700001)(478600001)(5660300002)(40480700001)(82740400003)(83380400001)(356005)(7636003)(2616005)(16526019)(186003)(6666004)(107886003)(1076003)(26005)(86362001)(8936002)(336012)(426003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 20:18:21.4438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8847e49-0bba-41b8-148b-08db2fc993b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C97F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911
Subject: [virtio-dev] [PATCH v9 0/8] Rename queue index to queue number

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
 transport-ccw.tex                | 27 +++++++------
 transport-mmio.tex               | 67 +++++++++++++++++++-------------
 transport-pci.tex                | 13 ++++---
 5 files changed, 86 insertions(+), 54 deletions(-)

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

