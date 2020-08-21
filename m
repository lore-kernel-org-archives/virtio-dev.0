Return-Path: virtio-dev-return-7692-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2940F985E87
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Aug 2020 13:16:09 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri, 21 Aug 2020 15:15:34 +0200
Message-Id: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 0/6] Add virtio-iommu built-in topology
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Cc: joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, eric.auger@redhat.com, lorenzo.pieralisi@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Add a topology description to the virtio-iommu driver and enable x86
platforms.

Since [v2] we have made some progress on adding ACPI support for
virtio-iommu, which is the preferred boot method on x86. It will be a
new vendor-agnostic table describing para-virtual topologies in a
minimal format. However some platforms don't use either ACPI or DT for
booting (for example microvm), and will need the alternative topology
description method proposed here. In addition, since the process to get
a new ACPI table will take a long time, this provides a boot method even
to ACPI-based platforms, if only temporarily for testing and
development.

v3:
* Add patch 1 that moves virtio-iommu to a subfolder.
* Split the rest:
  * Patch 2 adds topology-helper.c, which will be shared with the ACPI
    support.
  * Patch 4 adds definitions.
  * Patch 5 adds parser in topology.c.
* Address other comments.

Linux and QEMU patches available at:
https://jpbrucker.net/git/linux virtio-iommu/devel
https://jpbrucker.net/git/qemu virtio-iommu/devel

[spec] https://lists.oasis-open.org/archives/virtio-dev/202008/msg00067.htm=
l
[v2] https://lore.kernel.org/linux-iommu/20200228172537.377327-1-jean-phili=
ppe@linaro.org/
[v1] https://lore.kernel.org/linux-iommu/20200214160413.1475396-1-jean-phil=
ippe@linaro.org/
[rfc] https://lore.kernel.org/linux-iommu/20191122105000.800410-1-jean-phil=
ippe@linaro.org/

Jean-Philippe Brucker (6):
  iommu/virtio: Move to drivers/iommu/virtio/
  iommu/virtio: Add topology helpers
  PCI: Add DMA configuration for virtual platforms
  iommu/virtio: Add topology definitions
  iommu/virtio: Support topology description in config space
  iommu/virtio: Enable x86 support

 drivers/iommu/Kconfig                     |  18 +-
 drivers/iommu/Makefile                    |   3 +-
 drivers/iommu/virtio/Makefile             |   4 +
 drivers/iommu/virtio/topology-helpers.h   |  50 +++++
 include/linux/virt_iommu.h                |  15 ++
 include/uapi/linux/virtio_iommu.h         |  44 ++++
 drivers/iommu/virtio/topology-helpers.c   | 196 ++++++++++++++++
 drivers/iommu/virtio/topology.c           | 259 ++++++++++++++++++++++
 drivers/iommu/{ =3D> virtio}/virtio-iommu.c |   4 +
 drivers/pci/pci-driver.c                  |   5 +
 MAINTAINERS                               |   3 +-
 11 files changed, 597 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iommu/virtio/Makefile
 create mode 100644 drivers/iommu/virtio/topology-helpers.h
 create mode 100644 include/linux/virt_iommu.h
 create mode 100644 drivers/iommu/virtio/topology-helpers.c
 create mode 100644 drivers/iommu/virtio/topology.c
 rename drivers/iommu/{ =3D> virtio}/virtio-iommu.c (99%)

--=20
2.28.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

