Return-Path: virtio-dev-return-7271-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C400D985E56
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 May 2020 14:02:52 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 May 2020 16:01:28 +0200
Message-Id: <20200507140139.17083-5-david@redhat.com>
In-Reply-To: <20200507140139.17083-1-david@redhat.com>
References: <20200507140139.17083-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v4 04/15] virtio-mem: Paravirtualized memory hotunplug part 1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Jason Wang <jasowang@redhat.com>, Oscar Salvador <osalvador@suse.de>, Igor Mammedov <imammedo@redhat.com>, Dave Young <dyoung@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>
List-ID: <virtio-dev.lists.oasis-open.org>

Unplugging subblocks of memory blocks that are offline is easy. All we
have to do is watch out for concurrent onlining activity.

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
 drivers/virtio/virtio_mem.c | 116 +++++++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 270ddeaec059..a3ec795be8be 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -123,7 +123,7 @@ struct virtio_mem {
 =09 *
 =09 * When this lock is held the pointers can't change, ONLINE and
 =09 * OFFLINE blocks can't change the state and no subblocks will get
-=09 * plugged.
+=09 * plugged/unplugged.
 =09 */
 =09struct mutex hotplug_mutex;
 =09bool hotplug_active;
@@ -280,6 +280,12 @@ static int virtio_mem_mb_state_prepare_next_mb(struct =
virtio_mem *vm)
 =09     _mb_id++) \
 =09=09if (virtio_mem_mb_get_state(_vm, _mb_id) =3D=3D _state)
=20
+#define virtio_mem_for_each_mb_state_rev(_vm, _mb_id, _state) \
+=09for (_mb_id =3D _vm->next_mb_id - 1; \
+=09     _mb_id >=3D _vm->first_mb_id && _vm->nb_mb_state[_state]; \
+=09     _mb_id--) \
+=09=09if (virtio_mem_mb_get_state(_vm, _mb_id) =3D=3D _state)
+
 /*
  * Mark all selected subblocks plugged.
  *
@@ -325,6 +331,19 @@ static bool virtio_mem_mb_test_sb_plugged(struct virti=
o_mem *vm,
 =09       bit + count;
 }
=20
+/*
+ * Test if all selected subblocks are unplugged.
+ */
+static bool virtio_mem_mb_test_sb_unplugged(struct virtio_mem *vm,
+=09=09=09=09=09    unsigned long mb_id, int sb_id,
+=09=09=09=09=09    int count)
+{
+=09const int bit =3D (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+
+=09/* TODO: Helper similar to bitmap_set() */
+=09return find_next_bit(vm->sb_bitmap, bit + count, bit) >=3D bit + count;
+}
+
 /*
  * Find the first plugged subblock. Returns vm->nb_sb_per_mb in case there=
 is
  * none.
@@ -513,6 +532,9 @@ static void virtio_mem_notify_offline(struct virtio_mem=
 *vm,
 =09=09BUG();
 =09=09break;
 =09}
+
+=09/* trigger the workqueue, maybe we can now unplug memory. */
+=09virtio_mem_retry(vm);
 }
=20
 static void virtio_mem_notify_online(struct virtio_mem *vm, unsigned long =
mb_id,
@@ -1122,6 +1144,94 @@ static int virtio_mem_plug_request(struct virtio_mem=
 *vm, uint64_t diff)
 =09return rc;
 }
=20
+/*
+ * Unplug the desired number of plugged subblocks of an offline memory blo=
ck.
+ * Will fail if any subblock cannot get unplugged (instead of skipping it)=
.
+ *
+ * Will modify the state of the memory block. Might temporarily drop the
+ * hotplug_mutex.
+ *
+ * Note: Can fail after some subblocks were successfully unplugged.
+ */
+static int virtio_mem_mb_unplug_any_sb_offline(struct virtio_mem *vm,
+=09=09=09=09=09       unsigned long mb_id,
+=09=09=09=09=09       uint64_t *nb_sb)
+{
+=09int rc;
+
+=09rc =3D virtio_mem_mb_unplug_any_sb(vm, mb_id, nb_sb);
+
+=09/* some subblocks might have been unplugged even on failure */
+=09if (!virtio_mem_mb_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb))
+=09=09virtio_mem_mb_set_state(vm, mb_id,
+=09=09=09=09=09VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL);
+=09if (rc)
+=09=09return rc;
+
+=09if (virtio_mem_mb_test_sb_unplugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
+=09=09/*
+=09=09 * Remove the block from Linux - this should never fail.
+=09=09 * Hinder the block from getting onlined by marking it
+=09=09 * unplugged. Temporarily drop the mutex, so
+=09=09 * any pending GOING_ONLINE requests can be serviced/rejected.
+=09=09 */
+=09=09virtio_mem_mb_set_state(vm, mb_id,
+=09=09=09=09=09VIRTIO_MEM_MB_STATE_UNUSED);
+
+=09=09mutex_unlock(&vm->hotplug_mutex);
+=09=09rc =3D virtio_mem_mb_remove(vm, mb_id);
+=09=09BUG_ON(rc);
+=09=09mutex_lock(&vm->hotplug_mutex);
+=09}
+=09return 0;
+}
+
+/*
+ * Try to unplug the requested amount of memory.
+ */
+static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
+{
+=09uint64_t nb_sb =3D diff / vm->subblock_size;
+=09unsigned long mb_id;
+=09int rc;
+
+=09if (!nb_sb)
+=09=09return 0;
+
+=09/*
+=09 * We'll drop the mutex a couple of times when it is safe to do so.
+=09 * This might result in some blocks switching the state (online/offline=
)
+=09 * and we could miss them in this run - we will retry again later.
+=09 */
+=09mutex_lock(&vm->hotplug_mutex);
+
+=09/* Try to unplug subblocks of partially plugged offline blocks. */
+=09virtio_mem_for_each_mb_state_rev(vm, mb_id,
+=09=09=09=09=09 VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL) {
+=09=09rc =3D virtio_mem_mb_unplug_any_sb_offline(vm, mb_id,
+=09=09=09=09=09=09=09 &nb_sb);
+=09=09if (rc || !nb_sb)
+=09=09=09goto out_unlock;
+=09=09cond_resched();
+=09}
+
+=09/* Try to unplug subblocks of plugged offline blocks. */
+=09virtio_mem_for_each_mb_state_rev(vm, mb_id,
+=09=09=09=09=09 VIRTIO_MEM_MB_STATE_OFFLINE) {
+=09=09rc =3D virtio_mem_mb_unplug_any_sb_offline(vm, mb_id,
+=09=09=09=09=09=09=09 &nb_sb);
+=09=09if (rc || !nb_sb)
+=09=09=09goto out_unlock;
+=09=09cond_resched();
+=09}
+
+=09mutex_unlock(&vm->hotplug_mutex);
+=09return 0;
+out_unlock:
+=09mutex_unlock(&vm->hotplug_mutex);
+=09return rc;
+}
+
 /*
  * Try to unplug all blocks that couldn't be unplugged before, for example=
,
  * because the hypervisor was busy.
@@ -1204,8 +1314,10 @@ static void virtio_mem_run_wq(struct work_struct *wo=
rk)
 =09=09if (vm->requested_size > vm->plugged_size) {
 =09=09=09diff =3D vm->requested_size - vm->plugged_size;
 =09=09=09rc =3D virtio_mem_plug_request(vm, diff);
+=09=09} else {
+=09=09=09diff =3D vm->plugged_size - vm->requested_size;
+=09=09=09rc =3D virtio_mem_unplug_request(vm, diff);
 =09=09}
-=09=09/* TODO: try to unplug memory */
 =09}
=20
 =09switch (rc) {
--=20
2.25.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

