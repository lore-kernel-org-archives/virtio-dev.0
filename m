Return-Path: <virtio-dev-return-11863-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A09C7619A
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5ED613DF2D
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 58EC098658E
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4C15298656B; Thu, 30 Mar 2023 22:59:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3909F986563;
	Thu, 30 Mar 2023 22:59:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5+GOaxmhwgS2Z6dI5bkgZDS75K7Ge/lcmkh4QYK+QnFjBk/v2nheFXo6UgU/mbnFaGzIK7MTcM1cFQAvWRlmD5uGEom4oEOJp2g9ragYfU1D/zHR6qZvUNGPXebDJn+Rl/bstbDqx+WXvZr8PH88sYzovH1lRkYgew1y2JoLLXJchKzbWz4quY1KbY5sNGuPcnWcvTbTcqOrWYLDL3VeSuLfybfZeuaNDJT9cA4ijhOey3D3aGA1k1bPoehLg0R5acrnvQHDQ+IeIxNhsnzI4x/FcUsDKpU5V1VUvB3Sja56HLNEz9bEOWaXv+2bR1S57wZ1IC8Sx0UeA76uA0Ijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDHmUVljLgtm8ZwkzV/6Rtvki8EKzLmQJq0rcbu+prk=;
 b=X+g9sBjUPqWEB87hr2lBIYuSmKihqz5Ac5Y+jmsA215gE9tziwA2iApupZprBa3xr3p1sDRzrBhCSrGqSD51dEE2MkSuVe00XfZ6S0qDiG4+RNg48bGnbVxg9fNooWF+PAMGJOxwAImeUKh21/UqDG997H80PXC+6b0dkiA0MiwP6XW20KM4zfgTADvKe+15ti7fvV9uNKbBPqXDqCCkEQ96ygxxlTgh3p+bYzcmTnGMa+4svMfeDJ0skq6Ea8uZU03tEnO0mTbhIFSH+iri4uSGnMLje5AcXfNnBh36GFwWZAhqHaaZNoqV2QLfwizJ5W4T+28jvz4HvW//3sLg5g==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Fri, 31 Mar 2023 01:58:23 +0300
Message-ID: <20230330225834.506969-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 35eca08b-54ba-4bdb-3fc1-08db317266f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s9w/BMexE9Szcp8e2L3Bq9vKHMiHBH6HxZbZ9STMyeDfjnwNjjrjy4XOY+aIJK1wiA/dtOzpb0d5oTT+Xg+TZ2i6hCLsbxcYNIDnss4llCxP2j4yyhRhcLU40lZiJPGr2q9UhAqhFeca+9FMpdDuzkd2V7hQt6yIrrxGAc/e72hFI0XnmN7799Ht9AHZdOSlAcDL0tnRgEnJI9olls07Iy6yVRTIxOZlm4bK/TpyZcY7TsZraZllg+8KR6Gcj5+LPi4Cn61fnVWWt0+9l/cQGJ3Ktx73T9P+gR0rK9sViV0roQykichFTH6fvSwL3P3vcyw2sX6rn7uHRXmphBqxN42kVtYN5J+cNJbrRNXpxJu+1Izt1j0f/Mjd4XhEY1Xe3Xu3Qd0KZhKnA2RkCEAyznBO8WdYybc6Jj2TA/MOyXegNcfyDDy2xpIlQ6ePnKQaCCKAoRBP+NEYrQQrbOAQyXIINBK/IRMjmbb3Ivj/JaGxMrTADRaO08yi3usoGHP2bFW9TOmSEfEobKatOvx4C9FpehvFxRQA7j58W08/qJ6KWtN3Cc1mxGOAusZTfc5QpWoLsT3MbZuM4w0owBywGbpFwvUdy1KBkV+H9ZinM3bsqtjR4WI2NyX8XfRikAWmbCcVg9IszAFy15VUlefQ0YOdZ7UrqnICJpJ60p32sshoUnRV4PqrRHQOANWATrq40G4ghjRUcPxjUFTBPxaieqSK5SR1V7ocX2uqM6zT74VXHqbu19O3RewO/jmVzhmmlhXmdpTfIZ9Pk1VIWJY9qDP13EymXA6VYRRoV2ruPrE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(6666004)(107886003)(478600001)(1076003)(36756003)(426003)(83380400001)(86362001)(70206006)(5660300002)(2616005)(186003)(54906003)(40480700001)(16526019)(2906002)(7636003)(316002)(36860700001)(4326008)(8676002)(110136005)(41300700001)(34020700004)(82310400005)(336012)(82740400003)(8936002)(40460700003)(47076005)(356005)(70586007)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 22:59:22.4457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35eca08b-54ba-4bdb-3fc1-08db317266f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465
Subject: [virtio-dev] [PATCH 00/11] Introduce transitional mmr pci device

Overview:
---------
The Transitional MMR device is a variant of the transitional PCI device.
It has its own small Device ID range. It does not have I/O
region BAR; instead it exposes legacy configuration and device
specific registers at an offset in the memory region BAR.

Such transitional MMR devices will be used at the scale of
thousands of devices using PCI SR-IOV and/or future scalable
virtualization technology to provide backward
compatibility (for legacy devices) and also future
compatibility with new features.

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
The existing transitional PCI device is missing support for
PCI SR-IOV based devices. Currently it does not work beyond
PCI PF, or as software emulated device in reality. It currently
has below cited system level limitations:

[a] PCIe spec citation:
VFs do not support I/O Space and thus VF BARs shall not
indicate I/O Space.

[b] cpu arch citiation:
Intel 64 and IA-32 Architectures Software Developer’s Manual:
The processor’s I/O address space is separate and distinct from
the physical-memory address space. The I/O address space consists
of 64K individually addressable 8-bit I/O ports, numbered 0 through FFFFH.

[c] PCIe spec citation:
If a bridge implements an I/O address range,...I/O address range
will be aligned to a 4 KB boundary.

[d] I/O region accesses at PCI system level is slow as they are non-posted
operations in PCIe fabric.

The usecase requirements and limitations above can be solved by
extending the transitional device, mapping legacy and device
specific configuration registers in a memory PCI BAR instead
of using non composable I/O region.

Please review.

Patch summary:
--------------
patch 1 to 5 prepares the spec
patch 6 to 11 defines transitional mmr device

patch-1 uses lower case alphabets to name device id
patch-2 move transitional device id in legay section along with
        revision id
patch-3 splits legacy feature bits description from device id
patch-4 rename and moves virtio config registers next to 1.x
        registers section
patch-5 Adds missing helper verb in terminology definitions
patch-6 introduces transitional mmr device
patch-7 introduces transitional mmr device pci device ids
patch-8 introduces virtio extended pci capability
patch-9 describes new pci capability to locate legacy mmr
        registers
patch-10 extended usage of driver notification capability for
         the transitional mmr device
patch-11 adds conformance section of the transitional mmr device

This design and details further described below.

Design:
-------
Below picture captures the main small difference between current
transitional PCI SR-IOV VF and transitional MMR SR-IOV VF.

+------------------+ +--------------------+ +--------------------+
|virtio 1.x        | |Transitional        | |Transitional        |
|SRIOV VF          | |SRIOV VF            | |MMR SRIOV VF        |
|                  | |                    | |                    |
++---------------+ | ++---------------+   | ++---------------+   |
||dev_id =       | | ||dev_id =       |   | ||dev_id =       |   |
||{0x1040-0x106C}| | ||{0x1000-0x103f}|   | ||{0x10f9-0x10ff}|   |
|+---------------+ | |+---------------+   | |+---------------+   |
|                  | |                    | |                    |
|+------------+    | |+------------+      | |+-----------------+ |
||Memory BAR  |    | ||Memory BAR  |      | ||Memory BAR       | |
|+------------+    | |+------------+      | ||                 | |
|                  | |                    | || +--------------+| |
|                  | |+-----------------+ | || |legacy virtio || |
|                  | ||IOBAR impossible | | || |+ dev cfg     || |
|                  | |+-----------------+ | || |registers     || |
|                  | |                    | || +--------------+| |
|                  | |                    | |+-----------------+ |
+------------------+ +--------------------+ +--------------------+

Here transitional MMR SR-IOV VF has legacy configuration and
legacy device specific registers located at an offset in the memory
region BAR.

A memory region can be dedicated at BAR0 or it can be in an
existing BAR, allowing flexibility when implementing support
in a hardware device.

Transitional MMR SR-IOV VFs use a distinct device ID range to that
of existing virtio SR-IOV VFs to allow flexibility in driver
binding.

A more zoom-in version of transitional MMR SR-IOV device shows
that the location of the legacy registers are discovered by the
driver using a new capability.

+------------------------------+
|Transitional                  |
|MMR SRIOV VF                  |
|                              |
++---------------+             |
||dev_id =       |             |
||{0x10f9-0x10ff}|             |
|+---------------+             |
|                              |
++--------------------+        |
|| PCIe ext cap = 0xB |        |
|| cfg_type = 10      |        |
|| offset   = 0x1000  |        |
|| bar      = N {0..5}|        |
|+--|-----------------+        |
|   |                          |
|   |                          |
|   |    +-------------------+ |
|   |    | Memory BAR = A    | |
|   |    |                   | |
|   +------>+--------------+ | |
|        |  |legacy virtio | | |
|        |  |+ dev cfg     | | |
|        |  |registers     | | |
|        |  +--------------+ | |
|        +-----------------+ | |
+------------------------------+

Software usage:
---------------
Transitional MMR device can be used by multiple ways.

1. The most common way to use and map to the guest VM is by
using vfio driver framework in Linux kernel.

                +----------------------+
                |pci_dev_id = 0x100X   |
+---------------|pci_rev_id = 0x0      |-----+
|vfio device    |BAR0 = I/O region     |     |
|               |Other attributes      |     |
|               +----------------------+     |
|                                            |
+   +--------------+     +-----------------+ |
|   |I/O to memory |     | Other vfio      | |
|   |rd/wr mapper  |     | functionalities | |
|   +--------------+     +-----------------+ |
|                                            |
+-------------------+------------------------+
                    |
       +------------+-----------------+
       |         Transitional         |
       |         MMR SRIOV VF         |
       +------------------------------+

2. Virtio pci driver to bind to the listed device id and
   use it as native device in the host.

3. Use it in a light weight hypervisor to run bare-metal OS.

Parav Pandit (11):
  transport-pci: Use lowecase alphabets
  transport-pci: Move transitional device id to legacy section
  transport-pci: Split notes of PCI Device Layout
  transport-pci: Rename and move legacy PCI Device layout section
  introduction: Add missing helping verb
  introduction: Introduce transitional MMR interface
  transport-pci: Introduce transitional MMR device id
  transport-pci: Introduce virtio extended capability
  transport-pci: Describe PCI MMR dev config registers
  transport-pci: Use driver notification PCI capability
  conformance: Add transitional MMR interface conformance

 conformance.tex      |  11 +-
 introduction.tex     |  34 +++-
 tmmr-conformance.tex |  27 +++
 transport-pci.tex    | 405 ++++++++++++++++++++++++++++++-------------
 4 files changed, 354 insertions(+), 123 deletions(-)
 create mode 100644 tmmr-conformance.tex

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

