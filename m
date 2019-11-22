Return-Path: virtio-dev-return-6370-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B0765986080
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Nov 2019 10:50:59 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri, 22 Nov 2019 11:49:52 +0100
Message-Id: <20191122105000.800410-6-jean-philippe@linaro.org>
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC 05/13] ACPI/IORT: Support VIOT virtio-mmio node
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, jacob.jun.pan@intel.com, eric.auger@redhat.com, sebastien.boeuf@intel.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Add a new type of node to the IORT driver, that describes a virtio-iommu
device based on the virtio-mmio transport. The node is only available
when the IORT is a sub-table of the VIOT.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/acpi/iort.c | 66 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index 1d43fbc0001f..adc5953fffa5 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -43,7 +43,8 @@ static bool iort_type_matches(u8 type, enum iort_node_cat=
egory category)
 =09switch (category) {
 =09case IORT_IOMMU_TYPE:
 =09=09return type =3D=3D ACPI_IORT_NODE_SMMU ||
-=09=09       type =3D=3D ACPI_IORT_NODE_SMMU_V3;
+=09=09       type =3D=3D ACPI_IORT_NODE_SMMU_V3 ||
+=09=09       type =3D=3D ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU;
 =09case IORT_MSI_TYPE:
 =09=09return type =3D=3D ACPI_IORT_NODE_ITS_GROUP;
 =09default:
@@ -868,8 +869,10 @@ static inline bool iort_iommu_driver_enabled(u8 type)
 =09=09return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
 =09case ACPI_IORT_NODE_SMMU:
 =09=09return IS_BUILTIN(CONFIG_ARM_SMMU);
+=09case ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU:
+=09=09return IS_ENABLED(CONFIG_VIRTIO_IOMMU);
 =09default:
-=09=09pr_warn("IORT node type %u does not describe an SMMU\n", type);
+=09=09pr_warn("IORT node type %u does not describe an IOMMU\n", type);
 =09=09return false;
 =09}
 }
@@ -1408,6 +1411,46 @@ static int __init arm_smmu_v3_pmcg_add_platdata(stru=
ct platform_device *pdev)
 =09return platform_device_add_data(pdev, &model, sizeof(model));
 }
=20
+static int __init viommu_mmio_count_resources(struct acpi_iort_node *node)
+{
+=09/* Mem + IRQ */
+=09return 2;
+}
+
+static void __init viommu_mmio_init_resources(struct resource *res,
+=09=09=09=09=09   struct acpi_iort_node *node)
+{
+=09int hw_irq, trigger;
+=09struct acpi_viot_iort_virtio_mmio_iommu *viommu;
+
+=09viommu =3D (struct acpi_viot_iort_virtio_mmio_iommu *)node->node_data;
+
+=09res[0].start =3D viommu->base_address;
+=09res[0].end =3D viommu->base_address + viommu->span - 1;
+=09res[0].flags =3D IORESOURCE_MEM;
+
+=09hw_irq =3D IORT_IRQ_MASK(viommu->interrupt);
+=09trigger =3D IORT_IRQ_TRIGGER_MASK(viommu->interrupt);
+=09acpi_iort_register_irq(hw_irq, "viommu", trigger, res + 1);
+}
+
+static void __init viommu_mmio_dma_configure(struct device *dev,
+=09=09=09=09=09  struct acpi_iort_node *node)
+{
+=09enum dev_dma_attr attr;
+=09struct acpi_viot_iort_virtio_mmio_iommu *viommu;
+
+=09viommu =3D (struct acpi_viot_iort_virtio_mmio_iommu *)node->node_data;
+
+=09attr =3D (viommu->flags & ACPI_VIOT_IORT_VIRTIO_MMIO_IOMMU_CACHE_COHERE=
NT) ?
+=09=09DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
+
+=09dev->dma_mask =3D &dev->coherent_dma_mask;
+
+=09/* Configure DMA for the page table walker */
+=09acpi_dma_configure(dev, attr);
+}
+
 struct iort_dev_config {
 =09const char *name;
 =09int (*dev_init)(struct acpi_iort_node *node);
@@ -1443,6 +1486,14 @@ static const struct iort_dev_config iort_arm_smmu_v3=
_pmcg_cfg __initconst =3D {
 =09.dev_add_platdata =3D arm_smmu_v3_pmcg_add_platdata,
 };
=20
+static const struct iort_dev_config iort_viommu_mmio_cfg __initconst =3D {
+=09/* Probe with the generic virtio-mmio driver */
+=09.name =3D "virtio-mmio",
+=09.dev_dma_configure =3D viommu_mmio_dma_configure,
+=09.dev_count_resources =3D viommu_mmio_count_resources,
+=09.dev_init_resources =3D viommu_mmio_init_resources,
+};
+
 static __init const struct iort_dev_config *iort_get_dev_cfg(
 =09=09=09struct acpi_iort_node *node)
 {
@@ -1453,9 +1504,16 @@ static __init const struct iort_dev_config *iort_get=
_dev_cfg(
 =09=09return &iort_arm_smmu_cfg;
 =09case ACPI_IORT_NODE_PMCG:
 =09=09return &iort_arm_smmu_v3_pmcg_cfg;
-=09default:
-=09=09return NULL;
 =09}
+
+=09if (iort_table_source =3D=3D IORT_SOURCE_VIOT) {
+=09=09switch (node->type) {
+=09=09case ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU:
+=09=09=09return &iort_viommu_mmio_cfg;
+=09=09}
+=09}
+
+=09return NULL;
 }
=20
 /**
--=20
2.24.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

