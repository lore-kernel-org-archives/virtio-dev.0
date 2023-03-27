Return-Path: <virtio-dev-return-11784-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AADBC761A6
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:54:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 629887C2FD
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:54:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B8CB986429
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:54:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4FE32986318; Mon, 27 Mar 2023 20:54:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3AD3C986418;
	Mon, 27 Mar 2023 20:54:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxpMY9VcXlCImVxs0E4nZBsoH1Ou5ud2fYLJqv92HeL85JlQIYNDjuTB7+m09hEK60tBL10EkEXD9s6w3ld0MVuL5HjN0Iv7hYgQIj4tDiC/M9WuhXv9qdi4x1QNwck+G79Gdzq5JSzPlgzg/2LZHv6yNKHrywOiHCXCc9QKEk1HqtUFtKkIoIWY+FsR+kHAmfkwMgYfO+QserYEIUzA52QM3oKNF1bX+437iUqfVMtg/bMySaTJrzZxo3ZoHi+D/iVDfNd1fLFHV5OhdadK4fQY6Aeb3+07dKz8j64H6ApF6OS8WI4lujbG1XPDAdjRwBCSUz7BAmkXTch0V43aXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ul+zQlgq0YRGYjHrzzRqXdLLrF0IZTs/ctH3k1iEGlQ=;
 b=XAFtMrti8y0/V5oTG+rPuNlZKlAtomyRQeYKwJiJO4xh/kMP/6qGz7e8HwakHna4GoE1js4hYRtXFQ8Unry15C0ptdi+zL+RTVJywFcpBo3zI8prlmruTWzdGuo5U3fBx5ONhzqxp4Nz9cXfpT+O9kdKzpW2rmaq2YlFkGjpaNyngar98gLp0uTIO3Ishfy73JoVnZ0FD07xOV3U+Bpc/o/ZHDqIZDRR61Vv/h5dY4QPqeeFkkH3NxsJ3186b62zB41j4xDVE0ofa9kB5tKs4bQLi4NaCxgOEu/7Rr9Rt9gfmEZE99LJwmWnC9nPcSdcatvuwkTvmaRYKWdiMNyuwA==
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
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Mon, 27 Mar 2023 23:53:51 +0300
Message-ID: <20230327205359.406605-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E632:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 6568b264-e61e-42dd-a746-08db2f056fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yz/kkOuJpXaCsOoAM0NcKkIoeMXZBRHWWk5XYtUV24/Mr3cQtbzxzrgP5mK5gOO+glM8n0vaZ6cDAZlHkhTlajb0TWP4AnMkxQHNF9SafrWTa/jtTqTKqmdx1toMouM1jvzbcUViqXjXi1PpNKRQoYlxACTxY99ZGKEB4CcsqaC+xXceak272MntShCIHnTxDPManNt3nSP+xtItb9D2ADxzaLSSN9pJNXdF8ojrH0sZTFrvqQygPv1EbO1Cz7M+yi/oKQIvZ0dkS6RqKMxq5IS+/nFoHJOuWGA4zRLJ6BoDT6X4IpoNcq/u6pZsTqp0XYwxkzypnB9Fp9QrpnxoRgQSkX3oVDlDtv43eplvF7mVLw86QaQN0cD0S+jyMJoglQaAn/OBIQTdIewIRZJIZC5dDF19rAA9SYGYuyq9roMmVKcLz+R3jQWBhNKIZR31vlpr3BiuaOuDm0kUajs3xgb2jWpi88YAF4CvhEEvqhthgRqD1mkkaYg52a89MFoCVEtrfdoIKnPRrnVJVGUxUaquZTOSzVlvdVDBWGH3C971qePzv8qt9CoOQJUEdeNZgJYdhEqrvYtDXmFA4ZdrLtNcRROQ3mKgVBOwNa3plExddHfgKJIi/lwP/pQsmEDhVmgw6fSrD3dxpQ6sii+xwXtwPQseOLtzEP8v4PQKNiRhY5nGwhmlcz8a/HfZxwY8xTemb5N/qSkg7nRIpxGyfFMT2Yq2i6CjynVn94dCcNrxHK1D7rzDo/CxxRbfbonNuq6wMrAhC03Djj3IZIlJxc85Sjso0mO/dWqXxDsYP5E=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(40480700001)(82310400005)(36756003)(2906002)(40460700003)(478600001)(966005)(107886003)(6666004)(426003)(336012)(2616005)(47076005)(83380400001)(110136005)(36860700001)(8676002)(70586007)(54906003)(70206006)(4326008)(316002)(5660300002)(82740400003)(26005)(1076003)(16526019)(7636003)(186003)(8936002)(356005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 20:54:20.0314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6568b264-e61e-42dd-a746-08db2f056fe5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0000E632.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570
Subject: [virtio-dev] [PATCH v7 0/8] Rename queue index to queue number

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

