Return-Path: virtio-dev-return-2458-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 09CF158190FC
	for <virtio-dev@lists.oasis-open.org>; Mon,  7 Aug 2017 23:10:14 -0700 (PDT)
Message-ID: <59895668.9090104@intel.com>
Date: Tue, 08 Aug 2017 14:12:56 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1501742299-4369-1-git-send-email-wei.w.wang@intel.com> <1501742299-4369-5-git-send-email-wei.w.wang@intel.com> <20170803091151.GF12521@dhcp22.suse.cz>
In-Reply-To: <20170803091151.GF12521@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v13 4/5] mm: support reporting free page blocks
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mawilcox@microsoft.com, akpm@linux-foundation.org, virtio-dev@lists.oasis-open.org, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 08/03/2017 05:11 PM, Michal Hocko wrote:
> On Thu 03-08-17 14:38:18, Wei Wang wrote:
> This is just too ugly and wrong actually. Never provide struct page
> pointers outside of the zone->lock. What I've had in mind was to simply
> walk free lists of the suitable order and call the callback for each one.
> Something as simple as
>
> 	for (i = 0; i < MAX_NR_ZONES; i++) {
> 		struct zone *zone = &pgdat->node_zones[i];
>
> 		if (!populated_zone(zone))
> 			continue;

Can we directly use for_each_populated_zone(zone) here?


> 		spin_lock_irqsave(&zone->lock, flags);
> 		for (order = min_order; order < MAX_ORDER; ++order) {


This appears to be covered by for_each_migratetype_order(order, mt) below.


> 			struct free_area *free_area = &zone->free_area[order];
> 			enum migratetype mt;
> 			struct page *page;
>
> 			if (!free_area->nr_pages)
> 				continue;
>
> 			for_each_migratetype_order(order, mt) {
> 				list_for_each_entry(page,
> 						&free_area->free_list[mt], lru) {
>
> 					pfn = page_to_pfn(page);
> 					visit(opaque2, prn, 1<<order);
> 				}
> 			}
> 		}
>
> 		spin_unlock_irqrestore(&zone->lock, flags);
> 	}
>
> [...]
>

What do you think if we further simply the above implementation like this:

for_each_populated_zone(zone) {
                 for_each_migratetype_order_decend(1, order, mt) {
                         spin_lock_irqsave(&zone->lock, flags);
                         list_for_each_entry(page,
&zone->free_area[order].free_list[mt], lru) {
                                 pfn = page_to_pfn(page);
                                 visit(opaque1, pfn, 1 << order);
                         }
                         spin_unlock_irqrestore(&zone->lock, flags);
                 }
         }


Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

