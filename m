Return-Path: virtio-dev-return-3215-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 92B965818F54
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Feb 2018 06:54:15 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Date: Wed, 14 Feb 2018 14:53:36 +0000
Message-Id: <20180214145340.1223-1-jean-philippe.brucker@arm.com>
Subject: [virtio-dev] [PATCH 0/4] Add virtio-iommu driver
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, kvmarm@lists.cs.columbia.edu
Cc: joro@8bytes.org, alex.williamson@redhat.com, mst@redhat.com, jasowang@redhat.com, marc.zyngier@arm.com, robin.murphy@arm.com, will.deacon@arm.com, lorenzo.pieralisi@arm.com, eric.auger@redhat.com, eric.auger.pro@gmail.com, peterx@redhat.com, bharat.bhushan@nxp.com, tnowicki@caviumnetworks.com, jayachandran.nair@cavium.com, kevin.tian@intel.com, jintack@cs.columbia.edu
List-ID: <virtio-dev.lists.oasis-open.org>

Implement the virtio-iommu driver following version 0.6 of the
specification [1]. Previous version, RFCv2, was sent in November [2].
This version addresses Eric's comments and changes the device number.
(Since last week I also tested and fixed the probe/release functions,
they now use devm properly.)

I did not include ACPI support because the next IORT specifications
isn't ready yet (even though the virtio-iommu spec describes the node
format, a new node type has to be allocated). Therefore only device-tree
guests are supported for the moment but the x86 prototype, on branch
virtio-iommu/devel, doesn't add much complexity.

	git://linux-arm.org/linux-jpb.git virtio-iommu/v0.6

Test it with Eric's latest QEMU device [3], for example with the
following command-line:

$ qemu-system-aarch64 -M virt -cpu cortex-a57 -nographic
	-kernel Image -append 'console=ttyAMA0 root=/dev/vda rw'
	-device virtio-iommu-device
	-device virtio-blk-pci,iommu_platform,disable-legacy=on,drive=hd0
	-drive if=none,file=rootfs.bin,id=hd0

You can also try the kvmtool device [4]. For example on AMD Seattle I
use the following commands to boot a guest with all devices behind a
virtio-iommu, then display mapping stats.

$ lkvm run -k Image --irqchip gicv2m --console virtio --vfio-pci 01:00.0
	--viommu vfio --viommu virtio
$ lkvm debug -a -i stats

[1] [RFC] virtio-iommu version 0.6
    https://www.spinics.net/lists/linux-virtualization/msg32628.html
[2] [RFC PATCH v2 0/5] Add virtio-iommu driver
    https://www.spinics.net/lists/kvm/msg159047.html
[3] [RFC v6 00/22] VIRTIO-IOMMU device
    http://lists.gnu.org/archive/html/qemu-arm/2018-02/msg00274.html
[4] git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.6

Jean-Philippe Brucker (4):
  iommu: Add virtio-iommu driver
  iommu/virtio: Add probe request
  iommu/virtio: Add event queue
  vfio: Allow type-1 IOMMU instantiation with a virtio-iommu

 MAINTAINERS                       |    6 +
 drivers/iommu/Kconfig             |   11 +
 drivers/iommu/Makefile            |    1 +
 drivers/iommu/virtio-iommu.c      | 1220 +++++++++++++++++++++++++++++++++++++
 drivers/vfio/Kconfig              |    2 +-
 include/uapi/linux/virtio_ids.h   |    1 +
 include/uapi/linux/virtio_iommu.h |  171 ++++++
 7 files changed, 1411 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/virtio-iommu.c
 create mode 100644 include/uapi/linux/virtio_iommu.h

-- 
2.16.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

