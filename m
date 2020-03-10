Return-Path: virtio-dev-return-6913-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E5ADA985F01
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Mar 2020 11:49:04 +0000 (UTC)
References: <20200302134941.315212-1-david@redhat.com>
 <20200302134941.315212-7-david@redhat.com>
 <20200310114745.GH8447@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5bc2a2ff-1ae0-6746-b32a-c27962804cef@redhat.com>
Date: Tue, 10 Mar 2020 12:48:48 +0100
MIME-Version: 1.0
In-Reply-To: <20200310114745.GH8447@dhcp22.suse.cz>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v1 06/11] mm: Allow to offline unmovable PageOffline()
 pages via MEM_GOING_OFFLINE
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, Oscar Salvador <osalvador@suse.de>, Mel Gorman <mgorman@techsingularity.net>, Mike Rapoport <rppt@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Qian Cai <cai@lca.pw>, Pingfan Liu <kernelfans@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 10.03.20 12:47, Michal Hocko wrote:
> On Mon 02-03-20 14:49:36, David Hildenbrand wrote:
>> virtio-mem wants to allow to offline memory blocks of which some parts
>> were unplugged (allocated via alloc_contig_range()), especially, to later
>> offline and remove completely unplugged memory blocks. The important part
>> is that PageOffline() has to remain set until the section is offline, so
>> these pages will never get accessed (e.g., when dumping). The pages should
>> not be handed back to the buddy (which would require clearing PageOffline()
>> and result in issues if offlining fails and the pages are suddenly in the
>> buddy).
>>
>> Let's allow to do that by allowing to isolate any PageOffline() page
>> when offlining. This way, we can reach the memory hotplug notifier
>> MEM_GOING_OFFLINE, where the driver can signal that he is fine with
>> offlining this page by dropping its reference count. PageOffline() pages
>> with a reference count of 0 can then be skipped when offlining the
>> pages (like if they were free, however they are not in the buddy).
>>
>> Anybody who uses PageOffline() pages and does not agree to offline them
>> (e.g., Hyper-V balloon, XEN balloon, VMWare balloon for 2MB pages) will not
>> decrement the reference count and make offlining fail when trying to
>> migrate such an unmovable page. So there should be no observable change.
>> Same applies to balloon compaction users (movable PageOffline() pages), the
>> pages will simply be migrated.
>>
>> Note 1: If offlining fails, a driver has to increment the reference
>> 	count again in MEM_CANCEL_OFFLINE.
>>
>> Note 2: A driver that makes use of this has to be aware that re-onlining
>> 	the memory block has to be handled by hooking into onlining code
>> 	(online_page_callback_t), resetting the page PageOffline() and
>> 	not giving them to the buddy.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Juergen Gross <jgross@suse.com>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
>> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Anthony Yznaga <anthony.yznaga@oracle.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Mike Rapoport <rppt@linux.ibm.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Qian Cai <cai@lca.pw>
>> Cc: Pingfan Liu <kernelfans@gmail.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Looks good to me. Thanks for dropping __put_page hooks!
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks a lot Michal - looks much cleaner this way.

-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

