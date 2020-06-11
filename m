Return-Path: virtio-dev-return-7460-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 294F0986105
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 Jun 2020 09:35:39 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu, 11 Jun 2020 11:35:18 +0200
Message-Id: <20200611093518.5737-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v1] virtio-mem: add memory via add_memory_driver_managed()
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, David Hildenbrand <david@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, teawater <teawaterz@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Virtio-mem managed memory is always detected and added by the virtio-mem
driver, never using something like the firmware-provided memory map.
This is the case after an ordinary system reboot, and has to be guaranteed
after kexec. Especially, virtio-mem added memory resources can contain
inaccessible parts ("unblocked memory blocks"), blindly forwarding them
to a kexec kernel is dangerous, as unplugged memory will get accessed
(esp. written).

Let's use the new way of adding special driver-managed memory introduced
in commit 75ac4c58bc0d ("mm/memory_hotplug: introduce
add_memory_driver_managed()").

This will result in no entries in /sys/firmware/memmap ("raw firmware-
provided memory map"), the memory resource will be flagged
IORESOURCE_MEM_DRIVER_MANAGED (esp., kexec_file_load() will not place
kexec images on this memory), and it is exposed as "System RAM
(virtio_mem)" in /proc/iomem, so esp. kexec-tools can properly handle it.

Example /proc/iomem before this change:
  [...]
  140000000-333ffffff : virtio0
    140000000-147ffffff : System RAM
  334000000-533ffffff : virtio1
    338000000-33fffffff : System RAM
    340000000-347ffffff : System RAM
    348000000-34fffffff : System RAM
  [...]

Example /proc/iomem after this change:
  [...]
  140000000-333ffffff : virtio0
    140000000-147ffffff : System RAM (virtio_mem)
  334000000-533ffffff : virtio1
    338000000-33fffffff : System RAM (virtio_mem)
    340000000-347ffffff : System RAM (virtio_mem)
    348000000-34fffffff : System RAM (virtio_mem)
  [...]

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: teawater <teawaterz@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

Based on latest Linus' tree (and not a tag) because
- virtio-mem has just been merged via the vhost tree
- add_memory_driver_managed() has been merged a week ago via the -mm tree

I'd like to have this patch in 5.8, with the initial merge of virtio-mem
if possible (so the user space representation of virtio-mem added memory
resources won't change anymore).

---
 drivers/virtio/virtio_mem.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 50c689f250450..d2eab3558a9e1 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -101,6 +101,11 @@ struct virtio_mem {
=20
 =09/* The parent resource for all memory added via this device. */
 =09struct resource *parent_resource;
+=09/*
+=09 * Copy of "System RAM (virtio_mem)" to be used for
+=09 * add_memory_driver_managed().
+=09 */
+=09const char *resource_name;
=20
 =09/* Summary of all memory block states. */
 =09unsigned long nb_mb_state[VIRTIO_MEM_MB_STATE_COUNT];
@@ -414,8 +419,20 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, un=
signed long mb_id)
 =09if (nid =3D=3D NUMA_NO_NODE)
 =09=09nid =3D memory_add_physaddr_to_nid(addr);
=20
+=09/*
+=09 * When force-unloading the driver and we still have memory added to
+=09 * Linux, the resource name has to stay.
+=09 */
+=09if (!vm->resource_name) {
+=09=09vm->resource_name =3D kstrdup_const("System RAM (virtio_mem)",
+=09=09=09=09=09=09  GFP_KERNEL);
+=09=09if (!vm->resource_name)
+=09=09=09return -ENOMEM;
+=09}
+
 =09dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
-=09return add_memory(nid, addr, memory_block_size_bytes());
+=09return add_memory_driver_managed(nid, addr, memory_block_size_bytes(),
+=09=09=09=09=09 vm->resource_name);
 }
=20
 /*
@@ -1890,10 +1907,12 @@ static void virtio_mem_remove(struct virtio_device =
*vdev)
 =09    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL] ||
 =09    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE] ||
 =09    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL] ||
-=09    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_MOVABLE])
+=09    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_MOVABLE]) {
 =09=09dev_warn(&vdev->dev, "device still has system memory added\n");
-=09else
+=09} else {
 =09=09virtio_mem_delete_resource(vm);
+=09=09kfree_const(vm->resource_name);
+=09}
=20
 =09/* remove all tracking data - no locking needed */
 =09vfree(vm->mb_state);
--=20
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

