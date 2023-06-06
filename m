Return-Path: <virtio-dev-return-12870-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72133C83003
	for <virtio-dev@archiver.kernel.org>; Tue,  6 Jun 2023 20:15:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8EDAF16DDB5
	for <virtio-dev@archiver.kernel.org>; Tue,  6 Jun 2023 20:15:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8310B986588
	for <virtio-dev@archiver.kernel.org>; Tue,  6 Jun 2023 20:15:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6C1D7983BBE; Tue,  6 Jun 2023 20:15:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 52D96986572;
	Tue,  6 Jun 2023 20:15:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejZCFR/bseWNeX9t5JjYzQLG9vMsj3zd21HqJKgb6bUpJdWvgdlPoVmL/OdtXFOPLlC7uBIu072ivQDjhN6WKdJtFSOU7BYd2c/q7b04jcUqbSUx7XPHMO1Ma/UgdhCI+NceXH96QBN1QWfZwVat98oU0InrirSAoYd9wQUSCspNVfJcQjumquPUWFokiaXCXd36iFryoLbR6NxX81ufKlMhG9DdLAuCwXTpO9fXbgkz/aG1Eo/KsSTUnoCAuO+nDx435YHOYOuJEGg9/r8BJEqXWeA0T5r1t2ummyqyyCtrYWY/VY41rX9lRVzB0mAXriTVwl6E24GcB/pc/vKxXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRNBfGbjbQYo47V0Z6LUL5ELRMSOL+bCIt/QZk7NuBs=;
 b=DhH9e+YCqGOCSzK0N4Rfh8HEtkJeVtwR0yPL3qagc3RtIB22UxuTtSe2UBXiguE5jazBn2EzEaVk0H9tKAcVaIfsgkS3UNuwsrpRdbK/BVihu2ZGy2bwPHpdj+ljKbKrC/Bvsk9ui6+LzxWW0dQumLAVk+rDAArAAG2VmlJ4K6Q7tTiJDZsLZI7fkpn8zABVwT6eL689qz4VrryqjeZEdOrTs8oX4dFFkDb70NnKmGQ1mkFdg/MSaKKE9h6SZLI9sQZBe3QC0BynWy6NlPEaeSJ9jiNItjqh9Ys4WhBzLLWyRYIqtN9BGH1RvK9mVUSs8+RiQMuSM4MLuIgHku63GQ==
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
Date: Tue, 6 Jun 2023 23:15:12 +0300
Message-ID: <20230606201515.775121-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|CYYPR12MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd784a0-4d9e-4340-9d05-08db66cacd03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ovJzAHFIUv/svJulpcxFS8Mcaq9KuOGkbMp2hA27C6dkx0sH2l8QwG2e8g4vuYu1gup5JZcekI2UoBH+fEc0OqoP/gRpJ24GzGtJco1KNJrH2BTdcIqlSGPTKiikcmo8XzPXzz/JBY5xL6Sot8qAZo1I+OkAuQ0gVEIl/t/4Zk2k6APzm9Ybp9G4EZyUIkBVJ/uvrYV4c1fKOw4XkAoJJir6AaRjrpVArC4HfWoCW/ZiKihUL/FZKZzSYPmgUGc7zlvkpiSXMSBewfsv8J/o7psXOHGbDBVBmhCdyVSV9lsQrT22L1bloDOcEr9PkttRLGQQgjTuBim+/ZVPAdtdXqw2LzXYBaaVqMRWEPpVGFcBw0lP/R8b5jgeoW23BYrcz9UfUIG7WQxPDRxjla33mbtLz2WTyvbJJgZrswKmS9Y0W4kT72yCrQHsJKYm8y3zsP1v9Yxs4WQSeMSGVMRS5RSq8Ursa1Ujo3ZW4AVwzZv/RhmG1n+ScyfkrJMcT0zu8DDtdnhH1FjqnJ1Zr7mOwQxWQs3QUkyoEG3X13AuKdRjh5UbNf9pgC8nAqFmgcYkbj3scnH0ChE1qb1voT8weMOsCMRcjxWmdgZBWmRabEMxuT8rSl3kn1J1MtzjmCVpKm6EAMqY1lOK5T/yXLkaFQz7PmTd8QFmsV67XvBmpMcoX0xuryrRCduD5k44Os4SIYuB7xqSX5Nr2SO17x0Cb5n3G0KY0GyZZ7CdaoeuL7BAnc2q0eRlamUihbAGZ9JMbKuQIOEiN9VX7JrkEfWSjl5P7H2Bu0p8aleSpUSd6lo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(107886003)(1076003)(2616005)(41300700001)(336012)(426003)(6666004)(36860700001)(26005)(47076005)(16526019)(83380400001)(966005)(186003)(40460700003)(40480700001)(478600001)(110136005)(54906003)(82310400005)(4326008)(7636003)(356005)(82740400003)(70206006)(70586007)(316002)(8676002)(8936002)(86362001)(5660300002)(36756003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 20:15:41.0644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd784a0-4d9e-4340-9d05-08db66cacd03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9014
Subject: [virtio-dev] [PATCH v4 0/3] transport-pci: Introduce legacy registers access using AQ

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
   use it as native device in the host.

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
   saving hardware resources

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
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


Parav Pandit (3):
  admin: Split opcode table rows with a line
  transport-pci: Introduce legacy registers access commands
  transport-pci: Add legacy register access conformance section

 admin.tex                     |  12 ++-
 conformance.tex               |   2 +
 transport-pci-legacy-regs.tex | 155 ++++++++++++++++++++++++++++++++++
 transport-pci.tex             |  19 +++++
 4 files changed, 187 insertions(+), 1 deletion(-)
 create mode 100644 transport-pci-legacy-regs.tex

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

