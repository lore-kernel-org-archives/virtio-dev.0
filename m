Return-Path: virtio-dev-return-7697-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 293B2985EA6
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Aug 2020 13:16:25 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri, 21 Aug 2020 15:15:39 +0200
Message-Id: <20200821131540.2801801-6-jean-philippe@linaro.org>
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 5/6] iommu/virtio: Support topology description in config space
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Cc: joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, eric.auger@redhat.com, lorenzo.pieralisi@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Platforms without device-tree nor ACPI can provide a topology
description embedded into the virtio config space. Parse it.

Use PCI FIXUP to probe the config space early, because we need to
discover the topology before any DMA configuration takes place, and the
virtio driver may be loaded much later. Since we discover the topology
description when probing the PCI hierarchy, the virtual IOMMU cannot
manage other platform devices discovered earlier.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig           |  12 ++
 drivers/iommu/virtio/Makefile   |   1 +
 drivers/iommu/virtio/topology.c | 259 ++++++++++++++++++++++++++++++++
 3 files changed, 272 insertions(+)
 create mode 100644 drivers/iommu/virtio/topology.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e29ae50f7100..98d28fdbc19a 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -394,4 +394,16 @@ config VIRTIO_IOMMU
 config VIRTIO_IOMMU_TOPOLOGY_HELPERS
 =09bool
=20
+config VIRTIO_IOMMU_TOPOLOGY
+=09bool "Handle topology properties from the virtio-iommu"
+=09depends on VIRTIO_IOMMU
+=09depends on PCI
+=09default y
+=09select VIRTIO_IOMMU_TOPOLOGY_HELPERS
+=09help
+=09  Enable early probing of virtio-iommu devices to detect the built-in
+=09  topology description.
+
+=09  Say Y here if you intend to run this kernel as a guest.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/virtio/Makefile b/drivers/iommu/virtio/Makefile
index b42ad47eac7e..1eda8ca1cbbf 100644
--- a/drivers/iommu/virtio/Makefile
+++ b/drivers/iommu/virtio/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_VIRTIO_IOMMU) +=3D virtio-iommu.o
+obj-$(CONFIG_VIRTIO_IOMMU_TOPOLOGY) +=3D topology.o
 obj-$(CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS) +=3D topology-helpers.o
diff --git a/drivers/iommu/virtio/topology.c b/drivers/iommu/virtio/topolog=
y.c
new file mode 100644
index 000000000000..4923eec618b9
--- /dev/null
+++ b/drivers/iommu/virtio/topology.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/io-64-nonatomic-hi-lo.h>
+#include <linux/iopoll.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_pci.h>
+#include <uapi/linux/virtio_config.h>
+#include <uapi/linux/virtio_iommu.h>
+
+#include "topology-helpers.h"
+
+struct viommu_cap_config {
+=09u8 bar;
+=09u32 length; /* structure size */
+=09u32 offset; /* structure offset within the bar */
+};
+
+struct viommu_topo_header {
+=09u8 type;
+=09u8 reserved;
+=09u16 length;
+};
+
+static struct virt_topo_endpoint *
+viommu_parse_node(void __iomem *buf, size_t len)
+{
+=09int ret =3D -EINVAL;
+=09union {
+=09=09struct viommu_topo_header hdr;
+=09=09struct virtio_iommu_topo_pci_range pci;
+=09=09struct virtio_iommu_topo_mmio mmio;
+=09} __iomem *cfg =3D buf;
+=09struct virt_topo_endpoint *spec;
+
+=09spec =3D kzalloc(sizeof(*spec), GFP_KERNEL);
+=09if (!spec)
+=09=09return ERR_PTR(-ENOMEM);
+
+=09switch (ioread8(&cfg->hdr.type)) {
+=09case VIRTIO_IOMMU_TOPO_PCI_RANGE:
+=09=09if (len < sizeof(cfg->pci))
+=09=09=09goto err_free;
+
+=09=09spec->dev_id.type =3D VIRT_TOPO_DEV_TYPE_PCI;
+=09=09spec->dev_id.segment =3D ioread16(&cfg->pci.segment);
+=09=09spec->dev_id.bdf_start =3D ioread16(&cfg->pci.bdf_start);
+=09=09spec->dev_id.bdf_end =3D ioread16(&cfg->pci.bdf_end);
+=09=09spec->endpoint_id =3D ioread32(&cfg->pci.endpoint_start);
+=09=09break;
+=09case VIRTIO_IOMMU_TOPO_MMIO:
+=09=09if (len < sizeof(cfg->mmio))
+=09=09=09goto err_free;
+
+=09=09spec->dev_id.type =3D VIRT_TOPO_DEV_TYPE_MMIO;
+=09=09spec->dev_id.base =3D ioread64(&cfg->mmio.address);
+=09=09spec->endpoint_id =3D ioread32(&cfg->mmio.endpoint);
+=09=09break;
+=09default:
+=09=09pr_warn("unhandled format 0x%x\n", ioread8(&cfg->hdr.type));
+=09=09ret =3D 0;
+=09=09goto err_free;
+=09}
+=09return spec;
+
+err_free:
+=09kfree(spec);
+=09return ERR_PTR(ret);
+}
+
+static int viommu_parse_topology(struct device *dev,
+=09=09=09=09 struct virtio_iommu_config __iomem *cfg,
+=09=09=09=09 size_t max_len)
+{
+=09int ret;
+=09u16 len;
+=09size_t i;
+=09LIST_HEAD(endpoints);
+=09size_t offset, count;
+=09struct virt_topo_iommu *viommu;
+=09struct virt_topo_endpoint *ep, *next;
+=09struct viommu_topo_header __iomem *cur;
+
+=09offset =3D ioread16(&cfg->topo_config.offset);
+=09count =3D ioread16(&cfg->topo_config.count);
+=09if (!offset || !count)
+=09=09return 0;
+
+=09viommu =3D kzalloc(sizeof(*viommu), GFP_KERNEL);
+=09if (!viommu)
+=09=09return -ENOMEM;
+
+=09viommu->dev =3D dev;
+
+=09for (i =3D 0; i < count; i++, offset +=3D len) {
+=09=09if (offset + sizeof(*cur) > max_len) {
+=09=09=09ret =3D -EOVERFLOW;
+=09=09=09goto err_free;
+=09=09}
+
+=09=09cur =3D (void __iomem *)cfg + offset;
+=09=09len =3D ioread16(&cur->length);
+=09=09if (offset + len > max_len) {
+=09=09=09ret =3D -EOVERFLOW;
+=09=09=09goto err_free;
+=09=09}
+
+=09=09ep =3D viommu_parse_node((void __iomem *)cur, len);
+=09=09if (!ep) {
+=09=09=09continue;
+=09=09} else if (IS_ERR(ep)) {
+=09=09=09ret =3D PTR_ERR(ep);
+=09=09=09goto err_free;
+=09=09}
+
+=09=09ep->viommu =3D viommu;
+=09=09list_add(&ep->list, &endpoints);
+=09}
+
+=09list_for_each_entry_safe(ep, next, &endpoints, list)
+=09=09/* Moves ep to the helpers list */
+=09=09virt_topo_add_endpoint(ep);
+=09virt_topo_add_iommu(viommu);
+
+=09return 0;
+err_free:
+=09list_for_each_entry_safe(ep, next, &endpoints, list)
+=09=09kfree(ep);
+=09kfree(viommu);
+=09return ret;
+}
+
+#define VPCI_FIELD(field) offsetof(struct virtio_pci_cap, field)
+
+static inline int viommu_pci_find_capability(struct pci_dev *dev, u8 cfg_t=
ype,
+=09=09=09=09=09     struct viommu_cap_config *cap)
+{
+=09int pos;
+=09u8 bar;
+
+=09for (pos =3D pci_find_capability(dev, PCI_CAP_ID_VNDR);
+=09     pos > 0;
+=09     pos =3D pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
+=09=09u8 type;
+
+=09=09pci_read_config_byte(dev, pos + VPCI_FIELD(cfg_type), &type);
+=09=09if (type !=3D cfg_type)
+=09=09=09continue;
+
+=09=09pci_read_config_byte(dev, pos + VPCI_FIELD(bar), &bar);
+
+=09=09/* Ignore structures with reserved BAR values */
+=09=09if (type !=3D VIRTIO_PCI_CAP_PCI_CFG && bar > 0x5)
+=09=09=09continue;
+
+=09=09cap->bar =3D bar;
+=09=09pci_read_config_dword(dev, pos + VPCI_FIELD(length),
+=09=09=09=09      &cap->length);
+=09=09pci_read_config_dword(dev, pos + VPCI_FIELD(offset),
+=09=09=09=09      &cap->offset);
+
+=09=09return pos;
+=09}
+=09return 0;
+}
+
+static int viommu_pci_reset(struct virtio_pci_common_cfg __iomem *cfg)
+{
+=09u8 status;
+=09ktime_t timeout =3D ktime_add_ms(ktime_get(), 100);
+
+=09iowrite8(0, &cfg->device_status);
+=09while ((status =3D ioread8(&cfg->device_status)) !=3D 0 &&
+=09       ktime_before(ktime_get(), timeout))
+=09=09msleep(1);
+
+=09return status ? -ETIMEDOUT : 0;
+}
+
+static void viommu_pci_parse_topology(struct pci_dev *dev)
+{
+=09int ret;
+=09u32 features;
+=09void __iomem *regs, *common_regs;
+=09struct viommu_cap_config cap =3D {0};
+=09struct virtio_pci_common_cfg __iomem *common_cfg;
+
+=09/*
+=09 * The virtio infrastructure might not be loaded at this point. We need
+=09 * to access the BARs ourselves.
+=09 */
+=09ret =3D viommu_pci_find_capability(dev, VIRTIO_PCI_CAP_COMMON_CFG, &cap=
);
+=09if (!ret) {
+=09=09pci_warn(dev, "common capability not found\n");
+=09=09return;
+=09}
+
+=09if (pci_enable_device_mem(dev))
+=09=09return;
+
+=09common_regs =3D pci_iomap(dev, cap.bar, 0);
+=09if (!common_regs)
+=09=09return;
+
+=09common_cfg =3D common_regs + cap.offset;
+
+=09/* Perform the init sequence before we can read the config */
+=09ret =3D viommu_pci_reset(common_cfg);
+=09if (ret < 0) {
+=09=09pci_warn(dev, "unable to reset device\n");
+=09=09goto out_unmap_common;
+=09}
+
+=09iowrite8(VIRTIO_CONFIG_S_ACKNOWLEDGE, &common_cfg->device_status);
+=09iowrite8(VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER,
+=09=09 &common_cfg->device_status);
+
+=09/* Find out if the device supports topology description */
+=09iowrite32(0, &common_cfg->device_feature_select);
+=09features =3D ioread32(&common_cfg->device_feature);
+
+=09if (!(features & BIT(VIRTIO_IOMMU_F_TOPOLOGY))) {
+=09=09pci_dbg(dev, "device doesn't have topology description");
+=09=09goto out_reset;
+=09}
+
+=09ret =3D viommu_pci_find_capability(dev, VIRTIO_PCI_CAP_DEVICE_CFG, &cap=
);
+=09if (!ret) {
+=09=09pci_warn(dev, "device config capability not found\n");
+=09=09goto out_reset;
+=09}
+
+=09regs =3D pci_iomap(dev, cap.bar, 0);
+=09if (!regs)
+=09=09goto out_reset;
+
+=09pci_info(dev, "parsing virtio-iommu topology\n");
+=09ret =3D viommu_parse_topology(&dev->dev, regs + cap.offset,
+=09=09=09=09    pci_resource_len(dev, 0) - cap.offset);
+=09if (ret)
+=09=09pci_warn(dev, "failed to parse topology: %d\n", ret);
+
+=09pci_iounmap(dev, regs);
+out_reset:
+=09ret =3D viommu_pci_reset(common_cfg);
+=09if (ret)
+=09=09pci_warn(dev, "unable to reset device\n");
+out_unmap_common:
+=09pci_iounmap(dev, common_regs);
+}
+
+/*
+ * Catch a PCI virtio-iommu implementation early to get the topology descr=
iption
+ * before we start probing other endpoints.
+ */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT_QUMRANET, 0x1040 + VIRTIO_ID_=
IOMMU,
+=09=09=09viommu_pci_parse_topology);
--=20
2.28.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

