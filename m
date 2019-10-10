Return-Path: virtio-dev-return-6220-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 46017985D74
	for <virtio-dev@lists.oasis-open.org>; Thu, 10 Oct 2019 20:36:38 +0000 (UTC)
MIME-Version: 1.0
References: <20190812131235.27244-1-nitesh@redhat.com> <20190812131235.27244-2-nitesh@redhat.com>
In-Reply-To: <20190812131235.27244-2-nitesh@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 10 Oct 2019 13:36:26 -0700
Message-ID: <CAKgT0UeKxCYtg6+aCPyxJcAGrBgvCWziUpZM6Tmw-9PSChcGVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [RFC][Patch v12 1/2] mm: page_reporting: core infrastructure
To: Nitesh Narayan Lal <nitesh@redhat.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com, Pankaj Gupta <pagupta@redhat.com>, "Wang, Wei W" <wei.w.wang@intel.com>, Yang Zhang <yang.zhang.wz@gmail.com>, Rik van Riel <riel@surriel.com>, David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>, john.starks@microsoft.com, Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Aug 12, 2019 at 6:13 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>

<snip>

> +static int process_free_page(struct page *page,
> +                            struct page_reporting_config *phconf, int count)
> +{
> +       int mt, order, ret = 0;
> +
> +       mt = get_pageblock_migratetype(page);
> +       order = page_private(page);
> +       ret = __isolate_free_page(page, order);
> +
> +       if (ret) {
> +               /*
> +                * Preserving order and migratetype for reuse while
> +                * releasing the pages back to the buddy.
> +                */
> +               set_pageblock_migratetype(page, mt);
> +               set_page_private(page, order);
> +
> +               sg_set_page(&phconf->sg[count++], page,
> +                           PAGE_SIZE << order, 0);
> +       }
> +
> +       return count;
> +}
> +
> +/**
> + * scan_zone_bitmap - scans the bitmap for the requested zone.
> + * @phconf: page reporting configuration object initialized by the backend.
> + * @zone: zone for which page reporting is requested.
> + *
> + * For every page marked in the bitmap it checks if it is still free if so it
> + * isolates and adds them to a scatterlist. As soon as the number of isolated
> + * pages reach the threshold set by the backend, they are reported to the
> + * hypervisor by the backend. Once the hypervisor responds after processing
> + * they are returned back to the buddy for reuse.
> + */
> +static void scan_zone_bitmap(struct page_reporting_config *phconf,
> +                            struct zone *zone)
> +{
> +       unsigned long setbit;
> +       struct page *page;
> +       int count = 0;
> +
> +       sg_init_table(phconf->sg, phconf->max_pages);
> +
> +       for_each_set_bit(setbit, zone->bitmap, zone->nbits) {
> +               /* Process only if the page is still online */
> +               page = pfn_to_online_page((setbit << PAGE_REPORTING_MIN_ORDER) +
> +                                         zone->base_pfn);
> +               if (!page)
> +                       continue;
> +
> +               spin_lock(&zone->lock);
> +
> +               /* Ensure page is still free and can be processed */
> +               if (PageBuddy(page) && page_private(page) >=
> +                   PAGE_REPORTING_MIN_ORDER)
> +                       count = process_free_page(page, phconf, count);
> +
> +               spin_unlock(&zone->lock);
> +               /* Page has been processed, adjust its bit and zone counter */
> +               clear_bit(setbit, zone->bitmap);
> +               atomic_dec(&zone->free_pages);
> +
> +               if (count == phconf->max_pages) {
> +                       /* Report isolated pages to the hypervisor */
> +                       phconf->report(phconf, count);
> +
> +                       /* Return processed pages back to the buddy */
> +                       return_isolated_page(zone, phconf);
> +
> +                       /* Reset for next reporting */
> +                       sg_init_table(phconf->sg, phconf->max_pages);
> +                       count = 0;
> +               }
> +       }
> +       /*
> +        * If the number of isolated pages does not meet the max_pages
> +        * threshold, we would still prefer to report them as we have already
> +        * isolated them.
> +        */
> +       if (count) {
> +               sg_mark_end(&phconf->sg[count - 1]);
> +               phconf->report(phconf, count);
> +
> +               return_isolated_page(zone, phconf);
> +       }
> +}
> +

So one thing that occurred to me is that this code is missing checks
so that it doesn't try to hint isolated pages. With the bitmap
approach you need an additional check so that you aren't pulling
isolated pages out and reporting them.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

