Return-Path: virtio-dev-return-6115-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 228AE985B47
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Sep 2019 12:30:28 +0000 (UTC)
References: <20190812131235.27244-1-nitesh@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <356b752f-7f5c-a6f7-c643-8ffb49c27a67@redhat.com>
Date: Wed, 11 Sep 2019 14:30:03 +0200
MIME-Version: 1.0
In-Reply-To: <20190812131235.27244-1-nitesh@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [RFC][PATCH v12 0/2] mm: Support for page reporting
To: Nitesh Narayan Lal <nitesh@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com, mst@redhat.com, dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com, alexander.duyck@gmail.com, john.starks@microsoft.com, dave.hansen@intel.com, mhocko@suse.com, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12.08.19 15:12, Nitesh Narayan Lal wrote:
> This patch series proposes an efficient mechanism for reporting free memory
> from a guest to its hypervisor. It especially enables guests with no page cache
> (e.g., nvdimm, virtio-pmem) or with small page caches (e.g., ram > disk) to
> rapidly hand back free memory to the hypervisor.
> This approach has a minimal impact on the existing core-mm infrastructure.
> 
> This approach tracks all freed pages of the order MAX_ORDER - 2 in bitmaps.
> A new hook after buddy merging is used to set the bits in the bitmap for a freed 
> page. Each set bit is cleared after they are processed/checked for
> re-allocation.
> Bitmaps are stored on a per-zone basis and are protected by the zone lock. A
> workqueue asynchronously processes the bitmaps as soon as a pre-defined memory
> threshold is met, trying to isolate and report pages that are still free.
> The isolated pages are stored in a scatterlist and are reported via
> virtio-balloon, which is responsible for sending batched pages to the
> hypervisor. Once the hypervisor processed the reporting request, the isolated
> pages are returned back to the buddy.
> The thershold which defines the number of pages which will be isolated and
> reported to the hypervisor at a time is currently hardcoded to 16 in the guest.
> 
> Benefit analysis:
> Number of 5 GB guests (each touching 4 to 5 GB memory) that can be launched on a
> 15 GB single NUMA system without using swap space in the host.
> 
> 	    Guest kernel-->	Unmodified		with v12 page reporting
> 	Number of guests-->	    2				7
> 
> Conclusion: In a page-reporting enabled kernel, the guest is able to report
> most of its unused memory back to the host. Due to this on the same host, I was
> able to launch 7 guests without touching any swap compared to 2 which were
> launched with an unmodified kernel.
> 
> Performance Analysis:
> In order to measure the performance impact of this patch-series over an
> unmodified kernel, I am using will-it-scale/page_fault1 on a 30 GB, 24 vcpus
> single NUMA guest which is affined to a single node in the host. Over several
> runs, I observed that with this patch-series there is a degradation of around
> 1-3% for certain cases. This degradation could be a result of page-zeroing
> overhead which comes with every page-fault in the guest.
> I also tried this test on a 2 NUMA node host running page reporting
> enabled 60GB guest also having 2 NUMA nodes and 24 vcpus. I observed a similar
> degradation of around 1-3% in most of the cases.
> For certain cases, the variability even with an unmodified kernel was around
> 4-6% with every fresh boot. I will continue to investigate this further to find
> the reason behind it.
> 
> Ongoing work-items:
> * I have a working prototype for supporting memory hotplug/hotremove with page
>   reporting. However, it still requires more testing and fixes specifically on
>   the hotremove side.
>   Right now, for any memory hotplug or hotremove request bitmap or its
>   respective fields are not changed. Hence, memory added via hotplug is not
>   tracked in the bitmap. Similarly, removed memory is not reported to the
>   hypervisor by using an online memory check. 
> * I will also have to look into the details about how to handle page poisoning
>   scenarios and test with directly assigned devices.
> 
> 
> Changes from v11:
> https://lkml.org/lkml/2019/7/10/742
> * Moved the fields required to manage bitmap of free pages to 'struct zone'.
> * Replaced the list which was used to hold and report the free pages with
>   scatterlist.
> * Tried to fix the anti-kernel patterns and improve overall code quality.
> * Fixed a few bugs in the code which were reported in the last posting.
> * Moved to use MADV_DONTNEED from MADV_FREE.
> * Replaced page hinting in favor of page reporting.
> * Addressed other comments which I received in the last posting.	
> 
> 
> Changes from v10:
> https://lkml.org/lkml/2019/6/3/943
> * Added logic to take care of multiple NUMA nodes scenarios.
> * Simplified the logic for reporting isolated pages to the host. (Eg. replaced
>   dynamically allocated arrays with static ones, introduced wait event instead
>   of the loop in order to wait for a response from the host)
> * Added a mutex to prevent race condition when page reporting is enabled by
>   multiple drivers.
> * Simplified the logic responsible for decrementing free page counter for each
>   zone.
> * Simplified code structuring/naming.
>  

Some current limitations of this patchset seem to be

1. Sparse zones eventually wasting memory (1bit per 2MB).

As I already set, I consider this in most virtual environments a special
case (especially a lot of sparsity). You can simply compare the spanned
vs. present pages and don't allocate a bitmap in case it's too sparse
("currently unsupported environment"). These pieces won't be considered
for free page reporting, however free page reporting is a pure
optimization already either way. We can be smarter in the future (split
up bitmap into sub-bitmaps ...)

2. Memory hot(un)plug support

Memory hotplug should be easy with the memory hotplug notifier. Resize
bitmaps after hotplug if required. Hotunplug is tricky, as it depends on
zone shrinking (shrink bitmaps after offlining). You could scan for
actually online section manually. But with minor modifications after
"[PATCH v4 0/8] mm/memory_hotplug: Shrink zones before removing memory",
at least some cases could also be handled. (sparse handling similar to
1). Of course, initially, you could also simply not try to shrink the
bitmap on unplug ...

3. Scanning speed

I have no idea if that is actually an issue. But there are different
options if it is, for example, a hierarchical bitmap.


Besides these, I think there were other review comments that should be
addressed, but they don't seem to target the concept but rather
implementation details.

-- 

Thanks,

David / dhildenb

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

