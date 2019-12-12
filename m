Return-Path: virtio-dev-return-6510-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2F659985F30
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Dec 2019 17:13:37 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu, 12 Dec 2019 18:11:37 +0100
Message-Id: <20191212171137.13872-14-david@redhat.com>
In-Reply-To: <20191212171137.13872-1-david@redhat.com>
References: <20191212171137.13872-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH RFC v4 13/13] virtio-mem: Drop slab objects when unplug continues to fail
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jason Wang <jasowang@redhat.com>, Oscar Salvador <osalvador@suse.de>, Igor Mammedov <imammedo@redhat.com>, Dave Young <dyoung@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, linux-fsdevel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

Start dropping slab objects after 30 minutes and repeat every 30 minutes
in case we can't unplug more memory using alloc_contig_range().
Log messages and make it configurable. Enable dropping slab objects as
default (especially, reclaimable slab objects that are not movable).

In the future, we might want to implement+use drop_slab_range(), which
will also come in handy for other users (e.g., offlining, gigantic huge
pages).

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 3a57434f92ed..8f25f7453a08 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -25,6 +25,11 @@ static bool unplug_online =3D true;
 module_param(unplug_online, bool, 0644);
 MODULE_PARM_DESC(unplug_online, "Try to unplug online memory");
=20
+static bool drop_slab_objects =3D true;
+module_param(drop_slab_objects, bool, 0644);
+MODULE_PARM_DESC(drop_slab_objects,
+=09=09 "Drop slab objects when unplug continues to fail");
+
 enum virtio_mem_mb_state {
 =09/* Unplugged, not added to Linux. Can be reused later. */
 =09VIRTIO_MEM_MB_STATE_UNUSED =3D 0,
@@ -1384,6 +1389,7 @@ static int virtio_mem_mb_unplug_any_sb_online(struct =
virtio_mem *vm,
 static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
 {
 =09uint64_t nb_sb =3D diff / vm->subblock_size;
+=09bool retried =3D false;
 =09unsigned long mb_id;
 =09int rc;
=20
@@ -1421,6 +1427,7 @@ static int virtio_mem_unplug_request(struct virtio_me=
m *vm, uint64_t diff)
 =09=09return 0;
 =09}
=20
+retry_locked:
 =09/* Try to unplug subblocks of partially plugged online blocks. */
 =09virtio_mem_for_each_mb_state(vm, mb_id,
 =09=09=09=09     VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL) {
@@ -1445,6 +1452,29 @@ static int virtio_mem_unplug_request(struct virtio_m=
em *vm, uint64_t diff)
 =09}
=20
 =09mutex_unlock(&vm->hotplug_mutex);
+
+=09/*
+=09 * If we can't unplug the requested amount of memory for a long time,
+=09 * start freeing up memory in caches. This might harm performance,
+=09 * is configurable, and we log a message. Retry imemdiately a second
+=09 * time - then wait another VIRTIO_MEM_RETRY_TIMER_MAX_MS.
+=09 */
+=09if (nb_sb && !retried && drop_slab_objects &&
+=09    vm->retry_timer_ms =3D=3D VIRTIO_MEM_RETRY_TIMER_MAX_MS) {
+=09=09if (vm->nid =3D=3D NUMA_NO_NODE) {
+=09=09=09dev_info(&vm->vdev->dev, "dropping all slab objects\n");
+=09=09=09drop_slab();
+=09=09} else {
+=09=09=09dev_info(&vm->vdev->dev,
+=09=09=09=09 "dropping all slab objects on node=3D%d\n",
+=09=09=09=09 vm->nid);
+=09=09=09drop_slab_node(vm->nid);
+=09=09}
+=09=09retried =3D true;
+=09=09mutex_lock(&vm->hotplug_mutex);
+=09=09goto retry_locked;
+=09}
+
 =09return nb_sb ? -EBUSY : 0;
 out_unlock:
 =09mutex_unlock(&vm->hotplug_mutex);
--=20
2.23.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

