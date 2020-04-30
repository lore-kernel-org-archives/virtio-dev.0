Return-Path: virtio-dev-return-7219-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 12220985B04
	for <virtio-dev@lists.oasis-open.org>; Thu, 30 Apr 2020 10:29:46 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu, 30 Apr 2020 12:29:05 +0200
Message-Id: <20200430102908.10107-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 0/3] mm/memory_hotplug: Allow to not create firmware memmap entries
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-hyperv@vger.kernel.org, linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, Eric Biederman <ebiederm@xmission.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jason Wang <jasowang@redhat.com>, Juergen Gross <jgross@suse.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>, Leonardo Bras <leobras.c@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Nathan Lynch <nathanl@linux.ibm.com>, Oscar Salvador <osalvador@suse.de>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Paul Mackerras <paulus@samba.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, Pingfan Liu <kernelfans@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stefano Stabellini <sstabellini@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Vishal Verma <vishal.l.verma@intel.com>, Wei Liu <wei.liu@kernel.org>, Wei Yang <richard.weiyang@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This is the follow up of [1]:
=09[PATCH v1 0/3] mm/memory_hotplug: Make virtio-mem play nicely with
=09kexec-tools

I realized that this is not only helpful for virtio-mem, but also for
dax/kmem - it's a fix for that use case (see patch #3) of persistent
memory.

Also, while testing, I discovered that kexec-tools will *not* add dax/kmem
memory (anything not directly under the root when parsing /proc/iomem) to
the elfcorehdr, so this memory will never get included in a dump. This
probably has to be fixed in kexec-tools - virtio-mem will require this as
well.

v1 -> v2:
- Don't change the resource name
- Rename the flag to MHP_NO_FIRMWARE_MEMMAP to reflect what it is doing
- Rephrase subjects/descriptions
- Use the flag for dax/kmem

I'll have to rebase virtio-mem on these changes, there will be a resend.

[1] https://lkml.kernel.org/r/20200429160803.109056-1-david@redhat.com

David Hildenbrand (3):
  mm/memory_hotplug: Prepare passing flags to add_memory() and friends
  mm/memory_hotplug: Introduce MHP_NO_FIRMWARE_MEMMAP
  device-dax: Add system ram (add_memory()) with MHP_NO_FIRMWARE_MEMMAP

 arch/powerpc/platforms/powernv/memtrace.c       |  2 +-
 arch/powerpc/platforms/pseries/hotplug-memory.c |  2 +-
 drivers/acpi/acpi_memhotplug.c                  |  2 +-
 drivers/base/memory.c                           |  2 +-
 drivers/dax/kmem.c                              |  3 ++-
 drivers/hv/hv_balloon.c                         |  2 +-
 drivers/s390/char/sclp_cmd.c                    |  2 +-
 drivers/xen/balloon.c                           |  2 +-
 include/linux/memory_hotplug.h                  | 15 ++++++++++++---
 mm/memory_hotplug.c                             | 14 ++++++++------
 10 files changed, 29 insertions(+), 17 deletions(-)

--=20
2.25.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

