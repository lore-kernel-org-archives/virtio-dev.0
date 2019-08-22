Return-Path: virtio-dev-return-6010-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 668B0985CA6
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Aug 2019 16:24:50 +0000 (UTC)
MIME-Version: 1.0
References: <20190821145806.20926.22448.stgit@localhost.localdomain>
 <20190821145950.20926.83684.stgit@localhost.localdomain> <91355107-ed73-fce5-7051-3a746b526163@redhat.com>
In-Reply-To: <91355107-ed73-fce5-7051-3a746b526163@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 22 Aug 2019 09:24:37 -0700
Message-ID: <CAKgT0UeFyxH9pEsQ+CcZo3c4-GZdqsw6ucPG2KOkefvDvFF94g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] [PATCH v6 4/6] mm: Introduce Reported pages
To: Nitesh Narayan Lal <nitesh@redhat.com>
Cc: kvm list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, virtio-dev@lists.oasis-open.org, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Rik van Riel <riel@surriel.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Aug 22, 2019 at 9:19 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>
>
> On 8/21/19 10:59 AM, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > In order to pave the way for free page reporting in virtualized
> > environments we will need a way to get pages out of the free lists and
> > identify those pages after they have been returned. To accomplish this,
> > this patch adds the concept of a Reported Buddy, which is essentially
> > meant to just be the Uptodate flag used in conjunction with the Buddy
> > page type.
> >
> > It adds a set of pointers we shall call "boundary" which represents the
> > upper boundary between the unreported and reported pages. The general idea
> > is that in order for a page to cross from one side of the boundary to the
> > other it will need to go through the reporting process. Ultimately a
> > free_list has been fully processed when the boundary has been moved from
> > the tail all they way up to occupying the first entry in the list.
> >
> > Doing this we should be able to make certain that we keep the reported
> > pages as one contiguous block in each free list. This will allow us to
> > efficiently manipulate the free lists whenever we need to go in and start
> > sending reports to the hypervisor that there are new pages that have been
> > freed and are no longer in use.
> >
> > An added advantage to this approach is that we should be reducing the
> > overall memory footprint of the guest as it will be more likely to recycle
> > warm pages versus trying to allocate the reported pages that were likely
> > evicted from the guest memory.
> >
> > Since we will only be reporting one zone at a time we keep the boundary
> > limited to being defined for just the zone we are currently reporting pages
> > from. Doing this we can keep the number of additional pointers needed quite
> > small. To flag that the boundaries are in place we use a single bit
> > in the zone to indicate that reporting and the boundaries are active.
> >
> > The determination of when to start reporting is based on the tracking of
> > the number of free pages in a given area versus the number of reported
> > pages in that area. We keep track of the number of reported pages per
> > free_area in a separate zone specific area. We do this to avoid modifying
> > the free_area structure as this can lead to false sharing for the highest
> > order with the zone lock which leads to a noticeable performance
> > degradation.
> [...]
> > +
> > +/* request page reporting on this zone */
> > +void __page_reporting_request(struct zone *zone)
> > +{
> > +     struct page_reporting_dev_info *phdev;
> > +
> > +     rcu_read_lock();
> > +
> > +     /*
> > +      * We use RCU to protect the ph_dev_info pointer. In almost all
> > +      * cases this should be present, however in the unlikely case of
> > +      * a shutdown this will be NULL and we should exit.
> > +      */
> > +     phdev = rcu_dereference(ph_dev_info);
> > +     if (unlikely(!phdev))
> > +             return;
> > +
>
> Just a minor comment here.
> Although this is unlikely to trigger still I think you should release the
> rcu_read_lock before returning.

Thanks for catching that. I will have that fixed for next version.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

