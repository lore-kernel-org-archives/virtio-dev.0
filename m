Return-Path: virtio-dev-return-7738-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2AF44985EC1
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Sep 2020 21:09:02 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed,  2 Sep 2020 14:08:30 -0700
Message-Id: <20200902210847.2689-7-gurchetansingh@chromium.org>
In-Reply-To: <20200902210847.2689-1-gurchetansingh@chromium.org>
References: <20200902210847.2689-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 06/23] virtio: Implement get_shm_region for MMIO transport
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: sebastien.boeuf@intel.com, kraxel@redhat.com, vgoyal@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Sebastien Boeuf <sebastien.boeuf@intel.com>

On MMIO a new set of registers is defined for finding SHM
regions.  Add their definitions and use them to find the region.

Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Cc: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
---
 drivers/virtio/virtio_mmio.c     | 31 +++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_mmio.h | 11 +++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 627ac04874940..417113935b67a 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -498,6 +498,36 @@ static const char *vm_bus_name(struct virtio_device *v=
dev)
 =09return vm_dev->pdev->name;
 }
=20
+static bool vm_get_shm_region(struct virtio_device *vdev,
+=09=09=09      struct virtio_shm_region *region, u8 id)
+{
+=09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
+=09u64 len, addr;
+
+=09/* Select the region we're interested in */
+=09writel(id, vm_dev->base + VIRTIO_MMIO_SHM_SEL);
+
+=09/* Read the region size */
+=09len =3D (u64)readl(vm_dev->base + VIRTIO_MMIO_SHM_LEN_LOW);
+=09len |=3D (u64)readl(vm_dev->base + VIRTIO_MMIO_SHM_LEN_HIGH) << 32;
+
+=09region->len =3D len;
+
+=09/* Check if region length is -1. If that's the case, the shared memory
+=09 * region does not exist and there is no need to proceed further.
+=09 */
+=09if (len =3D=3D ~(u64)0)
+=09=09return false;
+
+=09/* Read the region base address */
+=09addr =3D (u64)readl(vm_dev->base + VIRTIO_MMIO_SHM_BASE_LOW);
+=09addr |=3D (u64)readl(vm_dev->base + VIRTIO_MMIO_SHM_BASE_HIGH) << 32;
+
+=09region->addr =3D addr;
+
+=09return true;
+}
+
 static const struct virtio_config_ops virtio_mmio_config_ops =3D {
 =09.get=09=09=3D vm_get,
 =09.set=09=09=3D vm_set,
@@ -510,6 +540,7 @@ static const struct virtio_config_ops virtio_mmio_confi=
g_ops =3D {
 =09.get_features=09=3D vm_get_features,
 =09.finalize_features =3D vm_finalize_features,
 =09.bus_name=09=3D vm_bus_name,
+=09.get_shm_region =3D vm_get_shm_region,
 };
=20
=20
diff --git a/include/uapi/linux/virtio_mmio.h b/include/uapi/linux/virtio_m=
mio.h
index c4b09689ab644..0650f91bea6c7 100644
--- a/include/uapi/linux/virtio_mmio.h
+++ b/include/uapi/linux/virtio_mmio.h
@@ -122,6 +122,17 @@
 #define VIRTIO_MMIO_QUEUE_USED_LOW=090x0a0
 #define VIRTIO_MMIO_QUEUE_USED_HIGH=090x0a4
=20
+/* Shared memory region id */
+#define VIRTIO_MMIO_SHM_SEL             0x0ac
+
+/* Shared memory region length, 64 bits in two halves */
+#define VIRTIO_MMIO_SHM_LEN_LOW         0x0b0
+#define VIRTIO_MMIO_SHM_LEN_HIGH        0x0b4
+
+/* Shared memory region base address, 64 bits in two halves */
+#define VIRTIO_MMIO_SHM_BASE_LOW        0x0b8
+#define VIRTIO_MMIO_SHM_BASE_HIGH       0x0bc
+
 /* Configuration atomicity value */
 #define VIRTIO_MMIO_CONFIG_GENERATION=090x0fc
=20
--=20
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

