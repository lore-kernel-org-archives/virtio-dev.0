Return-Path: virtio-dev-return-6373-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 36651985FC5
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Nov 2019 10:51:08 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri, 22 Nov 2019 11:49:54 +0100
Message-Id: <20191122105000.800410-8-jean-philippe@linaro.org>
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC 07/13] ACPI/IORT: Defer probe until virtio-iommu-pci has registered a fwnode
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, jacob.jun.pan@intel.com, eric.auger@redhat.com, sebastien.boeuf@intel.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

When the IOMMU is PCI-based, IORT doesn't know the fwnode until the
driver has had a chance to register it. In addition to deferring the
probe until the IOMMU ops are set, also defer the probe until the fwspec
is available.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/iort.c | 54 ++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index b517aa4e83ba..f08f72d8af78 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -61,6 +61,22 @@ static bool iort_type_matches(u8 type, enum iort_node_ca=
tegory category)
 =09}
 }
=20
+static inline bool iort_iommu_driver_enabled(u8 type)
+{
+=09switch (type) {
+=09case ACPI_IORT_NODE_SMMU_V3:
+=09=09return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
+=09case ACPI_IORT_NODE_SMMU:
+=09=09return IS_BUILTIN(CONFIG_ARM_SMMU);
+=09case ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU:
+=09case ACPI_VIOT_IORT_NODE_VIRTIO_PCI_IOMMU:
+=09=09return IS_ENABLED(CONFIG_VIRTIO_IOMMU);
+=09default:
+=09=09pr_warn("IORT node type %u does not describe an IOMMU\n", type);
+=09=09return false;
+=09}
+}
+
 /**
  * iort_set_fwnode() - Create iort_fwnode and use it to register
  *=09=09       iommu data in the iort_fwnode_list
@@ -102,9 +118,9 @@ static inline int iort_set_fwnode(struct acpi_iort_node=
 *iort_node,
  *
  * Returns: fwnode_handle pointer on success, NULL on failure
  */
-static inline struct fwnode_handle *iort_get_fwnode(
-=09=09=09struct acpi_iort_node *node)
+static inline struct fwnode_handle *iort_get_fwnode(struct acpi_iort_node =
*node)
 {
+=09int err =3D -ENODEV;
 =09struct iort_fwnode *curr;
 =09struct fwnode_handle *fwnode =3D NULL;
=20
@@ -112,12 +128,20 @@ static inline struct fwnode_handle *iort_get_fwnode(
 =09list_for_each_entry(curr, &iort_fwnode_list, list) {
 =09=09if (curr->iort_node =3D=3D node) {
 =09=09=09fwnode =3D curr->fwnode;
+=09=09=09if (!fwnode && curr->pci_devid) {
+=09=09=09=09/*
+=09=09=09=09 * Postpone probe until virtio-iommu has
+=09=09=09=09 * registered its fwnode.
+=09=09=09=09 */
+=09=09=09=09err =3D iort_iommu_driver_enabled(node->type) ?
+=09=09=09=09=09-EPROBE_DEFER : -ENODEV;
+=09=09=09}
 =09=09=09break;
 =09=09}
 =09}
 =09spin_unlock(&iort_fwnode_lock);
=20
-=09return fwnode;
+=09return fwnode ?: ERR_PTR(err);
 }
=20
 /**
@@ -874,22 +898,6 @@ int iort_iommu_msi_get_resv_regions(struct device *dev=
, struct list_head *head)
 =09return (resv =3D=3D its->its_count) ? resv : -ENODEV;
 }
=20
-static inline bool iort_iommu_driver_enabled(u8 type)
-{
-=09switch (type) {
-=09case ACPI_IORT_NODE_SMMU_V3:
-=09=09return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
-=09case ACPI_IORT_NODE_SMMU:
-=09=09return IS_BUILTIN(CONFIG_ARM_SMMU);
-=09case ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU:
-=09case ACPI_VIOT_IORT_NODE_VIRTIO_PCI_IOMMU:
-=09=09return IS_ENABLED(CONFIG_VIRTIO_IOMMU);
-=09default:
-=09=09pr_warn("IORT node type %u does not describe an IOMMU\n", type);
-=09=09return false;
-=09}
-}
-
 static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
 =09=09=09       struct fwnode_handle *fwnode,
 =09=09=09       const struct iommu_ops *ops)
@@ -920,8 +928,8 @@ static int iort_iommu_xlate(struct device *dev, struct =
acpi_iort_node *node,
 =09=09return -ENODEV;
=20
 =09iort_fwnode =3D iort_get_fwnode(node);
-=09if (!iort_fwnode)
-=09=09return -ENODEV;
+=09if (IS_ERR(iort_fwnode))
+=09=09return PTR_ERR(iort_fwnode);
=20
 =09/*
 =09 * If the ops look-up fails, this means that either
@@ -1618,8 +1626,8 @@ static int __init iort_add_platform_device(struct acp=
i_iort_node *node,
=20
 =09fwnode =3D iort_get_fwnode(node);
=20
-=09if (!fwnode) {
-=09=09ret =3D -ENODEV;
+=09if (IS_ERR(fwnode)) {
+=09=09ret =3D PTR_ERR(fwnode);
 =09=09goto dev_put;
 =09}
=20
--=20
2.24.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

