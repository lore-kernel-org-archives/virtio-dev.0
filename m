Return-Path: virtio-dev-return-7505-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5CFF2985F8C
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 Jun 2020 14:56:59 +0000 (UTC)
Date: Wed, 24 Jun 2020 10:56:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200624103559-mutt-send-email-mst@kernel.org>
References: <20200527041212.12700.60627.stgit@localhost.localdomain>
 <20200527041414.12700.50293.stgit@localhost.localdomain>
 <CAKgT0UdPC1s0c-wqsNc4x8DeZhtZQVMmLArWQ=Z345Mkof650Q@mail.gmail.com>
 <4f37c184-cf62-5711-a737-925533b52d73@redhat.com>
 <CAKgT0Udmxjx66hEhDyqWS1wBkAfEf_hht8FZAOuh3NMDOAOR3w@mail.gmail.com>
 <aea3b6e6-f653-dd0c-5e17-d0c948a6af4b@redhat.com>
 <20200618120121-mutt-send-email-mst@kernel.org>
 <1ee4f06d-f0bb-4155-ee82-1d56c346e2a0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1ee4f06d-f0bb-4155-ee82-1d56c346e2a0@redhat.com>
Subject: [virtio-dev] Re: [PATCH v25 QEMU 3/3] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: David Hildenbrand <david@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jun 18, 2020 at 07:10:43PM +0200, David Hildenbrand wrote:
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
> 
> I consider free page hinting (in QEMU) to be in an unmaintainable state
> (and it looks like Alex and I are fixing a feature we don't actually
> intend to use / not aware of users). In contrast to that, the free page
> reporting functionality/implementation is a walk in the park.

So at the high level the idea was simple, we just clear the dirty bit
when page is hinted, unless we sent a new command since. Implementation
was reviewed by migration maintainers. If there's a consensus the code
is written so badly we can't maintain it, maybe we should remove it.
Which parts are unmaintainable in your eyes - migration or virtio ones?
Or maybe it's the general thing that interface was never specced
properly.

> > 
> > I'm still trying to get my head around the list of issues.  So far they
> > all look kind of minor to me.  Would you like to summarize them
> > somewhere?
> 
> Some things I still have in my mind

Thanks for the summary!

> 
> 1. If migration fails during RAM precopy, the guest will never receive a
> DONE notification. Probably easy to fix.
> 
> 2. Unclear semantics. Alex tried to document what the actual semantics
> of hinted pages are.

I'll reply to that now.

> Assume the following in the guest to a previously
> hinted page
> 
> /* page was hinted and is reused now */
> if (page[x] != Y)
> 	page[x] == Y;
> /* migration ends, we now run on the destination */
> BUG_ON(page[x] != Y);
> /* BUG, because the content chan

The assumption hinting makes is that data in page is writtent to before it's used.


> A guest can observe that. And that could be a random driver that just
> allocated a page.
> 
> (I *assume* in Linux we might catch that using kasan, but I am not 100%
> sure, also, the actual semantics to document are unclear - e.g., for
> other guests)

I think it's basically simple: hinting means it's ok to
fill page with trash unless it has been modified since the command
ID supplied.

> As Alex mentioned, it is not even guaranteed in QEMU that we receive a
> zero page on the destination, it could also be something else (e.g.,
> previously migrated values).


Absolutely.

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

Reset is notoriously hard to get right.

> There are other concerns I had regarding the iothread (e.g., while
> reporting is active, virtio_ballloon_get_free_page_hints() is
> essentially a busy loop, in contrast to documented -
> continue_to_get_hints will always be true).

So that would be a performance issue you are suggesting, right?

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


I don't know how to find out. So far it doesn't look like we found
any common data corruptions that would indicate no one can use it safely.
Races around reset aren't all that uncommon but I don't think that
qualifies as a deal breaker.

I find the idea of asynchronously sending hints to host without
waiting for them to be processed intriguing. Not something
I'd work on implementing if we had reporting originally,
but since it's there I'm not sure we should just discard it
at this point.

> This feature obviously saw no proper review.

I did my best but obviously missed some things.

> -- 
> Thanks,
> 
> David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

