Return-Path: virtio-dev-return-7270-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 697A8985E59
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 May 2020 14:02:36 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 May 2020 16:01:27 +0200
Message-Id: <20200507140139.17083-4-david@redhat.com>
In-Reply-To: <20200507140139.17083-1-david@redhat.com>
References: <20200507140139.17083-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v4 03/15] virtio-mem: Allow to specify an ACPI PXM as nid
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Jason Wang <jasowang@redhat.com>, Oscar Salvador <osalvador@suse.de>, Igor Mammedov <imammedo@redhat.com>, Dave Young <dyoung@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

We want to allow to specify (similar as for a DIMM), to which node a
virtio-mem device (and, therefore, its memory) belongs. Add a new
virtio-mem feature flag and export pxm_to_node, so it can be used in kernel
module context.

Acked-by: Michal Hocko <mhocko@suse.com> # for the export
Acked-by: "Rafael J. Wysocki" <rafael@kernel.org> # for the export
Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Tested-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/acpi/numa/srat.c        |  1 +
 drivers/virtio/virtio_mem.c     | 39 +++++++++++++++++++++++++++++++--
 include/uapi/linux/virtio_mem.h | 10 ++++++++-
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 47b4969d9b93..5be5a977da1b 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -35,6 +35,7 @@ int pxm_to_node(int pxm)
 =09=09return NUMA_NO_NODE;
 =09return pxm_to_node_map[pxm];
 }
+EXPORT_SYMBOL(pxm_to_node);
=20
 int node_to_pxm(int node)
 {
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 5d1dcaa6fc42..270ddeaec059 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -21,6 +21,8 @@
 #include <linux/bitmap.h>
 #include <linux/lockdep.h>
=20
+#include <acpi/acpi_numa.h>
+
 enum virtio_mem_mb_state {
 =09/* Unplugged, not added to Linux. Can be reused later. */
 =09VIRTIO_MEM_MB_STATE_UNUSED =3D 0,
@@ -72,6 +74,8 @@ struct virtio_mem {
=20
 =09/* The device block size (for communicating with the device). */
 =09uint32_t device_block_size;
+=09/* The translated node id. NUMA_NO_NODE in case not specified. */
+=09int nid;
 =09/* Physical start address of the memory region. */
 =09uint64_t addr;
 =09/* Maximum region size in bytes. */
@@ -389,7 +393,10 @@ static int virtio_mem_sb_bitmap_prepare_next_mb(struct=
 virtio_mem *vm)
 static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
 {
 =09const uint64_t addr =3D virtio_mem_mb_id_to_phys(mb_id);
-=09int nid =3D memory_add_physaddr_to_nid(addr);
+=09int nid =3D vm->nid;
+
+=09if (nid =3D=3D NUMA_NO_NODE)
+=09=09nid =3D memory_add_physaddr_to_nid(addr);
=20
 =09dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
 =09return add_memory(nid, addr, memory_block_size_bytes());
@@ -407,7 +414,10 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, un=
signed long mb_id)
 static int virtio_mem_mb_remove(struct virtio_mem *vm, unsigned long mb_id=
)
 {
 =09const uint64_t addr =3D virtio_mem_mb_id_to_phys(mb_id);
-=09int nid =3D memory_add_physaddr_to_nid(addr);
+=09int nid =3D vm->nid;
+
+=09if (nid =3D=3D NUMA_NO_NODE)
+=09=09nid =3D memory_add_physaddr_to_nid(addr);
=20
 =09dev_dbg(&vm->vdev->dev, "removing memory block: %lu\n", mb_id);
 =09return remove_memory(nid, addr, memory_block_size_bytes());
@@ -426,6 +436,17 @@ static void virtio_mem_retry(struct virtio_mem *vm)
 =09spin_unlock_irqrestore(&vm->removal_lock, flags);
 }
=20
+static int virtio_mem_translate_node_id(struct virtio_mem *vm, uint16_t no=
de_id)
+{
+=09int node =3D NUMA_NO_NODE;
+
+#if defined(CONFIG_ACPI_NUMA)
+=09if (virtio_has_feature(vm->vdev, VIRTIO_MEM_F_ACPI_PXM))
+=09=09node =3D pxm_to_node(node_id);
+#endif
+=09return node;
+}
+
 /*
  * Test if a virtio-mem device overlaps with the given range. Can be calle=
d
  * from (notifier) callbacks lockless.
@@ -1267,6 +1288,7 @@ static bool virtio_mem_any_memory_present(unsigned lo=
ng start,
 static int virtio_mem_init(struct virtio_mem *vm)
 {
 =09const uint64_t phys_limit =3D 1UL << MAX_PHYSMEM_BITS;
+=09uint16_t node_id;
=20
 =09if (!vm->vdev->config->get) {
 =09=09dev_err(&vm->vdev->dev, "config access disabled\n");
@@ -1287,6 +1309,9 @@ static int virtio_mem_init(struct virtio_mem *vm)
 =09=09     &vm->plugged_size);
 =09virtio_cread(vm->vdev, struct virtio_mem_config, block_size,
 =09=09     &vm->device_block_size);
+=09virtio_cread(vm->vdev, struct virtio_mem_config, node_id,
+=09=09     &node_id);
+=09vm->nid =3D virtio_mem_translate_node_id(vm, node_id);
 =09virtio_cread(vm->vdev, struct virtio_mem_config, addr, &vm->addr);
 =09virtio_cread(vm->vdev, struct virtio_mem_config, region_size,
 =09=09     &vm->region_size);
@@ -1365,6 +1390,8 @@ static int virtio_mem_init(struct virtio_mem *vm)
 =09=09 memory_block_size_bytes());
 =09dev_info(&vm->vdev->dev, "subblock size: 0x%x",
 =09=09 vm->subblock_size);
+=09if (vm->nid !=3D NUMA_NO_NODE)
+=09=09dev_info(&vm->vdev->dev, "nid: %d", vm->nid);
=20
 =09return 0;
 }
@@ -1508,12 +1535,20 @@ static int virtio_mem_restore(struct virtio_device =
*vdev)
 }
 #endif
=20
+static unsigned int virtio_mem_features[] =3D {
+#if defined(CONFIG_NUMA) && defined(CONFIG_ACPI_NUMA)
+=09VIRTIO_MEM_F_ACPI_PXM,
+#endif
+};
+
 static struct virtio_device_id virtio_mem_id_table[] =3D {
 =09{ VIRTIO_ID_MEM, VIRTIO_DEV_ANY_ID },
 =09{ 0 },
 };
=20
 static struct virtio_driver virtio_mem_driver =3D {
+=09.feature_table =3D virtio_mem_features,
+=09.feature_table_size =3D ARRAY_SIZE(virtio_mem_features),
 =09.driver.name =3D KBUILD_MODNAME,
 =09.driver.owner =3D THIS_MODULE,
 =09.id_table =3D virtio_mem_id_table,
diff --git a/include/uapi/linux/virtio_mem.h b/include/uapi/linux/virtio_me=
m.h
index 1bfade78bdfd..e0a9dc7397c3 100644
--- a/include/uapi/linux/virtio_mem.h
+++ b/include/uapi/linux/virtio_mem.h
@@ -83,6 +83,12 @@
  * device is busy.
  */
=20
+/* --- virtio-mem: feature bits --- */
+
+/* node_id is an ACPI PXM and is valid */
+#define VIRTIO_MEM_F_ACPI_PXM=09=090
+
+
 /* --- virtio-mem: guest -> host requests --- */
=20
 /* request to plug memory blocks */
@@ -177,7 +183,9 @@ struct virtio_mem_resp {
 struct virtio_mem_config {
 =09/* Block size and alignment. Cannot change. */
 =09__u32 block_size;
-=09__u32 padding;
+=09/* Valid with VIRTIO_MEM_F_ACPI_PXM. Cannot change. */
+=09__u16 node_id;
+=09__u16 padding;
 =09/* Start address of the memory region. Cannot change. */
 =09__u64 addr;
 =09/* Region size (maximum). Cannot change. */
--=20
2.25.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

