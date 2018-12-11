Return-Path: virtio-dev-return-5177-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7260A985C75
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Dec 2018 18:26:45 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Date: Tue, 11 Dec 2018 18:20:57 +0000
Message-Id: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v6 0/7] Add virtio-iommu driver
To: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, joro@8bytes.org, mst@redhat.com
Cc: jasowang@redhat.com, robh+dt@kernel.org, mark.rutland@arm.com, bhelgaas@google.com, frowand.list@gmail.com, kvmarm@lists.cs.columbia.edu, eric.auger@redhat.com, tnowicki@caviumnetworks.com, kevin.tian@intel.com, marc.zyngier@arm.com, robin.murphy@arm.com, will.deacon@arm.com, lorenzo.pieralisi@arm.com, bharat.bhushan@nxp.com
List-ID: <virtio-dev.lists.oasis-open.org>

Implement the virtio-iommu driver, following specification v0.9 [1].

Only minor changes since v5 [2]. I fixed issues reported by Michael and
added tags from Eric and Bharat. Thanks!

You can find Linux driver and kvmtool device on v0.9 branches [3],
module and x86 support on virtio-iommu/devel. Also tested with Eric's
QEMU device [4].

[1] Virtio-iommu specification v0.9, sources and pdf
    git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.9
    http://jpbrucker.net/virtio-iommu/spec/v0.9/virtio-iommu-v0.9.pdf

[2] [PATCH v5 0/7] Add virtio-iommu driver
    https://www.spinics.net/lists/linux-pci/msg78158.html

[3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.9.1
    git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.9

[4] [RFC v9 00/17] VIRTIO-IOMMU device
    https://www.mail-archive.com/qemu-devel@nongnu.org/msg575578.html

Jean-Philippe Brucker (7):
  dt-bindings: virtio-mmio: Add IOMMU description
  dt-bindings: virtio: Add virtio-pci-iommu node
  of: Allow the iommu-map property to omit untranslated devices
  PCI: OF: Initialize dev->fwnode appropriately
  iommu: Add virtio-iommu driver
  iommu/virtio: Add probe request
  iommu/virtio: Add event queue

 .../devicetree/bindings/virtio/iommu.txt      |   66 +
 .../devicetree/bindings/virtio/mmio.txt       |   30 +
 MAINTAINERS                                   |    7 +
 drivers/iommu/Kconfig                         |   11 +
 drivers/iommu/Makefile                        |    1 +
 drivers/iommu/virtio-iommu.c                  | 1157 +++++++++++++++++
 drivers/of/base.c                             |   10 +-
 drivers/pci/of.c                              |    7 +
 include/uapi/linux/virtio_ids.h               |    1 +
 include/uapi/linux/virtio_iommu.h             |  161 +++
 10 files changed, 1448 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
 create mode 100644 drivers/iommu/virtio-iommu.c
 create mode 100644 include/uapi/linux/virtio_iommu.h

-- 
2.19.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

