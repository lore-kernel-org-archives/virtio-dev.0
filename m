Return-Path: virtio-dev-return-7274-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B926985EA7
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 May 2020 14:03:22 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 May 2020 16:01:31 +0200
Message-Id: <20200507140139.17083-8-david@redhat.com>
In-Reply-To: <20200507140139.17083-1-david@redhat.com>
References: <20200507140139.17083-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v4 07/15] virtio-mem: Allow to offline partially unplugged memory blocks
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Jason Wang <jasowang@redhat.com>, Oscar Salvador <osalvador@suse.de>, Igor Mammedov <imammedo@redhat.com>, Dave Young <dyoung@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>
List-ID: <virtio-dev.lists.oasis-open.org>

Dropping the reference count of PageOffline() pages during MEM_GOING_ONLINE
allows offlining code to skip them. However, we also have to clear
PG_reserved, because PG_reserved pages get detected as unmovable right
away. Take care of restoring the reference count when offlining is
canceled.

Clarify why we don't have to perform any action when unloading the
driver. Also, let's add a warning if anybody is still holding a
reference to unplugged pages when offlining.

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
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 68 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 74f0d3cb1d22..b0b41c73ce89 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -572,6 +572,57 @@ static void virtio_mem_notify_online(struct virtio_mem=
 *vm, unsigned long mb_id,
 =09=09virtio_mem_retry(vm);
 }
=20
+static void virtio_mem_notify_going_offline(struct virtio_mem *vm,
+=09=09=09=09=09    unsigned long mb_id)
+{
+=09const unsigned long nr_pages =3D PFN_DOWN(vm->subblock_size);
+=09struct page *page;
+=09unsigned long pfn;
+=09int sb_id, i;
+
+=09for (sb_id =3D 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
+=09=09if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
+=09=09=09continue;
+=09=09/*
+=09=09 * Drop our reference to the pages so the memory can get
+=09=09 * offlined and add the unplugged pages to the managed
+=09=09 * page counters (so offlining code can correctly subtract
+=09=09 * them again).
+=09=09 */
+=09=09pfn =3D PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
+=09=09=09       sb_id * vm->subblock_size);
+=09=09adjust_managed_page_count(pfn_to_page(pfn), nr_pages);
+=09=09for (i =3D 0; i < nr_pages; i++) {
+=09=09=09page =3D pfn_to_page(pfn + i);
+=09=09=09if (WARN_ON(!page_ref_dec_and_test(page)))
+=09=09=09=09dump_page(page, "unplugged page referenced");
+=09=09}
+=09}
+}
+
+static void virtio_mem_notify_cancel_offline(struct virtio_mem *vm,
+=09=09=09=09=09     unsigned long mb_id)
+{
+=09const unsigned long nr_pages =3D PFN_DOWN(vm->subblock_size);
+=09unsigned long pfn;
+=09int sb_id, i;
+
+=09for (sb_id =3D 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
+=09=09if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
+=09=09=09continue;
+=09=09/*
+=09=09 * Get the reference we dropped when going offline and
+=09=09 * subtract the unplugged pages from the managed page
+=09=09 * counters.
+=09=09 */
+=09=09pfn =3D PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
+=09=09=09       sb_id * vm->subblock_size);
+=09=09adjust_managed_page_count(pfn_to_page(pfn), -nr_pages);
+=09=09for (i =3D 0; i < nr_pages; i++)
+=09=09=09page_ref_inc(pfn_to_page(pfn + i));
+=09}
+}
+
 /*
  * This callback will either be called synchronously from add_memory() or
  * asynchronously (e.g., triggered via user space). We have to be careful
@@ -618,6 +669,7 @@ static int virtio_mem_memory_notifier_cb(struct notifie=
r_block *nb,
 =09=09=09break;
 =09=09}
 =09=09vm->hotplug_active =3D true;
+=09=09virtio_mem_notify_going_offline(vm, mb_id);
 =09=09break;
 =09case MEM_GOING_ONLINE:
 =09=09mutex_lock(&vm->hotplug_mutex);
@@ -642,6 +694,12 @@ static int virtio_mem_memory_notifier_cb(struct notifi=
er_block *nb,
 =09=09mutex_unlock(&vm->hotplug_mutex);
 =09=09break;
 =09case MEM_CANCEL_OFFLINE:
+=09=09if (!vm->hotplug_active)
+=09=09=09break;
+=09=09virtio_mem_notify_cancel_offline(vm, mb_id);
+=09=09vm->hotplug_active =3D false;
+=09=09mutex_unlock(&vm->hotplug_mutex);
+=09=09break;
 =09case MEM_CANCEL_ONLINE:
 =09=09if (!vm->hotplug_active)
 =09=09=09break;
@@ -668,8 +726,11 @@ static void virtio_mem_set_fake_offline(unsigned long =
pfn,
 =09=09struct page *page =3D pfn_to_page(pfn);
=20
 =09=09__SetPageOffline(page);
-=09=09if (!onlined)
+=09=09if (!onlined) {
 =09=09=09SetPageDirty(page);
+=09=09=09/* FIXME: remove after cleanups */
+=09=09=09ClearPageReserved(page);
+=09=09}
 =09}
 }
=20
@@ -1722,6 +1783,11 @@ static void virtio_mem_remove(struct virtio_device *=
vdev)
 =09=09BUG_ON(rc);
 =09=09virtio_mem_mb_set_state(vm, mb_id, VIRTIO_MEM_MB_STATE_UNUSED);
 =09}
+=09/*
+=09 * After we unregistered our callbacks, user space can no longer
+=09 * offline partially plugged online memory blocks. No need to worry
+=09 * about them.
+=09 */
=20
 =09/* unregister callbacks */
 =09unregister_virtio_mem_device(vm);
--=20
2.25.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

