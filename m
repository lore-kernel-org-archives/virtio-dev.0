Return-Path: virtio-dev-return-7222-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4117A985B89
	for <virtio-dev@lists.oasis-open.org>; Thu, 30 Apr 2020 10:30:01 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu, 30 Apr 2020 12:29:08 +0200
Message-Id: <20200430102908.10107-4-david@redhat.com>
In-Reply-To: <20200430102908.10107-1-david@redhat.com>
References: <20200430102908.10107-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 3/3] device-dax: Add system ram (add_memory()) with MHP_NO_FIRMWARE_MEMMAP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-hyperv@vger.kernel.org, linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eric Biederman <ebiederm@xmission.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Dan Williams <dan.j.williams@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Currently, when adding memory, we create entries in /sys/firmware/memmap/
as "System RAM". This does not reflect the reality and will lead to
kexec-tools to add that memory to the fixed-up initial memmap for a
kexec kernel (loaded via kexec_load()). The memory will be considered
initial System RAM by the kexec kernel.

We should let the kexec kernel decide how to use that memory - just as
we do during an ordinary reboot.

Before configuring the namespace:
=09[root@localhost ~]# cat /proc/iomem
=09...
=09140000000-33fffffff : Persistent Memory
=09  140000000-33fffffff : namespace0.0
=093280000000-32ffffffff : PCI Bus 0000:00

After configuring the namespace:
=09[root@localhost ~]# cat /proc/iomem
=09...
=09140000000-33fffffff : Persistent Memory
=09  140000000-1481fffff : namespace0.0
=09  148200000-33fffffff : dax0.0
=093280000000-32ffffffff : PCI Bus 0000:00

After loading kmem:
=09[root@localhost ~]# cat /proc/iomem
=09...
=09140000000-33fffffff : Persistent Memory
=09  140000000-1481fffff : namespace0.0
=09  150000000-33fffffff : dax0.0
=09    150000000-33fffffff : System RAM
=093280000000-32ffffffff : PCI Bus 0000:00

After a proper reboot:
=09[root@localhost ~]# cat /proc/iomem
=09...
=09140000000-33fffffff : Persistent Memory
=09  140000000-1481fffff : namespace0.0
=09  148200000-33fffffff : dax0.0
=093280000000-32ffffffff : PCI Bus 0000:00

Within the kexec kernel before this change:
=09[root@localhost ~]# cat /proc/iomem
=09...
=09140000000-33fffffff : Persistent Memory
=09  140000000-1481fffff : namespace0.0
=09  150000000-33fffffff : System RAM
=093280000000-32ffffffff : PCI Bus 0000:00

Within the kexec kernel after this change:
=09[root@localhost ~]# cat /proc/iomem
=09...
=09140000000-33fffffff : Persistent Memory
=09  140000000-1481fffff : namespace0.0
=09  148200000-33fffffff : dax0.0
=093280000000-32ffffffff : PCI Bus 0000:00

/sys/firmware/memmap/ before this change:
=090000000000000000-000000000009fc00 (System RAM)
=09000000000009fc00-00000000000a0000 (Reserved)
=0900000000000f0000-0000000000100000 (Reserved)
=090000000000100000-00000000bffdf000 (System RAM)
=0900000000bffdf000-00000000c0000000 (Reserved)
=0900000000feffc000-00000000ff000000 (Reserved)
=0900000000fffc0000-0000000100000000 (Reserved)
=090000000100000000-0000000140000000 (System RAM)
=090000000150000000-0000000340000000 (System RAM)

/sys/firmware/memmap/ after a proper reboot:
=090000000000000000-000000000009fc00 (System RAM)
=09000000000009fc00-00000000000a0000 (Reserved)
=0900000000000f0000-0000000000100000 (Reserved)
=090000000000100000-00000000bffdf000 (System RAM)
=0900000000bffdf000-00000000c0000000 (Reserved)
=0900000000feffc000-00000000ff000000 (Reserved)
=0900000000fffc0000-0000000100000000 (Reserved)
=090000000100000000-0000000140000000 (System RAM)

/sys/firmware/memmap/ after this change:
=090000000000000000-000000000009fc00 (System RAM)
=09000000000009fc00-00000000000a0000 (Reserved)
=0900000000000f0000-0000000000100000 (Reserved)
=090000000000100000-00000000bffdf000 (System RAM)
=0900000000bffdf000-00000000c0000000 (Reserved)
=0900000000feffc000-00000000ff000000 (Reserved)
=0900000000fffc0000-0000000100000000 (Reserved)
=090000000100000000-0000000140000000 (System RAM)

kexec-tools already seem to basically ignore any System RAM that's not
on top level when searching for areas to place kexec images - but also
for determining crash areas to dump via kdump. This behavior is not
changed by this patch. kexec-tools probably has to be fixed to also
include this memory in system dumps.

Note: kexec_file_load() does the right thing already within the kernel.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/dax/kmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index e159184e0ba0..929823a79816 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -65,7 +65,8 @@ int dev_dax_kmem_probe(struct device *dev)
 =09new_res->flags =3D IORESOURCE_SYSTEM_RAM;
 =09new_res->name =3D dev_name(dev);
=20
-=09rc =3D add_memory(numa_node, new_res->start, resource_size(new_res), 0)=
;
+=09rc =3D add_memory(numa_node, new_res->start, resource_size(new_res),
+=09=09=09MHP_NO_FIRMWARE_MEMMAP);
 =09if (rc) {
 =09=09release_resource(new_res);
 =09=09kfree(new_res);
--=20
2.25.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

