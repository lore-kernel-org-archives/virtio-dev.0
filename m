Return-Path: virtio-dev-return-7280-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 971EB985EBA
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 May 2020 14:03:46 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 May 2020 16:01:35 +0200
Message-Id: <20200507140139.17083-12-david@redhat.com>
In-Reply-To: <20200507140139.17083-1-david@redhat.com>
References: <20200507140139.17083-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v4 11/15] virtio-mem: Add parent resource for all added "System RAM"
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Let's add a parent resource, named after the virtio device (inspired by
drivers/dax/kmem.c). This allows user space to identify which memory
belongs to which virtio-mem device.

With this change and two virtio-mem devices:
=09:/# cat /proc/iomem
=0900000000-00000fff : Reserved
=0900001000-0009fbff : System RAM
=09[...]
=09140000000-333ffffff : virtio0
=09  140000000-147ffffff : System RAM
=09  148000000-14fffffff : System RAM
=09  150000000-157ffffff : System RAM
=09[...]
=09334000000-3033ffffff : virtio1
=09  338000000-33fffffff : System RAM
=09  340000000-347ffffff : System RAM
=09  348000000-34fffffff : System RAM
=09[...]

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 52 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index eb4c16d634e0..80cdb9e6b3c4 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -99,6 +99,9 @@ struct virtio_mem {
 =09/* Id of the next memory bock to prepare when needed. */
 =09unsigned long next_mb_id;
=20
+=09/* The parent resource for all memory added via this device. */
+=09struct resource *parent_resource;
+
 =09/* Summary of all memory block states. */
 =09unsigned long nb_mb_state[VIRTIO_MEM_MB_STATE_COUNT];
 #define VIRTIO_MEM_NB_OFFLINE_THRESHOLD=09=0910
@@ -1741,6 +1744,44 @@ static int virtio_mem_init(struct virtio_mem *vm)
 =09return 0;
 }
=20
+static int virtio_mem_create_resource(struct virtio_mem *vm)
+{
+=09/*
+=09 * When force-unloading the driver and removing the device, we
+=09 * could have a garbage pointer. Duplicate the string.
+=09 */
+=09const char *name =3D kstrdup(dev_name(&vm->vdev->dev), GFP_KERNEL);
+
+=09if (!name)
+=09=09return -ENOMEM;
+
+=09vm->parent_resource =3D __request_mem_region(vm->addr, vm->region_size,
+=09=09=09=09=09=09   name, IORESOURCE_SYSTEM_RAM);
+=09if (!vm->parent_resource) {
+=09=09kfree(name);
+=09=09dev_warn(&vm->vdev->dev, "could not reserve device region\n");
+=09=09return -EBUSY;
+=09}
+
+=09/* The memory is not actually busy - make add_memory() work. */
+=09vm->parent_resource->flags &=3D ~IORESOURCE_BUSY;
+=09return 0;
+}
+
+static void virtio_mem_delete_resource(struct virtio_mem *vm)
+{
+=09const char *name;
+
+=09if (!vm->parent_resource)
+=09=09return;
+
+=09name =3D vm->parent_resource->name;
+=09release_resource(vm->parent_resource);
+=09kfree(vm->parent_resource);
+=09kfree(name);
+=09vm->parent_resource =3D NULL;
+}
+
 static int virtio_mem_probe(struct virtio_device *vdev)
 {
 =09struct virtio_mem *vm;
@@ -1770,11 +1811,16 @@ static int virtio_mem_probe(struct virtio_device *v=
dev)
 =09if (rc)
 =09=09goto out_del_vq;
=20
+=09/* create the parent resource for all memory */
+=09rc =3D virtio_mem_create_resource(vm);
+=09if (rc)
+=09=09goto out_del_vq;
+
 =09/* register callbacks */
 =09vm->memory_notifier.notifier_call =3D virtio_mem_memory_notifier_cb;
 =09rc =3D register_memory_notifier(&vm->memory_notifier);
 =09if (rc)
-=09=09goto out_del_vq;
+=09=09goto out_del_resource;
 =09rc =3D register_virtio_mem_device(vm);
 =09if (rc)
 =09=09goto out_unreg_mem;
@@ -1788,6 +1834,8 @@ static int virtio_mem_probe(struct virtio_device *vde=
v)
 =09return 0;
 out_unreg_mem:
 =09unregister_memory_notifier(&vm->memory_notifier);
+out_del_resource:
+=09virtio_mem_delete_resource(vm);
 out_del_vq:
 =09vdev->config->del_vqs(vdev);
 out_free_vm:
@@ -1848,6 +1896,8 @@ static void virtio_mem_remove(struct virtio_device *v=
dev)
 =09    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL] ||
 =09    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_MOVABLE])
 =09=09dev_warn(&vdev->dev, "device still has system memory added\n");
+=09else
+=09=09virtio_mem_delete_resource(vm);
=20
 =09/* remove all tracking data - no locking needed */
 =09vfree(vm->mb_state);
--=20
2.25.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

