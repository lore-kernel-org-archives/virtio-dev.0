Return-Path: virtio-dev-return-7275-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 672B0985E58
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 May 2020 14:03:29 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 May 2020 16:01:32 +0200
Message-Id: <20200507140139.17083-9-david@redhat.com>
In-Reply-To: <20200507140139.17083-1-david@redhat.com>
References: <20200507140139.17083-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v4 08/15] mm/memory_hotplug: Introduce offline_and_remove_memory()
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Oscar Salvador <osalvador@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Qian Cai <cai@lca.pw>
List-ID: <virtio-dev.lists.oasis-open.org>

virtio-mem wants to offline and remove a memory block once it unplugged
all subblocks (e.g., using alloc_contig_range()). Let's provide
an interface to do that from a driver. virtio-mem already supports to
offline partially unplugged memory blocks. Offlining a fully unplugged
memory block will not require to migrate any pages. All unplugged
subblocks are PageOffline() and have a reference count of 0 - so
offlining code will simply skip them.

All we need is an interface to offline and remove the memory from kernel
module context, where we don't have access to the memory block devices
(esp. find_memory_block() and device_offline()) and the device hotplug
lock.

To keep things simple, allow to only work on a single memory block.

Acked-by: Michal Hocko <mhocko@suse.com>
Tested-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Qian Cai <cai@lca.pw>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/memory_hotplug.h |  1 +
 mm/memory_hotplug.c            | 37 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.=
h
index 93d9ada74ddd..cb7499843f5c 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -319,6 +319,7 @@ extern void try_offline_node(int nid);
 extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
 extern int remove_memory(int nid, u64 start, u64 size);
 extern void __remove_memory(int nid, u64 start, u64 size);
+extern int offline_and_remove_memory(int nid, u64 start, u64 size);
=20
 #else
 static inline bool is_mem_section_removable(unsigned long pfn,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 008e4a7ed8bc..4acb99aa9bf4 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1821,4 +1821,41 @@ int remove_memory(int nid, u64 start, u64 size)
 =09return rc;
 }
 EXPORT_SYMBOL_GPL(remove_memory);
+
+/*
+ * Try to offline and remove a memory block. Might take a long time to
+ * finish in case memory is still in use. Primarily useful for memory devi=
ces
+ * that logically unplugged all memory (so it's no longer in use) and want=
 to
+ * offline + remove the memory block.
+ */
+int offline_and_remove_memory(int nid, u64 start, u64 size)
+{
+=09struct memory_block *mem;
+=09int rc =3D -EINVAL;
+
+=09if (!IS_ALIGNED(start, memory_block_size_bytes()) ||
+=09    size !=3D memory_block_size_bytes())
+=09=09return rc;
+
+=09lock_device_hotplug();
+=09mem =3D find_memory_block(__pfn_to_section(PFN_DOWN(start)));
+=09if (mem)
+=09=09rc =3D device_offline(&mem->dev);
+=09/* Ignore if the device is already offline. */
+=09if (rc > 0)
+=09=09rc =3D 0;
+
+=09/*
+=09 * In case we succeeded to offline the memory block, remove it.
+=09 * This cannot fail as it cannot get onlined in the meantime.
+=09 */
+=09if (!rc) {
+=09=09rc =3D try_remove_memory(nid, start, size);
+=09=09WARN_ON_ONCE(rc);
+=09}
+=09unlock_device_hotplug();
+
+=09return rc;
+}
+EXPORT_SYMBOL_GPL(offline_and_remove_memory);
 #endif /* CONFIG_MEMORY_HOTREMOVE */
--=20
2.25.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

