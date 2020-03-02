Return-Path: virtio-dev-return-6862-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E062E985CDE
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Mar 2020 13:53:22 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Mon,  2 Mar 2020 14:49:39 +0100
Message-Id: <20200302134941.315212-10-david@redhat.com>
In-Reply-To: <20200302134941.315212-1-david@redhat.com>
References: <20200302134941.315212-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v1 09/11] virtio-mem: Offline and remove completely unplugged memory blocks
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>, Oscar Salvador <osalvador@suse.de>, Igor Mammedov <imammedo@redhat.com>, Dave Young <dyoung@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>
List-ID: <virtio-dev.lists.oasis-open.org>

Let's offline+remove memory blocks once all subblocks are unplugged. We
can use the new Linux MM interface for that. As no memory is in use
anymore, this shouldn't take a long time and shouldn't fail. There might
be corner cases where the offlining could still fail (especially, if
another notifier NACKs the offlining request).

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
 drivers/virtio/virtio_mem.c | 47 +++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 2916f8b970fa..0274527ac517 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -443,6 +443,28 @@ static int virtio_mem_mb_remove(struct virtio_mem *vm,=
 unsigned long mb_id)
 =09return remove_memory(nid, addr, memory_block_size_bytes());
 }
=20
+/*
+ * Try to offline and remove a memory block from Linux.
+ *
+ * Must not be called with the vm->hotplug_mutex held (possible deadlock w=
ith
+ * onlining code).
+ *
+ * Will not modify the state of the memory block.
+ */
+static int virtio_mem_mb_offline_and_remove(struct virtio_mem *vm,
+=09=09=09=09=09    unsigned long mb_id)
+{
+=09const uint64_t addr =3D virtio_mem_mb_id_to_phys(mb_id);
+=09int nid =3D vm->nid;
+
+=09if (nid =3D=3D NUMA_NO_NODE)
+=09=09nid =3D memory_add_physaddr_to_nid(addr);
+
+=09dev_dbg(&vm->vdev->dev, "offlining and removing memory block: %lu\n",
+=09=09mb_id);
+=09return offline_and_remove_memory(nid, addr, memory_block_size_bytes());
+}
+
 /*
  * Trigger the workqueue so the device can perform its magic.
  */
@@ -535,7 +557,13 @@ static void virtio_mem_notify_offline(struct virtio_me=
m *vm,
 =09=09break;
 =09}
=20
-=09/* trigger the workqueue, maybe we can now unplug memory. */
+=09/*
+=09 * Trigger the workqueue, maybe we can now unplug memory. Also,
+=09 * when we offline and remove a memory block, this will re-trigger
+=09 * us immediately - which is often nice because the removal of
+=09 * the memory block (e.g., memmap) might have freed up memory
+=09 * on other memory blocks we manage.
+=09 */
 =09virtio_mem_retry(vm);
 }
=20
@@ -1278,7 +1306,8 @@ static int virtio_mem_mb_unplug_any_sb_offline(struct=
 virtio_mem *vm,
  * Unplug the desired number of plugged subblocks of an online memory bloc=
k.
  * Will skip subblock that are busy.
  *
- * Will modify the state of the memory block.
+ * Will modify the state of the memory block. Might temporarily drop the
+ * hotplug_mutex.
  *
  * Note: Can fail after some subblocks were successfully unplugged. Can
  *       return 0 even if subblocks were busy and could not get unplugged.
@@ -1334,9 +1363,19 @@ static int virtio_mem_mb_unplug_any_sb_online(struct=
 virtio_mem *vm,
 =09}
=20
 =09/*
-=09 * TODO: Once all subblocks of a memory block were unplugged, we want
-=09 * to offline the memory block and remove it.
+=09 * Once all subblocks of a memory block were unplugged, offline and
+=09 * remove it. This will usually not fail, as no memory is in use
+=09 * anymore - however some other notifiers might NACK the request.
 =09 */
+=09if (virtio_mem_mb_test_sb_unplugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
+=09=09mutex_unlock(&vm->hotplug_mutex);
+=09=09rc =3D virtio_mem_mb_offline_and_remove(vm, mb_id);
+=09=09mutex_lock(&vm->hotplug_mutex);
+=09=09if (!rc)
+=09=09=09virtio_mem_mb_set_state(vm, mb_id,
+=09=09=09=09=09=09VIRTIO_MEM_MB_STATE_UNUSED);
+=09}
+
 =09return 0;
 }
=20
--=20
2.24.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

