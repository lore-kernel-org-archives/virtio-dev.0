Return-Path: virtio-dev-return-6507-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E3013985DD7
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Dec 2019 17:13:22 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu, 12 Dec 2019 18:11:35 +0100
Message-Id: <20191212171137.13872-12-david@redhat.com>
In-Reply-To: <20191212171137.13872-1-david@redhat.com>
References: <20191212171137.13872-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH RFC v4 11/13] mm/vmscan: Move count_vm_event(DROP_SLAB) into drop_slab()
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

Let's count within the function itself, so every invocation (of future
users) will be counted.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/drop_caches.c | 4 +---
 mm/vmscan.c      | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index d31b6c72b476..a042da782fcd 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -61,10 +61,8 @@ int drop_caches_sysctl_handler(struct ctl_table *table, =
int write,
 =09=09=09iterate_supers(drop_pagecache_sb, NULL);
 =09=09=09count_vm_event(DROP_PAGECACHE);
 =09=09}
-=09=09if (sysctl_drop_caches & 2) {
+=09=09if (sysctl_drop_caches & 2)
 =09=09=09drop_slab();
-=09=09=09count_vm_event(DROP_SLAB);
-=09=09}
 =09=09if (!stfu) {
 =09=09=09pr_info("%s (%d): drop_caches: %d\n",
 =09=09=09=09current->comm, task_pid_nr(current),
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5a6445e86328..c3e53502a84a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -726,6 +726,7 @@ void drop_slab(void)
=20
 =09for_each_online_node(nid)
 =09=09drop_slab_node(nid);
+=09count_vm_event(DROP_SLAB);
 }
=20
 static inline int is_page_cache_freeable(struct page *page)
--=20
2.23.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

