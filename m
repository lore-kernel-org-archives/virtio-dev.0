Return-Path: virtio-dev-return-6183-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EAE4C985FA9
	for <virtio-dev@lists.oasis-open.org>; Tue,  1 Oct 2019 15:35:18 +0000 (UTC)
References: <20191001152441.27008.99285.stgit@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7233498c-2f64-d661-4981-707b59c78fd5@redhat.com>
Date: Tue, 1 Oct 2019 17:35:00 +0200
MIME-Version: 1.0
In-Reply-To: <20191001152441.27008.99285.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v11 0/6] mm / virtio: Provide support for unused page
 reporting
To: Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, mgorman@techsingularity.net, vbabka@suse.cz, osalvador@suse.de
Cc: yang.zhang.wz@gmail.com, pagupta@redhat.com, konrad.wilk@oracle.com, nitesh@redhat.com, riel@surriel.com, lcapitulino@redhat.com, wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com, alexander.h.duyck@linux.intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 01.10.19 17:29, Alexander Duyck wrote:
> This series provides an asynchronous means of reporting to a hypervisor
> that a guest page is no longer in use and can have the data associated
> with it dropped. To do this I have implemented functionality that allows
> for what I am referring to as unused page reporting. The advantage of
> unused page reporting is that we can support a significant amount of
> memory over-commit with improved performance as we can avoid having to
> write/read memory from swap as the VM will instead actively participate
> in freeing unused memory so it doesn't have to be written.
> 
> The functionality for this is fairly simple. When enabled it will allocate
> statistics to track the number of reported pages in a given free area.
> When the number of free pages exceeds this value plus a high water value,
> currently 32, it will begin performing page reporting which consists of
> pulling non-reported pages off of the free lists of a given zone and
> placing them into a scatterlist. The scatterlist is then given to the page
> reporting device and it will perform the required action to make the pages
> "reported", in the case of virtio-balloon this results in the pages being
> madvised as MADV_DONTNEED. After this they are placed back on their
> original free list. If they are not merged in freeing an additional bit is
> set indicating that they are a "reported" buddy page instead of a standard
> buddy page. The cycle then repeats with additional non-reported pages
> being pulled until the free areas all consist of reported pages.
> 
> In order to try and keep the time needed to find a non-reported page to
> a minimum we maintain a "reported_boundary" pointer. This pointer is used
> by the get_unreported_pages iterator to determine at what point it should
> resume searching for non-reported pages. In order to guarantee pages do
> not get past the scan I have modified add_to_free_list_tail so that it
> will not insert pages behind the reported_boundary. Doing this allows us
> to keep the overhead to a minimum as re-walking the list without the
> boundary will result in as much as 18% additional overhead on a 32G VM.
> 
> If another process needs to perform a massive manipulation of the free
> list, such as compaction, it can either reset a given individual boundary
> which will push the boundary back to the list_head, or it can clear the
> bit indicating the zone is actively processing which will result in the
> reporting process resetting all of the boundaries for a given zone.
> 
> I am leaving a number of things hard-coded such as limiting the lowest
> order processed to pageblock_order, and have left it up to the guest to
> determine what the limit is on how many pages it wants to allocate to
> process the hints. The upper limit for this is based on the size of the
> queue used to store the scatterlist.
> 
> I wanted to avoid gaming the performance testing for this. As far as
> possible gain a significant performance improvement should be visible in
> cases where guests are forced to write/read from swap. As such, testing
> it would be more of a benchmark of copying a page from swap versus just
> allocating a zero page. I have been verifying that the memory is being
> freed using memhog to allocate all the memory on the guest, and then
> watching /proc/meminfo to verify the host sees the memory returned after
> the test completes.
> 
> As far as possible regressions I have focused on cases where performing
> the hinting would be non-optimal, such as cases where the code isn't
> needed as memory is not over-committed, or the functionality is not in
> use. I have been using the will-it-scale/page_fault1 test running with 16
> vcpus and have modified it to use Transparent Huge Pages. With this I see
> almost no difference with the patches applied and the feature disabled.
> Likewise I see almost no difference with the feature enabled, but the
> madvise disabled in the hypervisor due to a device being assigned. With
> the feature fully enabled in both guest and hypervisor I see a regression
> between -1.86% and -8.84% versus the baseline. I found that most of the
> overhead was due to the page faulting/zeroing that comes as a result of
> the pages having been evicted from the guest.

I think Michal asked for a performance comparison against Nitesh's
approach, to evaluate if keeping the reported state + tracking inside
the buddy is really worth it. Do you have any such numbers already? (or
did my tired eyes miss them in this cover letter? :/)

-- 

Thanks,

David / dhildenb

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

