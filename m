Return-Path: virtio-dev-return-7511-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A1598985A85
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 Jun 2020 20:36:45 +0000 (UTC)
Date: Wed, 24 Jun 2020 16:36:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200624163604-mutt-send-email-mst@kernel.org>
References: <CAKgT0UdPC1s0c-wqsNc4x8DeZhtZQVMmLArWQ=Z345Mkof650Q@mail.gmail.com>
 <4f37c184-cf62-5711-a737-925533b52d73@redhat.com>
 <CAKgT0Udmxjx66hEhDyqWS1wBkAfEf_hht8FZAOuh3NMDOAOR3w@mail.gmail.com>
 <aea3b6e6-f653-dd0c-5e17-d0c948a6af4b@redhat.com>
 <20200618120121-mutt-send-email-mst@kernel.org>
 <1ee4f06d-f0bb-4155-ee82-1d56c346e2a0@redhat.com>
 <20200624103559-mutt-send-email-mst@kernel.org>
 <a7daa26d-52a2-4834-9cf1-7bdc457e686f@redhat.com>
 <20200624113417-mutt-send-email-mst@kernel.org>
 <dd2431be-fd22-9307-51e4-b081026f6315@redhat.com>
MIME-Version: 1.0
In-Reply-To: <dd2431be-fd22-9307-51e4-b081026f6315@redhat.com>
Subject: [virtio-dev] Re: [PATCH v25 QEMU 3/3] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: David Hildenbrand <david@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jun 24, 2020 at 06:01:02PM +0200, David Hildenbrand wrote:
> On 24.06.20 17:37, Michael S. Tsirkin wrote:
> > On Wed, Jun 24, 2020 at 05:28:59PM +0200, David Hildenbrand wrote:
> >>> So at the high level the idea was simple, we just clear the dirty bit
> >>> when page is hinted, unless we sent a new command since. Implementation
> >>> was reviewed by migration maintainers. If there's a consensus the code
> >>> is written so badly we can't maintain it, maybe we should remove it.
> >>> Which parts are unmaintainable in your eyes - migration or virtio ones?
> >>
> >> QEMU implementation without a propert virtio specification. I hope that
> >> we can *at least* finally document the expected behavior. Alex gave it a
> >> shot, and I was hoping that Wei could jump in to clarify, help move this
> >> forward ... after all he implemented (+designed?) the feature and the
> >> virtio interface.
> >>
> >>> Or maybe it's the general thing that interface was never specced
> >>> properly.
> >>
> >> Yes, a spec would be definitely a good starter ...
> >>
> >> [...]
> >>
> >>>>
> >>>> 1. If migration fails during RAM precopy, the guest will never receive a
> >>>> DONE notification. Probably easy to fix.
> >>>>
> >>>> 2. Unclear semantics. Alex tried to document what the actual semantics
> >>>> of hinted pages are.
> >>>
> >>> I'll reply to that now.
> >>>
> >>>> Assume the following in the guest to a previously
> >>>> hinted page
> >>>>
> >>>> /* page was hinted and is reused now */
> >>>> if (page[x] != Y)
> >>>> 	page[x] == Y;
> >>>> /* migration ends, we now run on the destination */
> >>>> BUG_ON(page[x] != Y);
> >>>> /* BUG, because the content chan
> >>>
> >>> The assumption hinting makes is that data in page is writtent to before it's used.
> >>>
> >>>
> >>>> A guest can observe that. And that could be a random driver that just
> >>>> allocated a page.
> >>>>
> >>>> (I *assume* in Linux we might catch that using kasan, but I am not 100%
> >>>> sure, also, the actual semantics to document are unclear - e.g., for
> >>>> other guests)
> >>>
> >>> I think it's basically simple: hinting means it's ok to
> >>> fill page with trash unless it has been modified since the command
> >>> ID supplied.
> >>
> >> Yeah, I quite dislike the semantics, especially, as they are different
> >> to well-know semantics as e.g., represent in MADV_FREE. Getting changed
> >> content when reading is really weird. But it seemed to be easier to
> >> implement (low hanging fruit) and nobody complained back then. Well, now
> >> we are stuck with it.
> >>
> >> [..]
> > 
> > The difference with MADV_FREE is
> > - asynchronous (using cmd id to synchronize)
> > - zero not guaranteed
> > 
> > right?
> 
> *looking into man page*, yes, when reading you either get the old
> content or zero.
> 
> (I remember that a re-read also makes the content stable, but looks like
> you really have to write to a page)
> 
> We should most probably do what Alex suggested and initialize pages (at
> least write a single byte) when leaking them from the shrinker in the
> guest while hinting is active, such that the content is stable for
> anybody to allocate and reuse a page.

Drivers ignore old content from slab though, so I don't really see
the point.

> -- 
> Thanks,
> 
> David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

