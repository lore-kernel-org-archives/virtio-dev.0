Return-Path: virtio-dev-return-7269-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B8993985E58
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 May 2020 14:02:24 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 May 2020 16:01:25 +0200
Message-Id: <20200507140139.17083-2-david@redhat.com>
In-Reply-To: <20200507140139.17083-1-david@redhat.com>
References: <20200507140139.17083-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v4 01/15] virtio-mem: Paravirtualized memory hotplug
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Jason Wang <jasowang@redhat.com>, Oscar Salvador <osalvador@suse.de>, Igor Mammedov <imammedo@redhat.com>, Dave Young <dyoung@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

Each virtio-mem device owns exactly one memory region. It is responsible
for adding/removing memory from that memory region on request.

When the device driver starts up, the requested amount of memory is
queried and then plugged to Linux. On request, further memory can be
plugged or unplugged. This patch only implements the plugging part.

On x86-64, memory can currently be plugged in 4MB ("subblock") granularity.
When required, a new memory block will be added (e.g., usually 128MB on
x86-64) in order to plug more subblocks. Only x86-64 was tested for now.

The online_page callback is used to keep unplugged subblocks offline
when onlining memory - similar to the Hyper-V balloon driver. Unplugged
pages are marked PG_offline, to tell dump tools (e.g., makedumpfile) to
skip them.

User space is usually responsible for onlining the added memory. The
memory hotplug notifier is used to synchronize virtio-mem activity
against memory onlining/offlining.

Each virtio-mem device can belong to a NUMA node, which allows us to
easily add/remove small chunks of memory to/from a specific NUMA node by
using multiple virtio-mem devices. Something that works even when the
guest has no idea about the NUMA topology.

One way to view virtio-mem is as a "resizable DIMM" or a DIMM with many
"sub-DIMMS".

This patch directly introduces the basic infrastructure to implement memory
unplug. Especially the memory block states and subblock bitmaps will be
heavily used there.

Notes:
- In case memory is to be onlined by user space, we limit the amount of
  offline memory blocks, to not run out of memory. This is esp. an
  issue if memory is added faster than it is getting onlined.
- Suspend/Hibernate is not supported due to the way virtio-mem devices
  behave. Limited support might be possible in the future.
- Reloading the device driver is not supported.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
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
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/Kconfig          |   16 +
 drivers/virtio/Makefile         |    1 +
 drivers/virtio/virtio_mem.c     | 1533 +++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_ids.h |    1 +
 include/uapi/linux/virtio_mem.h |  200 ++++
 5 files changed, 1751 insertions(+)
 create mode 100644 drivers/virtio/virtio_mem.c
 create mode 100644 include/uapi/linux/virtio_mem.h

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 69a32dfc318a..d6dde7d2cf76 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -78,6 +78,22 @@ config VIRTIO_BALLOON
=20
 =09 If unsure, say M.
=20
+config VIRTIO_MEM
+=09tristate "Virtio mem driver"
+=09default m
+=09depends on X86_64
+=09depends on VIRTIO
+=09depends on MEMORY_HOTPLUG_SPARSE
+=09depends on MEMORY_HOTREMOVE
+=09help
+=09 This driver provides access to virtio-mem paravirtualized memory
+=09 devices, allowing to hotplug and hotunplug memory.
+
+=09 This driver was only tested under x86-64, but should theoretically
+=09 work on all architectures that support memory hotplug and hotremove.
+
+=09 If unsure, say M.
+
 config VIRTIO_INPUT
 =09tristate "Virtio input driver"
 =09depends on VIRTIO
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 29a1386ecc03..4d993791f2d7 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -7,3 +7,4 @@ virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) +=3D virtio_pci_lega=
cy.o
 obj-$(CONFIG_VIRTIO_BALLOON) +=3D virtio_balloon.o
 obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio_input.o
 obj-$(CONFIG_VIRTIO_VDPA) +=3D virtio_vdpa.o
+obj-$(CONFIG_VIRTIO_MEM) +=3D virtio_mem.o
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
new file mode 100644
index 000000000000..5d1dcaa6fc42
--- /dev/null
+++ b/drivers/virtio/virtio_mem.c
@@ -0,0 +1,1533 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Virtio-mem device driver.
+ *
+ * Copyright Red Hat, Inc. 2020
+ *
+ * Author(s): David Hildenbrand <david@redhat.com>
+ */
+
+#include <linux/virtio.h>
+#include <linux/virtio_mem.h>
+#include <linux/workqueue.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/memory_hotplug.h>
+#include <linux/memory.h>
+#include <linux/hrtimer.h>
+#include <linux/crash_dump.h>
+#include <linux/mutex.h>
+#include <linux/bitmap.h>
+#include <linux/lockdep.h>
+
+enum virtio_mem_mb_state {
+=09/* Unplugged, not added to Linux. Can be reused later. */
+=09VIRTIO_MEM_MB_STATE_UNUSED =3D 0,
+=09/* (Partially) plugged, not added to Linux. Error on add_memory(). */
+=09VIRTIO_MEM_MB_STATE_PLUGGED,
+=09/* Fully plugged, fully added to Linux, offline. */
+=09VIRTIO_MEM_MB_STATE_OFFLINE,
+=09/* Partially plugged, fully added to Linux, offline. */
+=09VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL,
+=09/* Fully plugged, fully added to Linux, online (!ZONE_MOVABLE). */
+=09VIRTIO_MEM_MB_STATE_ONLINE,
+=09/* Partially plugged, fully added to Linux, online (!ZONE_MOVABLE). */
+=09VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL,
+=09/*
+=09 * Fully plugged, fully added to Linux, online (ZONE_MOVABLE).
+=09 * We are not allowed to allocate (unplug) parts of this block that
+=09 * are not movable (similar to gigantic pages). We will never allow
+=09 * to online OFFLINE_PARTIAL to ZONE_MOVABLE (as they would contain
+=09 * unmovable parts).
+=09 */
+=09VIRTIO_MEM_MB_STATE_ONLINE_MOVABLE,
+=09VIRTIO_MEM_MB_STATE_COUNT
+};
+
+struct virtio_mem {
+=09struct virtio_device *vdev;
+
+=09/* We might first have to unplug all memory when starting up. */
+=09bool unplug_all_required;
+
+=09/* Workqueue that processes the plug/unplug requests. */
+=09struct work_struct wq;
+=09atomic_t config_changed;
+
+=09/* Virtqueue for guest->host requests. */
+=09struct virtqueue *vq;
+
+=09/* Wait for a host response to a guest request. */
+=09wait_queue_head_t host_resp;
+
+=09/* Space for one guest request and the host response. */
+=09struct virtio_mem_req req;
+=09struct virtio_mem_resp resp;
+
+=09/* The current size of the device. */
+=09uint64_t plugged_size;
+=09/* The requested size of the device. */
+=09uint64_t requested_size;
+
+=09/* The device block size (for communicating with the device). */
+=09uint32_t device_block_size;
+=09/* Physical start address of the memory region. */
+=09uint64_t addr;
+=09/* Maximum region size in bytes. */
+=09uint64_t region_size;
+
+=09/* The subblock size. */
+=09uint32_t subblock_size;
+=09/* The number of subblocks per memory block. */
+=09uint32_t nb_sb_per_mb;
+
+=09/* Id of the first memory block of this device. */
+=09unsigned long first_mb_id;
+=09/* Id of the last memory block of this device. */
+=09unsigned long last_mb_id;
+=09/* Id of the last usable memory block of this device. */
+=09unsigned long last_usable_mb_id;
+=09/* Id of the next memory bock to prepare when needed. */
+=09unsigned long next_mb_id;
+
+=09/* Summary of all memory block states. */
+=09unsigned long nb_mb_state[VIRTIO_MEM_MB_STATE_COUNT];
+#define VIRTIO_MEM_NB_OFFLINE_THRESHOLD=09=0910
+
+=09/*
+=09 * One byte state per memory block.
+=09 *
+=09 * Allocated via vmalloc(). When preparing new blocks, resized
+=09 * (alloc+copy+free) when needed (crossing pages with the next mb).
+=09 * (when crossing pages).
+=09 *
+=09 * With 128MB memory blocks, we have states for 512GB of memory in one
+=09 * page.
+=09 */
+=09uint8_t *mb_state;
+
+=09/*
+=09 * $nb_sb_per_mb bit per memory block. Handled similar to mb_state.
+=09 *
+=09 * With 4MB subblocks, we manage 128GB of memory in one page.
+=09 */
+=09unsigned long *sb_bitmap;
+
+=09/*
+=09 * Mutex that protects the nb_mb_state, mb_state, and sb_bitmap.
+=09 *
+=09 * When this lock is held the pointers can't change, ONLINE and
+=09 * OFFLINE blocks can't change the state and no subblocks will get
+=09 * plugged.
+=09 */
+=09struct mutex hotplug_mutex;
+=09bool hotplug_active;
+
+=09/* An error occurred we cannot handle - stop processing requests. */
+=09bool broken;
+
+=09/* The driver is being removed. */
+=09spinlock_t removal_lock;
+=09bool removing;
+
+=09/* Timer for retrying to plug/unplug memory. */
+=09struct hrtimer retry_timer;
+#define VIRTIO_MEM_RETRY_TIMER_MS=09=0930000
+
+=09/* Memory notifier (online/offline events). */
+=09struct notifier_block memory_notifier;
+
+=09/* Next device in the list of virtio-mem devices. */
+=09struct list_head next;
+};
+
+/*
+ * We have to share a single online_page callback among all virtio-mem
+ * devices. We use RCU to iterate the list in the callback.
+ */
+static DEFINE_MUTEX(virtio_mem_mutex);
+static LIST_HEAD(virtio_mem_devices);
+
+static void virtio_mem_online_page_cb(struct page *page, unsigned int orde=
r);
+
+/*
+ * Register a virtio-mem device so it will be considered for the online_pa=
ge
+ * callback.
+ */
+static int register_virtio_mem_device(struct virtio_mem *vm)
+{
+=09int rc =3D 0;
+
+=09/* First device registers the callback. */
+=09mutex_lock(&virtio_mem_mutex);
+=09if (list_empty(&virtio_mem_devices))
+=09=09rc =3D set_online_page_callback(&virtio_mem_online_page_cb);
+=09if (!rc)
+=09=09list_add_rcu(&vm->next, &virtio_mem_devices);
+=09mutex_unlock(&virtio_mem_mutex);
+
+=09return rc;
+}
+
+/*
+ * Unregister a virtio-mem device so it will no longer be considered for t=
he
+ * online_page callback.
+ */
+static void unregister_virtio_mem_device(struct virtio_mem *vm)
+{
+=09/* Last device unregisters the callback. */
+=09mutex_lock(&virtio_mem_mutex);
+=09list_del_rcu(&vm->next);
+=09if (list_empty(&virtio_mem_devices))
+=09=09restore_online_page_callback(&virtio_mem_online_page_cb);
+=09mutex_unlock(&virtio_mem_mutex);
+
+=09synchronize_rcu();
+}
+
+/*
+ * Calculate the memory block id of a given address.
+ */
+static unsigned long virtio_mem_phys_to_mb_id(unsigned long addr)
+{
+=09return addr / memory_block_size_bytes();
+}
+
+/*
+ * Calculate the physical start address of a given memory block id.
+ */
+static unsigned long virtio_mem_mb_id_to_phys(unsigned long mb_id)
+{
+=09return mb_id * memory_block_size_bytes();
+}
+
+/*
+ * Calculate the subblock id of a given address.
+ */
+static unsigned long virtio_mem_phys_to_sb_id(struct virtio_mem *vm,
+=09=09=09=09=09      unsigned long addr)
+{
+=09const unsigned long mb_id =3D virtio_mem_phys_to_mb_id(addr);
+=09const unsigned long mb_addr =3D virtio_mem_mb_id_to_phys(mb_id);
+
+=09return (addr - mb_addr) / vm->subblock_size;
+}
+
+/*
+ * Set the state of a memory block, taking care of the state counter.
+ */
+static void virtio_mem_mb_set_state(struct virtio_mem *vm, unsigned long m=
b_id,
+=09=09=09=09    enum virtio_mem_mb_state state)
+{
+=09const unsigned long idx =3D mb_id - vm->first_mb_id;
+=09enum virtio_mem_mb_state old_state;
+
+=09old_state =3D vm->mb_state[idx];
+=09vm->mb_state[idx] =3D state;
+
+=09BUG_ON(vm->nb_mb_state[old_state] =3D=3D 0);
+=09vm->nb_mb_state[old_state]--;
+=09vm->nb_mb_state[state]++;
+}
+
+/*
+ * Get the state of a memory block.
+ */
+static enum virtio_mem_mb_state virtio_mem_mb_get_state(struct virtio_mem =
*vm,
+=09=09=09=09=09=09=09unsigned long mb_id)
+{
+=09const unsigned long idx =3D mb_id - vm->first_mb_id;
+
+=09return vm->mb_state[idx];
+}
+
+/*
+ * Prepare the state array for the next memory block.
+ */
+static int virtio_mem_mb_state_prepare_next_mb(struct virtio_mem *vm)
+{
+=09unsigned long old_bytes =3D vm->next_mb_id - vm->first_mb_id + 1;
+=09unsigned long new_bytes =3D vm->next_mb_id - vm->first_mb_id + 2;
+=09int old_pages =3D PFN_UP(old_bytes);
+=09int new_pages =3D PFN_UP(new_bytes);
+=09uint8_t *new_mb_state;
+
+=09if (vm->mb_state && old_pages =3D=3D new_pages)
+=09=09return 0;
+
+=09new_mb_state =3D vzalloc(new_pages * PAGE_SIZE);
+=09if (!new_mb_state)
+=09=09return -ENOMEM;
+
+=09mutex_lock(&vm->hotplug_mutex);
+=09if (vm->mb_state)
+=09=09memcpy(new_mb_state, vm->mb_state, old_pages * PAGE_SIZE);
+=09vfree(vm->mb_state);
+=09vm->mb_state =3D new_mb_state;
+=09mutex_unlock(&vm->hotplug_mutex);
+
+=09return 0;
+}
+
+#define virtio_mem_for_each_mb_state(_vm, _mb_id, _state) \
+=09for (_mb_id =3D _vm->first_mb_id; \
+=09     _mb_id < _vm->next_mb_id && _vm->nb_mb_state[_state]; \
+=09     _mb_id++) \
+=09=09if (virtio_mem_mb_get_state(_vm, _mb_id) =3D=3D _state)
+
+/*
+ * Mark all selected subblocks plugged.
+ *
+ * Will not modify the state of the memory block.
+ */
+static void virtio_mem_mb_set_sb_plugged(struct virtio_mem *vm,
+=09=09=09=09=09 unsigned long mb_id, int sb_id,
+=09=09=09=09=09 int count)
+{
+=09const int bit =3D (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+
+=09__bitmap_set(vm->sb_bitmap, bit, count);
+}
+
+/*
+ * Mark all selected subblocks unplugged.
+ *
+ * Will not modify the state of the memory block.
+ */
+static void virtio_mem_mb_set_sb_unplugged(struct virtio_mem *vm,
+=09=09=09=09=09   unsigned long mb_id, int sb_id,
+=09=09=09=09=09   int count)
+{
+=09const int bit =3D (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+
+=09__bitmap_clear(vm->sb_bitmap, bit, count);
+}
+
+/*
+ * Test if all selected subblocks are plugged.
+ */
+static bool virtio_mem_mb_test_sb_plugged(struct virtio_mem *vm,
+=09=09=09=09=09  unsigned long mb_id, int sb_id,
+=09=09=09=09=09  int count)
+{
+=09const int bit =3D (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
+
+=09if (count =3D=3D 1)
+=09=09return test_bit(bit, vm->sb_bitmap);
+
+=09/* TODO: Helper similar to bitmap_set() */
+=09return find_next_zero_bit(vm->sb_bitmap, bit + count, bit) >=3D
+=09       bit + count;
+}
+
+/*
+ * Find the first plugged subblock. Returns vm->nb_sb_per_mb in case there=
 is
+ * none.
+ */
+static int virtio_mem_mb_first_plugged_sb(struct virtio_mem *vm,
+=09=09=09=09=09  unsigned long mb_id)
+{
+=09const int bit =3D (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb;
+
+=09return find_next_bit(vm->sb_bitmap, bit + vm->nb_sb_per_mb, bit) - bit;
+}
+
+/*
+ * Find the first unplugged subblock. Returns vm->nb_sb_per_mb in case the=
re is
+ * none.
+ */
+static int virtio_mem_mb_first_unplugged_sb(struct virtio_mem *vm,
+=09=09=09=09=09    unsigned long mb_id)
+{
+=09const int bit =3D (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb;
+
+=09return find_next_zero_bit(vm->sb_bitmap, bit + vm->nb_sb_per_mb, bit) -
+=09       bit;
+}
+
+/*
+ * Prepare the subblock bitmap for the next memory block.
+ */
+static int virtio_mem_sb_bitmap_prepare_next_mb(struct virtio_mem *vm)
+{
+=09const unsigned long old_nb_mb =3D vm->next_mb_id - vm->first_mb_id;
+=09const unsigned long old_nb_bits =3D old_nb_mb * vm->nb_sb_per_mb;
+=09const unsigned long new_nb_bits =3D (old_nb_mb + 1) * vm->nb_sb_per_mb;
+=09int old_pages =3D PFN_UP(BITS_TO_LONGS(old_nb_bits) * sizeof(long));
+=09int new_pages =3D PFN_UP(BITS_TO_LONGS(new_nb_bits) * sizeof(long));
+=09unsigned long *new_sb_bitmap, *old_sb_bitmap;
+
+=09if (vm->sb_bitmap && old_pages =3D=3D new_pages)
+=09=09return 0;
+
+=09new_sb_bitmap =3D vzalloc(new_pages * PAGE_SIZE);
+=09if (!new_sb_bitmap)
+=09=09return -ENOMEM;
+
+=09mutex_lock(&vm->hotplug_mutex);
+=09if (new_sb_bitmap)
+=09=09memcpy(new_sb_bitmap, vm->sb_bitmap, old_pages * PAGE_SIZE);
+
+=09old_sb_bitmap =3D vm->sb_bitmap;
+=09vm->sb_bitmap =3D new_sb_bitmap;
+=09mutex_unlock(&vm->hotplug_mutex);
+
+=09vfree(old_sb_bitmap);
+=09return 0;
+}
+
+/*
+ * Try to add a memory block to Linux. This will usually only fail
+ * if out of memory.
+ *
+ * Must not be called with the vm->hotplug_mutex held (possible deadlock w=
ith
+ * onlining code).
+ *
+ * Will not modify the state of the memory block.
+ */
+static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
+{
+=09const uint64_t addr =3D virtio_mem_mb_id_to_phys(mb_id);
+=09int nid =3D memory_add_physaddr_to_nid(addr);
+
+=09dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
+=09return add_memory(nid, addr, memory_block_size_bytes());
+}
+
+/*
+ * Try to remove a memory block from Linux. Will only fail if the memory b=
lock
+ * is not offline.
+ *
+ * Must not be called with the vm->hotplug_mutex held (possible deadlock w=
ith
+ * onlining code).
+ *
+ * Will not modify the state of the memory block.
+ */
+static int virtio_mem_mb_remove(struct virtio_mem *vm, unsigned long mb_id=
)
+{
+=09const uint64_t addr =3D virtio_mem_mb_id_to_phys(mb_id);
+=09int nid =3D memory_add_physaddr_to_nid(addr);
+
+=09dev_dbg(&vm->vdev->dev, "removing memory block: %lu\n", mb_id);
+=09return remove_memory(nid, addr, memory_block_size_bytes());
+}
+
+/*
+ * Trigger the workqueue so the device can perform its magic.
+ */
+static void virtio_mem_retry(struct virtio_mem *vm)
+{
+=09unsigned long flags;
+
+=09spin_lock_irqsave(&vm->removal_lock, flags);
+=09if (!vm->removing)
+=09=09queue_work(system_freezable_wq, &vm->wq);
+=09spin_unlock_irqrestore(&vm->removal_lock, flags);
+}
+
+/*
+ * Test if a virtio-mem device overlaps with the given range. Can be calle=
d
+ * from (notifier) callbacks lockless.
+ */
+static bool virtio_mem_overlaps_range(struct virtio_mem *vm,
+=09=09=09=09      unsigned long start, unsigned long size)
+{
+=09unsigned long dev_start =3D virtio_mem_mb_id_to_phys(vm->first_mb_id);
+=09unsigned long dev_end =3D virtio_mem_mb_id_to_phys(vm->last_mb_id) +
+=09=09=09=09memory_block_size_bytes();
+
+=09return start < dev_end && dev_start < start + size;
+}
+
+/*
+ * Test if a virtio-mem device owns a memory block. Can be called from
+ * (notifier) callbacks lockless.
+ */
+static bool virtio_mem_owned_mb(struct virtio_mem *vm, unsigned long mb_id=
)
+{
+=09return mb_id >=3D vm->first_mb_id && mb_id <=3D vm->last_mb_id;
+}
+
+static int virtio_mem_notify_going_online(struct virtio_mem *vm,
+=09=09=09=09=09  unsigned long mb_id,
+=09=09=09=09=09  enum zone_type zone)
+{
+=09switch (virtio_mem_mb_get_state(vm, mb_id)) {
+=09case VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL:
+=09=09/*
+=09=09 * We won't allow to online a partially plugged memory block
+=09=09 * to the MOVABLE zone - it would contain unmovable parts.
+=09=09 */
+=09=09if (zone =3D=3D ZONE_MOVABLE) {
+=09=09=09dev_warn_ratelimited(&vm->vdev->dev,
+=09=09=09=09=09     "memory block has holes, MOVABLE not supported\n");
+=09=09=09return NOTIFY_BAD;
+=09=09}
+=09=09return NOTIFY_OK;
+=09case VIRTIO_MEM_MB_STATE_OFFLINE:
+=09=09return NOTIFY_OK;
+=09default:
+=09=09break;
+=09}
+=09dev_warn_ratelimited(&vm->vdev->dev,
+=09=09=09     "memory block onlining denied\n");
+=09return NOTIFY_BAD;
+}
+
+static void virtio_mem_notify_offline(struct virtio_mem *vm,
+=09=09=09=09      unsigned long mb_id)
+{
+=09switch (virtio_mem_mb_get_state(vm, mb_id)) {
+=09case VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL:
+=09=09virtio_mem_mb_set_state(vm, mb_id,
+=09=09=09=09=09VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL);
+=09=09break;
+=09case VIRTIO_MEM_MB_STATE_ONLINE:
+=09case VIRTIO_MEM_MB_STATE_ONLINE_MOVABLE:
+=09=09virtio_mem_mb_set_state(vm, mb_id,
+=09=09=09=09=09VIRTIO_MEM_MB_STATE_OFFLINE);
+=09=09break;
+=09default:
+=09=09BUG();
+=09=09break;
+=09}
+}
+
+static void virtio_mem_notify_online(struct virtio_mem *vm, unsigned long =
mb_id,
+=09=09=09=09     enum zone_type zone)
+{
+=09unsigned long nb_offline;
+
+=09switch (virtio_mem_mb_get_state(vm, mb_id)) {
+=09case VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL:
+=09=09BUG_ON(zone =3D=3D ZONE_MOVABLE);
+=09=09virtio_mem_mb_set_state(vm, mb_id,
+=09=09=09=09=09VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL);
+=09=09break;
+=09case VIRTIO_MEM_MB_STATE_OFFLINE:
+=09=09if (zone =3D=3D ZONE_MOVABLE)
+=09=09=09virtio_mem_mb_set_state(vm, mb_id,
+=09=09=09=09=09    VIRTIO_MEM_MB_STATE_ONLINE_MOVABLE);
+=09=09else
+=09=09=09virtio_mem_mb_set_state(vm, mb_id,
+=09=09=09=09=09=09VIRTIO_MEM_MB_STATE_ONLINE);
+=09=09break;
+=09default:
+=09=09BUG();
+=09=09break;
+=09}
+=09nb_offline =3D vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE] +
+=09=09     vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL];
+
+=09/* see if we can add new blocks now that we onlined one block */
+=09if (nb_offline =3D=3D VIRTIO_MEM_NB_OFFLINE_THRESHOLD - 1)
+=09=09virtio_mem_retry(vm);
+}
+
+/*
+ * This callback will either be called synchronously from add_memory() or
+ * asynchronously (e.g., triggered via user space). We have to be careful
+ * with locking when calling add_memory().
+ */
+static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
+=09=09=09=09=09 unsigned long action, void *arg)
+{
+=09struct virtio_mem *vm =3D container_of(nb, struct virtio_mem,
+=09=09=09=09=09     memory_notifier);
+=09struct memory_notify *mhp =3D arg;
+=09const unsigned long start =3D PFN_PHYS(mhp->start_pfn);
+=09const unsigned long size =3D PFN_PHYS(mhp->nr_pages);
+=09const unsigned long mb_id =3D virtio_mem_phys_to_mb_id(start);
+=09enum zone_type zone;
+=09int rc =3D NOTIFY_OK;
+
+=09if (!virtio_mem_overlaps_range(vm, start, size))
+=09=09return NOTIFY_DONE;
+
+=09/*
+=09 * Memory is onlined/offlined in memory block granularity. We cannot
+=09 * cross virtio-mem device boundaries and memory block boundaries. Bail
+=09 * out if this ever changes.
+=09 */
+=09if (WARN_ON_ONCE(size !=3D memory_block_size_bytes() ||
+=09=09=09 !IS_ALIGNED(start, memory_block_size_bytes())))
+=09=09return NOTIFY_BAD;
+
+=09/*
+=09 * Avoid circular locking lockdep warnings. We lock the mutex
+=09 * e.g., in MEM_GOING_ONLINE and unlock it in MEM_ONLINE. The
+=09 * blocking_notifier_call_chain() has it's own lock, which gets unlocke=
d
+=09 * between both notifier calls and will bail out. False positive.
+=09 */
+=09lockdep_off();
+
+=09switch (action) {
+=09case MEM_GOING_OFFLINE:
+=09=09mutex_lock(&vm->hotplug_mutex);
+=09=09if (vm->removing) {
+=09=09=09rc =3D notifier_from_errno(-EBUSY);
+=09=09=09mutex_unlock(&vm->hotplug_mutex);
+=09=09=09break;
+=09=09}
+=09=09vm->hotplug_active =3D true;
+=09=09break;
+=09case MEM_GOING_ONLINE:
+=09=09mutex_lock(&vm->hotplug_mutex);
+=09=09if (vm->removing) {
+=09=09=09rc =3D notifier_from_errno(-EBUSY);
+=09=09=09mutex_unlock(&vm->hotplug_mutex);
+=09=09=09break;
+=09=09}
+=09=09vm->hotplug_active =3D true;
+=09=09zone =3D page_zonenum(pfn_to_page(mhp->start_pfn));
+=09=09rc =3D virtio_mem_notify_going_online(vm, mb_id, zone);
+=09=09break;
+=09case MEM_OFFLINE:
+=09=09virtio_mem_notify_offline(vm, mb_id);
+=09=09vm->hotplug_active =3D false;
+=09=09mutex_unlock(&vm->hotplug_mutex);
+=09=09break;
+=09case MEM_ONLINE:
+=09=09zone =3D page_zonenum(pfn_to_page(mhp->start_pfn));
+=09=09virtio_mem_notify_online(vm, mb_id, zone);
+=09=09vm->hotplug_active =3D false;
+=09=09mutex_unlock(&vm->hotplug_mutex);
+=09=09break;
+=09case MEM_CANCEL_OFFLINE:
+=09case MEM_CANCEL_ONLINE:
+=09=09if (!vm->hotplug_active)
+=09=09=09break;
+=09=09vm->hotplug_active =3D false;
+=09=09mutex_unlock(&vm->hotplug_mutex);
+=09=09break;
+=09default:
+=09=09break;
+=09}
+
+=09lockdep_on();
+
+=09return rc;
+}
+
+/*
+ * Set a range of pages PG_offline.
+ */
+static void virtio_mem_set_fake_offline(unsigned long pfn,
+=09=09=09=09=09unsigned int nr_pages)
+{
+=09for (; nr_pages--; pfn++)
+=09=09__SetPageOffline(pfn_to_page(pfn));
+}
+
+/*
+ * Clear PG_offline from a range of pages.
+ */
+static void virtio_mem_clear_fake_offline(unsigned long pfn,
+=09=09=09=09=09  unsigned int nr_pages)
+{
+=09for (; nr_pages--; pfn++)
+=09=09__ClearPageOffline(pfn_to_page(pfn));
+}
+
+/*
+ * Release a range of fake-offline pages to the buddy, effectively
+ * fake-onlining them.
+ */
+static void virtio_mem_fake_online(unsigned long pfn, unsigned int nr_page=
s)
+{
+=09const int order =3D MAX_ORDER - 1;
+=09int i;
+
+=09/*
+=09 * We are always called with subblock granularity, which is at least
+=09 * aligned to MAX_ORDER - 1.
+=09 */
+=09virtio_mem_clear_fake_offline(pfn, nr_pages);
+
+=09for (i =3D 0; i < nr_pages; i +=3D 1 << order)
+=09=09generic_online_page(pfn_to_page(pfn + i), order);
+}
+
+static void virtio_mem_online_page_cb(struct page *page, unsigned int orde=
r)
+{
+=09const unsigned long addr =3D page_to_phys(page);
+=09const unsigned long mb_id =3D virtio_mem_phys_to_mb_id(addr);
+=09struct virtio_mem *vm;
+=09int sb_id;
+
+=09/*
+=09 * We exploit here that subblocks have at least MAX_ORDER - 1
+=09 * size/alignment and that this callback is is called with such a
+=09 * size/alignment. So we cannot cross subblocks and therefore
+=09 * also not memory blocks.
+=09 */
+=09rcu_read_lock();
+=09list_for_each_entry_rcu(vm, &virtio_mem_devices, next) {
+=09=09if (!virtio_mem_owned_mb(vm, mb_id))
+=09=09=09continue;
+
+=09=09sb_id =3D virtio_mem_phys_to_sb_id(vm, addr);
+=09=09/*
+=09=09 * If plugged, online the pages, otherwise, set them fake
+=09=09 * offline (PageOffline).
+=09=09 */
+=09=09if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
+=09=09=09generic_online_page(page, order);
+=09=09else
+=09=09=09virtio_mem_set_fake_offline(PFN_DOWN(addr), 1 << order);
+=09=09rcu_read_unlock();
+=09=09return;
+=09}
+=09rcu_read_unlock();
+
+=09/* not virtio-mem memory, but e.g., a DIMM. online it */
+=09generic_online_page(page, order);
+}
+
+static uint64_t virtio_mem_send_request(struct virtio_mem *vm,
+=09=09=09=09=09const struct virtio_mem_req *req)
+{
+=09struct scatterlist *sgs[2], sg_req, sg_resp;
+=09unsigned int len;
+=09int rc;
+
+=09/* don't use the request residing on the stack (vaddr) */
+=09vm->req =3D *req;
+
+=09/* out: buffer for request */
+=09sg_init_one(&sg_req, &vm->req, sizeof(vm->req));
+=09sgs[0] =3D &sg_req;
+
+=09/* in: buffer for response */
+=09sg_init_one(&sg_resp, &vm->resp, sizeof(vm->resp));
+=09sgs[1] =3D &sg_resp;
+
+=09rc =3D virtqueue_add_sgs(vm->vq, sgs, 1, 1, vm, GFP_KERNEL);
+=09if (rc < 0)
+=09=09return rc;
+
+=09virtqueue_kick(vm->vq);
+
+=09/* wait for a response */
+=09wait_event(vm->host_resp, virtqueue_get_buf(vm->vq, &len));
+
+=09return virtio16_to_cpu(vm->vdev, vm->resp.type);
+}
+
+static int virtio_mem_send_plug_request(struct virtio_mem *vm, uint64_t ad=
dr,
+=09=09=09=09=09uint64_t size)
+{
+=09const uint64_t nb_vm_blocks =3D size / vm->device_block_size;
+=09const struct virtio_mem_req req =3D {
+=09=09.type =3D cpu_to_virtio16(vm->vdev, VIRTIO_MEM_REQ_PLUG),
+=09=09.u.plug.addr =3D cpu_to_virtio64(vm->vdev, addr),
+=09=09.u.plug.nb_blocks =3D cpu_to_virtio16(vm->vdev, nb_vm_blocks),
+=09};
+
+=09if (atomic_read(&vm->config_changed))
+=09=09return -EAGAIN;
+
+=09switch (virtio_mem_send_request(vm, &req)) {
+=09case VIRTIO_MEM_RESP_ACK:
+=09=09vm->plugged_size +=3D size;
+=09=09return 0;
+=09case VIRTIO_MEM_RESP_NACK:
+=09=09return -EAGAIN;
+=09case VIRTIO_MEM_RESP_BUSY:
+=09=09return -EBUSY;
+=09case VIRTIO_MEM_RESP_ERROR:
+=09=09return -EINVAL;
+=09default:
+=09=09return -ENOMEM;
+=09}
+}
+
+static int virtio_mem_send_unplug_request(struct virtio_mem *vm, uint64_t =
addr,
+=09=09=09=09=09  uint64_t size)
+{
+=09const uint64_t nb_vm_blocks =3D size / vm->device_block_size;
+=09const struct virtio_mem_req req =3D {
+=09=09.type =3D cpu_to_virtio16(vm->vdev, VIRTIO_MEM_REQ_UNPLUG),
+=09=09.u.unplug.addr =3D cpu_to_virtio64(vm->vdev, addr),
+=09=09.u.unplug.nb_blocks =3D cpu_to_virtio16(vm->vdev, nb_vm_blocks),
+=09};
+
+=09if (atomic_read(&vm->config_changed))
+=09=09return -EAGAIN;
+
+=09switch (virtio_mem_send_request(vm, &req)) {
+=09case VIRTIO_MEM_RESP_ACK:
+=09=09vm->plugged_size -=3D size;
+=09=09return 0;
+=09case VIRTIO_MEM_RESP_BUSY:
+=09=09return -EBUSY;
+=09case VIRTIO_MEM_RESP_ERROR:
+=09=09return -EINVAL;
+=09default:
+=09=09return -ENOMEM;
+=09}
+}
+
+static int virtio_mem_send_unplug_all_request(struct virtio_mem *vm)
+{
+=09const struct virtio_mem_req req =3D {
+=09=09.type =3D cpu_to_virtio16(vm->vdev, VIRTIO_MEM_REQ_UNPLUG_ALL),
+=09};
+
+=09switch (virtio_mem_send_request(vm, &req)) {
+=09case VIRTIO_MEM_RESP_ACK:
+=09=09vm->unplug_all_required =3D false;
+=09=09vm->plugged_size =3D 0;
+=09=09/* usable region might have shrunk */
+=09=09atomic_set(&vm->config_changed, 1);
+=09=09return 0;
+=09case VIRTIO_MEM_RESP_BUSY:
+=09=09return -EBUSY;
+=09default:
+=09=09return -ENOMEM;
+=09}
+}
+
+/*
+ * Plug selected subblocks. Updates the plugged state, but not the state
+ * of the memory block.
+ */
+static int virtio_mem_mb_plug_sb(struct virtio_mem *vm, unsigned long mb_i=
d,
+=09=09=09=09 int sb_id, int count)
+{
+=09const uint64_t addr =3D virtio_mem_mb_id_to_phys(mb_id) +
+=09=09=09      sb_id * vm->subblock_size;
+=09const uint64_t size =3D count * vm->subblock_size;
+=09int rc;
+
+=09dev_dbg(&vm->vdev->dev, "plugging memory block: %lu : %i - %i\n", mb_id=
,
+=09=09sb_id, sb_id + count - 1);
+
+=09rc =3D virtio_mem_send_plug_request(vm, addr, size);
+=09if (!rc)
+=09=09virtio_mem_mb_set_sb_plugged(vm, mb_id, sb_id, count);
+=09return rc;
+}
+
+/*
+ * Unplug selected subblocks. Updates the plugged state, but not the state
+ * of the memory block.
+ */
+static int virtio_mem_mb_unplug_sb(struct virtio_mem *vm, unsigned long mb=
_id,
+=09=09=09=09   int sb_id, int count)
+{
+=09const uint64_t addr =3D virtio_mem_mb_id_to_phys(mb_id) +
+=09=09=09      sb_id * vm->subblock_size;
+=09const uint64_t size =3D count * vm->subblock_size;
+=09int rc;
+
+=09dev_dbg(&vm->vdev->dev, "unplugging memory block: %lu : %i - %i\n",
+=09=09mb_id, sb_id, sb_id + count - 1);
+
+=09rc =3D virtio_mem_send_unplug_request(vm, addr, size);
+=09if (!rc)
+=09=09virtio_mem_mb_set_sb_unplugged(vm, mb_id, sb_id, count);
+=09return rc;
+}
+
+/*
+ * Unplug the desired number of plugged subblocks of a offline or not-adde=
d
+ * memory block. Will fail if any subblock cannot get unplugged (instead o=
f
+ * skipping it).
+ *
+ * Will not modify the state of the memory block.
+ *
+ * Note: can fail after some subblocks were unplugged.
+ */
+static int virtio_mem_mb_unplug_any_sb(struct virtio_mem *vm,
+=09=09=09=09       unsigned long mb_id, uint64_t *nb_sb)
+{
+=09int sb_id, count;
+=09int rc;
+
+=09while (*nb_sb) {
+=09=09sb_id =3D virtio_mem_mb_first_plugged_sb(vm, mb_id);
+=09=09if (sb_id >=3D vm->nb_sb_per_mb)
+=09=09=09break;
+=09=09count =3D 1;
+=09=09while (count < *nb_sb &&
+=09=09       sb_id + count  < vm->nb_sb_per_mb &&
+=09=09       virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id + count,
+=09=09=09=09=09=09     1))
+=09=09=09count++;
+
+=09=09rc =3D virtio_mem_mb_unplug_sb(vm, mb_id, sb_id, count);
+=09=09if (rc)
+=09=09=09return rc;
+=09=09*nb_sb -=3D count;
+=09}
+
+=09return 0;
+}
+
+/*
+ * Unplug all plugged subblocks of an offline or not-added memory block.
+ *
+ * Will not modify the state of the memory block.
+ *
+ * Note: can fail after some subblocks were unplugged.
+ */
+static int virtio_mem_mb_unplug(struct virtio_mem *vm, unsigned long mb_id=
)
+{
+=09uint64_t nb_sb =3D vm->nb_sb_per_mb;
+
+=09return virtio_mem_mb_unplug_any_sb(vm, mb_id, &nb_sb);
+}
+
+/*
+ * Prepare tracking data for the next memory block.
+ */
+static int virtio_mem_prepare_next_mb(struct virtio_mem *vm,
+=09=09=09=09      unsigned long *mb_id)
+{
+=09int rc;
+
+=09if (vm->next_mb_id > vm->last_usable_mb_id)
+=09=09return -ENOSPC;
+
+=09/* Resize the state array if required. */
+=09rc =3D virtio_mem_mb_state_prepare_next_mb(vm);
+=09if (rc)
+=09=09return rc;
+
+=09/* Resize the subblock bitmap if required. */
+=09rc =3D virtio_mem_sb_bitmap_prepare_next_mb(vm);
+=09if (rc)
+=09=09return rc;
+
+=09vm->nb_mb_state[VIRTIO_MEM_MB_STATE_UNUSED]++;
+=09*mb_id =3D vm->next_mb_id++;
+=09return 0;
+}
+
+/*
+ * Don't add too many blocks that are not onlined yet to avoid running OOM=
.
+ */
+static bool virtio_mem_too_many_mb_offline(struct virtio_mem *vm)
+{
+=09unsigned long nb_offline;
+
+=09nb_offline =3D vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE] +
+=09=09     vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL];
+=09return nb_offline >=3D VIRTIO_MEM_NB_OFFLINE_THRESHOLD;
+}
+
+/*
+ * Try to plug the desired number of subblocks and add the memory block
+ * to Linux.
+ *
+ * Will modify the state of the memory block.
+ */
+static int virtio_mem_mb_plug_and_add(struct virtio_mem *vm,
+=09=09=09=09      unsigned long mb_id,
+=09=09=09=09      uint64_t *nb_sb)
+{
+=09const int count =3D min_t(int, *nb_sb, vm->nb_sb_per_mb);
+=09int rc, rc2;
+
+=09if (WARN_ON_ONCE(!count))
+=09=09return -EINVAL;
+
+=09/*
+=09 * Plug the requested number of subblocks before adding it to linux,
+=09 * so that onlining will directly online all plugged subblocks.
+=09 */
+=09rc =3D virtio_mem_mb_plug_sb(vm, mb_id, 0, count);
+=09if (rc)
+=09=09return rc;
+
+=09/*
+=09 * Mark the block properly offline before adding it to Linux,
+=09 * so the memory notifiers will find the block in the right state.
+=09 */
+=09if (count =3D=3D vm->nb_sb_per_mb)
+=09=09virtio_mem_mb_set_state(vm, mb_id,
+=09=09=09=09=09VIRTIO_MEM_MB_STATE_OFFLINE);
+=09else
+=09=09virtio_mem_mb_set_state(vm, mb_id,
+=09=09=09=09=09VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL);
+
+=09/* Add the memory block to linux - if that fails, try to unplug. */
+=09rc =3D virtio_mem_mb_add(vm, mb_id);
+=09if (rc) {
+=09=09enum virtio_mem_mb_state new_state =3D VIRTIO_MEM_MB_STATE_UNUSED;
+
+=09=09dev_err(&vm->vdev->dev,
+=09=09=09"adding memory block %lu failed with %d\n", mb_id, rc);
+=09=09rc2 =3D virtio_mem_mb_unplug_sb(vm, mb_id, 0, count);
+
+=09=09/*
+=09=09 * TODO: Linux MM does not properly clean up yet in all cases
+=09=09 * where adding of memory failed - especially on -ENOMEM.
+=09=09 */
+=09=09if (rc2)
+=09=09=09new_state =3D VIRTIO_MEM_MB_STATE_PLUGGED;
+=09=09virtio_mem_mb_set_state(vm, mb_id, new_state);
+=09=09return rc;
+=09}
+
+=09*nb_sb -=3D count;
+=09return 0;
+}
+
+/*
+ * Try to plug the desired number of subblocks of a memory block that
+ * is already added to Linux.
+ *
+ * Will modify the state of the memory block.
+ *
+ * Note: Can fail after some subblocks were successfully plugged.
+ */
+static int virtio_mem_mb_plug_any_sb(struct virtio_mem *vm, unsigned long =
mb_id,
+=09=09=09=09     uint64_t *nb_sb, bool online)
+{
+=09unsigned long pfn, nr_pages;
+=09int sb_id, count;
+=09int rc;
+
+=09if (WARN_ON_ONCE(!*nb_sb))
+=09=09return -EINVAL;
+
+=09while (*nb_sb) {
+=09=09sb_id =3D virtio_mem_mb_first_unplugged_sb(vm, mb_id);
+=09=09if (sb_id >=3D vm->nb_sb_per_mb)
+=09=09=09break;
+=09=09count =3D 1;
+=09=09while (count < *nb_sb &&
+=09=09       sb_id + count < vm->nb_sb_per_mb &&
+=09=09       !virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id + count,
+=09=09=09=09=09=09      1))
+=09=09=09count++;
+
+=09=09rc =3D virtio_mem_mb_plug_sb(vm, mb_id, sb_id, count);
+=09=09if (rc)
+=09=09=09return rc;
+=09=09*nb_sb -=3D count;
+=09=09if (!online)
+=09=09=09continue;
+
+=09=09/* fake-online the pages if the memory block is online */
+=09=09pfn =3D PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
+=09=09=09       sb_id * vm->subblock_size);
+=09=09nr_pages =3D PFN_DOWN(count * vm->subblock_size);
+=09=09virtio_mem_fake_online(pfn, nr_pages);
+=09}
+
+=09if (virtio_mem_mb_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
+=09=09if (online)
+=09=09=09virtio_mem_mb_set_state(vm, mb_id,
+=09=09=09=09=09=09VIRTIO_MEM_MB_STATE_ONLINE);
+=09=09else
+=09=09=09virtio_mem_mb_set_state(vm, mb_id,
+=09=09=09=09=09=09VIRTIO_MEM_MB_STATE_OFFLINE);
+=09}
+
+=09return rc;
+}
+
+/*
+ * Try to plug the requested amount of memory.
+ */
+static int virtio_mem_plug_request(struct virtio_mem *vm, uint64_t diff)
+{
+=09uint64_t nb_sb =3D diff / vm->subblock_size;
+=09unsigned long mb_id;
+=09int rc;
+
+=09if (!nb_sb)
+=09=09return 0;
+
+=09/* Don't race with onlining/offlining */
+=09mutex_lock(&vm->hotplug_mutex);
+
+=09/* Try to plug subblocks of partially plugged online blocks. */
+=09virtio_mem_for_each_mb_state(vm, mb_id,
+=09=09=09=09     VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL) {
+=09=09rc =3D virtio_mem_mb_plug_any_sb(vm, mb_id, &nb_sb, true);
+=09=09if (rc || !nb_sb)
+=09=09=09goto out_unlock;
+=09=09cond_resched();
+=09}
+
+=09/* Try to plug subblocks of partially plugged offline blocks. */
+=09virtio_mem_for_each_mb_state(vm, mb_id,
+=09=09=09=09     VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL) {
+=09=09rc =3D virtio_mem_mb_plug_any_sb(vm, mb_id, &nb_sb, false);
+=09=09if (rc || !nb_sb)
+=09=09=09goto out_unlock;
+=09=09cond_resched();
+=09}
+
+=09/*
+=09 * We won't be working on online/offline memory blocks from this point,
+=09 * so we can't race with memory onlining/offlining. Drop the mutex.
+=09 */
+=09mutex_unlock(&vm->hotplug_mutex);
+
+=09/* Try to plug and add unused blocks */
+=09virtio_mem_for_each_mb_state(vm, mb_id, VIRTIO_MEM_MB_STATE_UNUSED) {
+=09=09if (virtio_mem_too_many_mb_offline(vm))
+=09=09=09return -ENOSPC;
+
+=09=09rc =3D virtio_mem_mb_plug_and_add(vm, mb_id, &nb_sb);
+=09=09if (rc || !nb_sb)
+=09=09=09return rc;
+=09=09cond_resched();
+=09}
+
+=09/* Try to prepare, plug and add new blocks */
+=09while (nb_sb) {
+=09=09if (virtio_mem_too_many_mb_offline(vm))
+=09=09=09return -ENOSPC;
+
+=09=09rc =3D virtio_mem_prepare_next_mb(vm, &mb_id);
+=09=09if (rc)
+=09=09=09return rc;
+=09=09rc =3D virtio_mem_mb_plug_and_add(vm, mb_id, &nb_sb);
+=09=09if (rc)
+=09=09=09return rc;
+=09=09cond_resched();
+=09}
+
+=09return 0;
+out_unlock:
+=09mutex_unlock(&vm->hotplug_mutex);
+=09return rc;
+}
+
+/*
+ * Try to unplug all blocks that couldn't be unplugged before, for example=
,
+ * because the hypervisor was busy.
+ */
+static int virtio_mem_unplug_pending_mb(struct virtio_mem *vm)
+{
+=09unsigned long mb_id;
+=09int rc;
+
+=09virtio_mem_for_each_mb_state(vm, mb_id, VIRTIO_MEM_MB_STATE_PLUGGED) {
+=09=09rc =3D virtio_mem_mb_unplug(vm, mb_id);
+=09=09if (rc)
+=09=09=09return rc;
+=09=09virtio_mem_mb_set_state(vm, mb_id, VIRTIO_MEM_MB_STATE_UNUSED);
+=09}
+
+=09return 0;
+}
+
+/*
+ * Update all parts of the config that could have changed.
+ */
+static void virtio_mem_refresh_config(struct virtio_mem *vm)
+{
+=09const uint64_t phys_limit =3D 1UL << MAX_PHYSMEM_BITS;
+=09uint64_t new_plugged_size, usable_region_size, end_addr;
+
+=09/* the plugged_size is just a reflection of what _we_ did previously */
+=09virtio_cread(vm->vdev, struct virtio_mem_config, plugged_size,
+=09=09     &new_plugged_size);
+=09if (WARN_ON_ONCE(new_plugged_size !=3D vm->plugged_size))
+=09=09vm->plugged_size =3D new_plugged_size;
+
+=09/* calculate the last usable memory block id */
+=09virtio_cread(vm->vdev, struct virtio_mem_config,
+=09=09     usable_region_size, &usable_region_size);
+=09end_addr =3D vm->addr + usable_region_size;
+=09end_addr =3D min(end_addr, phys_limit);
+=09vm->last_usable_mb_id =3D virtio_mem_phys_to_mb_id(end_addr) - 1;
+
+=09/* see if there is a request to change the size */
+=09virtio_cread(vm->vdev, struct virtio_mem_config, requested_size,
+=09=09     &vm->requested_size);
+
+=09dev_info(&vm->vdev->dev, "plugged size: 0x%llx", vm->plugged_size);
+=09dev_info(&vm->vdev->dev, "requested size: 0x%llx", vm->requested_size);
+}
+
+/*
+ * Workqueue function for handling plug/unplug requests and config updates=
.
+ */
+static void virtio_mem_run_wq(struct work_struct *work)
+{
+=09struct virtio_mem *vm =3D container_of(work, struct virtio_mem, wq);
+=09uint64_t diff;
+=09int rc;
+
+=09hrtimer_cancel(&vm->retry_timer);
+
+=09if (vm->broken)
+=09=09return;
+
+retry:
+=09rc =3D 0;
+
+=09/* Make sure we start with a clean state if there are leftovers. */
+=09if (unlikely(vm->unplug_all_required))
+=09=09rc =3D virtio_mem_send_unplug_all_request(vm);
+
+=09if (atomic_read(&vm->config_changed)) {
+=09=09atomic_set(&vm->config_changed, 0);
+=09=09virtio_mem_refresh_config(vm);
+=09}
+
+=09/* Unplug any leftovers from previous runs */
+=09if (!rc)
+=09=09rc =3D virtio_mem_unplug_pending_mb(vm);
+
+=09if (!rc && vm->requested_size !=3D vm->plugged_size) {
+=09=09if (vm->requested_size > vm->plugged_size) {
+=09=09=09diff =3D vm->requested_size - vm->plugged_size;
+=09=09=09rc =3D virtio_mem_plug_request(vm, diff);
+=09=09}
+=09=09/* TODO: try to unplug memory */
+=09}
+
+=09switch (rc) {
+=09case 0:
+=09=09break;
+=09case -ENOSPC:
+=09=09/*
+=09=09 * We cannot add any more memory (alignment, physical limit)
+=09=09 * or we have too many offline memory blocks.
+=09=09 */
+=09=09break;
+=09case -EBUSY:
+=09=09/*
+=09=09 * The hypervisor cannot process our request right now
+=09=09 * (e.g., out of memory, migrating).
+=09=09 */
+=09case -ENOMEM:
+=09=09/* Out of memory, try again later. */
+=09=09hrtimer_start(&vm->retry_timer,
+=09=09=09      ms_to_ktime(VIRTIO_MEM_RETRY_TIMER_MS),
+=09=09=09      HRTIMER_MODE_REL);
+=09=09break;
+=09case -EAGAIN:
+=09=09/* Retry immediately (e.g., the config changed). */
+=09=09goto retry;
+=09default:
+=09=09/* Unknown error, mark as broken */
+=09=09dev_err(&vm->vdev->dev,
+=09=09=09"unknown error, marking device broken: %d\n", rc);
+=09=09vm->broken =3D true;
+=09}
+}
+
+static enum hrtimer_restart virtio_mem_timer_expired(struct hrtimer *timer=
)
+{
+=09struct virtio_mem *vm =3D container_of(timer, struct virtio_mem,
+=09=09=09=09=09     retry_timer);
+
+=09virtio_mem_retry(vm);
+=09return HRTIMER_NORESTART;
+}
+
+static void virtio_mem_handle_response(struct virtqueue *vq)
+{
+=09struct virtio_mem *vm =3D vq->vdev->priv;
+
+=09wake_up(&vm->host_resp);
+}
+
+static int virtio_mem_init_vq(struct virtio_mem *vm)
+{
+=09struct virtqueue *vq;
+
+=09vq =3D virtio_find_single_vq(vm->vdev, virtio_mem_handle_response,
+=09=09=09=09   "guest-request");
+=09if (IS_ERR(vq))
+=09=09return PTR_ERR(vq);
+=09vm->vq =3D vq;
+
+=09return 0;
+}
+
+/*
+ * Test if any memory in the range is present in Linux.
+ */
+static bool virtio_mem_any_memory_present(unsigned long start,
+=09=09=09=09=09  unsigned long size)
+{
+=09const unsigned long start_pfn =3D PFN_DOWN(start);
+=09const unsigned long end_pfn =3D PFN_UP(start + size);
+=09unsigned long pfn;
+
+=09for (pfn =3D start_pfn; pfn !=3D end_pfn; pfn++)
+=09=09if (present_section_nr(pfn_to_section_nr(pfn)))
+=09=09=09return true;
+
+=09return false;
+}
+
+static int virtio_mem_init(struct virtio_mem *vm)
+{
+=09const uint64_t phys_limit =3D 1UL << MAX_PHYSMEM_BITS;
+
+=09if (!vm->vdev->config->get) {
+=09=09dev_err(&vm->vdev->dev, "config access disabled\n");
+=09=09return -EINVAL;
+=09}
+
+=09/*
+=09 * We don't want to (un)plug or reuse any memory when in kdump. The
+=09 * memory is still accessible (but not mapped).
+=09 */
+=09if (is_kdump_kernel()) {
+=09=09dev_warn(&vm->vdev->dev, "disabled in kdump kernel\n");
+=09=09return -EBUSY;
+=09}
+
+=09/* Fetch all properties that can't change. */
+=09virtio_cread(vm->vdev, struct virtio_mem_config, plugged_size,
+=09=09     &vm->plugged_size);
+=09virtio_cread(vm->vdev, struct virtio_mem_config, block_size,
+=09=09     &vm->device_block_size);
+=09virtio_cread(vm->vdev, struct virtio_mem_config, addr, &vm->addr);
+=09virtio_cread(vm->vdev, struct virtio_mem_config, region_size,
+=09=09     &vm->region_size);
+
+=09/*
+=09 * If we still have memory plugged, we might have to unplug all
+=09 * memory first. However, if somebody simply unloaded the driver
+=09 * we would have to reinitialize the old state - something we don't
+=09 * support yet. Detect if we have any memory in the area present.
+=09 */
+=09if (vm->plugged_size) {
+=09=09uint64_t usable_region_size;
+
+=09=09virtio_cread(vm->vdev, struct virtio_mem_config,
+=09=09=09     usable_region_size, &usable_region_size);
+
+=09=09if (virtio_mem_any_memory_present(vm->addr,
+=09=09=09=09=09=09  usable_region_size)) {
+=09=09=09dev_err(&vm->vdev->dev,
+=09=09=09=09"reloading the driver is not supported\n");
+=09=09=09return -EINVAL;
+=09=09}
+=09=09/*
+=09=09 * Note: it might happen that the device is busy and
+=09=09 * unplugging all memory might take some time.
+=09=09 */
+=09=09dev_info(&vm->vdev->dev, "unplugging all memory required\n");
+=09=09vm->unplug_all_required =3D 1;
+=09}
+
+=09/*
+=09 * We always hotplug memory in memory block granularity. This way,
+=09 * we have to wait for exactly one memory block to online.
+=09 */
+=09if (vm->device_block_size > memory_block_size_bytes()) {
+=09=09dev_err(&vm->vdev->dev,
+=09=09=09"The block size is not supported (too big).\n");
+=09=09return -EINVAL;
+=09}
+
+=09/* bad device setup - warn only */
+=09if (!IS_ALIGNED(vm->addr, memory_block_size_bytes()))
+=09=09dev_warn(&vm->vdev->dev,
+=09=09=09 "The alignment of the physical start address can make some memor=
y unusable.\n");
+=09if (!IS_ALIGNED(vm->addr + vm->region_size, memory_block_size_bytes()))
+=09=09dev_warn(&vm->vdev->dev,
+=09=09=09 "The alignment of the physical end address can make some memory =
unusable.\n");
+=09if (vm->addr + vm->region_size > phys_limit)
+=09=09dev_warn(&vm->vdev->dev,
+=09=09=09 "Some memory is not addressable. This can make some memory unusa=
ble.\n");
+
+=09/*
+=09 * Calculate the subblock size:
+=09 * - At least MAX_ORDER - 1 / pageblock_order.
+=09 * - At least the device block size.
+=09 * In the worst case, a single subblock per memory block.
+=09 */
+=09vm->subblock_size =3D PAGE_SIZE * 1u << max_t(uint32_t, MAX_ORDER - 1,
+=09=09=09=09=09=09    pageblock_order);
+=09vm->subblock_size =3D max_t(uint32_t, vm->device_block_size,
+=09=09=09=09  vm->subblock_size);
+=09vm->nb_sb_per_mb =3D memory_block_size_bytes() / vm->subblock_size;
+
+=09/* Round up to the next full memory block */
+=09vm->first_mb_id =3D virtio_mem_phys_to_mb_id(vm->addr - 1 +
+=09=09=09=09=09=09   memory_block_size_bytes());
+=09vm->next_mb_id =3D vm->first_mb_id;
+=09vm->last_mb_id =3D virtio_mem_phys_to_mb_id(vm->addr +
+=09=09=09 vm->region_size) - 1;
+
+=09dev_info(&vm->vdev->dev, "start address: 0x%llx", vm->addr);
+=09dev_info(&vm->vdev->dev, "region size: 0x%llx", vm->region_size);
+=09dev_info(&vm->vdev->dev, "device block size: 0x%x",
+=09=09 vm->device_block_size);
+=09dev_info(&vm->vdev->dev, "memory block size: 0x%lx",
+=09=09 memory_block_size_bytes());
+=09dev_info(&vm->vdev->dev, "subblock size: 0x%x",
+=09=09 vm->subblock_size);
+
+=09return 0;
+}
+
+static int virtio_mem_probe(struct virtio_device *vdev)
+{
+=09struct virtio_mem *vm;
+=09int rc =3D -EINVAL;
+
+=09vdev->priv =3D vm =3D kzalloc(sizeof(*vm), GFP_KERNEL);
+=09if (!vm)
+=09=09return -ENOMEM;
+
+=09init_waitqueue_head(&vm->host_resp);
+=09vm->vdev =3D vdev;
+=09INIT_WORK(&vm->wq, virtio_mem_run_wq);
+=09mutex_init(&vm->hotplug_mutex);
+=09INIT_LIST_HEAD(&vm->next);
+=09spin_lock_init(&vm->removal_lock);
+=09hrtimer_init(&vm->retry_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+=09vm->retry_timer.function =3D virtio_mem_timer_expired;
+
+=09/* register the virtqueue */
+=09rc =3D virtio_mem_init_vq(vm);
+=09if (rc)
+=09=09goto out_free_vm;
+
+=09/* initialize the device by querying the config */
+=09rc =3D virtio_mem_init(vm);
+=09if (rc)
+=09=09goto out_del_vq;
+
+=09/* register callbacks */
+=09vm->memory_notifier.notifier_call =3D virtio_mem_memory_notifier_cb;
+=09rc =3D register_memory_notifier(&vm->memory_notifier);
+=09if (rc)
+=09=09goto out_del_vq;
+=09rc =3D register_virtio_mem_device(vm);
+=09if (rc)
+=09=09goto out_unreg_mem;
+
+=09virtio_device_ready(vdev);
+
+=09/* trigger a config update to start processing the requested_size */
+=09atomic_set(&vm->config_changed, 1);
+=09queue_work(system_freezable_wq, &vm->wq);
+
+=09return 0;
+out_unreg_mem:
+=09unregister_memory_notifier(&vm->memory_notifier);
+out_del_vq:
+=09vdev->config->del_vqs(vdev);
+out_free_vm:
+=09kfree(vm);
+=09vdev->priv =3D NULL;
+
+=09return rc;
+}
+
+static void virtio_mem_remove(struct virtio_device *vdev)
+{
+=09struct virtio_mem *vm =3D vdev->priv;
+=09unsigned long mb_id;
+=09int rc;
+
+=09/*
+=09 * Make sure the workqueue won't be triggered anymore and no memory
+=09 * blocks can be onlined/offlined until we're finished here.
+=09 */
+=09mutex_lock(&vm->hotplug_mutex);
+=09spin_lock_irq(&vm->removal_lock);
+=09vm->removing =3D true;
+=09spin_unlock_irq(&vm->removal_lock);
+=09mutex_unlock(&vm->hotplug_mutex);
+
+=09/* wait until the workqueue stopped */
+=09cancel_work_sync(&vm->wq);
+=09hrtimer_cancel(&vm->retry_timer);
+
+=09/*
+=09 * After we unregistered our callbacks, user space can online partially
+=09 * plugged offline blocks. Make sure to remove them.
+=09 */
+=09virtio_mem_for_each_mb_state(vm, mb_id,
+=09=09=09=09     VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL) {
+=09=09rc =3D virtio_mem_mb_remove(vm, mb_id);
+=09=09BUG_ON(rc);
+=09=09virtio_mem_mb_set_state(vm, mb_id, VIRTIO_MEM_MB_STATE_UNUSED);
+=09}
+
+=09/* unregister callbacks */
+=09unregister_virtio_mem_device(vm);
+=09unregister_memory_notifier(&vm->memory_notifier);
+
+=09/*
+=09 * There is no way we could reliably remove all memory we have added to
+=09 * the system. And there is no way to stop the driver/device from going
+=09 * away. Warn at least.
+=09 */
+=09if (vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE] ||
+=09    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL] ||
+=09    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE] ||
+=09    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL] ||
+=09    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_MOVABLE])
+=09=09dev_warn(&vdev->dev, "device still has system memory added\n");
+
+=09/* remove all tracking data - no locking needed */
+=09vfree(vm->mb_state);
+=09vfree(vm->sb_bitmap);
+
+=09/* reset the device and cleanup the queues */
+=09vdev->config->reset(vdev);
+=09vdev->config->del_vqs(vdev);
+
+=09kfree(vm);
+=09vdev->priv =3D NULL;
+}
+
+static void virtio_mem_config_changed(struct virtio_device *vdev)
+{
+=09struct virtio_mem *vm =3D vdev->priv;
+
+=09atomic_set(&vm->config_changed, 1);
+=09virtio_mem_retry(vm);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int virtio_mem_freeze(struct virtio_device *vdev)
+{
+=09/*
+=09 * When restarting the VM, all memory is usually unplugged. Don't
+=09 * allow to suspend/hibernate.
+=09 */
+=09dev_err(&vdev->dev, "save/restore not supported.\n");
+=09return -EPERM;
+}
+
+static int virtio_mem_restore(struct virtio_device *vdev)
+{
+=09return -EPERM;
+}
+#endif
+
+static struct virtio_device_id virtio_mem_id_table[] =3D {
+=09{ VIRTIO_ID_MEM, VIRTIO_DEV_ANY_ID },
+=09{ 0 },
+};
+
+static struct virtio_driver virtio_mem_driver =3D {
+=09.driver.name =3D KBUILD_MODNAME,
+=09.driver.owner =3D THIS_MODULE,
+=09.id_table =3D virtio_mem_id_table,
+=09.probe =3D virtio_mem_probe,
+=09.remove =3D virtio_mem_remove,
+=09.config_changed =3D virtio_mem_config_changed,
+#ifdef CONFIG_PM_SLEEP
+=09.freeze=09=3D=09virtio_mem_freeze,
+=09.restore =3D=09virtio_mem_restore,
+#endif
+};
+
+module_virtio_driver(virtio_mem_driver);
+MODULE_DEVICE_TABLE(virtio, virtio_mem_id_table);
+MODULE_AUTHOR("David Hildenbrand <david@redhat.com>");
+MODULE_DESCRIPTION("Virtio-mem driver");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_id=
s.h
index ecc27a17401a..b052355ac7a3 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -44,6 +44,7 @@
 #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
 #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
 #define VIRTIO_ID_IOMMU        23 /* virtio IOMMU */
+#define VIRTIO_ID_MEM          24 /* virtio mem */
 #define VIRTIO_ID_FS           26 /* virtio filesystem */
 #define VIRTIO_ID_PMEM         27 /* virtio pmem */
 #define VIRTIO_ID_MAC80211_HWSIM 29 /* virtio mac80211-hwsim */
diff --git a/include/uapi/linux/virtio_mem.h b/include/uapi/linux/virtio_me=
m.h
new file mode 100644
index 000000000000..1bfade78bdfd
--- /dev/null
+++ b/include/uapi/linux/virtio_mem.h
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Virtio Mem Device
+ *
+ * Copyright Red Hat, Inc. 2020
+ *
+ * Authors:
+ *     David Hildenbrand <david@redhat.com>
+ *
+ * This header is BSD licensed so anyone can use the definitions
+ * to implement compatible drivers/servers:
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of IBM nor the names of its contributors
+ *    may be used to endorse or promote products derived from this softwar=
e
+ *    without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
+ * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
+ * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#ifndef _LINUX_VIRTIO_MEM_H
+#define _LINUX_VIRTIO_MEM_H
+
+#include <linux/types.h>
+#include <linux/virtio_types.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_config.h>
+
+/*
+ * Each virtio-mem device manages a dedicated region in physical address
+ * space. Each device can belong to a single NUMA node, multiple devices
+ * for a single NUMA node are possible. A virtio-mem device is like a
+ * "resizable DIMM" consisting of small memory blocks that can be plugged
+ * or unplugged. The device driver is responsible for (un)plugging memory
+ * blocks on demand.
+ *
+ * Virtio-mem devices can only operate on their assigned memory region in
+ * order to (un)plug memory. A device cannot (un)plug memory belonging to
+ * other devices.
+ *
+ * The "region_size" corresponds to the maximum amount of memory that can
+ * be provided by a device. The "size" corresponds to the amount of memory
+ * that is currently plugged. "requested_size" corresponds to a request
+ * from the device to the device driver to (un)plug blocks. The
+ * device driver should try to (un)plug blocks in order to reach the
+ * "requested_size". It is impossible to plug more memory than requested.
+ *
+ * The "usable_region_size" represents the memory region that can actually
+ * be used to (un)plug memory. It is always at least as big as the
+ * "requested_size" and will grow dynamically. It will only shrink when
+ * explicitly triggered (VIRTIO_MEM_REQ_UNPLUG).
+ *
+ * There are no guarantees what will happen if unplugged memory is
+ * read/written. Such memory should, in general, not be touched. E.g.,
+ * even writing might succeed, but the values will simply be discarded at
+ * random points in time.
+ *
+ * It can happen that the device cannot process a request, because it is
+ * busy. The device driver has to retry later.
+ *
+ * Usually, during system resets all memory will get unplugged, so the
+ * device driver can start with a clean state. However, in specific
+ * scenarios (if the device is busy) it can happen that the device still
+ * has memory plugged. The device driver can request to unplug all memory
+ * (VIRTIO_MEM_REQ_UNPLUG) - which might take a while to succeed if the
+ * device is busy.
+ */
+
+/* --- virtio-mem: guest -> host requests --- */
+
+/* request to plug memory blocks */
+#define VIRTIO_MEM_REQ_PLUG=09=09=090
+/* request to unplug memory blocks */
+#define VIRTIO_MEM_REQ_UNPLUG=09=09=091
+/* request to unplug all blocks and shrink the usable size */
+#define VIRTIO_MEM_REQ_UNPLUG_ALL=09=092
+/* request information about the plugged state of memory blocks */
+#define VIRTIO_MEM_REQ_STATE=09=09=093
+
+struct virtio_mem_req_plug {
+=09__virtio64 addr;
+=09__virtio16 nb_blocks;
+};
+
+struct virtio_mem_req_unplug {
+=09__virtio64 addr;
+=09__virtio16 nb_blocks;
+};
+
+struct virtio_mem_req_state {
+=09__virtio64 addr;
+=09__virtio16 nb_blocks;
+};
+
+struct virtio_mem_req {
+=09__virtio16 type;
+=09__virtio16 padding[3];
+
+=09union {
+=09=09struct virtio_mem_req_plug plug;
+=09=09struct virtio_mem_req_unplug unplug;
+=09=09struct virtio_mem_req_state state;
+=09} u;
+};
+
+
+/* --- virtio-mem: host -> guest response --- */
+
+/*
+ * Request processed successfully, applicable for
+ * - VIRTIO_MEM_REQ_PLUG
+ * - VIRTIO_MEM_REQ_UNPLUG
+ * - VIRTIO_MEM_REQ_UNPLUG_ALL
+ * - VIRTIO_MEM_REQ_STATE
+ */
+#define VIRTIO_MEM_RESP_ACK=09=09=090
+/*
+ * Request denied - e.g. trying to plug more than requested, applicable fo=
r
+ * - VIRTIO_MEM_REQ_PLUG
+ */
+#define VIRTIO_MEM_RESP_NACK=09=09=091
+/*
+ * Request cannot be processed right now, try again later, applicable for
+ * - VIRTIO_MEM_REQ_PLUG
+ * - VIRTIO_MEM_REQ_UNPLUG
+ * - VIRTIO_MEM_REQ_UNPLUG_ALL
+ */
+#define VIRTIO_MEM_RESP_BUSY=09=09=092
+/*
+ * Error in request (e.g. addresses/alignment), applicable for
+ * - VIRTIO_MEM_REQ_PLUG
+ * - VIRTIO_MEM_REQ_UNPLUG
+ * - VIRTIO_MEM_REQ_STATE
+ */
+#define VIRTIO_MEM_RESP_ERROR=09=09=093
+
+
+/* State of memory blocks is "plugged" */
+#define VIRTIO_MEM_STATE_PLUGGED=09=090
+/* State of memory blocks is "unplugged" */
+#define VIRTIO_MEM_STATE_UNPLUGGED=09=091
+/* State of memory blocks is "mixed" */
+#define VIRTIO_MEM_STATE_MIXED=09=09=092
+
+struct virtio_mem_resp_state {
+=09__virtio16 state;
+};
+
+struct virtio_mem_resp {
+=09__virtio16 type;
+=09__virtio16 padding[3];
+
+=09union {
+=09=09struct virtio_mem_resp_state state;
+=09} u;
+};
+
+/* --- virtio-mem: configuration --- */
+
+struct virtio_mem_config {
+=09/* Block size and alignment. Cannot change. */
+=09__u32 block_size;
+=09__u32 padding;
+=09/* Start address of the memory region. Cannot change. */
+=09__u64 addr;
+=09/* Region size (maximum). Cannot change. */
+=09__u64 region_size;
+=09/*
+=09 * Currently usable region size. Can grow up to region_size. Can
+=09 * shrink due to VIRTIO_MEM_REQ_UNPLUG_ALL (in which case no config
+=09 * update will be sent).
+=09 */
+=09__u64 usable_region_size;
+=09/*
+=09 * Currently used size. Changes due to plug/unplug requests, but no
+=09 * config updates will be sent.
+=09 */
+=09__u64 plugged_size;
+=09/* Requested size. New plug requests cannot exceed it. Can change. */
+=09__u64 requested_size;
+};
+
+#endif /* _LINUX_VIRTIO_MEM_H */
--=20
2.25.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

