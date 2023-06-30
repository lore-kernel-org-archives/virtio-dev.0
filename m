Return-Path: <virtio-dev-return-13176-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD03EB64DD
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 04:20:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1587B2CAEC
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 04:20:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0341A98670D
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 04:20:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DF7E09866ED; Fri, 30 Jun 2023 04:20:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C7F38983FEB;
	Fri, 30 Jun 2023 04:20:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlFiP+dfMyjt2ks0DsJWaQ3JY+6eXlkSwrGaG5FO2UxZGCaMC4TKHom31YMJYROz/CdcB10ynlWuaSGQ3Los76AlJRWb/ZsYktggXZdh1mo9qya8MJYR7Mz1cDUetegiUVc/ljjTtWfkSu9CmJkmEhdNN8uIWSM5QoKpb2sxggRdZul3jePPQBiCbbfxULq3hTj5KFlcwZ16Vxg+OXUN/MSc0Hi4eh21+GSFXBhy2f+5Ga0qRJf1MXSkLMObT+VWC3a0mxPapCWLIp9dUYgyNaHsUzQjXroTUkcqx77cioRISevJiuGz9Opy5hz2XKGZh/dOqJ0/bXGoIYi2L5GJLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYoqCbQLxKrafCBQAX/8Yp4o/mhfHr2LBAOTsAlcnjw=;
 b=EndAiaey4sIX6w2rw2cHBHB2rvsNVNZlSjrmpLbpqjtLmXyul0EtC8guFTZZP8uS27+rrSwRPKlOpLU+AQpSuXVahfNW6raDdcLW/JrydPL26cht6M+Ng8+zv232hwYLFOjChUhshenBUwctwog/dGFJav3b+cZdntlnOfZr+e52AJR7yc+MKE+Cs+hBbFOVudoF4n3MLj4HU4ZZUd89Nx0yVz/6Cjbrs3GTU7GJptzzihi1guqhLG3m/mhoT13vscL7Kh/WDE6uhPbmXIyjizL6o6soyMpZuc7hW/iGt4XcRCacFHGVPkJX4QQceRxeeFQTcklhm/dwJtA6OAdMSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.oasis-open.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <virtio-comment@lists.oasis-open.org>, <mst@redhat.com>,
	<cohuck@redhat.com>, <david.edmondson@oracle.com>
CC: <virtio-dev@lists.oasis-open.org>, <sburla@marvell.com>,
	<jasowang@redhat.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Fri, 30 Jun 2023 07:20:02 +0300
Message-ID: <20230630042006.1569920-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: fc38ebc0-aceb-4ca9-df10-08db7921590b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ycyVp/dYGVEFoPDhPdc/Ucen8nD6Sk9AwulyyLj6heL77uFstZWz63BqmvLFNPIlTKffYJXK6Eh6Ue4q20vGf0eWV905uwaAHd7pj2gO59uFaO5nQqpCO4NulO4OIg1HxsBySbY4vmbs7E9sv72GK7IkQDHDkG6hLgc4CiMjJWzEeteYpDfEaKkPZSwrk9q3kglIGN1OQYHrt3Kf3Pin34G/WVG0zIr9vAQZrW9K+K4nGAtxZJ+9q1jlcDB8mDseJZwQfiWjWlyxxa3JUreHwpmm2pZtFsy/uqUxY5foW2jLCLvBOiSnQneREqZAjQIZOdbjqlf+W4IqwA0loCqie9eMrWx+8nrcvVKb1QCZ8T3njIymgOaubHERKM1VqLsp0YEC3hcdg0cv/xXV93PMF0lVxiwYChoJpUQfxdl59s0vV0PG1Rf10dkSSy9vER/jKu1RaBKTkb69R3/iU2uMlJqgJqWD3TWTeaDN1SAPxZHd+XmB2sR5xMc8GunnikcVGgb2xHn7PbtRrRpHPgBI3OtLvdQwLZfakLnsQj8mivelSoj76dIBixa1kCx6TVY4Lvg7RxHULkVDFD05uicjCn6Oo7tWno8FUFxO/mv3OW4J1WCDG4IYpFFMFd9JEWBXP0KvkyndQQIsyS5eLoL00DQ/jc3hff2W8QENjbVSwDVwrQzII/JrqADPhR592bSoeIrmlNbFeqTUpz3ydgU9BNMNSAUCc+cg2uwKBxE7u3lZ7f6CEee3hADeZELgK+1zy/Kb/YXFbUE9yTNSxwbloGHAq3sFAjgUFh0qX5VCHMM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(26005)(82310400005)(4326008)(8936002)(36860700001)(107886003)(36756003)(966005)(110136005)(2616005)(478600001)(1076003)(336012)(54906003)(426003)(2906002)(6666004)(16526019)(83380400001)(186003)(356005)(40460700003)(70206006)(47076005)(82740400003)(7636003)(40480700001)(70586007)(30864003)(5660300002)(86362001)(8676002)(41300700001)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 04:20:33.6482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc38ebc0-aceb-4ca9-df10-08db7921590b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932
Subject: [virtio-dev] [PATCH v8 0/4] admin: Access legacy registers using admin commands

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

 admin-cmds-legacy-interface.tex | 206 ++++++++++++++++++++++++++++++++
 admin.tex                       |  20 +++-
 conformance.tex                 |   3 +
 transport-pci-legacy-regs.tex   |  41 +++++++
 transport-pci.tex               |   2 +
 5 files changed, 269 insertions(+), 3 deletions(-)
 create mode 100644 admin-cmds-legacy-interface.tex
 create mode 100644 transport-pci-legacy-regs.tex

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

