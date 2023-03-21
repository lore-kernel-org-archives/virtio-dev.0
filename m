Return-Path: <virtio-dev-return-11688-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC833C76195
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 39B313E32A
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2765A9864D2
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1AC6D986450; Tue, 21 Mar 2023 21:59:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0780E98643E;
	Tue, 21 Mar 2023 21:59:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AX2fIbu8BZWqQvMCgKyVWUib8R36Ej312xNGiqqnU6VKBBZqzgGumglFkSm4anDHoCxAo+0/aoKtq0YoIS0nsPdcsCCi4yBwMtgkDp8Tlrl2WdTiliPvTolutJrzx3eWQWVFC58qhVOK0pjgQ3ymNj9gUVxaP8HOVlFSSmRu04BBIT+ASjlQq3u2+Q8GQrNShNgSDR4wt9b5rp6YoAllV+m3FT5SJFeCqJYnpZjO3gCverhSioS/c0uUY7dckipJmI4XWszBHc1W/JdUsmpo/mcwlJiQx1nrTektYYqb2x9hd/1CNI7x+RxwnIr2d1R5mWgewH2zFm5QUOcg/kRZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znMKx3g1TFWq5Oq4KRoLPWDn6TA9neSUg+hNUn3q1hU=;
 b=L55DZQxjfIB5Ubloa0Z1rtkFkiwB5fZAX3iP3kw621PkNgXoolSqDvkON/nGF8UR8viPPYBzmpnLGQrzmVFts852pNsJruqNFQmd31FyNQkMX7Zy+H5wZUj466b2OEg/nfqLfw5omk5uEF1kfpHPLgo6Jr05Y5d8lrqdTLomVd/vJ0AEK0wDXkYag1+oR8WcGH1KKv2ES79YPgieL1ZBuHq4sHlsxElxHFr4+ivgenTkRNzZo6XiuL+52sf79QQKTYP99s+9xW8y56QaqjLjlP7MLBuiSrIr/TnDgvZO8/ftJUSaLiLQeuYnK3giQmoy+6lTek75d7CHJAw/p/yaBQ==
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
Date: Tue, 21 Mar 2023 23:58:26 +0200
Message-ID: <20230321215834.225856-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT063:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: ba35ed06-b720-4f4e-69fe-08db2a577b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7a91+Hxu7rG5MZBdjkgh5jBEaU0INLFTBOgTigxTzCIFuzHzbtfGUczlK7qtb09BPSNIX98tzK0LiHBjxmFzMGXOIN3Mpg/x3jPGBOdmR5q3XPB8ssEJZoSx6seY7b8/NFMxyInP1tRAZuOiYa16sCaz/NwI34b8VUoR8xRIFPzylLJewg180SbMlEbsWoKZ1SKY3AXM3LSF7gdpzNvNpfkPoJfBBFJJKp36pavUuSXb2TqYurI4HxpVE0v18OYpdtKDGw6rhaqZ0Pj4uGee3oST0leTQqoHB13/PHytZ1P7taS7YafXQJwam935fv1+4pWIBPW+DsHSnLT7w/6id7MxAlqPjZUZUv4yX8LU2ErBzVNOz7g6abJxIqLpVld/xzcwoLY8f87OJzykWQDFRjT1ctXI2/q33+GYOM2vV2NzBgFADhvHHY+lF/5NA2VTA4N8HZrMKzhgZeB+zqc+vApGn00JsjJszzNzuIxUoH1S9imTqwAh1oBi106qIqEua6nFfWcHkROyx8e/wUyqF0+XJong4zMimCWViXn+npbmvFLchhwWNYadGxgho6M2GPEwhvjUOLTco0loZAMM26qqzxTTanJvmuFtB87zOQrbLUyn+oVXFbbuDgwvIV8uthG/OtsnheZLC0ahh1cN+VlXUrqF+bqOLvi8wRD2a2hzcBkHAJU7i0NDz6RoiiIrEd9SFJeXUDTaTD/ken9tpZaiW6rnxcwi7woUmlLkInlIo6igCmJbDQwxhF68kLQnyJ6dES/xQDBzwmGKGWZSxuTf3qgR3X9o65rgCwKzfVg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(2616005)(336012)(426003)(47076005)(82310400005)(83380400001)(54906003)(1076003)(316002)(966005)(6666004)(110136005)(186003)(478600001)(16526019)(26005)(107886003)(70206006)(356005)(36860700001)(40460700003)(7636003)(86362001)(2906002)(8936002)(4326008)(5660300002)(41300700001)(70586007)(8676002)(36756003)(40480700001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 21:59:01.7304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba35ed06-b720-4f4e-69fe-08db2a577b17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031
Subject: [virtio-dev] [PATCH v3 0/8] Rename queue index to queue number

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
 device-types/net/description.tex | 24 ++++++++++----
 transport-ccw.tex                | 51 ++++++++++++++++++++++-------
 transport-mmio.tex               | 56 +++++++++++++++++++-------------
 transport-pci.tex                | 14 ++++----
 5 files changed, 102 insertions(+), 46 deletions(-)

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

