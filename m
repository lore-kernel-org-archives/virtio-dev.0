Return-Path: <virtio-dev-return-11736-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7360C6FD1C
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:00:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ADB26C6101
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:00:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9E5F19864EB
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 01:00:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 91409986475; Thu, 23 Mar 2023 01:00:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 51B4898646A;
	Thu, 23 Mar 2023 01:00:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCGPE/17FUKa5A41TPM6A/bU9oqt6LpxhQlYONVkvyTzmjyFyFIeOkECl8XqiCVDFxg7iShTk+FcaKbeNQORoaKgYGfJKVNUBJ4PHWiONZScRcvmTBWvpH9hS3oW73p+YMgwvkdlD6UNyY1+QpvkRgYhXMRwEZHKERZRHfI3qhgJIE9aqTZeZ5kX1GlZCNJf1iTcs9qRrloRyEkPdb/XC6FdHCpiZ4oTQ4/FXY7xUzmv0Auz9sUq6DVdBbzyBc4ZasfUSO923cPQtTJ1cPi9PdhU5mWQ+4nHEQWJfiSqfDEu43vv5sDizsFNF6qwBFC2r87B5aNUEJe2jOvW+UEGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xpqGpqPQ76gk/Br9iM6weNWBLW/qdT+A0IexB6sXDU=;
 b=VVkcL2bth9FCabsLKun1ev0mlCBhMtaTrL113dPuzh8YuK8Q1YcZxAWUY/J27xRJO6D/cM57kQCQOZcSNTG37wMMKLzpr4zuN6tBThYMpP5FH8s4r+hGCWfYmxxXcfSfHWXsmPZ2zPLC+7F7UXkC8mMfdzjZKH39Hhwa3roxL8TN/+JgyHn6cnYT0mWKjm5xyOUy0sxCioiG9oTbsdTOv5HQMUIS5cSLtKDLYX5pNV8SHete7/mXXm7AbvLkTwPeR7j4vqDlBPXKH3HOM2lWUipDkQfsXWhpBWN+ELaFyID+eVfwMdPAH8OHyT9EsCyCcGtRFJDNCYu+FcxwVRqkrA==
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
Date: Thu, 23 Mar 2023 02:59:36 +0200
Message-ID: <20230323005944.262738-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C984:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e5115d-f30e-4483-9969-08db2b39fc29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qv4sDoe5AbSdX1Y+hodOUF5Ixod2E3SOtcMQgQX+tFFY0kJ1dLyBkpHh3kDKVobAWj/7dXnCDBXP1uvxGkCmJGawq5uOiBW802k15cW3I7g3a5qdNlb32KN9E1k43V5HMd+7yu3LkYerTs44lK3rCu61+7cEA1At8lHWm+MEPqvLl5mUzK6JNtmk3fKUHTr+NJoccNVlUrORJnLPn9r6mGAXK8cTxaHFoR7hWGsUIMHcwqtxgl1YbOi2zP1MddQfjkI3MoMXSvrfGNN5E11Z1HTgEAnQZXTPaJ9s32mROhW3MrclNjrMxv92mYTyHHG8MQBo3SrHzojnjHTpzoGHOSaWWqW3OhuLmHVpr+y2dN1Q4dmRF1PmRe9btSQENOFqTeBFKaVv3Fgux2kl6nlGdP6vxf9ouCxgtWZX2+Wjn+1NiF922Z9iDqoYnDnmGQotCEZ6HYaQ3zmiYoqwO9Hua0LLm7WfIo+GXsxj6vO/oMiRgf/rjOo+lOGihq70ReWJI1B6nEZz+WOpACWWirRhfq9agcbhj6DCzNwxPekOhUwG7UqpPzS5QHYPFxVYDwtsJ9tpynHS2ftcwx5Ybdh6+Y5tJMc0frMAxKmHA9AZC0h1A38WwS+yNbJYT7VZEMnR7wZgVrEmEVN6Peas7wZeaAl1HX/eXtUYpBkkhoJMQw6aC7vt18iqJyMoB6iWoNzwVka1CIeeHUCdwcX0oX7vjGxbXMTqKtKMRblYMcSuDTetaVh/Kd15p3cqVe1B/yp9+aIf116Q4Cfm9v/a/Fxj35MqW1FjElL3PELI/xz0iQA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199018)(40470700004)(36840700001)(46966006)(7636003)(40480700001)(8936002)(336012)(966005)(70586007)(6666004)(86362001)(107886003)(41300700001)(4326008)(40460700003)(8676002)(36860700001)(70206006)(82740400003)(2616005)(356005)(54906003)(2906002)(83380400001)(478600001)(82310400005)(26005)(36756003)(1076003)(16526019)(5660300002)(47076005)(316002)(110136005)(426003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 01:00:24.5678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e5115d-f30e-4483-9969-08db2b39fc29
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C984.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677
Subject: [virtio-dev] [PATCH v5 0/8] Rename queue index to queue number

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
 device-types/net/description.tex | 28 +++++++++++-----
 transport-ccw.tex                | 27 ++++++++-------
 transport-mmio.tex               | 56 +++++++++++++++++++-------------
 transport-pci.tex                | 14 ++++----
 5 files changed, 80 insertions(+), 48 deletions(-)

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

