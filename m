Return-Path: virtio-dev-return-7209-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4864A985EA7
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Apr 2020 16:08:49 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Apr 2020 18:08:02 +0200
Message-Id: <20200429160803.109056-3-david@redhat.com>
In-Reply-To: <20200429160803.109056-1-david@redhat.com>
References: <20200429160803.109056-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v1 2/3] mm/memory_hotplug: Introduce MHP_DRIVER_MANAGED
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-hyperv@vger.kernel.org, linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Some paravirtualized devices that add memory via add_memory() and
friends (esp. virtio-mem) don't want to create entries in
/sys/firmware/memmap/ - primarily to hinder kexec from adding this
memory to the boot memmap of the kexec kernel.

In fact, such memory is never exposed via the firmware (e.g., e820), but
only via the device, so exposing this memory via /sys/firmware/memmap/ is
wrong:
 "kexec needs the raw firmware-provided memory map to setup the
  parameter segment of the kernel that should be booted with
  kexec. Also, the raw memory map is useful for debugging. For
  that reason, /sys/firmware/memmap is an interface that provides
  the raw memory map to userspace." [1]

We want to let user space know that memory which is always detected,
added, and managed via a (device) driver - like memory managed by
virtio-mem - is special. It cannot be used for placing kexec segments
and the (device) driver is responsible for re-adding memory that
(eventually shrunk/grown/defragmented) memory after a reboot/kexec. It
should e.g., not be added to a fixed up firmware memmap. However, it should
be dumped by kdump.

Also, such memory could behave differently than an ordinary DIMM - e.g.,
memory managed by virtio-mem can have holes inside added memory resource,
which should not be touched, especially for writing.

Let's expose that memory as "System RAM (driver managed)" e.g., via
/pro/iomem.

We don't have to worry about firmware_map_remove() on the removal path.
If there is no entry, it will simply return with -EINVAL.

[1] https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-firmware-mem=
map

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/memory_hotplug.h |  8 ++++++++
 mm/memory_hotplug.c            | 20 ++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.=
h
index bf0e3edb8688..cc538584b39e 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -68,6 +68,14 @@ struct mhp_params {
 =09pgprot_t pgprot;
 };
=20
+/* Flags used for add_memory() and friends. */
+
+/*
+ * Don't create entries in /sys/firmware/memmap/ and expose memory as
+ * "System RAM (driver managed)" in e.g., /proc/iomem
+ */
+#define MHP_DRIVER_MANAGED=09=091
+
 /*
  * Zone resizing functions
  *
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index ebdf6541d074..cfa0721280aa 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -98,11 +98,11 @@ void mem_hotplug_done(void)
 u64 max_mem_size =3D U64_MAX;
=20
 /* add this memory to iomem resource */
-static struct resource *register_memory_resource(u64 start, u64 size)
+static struct resource *register_memory_resource(u64 start, u64 size,
+=09=09=09=09=09=09 const char *resource_name)
 {
 =09struct resource *res;
 =09unsigned long flags =3D  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
-=09char *resource_name =3D "System RAM";
=20
 =09/*
 =09 * Make sure value parsed from 'mem=3D' only restricts memory adding
@@ -1058,7 +1058,8 @@ int __ref add_memory_resource(int nid, struct resourc=
e *res,
 =09BUG_ON(ret);
=20
 =09/* create new memmap entry */
-=09firmware_map_add_hotplug(start, start + size, "System RAM");
+=09if (!(flags & MHP_DRIVER_MANAGED))
+=09=09firmware_map_add_hotplug(start, start + size, "System RAM");
=20
 =09/* device_online() will take the lock when calling online_pages() */
 =09mem_hotplug_done();
@@ -1081,10 +1082,21 @@ int __ref add_memory_resource(int nid, struct resou=
rce *res,
 /* requires device_hotplug_lock, see add_memory_resource() */
 int __ref __add_memory(int nid, u64 start, u64 size, unsigned long flags)
 {
+=09const char *resource_name =3D "System RAM";
 =09struct resource *res;
 =09int ret;
=20
-=09res =3D register_memory_resource(start, size);
+=09/*
+=09 * Indicate that memory managed by a driver is special. It's always
+=09 * detected and added via a driver, should not be given to the kexec
+=09 * kernel for booting when manually crafting the firmware memmap, and
+=09 * no kexec segments should be placed on it. However, kdump should
+=09 * dump this memory.
+=09 */
+=09if (flags & MHP_DRIVER_MANAGED)
+=09=09resource_name =3D "System RAM (driver managed)";
+
+=09res =3D register_memory_resource(start, size, resource_name);
 =09if (IS_ERR(res))
 =09=09return PTR_ERR(res);
=20
--=20
2.25.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

