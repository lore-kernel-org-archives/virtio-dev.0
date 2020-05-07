Return-Path: virtio-dev-return-7279-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 777C7985EAE
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 May 2020 14:03:46 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 May 2020 16:01:37 +0200
Message-Id: <20200507140139.17083-14-david@redhat.com>
In-Reply-To: <20200507140139.17083-1-david@redhat.com>
References: <20200507140139.17083-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v4 13/15] virtio-mem: Unplug subblocks right-to-left
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

We unplug blocks right-to-left, let's also unplug subblocks within a block
right-to-left.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 38 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 8dd57b61b09b..a719e1a04ac7 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -353,18 +353,6 @@ static bool virtio_mem_mb_test_sb_unplugged(struct vir=
tio_mem *vm,
 =09return find_next_bit(vm->sb_bitmap, bit + count, bit) >=3D bit + count;
 }
=20
-/*
- * Find the first plugged subblock. Returns vm->nb_sb_per_mb in case there=
 is
- * none.
- */
-static int virtio_mem_mb_first_plugged_sb(struct virtio_mem *vm,
-=09=09=09=09=09  unsigned long mb_id)
-{
-=09const int bit =3D (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb;
-
-=09return find_next_bit(vm->sb_bitmap, bit + vm->nb_sb_per_mb, bit) - bit;
-}
-
 /*
  * Find the first unplugged subblock. Returns vm->nb_sb_per_mb in case the=
re is
  * none.
@@ -1016,21 +1004,27 @@ static int virtio_mem_mb_unplug_any_sb(struct virti=
o_mem *vm,
 =09int sb_id, count;
 =09int rc;
=20
+=09sb_id =3D vm->nb_sb_per_mb - 1;
 =09while (*nb_sb) {
-=09=09sb_id =3D virtio_mem_mb_first_plugged_sb(vm, mb_id);
-=09=09if (sb_id >=3D vm->nb_sb_per_mb)
+=09=09/* Find the next candidate subblock */
+=09=09while (sb_id >=3D 0 &&
+=09=09       virtio_mem_mb_test_sb_unplugged(vm, mb_id, sb_id, 1))
+=09=09=09sb_id--;
+=09=09if (sb_id < 0)
 =09=09=09break;
+=09=09/* Try to unplug multiple subblocks at a time */
 =09=09count =3D 1;
-=09=09while (count < *nb_sb &&
-=09=09       sb_id + count  < vm->nb_sb_per_mb &&
-=09=09       virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id + count,
-=09=09=09=09=09=09     1))
+=09=09while (count < *nb_sb && sb_id > 0 &&
+=09=09       virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id - 1, 1)) {
 =09=09=09count++;
+=09=09=09sb_id--;
+=09=09}
=20
 =09=09rc =3D virtio_mem_mb_unplug_sb(vm, mb_id, sb_id, count);
 =09=09if (rc)
 =09=09=09return rc;
 =09=09*nb_sb -=3D count;
+=09=09sb_id--;
 =09}
=20
 =09return 0;
@@ -1337,12 +1331,12 @@ static int virtio_mem_mb_unplug_any_sb_online(struc=
t virtio_mem *vm,
 =09 * we should sense via something like is_mem_section_removable()
 =09 * first if it makes sense to go ahead any try to allocate.
 =09 */
-=09for (sb_id =3D 0; sb_id < vm->nb_sb_per_mb && *nb_sb; sb_id++) {
+=09for (sb_id =3D vm->nb_sb_per_mb - 1; sb_id >=3D 0 && *nb_sb; sb_id--) {
 =09=09/* Find the next candidate subblock */
-=09=09while (sb_id < vm->nb_sb_per_mb &&
+=09=09while (sb_id >=3D 0 &&
 =09=09       !virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
-=09=09=09sb_id++;
-=09=09if (sb_id >=3D vm->nb_sb_per_mb)
+=09=09=09sb_id--;
+=09=09if (sb_id < 0)
 =09=09=09break;
=20
 =09=09start_pfn =3D PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
--=20
2.25.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

