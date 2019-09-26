Return-Path: virtio-dev-return-6172-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4F4B5985E52
	for <virtio-dev@lists.oasis-open.org>; Thu, 26 Sep 2019 15:14:10 +0000 (UTC)
MIME-Version: 1.0
References: <20190918175109.23474.67039.stgit@localhost.localdomain>
 <20190924142342.GX23050@dhcp22.suse.cz> <CAKgT0UcYdA+LysVVO+8Beabsd-YBH+tNUKnQgaFmrZBW1xkFxA@mail.gmail.com>
 <20190926122208.GI20255@dhcp22.suse.cz>
In-Reply-To: <20190926122208.GI20255@dhcp22.suse.cz>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 26 Sep 2019 08:13:58 -0700
Message-ID: <CAKgT0UfMooLJ9bWAhAyyznwxcUyibJr28AaSKfYbdJkguOLcvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [PATCH v10 0/6] mm / virtio: Provide support for unused page reporting
To: Michal Hocko <mhocko@kernel.org>
Cc: virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, linux-arm-kernel@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Nitesh Narayan Lal <nitesh@redhat.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 26, 2019 at 5:22 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 24-09-19 08:20:22, Alexander Duyck wrote:
> > On Tue, Sep 24, 2019 at 7:23 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Wed 18-09-19 10:52:25, Alexander Duyck wrote:
> > > [...]
> > > > In order to try and keep the time needed to find a non-reported page to
> > > > a minimum we maintain a "reported_boundary" pointer. This pointer is used
> > > > by the get_unreported_pages iterator to determine at what point it should
> > > > resume searching for non-reported pages. In order to guarantee pages do
> > > > not get past the scan I have modified add_to_free_list_tail so that it
> > > > will not insert pages behind the reported_boundary.
> > > >
> > > > If another process needs to perform a massive manipulation of the free
> > > > list, such as compaction, it can either reset a given individual boundary
> > > > which will push the boundary back to the list_head, or it can clear the
> > > > bit indicating the zone is actively processing which will result in the
> > > > reporting process resetting all of the boundaries for a given zone.
> > >
> > > Is this any different from the previous version? The last review
> > > feedback (both from me and Mel) was that we are not happy to have an
> > > externally imposed constrains on how the page allocator is supposed to
> > > maintain its free lists.
> >
> > The main change for v10 versus v9 is that I allow the page reporting
> > boundary to be overridden. Specifically there are two approaches that
> > can be taken.
> >
> > The first is to simply reset the iterator for whatever list is
> > updated. What this will do is reset the iterator back to list_head and
> > then you can do whatever you want with that specific list.
>
> OK, this is slightly better than pushing the allocator to the corner.
> The allocator really has to be under control of its data structures.
> I would still be happier if the allocator wouldn't really have to bother
> about somebody snooping its internal state to do its own thing. So
> please make sure to describe why and how much this really matters.

Okay I can try to do that. I suppose if nothing else I can put
together a test patch that reverts these bits and can add
documentation on the amount of regression seen without those bits. I
should be able to get that taken care of and a v11 out in the next few
days.

> > The other option is to simply clear the ZONE_PAGE_REPORTING_ACTIVE
> > bit. That will essentially notify the page reporting code that any/all
> > hints that were recorded have been discarded and that it needs to
> > start over.
> >
> > All I am trying to do with this approach is reduce the work. Without
> > doing this the code has to walk the entire free page list for the
> > higher orders every iteration and that will not be cheap.
>
> How expensive this will be?

Well without this I believe the work goes from being O(n) to O(n^2) as
we would have to walk the list every time we pull the batch of pages,
so without the iterator we end up having walk the page list
repeatedly. I suspect it becomes more expensive the more memory we
have. I'll be able to verify it later today once I can generate some
numbers.

> > Admittedly
> > it is a bit more invasive than the cut/splice logic used in compaction
> > which is taking the pages it has already processed and moving them to
> > the other end of the list. However, I have reduced things so that we
> > only really are limiting where add_to_free_list_tail can place pages,
> > and we are having to check/push back the boundaries if a reported page
> > is removed from a free_list.
> >
> > > If this is really the only way to go forward then I would like to hear
> > > very convincing arguments about other approaches not being feasible.
> > > There are none in this cover letter unfortunately. This will be really a
> > > hard sell without them.
> >
> > So I had considered several different approaches.
>
> Thanks this is certainly useful and it would have been even more so if
> you gave some rough numbers to quantify how much overhead for different
> solutions we are talking about here.

I'll see what I can do. As far as the bitmap solution I think Nitesh
has numbers for what he has been able to get out of it. At this point
I would assume his solution for the virtio/QEMU bits is probably
identical to mine so it should be easier to get an apples to apples
comparison.

Thanks.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

