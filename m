Return-Path: virtio-dev-return-6148-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DC171985A54
	for <virtio-dev@lists.oasis-open.org>; Mon, 23 Sep 2019 15:00:35 +0000 (UTC)
Date: Mon, 23 Sep 2019 11:00:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190923105746-mutt-send-email-mst@kernel.org>
References: <20190918175109.23474.67039.stgit@localhost.localdomain>
 <20190918175249.23474.51171.stgit@localhost.localdomain>
 <20190923041330-mutt-send-email-mst@kernel.org>
 <CAKgT0UfFBO9h3heGSo+AaZgUNpy5uuOm3yh62bYwYJ5dq+t1gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UfFBO9h3heGSo+AaZgUNpy5uuOm3yh62bYwYJ5dq+t1gQ@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v10 3/6] mm: Introduce Reported pages
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>, linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, linux-arm-kernel@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Nitesh Narayan Lal <nitesh@redhat.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Sep 23, 2019 at 07:50:15AM -0700, Alexander Duyck wrote:
> > > +static inline void
> > > +page_reporting_reset_boundary(struct zone *zone, unsigned int order, int mt)
> > > +{
> > > +     int index;
> > > +
> > > +     if (order < PAGE_REPORTING_MIN_ORDER)
> > > +             return;
> > > +     if (!test_bit(ZONE_PAGE_REPORTING_ACTIVE, &zone->flags))
> > > +             return;
> > > +
> > > +     index = get_reporting_index(order, mt);
> > > +     reported_boundary[index] = &zone->free_area[order].free_list[mt];
> > > +}
> >
> > So this seems to be costly.
> > I'm guessing it's the access to flags:
> >
> >
> >         /* zone flags, see below */
> >         unsigned long           flags;
> >
> >         /* Primarily protects free_area */
> >         spinlock_t              lock;
> >
> >
> >
> > which is in the same cache line as the lock.
> 
> I'm not sure what you mean by this being costly?

I've just been wondering why does will it scale report a 1.5% regression
with this patch.

> Also, at least on my system, pahole seems to indicate they are in
> different cache lines.
> 
> /* --- cacheline 3 boundary (192 bytes) --- */
> struct zone_padding        _pad1_;               /*   192     0 */
> struct free_area           free_area[11];        /*   192  1144 */
> /* --- cacheline 20 boundary (1280 bytes) was 56 bytes ago --- */
> long unsigned int          flags;                /*  1336     8 */
> /* --- cacheline 21 boundary (1344 bytes) --- */
> spinlock_t                 lock;                 /*  1344     4 */
> 
> Basically these flags aren't supposed to be touched unless we are
> holding the lock anyway so I am not sure it would be all that costly
> for this setup. Basically we are holding the lock when the flag is set
> or cleared, and we only set it if it is not already set. If needed
> though I suppose I could look at moving the flags if you think that is
> an issue. However I would probably need to add some additional padding
> to prevent the lock from getting into the same cache line as the
> free_area values.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

