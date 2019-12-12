Return-Path: virtio-dev-return-6502-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F9A2985DBB
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Dec 2019 17:12:45 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu, 12 Dec 2019 18:11:29 +0100
Message-Id: <20191212171137.13872-6-david@redhat.com>
In-Reply-To: <20191212171137.13872-1-david@redhat.com>
References: <20191212171137.13872-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH RFC v4 05/13] virtio-mem: Paravirtualized memory hotunplug part 2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>, Oscar Salvador <osalvador@suse.de>, Igor Mammedov <imammedo@redhat.com>, Dave Young <dyoung@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>
List-ID: <virtio-dev.lists.oasis-open.org>

We can use alloc_contig_range() to try to unplug subblocks. Unplugged
blocks will be marked PG_offline, however, don't have the PG_reserved
flag set. This way, we can differentiate these allocated subblocks from
subblocks that were never onlined and handle them properly in
virtio_mem_fake_online(). free_contig_range() is used to hand back
subblocks to Linux.

It is worth noting that there are no guarantess on how much memory can
actually get unplugged again. All device memory might completely be
fragmented with unmovable data, such that no subblock can get unplugged.
We might want to improve the unplugging capability in the future.

We are not touching the ZONE_MOVABLE. If memory is onlined to the
ZONE_MOVABLE, it can only get unplugged after that memory was offlined
manually by user space. In normal operation, virtio-mem memory is
suggested to be onlined to ZONE_NORMAL. In the future, we will try to
make unplug more likely to succeed.

Add a module parameter to control if online memory shall be touched.

Future work:
- Performance improvements:
-- Sense (lockless) if it make sense to try alloc_contig_range() at all
   before directly trying to isolate and taking locks.
-- Try to unplug bigger chunks if possible first.
-- Identify free areas first, that don't have to be evacuated.
- Make unplug more likely to succeed:
-- There are various idea to limit fragmentation on memory block
   granularity. (e.g., ZONE_PREFER_MOVABLE and smart balancing)
-- Allocate memmap from added memory. This way, less unmovable data can
   end up on the memory blocks.
- OOM handling, e.g., via an OOM handler.
- Defragmentation
-- Will require a new virtio-mem CMD to exchange plugged<->unplugged blocks

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
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/Kconfig      |   1 +
 drivers/virtio/virtio_mem.c | 156 ++++++++++++++++++++++++++++++++----
 2 files changed, 143 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 294720d53057..75a760f32ec7 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -71,6 +71,7 @@ config VIRTIO_MEM
 =09depends on VIRTIO
 =09depends on MEMORY_HOTPLUG_SPARSE
 =09depends on MEMORY_HOTREMOVE
+=09select CONTIG_ALLOC
 =09help
 =09 This driver provides access to virtio-mem paravirtualized memory
 =09 devices, allowing to hotplug and hotunplug memory.
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index f1af05def5df..5a142a371222 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -21,6 +21,10 @@
=20
 #include <acpi/acpi_numa.h>
=20
+static bool unplug_online =3D true;
+module_param(unplug_online, bool, 0644);
+MODULE_PARM_DESC(unplug_online, "Try to unplug online memory");
+
 enum virtio_mem_mb_state {
 =09/* Unplugged, not added to Linux. Can be reused later. */
 =09VIRTIO_MEM_MB_STATE_UNUSED =3D 0,
@@ -646,23 +650,35 @@ static int virtio_mem_memory_notifier_cb(struct notif=
ier_block *nb,
 }
=20
 /*
- * Set a range of pages PG_offline.
+ * Set a range of pages PG_offline. Remember pages that were never onlined
+ * (via generic_online_page()) using PageDirty().
  */
 static void virtio_mem_set_fake_offline(unsigned long pfn,
-=09=09=09=09=09unsigned int nr_pages)
+=09=09=09=09=09unsigned int nr_pages, bool onlined)
 {
-=09for (; nr_pages--; pfn++)
-=09=09__SetPageOffline(pfn_to_page(pfn));
+=09for (; nr_pages--; pfn++) {
+=09=09struct page *page =3D pfn_to_page(pfn);
+
+=09=09__SetPageOffline(page);
+=09=09if (!onlined)
+=09=09=09SetPageDirty(page);
+=09}
 }
=20
 /*
- * Clear PG_offline from a range of pages.
+ * Clear PG_offline from a range of pages. If the pages were never onlined=
,
+ * (via generic_online_page()), clear PageDirty().
  */
 static void virtio_mem_clear_fake_offline(unsigned long pfn,
-=09=09=09=09=09  unsigned int nr_pages)
+=09=09=09=09=09  unsigned int nr_pages, bool onlined)
 {
-=09for (; nr_pages--; pfn++)
-=09=09__ClearPageOffline(pfn_to_page(pfn));
+=09for (; nr_pages--; pfn++) {
+=09=09struct page *page =3D pfn_to_page(pfn);
+
+=09=09__ClearPageOffline(page);
+=09=09if (!onlined)
+=09=09=09ClearPageDirty(page);
+=09}
 }
=20
 /*
@@ -681,10 +697,26 @@ static void virtio_mem_fake_online(unsigned long pfn,=
 unsigned int nr_pages)
 =09BUG_ON(!IS_ALIGNED(pfn, 1 << order));
 =09BUG_ON(!IS_ALIGNED(nr_pages, 1 << order));
=20
-=09virtio_mem_clear_fake_offline(pfn, nr_pages);
+=09for (i =3D 0; i < nr_pages; i +=3D 1 << order) {
+=09=09struct page *page =3D pfn_to_page(pfn + i);
=20
-=09for (i =3D 0; i < nr_pages; i +=3D 1 << order)
-=09=09generic_online_page(pfn_to_page(pfn + i), order);
+=09=09/*
+=09=09 * If the page is PageDirty(), it was kept fake-offline when
+=09=09 * onlining the memory block. Otherwise, it was allocated
+=09=09 * using alloc_contig_range(). All pages in a subblock are
+=09=09 * alike.
+=09=09 */
+=09=09if (PageDirty(page)) {
+=09=09=09virtio_mem_clear_fake_offline(pfn + i, 1 << order,
+=09=09=09=09=09=09      false);
+=09=09=09generic_online_page(page, order);
+=09=09} else {
+=09=09=09virtio_mem_clear_fake_offline(pfn + i, 1 << order,
+=09=09=09=09=09=09      true);
+=09=09=09free_contig_range(pfn + i, 1 << order);
+=09=09=09adjust_managed_page_count(page, 1 << order);
+=09=09}
+=09}
 }
=20
 static void virtio_mem_online_page_cb(struct page *page, unsigned int orde=
r)
@@ -713,7 +745,8 @@ static void virtio_mem_online_page_cb(struct page *page=
, unsigned int order)
 =09=09if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
 =09=09=09generic_online_page(page, order);
 =09=09else
-=09=09=09virtio_mem_set_fake_offline(PFN_DOWN(addr), 1 << order);
+=09=09=09virtio_mem_set_fake_offline(PFN_DOWN(addr), 1 << order,
+=09=09=09=09=09=09    false);
 =09=09rcu_read_unlock();
 =09=09return;
 =09}
@@ -1181,6 +1214,72 @@ static int virtio_mem_mb_unplug_any_sb_offline(struc=
t virtio_mem *vm,
 =09return 0;
 }
=20
+/*
+ * Unplug the desired number of plugged subblocks of an online memory bloc=
k.
+ * Will skip subblock that are busy.
+ *
+ * Will modify the state of the memory block.
+ *
+ * Note: Can fail after some subblocks were successfully unplugged. Can
+ *       return 0 even if subblocks were busy and could not get unplugged.
+ */
+static int virtio_mem_mb_unplug_any_sb_online(struct virtio_mem *vm,
+=09=09=09=09=09      unsigned long mb_id,
+=09=09=09=09=09      uint64_t *nb_sb)
+{
+=09const unsigned long nr_pages =3D PFN_DOWN(vm->subblock_size);
+=09unsigned long start_pfn;
+=09int rc, sb_id;
+
+=09/*
+=09 * TODO: To increase the performance we want to try bigger, consecutive
+=09 * subblocks first before falling back to single subblocks. Also,
+=09 * we should sense via something like is_mem_section_removable()
+=09 * first if it makes sense to go ahead any try to allocate.
+=09 */
+=09for (sb_id =3D 0; sb_id < vm->nb_sb_per_mb && *nb_sb; sb_id++) {
+=09=09/* Find the next candidate subblock */
+=09=09while (sb_id < vm->nb_sb_per_mb &&
+=09=09       !virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
+=09=09=09sb_id++;
+=09=09if (sb_id >=3D vm->nb_sb_per_mb)
+=09=09=09break;
+
+=09=09start_pfn =3D PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
+=09=09=09=09     sb_id * vm->subblock_size);
+=09=09rc =3D alloc_contig_range(start_pfn, start_pfn + nr_pages,
+=09=09=09=09=09MIGRATE_MOVABLE, GFP_KERNEL);
+=09=09if (rc =3D=3D -ENOMEM)
+=09=09=09/* whoops, out of memory */
+=09=09=09return rc;
+=09=09if (rc)
+=09=09=09/* memory busy, we can't unplug this chunk */
+=09=09=09continue;
+
+=09=09/* Mark it as fake-offline before unplugging it */
+=09=09virtio_mem_set_fake_offline(start_pfn, nr_pages, true);
+=09=09adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
+
+=09=09/* Try to unplug the allocated memory */
+=09=09rc =3D virtio_mem_mb_unplug_sb(vm, mb_id, sb_id, 1);
+=09=09if (rc) {
+=09=09=09/* Return the memory to the buddy. */
+=09=09=09virtio_mem_fake_online(start_pfn, nr_pages);
+=09=09=09return rc;
+=09=09}
+
+=09=09virtio_mem_mb_set_state(vm, mb_id,
+=09=09=09=09=09VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL);
+=09=09*nb_sb -=3D 1;
+=09}
+
+=09/*
+=09 * TODO: Once all subblocks of a memory block were unplugged, we want
+=09 * to offline the memory block and remove it.
+=09 */
+=09return 0;
+}
+
 /*
  * Try to unplug the requested amount of memory.
  */
@@ -1219,8 +1318,36 @@ static int virtio_mem_unplug_request(struct virtio_m=
em *vm, uint64_t diff)
 =09=09cond_resched();
 =09}
=20
+=09if (!unplug_online) {
+=09=09mutex_unlock(&vm->hotplug_mutex);
+=09=09return 0;
+=09}
+
+=09/* Try to unplug subblocks of partially plugged online blocks. */
+=09virtio_mem_for_each_mb_state(vm, mb_id,
+=09=09=09=09     VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL) {
+=09=09rc =3D virtio_mem_mb_unplug_any_sb_online(vm, mb_id,
+=09=09=09=09=09=09=09&nb_sb);
+=09=09if (rc || !nb_sb)
+=09=09=09goto out_unlock;
+=09=09mutex_unlock(&vm->hotplug_mutex);
+=09=09cond_resched();
+=09=09mutex_lock(&vm->hotplug_mutex);
+=09}
+
+=09/* Try to unplug subblocks of plugged online blocks. */
+=09virtio_mem_for_each_mb_state(vm, mb_id, VIRTIO_MEM_MB_STATE_ONLINE) {
+=09=09rc =3D virtio_mem_mb_unplug_any_sb_online(vm, mb_id,
+=09=09=09=09=09=09=09&nb_sb);
+=09=09if (rc || !nb_sb)
+=09=09=09goto out_unlock;
+=09=09mutex_unlock(&vm->hotplug_mutex);
+=09=09cond_resched();
+=09=09mutex_lock(&vm->hotplug_mutex);
+=09}
+
 =09mutex_unlock(&vm->hotplug_mutex);
-=09return 0;
+=09return nb_sb ? -EBUSY : 0;
 out_unlock:
 =09mutex_unlock(&vm->hotplug_mutex);
 =09return rc;
@@ -1324,7 +1451,8 @@ static void virtio_mem_run_wq(struct work_struct *wor=
k)
 =09case -EBUSY:
 =09=09/*
 =09=09 * The hypervisor cannot process our request right now
-=09=09 * (e.g., out of memory, migrating).
+=09=09 * (e.g., out of memory, migrating) or we cannot free up
+=09=09 * any memory to unplug it (all plugged memory is busy).
 =09=09 */
 =09case -ENOMEM:
 =09=09/* Out of memory, try again later. */
--=20
2.23.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

