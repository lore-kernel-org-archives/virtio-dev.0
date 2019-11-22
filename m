Return-Path: virtio-dev-return-6372-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 908AE985EAA
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Nov 2019 10:51:03 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri, 22 Nov 2019 11:49:53 +0100
Message-Id: <20191122105000.800410-7-jean-philippe@linaro.org>
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC 06/13] ACPI/IORT: Support VIOT virtio-pci node
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, jacob.jun.pan@intel.com, eric.auger@redhat.com, sebastien.boeuf@intel.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

When virtio-iommu uses the PCI transport, IORT doesn't instantiate the
device and doesn't create a fwnode. They will be created later by the
PCI subsystem. Store the information needed to identify the IOMMU in
iort_fwnode_list.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/acpi/iort.c | 117 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 93 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index adc5953fffa5..b517aa4e83ba 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -30,10 +30,17 @@ struct iort_its_msi_chip {
 =09u32=09=09=09translation_id;
 };
=20
+struct iort_pci_devid {
+=09u16 segment;
+=09u8 bus;
+=09u8 devfn;
+};
+
 struct iort_fwnode {
 =09struct list_head list;
 =09struct acpi_iort_node *iort_node;
 =09struct fwnode_handle *fwnode;
+=09struct iort_pci_devid *pci_devid;
 };
 static LIST_HEAD(iort_fwnode_list);
 static DEFINE_SPINLOCK(iort_fwnode_lock);
@@ -44,7 +51,8 @@ static bool iort_type_matches(u8 type, enum iort_node_cat=
egory category)
 =09case IORT_IOMMU_TYPE:
 =09=09return type =3D=3D ACPI_IORT_NODE_SMMU ||
 =09=09       type =3D=3D ACPI_IORT_NODE_SMMU_V3 ||
-=09=09       type =3D=3D ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU;
+=09=09       type =3D=3D ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU ||
+=09=09       type =3D=3D ACPI_VIOT_IORT_NODE_VIRTIO_PCI_IOMMU;
 =09case IORT_MSI_TYPE:
 =09=09return type =3D=3D ACPI_IORT_NODE_ITS_GROUP;
 =09default:
@@ -59,12 +67,14 @@ static bool iort_type_matches(u8 type, enum iort_node_c=
ategory category)
  *
  * @node: IORT table node associated with the IOMMU
  * @fwnode: fwnode associated with the IORT node
+ * @pci_devid: pci device ID associated with the IORT node, may be NULL
  *
  * Returns: 0 on success
  *          <0 on failure
  */
 static inline int iort_set_fwnode(struct acpi_iort_node *iort_node,
-=09=09=09=09  struct fwnode_handle *fwnode)
+=09=09=09=09  struct fwnode_handle *fwnode,
+=09=09=09=09  struct iort_pci_devid *pci_devid)
 {
 =09struct iort_fwnode *np;
=20
@@ -76,6 +86,7 @@ static inline int iort_set_fwnode(struct acpi_iort_node *=
iort_node,
 =09INIT_LIST_HEAD(&np->list);
 =09np->iort_node =3D iort_node;
 =09np->fwnode =3D fwnode;
+=09np->pci_devid =3D pci_devid;
=20
 =09spin_lock(&iort_fwnode_lock);
 =09list_add_tail(&np->list, &iort_fwnode_list);
@@ -121,6 +132,7 @@ static inline void iort_delete_fwnode(struct acpi_iort_=
node *node)
 =09spin_lock(&iort_fwnode_lock);
 =09list_for_each_entry_safe(curr, tmp, &iort_fwnode_list, list) {
 =09=09if (curr->iort_node =3D=3D node) {
+=09=09=09kfree(curr->pci_devid);
 =09=09=09list_del(&curr->list);
 =09=09=09kfree(curr);
 =09=09=09break;
@@ -870,6 +882,7 @@ static inline bool iort_iommu_driver_enabled(u8 type)
 =09case ACPI_IORT_NODE_SMMU:
 =09=09return IS_BUILTIN(CONFIG_ARM_SMMU);
 =09case ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU:
+=09case ACPI_VIOT_IORT_NODE_VIRTIO_PCI_IOMMU:
 =09=09return IS_ENABLED(CONFIG_VIRTIO_IOMMU);
 =09default:
 =09=09pr_warn("IORT node type %u does not describe an IOMMU\n", type);
@@ -1451,6 +1464,28 @@ static void __init viommu_mmio_dma_configure(struct =
device *dev,
 =09acpi_dma_configure(dev, attr);
 }
=20
+static __init struct iort_pci_devid *
+viommu_pci_get_devid(struct acpi_iort_node *node)
+{
+=09unsigned int val;
+=09struct iort_pci_devid *devid;
+=09struct acpi_viot_iort_virtio_pci_iommu *viommu;
+
+=09viommu =3D (struct acpi_viot_iort_virtio_pci_iommu *)node->node_data;
+
+=09val =3D le32_to_cpu(viommu->devid);
+
+=09devid =3D kzalloc(sizeof(*devid), GFP_KERNEL);
+=09if (!devid)
+=09=09return ERR_PTR(-ENOMEM);
+
+=09devid->segment =3D val >> 16;
+=09devid->bus =3D PCI_BUS_NUM(val);
+=09devid->devfn =3D val & 0xff;
+
+=09return devid;
+}
+
 struct iort_dev_config {
 =09const char *name;
 =09int (*dev_init)(struct acpi_iort_node *node);
@@ -1462,6 +1497,7 @@ struct iort_dev_config {
 =09int (*dev_set_proximity)(struct device *dev,
 =09=09=09=09    struct acpi_iort_node *node);
 =09int (*dev_add_platdata)(struct platform_device *pdev);
+=09struct iort_pci_devid *(*dev_get_pci_devid)(struct acpi_iort_node *node=
);
 };
=20
 static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst =3D {
@@ -1494,6 +1530,10 @@ static const struct iort_dev_config iort_viommu_mmio=
_cfg __initconst =3D {
 =09.dev_init_resources =3D viommu_mmio_init_resources,
 };
=20
+static const struct iort_dev_config iort_viommu_pci_cfg __initconst =3D {
+=09.dev_get_pci_devid =3D viommu_pci_get_devid,
+};
+
 static __init const struct iort_dev_config *iort_get_dev_cfg(
 =09=09=09struct acpi_iort_node *node)
 {
@@ -1510,6 +1550,8 @@ static __init const struct iort_dev_config *iort_get_=
dev_cfg(
 =09=09switch (node->type) {
 =09=09case ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU:
 =09=09=09return &iort_viommu_mmio_cfg;
+=09=09case ACPI_VIOT_IORT_NODE_VIRTIO_PCI_IOMMU:
+=09=09=09return &iort_viommu_pci_cfg;
 =09=09}
 =09}
=20
@@ -1641,13 +1683,55 @@ static void __init iort_enable_acs(struct acpi_iort=
_node *iort_node)
 static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
 #endif
=20
-static void __init iort_init_platform_devices(void)
+static int __init iort_init_node(struct acpi_iort_node *iort_node)
+{
+=09int ret;
+=09const struct iort_dev_config *ops;
+=09struct fwnode_handle *fwnode;
+
+=09iort_enable_acs(iort_node);
+
+=09ops =3D iort_get_dev_cfg(iort_node);
+=09if (!ops)
+=09=09return 0;
+
+=09if (ops->dev_get_pci_devid) {
+=09=09struct iort_pci_devid *pci_devid =3D
+=09=09=09ops->dev_get_pci_devid(iort_node);
+
+=09=09if (IS_ERR(pci_devid))
+=09=09=09return PTR_ERR(pci_devid);
+=09=09/*
+=09=09 * For a PCI-based IOMMU, set the pci_devid handle now, but
+=09=09 * leave the fwnode empty. It will be completed later when the
+=09=09 * PCI device gets probed.
+=09=09 */
+=09=09iort_set_fwnode(iort_node, NULL, pci_devid);
+
+=09=09return 0;
+=09}
+
+=09fwnode =3D acpi_alloc_fwnode_static();
+=09if (!fwnode)
+=09=09return -ENOMEM;
+
+=09iort_set_fwnode(iort_node, fwnode, NULL);
+
+=09ret =3D iort_add_platform_device(iort_node, ops);
+=09if (ret) {
+=09=09iort_delete_fwnode(iort_node);
+=09=09acpi_free_fwnode_static(fwnode);
+=09=09return ret;
+=09}
+
+=09return 0;
+}
+
+static void __init iort_init_devices(void)
 {
 =09struct acpi_iort_node *iort_node, *iort_end;
 =09struct acpi_table_iort *iort;
-=09struct fwnode_handle *fwnode;
-=09int i, ret;
-=09const struct iort_dev_config *ops;
+=09int i;
=20
 =09/*
 =09 * iort_table and iort both point to the start of IORT table, but
@@ -1667,23 +1751,8 @@ static void __init iort_init_platform_devices(void)
 =09=09=09return;
 =09=09}
=20
-=09=09iort_enable_acs(iort_node);
-
-=09=09ops =3D iort_get_dev_cfg(iort_node);
-=09=09if (ops) {
-=09=09=09fwnode =3D acpi_alloc_fwnode_static();
-=09=09=09if (!fwnode)
-=09=09=09=09return;
-
-=09=09=09iort_set_fwnode(iort_node, fwnode);
-
-=09=09=09ret =3D iort_add_platform_device(iort_node, ops);
-=09=09=09if (ret) {
-=09=09=09=09iort_delete_fwnode(iort_node);
-=09=09=09=09acpi_free_fwnode_static(fwnode);
-=09=09=09=09return;
-=09=09=09}
-=09=09}
+=09=09if (iort_init_node(iort_node))
+=09=09=09return;
=20
 =09=09iort_node =3D ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
 =09=09=09=09=09 iort_node->length);
@@ -1703,7 +1772,7 @@ void __init acpi_iort_register_table(struct acpi_tabl=
e_header *table,
 =09iort_table =3D table;
 =09iort_table_source =3D source;
=20
-=09iort_init_platform_devices();
+=09iort_init_devices();
 }
=20
 void __init acpi_iort_init(void)
--=20
2.24.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

