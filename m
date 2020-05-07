Return-Path: virtio-dev-return-7282-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A5196985EF4
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 May 2020 14:03:51 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 May 2020 16:01:39 +0200
Message-Id: <20200507140139.17083-16-david@redhat.com>
In-Reply-To: <20200507140139.17083-1-david@redhat.com>
References: <20200507140139.17083-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v4 15/15] virtio-mem: Try to unplug the complete online memory block first
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Right now, we always try to unplug single subblocks when processing an
online memory block. Let's try to unplug the complete online memory block
first, in case it is fully plugged and the unplug request is large
enough. Fallback to single subblocks in case the memory block cannot get
unplugged as a whole.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 88 ++++++++++++++++++++++++-------------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index abd93b778a26..9e523db3bee1 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1307,6 +1307,46 @@ static int virtio_mem_mb_unplug_any_sb_offline(struc=
t virtio_mem *vm,
 =09return 0;
 }
=20
+/*
+ * Unplug the given plugged subblocks of an online memory block.
+ *
+ * Will modify the state of the memory block.
+ */
+static int virtio_mem_mb_unplug_sb_online(struct virtio_mem *vm,
+=09=09=09=09=09  unsigned long mb_id, int sb_id,
+=09=09=09=09=09  int count)
+{
+=09const unsigned long nr_pages =3D PFN_DOWN(vm->subblock_size) * count;
+=09unsigned long start_pfn;
+=09int rc;
+
+=09start_pfn =3D PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
+=09=09=09     sb_id * vm->subblock_size);
+=09rc =3D alloc_contig_range(start_pfn, start_pfn + nr_pages,
+=09=09=09=09MIGRATE_MOVABLE, GFP_KERNEL);
+=09if (rc =3D=3D -ENOMEM)
+=09=09/* whoops, out of memory */
+=09=09return rc;
+=09if (rc)
+=09=09return -EBUSY;
+
+=09/* Mark it as fake-offline before unplugging it */
+=09virtio_mem_set_fake_offline(start_pfn, nr_pages, true);
+=09adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
+
+=09/* Try to unplug the allocated memory */
+=09rc =3D virtio_mem_mb_unplug_sb(vm, mb_id, sb_id, count);
+=09if (rc) {
+=09=09/* Return the memory to the buddy. */
+=09=09virtio_mem_fake_online(start_pfn, nr_pages);
+=09=09return rc;
+=09}
+
+=09virtio_mem_mb_set_state(vm, mb_id,
+=09=09=09=09VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL);
+=09return 0;
+}
+
 /*
  * Unplug the desired number of plugged subblocks of an online memory bloc=
k.
  * Will skip subblock that are busy.
@@ -1321,16 +1361,21 @@ static int virtio_mem_mb_unplug_any_sb_online(struc=
t virtio_mem *vm,
 =09=09=09=09=09      unsigned long mb_id,
 =09=09=09=09=09      uint64_t *nb_sb)
 {
-=09const unsigned long nr_pages =3D PFN_DOWN(vm->subblock_size);
-=09unsigned long start_pfn;
 =09int rc, sb_id;
=20
-=09/*
-=09 * TODO: To increase the performance we want to try bigger, consecutive
-=09 * subblocks first before falling back to single subblocks. Also,
-=09 * we should sense via something like is_mem_section_removable()
-=09 * first if it makes sense to go ahead any try to allocate.
-=09 */
+=09/* If possible, try to unplug the complete block in one shot. */
+=09if (*nb_sb >=3D vm->nb_sb_per_mb &&
+=09    virtio_mem_mb_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
+=09=09rc =3D virtio_mem_mb_unplug_sb_online(vm, mb_id, 0,
+=09=09=09=09=09=09    vm->nb_sb_per_mb);
+=09=09if (!rc) {
+=09=09=09*nb_sb -=3D vm->nb_sb_per_mb;
+=09=09=09goto unplugged;
+=09=09} else if (rc !=3D -EBUSY)
+=09=09=09return rc;
+=09}
+
+=09/* Fallback to single subblocks. */
 =09for (sb_id =3D vm->nb_sb_per_mb - 1; sb_id >=3D 0 && *nb_sb; sb_id--) {
 =09=09/* Find the next candidate subblock */
 =09=09while (sb_id >=3D 0 &&
@@ -1339,34 +1384,15 @@ static int virtio_mem_mb_unplug_any_sb_online(struc=
t virtio_mem *vm,
 =09=09if (sb_id < 0)
 =09=09=09break;
=20
-=09=09start_pfn =3D PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
-=09=09=09=09     sb_id * vm->subblock_size);
-=09=09rc =3D alloc_contig_range(start_pfn, start_pfn + nr_pages,
-=09=09=09=09=09MIGRATE_MOVABLE, GFP_KERNEL);
-=09=09if (rc =3D=3D -ENOMEM)
-=09=09=09/* whoops, out of memory */
-=09=09=09return rc;
-=09=09if (rc)
-=09=09=09/* memory busy, we can't unplug this chunk */
+=09=09rc =3D virtio_mem_mb_unplug_sb_online(vm, mb_id, sb_id, 1);
+=09=09if (rc =3D=3D -EBUSY)
 =09=09=09continue;
-
-=09=09/* Mark it as fake-offline before unplugging it */
-=09=09virtio_mem_set_fake_offline(start_pfn, nr_pages, true);
-=09=09adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
-
-=09=09/* Try to unplug the allocated memory */
-=09=09rc =3D virtio_mem_mb_unplug_sb(vm, mb_id, sb_id, 1);
-=09=09if (rc) {
-=09=09=09/* Return the memory to the buddy. */
-=09=09=09virtio_mem_fake_online(start_pfn, nr_pages);
+=09=09else if (rc)
 =09=09=09return rc;
-=09=09}
-
-=09=09virtio_mem_mb_set_state(vm, mb_id,
-=09=09=09=09=09VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL);
 =09=09*nb_sb -=3D 1;
 =09}
=20
+unplugged:
 =09/*
 =09 * Once all subblocks of a memory block were unplugged, offline and
 =09 * remove it. This will usually not fail, as no memory is in use
--=20
2.25.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

