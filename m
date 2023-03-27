Return-Path: <virtio-dev-return-11794-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705E8C6FD1D
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 23:58:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8C19423D57
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 23:58:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8443E9863E6
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 23:58:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7A23A98631B; Mon, 27 Mar 2023 23:58:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5DEBE98633B;
	Mon, 27 Mar 2023 23:58:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ft3clMgzSCUcGG0iijdBNIvbTlY6BIv8Zl1f8nbQtWEAuf6Oea+zDjuWiziy+WTZEh6yfFgI31kak4LwvZxa+uiw7/MPnz5kXWAEBLjXOyA9Md6eMoNRj+9N4W0rManqtjwuRGCzFnl9HA9M0zuemABL/W30wG/hY31alL/s2edFYRHIXwC5ZAk148AI4/NlQoOOeL2pxtlaF92ju7atgmCU26Zkqr2m44TXkjN/qX9gZ0rYsbj7u1HEO/AAABuNxois80G/CuSzm6qhrzm94ScngM8S8mNOBkKUHz997wMQLH3N0pxv8nakiRlOWpSJZ2Co9eMa5tYi4vpuv3/jqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gERCTpNrf0WKbkE0nvW5bRWyJNPlI917hIKs/kPG6Og=;
 b=bhMcDwHjKcUNwWsvRcdaqKdcnX/tvaWk0hMx06XZbPzRJFLDk2gLF9F56jyk1iURe4kkk7hYeFnJxn8E5BVE6DfwEV+446Aw7nFeUq+YZaURiRkp5W1TyGlN21AHnM9DyGVqh09rmRVDw5YgoPZ2mOlOGIOi0RWVuJ4QG3O9tEDHVbntCQMkrmN9Pf/mwrg54TkAFi1v6eVlZqb9WiH6T9jn9Js65TCev6yePFkkthhsDF6jo323oulTbdNQZkbowykK3AqQZEiWMFPgvs5bCWDtK2GOrdxE98VCKuTzTTOQ54xKKc9W8n3BiJCA55CWyF5LArI2XmL94lGXwN6woA==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Tue, 28 Mar 2023 02:58:04 +0300
Message-ID: <20230327235812.414126-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3C:EE_|CY5PR12MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b661e0-eabe-4328-6612-08db2f1f2d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eBE2c2Au8k4IINV1YJpRx3Y6VMMU1ZiyoWoLopclCiiodITgZYiAFYMpGpplkW6oTZiigQywJSB3sjGHwGs8LcRfg1BiVy2/iijCv78HDjSPqP9n5IWcJnRO/UnqeFo14LHDsGEZLmHaxrNY5etR8vvXnM6aapMYynfiffpjk6/UK7cw3F5IBUCKf2D0zoP1r/3SlFy+82MTZtHX4kHyqjrZ3Wz7WS3gJq7I5FAjbavuTxBgPNa5GEyh0NXmMGb+jxEQvjzUuw05xDyWNsrJzKdqQC6vlH+w+Iqdmy1gjbz1oAdaY/JNG7/tpx0qVvhN8BdUxKaxAGj/sRhmqesKerwkSZj53cb2m9sS7B7ggA+jIC+x21Ihs8EXrHWhNDcFIgLSHbmlGJ4ymS6Uzp9/nxX4mSUY6xTPJEZypOcGNQbUWsc9rLrJ4ykJWyAuc+YdQTKSO6uqHDopwiQ19ez+Yjrextl/KpYvuM2Dd0cnjgMeiHc0vdCxOEXHHOhkIdTeg9ZeLd2pcDRq+7E+flnMF8Txn6e8Hqxasi2vgInPXXMGsxEDXmXyDS4V5PvFLCutJ+k3bQLbf36eIxC4h6edWfT2yzq/IJi+j5zixNIUpGDU7p+kXxtKGkJnD+MHtTmxabTWzfJ+kXmC5LPKnm5V8Yoif3UMY2afA68fdod6RYhoiFSqiSBc2YDw+YOfeTpahlVA4AxqpXw+q4YTXkEks/HZ+N+GvSFAmTYdcJHaqJMiHBfGh2OxKzvukM8jBSJrVSCjXJFU11rQgIz61Kjogbf9YiP6SV6iVKmXbGrz1Ro=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(2906002)(316002)(336012)(83380400001)(41300700001)(36756003)(426003)(2616005)(1076003)(40460700003)(4326008)(70206006)(70586007)(186003)(40480700001)(16526019)(36860700001)(478600001)(26005)(8936002)(82310400005)(107886003)(86362001)(54906003)(110136005)(6666004)(8676002)(7636003)(5660300002)(356005)(47076005)(966005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 23:58:34.8353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b661e0-eabe-4328-6612-08db2f1f2d1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0000EE3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6645
Subject: [virtio-dev] [PATCH v8 0/8] Rename queue index to queue number

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

 content.tex                      |  3 ++
 device-types/net/description.tex | 28 ++++++++++----
 transport-ccw.tex                | 27 ++++++++------
 transport-mmio.tex               | 63 ++++++++++++++++++--------------
 transport-pci.tex                | 14 ++++---
 5 files changed, 82 insertions(+), 53 deletions(-)

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

