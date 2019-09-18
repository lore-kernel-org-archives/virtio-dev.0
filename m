Return-Path: virtio-dev-return-6129-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EC6AE985E17
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Sep 2019 17:52:29 +0000 (UTC)
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 18 Sep 2019 10:52:25 -0700
Message-ID: <20190918175109.23474.67039.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] [PATCH v10 0/6] mm / virtio: Provide support for unused page
 reporting
To: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, david@redhat.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org, vbabka@suse.cz, akpm@linux-foundation.org, mgorman@techsingularity.net, linux-arm-kernel@lists.infradead.org, osalvador@suse.de
Cc: yang.zhang.wz@gmail.com, pagupta@redhat.com, konrad.wilk@oracle.com, nitesh@redhat.com, riel@surriel.com, lcapitulino@redhat.com, wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com, alexander.h.duyck@linux.intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This series provides an asynchronous means of reporting to a hypervisor
that a guest page is no longer in use and can have the data associated
with it dropped. To do this I have implemented functionality that allows
for what I am referring to as unused page reporting. The advantage of
unused page reporting is that we can support a significant amount of
memory over-commit with improved performance as we can avoid having to
write/read memory from swap as the VM will instead actively participate
in freeing unused memory so it doesn't have to be written.

The functionality for this is fairly simple. When enabled it will allocate
statistics to track the number of reported pages in a given free area.
When the number of free pages exceeds this value plus a high water value,
currently 32, it will begin performing page reporting which consists of
pulling non-reported pages off of the free lists of a given zone and
placing them into a scatterlist. The scatterlist is then given to the page
reporting device and it will perform the required action to make the pages
"reported", in the case of virtio-balloon this results in the pages being
madvised as MADV_DONTNEED. After this they are placed back on their
original free list. If they are not merged in freeing an additional bit is
set indicating that they are a "reported" buddy page instead of a standard
buddy page. The cycle then repeats with additional non-reported pages
being pulled until the free areas all consist of reported pages.

In order to try and keep the time needed to find a non-reported page to
a minimum we maintain a "reported_boundary" pointer. This pointer is used
by the get_unreported_pages iterator to determine at what point it should
resume searching for non-reported pages. In order to guarantee pages do
not get past the scan I have modified add_to_free_list_tail so that it
will not insert pages behind the reported_boundary.

If another process needs to perform a massive manipulation of the free
list, such as compaction, it can either reset a given individual boundary
which will push the boundary back to the list_head, or it can clear the
bit indicating the zone is actively processing which will result in the
reporting process resetting all of the boundaries for a given zone.

I am leaving a number of things hard-coded such as limiting the lowest
order processed to pageblock_order, and have left it up to the guest to
determine what the limit is on how many pages it wants to allocate to
process the hints. The upper limit for this is based on the size of the
queue used to store the scatterlist.

I wanted to avoid gaming the performance testing for this. As far as
possible gain a significant performance improvement should be visible in
cases where guests are forced to write/read from swap. As such, testing
it would be more of a benchmark of copying a page from swap versus just
allocating a zero page. I have been verifying that the memory is being
freed using memhog to allocate all the memory on the guest, and then
watching /proc/meminfo to verify the host sees the memory returned after
the test completes.

As far as possible regressions I have focused on cases where performing
the hinting would be non-optimal, such as cases where the code isn't
needed as memory is not over-committed, or the functionality is not in
use. I have been using the will-it-scale/page_fault1 test running with 16
vcpus and have modified it to use Transparent Huge Pages. With this I see
almost no difference with the patches applied and the feature disabled.
Likewise I see almost no difference with the feature enabled, but the
madvise disabled in the hypervisor due to a device being assigned. With
the feature fully enabled in both guest and hypervisor I see a regression
between -1.86% and -8.84% versus the baseline. I found that most of the
overhead was due to the page faulting/zeroing that comes as a result of
the pages having been evicted from the guest.

For info on earlier versions you will need to follow the links provided
with the respective versions.

Changes from v9:
https://lore.kernel.org/lkml/20190907172225.10910.34302.stgit@localhost.localdomain/
Updated cover page
Dropped per-cpu page randomization entropy patch
Added "to_tail" boolean value to __free_one_page to improve readability
Renamed __shuffle_pick_tail to shuffle_pick_tail, avoiding extra inline function
Dropped arm64 HUGLE_TLB_ORDER movement patch since it is no longer needed
Significant rewrite of page reporting functionality
  Updated logic to support interruptions from compaction
  get_unreported_page will now walk through reported sections
  Moved free_list manipulators out of mmzone.h and into page_alloc.c
  Removed page_reporting.h include from mmzone.h
  Split page_reporting.h between include/linux/ and mm/
  Added #include <asm/pgtable.h>" to mm/page_reporting.h
  Renamed page_reporting_startup/shutdown to page_reporting_register/unregister
Updated comments related to virtio page poison tracking feature

---

Alexander Duyck (6):
      mm: Adjust shuffle code to allow for future coalescing
      mm: Use zone and order instead of free area in free_list manipulators
      mm: Introduce Reported pages
      mm: Add device side and notifier for unused page reporting
      virtio-balloon: Pull page poisoning config out of free page hinting
      virtio-balloon: Add support for providing unused page reports to host


 drivers/virtio/Kconfig              |    1 
 drivers/virtio/virtio_balloon.c     |   87 ++++++++-
 include/linux/mmzone.h              |   60 ++----
 include/linux/page-flags.h          |   11 +
 include/linux/page_reporting.h      |   31 +++
 include/uapi/linux/virtio_balloon.h |    1 
 mm/Kconfig                          |   11 +
 mm/Makefile                         |    1 
 mm/compaction.c                     |    5 +
 mm/memory_hotplug.c                 |    2 
 mm/page_alloc.c                     |  194 +++++++++++++++----
 mm/page_reporting.c                 |  350 +++++++++++++++++++++++++++++++++++
 mm/page_reporting.h                 |  224 ++++++++++++++++++++++
 mm/shuffle.c                        |   12 +
 mm/shuffle.h                        |    6 +
 15 files changed, 893 insertions(+), 103 deletions(-)
 create mode 100644 include/linux/page_reporting.h
 create mode 100644 mm/page_reporting.c
 create mode 100644 mm/page_reporting.h

--

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

