Return-Path: virtio-dev-return-7696-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F5A2985E94
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Aug 2020 13:16:16 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri, 21 Aug 2020 15:15:36 +0200
Message-Id: <20200821131540.2801801-3-jean-philippe@linaro.org>
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 2/6] iommu/virtio: Add topology helpers
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Cc: joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, eric.auger@redhat.com, lorenzo.pieralisi@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

To support topology description from ACPI and from the builtin
description, add helpers to keep track of I/O topology descriptors.

To ease re-use of the helpers by other drivers and future ACPI
extensions, use the "virt_" prefix rather than "virtio_" when naming
structs and functions.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig                   |   3 +
 drivers/iommu/virtio/Makefile           |   1 +
 drivers/iommu/virtio/topology-helpers.h |  50 ++++++
 include/linux/virt_iommu.h              |  15 ++
 drivers/iommu/virtio/topology-helpers.c | 196 ++++++++++++++++++++++++
 drivers/iommu/virtio/virtio-iommu.c     |   4 +
 MAINTAINERS                             |   1 +
 7 files changed, 270 insertions(+)
 create mode 100644 drivers/iommu/virtio/topology-helpers.h
 create mode 100644 include/linux/virt_iommu.h
 create mode 100644 drivers/iommu/virtio/topology-helpers.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index bef5d75e306b..e29ae50f7100 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -391,4 +391,7 @@ config VIRTIO_IOMMU
=20
 =09  Say Y here if you intend to run this kernel as a guest.
=20
+config VIRTIO_IOMMU_TOPOLOGY_HELPERS
+=09bool
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/virtio/Makefile b/drivers/iommu/virtio/Makefile
index 279368fcc074..b42ad47eac7e 100644
--- a/drivers/iommu/virtio/Makefile
+++ b/drivers/iommu/virtio/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_VIRTIO_IOMMU) +=3D virtio-iommu.o
+obj-$(CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS) +=3D topology-helpers.o
diff --git a/drivers/iommu/virtio/topology-helpers.h b/drivers/iommu/virtio=
/topology-helpers.h
new file mode 100644
index 000000000000..436ca6a900c5
--- /dev/null
+++ b/drivers/iommu/virtio/topology-helpers.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef TOPOLOGY_HELPERS_H_
+#define TOPOLOGY_HELPERS_H_
+
+#ifdef CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS
+
+/* Identify a device node in the topology */
+struct virt_topo_dev_id {
+=09unsigned int=09=09=09type;
+#define VIRT_TOPO_DEV_TYPE_PCI=09=091
+#define VIRT_TOPO_DEV_TYPE_MMIO=09=092
+=09union {
+=09=09/* PCI endpoint or range */
+=09=09struct {
+=09=09=09u16=09=09segment;
+=09=09=09u16=09=09bdf_start;
+=09=09=09u16=09=09bdf_end;
+=09=09};
+=09=09/* MMIO region */
+=09=09u64=09=09=09base;
+=09};
+};
+
+/* Specification of an IOMMU */
+struct virt_topo_iommu {
+=09struct virt_topo_dev_id=09=09dev_id;
+=09struct device=09=09=09*dev; /* transport device */
+=09struct fwnode_handle=09=09*fwnode;
+=09struct iommu_ops=09=09*ops;
+=09struct list_head=09=09list;
+};
+
+/* Specification of an endpoint */
+struct virt_topo_endpoint {
+=09struct virt_topo_dev_id=09=09dev_id;
+=09u32=09=09=09=09endpoint_id;
+=09struct virt_topo_iommu=09=09*viommu;
+=09struct list_head=09=09list;
+};
+
+void virt_topo_add_endpoint(struct virt_topo_endpoint *ep);
+void virt_topo_add_iommu(struct virt_topo_iommu *viommu);
+
+void virt_topo_set_iommu_ops(struct device *dev, struct iommu_ops *ops);
+
+#else /* !CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS */
+static inline void virt_topo_set_iommu_ops(struct device *dev, struct iomm=
u_ops *ops)
+{ }
+#endif /* !CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS */
+#endif /* TOPOLOGY_HELPERS_H_ */
diff --git a/include/linux/virt_iommu.h b/include/linux/virt_iommu.h
new file mode 100644
index 000000000000..17d2bd4732e0
--- /dev/null
+++ b/include/linux/virt_iommu.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef VIRT_IOMMU_H_
+#define VIRT_IOMMU_H_
+
+#ifdef CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS
+int virt_dma_configure(struct device *dev);
+
+#else /* !CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS */
+static inline int virt_dma_configure(struct device *dev)
+{
+=09/* Don't disturb the normal DMA configuration methods */
+=09return 0;
+}
+#endif /* !CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS */
+#endif /* VIRT_IOMMU_H_ */
diff --git a/drivers/iommu/virtio/topology-helpers.c b/drivers/iommu/virtio=
/topology-helpers.c
new file mode 100644
index 000000000000..8815e3a5d431
--- /dev/null
+++ b/drivers/iommu/virtio/topology-helpers.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/dma-iommu.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/virt_iommu.h>
+
+#include "topology-helpers.h"
+
+static LIST_HEAD(viommus);
+static LIST_HEAD(pci_endpoints);
+static LIST_HEAD(mmio_endpoints);
+static DEFINE_MUTEX(viommus_lock);
+
+static bool virt_topo_device_match(struct device *dev,
+=09=09=09=09   struct virt_topo_dev_id *id)
+{
+=09if (id->type =3D=3D VIRT_TOPO_DEV_TYPE_PCI && dev_is_pci(dev)) {
+=09=09struct pci_dev *pdev =3D to_pci_dev(dev);
+=09=09u16 dev_id =3D pci_dev_id(pdev);
+
+=09=09return pci_domain_nr(pdev->bus) =3D=3D id->segment &&
+=09=09=09dev_id >=3D id->bdf_start &&
+=09=09=09dev_id <=3D id->bdf_end;
+=09} else if (id->type =3D=3D VIRT_TOPO_DEV_TYPE_MMIO &&
+=09=09   dev_is_platform(dev)) {
+=09=09struct platform_device *plat_dev =3D to_platform_device(dev);
+=09=09struct resource *mem;
+
+=09=09mem =3D platform_get_resource(plat_dev, IORESOURCE_MEM, 0);
+=09=09if (!mem)
+=09=09=09return false;
+=09=09return mem->start =3D=3D id->base;
+=09}
+=09return false;
+}
+
+static const struct iommu_ops *virt_iommu_setup(struct device *dev)
+{
+=09struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
+=09struct virt_topo_iommu *viommu =3D NULL;
+=09struct virt_topo_endpoint *ep;
+=09struct pci_dev *pci_dev =3D NULL;
+=09u32 epid;
+=09int ret;
+
+=09/* Already translated? */
+=09if (fwspec && fwspec->ops)
+=09=09return NULL;
+
+=09mutex_lock(&viommus_lock);
+=09if (dev_is_pci(dev)) {
+=09=09pci_dev =3D to_pci_dev(dev);
+=09=09list_for_each_entry(ep, &pci_endpoints, list) {
+=09=09=09if (virt_topo_device_match(dev, &ep->dev_id)) {
+=09=09=09=09epid =3D pci_dev_id(pci_dev) -
+=09=09=09=09=09ep->dev_id.bdf_start +
+=09=09=09=09=09ep->endpoint_id;
+=09=09=09=09viommu =3D ep->viommu;
+=09=09=09=09break;
+=09=09=09}
+=09=09}
+=09} else if (dev_is_platform(dev)) {
+=09=09list_for_each_entry(ep, &mmio_endpoints, list) {
+=09=09=09if (virt_topo_device_match(dev, &ep->dev_id)) {
+=09=09=09=09epid =3D ep->endpoint_id;
+=09=09=09=09viommu =3D ep->viommu;
+=09=09=09=09break;
+=09=09=09}
+=09=09}
+=09}
+=09mutex_unlock(&viommus_lock);
+=09if (!viommu)
+=09=09return NULL;
+
+=09/* We're not translating ourselves. */
+=09if (virt_topo_device_match(dev, &viommu->dev_id) ||
+=09    dev =3D=3D viommu->dev)
+=09=09return NULL;
+
+=09/*
+=09 * If we found a PCI range managed by the viommu, we're the one that ha=
s
+=09 * to request ACS.
+=09 */
+=09if (pci_dev)
+=09=09pci_request_acs();
+
+=09if (!viommu->ops)
+=09=09return ERR_PTR(-EPROBE_DEFER);
+
+=09ret =3D iommu_fwspec_init(dev, viommu->fwnode, viommu->ops);
+=09if (ret)
+=09=09return ERR_PTR(ret);
+
+=09iommu_fwspec_add_ids(dev, &epid, 1);
+
+=09return viommu->ops;
+}
+
+/**
+ * virt_topo_add_endpoint - Register endpoint specification
+ * @ep: the endpoint specification
+ */
+void virt_topo_add_endpoint(struct virt_topo_endpoint *ep)
+{
+=09mutex_lock(&viommus_lock);
+=09list_add(&ep->list,
+=09=09 ep->dev_id.type =3D=3D VIRT_TOPO_DEV_TYPE_MMIO ?
+=09=09 &mmio_endpoints : &pci_endpoints);
+=09mutex_unlock(&viommus_lock);
+}
+
+/**
+ * virt_topo_add_iommu - Register IOMMU specification
+ * @viommu: the IOMMU specification
+ */
+void virt_topo_add_iommu(struct virt_topo_iommu *viommu)
+{
+=09mutex_lock(&viommus_lock);
+=09list_add(&viommu->list, &viommus);
+=09mutex_unlock(&viommus_lock);
+}
+
+/**
+ * virt_dma_configure - Configure DMA of virtualized devices
+ * @dev: the endpoint
+ *
+ * Setup the DMA and IOMMU ops of a virtual device, for platforms without =
DT or
+ * ACPI.
+ *
+ * Return: -EPROBE_DEFER if the device is managed by an IOMMU that hasn't =
been
+ *   probed yet, 0 otherwise
+ */
+int virt_dma_configure(struct device *dev)
+{
+=09const struct iommu_ops *iommu_ops;
+
+=09iommu_ops =3D virt_iommu_setup(dev);
+=09if (IS_ERR_OR_NULL(iommu_ops)) {
+=09=09int ret =3D PTR_ERR(iommu_ops);
+
+=09=09if (ret =3D=3D -EPROBE_DEFER || ret =3D=3D 0)
+=09=09=09return ret;
+=09=09dev_err(dev, "error %d while setting up virt IOMMU\n", ret);
+=09=09return 0;
+=09}
+
+=09/*
+=09 * If we have reason to believe the IOMMU driver missed the initial
+=09 * add_device callback for dev, replay it to get things in order.
+=09 */
+=09if (dev->bus && !device_iommu_mapped(dev))
+=09=09iommu_probe_device(dev);
+
+=09/* Assume coherent, as well as full 64-bit addresses. */
+#ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
+=09arch_setup_dma_ops(dev, 0, ~0ULL, iommu_ops, true);
+#else
+=09iommu_setup_dma_ops(dev, 0, ~0ULL);
+#endif
+=09return 0;
+}
+
+/**
+ * virt_topo_set_iommu_ops - Set the IOMMU ops of a virtual IOMMU device
+ * @dev: the IOMMU device (transport)
+ * @ops: the new IOMMU ops or NULL
+ *
+ * Setup the iommu_ops associated to an IOMMU, once the driver is loaded
+ * and the device probed.
+ */
+void virt_topo_set_iommu_ops(struct device *dev, struct iommu_ops *ops)
+{
+=09struct virt_topo_iommu *viommu;
+
+=09mutex_lock(&viommus_lock);
+=09list_for_each_entry(viommu, &viommus, list) {
+=09=09/*
+=09=09 * In case the topology driver didn't have a dev handle when
+=09=09 * registering the topology, add it now.
+=09=09 */
+=09=09if (!viommu->dev &&
+=09=09    virt_topo_device_match(dev, &viommu->dev_id))
+=09=09=09viommu->dev =3D dev;
+
+=09=09if (viommu->dev =3D=3D dev) {
+=09=09=09viommu->ops =3D ops;
+=09=09=09viommu->fwnode =3D ops ? dev->fwnode : NULL;
+=09=09=09break;
+=09=09}
+=09}
+=09mutex_unlock(&viommus_lock);
+}
+EXPORT_SYMBOL_GPL(virt_topo_set_iommu_ops);
diff --git a/drivers/iommu/virtio/virtio-iommu.c b/drivers/iommu/virtio/vir=
tio-iommu.c
index b4da396cce60..b371d15f837f 100644
--- a/drivers/iommu/virtio/virtio-iommu.c
+++ b/drivers/iommu/virtio/virtio-iommu.c
@@ -25,6 +25,8 @@
=20
 #include <uapi/linux/virtio_iommu.h>
=20
+#include "topology-helpers.h"
+
 #define MSI_IOVA_BASE=09=09=090x8000000
 #define MSI_IOVA_LENGTH=09=09=090x100000
=20
@@ -1065,6 +1067,7 @@ static int viommu_probe(struct virtio_device *vdev)
 =09if (ret)
 =09=09goto err_free_vqs;
=20
+=09virt_topo_set_iommu_ops(dev->parent, &viommu_ops);
 =09iommu_device_set_ops(&viommu->iommu, &viommu_ops);
 =09iommu_device_set_fwnode(&viommu->iommu, parent_dev->fwnode);
=20
@@ -1111,6 +1114,7 @@ static void viommu_remove(struct virtio_device *vdev)
 {
 =09struct viommu_dev *viommu =3D vdev->priv;
=20
+=09virt_topo_set_iommu_ops(vdev->dev.parent, NULL);
 =09iommu_device_sysfs_remove(&viommu->iommu);
 =09iommu_device_unregister(&viommu->iommu);
=20
diff --git a/MAINTAINERS b/MAINTAINERS
index 3602b223c9b2..8fd53c22a0ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18452,6 +18452,7 @@ M:=09Jean-Philippe Brucker <jean-philippe@linaro.or=
g>
 L:=09virtualization@lists.linux-foundation.org
 S:=09Maintained
 F:=09drivers/iommu/virtio/
+F:=09include/linux/virt_iommu.h
 F:=09include/uapi/linux/virtio_iommu.h
=20
 VIRTIO MEM DRIVER
--=20
2.28.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

