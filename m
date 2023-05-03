Return-Path: <virtio-dev-return-12500-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98E5C77B7F
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 03:27:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4D12741EE9
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 03:27:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 363919866D9
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 03:27:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0C4419864EB; Wed,  3 May 2023 03:27:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA2FC9864C5;
	Wed,  3 May 2023 03:27:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2sDL2nGMfOSdVw9NoMYXIy3MVPTO5TZBIpd+DifWLCr6g7Op1ENwhkAUFnWcuku1IRsHCxk7+V1rbmH4De2TZVa8AAP1OBQ1yb34h7Q01bQI/3hnRfvD2ipuKFec4IHPESREYGGRcgZqkzeVF4X+TjdLvsRpT0XRobANiwgGdF6WkhggRUS2zRLXsHyz9EgtIgA6knLs+WlqqGLQ9mkrDKXSPz8X2xTcgGgNjcx4jF4VXLvsC67/vn+U/JjHPAcd6D+Kpx7ofGsd/3SPdGlEULCZQBpfNNbt6l5UU2yImiWVYT1Z0s1R1czHwebuwNDgmAMm+/eSZCC2gC5T8Sihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oXnfDueqr40aHNxjk9w5+uvyfjql8KLTZ7FvMd06uE=;
 b=crgdpIGua+ulG9cz4qb+7/xDEUi3XVV+DhgYEsOXn9/i7GGFwWBvLBRHSR+kupHR6VJ+GJcuQ8m901e6/L+6IG4vAq3MRA3ia9f/QVB8DAkMkaNsuaqLgDXGcJhPfmmb0tGzwAhWjtjFZCAxFInA8/zS0Ycs47ANe0OgvVUsfpyo+ntsPNuDmiI3flYZjnfoq64Eku+i4NmhkPVEkrdpPMa0+UuO58gxjdPEerg58w75dm/Nzi7+c+DFeTJdNPWlwxMgiF2qbqXzAW8QZwGh7uTAzKAtRyYWd6nuebUEZVttYuPi+hM9cOUcrUpLMynME/EpJUOJQodtYCuMYYdv5A==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>,
	<david.edmondson@oracle.com>
CC: <sburla@marvell.com>, <jasowang@redhat.com>,
	<virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Wed, 3 May 2023 06:26:57 +0300
Message-ID: <20230503032659.530330-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT061:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8cdeb8-d19f-4edb-930d-08db4b8655aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s0LGcihF31fv04HksoJgj4u4KRcmr01MxKeuR6txEj6oTU0v9f4GSlKDglCZBSAo9QXEY3A62DyGlixQpo5cmXyV/Neb51m3fgr/RkF8dGR8uUofwAKAaYH4OQJROXHDisfZQAnfjdIwmTAUrhCFT7SFJ2Q+Fcl1PFboA11Wwig4+eMLXXp3b5K0nCM2eXMg3I8O71FLN2jhon9DSmSw7VSpxJMBmqUzhhL6R3xCneFqajJNc9NXFRGIvYuoBD1ZIWY353eIz2PoYar/lJDtkMsIcN8sKtx3oL5h0fODMd8+7o54NWy/Xae5tD952HPHSHWY2p1Go4xOgYdkJo//THKQESUOLOu5MSQv/mD4OO/WQ1yALSyGUW4W5kwePuM2C9+W5QiWxuYqI7N4ySZb2hU4e0mgK3WSwXQVfbs7AksRqkcy9gQxVJw5tToWFpD91rHpNEsfoLSV6mogNxFImo66lXYXIkD0Cs5PMr6D3rY/efLtvlOmlyPIzaSXBLwtJ4HiUKGw4ZY/IlCz1XZOQCdUNMoy0kMEdMGWc19JrkTOYC7Qox3R8kND6WQeDRael/GKJVsk/IRkt1qQ3UOi/hWwHAwYbdC2TjTA2e4RIWVyezhgPlyK1FiTqCS9Jqts/llrJDBkoWr2MnciNvtaz54Tx1ChTSrqsDyAwH/qe2gP7wVkwo5/Id9WuS4rGHiNUWAcIHI1EhY4Ea5j5eIynK1PaRaGxT+pJqnPVKcFKfk+CGUEHwumaNS1hTlPOqccKOKCs6ZOSpnZ+p91bGZWcJKConO+7m0eTlxJ5WOVi8o=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(82310400005)(316002)(1076003)(26005)(336012)(47076005)(36860700001)(41300700001)(83380400001)(4326008)(54906003)(426003)(110136005)(186003)(2616005)(70586007)(70206006)(966005)(6666004)(82740400003)(36756003)(356005)(7636003)(107886003)(2906002)(86362001)(5660300002)(8936002)(8676002)(16526019)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 03:27:33.6437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8cdeb8-d19f-4edb-930d-08db4b8655aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330
Subject: [virtio-dev] [PATCH v1 0/2] transport-pci: Introduce legacy registers access using AQ

This patch introduces legacy registers access commands for the owner
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

This short series is on top of [1].
It uses the newly introduced administrative virtqueue facility with 3 new
opcodes and uses the existing virtio_admin_cmd.

It is expected to go another rebase once v13 for [1] is rolled out and merged.

[1] https://lore.kernel.org/virtio-comment/cover.1682354275.git.mst@redhat.com/T/#t

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

Above usecase requirements can be solved by PCI PF group owner enabling
the access to its group member PCI VFs legacy registers using an admin
virtqueue of the group owner PCI PF.

Software usage example:
-----------------------
The most common way to use and map to the guest VM is by
using vfio driver framework in Linux kernel.

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

 admin.tex                 |   5 +-
 conformance.tex           |   2 +
 transport-pci-vf-regs.tex | 115 ++++++++++++++++++++++++++++++++++++++
 transport-pci.tex         |   2 +
 4 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 transport-pci-vf-regs.tex

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

