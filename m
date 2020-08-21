Return-Path: virtio-dev-return-7694-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 80E90985E87
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Aug 2020 13:16:13 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri, 21 Aug 2020 15:15:37 +0200
Message-Id: <20200821131540.2801801-4-jean-philippe@linaro.org>
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 3/6] PCI: Add DMA configuration for virtual platforms
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Cc: joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, eric.auger@redhat.com, lorenzo.pieralisi@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hardware platforms usually describe the IOMMU topology using either
device-tree pointers or vendor-specific ACPI tables.  For virtual
platforms that don't provide a device-tree, the virtio-iommu device
contains a description of the endpoints it manages.  That information
allows us to probe endpoints after the IOMMU is probed (possibly as late
as userspace modprobe), provided it is discovered early enough.

Add a hook to pci_dma_configure(), which returns -EPROBE_DEFER if the
endpoint is managed by a vIOMMU that will be loaded later, or 0 in any
other case to avoid disturbing the normal DMA configuration methods.
When CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS isn't selected, the call to
virt_dma_configure() is compiled out.

As long as the information is consistent, platforms can provide both a
device-tree and a built-in topology, and the IOMMU infrastructure is
able to deal with multiple DMA configuration methods.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/pci-driver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 449466f71040..dbe9d33606b0 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -19,6 +19,7 @@
 #include <linux/kexec.h>
 #include <linux/of_device.h>
 #include <linux/acpi.h>
+#include <linux/virt_iommu.h>
 #include "pci.h"
 #include "pcie/portdrv.h"
=20
@@ -1605,6 +1606,10 @@ static int pci_dma_configure(struct device *dev)
 =09struct device *bridge;
 =09int ret =3D 0;
=20
+=09ret =3D virt_dma_configure(dev);
+=09if (ret)
+=09=09return ret;
+
 =09bridge =3D pci_get_host_bridge_device(to_pci_dev(dev));
=20
 =09if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
--=20
2.28.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

