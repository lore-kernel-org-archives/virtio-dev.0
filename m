Return-Path: virtio-dev-return-7488-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A3856985F77
	for <virtio-dev@lists.oasis-open.org>; Thu, 18 Jun 2020 19:45:56 +0000 (UTC)
MIME-Version: 1.0
References: <20200527041212.12700.60627.stgit@localhost.localdomain>
 <20200527041414.12700.50293.stgit@localhost.localdomain> <CAKgT0UdPC1s0c-wqsNc4x8DeZhtZQVMmLArWQ=Z345Mkof650Q@mail.gmail.com>
 <4f37c184-cf62-5711-a737-925533b52d73@redhat.com> <CAKgT0Udmxjx66hEhDyqWS1wBkAfEf_hht8FZAOuh3NMDOAOR3w@mail.gmail.com>
 <aea3b6e6-f653-dd0c-5e17-d0c948a6af4b@redhat.com> <20200618120121-mutt-send-email-mst@kernel.org>
 <1ee4f06d-f0bb-4155-ee82-1d56c346e2a0@redhat.com>
In-Reply-To: <1ee4f06d-f0bb-4155-ee82-1d56c346e2a0@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 18 Jun 2020 12:45:43 -0700
Message-ID: <CAKgT0UfgyVyfLSg1dZejUR0g6znijY+dRyW_TAFJMZU+qXK+UQ@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v25 QEMU 3/3] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
Content-Type: text/plain; charset="UTF-8"
To: David Hildenbrand <david@redhat.com>, "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jun 18, 2020 at 10:10 AM David Hildenbrand <david@redhat.com> wrote:
>
> >>
> >> Ugh, ...
> >>
> >> @MST, you might have missed that in another discussion, what's your
> >> general opinion about removing free page hinting in QEMU (and Linux)? We
> >> keep finding issues in the QEMU implementation, including non-trivial
> >> ones, and have to speculate about the actual semantics. I can see that
> >> e.g., libvirt does not support it yet.
> >
> > Not maintaining two similar features sounds attractive.

Agreed. Just to make sure we are all on the same page I am adding Wei
Wang since he was the original author for page hinting.

> I consider free page hinting (in QEMU) to be in an unmaintainable state
> (and it looks like Alex and I are fixing a feature we don't actually
> intend to use / not aware of users). In contrast to that, the free page
> reporting functionality/implementation is a walk in the park.
>
> >
> > I'm still trying to get my head around the list of issues.  So far they
> > all look kind of minor to me.  Would you like to summarize them
> > somewhere?
>
> Some things I still have in my mind
>
>
> 1. If migration fails during RAM precopy, the guest will never receive a
> DONE notification. Probably easy to fix.

Agreed. It is just a matter of finding the right point to add a hook
so that if we abort the migration we can report DONE.

> 2. Unclear semantics. Alex tried to document what the actual semantics
> of hinted pages are. Assume the following in the guest to a previously
> hinted page
>
> /* page was hinted and is reused now */
> if (page[x] != Y)
>         page[x] == Y;
> /* migration ends, we now run on the destination */
> BUG_ON(page[x] != Y);
> /* BUG, because the content chan
>
> A guest can observe that. And that could be a random driver that just
> allocated a page.
>
> (I *assume* in Linux we might catch that using kasan, but I am not 100%
> sure, also, the actual semantics to document are unclear - e.g., for
> other guests)
>
> As Alex mentioned, it is not even guaranteed in QEMU that we receive a
> zero page on the destination, it could also be something else (e.g.,
> previously migrated values).

So this is only an issue for pages that are pushed out of the balloon
as a part of the shrinker process though. So fixing it would be pretty
straightforward as we would just have to initialize or at least dirty
pages that are leaked as a part of the shrinker. That may have an
impact on performance though as it would result in us dirtying pages
that are freed as a result of the shrinker being triggered.

> 3. If I am not wrong, the iothread works in
> virtio_ballloon_get_free_page_hints() on the virtqueue only with holding
> the free_page_lock (no BQL).
>
> Assume we're migrating, the iothread is active, and the guest triggers a
> device reset.
>
> virtio_balloon_device_reset() will trigger a
> virtio_balloon_free_page_stop(s). That won't actually wait for the
> iothread to stop, it will only temporarily lock free_page_lock and
> update s->free_page_report_status.
>
> I think there can be a race between the device reset and the iothread.
> Once virtio_balloon_free_page_stop() returned,
> virtio_ballloon_get_free_page_hints() can still call
> - virtio_queue_set_notification(vq, 0);
> - virtio_queue_set_notification(vq, 1);
> - virtio_notify(vdev, vq);
> - virtqueue_pop()
>
> I doubt this is very nice.

And our conversation had me start looking though reference to
virtio_balloon_free_page_stop. It looks like we call it for when we
unrealize the device or reset the device. It might make more sense for
us to look at pushing the status to DONE and forcing the iothread to
be flushed out.

> There are other concerns I had regarding the iothread (e.g., while
> reporting is active, virtio_ballloon_get_free_page_hints() is
> essentially a busy loop, in contrast to documented -
> continue_to_get_hints will always be true).
>
> > The appeal of hinting is that it's 0 overhead outside migration,
> > and pains were taken to avoid keeping pages locked while
> > hypervisor is busy.
> >
> > If we are to drop hinting completely we need to show that reporting
> > can be comparable, and we'll probably want to add a mode for
> > reporting that behaves somewhat similarly.
>
> Depends on the actual users. If we're dropping a feature that nobody is
> actively using, I don't think we have to show anything.
>
> This feature obviously saw no proper review.

I'm pretty sure it had some, as it went through several iterations as
I recall. However I don't think the review of the virtio interface was
very detailed as I think most of the attention was on the kernel
interface.

As far as trying to do this with page reporting it would be doable,
but I would need to use something like the command interface so that I
would have a way to tell the driver when to drop the reported bit from
the pages and when to stop/resume hinting. However it still wouldn't
resolve the issue of copy on write style pages where the page is only
read and never updated. I honestly wonder if it wouldn't be better to
just apply the same logic that I have been doing with page reporting
and migrate a zero page for a hinted page and MADVISE the page away so
that it should be zero on the origin. Then you get the benefit of the
guest shrinking as you perform the migration and would only be
transmitting zero pages to the other side which should be
significantly smaller if I am not mistaken.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

