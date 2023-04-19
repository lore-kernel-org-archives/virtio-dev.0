Return-Path: <virtio-dev-return-12290-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E401FC6FD18
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0DE276034C
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2405986665
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:47:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C2CAF98650A; Wed, 19 Apr 2023 01:47:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2F323986623;
	Wed, 19 Apr 2023 01:47:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBPpxnVkKmrmsaahIR7PBGGf6m1skMkK4NfDHfM99j0+6fWDf4SXJoqczpfcecN+OkbzSS/aUE35dWutezLqe1jpzKriiGlnzczk8Ezd6C1iN3PadG40w6QmBt7VWvdX9e9eyIl7Rg2bVbaT4N43lf8WGWQMMD6kunBVJ+zycYxT3o7MPNvxNdS+DIGtqa7li2UFJI+6Jv8g1NvdESW4TTKOvmIpYi6klQJnoL5Ga1T7Y44l+vzAuIZD9MmHzfPS9oqfPcj4faJFaqis6gvkP/NRCkwQNLjD01q0uN7YWCjFsZCI993c4cHDxODTilT7GrK2yekmOD+TsrDGVxWK+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLcQAH2YkHOOoAW+39/ehgm8NFK/LhAvOosBHRpYjaQ=;
 b=Rh5vGCqc5RYLzIfpuHAAaNnWAOOyff8Nw+4FCe7lWH5AS8e9JNpjt01BE1xITQGvJ7juuJaB2X8BrACEGz+zlp+aHMnGKViAWjv1FrUv/RIoOhRmSvzlOnmWvgkH017Mpf5rOXFnVs0Dn/DHbD7fA1sSvhQpMQ1/16z46OAU9PzOJgUrP3zfC2fuHQuS1TE9YKhDusWQ/AbUrb3kG9QM1XEM40WWMY9S/rVGzYgUHjViLZ4zuSWwbMiRQpbmCkPjf08NdhwunBAnpdGEE31YZNqmqC1fOTzMOsWwmFl28Y8IaUjjvSH6F2gtNIrrz2D/CWmxRbi4tk5o1ZCDzVuwiQ==
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
	<virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Wed, 19 Apr 2023 04:46:28 +0300
Message-ID: <20230419014639.919458-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B9:EE_|PH0PR12MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d4d2c9b-7519-4214-2eaa-08db4077fbfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TAToAi2aviOSCCAySY4rrtz+KGgn4W6cvaCtH+QbuSJVqS4UARbYxKaR2ErrlYfZ2NtVdOf4UR9qOpNvDsPmdF2t/SpYy0xzyxF6wzmFofHtvy/ukfppu8Dni+zB/t2GqXHjLTfh1ErVjPM9K2GGDgFmb2Cjfv6O2uyPJWrd5qzlpB+bfKFwViHi0BxNECrNodvd0uo4eO/aV7UXQUVBM0EFNVJlOHOHz1kRhW9vT2gnBiGlEs8bxDFpM0ESxEpz6z8aInT0ewnQhJZwZL4k7/Q53A79jUpQslmXPg9D+SDLM7WTJXzKqnZsUl0EkKGxBcS/ZDPMulhdHJ2wr7y2u92oilq9eDDjqICG5leQj4THnnJhFfM2I3EVTUddQ5pb3e2WEvcisMThlOWp45ow79ES+eHYgXaU1MMc/DEGzyV0hfXnkFoQRqhcAm+3RgWtGvk1i4WrhunQ5RrsQbuBSlFrQ8ivxP8j5PKDaD/WGtoNzwwJIyA34KXi/Tr+sRAAVTRMBISWw6BCIl4EwaTsdR+L6a12K3McghkC/CKNTs6089+OFVteLtJxwFf/Y17s4XkZu5+ULU7FDPE7Rp2UdrOPXTkrCFyZacw8RmtUAsy+c2M27sKdYODenA8Bo5tbKYLbI1r//l30O4HWa2okzt0kQ7W7HiovVB4uP7VijisMBCgVMfTgiwnFN4x/FrZWyf4P2oid7Q6MLqFTK08ooTqIaA/c5Qsf3GKJQQ4sTQo7/U/1lbL1+DhRFZBii6lQhxnTEcemKThhX8digASRgzl5mOeSolLjR30e9l4IFms=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(8676002)(40480700001)(36860700001)(336012)(83380400001)(47076005)(426003)(110136005)(1076003)(966005)(16526019)(478600001)(54906003)(2616005)(186003)(26005)(107886003)(82740400003)(82310400005)(5660300002)(36756003)(316002)(7636003)(4326008)(70586007)(70206006)(356005)(41300700001)(8936002)(86362001)(2906002)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 01:47:07.3788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4d2c9b-7519-4214-2eaa-08db4077fbfa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF000145B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647
Subject: [virtio-dev] [PATCH v14 00/11] Rename queue number to queue index

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

 content.tex                      | 20 ++++++---
 device-types/net/description.tex | 53 ++++++++++++++---------
 notifications-be.c               |  2 +-
 notifications-le.c               |  2 +-
 notifications-pci-le.c           |  8 ++++
 transport-ccw.tex                | 15 ++++---
 transport-mmio.tex               | 55 ++++++++++++++----------
 transport-pci.tex                | 74 +++++++++++++++++++++++---------
 8 files changed, 151 insertions(+), 78 deletions(-)
 create mode 100644 notifications-pci-le.c

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

