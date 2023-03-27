Return-Path: <virtio-dev-return-11796-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18B1C76195
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 27D9360273
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0DB299863FA
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E5D8D983F7B; Tue, 28 Mar 2023 00:00:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A01FB98657D;
	Tue, 28 Mar 2023 00:00:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oN1F4dbnajX0GQ2MGq6bpEeJp3NyyN78qh1J5F+E1E9bLATNBb+zHkuxzD66WdU3xeFcIN5pZZS7Q331bE/3zknVksfMKfCEziRkDZTQHjwi5pjLGaE2fIkqIc2ZBPoy/ywHJG9O6K8k5dYnXE/OtlrfzBNLjkYYXhIMHRFbg3KOcduSnu5RdUwEyrniIGGFWEM+tocdrNYcAOX+JS6RBBIdzzxoJcUAEi8aBRJqk0HZGyHmLQR0V0gu0HqT6GPUtkb+8mR3ufLF5i91MEt8FrsTaNKUaP7jWwTcxpPEcL3VBWH89QFKkim6PQPU0Qasw+mwVipyF0Q32G+fZqg9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gERCTpNrf0WKbkE0nvW5bRWyJNPlI917hIKs/kPG6Og=;
 b=h8+k8L6EGR7hriUxbM3iVk3yeuLnlxpTmB1CASOwyNvOe8UbNaJwKuXQ6mZL1mNtkQcJyggNS85K+KW5zTPVI+KzFjUuNdopgiuI1lesDzXz/oC0XKpSx80d9Xff4XjDTZ5EGbsJcTJBxCvygwdbqPpspgxGdV5TXJB9l71wWvFt5BQEjAoDTFr17/RM2Hb5Dpva6QQ0IN4f+QyfQx2X87U23g+8G8rGCJ0Na133llb3ltE9KkP05V98vEHKRAKJvx5DdCcmLKnigVRpuMxaccNxBRufpsqEP6VPXbE7eQWzHqp4N2wiPSoPy/l0sdHo2aUZ0ettCTpOrPKjt4m6rA==
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
Date: Tue, 28 Mar 2023 02:59:28 +0300
Message-ID: <20230327235936.414196-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT010:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: a552ab05-4b72-4a9f-f2e4-08db2f1f606e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vC7kXY7xal2gw51A3dV/Wk/2ZpRgZmmu/+3/Pk37iiYX2YN9uAr0ZBGpYBGkcZEKrbZKGpf8DcW1/r6nxlLVkJ7i0OkYLKrjU5lEGpMvyJYosswrCz3Q86dsKc9eMMw3JF0YnM99jMKGvq1sp69l5zGv4Pq24KSy6eZQmE52vFE+MrTClzULITP6XeeZilPC8B/lBEENRFrSNIu4jiTvB0fbnh3VWZxy6yspLdEDcawaRLsRr1gTc/+aKrpkj2JOxvn3I4GCOIfAPBo/2H4gO/2sHirNiKbOIj3oC+SypO6IQUQCnGOvBhSZIV6+wigGZoEpxGD9VhNXMTMkrU9cGaP3zqjg11pxE5gEhtk+AxfOK3ks2Jbqe7zji2dUH7HwFgNxaZ6KSP+T8FI0GMMkOOIBjA2HRu/rZAt7CVG4pzJBexrb5Pi9DxXfEn/jTzxkjzkv1Qa9kpJIorflLDSO81U2R8LhhnVf/1cg9U7D3+IYCg9l/tBZHXx1y4MlB/meFENmJ9RBaXlhKI6zAI9UYexgT7gdQbu0V+KtnLgferx6aCMaFpE7LQT2ChDGg1wU+VQTV/2e8Rx32Zmgt3UdaxNOXa2Fh2XW5joaVmkTMX/WLZo27I3DQBQfFOAsCxWZh+Jn5w8ZYWFBEioPhP+Sn1dKuSk3mIqS1HLYm90vFS+SZ/lgIJO5uYOMBW9FMw8bEeljjeP/3nZIkcDyPkol6LfFmWHZJ+iPYH7E9jcr3rxkWmjILBCNtKJGeZVXkv8yHQKOVuPKKRG2fndkM5ysuNWSJ/pQJ1eostTZ7nU8ztT7LC76YuFtoqiPeuKayW2cUFsELYisH5DMFHQcUgzs3Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(426003)(26005)(47076005)(86362001)(2906002)(316002)(1076003)(6666004)(107886003)(110136005)(82310400005)(966005)(83380400001)(478600001)(54906003)(356005)(40480700001)(36860700001)(336012)(16526019)(2616005)(186003)(40460700003)(8676002)(4326008)(70586007)(36756003)(41300700001)(70206006)(5660300002)(7636003)(34020700004)(82740400003)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 00:00:00.9401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a552ab05-4b72-4a9f-f2e4-08db2f1f606e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805
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

