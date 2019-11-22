Return-Path: virtio-dev-return-6379-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4E213986088
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Nov 2019 10:51:08 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri, 22 Nov 2019 11:49:55 +0100
Message-Id: <20191122105000.800410-9-jean-philippe@linaro.org>
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC 08/13] ACPI/IORT: Add callback to update a device's fwnode
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, jacob.jun.pan@intel.com, eric.auger@redhat.com, sebastien.boeuf@intel.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

For a PCI-based IOMMU, IORT isn't in charge of allocating a fwnode. Let
the IOMMU driver update the fwnode associated to an IORT node when
available.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/iort.c       | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/acpi_iort.h |  4 ++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index f08f72d8af78..8263ab275b2b 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -1038,11 +1038,49 @@ const struct iommu_ops *iort_iommu_configure(struct=
 device *dev)
=20
 =09return ops;
 }
+
+/**
+ * iort_iommu_update_fwnode - update fwnode of a PCI IOMMU
+ * @dev: the IOMMU device
+ * @fwnode: the fwnode, or NULL to remove an existing fwnode
+ *
+ * A PCI device isn't instantiated by the IORT driver. The IOMMU driver se=
ts or
+ * removes its fwnode using this function.
+ */
+void iort_iommu_update_fwnode(struct device *dev, struct fwnode_handle *fw=
node)
+{
+=09struct pci_dev *pdev;
+=09struct iort_fwnode *curr;
+=09struct iort_pci_devid *devid;
+
+=09if (!dev_is_pci(dev))
+=09=09return;
+
+=09pdev =3D to_pci_dev(dev);
+
+=09spin_lock(&iort_fwnode_lock);
+=09list_for_each_entry(curr, &iort_fwnode_list, list) {
+=09=09devid =3D curr->pci_devid;
+=09=09if (devid &&
+=09=09    pci_domain_nr(pdev->bus) =3D=3D devid->segment &&
+=09=09    pdev->bus->number =3D=3D devid->bus &&
+=09=09    pdev->devfn =3D=3D devid->devfn) {
+=09=09=09WARN_ON(fwnode && curr->fwnode);
+=09=09=09curr->fwnode =3D fwnode;
+=09=09=09break;
+=09=09}
+=09}
+=09spin_unlock(&iort_fwnode_lock);
+}
+EXPORT_SYMBOL_GPL(iort_iommu_update_fwnode);
 #else
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *=
head)
 { return 0; }
 const struct iommu_ops *iort_iommu_configure(struct device *dev)
 { return NULL; }
+static void iort_iommu_update_fwnode(struct device *dev,
+=09=09=09=09     struct fwnode_handle *fwnode)
+{ }
 #endif
=20
 static int nc_dma_get_range(struct device *dev, u64 *size)
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index f4db5fff07cf..840635e40d9d 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -43,6 +43,7 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)=
;
 void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *size);
 const struct iommu_ops *iort_iommu_configure(struct device *dev);
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *=
head);
+void iort_iommu_update_fwnode(struct device *dev, struct fwnode_handle *fw=
node);
 #else
 static void acpi_iort_register_table(struct acpi_table_header *table,
 =09=09=09=09     enum iort_table_source source)
@@ -63,6 +64,9 @@ static inline const struct iommu_ops *iort_iommu_configur=
e(
 static inline
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *=
head)
 { return 0; }
+static void iort_iommu_update_fwnode(struct device *dev,
+=09=09=09=09     struct fwnode_handle *fwnode)
+{ }
 #endif
=20
 #endif /* __ACPI_IORT_H__ */
--=20
2.24.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

