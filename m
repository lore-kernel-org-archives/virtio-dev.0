Return-Path: virtio-dev-return-4414-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 4919F5818EAE
	for <virtio-dev@lists.oasis-open.org>; Sun, 17 Jun 2018 19:16:20 -0700 (PDT)
Date: Mon, 18 Jun 2018 05:16:02 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180618051145-mutt-send-email-mst@kernel.org>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
 <1529037793-35521-2-git-send-email-wei.w.wang@intel.com>
 <20180616045005.GA14936@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180616045005.GA14936@bombadil.infradead.org>
Subject: [virtio-dev] Re: [PATCH v33 1/4] mm: add a function to get free page blocks
To: Matthew Wilcox <willy@infradead.org>
Cc: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, peterx@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jun 15, 2018 at 09:50:05PM -0700, Matthew Wilcox wrote:
> I wonder if (to address Michael's concern), you shouldn't instead use
> the first free chunk of pages to return the addresses of all the pages.
> ie something like this:
> 
> 	__le64 *ret = NULL;
> 	unsigned int max = (PAGE_SIZE << order) / sizeof(__le64);
> 
> 	for_each_populated_zone(zone) {
> 		spin_lock_irq(&zone->lock);
> 		for (mt = 0; mt < MIGRATE_TYPES; mt++) {
> 			list = &zone->free_area[order].free_list[mt];
> 			list_for_each_entry_safe(page, list, lru, ...) {
> 				if (index == size)
> 					break;
> 				addr = page_to_pfn(page) << PAGE_SHIFT;
> 				if (!ret) {
> 					list_del(...);
> 					ret = addr;
> 				}
> 				ret[index++] = cpu_to_le64(addr);
> 			}
> 		}
> 		spin_unlock_irq(&zone->lock);
> 	}
> 
> 	return ret;
> }
> 
> You'll need to return the page to the freelist afterwards, but free_pages()
> should take care of that.

Yes Wei already came up with the idea to stick this data into a
MAX_ORDER allocation. Are you sure just taking an entry off
the list like that has no bad side effects?
I have a vague memory someone complained that everyone
most go through get free pages/kmalloc, but I can't
find that anymore.


-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

