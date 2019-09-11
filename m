Return-Path: virtio-dev-return-6121-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FB2F985C72
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Sep 2019 15:12:16 +0000 (UTC)
MIME-Version: 1.0
References: <20190907172225.10910.34302.stgit@localhost.localdomain>
 <20190910124209.GY2063@dhcp22.suse.cz> <CAKgT0Udr6nYQFTRzxLbXk41SiJ-pcT_bmN1j1YR4deCwdTOaUQ@mail.gmail.com>
 <20190910144713.GF2063@dhcp22.suse.cz> <CAKgT0UdB4qp3vFGrYEs=FwSXKpBEQ7zo7DV55nJRO2C-KCEOrw@mail.gmail.com>
 <20190910175213.GD4023@dhcp22.suse.cz> <1d7de9f9f4074f67c567dbb4cc1497503d739e30.camel@linux.intel.com>
 <20190911113619.GP4023@dhcp22.suse.cz>
In-Reply-To: <20190911113619.GP4023@dhcp22.suse.cz>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 11 Sep 2019 08:12:03 -0700
Message-ID: <CAKgT0UfOp1c+ov=3pBD72EkSB9Vm7mG5G6zJj4=j=UH7zCgg2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [PATCH v9 0/8] stg mail -e --version=v9 \
To: Michal Hocko <mhocko@kernel.org>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>, virtio-dev@lists.oasis-open.org, kvm list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, will@kernel.org, linux-arm-kernel@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, Yang Zhang <yang.zhang.wz@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Nitesh Narayan Lal <nitesh@redhat.com>, Rik van Riel <riel@surriel.com>, lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Fengguang Wu <fengguang.wu@intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Sep 11, 2019 at 4:36 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 10-09-19 14:23:40, Alexander Duyck wrote:
> [...]
> > We don't put any limitations on the allocator other then that it needs to
> > clean up the metadata on allocation, and that it cannot allocate a page
> > that is in the process of being reported since we pulled it from the
> > free_list. If the page is a "Reported" page then it decrements the
> > reported_pages count for the free_area and makes sure the page doesn't
> > exist in the "Boundary" array pointer value, if it does it moves the
> > "Boundary" since it is pulling the page.
>
> This is still a non-trivial limitation on the page allocation from an
> external code IMHO. I cannot give any explicit reason why an ordering on
> the free list might matter (well except for page shuffling which uses it
> to make physical memory pattern allocation more random) but the
> architecture seems hacky and dubious to be honest. It shoulds like the
> whole interface has been developed around a very particular and single
> purpose optimization.

How is this any different then the code that moves a page that will
likely be merged to the tail though?

In our case the "Reported" page is likely going to be much more
expensive to allocate and use then a standard page because it will be
faulted back in. In such a case wouldn't it make sense for us to want
to keep the pages that don't require faults ahead of those pages in
the free_list so that they are more likely to be allocated? All we are
doing with the boundary list is preventing still resident pages from
being deferred behind pages that would require a page fault to get
access to.

> I remember that there was an attempt to report free memory that provided
> a callback mechanism [1], which was much less intrusive to the internals
> of the allocator yet it should provide a similar functionality. Did you
> see that approach? How does this compares to it? Or am I completely off
> when comparing them?
>
> [1] mostly likely not the latest version of the patchset
> http://lkml.kernel.org/r/1502940416-42944-5-git-send-email-wei.w.wang@intel.com

There have been a few comparisons between this patch set and the ones
from Wei Wang. In regards to the one you are pointing to the main
difference is that I am not permanently locking memory. Basically what
happens is that the iterator will take the lock, pull a few pages,
release the lock while reporting them, and then take the lock to
return those pages, grab some more, and repeat.

I was actually influenced somewhat by the suggestions that patchset
received, specifically I believe it resembles something like what was
suggested by Linus in response to v35 of that patch set:
https://lore.kernel.org/linux-mm/CA+55aFzqj8wxXnHAdUTiOomipgFONVbqKMjL_tfk7e5ar1FziQ@mail.gmail.com/

Basically where the feature Wei Wang was working on differs from this
patch set is that I need this to run continually, his only needed to
run periodically as he was just trying to identify free pages at a
fixed point in time. My goal is to identify pages that have been freed
since the last time I reported them. To do that I need a flag in the
page to identify those pages, and an iterator in the form of a
boundary pointer so that I can incrementally walk through the list
without losing track of freed pages.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

