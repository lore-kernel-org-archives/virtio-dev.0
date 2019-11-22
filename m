Return-Path: virtio-dev-return-6374-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5358B9860CE
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Nov 2019 10:51:08 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri, 22 Nov 2019 11:49:56 +0100
Message-Id: <20191122105000.800410-10-jean-philippe@linaro.org>
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC 09/13] iommu/virtio: Create fwnode if necessary
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, jacob.jun.pan@intel.com, eric.auger@redhat.com, sebastien.boeuf@intel.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

The presence of a fwnode on a PCI device depends on the platform. QEMU
q35, for example, creates an ACPI description for each PCI slot, but
QEMU virt (aarch64) doesn't. Since the IOMMU subsystem relies heavily on
fwnode to discover the DMA topology, create a fwnode for the
virtio-iommu if necessary, using the software_node framework.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 56 ++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 3ea9d7682999..8efa368134c0 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -966,6 +966,48 @@ static struct iommu_ops viommu_ops =3D {
 =09.of_xlate=09=09=3D viommu_of_xlate,
 };
=20
+static int viommu_set_fwnode(struct viommu_dev *viommu)
+{
+=09/*
+=09 * viommu->dev is the virtio device, its parent is the associated
+=09 * transport device.
+=09 */
+=09struct device *dev =3D viommu->dev->parent;
+
+=09/*
+=09 * With device tree a fwnode is always present. With ACPI, on some
+=09 * platforms a PCI device has a DSDT node describing the slot. On other
+=09 * platforms, no fwnode is created and we have to do it ourselves.
+=09 */
+=09if (!dev->fwnode) {
+=09=09struct fwnode_handle *fwnode;
+
+=09=09fwnode =3D fwnode_create_software_node(NULL, NULL);
+=09=09if (IS_ERR(fwnode))
+=09=09=09return PTR_ERR(fwnode);
+
+=09=09set_primary_fwnode(dev, fwnode);
+=09}
+
+=09iommu_device_set_fwnode(&viommu->iommu, dev->fwnode);
+=09return 0;
+}
+
+static void viommu_clear_fwnode(struct viommu_dev *viommu)
+{
+=09struct device *dev =3D viommu->dev->parent;
+
+=09if (!dev->fwnode)
+=09=09return;
+
+=09if (is_software_node(dev->fwnode)) {
+=09=09struct fwnode_handle *fwnode =3D dev->fwnode;
+
+=09=09set_primary_fwnode(dev, NULL);
+=09=09fwnode_remove_software_node(fwnode);
+=09}
+}
+
 static int viommu_init_vqs(struct viommu_dev *viommu)
 {
 =09struct virtio_device *vdev =3D dev_to_virtio(viommu->dev);
@@ -1004,7 +1046,6 @@ static int viommu_fill_evtq(struct viommu_dev *viommu=
)
=20
 static int viommu_probe(struct virtio_device *vdev)
 {
-=09struct device *parent_dev =3D vdev->dev.parent;
 =09struct viommu_dev *viommu =3D NULL;
 =09struct device *dev =3D &vdev->dev;
 =09u64 input_start =3D 0;
@@ -1084,9 +1125,11 @@ static int viommu_probe(struct virtio_device *vdev)
 =09if (ret)
 =09=09goto err_free_vqs;
=20
-=09iommu_device_set_ops(&viommu->iommu, &viommu_ops);
-=09iommu_device_set_fwnode(&viommu->iommu, parent_dev->fwnode);
+=09ret =3D viommu_set_fwnode(viommu);
+=09if (ret)
+=09=09goto err_sysfs_remove;
=20
+=09iommu_device_set_ops(&viommu->iommu, &viommu_ops);
 =09iommu_device_register(&viommu->iommu);
=20
 #ifdef CONFIG_PCI
@@ -1119,8 +1162,10 @@ static int viommu_probe(struct virtio_device *vdev)
 =09return 0;
=20
 err_unregister:
-=09iommu_device_sysfs_remove(&viommu->iommu);
 =09iommu_device_unregister(&viommu->iommu);
+=09viommu_clear_fwnode(viommu);
+err_sysfs_remove:
+=09iommu_device_sysfs_remove(&viommu->iommu);
 err_free_vqs:
 =09vdev->config->del_vqs(vdev);
=20
@@ -1131,8 +1176,9 @@ static void viommu_remove(struct virtio_device *vdev)
 {
 =09struct viommu_dev *viommu =3D vdev->priv;
=20
-=09iommu_device_sysfs_remove(&viommu->iommu);
 =09iommu_device_unregister(&viommu->iommu);
+=09viommu_clear_fwnode(viommu);
+=09iommu_device_sysfs_remove(&viommu->iommu);
=20
 =09/* Stop all virtqueues */
 =09vdev->config->reset(vdev);
--=20
2.24.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

