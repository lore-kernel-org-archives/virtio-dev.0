Return-Path: <virtio-dev-return-13225-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCDDEB64DD
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 23:38:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F252816DDBF
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 23:37:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E847798680C
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 23:37:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DBF5498408C; Tue,  4 Jul 2023 23:37:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A83198672E;
	Tue,  4 Jul 2023 23:37:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClTTEGl+xsus8kLHtvcZSUyqDomTtSB+FqAdwwCeXzfSn5dwKcETgGHgNYX8FqguxufOg8lPefEsvfVnY6rcvqSqW45VNKEKBcP3x6fkV0YB/2wjXovQESXfWDsx390ct88PRfNRuAUUFEIusPSYGmFDhbYFrrYMUID1Kf6WB23jPpgvE2FT6eLezJJpI3SKJy2MDIRtm+o3nv2fKmyJ3EnG4bzK6MkqzhnnCA+16ODjRJumyY5T34o/1Myi26d+yNjSmtr9W19Ke024OqrTPsX8kumgid+Ztw9pbFRb1SYm3G4eYnjaRcUgN/066312M2PFDvmhyZQa4z5n20nX2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CwQBMasEyFihJDAuhVi4a5JW0SfTCulbq7vjQF1eJQ=;
 b=ctD10TZpn3CkIcugvlgiwpQP4X2IMxxfZzjA0rdjfq8gqr/wSflsk/qrNUAM3NvgF6lVLn44k2asN9h/CVxX99XcS+dB5NjFtiBklPnZwDR0bBda68+aCrtLN8E7Pw2zC/vBOePulfgygn9yOQRahsnrt5sDSk90GoLdjS6K4SbbQT1Ggmi1QfKsdlu7kZ6Fae236ixJNCCssk4RtaVqiyW1GnNMNokU70IL8cGvT52nM/VFA4nFUGRPwFkw2N4mGgVChibAEJcK09NkIJY/RM5eLDaR3sbZ4aQDcT0cwHimBv/d7GcgWjznGzBWk2HdfzOUgAeANSlKfQySK0yV5A==
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
Date: Wed, 5 Jul 2023 02:37:20 +0300
Message-ID: <20230704233724.22394-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT036:EE_|BL0PR12MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: cb58d5ae-fb2c-4cfe-7d23-08db7ce7ad9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5FlgI9V/Kijj1h8X6Ea1LHf6G7HPIfNI377RVO7HLzLUQble9ULwm/1/PO3YUZbqo0ItsLEX5dKQDuyjzZj4+V+96Z0x5vrZGCn4WxsxNFUHFvDnWiKX5WXPehRSZxnRnC/vLxWZBNK/jAJXAw2ptfwgvfeFwLEms+GP5UdQP9M7ovYjdCNoq/jN4Cf3NDzpU5eu7faKdDe6+nHevpFBDbtcyfIzkQ/o3TR/8Q2/kEDqbcRHFGtsIQ9McZ0Z0vy0PFUwcBq1LiCCwITdAjepJQnrN2wW+pCQ6LXYZcp51/L+vpt2C+CPrhpO7H4MqmBIgf6zURkx+J9uJPsXC7kSst9vJuWVxmuGz/DU7WfPwBHO1M79YtPuT5aleBVVunEjbzReHNn6zk7uF31MzPa26l9R/7LS0PhEDTh9AZJw+XD14wF8C1sCCheO6Ol+O713A5IG8/aAtbmDsmTZLxHIikp/sNrtgTjFsc56O6DJJ+YUHWN0hI37o32cMOzQlI/53afHYPgScKLdBx0tUdGYL9XJOg+JNNDvHbcgrOfY9EX+X3fqFdl849W+UjsW96b/sgDsGTjEt3PDQ9QgcQiWbKgQCeyxYXemS4TeUWSkpNI95gpOgt8bReGy19QZ7OsU9/mbjEq0BUn9z/chPAdN7POAZzjqi1O4IZKM5t/+2cRMGG1Wr2KpuDQVXGb1WWPWWGzz4qDHnXy7u2RIGrqUbdbciM1G6gnNA+OT2xDMv/fM9CVm88A5P+0kiDTGlyyV
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39850400004)(451199021)(46966006)(36840700001)(478600001)(6666004)(70586007)(110136005)(54906003)(70206006)(1076003)(26005)(16526019)(186003)(107886003)(966005)(2906002)(30864003)(82310400005)(41300700001)(316002)(4326008)(5660300002)(8936002)(8676002)(7636003)(356005)(82740400003)(86362001)(36756003)(47076005)(36860700001)(83380400001)(2616005)(426003)(336012)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 23:37:49.3223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb58d5ae-fb2c-4cfe-7d23-08db7ce7ad9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4996
Subject: [virtio-dev] [PATCH v9 0/4] admin: Access legacy registers using admin commands

This short series introduces legacy registers access commands for the owner
group member access the legacy registers of the member VFs.
This short series introduces legacy region access commands by the group owner
device for its member devices.
Currently it is applicable to the PCI PF and VF devices. If in future any
SIOV devices to support legacy registers, they can be easily supported using
same commands by using the group member identifiers of the future SIOV devices.

More details as overview, motivation, use case are further described
below.

Patch summary:
--------------
patch-1 split rows of admin opcode tables by a line
patch-2 fix section numbering
patch-3 add generic legacy region access commands
patch-4 add pci specific definition

It uses the newly introduced administration command facility with 4 new
commands and a new optional command to query the legacy notification region.

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
   Legacy region            Driver notification
    access                       |
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

4. F_LEACY_HDR, F_WRITE_MAC
Cons:
a. Requires device support to have read/write mac address which is
   hard to implement on every member device.
b. such functionality is duplicate of existing cvq per device.
c. config space is only for the initialization specific purpose.
d. Requires mediation of 1.x objects, which is not good design.
e. Solves only for the net device.
Pros:
a. May work for nested env

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
v8->v9:
- add missing articles in notify query command
- replaced 'this notification' with 'such a notification'
- addressed below comments from Michael
- dropped 'Region' from the commands
- added 7 reserved pad bytes in config write commands
- rewrote from 'use following structure' to 'field' has the following
  struct..
- dropped mentioning to follow struct virtio_admin_cmd.
- added note about command limited to only sriov group type for now
- rewrote the description little differently
v7->v8:
- remove empty line at the end of file
- removed white space at the end
- addressed comments from Michael add link to pci
- renamed region to region_data
- made region_data width to be 16 bytes to cover for 8 bytes offset
- moved generic notification region related normative from pci to
  generic section
- addressed comments from Michael
- made bar offset 64-bit
- prefix legacy specific structure with _legacy
- moved generic normative from pci to generic section
- added link to virtio pci capabilities when referring to bar 0
- remove 'should' from generic description
v6->v7:
- addressed several comments from Michael
- use AQ command to query legacy notify region, dropped pci capability
  modifications
- moved most part of the text to the generic admin command section
- replace administrative to administration
- replace admin vq citation to admin commands
- added normatives for device and driver side
- made BAR0 to be not used at all when supporting legacy interface
- added normative around BAR0 and SR-IOV extended capability
- grammar corrections
v5->v6:
- fixed previous missed abbreviation of LCC and LD
- added text for the PCI capability for the group member device
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

 admin-cmds-legacy-interface.tex | 205 ++++++++++++++++++++++++++++++++
 admin.tex                       |  20 +++-
 conformance.tex                 |   3 +
 transport-pci-legacy-regs.tex   |  41 +++++++
 transport-pci.tex               |   2 +
 5 files changed, 268 insertions(+), 3 deletions(-)
 create mode 100644 admin-cmds-legacy-interface.tex
 create mode 100644 transport-pci-legacy-regs.tex

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

