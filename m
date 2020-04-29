Return-Path: virtio-dev-return-7208-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3E6DB985E82
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Apr 2020 16:08:45 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Apr 2020 18:08:01 +0200
Message-Id: <20200429160803.109056-2-david@redhat.com>
In-Reply-To: <20200429160803.109056-1-david@redhat.com>
References: <20200429160803.109056-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v1 1/3] mm/memory_hotplug: Prepare passing flags to add_memory() and friends
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-hyperv@vger.kernel.org, linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jason Wang <jasowang@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Pingfan Liu <kernelfans@gmail.com>, Leonardo Bras <leobras.c@gmail.com>, Nathan Lynch <nathanl@linux.ibm.com>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, Baoquan He <bhe@redhat.com>, Wei Yang <richard.weiyang@gmail.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Eric Biederman <ebiederm@xmission.com>
List-ID: <virtio-dev.lists.oasis-open.org>

We soon want to pass flags - prepare for that.

This patch is based on a similar patch by Oscar Salvador:

https://lkml.kernel.org/r/20190625075227.15193-3-osalvador@suse.de

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: Leonardo Bras <leobras.c@gmail.com>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: linux-nvdimm@lists.01.org
Cc: linux-hyperv@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: xen-devel@lists.xenproject.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/powernv/memtrace.c       |  2 +-
 arch/powerpc/platforms/pseries/hotplug-memory.c |  2 +-
 drivers/acpi/acpi_memhotplug.c                  |  2 +-
 drivers/base/memory.c                           |  2 +-
 drivers/dax/kmem.c                              |  2 +-
 drivers/hv/hv_balloon.c                         |  2 +-
 drivers/s390/char/sclp_cmd.c                    |  2 +-
 drivers/virtio/virtio_mem.c                     |  2 +-
 drivers/xen/balloon.c                           |  2 +-
 include/linux/memory_hotplug.h                  |  7 ++++---
 mm/memory_hotplug.c                             | 11 ++++++-----
 11 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platf=
orms/powernv/memtrace.c
index 13b369d2cc45..a7475d18c671 100644
--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -224,7 +224,7 @@ static int memtrace_online(void)
 =09=09=09ent->mem =3D 0;
 =09=09}
=20
-=09=09if (add_memory(ent->nid, ent->start, ent->size)) {
+=09=09if (add_memory(ent->nid, ent->start, ent->size, 0)) {
 =09=09=09pr_err("Failed to add trace memory to node %d\n",
 =09=09=09=09ent->nid);
 =09=09=09ret +=3D 1;
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc=
/platforms/pseries/hotplug-memory.c
index 5ace2f9a277e..ae44eba46ca0 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -646,7 +646,7 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
 =09block_sz =3D memory_block_size_bytes();
=20
 =09/* Add the memory */
-=09rc =3D __add_memory(lmb->nid, lmb->base_addr, block_sz);
+=09rc =3D __add_memory(lmb->nid, lmb->base_addr, block_sz, 0);
 =09if (rc) {
 =09=09invalidate_lmb_associativity_index(lmb);
 =09=09return rc;
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.=
c
index e294f44a7850..d91b3584d4b2 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -207,7 +207,7 @@ static int acpi_memory_enable_device(struct acpi_memory=
_device *mem_device)
 =09=09if (node < 0)
 =09=09=09node =3D memory_add_physaddr_to_nid(info->start_addr);
=20
-=09=09result =3D __add_memory(node, info->start_addr, info->length);
+=09=09result =3D __add_memory(node, info->start_addr, info->length, 0);
=20
 =09=09/*
 =09=09 * If the memory block has been used by the kernel, add_memory()
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 2b09b68b9f78..c0ef7d9e310a 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -432,7 +432,7 @@ static ssize_t probe_store(struct device *dev, struct d=
evice_attribute *attr,
=20
 =09nid =3D memory_add_physaddr_to_nid(phys_addr);
 =09ret =3D __add_memory(nid, phys_addr,
-=09=09=09   MIN_MEMORY_BLOCK_SIZE * sections_per_block);
+=09=09=09   MIN_MEMORY_BLOCK_SIZE * sections_per_block, 0);
=20
 =09if (ret)
 =09=09goto out;
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 3d0a7e702c94..e159184e0ba0 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -65,7 +65,7 @@ int dev_dax_kmem_probe(struct device *dev)
 =09new_res->flags =3D IORESOURCE_SYSTEM_RAM;
 =09new_res->name =3D dev_name(dev);
=20
-=09rc =3D add_memory(numa_node, new_res->start, resource_size(new_res));
+=09rc =3D add_memory(numa_node, new_res->start, resource_size(new_res), 0)=
;
 =09if (rc) {
 =09=09release_resource(new_res);
 =09=09kfree(new_res);
diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 32e3bc0aa665..0194bed1a573 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -726,7 +726,7 @@ static void hv_mem_hot_add(unsigned long start, unsigne=
d long size,
=20
 =09=09nid =3D memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
 =09=09ret =3D add_memory(nid, PFN_PHYS((start_pfn)),
-=09=09=09=09(HA_CHUNK << PAGE_SHIFT));
+=09=09=09=09(HA_CHUNK << PAGE_SHIFT), 0);
=20
 =09=09if (ret) {
 =09=09=09pr_err("hot_add memory failed error is %d\n", ret);
diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
index a864b21af602..a6a908244c74 100644
--- a/drivers/s390/char/sclp_cmd.c
+++ b/drivers/s390/char/sclp_cmd.c
@@ -406,7 +406,7 @@ static void __init add_memory_merged(u16 rn)
 =09if (!size)
 =09=09goto skip_add;
 =09for (addr =3D start; addr < start + size; addr +=3D block_size)
-=09=09add_memory(0, addr, block_size);
+=09=09add_memory(0, addr, block_size, 0);
 skip_add:
 =09first_rn =3D rn;
 =09num =3D 1;
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 96e687531933..3101cbf9e59d 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -421,7 +421,7 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, uns=
igned long mb_id)
 =09=09nid =3D memory_add_physaddr_to_nid(addr);
=20
 =09dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
-=09return add_memory(nid, addr, memory_block_size_bytes());
+=09return add_memory(nid, addr, memory_block_size_bytes(), 0);
 }
=20
 /*
diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 0c142bcab79d..6ec0373fa624 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -347,7 +347,7 @@ static enum bp_state reserve_additional_memory(void)
 =09mutex_unlock(&balloon_mutex);
 =09/* add_memory_resource() requires the device_hotplug lock */
 =09lock_device_hotplug();
-=09rc =3D add_memory_resource(nid, resource);
+=09rc =3D add_memory_resource(nid, resource, 0);
 =09unlock_device_hotplug();
 =09mutex_lock(&balloon_mutex);
=20
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.=
h
index d641828e5596..bf0e3edb8688 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -340,9 +340,10 @@ extern void set_zone_contiguous(struct zone *zone);
 extern void clear_zone_contiguous(struct zone *zone);
=20
 extern void __ref free_area_init_core_hotplug(int nid);
-extern int __add_memory(int nid, u64 start, u64 size);
-extern int add_memory(int nid, u64 start, u64 size);
-extern int add_memory_resource(int nid, struct resource *resource);
+extern int __add_memory(int nid, u64 start, u64 size, unsigned long flags)=
;
+extern int add_memory(int nid, u64 start, u64 size, unsigned long flags);
+extern int add_memory_resource(int nid, struct resource *resource,
+=09=09=09       unsigned long flags);
 extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_=
pfn,
 =09=09unsigned long nr_pages, struct vmem_altmap *altmap);
 extern void remove_pfn_range_from_zone(struct zone *zone,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 4ac6395ee2fc..ebdf6541d074 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1000,7 +1000,8 @@ static int online_memory_block(struct memory_block *m=
em, void *arg)
  *
  * we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG
  */
-int __ref add_memory_resource(int nid, struct resource *res)
+int __ref add_memory_resource(int nid, struct resource *res,
+=09=09=09      unsigned long flags)
 {
 =09struct mhp_params params =3D { .pgprot =3D PAGE_KERNEL };
 =09u64 start, size;
@@ -1078,7 +1079,7 @@ int __ref add_memory_resource(int nid, struct resourc=
e *res)
 }
=20
 /* requires device_hotplug_lock, see add_memory_resource() */
-int __ref __add_memory(int nid, u64 start, u64 size)
+int __ref __add_memory(int nid, u64 start, u64 size, unsigned long flags)
 {
 =09struct resource *res;
 =09int ret;
@@ -1087,18 +1088,18 @@ int __ref __add_memory(int nid, u64 start, u64 size=
)
 =09if (IS_ERR(res))
 =09=09return PTR_ERR(res);
=20
-=09ret =3D add_memory_resource(nid, res);
+=09ret =3D add_memory_resource(nid, res, flags);
 =09if (ret < 0)
 =09=09release_memory_resource(res);
 =09return ret;
 }
=20
-int add_memory(int nid, u64 start, u64 size)
+int add_memory(int nid, u64 start, u64 size, unsigned long flags)
 {
 =09int rc;
=20
 =09lock_device_hotplug();
-=09rc =3D __add_memory(nid, start, size);
+=09rc =3D __add_memory(nid, start, size, flags);
 =09unlock_device_hotplug();
=20
 =09return rc;
--=20
2.25.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

