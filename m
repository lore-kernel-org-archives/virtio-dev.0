Return-Path: <virtio-dev-return-12908-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CD6C7EE29
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:04:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 19CAFF3F74
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:03:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 090C09866AC
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:03:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F0A249842E9; Fri,  9 Jun 2023 02:03:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3E20D9867FE;
	Fri,  9 Jun 2023 02:03:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLg17Ab/VyAVhflcDiDFCEHBzFxN/BNLleda0Z52uzYhHA2bsOmslOzocfi0nuGhNwO5kEv42S3kF5P1Pb86NH8oTk6o6WGiqD2Kyrwe8DfXoAyX1xrl50mzt1fW3uqjm9HGOD+UGyWtQf+BpoVf1+Y234cfhZQfDJ/ejOioW/qFrNXCQemDx5Sryyza/xFBpNdxqgnS5dEogIrE3tdcWgXvMEUECdqc0IqxlmnLk6PvyCFSUQY5OyFv1yqFmeg4N8WGCBdHP6UBZE0UUBA6MjrYqE7LbxDiMirYM+ioViQVGQ4/Z4obaV9IDj4CN5D7hlnDJ3W997k6Es7xnRJE5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tooFxEuW5mDjUNAOkHleas4ph3Os2bXPcejNooqx68g=;
 b=lx4CbcaZEOvrVI2bM3tri98J9UX9StsWSqMQ7DB2+DlADx2e1yKpJQjJlh4nvKtLL9t7oOleq2g/0Cq44vZXZXRsgrqchg18fnKBZrxeKLpgf9OVvo6cucdl3obsH0VxIaiDGvwH+ZhQpAC4EAMaEMGtdiRI2JcKc5RURM6eL7sDf73rMP+lT6HiUMhFoU20agKDRAC5E7g9mUegR7uvjMuKLVXkV1Ds0XUddw7lXqs6k7uJPq9BtDyEgZawF0Gln1XmH6Ms/s+Oyj1tdmQbo53EEZtRjQQX4S5t8DStDFHoLa0RQYsNHvOZ4zujhEb739SZsxCQRvqqVc2Ls0R1yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.oasis-open.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <virtio-comment@lists.oasis-open.org>, <mst@redhat.com>,
	<cohuck@redhat.com>, <david.edmondson@oracle.com>
CC: <virtio-dev@lists.oasis-open.org>, <sburla@marvell.com>,
	<jasowang@redhat.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Fri, 9 Jun 2023 05:02:44 +0300
Message-ID: <20230609020248.869700-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d15acbb-e57b-431c-6e89-08db688db3f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yfSaG9lQJZ6BEYdfk5j2X+4BFId7piesjMemgX5qB1YTg8dExcsI1Wb1y+2szWFKwZr2BKBJf82lQ3jAqJr0T0igVmVMtTc+z8mgF0xdthIELL33Ci5Yz8O8/St+9qvjghSdQOxuy7EKCAWbLXFNysuP0lDwH0mO79CL+txtYHYOEQ4ybpYXSLjdGVor0nRqogruVjqPz6ALx6IgmLN7cQXlFF74fJBjpzmTZ+Pc9LqZrJuRT6PVsQu4P2zLFFP8hrWxJvyciH532laFyXjyk5zrDlpZEBbmZaLykZwxHa75C7XU7Raq/RIoPZl9K76ZrsVwsSikC1db/RbBlF21HdvcdRFI62XFrdx4XfhYGT6L7ePU59eKowN58RL+Vu3CH3CtdDoY0Yy78Q02u22l8wS9KW9C3+sQG19U29/00nfz2FRl3vLtjtBo8Xb8jQV2DXRXDmsXnWBIQw0XIRDkShaPxM601jum7b3utQUpLEf6ztua34SnbWrKI58DHPCoiIM+CciJa7VPfRBRwWtOByNbIGhZZtbEyu1HlJctajOeGMAZe+4tauJYZXYnlZn4SuFt9KfJ9OvPgIkcfWhvZccUTjK3iidHY/RQ7R4NhdChgEny2HP945kd3BCcUJkx2NDklKWDIXqW2JAeCD1IoDPtBdbycVgn/8H4W2FekQeoRKVDgWH2Uyw/QtCprGsRwAAN2lMxI8IQnlcTz1QQ4an/7/D70HyRjdErlWi0GjuzCxPpI/AujC4zg8wutaLlVilpd1vQoaNWQG7UljIN2Phb8jP54jKjTByUHYCKLiM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(2906002)(36756003)(4326008)(70586007)(70206006)(6666004)(41300700001)(966005)(107886003)(478600001)(40460700003)(40480700001)(26005)(1076003)(186003)(16526019)(316002)(336012)(2616005)(5660300002)(82310400005)(426003)(36860700001)(86362001)(7636003)(82740400003)(47076005)(356005)(83380400001)(8676002)(54906003)(8936002)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 02:03:22.0050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d15acbb-e57b-431c-6e89-08db688db3f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491
Subject: [virtio-dev] [PATCH v5 0/4] admin: Introduce legacy registers access using AQ

This short series introduces legacy registers access commands for the owner
group member PCI PF to access the legacy registers of the member VFs.

If in future any SIOV devices to support legacy registers, they
can be easily supported using same commands by using the group
member identifiers of the future SIOV devices.

More details as overview, motivation, use case are further described
below.

Patch summary:
--------------
patch-1 split rows of admin opcode tables by a line
patch-2 adds administrative virtuqueue commands
patch-3 adds its conformance section and links

It uses the newly introduced administrative virtqueue facility with 4 new
commands which uses the existing virtio_admin_cmd.

Usecase:
--------
1. A hypervisor/system needs to provide transitional
   virtio devices to the guest VM at scale of thousands,
   typically, one to eight devices per VM.

2. A hypervisor/system needs to provide such devices using a
   vendor agnostic driver in the hypervisor system.

3. A hypervisor system prefers to have single stack regardless of
   virtio device type (net/blk) and be future compatible with a
   single vfio stack using SR-IOV or other scalable device
   virtualization technology to map PCI devices to the guest VM.
   (as transitional or otherwise)

Motivation/Background:
----------------------
The existing virtio transitional PCI device is missing support for
PCI SR-IOV based devices. Currently it does not work beyond
PCI PF, or as software emulated device in reality. Currently it
has below cited system level limitations:

[a] PCIe spec citation:
VFs do not support I/O Space and thus VF BARs shall not indicate I/O Space.

[b] cpu arch citiation:
Intel 64 and IA-32 Architectures Software Developer’s Manual:
The processor’s I/O address space is separate and distinct from
the physical-memory address space. The I/O address space consists
of 64K individually addressable 8-bit I/O ports, numbered 0 through FFFFH.

[c] PCIe spec citation:
If a bridge implements an I/O address range,...I/O address range will be
aligned to a 4 KB boundary.

Overview:
---------
Above usecase requirements is solved by PCI PF group owner accessing
its group member PCI VFs legacy registers using an admin virtqueue of
the group owner PCI PF.

Two new admin virtqueue commands are added which read/write PCI VF
registers.

Software usage example:
-----------------------
One way to use and map to the guest VM is by using vfio driver
framework in Linux kernel.

                +----------------------+
                |pci_dev_id = 0x100X   |
+---------------|pci_rev_id = 0x0      |-----+
|vfio device    |BAR0 = I/O region     |     |
|               |Other attributes      |     |
|               +----------------------+     |
|                                            |
+   +--------------+     +-----------------+ |
|   |I/O BAR to AQ |     | Other vfio      | |
|   |rd/wr mapper  |     | functionalities | |
|   +--------------+     +-----------------+ |
|                                            |
+------+-------------------------+-----------+
       |                         |
       |                    Driver notification
       |                         |
       |                         |
  +----+------------+       +----+------------+
  | +-----+         |       | PCI VF device A |
  | | AQ  |-------------+---->+-------------+ |
  | +-----+         |   |   | | legacy regs | |
  | PCI PF device   |   |   | +-------------+ |
  +-----------------+   |   +-----------------+
                        |
                        |   +----+------------+
                        |   | PCI VF device N |
                        +---->+-------------+ |
                            | | legacy regs | |
                            | +-------------+ |
                            +-----------------+

2. Virtio pci driver to bind to the listed device id and
   use it in the host.

3. Use it in a light weight hypervisor to run bare-metal OS.

Please review.

Alternatives considered:
========================
1. Exposing BAR0 as MMIO BAR that follows legacy registers template
Pros:
a. Kind of works with legacy drivers as some of them have used API
   which is agnostic to MMIO vs IOBAR.
b. Does not require hypervisor intervantion
Cons:
a. Device reset is extremely hard to implement in device at scale as
   driver does not wait for device reset completion
b. Device register width related problems persist that hypervisor if
   wishes, it cannot be fixed.

2. Accessing VF registers by tunneling it through new legacy PCI capability
Pros:
a. Self contained, but cannot work with future PCI SIOV devices
Cons:
a. Equally slow as AQ access
b. Still requires new capability for notification access
c. Requires hardware to build low level registers access which is not worth
   for long term future

3. Accessing VF notification region using new PF BAR
Cons:
a. Requires hardware to build new PCI steering logic per PF to forward
   notification from the PF to VF, requires double the amount of logic
   compared to today
b. Requires very large additional PF BAR whose size must be max_Vfs * BAR size.

4. Trapping CVQ, configuration region, LEGACY_HDR
Cons:
a. This does not fullfil the very basic requirement to not trap the
   1.x objects (configuration registers, vqs)
b. Requires feature negotiations mediation in hypervisor software
c. Requires constant device type specific knowledge in hypervisor driver
   (Does not scale for 30+ device types)

conclusion for picking AQ approach:
==================================
1. Overall AQ based access is simpler to implement with combination of
   best from software and device so that legacy registers do not get baked
   in the device hardware
2. AQ allows hypervisor software to intercept legacy registers and make
   corrections if needed
3. Provides trade-off between performance, device complexity vs spec,
   while still maintaining passthrough mode for the VFs with minimal
   hypervisor intercepts only for legacy registers access
4. AQ mechanism is designed for accessing other member devices registers
   as noted in AQ submission, it utilizes the existing infrastructure over
   other alternatives.
5. Uses existing driver notification region similar to legacy notification
   saves hardware resources

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v4->v5:
- split pci transport and generic command section to new patch
- removed multiple references to the VF
- written the description of the command as generic with member
  and group device terminology
- reflected many section names to remove VF
- split from pci transport specific patch
- split conformance to transport and generic sections
- written the description of the command as generic with member
  and group device terminology
- reflected many section names to remove VF
- rename fields from register to region
- avoided abbreviation for legacy, device and config
v3->v4:
- moved noted to the conformance section details in next patch
- removed queue notify address query AQ command on Michael's suggestion,
  though it is fine. Instead replaced with extending virtio_pci_notify_cap
  to indicate that legacy queue notifications can be done on the
  notification location
- fixed spelling errors
- replaced administrative virtqueue to administration virtqueue
- moved legacy interface normative references to legacy conformance
  section
v2->v3:
- added new patch to split raws of admin vq opcode table
- adddressed Jason and Michael's comment to split single register
  access command to common config and device specific commands.
- dropped the suggetion to introduce enable/disable command as
  admin command cap bit already covers it.
- added other alternative design considered and discussed in detail in v0, v1 and v2
v1->v2:
- addressed comments from Michael
- added theory of operation
- grammar corrections
- removed group fields description from individual commands as
  it is already present in generic section
- added endianness normative for legacy device registers region
- renamed the file to drop vf and add legacy prefix
- added overview in commit log
- renamed subsection to reflect command
v0->v1:
- addressed comments, suggesetions and ideas from Michael Tsirkin and Jason Wang
- far more simpler design than MMR access
- removed complexities of MMR device ids
- removed complexities of MMR registers and extended capabilities
- dropped adding new extended capabilities because if if they are
  added, a pci device still needs to have existing capabilities
  in the legacy configuration space and hypervisor driver do not
  need to access them


Parav Pandit (4):
  admin: Split opcode table rows with a line
  admin: Fix section numbering
  admin: Add group member legacy register access commands
  transport-pci: Introduce group legacy group member config region
    access

 admin-cmds-legacy-access.tex  | 136 ++++++++++++++++++++++++++++++++++
 admin.tex                     |  18 ++++-
 conformance.tex               |   5 ++
 transport-pci-legacy-regs.tex |  46 ++++++++++++
 transport-pci.tex             |  19 +++++
 5 files changed, 221 insertions(+), 3 deletions(-)
 create mode 100644 admin-cmds-legacy-access.tex
 create mode 100644 transport-pci-legacy-regs.tex

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

