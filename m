Return-Path: virtio-dev-return-5986-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EE6A3985B2B
	for <virtio-dev@lists.oasis-open.org>; Thu, 15 Aug 2019 23:00:58 +0000 (UTC)
MIME-Version: 1.0
References: <20190812131235.27244-1-nitesh@redhat.com> <20190812131235.27244-2-nitesh@redhat.com>
 <CAKgT0UcSabyrO=jUwq10KpJKLSuzorHDnKAGrtWVigKVgvD-6Q@mail.gmail.com>
 <6d5b57ca-41ff-5c54-ab20-2b1631a6ce29@redhat.com> <CAKgT0UfavuUT4ZvfxVdm3h25qc86ksxPO=GFpFkf8zbGAjHPvg@mail.gmail.com>
 <09c6fbef-fa53-3a25-d3d6-460b9b6b2020@redhat.com> <6241ef40-9403-1cb0-4e91-a1b86fcf1388@redhat.com>
In-Reply-To: <6241ef40-9403-1cb0-4e91-a1b86fcf1388@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 15 Aug 2019 16:00:46 -0700
Message-ID: <CAKgT0UduKXTMHD2qWqEa7wQPOFYtaQ5Sx3XS9Ki8i8-_kTdmkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [RFC][Patch v12 1/2] mm: page_reporting: core infrastructure
To: Nitesh Narayan Lal <nitesh@redhat.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com, Pankaj Gupta <pagupta@redhat.com>, "Wang, Wei W" <wei.w.wang@intel.com>, Yang Zhang <yang.zhang.wz@gmail.com>, Rik van Riel <riel@surriel.com>, David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>, john.starks@microsoft.com, Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Aug 15, 2019 at 12:23 PM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>
>
> On 8/15/19 9:15 AM, Nitesh Narayan Lal wrote:
> > On 8/14/19 12:11 PM, Alexander Duyck wrote:
> >> On Wed, Aug 14, 2019 at 8:49 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
> >>> On 8/12/19 2:47 PM, Alexander Duyck wrote:
> >>>> On Mon, Aug 12, 2019 at 6:13 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
> >>>>> This patch introduces the core infrastructure for free page reporting in
> >>>>> virtual environments. It enables the kernel to track the free pages which
> >>>>> can be reported to its hypervisor so that the hypervisor could
> >>>>> free and reuse that memory as per its requirement.
> >>>>>
> >>>>> While the pages are getting processed in the hypervisor (e.g.,
> >>>>> via MADV_DONTNEED), the guest must not use them, otherwise, data loss
> >>>>> would be possible. To avoid such a situation, these pages are
> >>>>> temporarily removed from the buddy. The amount of pages removed
> >>>>> temporarily from the buddy is governed by the backend(virtio-balloon
> >>>>> in our case).
> >>>>>
> >>>>> To efficiently identify free pages that can to be reported to the
> >>>>> hypervisor, bitmaps in a coarse granularity are used. Only fairly big
> >>>>> chunks are reported to the hypervisor - especially, to not break up THP
> >>>>> in the hypervisor - "MAX_ORDER - 2" on x86, and to save space. The bits
> >>>>> in the bitmap are an indication whether a page *might* be free, not a
> >>>>> guarantee. A new hook after buddy merging sets the bits.
> >>>>>
> >>>>> Bitmaps are stored per zone, protected by the zone lock. A workqueue
> >>>>> asynchronously processes the bitmaps, trying to isolate and report pages
> >>>>> that are still free. The backend (virtio-balloon) is responsible for
> >>>>> reporting these batched pages to the host synchronously. Once reporting/
> >>>>> freeing is complete, isolated pages are returned back to the buddy.
> >>>>>
> >>>>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> >>> [...]
> >>>>> +}
> >>>>> +
> >>>>> +/**
> >>>>> + * __page_reporting_enqueue - tracks the freed page in the respective zone's
> >>>>> + * bitmap and enqueues a new page reporting job to the workqueue if possible.
> >>>>> + */
> >>>>> +void __page_reporting_enqueue(struct page *page)
> >>>>> +{
> >>>>> +       struct page_reporting_config *phconf;
> >>>>> +       struct zone *zone;
> >>>>> +
> >>>>> +       rcu_read_lock();
> >>>>> +       /*
> >>>>> +        * We should not process this page if either page reporting is not
> >>>>> +        * yet completely enabled or it has been disabled by the backend.
> >>>>> +        */
> >>>>> +       phconf = rcu_dereference(page_reporting_conf);
> >>>>> +       if (!phconf)
> >>>>> +               return;
> >>>>> +
> >>>>> +       zone = page_zone(page);
> >>>>> +       bitmap_set_bit(page, zone);
> >>>>> +
> >>>>> +       /*
> >>>>> +        * We should not enqueue a job if a previously enqueued reporting work
> >>>>> +        * is in progress or we don't have enough free pages in the zone.
> >>>>> +        */
> >>>>> +       if (atomic_read(&zone->free_pages) >= phconf->max_pages &&
> >>>>> +           !atomic_cmpxchg(&phconf->refcnt, 0, 1))
> >>>> This doesn't make any sense to me. Why are you only incrementing the
> >>>> refcount if it is zero? Combining this with the assignment above, this
> >>>> isn't really a refcnt. It is just an oversized bitflag.
> >>> The intent for having an extra variable was to ensure that at a time only one
> >>> reporting job is enqueued. I do agree that for that purpose I really don't need
> >>> a reference counter and I should have used something like bool
> >>> 'page_hinting_active'. But with bool, I think there could be a possible chance
> >>> of race. Maybe I should rename this variable and keep it as atomic.
> >>> Any thoughts?
> >> You could just use a bitflag to achieve what you are doing here. That
> >> is the primary use case for many of the test_and_set_bit type
> >> operations. However one issue with doing it as a bitflag is that you
> >> have no way of telling that you took care of all requesters.
> > I think you are right, I might end up missing on certain reporting
> > opportunities in some special cases. Specifically when the pages which are
> > part of this new reporting request belongs to a section of the bitmap which
> > has already been scanned. Although, I have failed to reproduce this kind of
> > situation in an actual setup.
> >
> >>  That is
> >> where having an actual reference count comes in handy as you know
> >> exactly how many zones are requesting to be reported on.
> >
> > True.
> >
> >>>> Also I am pretty sure this results in the opportunity to miss pages
> >>>> because there is nothing to prevent you from possibly missing a ton of
> >>>> pages you could hint on if a large number of pages are pushed out all
> >>>> at once and then the system goes idle in terms of memory allocation
> >>>> and freeing.
> >>> I was looking at how you are enqueuing/processing reporting jobs for each zone.
> >>> I am wondering if I should also consider something on similar lines as having
> >>> that I might be able to address the concern which you have raised above. But it
> >>> would also mean that I have to add an additional flag in the zone_flags. :)
> >> You could do it either in the zone or outside the zone as yet another
> >> bitmap. I decided to put the flags inside the zone because there was a
> >> number of free bits there and it should be faster since we were
> >> already using the zone structure.
> > There are two possibilities which could happen while I am reporting:
> > 1. Another request might come in for a different zone.
> > 2. Another request could come in for the same zone and the pages belong to a
> >     section of the bitmap which has already been scanned.
> >
> > Having a per zone flag to indicate reporting status will solve the first
> > issue and to an extent the second as well. Having refcnt will possibly solve
> > both of them. What I am wondering about is that in my case I could easily
> > impact the performance negatively by performing more bitmap scanning.
> >
> >
>
> I realized that it may not be possible for me to directly adopt either refcnt
> or zone flags just because of the way I have page reporting setup right now.
>
> For now, I will just replace the refcnt with a bitflag as that should work
> for most of the cases.  Nevertheless, I will also keep looking for a better way.

If nothing else something you could consider is a refcnt for the
number of bits you have set in your bitfield. Then all you would need
to be doing is replace the cmpxchg with just a atomic_fetch_inc and
what you would need to do is have your worker thread track how many
bits it has cleared and subtract that from the refcnt at the end.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

