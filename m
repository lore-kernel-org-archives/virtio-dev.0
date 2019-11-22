Return-Path: virtio-dev-return-6375-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D1F61985FFA
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Nov 2019 10:51:08 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri, 22 Nov 2019 11:49:57 +0100
Message-Id: <20191122105000.800410-11-jean-philippe@linaro.org>
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC 10/13] iommu/virtio: Update IORT fwnode
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, jacob.jun.pan@intel.com, eric.auger@redhat.com, sebastien.boeuf@intel.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

When the virtio-iommu uses the PCI transport and the topology is
described with IORT, register the PCI fwnode with IORT.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 8efa368134c0..9847552faecc 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -7,6 +7,7 @@
=20
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
=20
+#include <linux/acpi_iort.h>
 #include <linux/amba/bus.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
@@ -989,6 +990,8 @@ static int viommu_set_fwnode(struct viommu_dev *viommu)
 =09=09set_primary_fwnode(dev, fwnode);
 =09}
=20
+=09/* Tell IORT about a PCI device's fwnode */
+=09iort_iommu_update_fwnode(dev, dev->fwnode);
 =09iommu_device_set_fwnode(&viommu->iommu, dev->fwnode);
 =09return 0;
 }
@@ -1000,6 +1003,8 @@ static void viommu_clear_fwnode(struct viommu_dev *vi=
ommu)
 =09if (!dev->fwnode)
 =09=09return;
=20
+=09iort_iommu_update_fwnode(dev, NULL);
+
 =09if (is_software_node(dev->fwnode)) {
 =09=09struct fwnode_handle *fwnode =3D dev->fwnode;
=20
--=20
2.24.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

