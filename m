Return-Path: virtio-dev-return-6080-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A9DD898431C
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Sep 2019 08:22:44 +0000 (UTC)
References: <20190907172225.10910.34302.stgit@localhost.localdomain>
 <20190907172528.10910.37051.stgit@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Message-ID: <98c05446-84f6-97f1-b246-1ad9595cc230@redhat.com>
Date: Mon, 9 Sep 2019 10:22:29 +0200
MIME-Version: 1.0
In-Reply-To: <20190907172528.10910.37051.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v9 3/8] mm: Move set/get_pcppage_migratetype to mmzone.h
To: Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, catalin.marinas@arm.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, will@kernel.org, linux-arm-kernel@lists.infradead.org, osalvador@suse.de
Cc: yang.zhang.wz@gmail.com, pagupta@redhat.com, konrad.wilk@oracle.com, nitesh@redhat.com, riel@surriel.com, lcapitulino@redhat.com, wei.w.wang@intel.com, aarcange@redhat.com, ying.huang@intel.com, pbonzini@redhat.com, dan.j.williams@intel.com, fengguang.wu@intel.com, alexander.h.duyck@linux.intel.com, kirill.shutemov@linux.intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 07.09.19 19:25, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> In order to support page reporting it will be necessary to store and
> retrieve the migratetype of a page. To enable that I am moving the set and
> get operations for pcppage_migratetype into the mm/internal.h header so
> that they can be used outside of the page_alloc.c file.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  mm/internal.h   |   18 ++++++++++++++++++
>  mm/page_alloc.c |   18 ------------------
>  2 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 0d5f720c75ab..e4a1a57bbd40 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -549,6 +549,24 @@ static inline bool is_migrate_highatomic_page(struct page *page)
>  	return get_pageblock_migratetype(page) == MIGRATE_HIGHATOMIC;
>  }
>  
> +/*
> + * A cached value of the page's pageblock's migratetype, used when the page is
> + * put on a pcplist. Used to avoid the pageblock migratetype lookup when
> + * freeing from pcplists in most cases, at the cost of possibly becoming stale.
> + * Also the migratetype set in the page does not necessarily match the pcplist
> + * index, e.g. page might have MIGRATE_CMA set but be on a pcplist with any
> + * other index - this ensures that it will be put on the correct CMA freelist.
> + */
> +static inline int get_pcppage_migratetype(struct page *page)
> +{
> +	return page->index;
> +}
> +
> +static inline void set_pcppage_migratetype(struct page *page, int migratetype)
> +{
> +	page->index = migratetype;
> +}
> +
>  void setup_zone_pageset(struct zone *zone);
>  extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
>  #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4e4356ba66c7..a791f2baeeeb 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -185,24 +185,6 @@ static int __init early_init_on_free(char *buf)
>  }
>  early_param("init_on_free", early_init_on_free);
>  
> -/*
> - * A cached value of the page's pageblock's migratetype, used when the page is
> - * put on a pcplist. Used to avoid the pageblock migratetype lookup when
> - * freeing from pcplists in most cases, at the cost of possibly becoming stale.
> - * Also the migratetype set in the page does not necessarily match the pcplist
> - * index, e.g. page might have MIGRATE_CMA set but be on a pcplist with any
> - * other index - this ensures that it will be put on the correct CMA freelist.
> - */
> -static inline int get_pcppage_migratetype(struct page *page)
> -{
> -	return page->index;
> -}
> -
> -static inline void set_pcppage_migratetype(struct page *page, int migratetype)
> -{
> -	page->index = migratetype;
> -}
> -
>  #ifdef CONFIG_PM_SLEEP
>  /*
>   * The following functions are used by the suspend/hibernate code to temporarily
> 
> 

Still have to understand in detail how this will be used, but the change
certainly looks ok :)

Acked-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

