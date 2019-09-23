Return-Path: virtio-dev-return-6149-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0BD25985A54
	for <virtio-dev@lists.oasis-open.org>; Mon, 23 Sep 2019 15:28:12 +0000 (UTC)
MIME-Version: 1.0
References: <20190918175109.23474.67039.stgit@localhost.localdomain>
 <20190918175249.23474.51171.stgit@localhost.localdomain> <20190923041330-mutt-send-email-mst@kernel.org>
 <CAKgT0UfFBO9h3heGSo+AaZgUNpy5uuOm3yh62bYwYJ5dq+t1gQ@mail.gmail.com> <20190923105746-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190923105746-mutt-send-email-mst@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 23 Sep 2019 08:28:00 -0700
Message-ID: <CAKgT0Ufp0bdz3YkbAoKWd5DALFjAkHaSUn_UywW1+3hk4tjPSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [PATCH v10 3/6] mm: Introduce Reported pages
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>, linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, linux-arm-kernel@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Nitesh Narayan Lal <nitesh@redhat.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Sep 23, 2019 at 8:00 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Sep 23, 2019 at 07:50:15AM -0700, Alexander Duyck wrote:
> > > > +static inline void
> > > > +page_reporting_reset_boundary(struct zone *zone, unsigned int order, int mt)
> > > > +{
> > > > +     int index;
> > > > +
> > > > +     if (order < PAGE_REPORTING_MIN_ORDER)
> > > > +             return;
> > > > +     if (!test_bit(ZONE_PAGE_REPORTING_ACTIVE, &zone->flags))
> > > > +             return;
> > > > +
> > > > +     index = get_reporting_index(order, mt);
> > > > +     reported_boundary[index] = &zone->free_area[order].free_list[mt];
> > > > +}
> > >
> > > So this seems to be costly.
> > > I'm guessing it's the access to flags:
> > >
> > >
> > >         /* zone flags, see below */
> > >         unsigned long           flags;
> > >
> > >         /* Primarily protects free_area */
> > >         spinlock_t              lock;
> > >
> > >
> > >
> > > which is in the same cache line as the lock.
> >
> > I'm not sure what you mean by this being costly?
>
> I've just been wondering why does will it scale report a 1.5% regression
> with this patch.

Are you talking about data you have collected from a test you have
run, or the data I have run?

In the case of the data I have run I notice almost no difference as
long as the pages are not actually being madvised. Once I turn on the
madvise then I start seeing the regression, but almost all of that is
due to page zeroing/faulting. There isn't expected to be a gain from
this patchset until you start having guests dealing with memory
overcommit on the host. Then at that point the patch set should start
showing gains when the madvise bits are enabled in QEMU.

Also the test I have been running is a modified version of the
page_fault1 test to specifically target transparent huge pages in
order to make this test that much more difficult, the standard
page_fault1 test wasn't showing much of anything since the overhead
for breaking a 2M page into 512 4K pages and zeroing those
individually in the guest  was essentially drowning out the effect of
the patches themselves.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

