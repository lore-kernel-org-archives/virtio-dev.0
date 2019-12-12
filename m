Return-Path: virtio-dev-return-6508-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4F713985DBA
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Dec 2019 17:13:29 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu, 12 Dec 2019 18:11:36 +0100
Message-Id: <20191212171137.13872-13-david@redhat.com>
In-Reply-To: <20191212171137.13872-1-david@redhat.com>
References: <20191212171137.13872-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH RFC v4 12/13] mm/vmscan: Export drop_slab() and drop_slab_node()
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

We already have a way to trigger reclaiming of all reclaimable slab objects
from user space (echo 2 > /proc/sys/vm/drop_caches). Let's allow drivers
to also trigger this when they really want to make progress and know what
they are doing.

virtio-mem wants to use these functions when it failed to unplug memory
for quite some time (e.g., after 30 minutes). It will then try to
free up reclaimable objects by dropping the slab caches every now and
then (e.g., every 30 minutes) as long as necessary. There will be a way to
disable this feature and info messages will be logged.

In the future, we want to have a drop_slab_range() functionality
instead. Memory offlining code has similar demands and also other
alloc_contig_range() users (e.g., gigantic pages) could make good use of
this feature. Adding it, however, requires more work/thought.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 4 ++--
 mm/vmscan.c        | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 64799c5cb39f..483300f58be8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2706,8 +2706,8 @@ int drop_caches_sysctl_handler(struct ctl_table *, in=
t,
 =09=09=09=09=09void __user *, size_t *, loff_t *);
 #endif
=20
-void drop_slab(void);
-void drop_slab_node(int nid);
+extern void drop_slab(void);
+extern void drop_slab_node(int nid);
=20
 #ifndef CONFIG_MMU
 #define randomize_va_space 0
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c3e53502a84a..4e1cdaaec5e6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -719,6 +719,7 @@ void drop_slab_node(int nid)
 =09=09} while ((memcg =3D mem_cgroup_iter(NULL, memcg, NULL)) !=3D NULL);
 =09} while (freed > 10);
 }
+EXPORT_SYMBOL(drop_slab_node);
=20
 void drop_slab(void)
 {
@@ -728,6 +729,7 @@ void drop_slab(void)
 =09=09drop_slab_node(nid);
 =09count_vm_event(DROP_SLAB);
 }
+EXPORT_SYMBOL(drop_slab);
=20
 static inline int is_page_cache_freeable(struct page *page)
 {
--=20
2.23.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

