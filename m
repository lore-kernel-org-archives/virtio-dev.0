Return-Path: virtio-dev-return-7210-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2FC2985E82
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Apr 2020 16:08:54 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Apr 2020 18:08:03 +0200
Message-Id: <20200429160803.109056-4-david@redhat.com>
In-Reply-To: <20200429160803.109056-1-david@redhat.com>
References: <20200429160803.109056-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v1 3/3] virtio-mem: Add memory with MHP_DRIVER_MANAGED
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-hyperv@vger.kernel.org, linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>, Michal Hocko <mhocko@suse.com>, Eric Biederman <ebiederm@xmission.com>
List-ID: <virtio-dev.lists.oasis-open.org>

We don't want /sys/firmware/memmap entries and we want to indicate
our memory as "System RAM (driver managed)" in /proc/iomem. This is
especially relevant for kexec-tools, which have to be updated to
support dumping virtio-mem memory after this patch. Expected behavior in
kexec-tools:
- Don't use this memory when creating a fixed-up firmware memmap. Works
  now out of the box on x86-64.
- Don't use this memory for placing kexec segments. Works now out of the
  box on x86-64.
- Consider "System RAM (driver managed)" when creating the elfcorehdr
  for kdump. This memory has to be dumped. Needs update of kexec-tools.

With this patch on x86-64:

/proc/iomem:
=0900000000-00000fff : Reserved
=0900001000-0009fbff : System RAM
=09[...]
=09fffc0000-ffffffff : Reserved
=09100000000-13fffffff : System RAM
=09140000000-147ffffff : System RAM (driver managed)
=09340000000-347ffffff : System RAM (driver managed)
=09348000000-34fffffff : System RAM (driver managed)
=09[..]
=093280000000-32ffffffff : PCI Bus 0000:00

/sys/firmware/memmap:
=090000000000000000-000000000009fc00 (System RAM)
=09000000000009fc00-00000000000a0000 (Reserved)
=0900000000000f0000-0000000000100000 (Reserved)
=090000000000100000-00000000bffe0000 (System RAM)
=0900000000bffe0000-00000000c0000000 (Reserved)
=0900000000feffc000-00000000ff000000 (Reserved)
=0900000000fffc0000-0000000100000000 (Reserved)
=090000000100000000-0000000140000000 (System RAM)

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 3101cbf9e59d..6f658d1aeac4 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -421,7 +421,8 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, uns=
igned long mb_id)
 =09=09nid =3D memory_add_physaddr_to_nid(addr);
=20
 =09dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
-=09return add_memory(nid, addr, memory_block_size_bytes(), 0);
+=09return add_memory(nid, addr, memory_block_size_bytes(),
+=09=09=09  MHP_DRIVER_MANAGED);
 }
=20
 /*
--=20
2.25.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

