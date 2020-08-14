Return-Path: virtio-dev-return-7645-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ABA65985DC2
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Aug 2020 02:40:19 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 13 Aug 2020 19:39:42 -0700
Message-Id: <20200814024000.2485-7-gurchetansingh@chromium.org>
In-Reply-To: <20200814024000.2485-1-gurchetansingh@chromium.org>
References: <20200814024000.2485-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 06/24] virtio: Implement get_shm_region for PCI transport
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com, mst@redhat.com, vgoyal@redhat.com, sebastien.boeuf@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Sebastien Boeuf <sebastien.boeuf@intel.com>

On PCI the shm regions are found using capability entries;
find a region by searching for the capability.

Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 102 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_pci.h    |  11 +++-
 2 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci=
_modern.c
index db93cedd262f..484c2669e1f3 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -444,6 +444,106 @@ static void del_vq(struct virtio_pci_vq_info *info)
 =09vring_del_virtqueue(vq);
 }
=20
+static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
+=09=09=09=09   u8 *bar, u64 *offset, u64 *len)
+{
+=09int pos;
+
+=09for (pos =3D pci_find_capability(dev, PCI_CAP_ID_VNDR); pos > 0;
+=09     pos =3D pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
+=09=09u8 type, cap_len, id;
+=09=09u32 tmp32;
+=09=09u64 res_offset, res_length;
+
+=09=09pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+=09=09=09=09=09=09=09 cfg_type),
+=09=09=09=09     &type);
+
+=09=09if (type !=3D VIRTIO_PCI_CAP_SHARED_MEMORY_CFG)
+=09=09=09continue;
+
+=09=09pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+=09=09=09=09=09=09=09 cap_len),
+=09=09=09=09     &cap_len);
+
+=09=09if (cap_len !=3D sizeof(struct virtio_pci_cap64)) {
+=09=09=09dev_err(&dev->dev, "%s: shm cap with bad size offset:%d, size: %d=
\n",
+=09=09=09=09 __func__, pos, cap_len);
+=09=09=09continue;
+=09=09}
+
+=09=09pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+=09=09=09=09=09=09=09 id),
+=09=09=09=09     &id);
+=09=09if (id !=3D required_id)
+=09=09=09continue;
+
+=09=09/* Type, and ID match, looks good */
+=09=09pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+=09=09=09=09=09=09=09 bar),
+=09=09=09=09     bar);
+
+=09=09/* Read the lower 32bit of length and offset */
+=09=09pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap,
+=09=09=09=09=09=09=09  offset),
+=09=09=09=09      &tmp32);
+=09=09res_offset =3D tmp32;
+=09=09pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap,
+=09=09=09=09=09=09=09  length),
+=09=09=09=09      &tmp32);
+=09=09res_length =3D tmp32;
+
+=09=09/* and now the top half */
+=09=09pci_read_config_dword(dev,
+=09=09=09=09      pos + offsetof(struct virtio_pci_cap64,
+=09=09=09=09=09=09     offset_hi),
+=09=09=09=09      &tmp32);
+
+=09=09res_offset |=3D ((u64)tmp32) << 32;
+=09=09pci_read_config_dword(dev,
+=09=09=09=09      pos + offsetof(struct virtio_pci_cap64,
+=09=09=09=09=09=09     length_hi),
+=09=09=09=09      &tmp32);
+=09=09res_length |=3D ((u64)tmp32) << 32;
+
+=09=09*offset =3D res_offset;
+=09=09*len =3D res_length;
+
+=09=09return pos;
+=09}
+
+=09return 0;
+}
+
+static bool vp_get_shm_region(struct virtio_device *vdev,
+=09=09=09      struct virtio_shm_region *region, u8 id)
+{
+=09struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
+=09struct pci_dev *pci_dev =3D vp_dev->pci_dev;
+=09u8 bar;
+=09u64 offset, len;
+=09phys_addr_t phys_addr;
+=09size_t bar_len;
+
+=09if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len))
+=09=09return false;
+
+=09phys_addr =3D pci_resource_start(pci_dev, bar);
+=09bar_len =3D pci_resource_len(pci_dev, bar);
+
+=09if (offset + len > bar_len) {
+=09=09dev_err(&pci_dev->dev,
+=09=09=09"%s: bar shorter than cap offset+len\n",
+=09=09=09__func__);
+=09=09return false;
+=09}
+
+=09region->len =3D len;
+=09region->addr =3D (u64) phys_addr + offset;
+
+=09return true;
+}
+
 static const struct virtio_config_ops virtio_pci_config_nodev_ops =3D {
 =09.get=09=09=3D NULL,
 =09.set=09=09=3D NULL,
@@ -458,6 +558,7 @@ static const struct virtio_config_ops virtio_pci_config=
_nodev_ops =3D {
 =09.bus_name=09=3D vp_bus_name,
 =09.set_vq_affinity =3D vp_set_vq_affinity,
 =09.get_vq_affinity =3D vp_get_vq_affinity,
+=09.get_shm_region  =3D vp_get_shm_region,
 };
=20
 static const struct virtio_config_ops virtio_pci_config_ops =3D {
@@ -474,6 +575,7 @@ static const struct virtio_config_ops virtio_pci_config=
_ops =3D {
 =09.bus_name=09=3D vp_bus_name,
 =09.set_vq_affinity =3D vp_set_vq_affinity,
 =09.get_vq_affinity =3D vp_get_vq_affinity,
+=09.get_shm_region  =3D vp_get_shm_region,
 };
=20
 /**
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pc=
i.h
index 90007a1abcab..3a86f36d7e3d 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -113,6 +113,8 @@
 #define VIRTIO_PCI_CAP_DEVICE_CFG=094
 /* PCI configuration access */
 #define VIRTIO_PCI_CAP_PCI_CFG=09=095
+/* Additional shared memory capability */
+#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
=20
 /* This is the PCI capability header: */
 struct virtio_pci_cap {
@@ -121,11 +123,18 @@ struct virtio_pci_cap {
 =09__u8 cap_len;=09=09/* Generic PCI field: capability length */
 =09__u8 cfg_type;=09=09/* Identifies the structure. */
 =09__u8 bar;=09=09/* Where to find it. */
-=09__u8 padding[3];=09/* Pad to full dword. */
+=09__u8 id;=09=09/* Multiple capabilities of the same type */
+=09__u8 padding[2];=09/* Pad to full dword. */
 =09__le32 offset;=09=09/* Offset within bar. */
 =09__le32 length;=09=09/* Length of the structure, in bytes. */
 };
=20
+struct virtio_pci_cap64 {
+=09struct virtio_pci_cap cap;
+=09__le32 offset_hi;             /* Most sig 32 bits of offset */
+=09__le32 length_hi;             /* Most sig 32 bits of length */
+};
+
 struct virtio_pci_notify_cap {
 =09struct virtio_pci_cap cap;
 =09__le32 notify_off_multiplier;=09/* Multiplier for queue_notify_off. */
--=20
2.24.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

