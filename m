Return-Path: virtio-dev-return-6503-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 645C6985DBA
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Dec 2019 17:12:57 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu, 12 Dec 2019 18:11:30 +0100
Message-Id: <20191212171137.13872-7-david@redhat.com>
In-Reply-To: <20191212171137.13872-1-david@redhat.com>
References: <20191212171137.13872-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH RFC v4 06/13] mm: Allow to offline unmovable PageOffline() pages via MEM_GOING_OFFLINE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>, Mel Gorman <mgorman@techsingularity.net>, Mike Rapoport <rppt@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Qian Cai <cai@lca.pw>, Pingfan Liu <kernelfans@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

virtio-mem wants to allow to offline memory blocks of which some parts
were unplugged (allocated via alloc_contig_range()), especially, to later
offline and remove completely unplugged memory blocks. The important part
is that PageOffline() has to remain set until the section is offline, so
these pages will never get accessed (e.g., when dumping). The pages should
not be handed back to the buddy (which would require clearing PageOffline()
and result in issues if offlining fails and the pages are suddenly in the
buddy).

Let's allow to do that by allowing to isolate any PageOffline() page
when offlining. This way, we can reach the memory hotplug notifier
MEM_GOING_OFFLINE, where the driver can signal that he is fine with
offlining this page by dropping its reference count. PageOffline() pages
with a reference count of 0 can then be skipped when offlining the
pages (like if they were free, however they are not in the buddy).

Anybody who uses PageOffline() pages and does not agree to offline them
(e.g., Hyper-V balloon, XEN balloon, VMWare balloon for 2MB pages) will not
decrement the reference count and make offlining fail when trying to
migrate such an unmovable page. So there should be no observerable change.
Same applies to balloon compaction users (movable PageOffline() pages), the
pages will simply be migrated.

Note 1: If offlining fails, a driver has to increment the reference
=09count again in MEM_CANCEL_OFFLINE.

Note 2: A driver that makes use of this has to be aware that re-onlining
=09the memory block has to be handled by hooking into onlining code
=09(online_page_callback_t), resetting the page PageOffline() and
=09not giving them to the buddy.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 10 ++++++++++
 mm/memory_hotplug.c        | 41 ++++++++++++++++++++++++++++----------
 mm/page_alloc.c            | 24 ++++++++++++++++++++++
 mm/page_isolation.c        |  9 +++++++++
 4 files changed, 74 insertions(+), 10 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1bf83c8fcaa7..ac1775082343 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -761,6 +761,16 @@ PAGE_TYPE_OPS(Buddy, buddy)
  * not onlined when onlining the section).
  * The content of these pages is effectively stale. Such pages should not
  * be touched (read/write/dump/save) except by their owner.
+ *
+ * If a driver wants to allow to offline unmovable PageOffline() pages wit=
hout
+ * putting them back to the buddy, it can do so via the memory notifier by
+ * decrementing the reference count in MEM_GOING_OFFLINE and incrementing =
the
+ * reference count in MEM_CANCEL_OFFLINE. When offlining, the PageOffline(=
)
+ * pages (now with a reference count of zero) are treated like free pages,
+ * allowing the containing memory block to get offlined. A driver that
+ * relies on this feature is aware that re-onlining the memory block will
+ * require to re-set the pages PageOffline() and not giving them to the
+ * buddy via online_page_callback_t.
  */
 PAGE_TYPE_OPS(Offline, offline)
=20
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index fc617ad6f035..da01453a04e6 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1231,11 +1231,15 @@ int test_pages_in_a_zone(unsigned long start_pfn, u=
nsigned long end_pfn,
=20
 /*
  * Scan pfn range [start,end) to find movable/migratable pages (LRU pages,
- * non-lru movable pages and hugepages). We scan pfn because it's much
- * easier than scanning over linked list. This function returns the pfn
- * of the first found movable page if it's found, otherwise 0.
+ * non-lru movable pages and hugepages).
+ *
+ * Returns:
+ *=090 in case a movable page is found and movable_pfn was updated.
+ *=09-ENOENT in case no movable page was found.
+ *=09-EBUSY in case a definetly unmovable page was found.
  */
-static unsigned long scan_movable_pages(unsigned long start, unsigned long=
 end)
+static int scan_movable_pages(unsigned long start, unsigned long end,
+=09=09=09      unsigned long *movable_pfn)
 {
 =09unsigned long pfn;
=20
@@ -1247,18 +1251,29 @@ static unsigned long scan_movable_pages(unsigned lo=
ng start, unsigned long end)
 =09=09=09continue;
 =09=09page =3D pfn_to_page(pfn);
 =09=09if (PageLRU(page))
-=09=09=09return pfn;
+=09=09=09goto found;
 =09=09if (__PageMovable(page))
-=09=09=09return pfn;
+=09=09=09goto found;
+
+=09=09/*
+=09=09 * Unmovable PageOffline() pages where somebody still holds
+=09=09 * a reference count (after MEM_GOING_OFFLINE) can definetly
+=09=09 * not be offlined.
+=09=09 */
+=09=09if (PageOffline(page) && page_count(page))
+=09=09=09return -EBUSY;
=20
 =09=09if (!PageHuge(page))
 =09=09=09continue;
 =09=09head =3D compound_head(page);
 =09=09if (page_huge_active(head))
-=09=09=09return pfn;
+=09=09=09goto found;
 =09=09skip =3D compound_nr(head) - (page - head);
 =09=09pfn +=3D skip - 1;
 =09}
+=09return -ENOENT;
+found:
+=09*movable_pfn =3D pfn;
 =09return 0;
 }
=20
@@ -1528,7 +1543,8 @@ static int __ref __offline_pages(unsigned long start_=
pfn,
 =09}
=20
 =09do {
-=09=09for (pfn =3D start_pfn; pfn;) {
+=09=09pfn =3D start_pfn;
+=09=09do {
 =09=09=09if (signal_pending(current)) {
 =09=09=09=09ret =3D -EINTR;
 =09=09=09=09reason =3D "signal backoff";
@@ -1538,14 +1554,19 @@ static int __ref __offline_pages(unsigned long star=
t_pfn,
 =09=09=09cond_resched();
 =09=09=09lru_add_drain_all();
=20
-=09=09=09pfn =3D scan_movable_pages(pfn, end_pfn);
-=09=09=09if (pfn) {
+=09=09=09ret =3D scan_movable_pages(pfn, end_pfn, &pfn);
+=09=09=09if (!ret) {
 =09=09=09=09/*
 =09=09=09=09 * TODO: fatal migration failures should bail
 =09=09=09=09 * out
 =09=09=09=09 */
 =09=09=09=09do_migrate_range(pfn, end_pfn);
 =09=09=09}
+=09=09} while (!ret);
+
+=09=09if (ret !=3D -ENOENT) {
+=09=09=09reason =3D "unmovable page";
+=09=09=09goto failed_removal_isolated;
 =09=09}
=20
 =09=09/*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5334decc9e06..840c0bbe2d9f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8256,6 +8256,19 @@ bool has_unmovable_pages(struct zone *zone, struct p=
age *page, int count,
 =09=09if ((flags & MEMORY_OFFLINE) && PageHWPoison(page))
 =09=09=09continue;
=20
+=09=09/*
+=09=09 * We treat all PageOffline() pages as movable when offlining
+=09=09 * to give drivers a chance to decrement their reference count
+=09=09 * in MEM_GOING_OFFLINE in order to signalize that these pages
+=09=09 * can be offlined as there are no direct references anymore.
+=09=09 * For actually unmovable PageOffline() where the driver does
+=09=09 * not support this, we will fail later when trying to actually
+=09=09 * move these pages that still have a reference count > 0.
+=09=09 * (false negatives in this function only)
+=09=09 */
+=09=09if ((flags & MEMORY_OFFLINE) && PageOffline(page))
+=09=09=09continue;
+
 =09=09if (__PageMovable(page))
 =09=09=09continue;
=20
@@ -8683,6 +8696,17 @@ __offline_isolated_pages(unsigned long start_pfn, un=
signed long end_pfn)
 =09=09=09offlined_pages++;
 =09=09=09continue;
 =09=09}
+=09=09/*
+=09=09 * At this point all remaining PageOffline() pages have a
+=09=09 * reference count of 0 and can simply be skipped.
+=09=09 */
+=09=09if (PageOffline(page)) {
+=09=09=09BUG_ON(page_count(page));
+=09=09=09BUG_ON(PageBuddy(page));
+=09=09=09pfn++;
+=09=09=09offlined_pages++;
+=09=09=09continue;
+=09=09}
=20
 =09=09BUG_ON(page_count(page));
 =09=09BUG_ON(!PageBuddy(page));
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 04ee1663cdbe..43b4dabfedc8 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -170,6 +170,7 @@ __first_valid_page(unsigned long pfn, unsigned long nr_=
pages)
  *=09=09=09a bit mask)
  *=09=09=09MEMORY_OFFLINE - isolate to offline (!allocate) memory
  *=09=09=09=09=09 e.g., skip over PageHWPoison() pages
+ *=09=09=09=09=09 and PageOffline() pages.
  *=09=09=09REPORT_FAILURE - report details about the failure to
  *=09=09=09isolate the range
  *
@@ -278,6 +279,14 @@ __test_page_isolated_in_pageblock(unsigned long pfn, u=
nsigned long end_pfn,
 =09=09else if ((flags & MEMORY_OFFLINE) && PageHWPoison(page))
 =09=09=09/* A HWPoisoned page cannot be also PageBuddy */
 =09=09=09pfn++;
+=09=09else if ((flags & MEMORY_OFFLINE) && PageOffline(page) &&
+=09=09=09 !page_count(page))
+=09=09=09/*
+=09=09=09 * The responsible driver agreed to offline
+=09=09=09 * PageOffline() pages by dropping its reference in
+=09=09=09 * MEM_GOING_OFFLINE.
+=09=09=09 */
+=09=09=09pfn++;
 =09=09else
 =09=09=09break;
 =09}
--=20
2.23.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

