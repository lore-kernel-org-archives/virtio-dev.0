Return-Path: virtio-dev-return-6164-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E6BEE985DCA
	for <virtio-dev@lists.oasis-open.org>; Tue, 24 Sep 2019 17:07:27 +0000 (UTC)
MIME-Version: 1.0
References: <20190918175109.23474.67039.stgit@localhost.localdomain>
 <20190924142342.GX23050@dhcp22.suse.cz> <d2a7acdd-3bb9-05c9-42d0-70a500801cd6@redhat.com>
In-Reply-To: <d2a7acdd-3bb9-05c9-42d0-70a500801cd6@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 24 Sep 2019 10:07:11 -0700
Message-ID: <CAKgT0UedoNBk3cp64SpCzXJqjtqBWZQSB7QzF7R_jhTDXbzNPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [PATCH v10 0/6] mm / virtio: Provide support for unused page reporting
To: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>, virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, linux-arm-kernel@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Nitesh Narayan Lal <nitesh@redhat.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Sep 24, 2019 at 8:32 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 24.09.19 16:23, Michal Hocko wrote:
> > On Wed 18-09-19 10:52:25, Alexander Duyck wrote:
> > [...]
> >> In order to try and keep the time needed to find a non-reported page to
> >> a minimum we maintain a "reported_boundary" pointer. This pointer is used
> >> by the get_unreported_pages iterator to determine at what point it should
> >> resume searching for non-reported pages. In order to guarantee pages do
> >> not get past the scan I have modified add_to_free_list_tail so that it
> >> will not insert pages behind the reported_boundary.
> >>
> >> If another process needs to perform a massive manipulation of the free
> >> list, such as compaction, it can either reset a given individual boundary
> >> which will push the boundary back to the list_head, or it can clear the
> >> bit indicating the zone is actively processing which will result in the
> >> reporting process resetting all of the boundaries for a given zone.
> >
> > Is this any different from the previous version? The last review
> > feedback (both from me and Mel) was that we are not happy to have an
> > externally imposed constrains on how the page allocator is supposed to
> > maintain its free lists.
> >
> > If this is really the only way to go forward then I would like to hear
> > very convincing arguments about other approaches not being feasible.
>
> Adding to what Alexander said, I don't consider the other approaches
> (especially the bitmap-based approach Nitesh is currently working on)
> infeasible. There might be more rough edges (e.g., sparse zones) and
> eventually sometimes a little more work to be done, but definitely
> feasible. Incorporating stuff into the buddy might make some tasks
> (e.g., identify free pages) more efficient.
>
> I still somewhat like the idea of capturing hints of free pages (in
> whatever data structure) and then going over the hints, seeing if the
> pages are still free. Then only temporarily isolating the still-free
> pages, reporting them, and un-isolating them after they were reported. I
> like the idea that the pages are not fake-allocated but only temporarily
> blocked. That works nicely e.g., with the movable zone (contain only
> movable data).

One other change in this patch set is that I split the headers so that
there is an internal header that resides in the mm tree and an
external one that provides the page reporting device structure and the
register/unregister functions. All that virtio-balloon knows is that
it is registering a notifier and will be called with scatter gather
lists for memory that is not currently in use by the kernel. It has no
visibility into the internal free_areas or the current state of the
buddy allocator. Rather than having two blocks that are both trying to
maintain that state, I have consolidated it all into the buddy
allocator with page reporting.

> But anyhow, after decades of people working on free page
> hinting/reporting, I am happy with anything that gets accepted upstream :D

Agreed. After working on this for 9 months I would be happy to get
something upstream that addresses this.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

