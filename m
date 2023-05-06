Return-Path: <virtio-dev-return-12602-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758BEC77B75
	for <virtio-dev@archiver.kernel.org>; Sat,  6 May 2023 00:02:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D603E1EAF1
	for <virtio-dev@archiver.kernel.org>; Sat,  6 May 2023 00:02:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C579E9866F0
	for <virtio-dev@archiver.kernel.org>; Sat,  6 May 2023 00:02:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BA88F9841A9; Sat,  6 May 2023 00:02:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 977F09866CF;
	Sat,  6 May 2023 00:02:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enTK5JpVzsQYNhrZ3/72D2ai/gIcw5mtjoPVs0x8nOWDONLuJ3S/XctIQ3E3SnbtYsUIUPAdN1KhkW9dq91tpVVRkZdQ5kqq7S/xVXzBlScKn665BONtA7afClskz8WYOZwoypl8C/SHj8VeuQ/MzBUAT8DkQ+Vo7Dq08UQ8pAfJ2ui0tbgTiok7vrUvkxXtjh7Vah73BhqQ4y8ZUjzP3VliGHFQ7g8y4dEeD5UNd7x2gBQnrcbvrN1F9bZ+UmZ0QznsjxyElH7AXzlemni3Jav6OBdXP0ZHmA1UplyNDZeq6FNYrBijI608oMZofTZN52uX3ogogkKNFpl4prf2xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iYyH+rZ8gXRBT+ZRtKbzpHG49JR9k47SwkLRIQ82G0=;
 b=DgPbCaMvZ+81yYhN+Yw3RMgBOgwmDx+nf7QgLBS90RJczx5Jhcj5Vn6brvHsZR86PhAK32rvlzR3u3vVo9v8BHyL6jSogSfCMC56upYysYuEnHr5It+zlhTaYzzWjCi5aK5TMfm+f3p0gtpXK1mLsQ8XPLEfFZi52VF5/F+1DqCe2ic4yVjaWUp+/bjWfb/1WTqkKi1yeLtv2lx2ZwCSvWoObsonMKSiqauFNl1HPsRy+DwP/wCRDQ9Yh4qPbQVtehqqah26oEv2j06wZsKu15Ywrtfj0XJDjPhn4CtZWeGbt/klsE7fQxKFj/WrfA18NNYSwFQlVKgHOaWEK83w5g==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>,
	<david.edmondson@oracle.com>
CC: <sburla@marvell.com>, <jasowang@redhat.com>, <yishaih@nvidia.com>,
	<maorg@nvidia.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Sat, 6 May 2023 03:01:33 +0300
Message-ID: <20230506000135.628899-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|DS0PR12MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d3282b-e260-4174-85b3-08db4dc51d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XV9rQR4py96pgJzDHZyUS1wdUPP1JrVFzTQcBWqlsvQSu5eRBeU28exOu6+gbMpGeViZakIE6kKvWmOg3zMcukBB+I1Wpn5RxsDbB5UM3WJ1XQJeJK+4gJjBiOjdmURaSpw8utnqaMb9umEobwwzTr1ARE79IIkrB7onH/7caKJKlc6ZxbE00N57lHWF8y9lLi2dXQaeU1AnRcr+Z50P7xYaUxZKFdc4a2okthCH82ceJsbzAR9C6/a9NiAug1fXl9aDcu7r3baJeaRQXF7KabAGMeKWRltDT9M981H9q95LBojCZiPdp5MtXh9TqNg0Ndzddq3mycXn65ae6v5nugKyQKKVTrWGXRJAaZHVtpqEg06YhMdmQQ1ogPXiknVNYpVgPGDY+mRWlSu6FMVoMunpoXjH2cYJ31wkv6nl6K/08q1zDipkenwHJy1+BgrzqsVFc8uSqXYcIB1BXpOB2PRNaDYP+WGr6VGSz1s4RGOwHzrJ9yJG3/pGda8LBP2J5bD+SXYNofwY5FcPEKLdXQzQMrPaPBgRdZdbREjY/wkcFMzOxr3bGK+M07D392iONi5OeKqfuoQB3mjokHEBsLqYdnQN5r++ZA0DbHcROJE9gwwThcB65EYYB5jErKaapFzGCM0pfMiAFaqbGbkY4KdgPwr7pFCRXbq30a10obBJVuzmPJ9uR7M7ypxqe2810TCndg6iozTIZ2k516wh7C6/W+onFM+FdtTT4141EaItM/o9TyrzmW3xoU8gNQRI03ubgu/hulWzmRFC2vRXdINkzOhcHo375CrsHoSu+/c=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(5660300002)(966005)(6666004)(83380400001)(36756003)(186003)(36860700001)(47076005)(426003)(40480700001)(2616005)(82310400005)(7636003)(356005)(16526019)(86362001)(336012)(107886003)(40460700003)(82740400003)(26005)(1076003)(54906003)(110136005)(2906002)(316002)(4326008)(8676002)(70206006)(70586007)(8936002)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 00:01:59.9142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d3282b-e260-4174-85b3-08db4dc51d64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8069
Subject: [virtio-dev] [PATCH v2 0/2] transport-pci: Introduce legacy registers access using AQ

This short series introduces legacy registers access commands for the owner
group member PCI PF to access the legacy registers of the member VFs.

If in future any SIOV devices to support legacy registers, they
can be easily supported using same commands by using the group
member identifiers of the future SIOV devices.

More details as overview, motivation, use case are further described
below.

Patch summary:
--------------
patch-1 adds administrative virtuqueue commands
patch-2 adds its conformance section

This short series is on top of latest work [1] from Michael.
It uses the newly introduced administrative virtqueue facility with 3 new
commands which uses the existing virtio_admin_cmd.

[1] https://lists.oasis-open.org/archives/virtio-comment/202305/msg00112.html

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
Above usecase requirements can be solved by PCI PF group owner accessing
its group member PCI VFs legacy registers using an admin virtqueue of
the group owner PCI PF.

Two new admin virtqueue commands are added which read/write PCI VF
registers.

The third command suggested by Jason queries the VF device's driver
notification region.

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

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
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


Parav Pandit (2):
  transport-pci: Introduce legacy registers access commands
  transport-pci: Add legacy register access conformance section

 admin.tex                     |   5 +-
 conformance.tex               |   2 +
 transport-pci-legacy-regs.tex | 133 ++++++++++++++++++++++++++++++++++
 transport-pci.tex             |   2 +
 4 files changed, 141 insertions(+), 1 deletion(-)
 create mode 100644 transport-pci-legacy-regs.tex

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

