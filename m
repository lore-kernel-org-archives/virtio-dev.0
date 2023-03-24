Return-Path: <virtio-dev-return-11753-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECF1C7619A
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:05:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5E31126DC
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:05:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A756D98658C
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:05:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9B986986495; Fri, 24 Mar 2023 01:05:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7AED498644A;
	Fri, 24 Mar 2023 01:05:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBQA67fqfeyvYxC7LTR+tVMmTw/7fl32kzyHscKyNv4AiQkha2lNWnHBJ05SE4of57hpnXkyFDNmVYSVpS9p1Q+uXBoq542fMDHf9vTCPxu09AuS6/pFygw1kOwBJJYx4/LHhxb5ZpRNTrecSTB0HmzJ4fg0CXiUKuXR0BqhgB3ZH6Ggrzi+PGIW5Mfs8Y0NCrHhpxETtQfQQZkhsucRX36dZqmpe1nbpqvNU7IeLIIPvZoiE6/xpkm2ephzxnP5UenOQmti6RU+bHkJ/E7kJO80t4d5ozje0kpN4DFeSsiKeHF6yII+mLrSCj0nQf6eHJz2kybTozGEoLr62n6rVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6v8FmSbYkYL/03inTbmxdHkYfqWJ+yaYe+rDWrimmM=;
 b=llOfsQhEg4/DxWw3bvmtSlr8ow17zAWaFeciDl6Csy8bjmaNVw6dnC82bBCj5FoICQXJFLXCARCTY9Q5Y3Q7jy0Yx3kbScjsrYvRIMi9HITI8TpEZpBUy3zTFMft7cjDi3bELScwTNHUwy1glgsrxk4f/KllMWWTC4E9ankQDqeVcMVyMdPIgwOuapeyZARRE9F8c7LOss77DQ1RqsdeLuQWiY5S7skN0dgYUj4Dhg0oIOLtEAr5sUZI+0zm+ZWpu/+N7AFsRCiOB7XvCeYqsBwLPyfM9iRyRUAEpC0Ede2sGA9cxNmv2dmgaQVZYRuWo4lNDmsyIQLFNpjM9K0D1A==
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
Date: Fri, 24 Mar 2023 04:04:24 +0300
Message-ID: <20230324010432.280330-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|BY5PR12MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a26336c-14dd-4945-a040-08db2c03c972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3GPkXvExKr1d5x8ncgyyZThAIpTYe7cW7hEBZ/5uOAbOv0xY5k2CLvMtQNu3LPaOKndstNw5QKvi2LPHgZcUmnZY/FAzEzzTCs61wTqYPlj57yIUCVqtuWijRtYZTGLnyHjOoghO/xPCSrNDM2qZ1/dN9Aq87HdcQr3ulE0q7us3oVcIo64G1/UxUGYU88yKAnUswYx5DWNOhhKC/IW+Cj/PLw8dHZdSX3/rw4EaWlbfBI+oz1Q6SC+zH7TzuusRa4ve8IHbE17l4rpTwJBARtE8WALDVGgyxfknonvPAcLuDKpK+8+OZ6lmOkLmu3Yqch8pwMuBK0rgY9RXlBReNhypkCk7swGypJeL4lIBqluizoyVepmbv5JTiGLJIxtIHD74JUPKOoUJnbYzHe28513qLpVDyPgGoY+TwpfFWXIGO37QkAt/rtOcnLMlZVwK1rkZpXImLSTgqJSiNnNR5BF0lzMPOIysiuXBjfVJarr7ZKOPJ3kJXBeC5JKauOb7xMMGdFoPNpqfa/mxVm+Bk2XASpoW8RaRFfyi1z0kBOw9ynvpI21bhsSbAHR3DbpJ86MT4Y8gk6rWut+InxoH0RElxOvAx9F52bljtDiDnqcQeX7cFfDgjBNht61yJKmBwdkvU4cmYTuEBpEUOYE0jK2HXg5JM+JFaWMvj+0ZSw0h6mwtV8Za51bocnH5ucswlA4cQCO0ChtPD+P1aA8JlftMfn+U4a4vyUfeYaCUqp1YnG1H0brczem/c7kQkQ3dUDzehRcMAkCSAfG/uSX8LA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199018)(46966006)(36840700001)(966005)(4326008)(5660300002)(8676002)(41300700001)(8936002)(2906002)(82740400003)(356005)(36860700001)(86362001)(36756003)(7636003)(107886003)(6666004)(316002)(1076003)(70586007)(2616005)(47076005)(70206006)(40480700001)(426003)(82310400005)(110136005)(478600001)(54906003)(26005)(186003)(336012)(16526019)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 01:04:57.7282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a26336c-14dd-4945-a040-08db2c03c972
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321
Subject: [virtio-dev] [PATCH v6 0/8] Rename queue index to queue number

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

