Return-Path: virtio-dev-return-7276-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9E211985E96
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 May 2020 14:03:45 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 May 2020 16:01:36 +0200
Message-Id: <20200507140139.17083-13-david@redhat.com>
In-Reply-To: <20200507140139.17083-1-david@redhat.com>
References: <20200507140139.17083-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v4 12/15] virtio-mem: Drop manual check for already present memory
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Registering our parent resource will fail if any memory is still present
(e.g., because somebody unloaded the driver and tries to reload it). No
need for the manual check.

Move our "unplug all" handling to after registering the resource.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 55 ++++++++-----------------------------
 1 file changed, 12 insertions(+), 43 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 80cdb9e6b3c4..8dd57b61b09b 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1616,23 +1616,6 @@ static int virtio_mem_init_vq(struct virtio_mem *vm)
 =09return 0;
 }
=20
-/*
- * Test if any memory in the range is present in Linux.
- */
-static bool virtio_mem_any_memory_present(unsigned long start,
-=09=09=09=09=09  unsigned long size)
-{
-=09const unsigned long start_pfn =3D PFN_DOWN(start);
-=09const unsigned long end_pfn =3D PFN_UP(start + size);
-=09unsigned long pfn;
-
-=09for (pfn =3D start_pfn; pfn !=3D end_pfn; pfn++)
-=09=09if (present_section_nr(pfn_to_section_nr(pfn)))
-=09=09=09return true;
-
-=09return false;
-}
-
 static int virtio_mem_init(struct virtio_mem *vm)
 {
 =09const uint64_t phys_limit =3D 1UL << MAX_PHYSMEM_BITS;
@@ -1664,32 +1647,6 @@ static int virtio_mem_init(struct virtio_mem *vm)
 =09virtio_cread(vm->vdev, struct virtio_mem_config, region_size,
 =09=09     &vm->region_size);
=20
-=09/*
-=09 * If we still have memory plugged, we might have to unplug all
-=09 * memory first. However, if somebody simply unloaded the driver
-=09 * we would have to reinitialize the old state - something we don't
-=09 * support yet. Detect if we have any memory in the area present.
-=09 */
-=09if (vm->plugged_size) {
-=09=09uint64_t usable_region_size;
-
-=09=09virtio_cread(vm->vdev, struct virtio_mem_config,
-=09=09=09     usable_region_size, &usable_region_size);
-
-=09=09if (virtio_mem_any_memory_present(vm->addr,
-=09=09=09=09=09=09  usable_region_size)) {
-=09=09=09dev_err(&vm->vdev->dev,
-=09=09=09=09"reloading the driver is not supported\n");
-=09=09=09return -EINVAL;
-=09=09}
-=09=09/*
-=09=09 * Note: it might happen that the device is busy and
-=09=09 * unplugging all memory might take some time.
-=09=09 */
-=09=09dev_info(&vm->vdev->dev, "unplugging all memory required\n");
-=09=09vm->unplug_all_required =3D 1;
-=09}
-
 =09/*
 =09 * We always hotplug memory in memory block granularity. This way,
 =09 * we have to wait for exactly one memory block to online.
@@ -1760,6 +1717,8 @@ static int virtio_mem_create_resource(struct virtio_m=
em *vm)
 =09if (!vm->parent_resource) {
 =09=09kfree(name);
 =09=09dev_warn(&vm->vdev->dev, "could not reserve device region\n");
+=09=09dev_info(&vm->vdev->dev,
+=09=09=09 "reloading the driver is not supported\n");
 =09=09return -EBUSY;
 =09}
=20
@@ -1816,6 +1775,16 @@ static int virtio_mem_probe(struct virtio_device *vd=
ev)
 =09if (rc)
 =09=09goto out_del_vq;
=20
+=09/*
+=09 * If we still have memory plugged, we have to unplug all memory first.
+=09 * Registering our parent resource makes sure that this memory isn't
+=09 * actually in use (e.g., trying to reload the driver).
+=09 */
+=09if (vm->plugged_size) {
+=09=09vm->unplug_all_required =3D 1;
+=09=09dev_info(&vm->vdev->dev, "unplugging all memory is required\n");
+=09}
+
 =09/* register callbacks */
 =09vm->memory_notifier.notifier_call =3D virtio_mem_memory_notifier_cb;
 =09rc =3D register_memory_notifier(&vm->memory_notifier);
--=20
2.25.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

