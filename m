Return-Path: <virtio-dev-return-12141-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45459C76196
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 54F40604C9
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 31888986662
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1C4E698672A; Tue, 11 Apr 2023 19:24:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 47D909866A8;
	Tue, 11 Apr 2023 19:24:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6T9p4Cibpoth/QkpD4aKd95pALghF4ZNootKbl4mYIJ+ocarLkbO42/zMVXQC9voOWN35201gytf1Lfu28feCuU5sKwYjWDvOugZ5WrILVUPCvkkYq9oWhMu/PBFLX49iAbvSr0knSq6rznPVMW92Bv6hA+EMp3Ze5jqPlFjr0uoQdZSnN0M8R89cy++BE5+U3hyz9SCnqknUUHLoDoUjtihvWTRzQahgKeWM1C6DfZkyS+6N1qYRvm57C+h0nQLDyehXWoTe1UH2/qYOxiqAMQQ4YymLC1qldcQYe5WkKy4JdY1zsMJ2lgzzER/a8zOnqPrHF+zPFC/Oe229gFtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOmZEzB8MKK7vo7E3WGI7VMeIea4xw7j0cIebonlIfQ=;
 b=ZWVynVv+vTvG9Z9rv2ZscJ/Oi2fL8V9+KJU2/KDyckpsGHZYCVDLGIzOuUHOwfyiuuNnWkykXkrQl2Q+bOFoXfqC3ZsNohw7q8X0f+EdaFHmy2AwtA2xjTOPhlZVGVEk5b3Xk9TOPOq0Ypj94xPLL4oULWqIDurTCjFf1FPRe7RNtsxvwgZHALUtPbQtdvn+X1cxzkEg4BUlNEVOc8f7j3WVOCeH2Jt3oagW5XOOLAROppj25OvU+ka8hfPIe2/ZJcd0+IZXiH4PSMVsXvzKJtfptMH8VJ5wT7dHGoFgn9WYFKQnu0HFgcaKDLejjssd7TW7pRSG8EI92HdkP13i7Q==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <sgarzare@redhat.com>, <pasic@linux.ibm.com>,
	<virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Tue, 11 Apr 2023 22:23:30 +0300
Message-ID: <20230411192341.751841-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BA:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6a52c9-bc59-44d8-6054-08db3ac25610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ijlV8QgjXprQCasuojkxZaj8lfkwE0QoduySisyKSdj+uuQQbonwIGYPEZcOObhXbRfbYtQw8jOs4GZkh3RSrXgUBHGsKPPzaps6PUf7gOXmFpjPYZB2HzgHIW/0hzEhk95Ns0wUBnlMpWZdhKokWi/r/lVWKifdb0teJ252nlkwZylCxnb+a1yr9oFdLyAclB3n0MWjFZvyblYw3jINw/Pwpu1xkSMQTZy2skkc1EXhIUBTylDzy17QIq156dzzPdJeyt6dQi2neRI6OCwhHKojBooTJ3+XL80nExSoPw2gB12UJ3NitCdD9xD2WgebxBwFRRfulj7C7sjjKAWQYgrByHzTc8R56/HNBPkg+c5UMfR45b9jPOXP9KuwzkV+JTz0rUv80+3F2soKMLHSTS9CH07R6ifu1N7NRFQxXdulpT/9+KQ3sirax6mV+TAgnEIxxzbaHduuSjYiDyuOPYk/d1SY8yyxCBultzvuyGGa8C+GDDu1IPUWyiYbEac+KV7wGRA87GjQjlQP7KxwCKG2OtiRg6ADYNLDvQ9ylWwl/uO6lLAFTo5v34cqht/8jyVDD6R6p0caYJ0cXAuNZtnOKF09YVpl+GS6whpGwqZXdMYHyjaBu6IEIeA+Wmp4uBqFmgQIk9Du9rGG4H9TEsfHrZglOm8btL7uMo7GqSc/GoMa5LmqjGTiTZG94Z3w3FT924tB5GlBHsyB23zO7B03taqF3Z08a99g4Cv0P6CkIGh14GqJhi+jxq9tBiCOED2Qbj6Vz+UV0D/Zvmr+KSyQNRDsoXxenpm/eij9gB0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(478600001)(40480700001)(47076005)(36756003)(83380400001)(86362001)(40460700003)(356005)(82740400003)(426003)(2616005)(7636003)(966005)(2906002)(316002)(110136005)(16526019)(1076003)(336012)(36860700001)(54906003)(26005)(186003)(8676002)(8936002)(6666004)(82310400005)(41300700001)(5660300002)(107886003)(70586007)(4326008)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 19:24:14.3162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6a52c9-bc59-44d8-6054-08db3ac25610
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF000145BA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173
Subject: [virtio-dev] [PATCH v13 00/11] Rename queue number to queue index

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

 content.tex                      | 20 ++++++++----
 device-types/net/description.tex | 53 ++++++++++++++++++------------
 notifications-be.c               |  2 +-
 notifications-le.c               |  2 +-
 transport-ccw.tex                | 15 +++++----
 transport-mmio.tex               | 55 +++++++++++++++++++-------------
 transport-pci.tex                | 28 +++++++++-------
 7 files changed, 106 insertions(+), 69 deletions(-)

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

