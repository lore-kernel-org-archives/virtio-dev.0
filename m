Return-Path: <virtio-dev-return-13107-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82910EB64DC
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 21:11:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BC27B7C6AC
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 21:11:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A78F5986677
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 21:11:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 98C72986432; Tue, 27 Jun 2023 21:11:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6FF0998642A;
	Tue, 27 Jun 2023 21:11:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LivsU+VvlRWtFM64V4z36wGIVVP2JRbo4uvw+DrZQ51XhjPKrscFFjCtbuN2RKdpZ9+UvkSnkUVBh9M9HNbAxIUGZUQGAVUnthkJNHZIYE4qyEE5FJMczCr69CytJ1e6NLtSqctUjrgvyr+UxApOjIDQQQ9kICfelVKLSTPEUbFRu1DeB6No3uxz4Nq4AL6EbcXtT85OwjECVy/KUJH/DRjZxpTLY1ukpCzXEng1RJqtV61BsdSjE8XfPkmuXmWwBtbHrzWkdtfbWMdz4e+s0bItJzIrJEJfT+L6PBs9g1lT48q6lYOwLSPlefwLFuiRtCNdkUo6v9+k1OcOb7v4LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBKqcNf5dX07QfGeKH8UT+hTbsggIWAj4SJuA2BLneY=;
 b=ZmHSOqfFzsY0sJBMURDgmHQ7V9Kg25C7DJZWG7OtgAbaXuYhQpx0uUt5Cf6NQy7lCYUXFpnlShysdq9v4V0bYpf0eWi7bUrc1rd69XTDzIN9j4LCh6CTiFsmx7AubOvcpXqb2qbyyzW1EZXVVErrpDENtWweu77WPCTPN8U7oAVbPDFV6zH3DHFMt1cS/2qWTtRBz6f3akgBnuGzpzMVvUY8TJWLkWKxfwIzyQWJLb/NSKP4l6C4VhRXhTa6OiDRecbNDBEjWk3K3iEzGRgi4awo0+XNIDXSELn19Fa4BwZYmeI6ezHHRYl5vq8fkCFhqgDjzOSQs9fElU7NcMqh9Q==
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
Date: Wed, 28 Jun 2023 00:10:46 +0300
Message-ID: <20230627211050.1527507-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT072:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e0fd46-80d6-4c7b-8f52-08db77530b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bPVjIJIVjE6xBYsv05CkmD338ekhcIsqOF9vzEoRm8JadiF8XUbI3FO5zEjpRGH+tlNPR2cX/DUUitZRvW8DcagtTXSXxOH44ST10PJAL80sekKMTJx3GfEd2qrJa6B9pckzFkdeofSsjIqWY0XWC6uoJQTjHnlwJc0Mzx0Ehs2G3p1iHLJujB0P15LBzUFbvFISda+/7SOGaInNhP7+YpvrZH7f0ykV3ekSNnZdJhDIhwJwAK+LQVIr2Od1wSBXExdjN1EkGdWGdfdcjxSdj9DDtjIj/dYlLZUrRLmZDY7AImaFCcbylcGxBm9FsVAXnDCGWzmTVjh/ML394u+XhhbFFqiNgS2EMHtxD/0rjGkaKdVQBSTqJD8Tv64a1GFcRy5y8BbjsiG/WqptstIiZnM+ooF3W0rATrwISmJSBqfr3q3o07m5b/LTxFgMbsECa0yqJL9OhAqazl3dny7D5nRXOogy6n0sYkottjLaC6ceMQES/9fB3ab1wCRsQq1kgt82utajrn43D0v+prKaz6ZeEeChMHzsawMCX1ZXtwD83L0ydgUkHi2wX706lR55FotiBFUMCdFB7RrWYXPgkglaf8l90SHsZI/Rma7Mp/+DJSaEJUoBWepHcI2XNh3FywtwRbeSPJo770TW8NK8Y3PfODev9e9QAyeMgLz5dV6C5Us43cfEPxh8UvEa92NdGGy9EYiQX0Mf8dLdeNRq1NlFdez5An6WbJp9sBvhWqL5pXwZvBJ5pQkPyRpjxm+wd7r07n3ZDaQfcHn55uk//yWc6aicVoLKBReIQEYw99g=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(16526019)(26005)(82310400005)(36756003)(36860700001)(107886003)(47076005)(966005)(478600001)(54906003)(2906002)(426003)(2616005)(110136005)(6666004)(83380400001)(336012)(186003)(1076003)(5660300002)(70206006)(356005)(82740400003)(316002)(7636003)(8676002)(70586007)(41300700001)(8936002)(40480700001)(4326008)(40460700003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 21:11:15.7904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e0fd46-80d6-4c7b-8f52-08db77530b59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638
Subject: [virtio-dev] [PATCH v7 0/4] admin: Introduce legacy registers access using AQ

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

Iadministation t uses the newly introduced administration command facility with 4 new
commands which uses the existing virtio_admin_cmd and a new command to
query the legacy notification region.

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

 admin-cmds-legacy-interface.tex | 204 ++++++++++++++++++++++++++++++++
 admin.tex                       |  20 +++-
 conformance.tex                 |   3 +
 transport-pci-legacy-regs.tex   |  43 +++++++
 transport-pci.tex               |   2 +
 5 files changed, 269 insertions(+), 3 deletions(-)
 create mode 100644 admin-cmds-legacy-interface.tex
 create mode 100644 transport-pci-legacy-regs.tex

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

