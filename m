Return-Path: virtio-dev-return-7164-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BE5F09860A0
	for <virtio-dev@lists.oasis-open.org>; Fri, 24 Apr 2020 16:09:38 +0000 (UTC)
MIME-Version: 1.0
References: <20200422181649.12258.37077.stgit@localhost.localdomain>
 <20200422182127.12258.26300.stgit@localhost.localdomain> <a2183a2f-e10d-1e19-52d9-a9cd71fa2655@redhat.com>
 <CAKgT0Ud1WVUV5VNCCBqJtYPSLCZTq5oXGUyvqHmXdnTQUko6qQ@mail.gmail.com> <6f7f970f-9188-726e-39da-6e0954ab9fdf@redhat.com>
In-Reply-To: <6f7f970f-9188-726e-39da-6e0954ab9fdf@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 24 Apr 2020 09:09:26 -0700
Message-ID: <CAKgT0Ueg=oJpxXj2m9hpV8V7v75VcByhsWH3Vz1_-tRuJ3MtFQ@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v21 QEMU 5/5] virtio-balloon: Provide an interface for
 free page reporting
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Apr 24, 2020 at 8:34 AM David Hildenbrand <david@redhat.com> wrote:
>
>
> >> Also, I do wonder if we want to default-enable it. It can still have a
> >> negative performance impact and some people might not want that.
> >
> > The negative performance impact should be minimal. At this point the
> > hinting process ends up being very light since it only processes a
> > small chunk of the memory before it shuts down for a couple seconds.
> > In my original data the only time any significant performance
> > regression was seen was with page shuffling enabled, and that was
> > before I put limits on how many pages we could process per pass and
> > how frequently we would make a pass through memory. My thought is that
> > we are much better having it enabled by default rather than having it
> > disabled by default. In the worst case scenario we have a little bit
> > of extra thread noise from it popping up running for a few
> > milliseconds and then sleeping for about two seconds, but the benefit
> > side is that the VMs will do us a favor and restrict themselves to a
> > much smaller idle footprint until such time as the memory is actually
> > needed in the guest.
>
> While I agree that the impact is small, there *is* a noticeable
> performance impact. One of the main users is memory overcommit.
>
> Also, imagine the following scenarios:
> - RT workload in the guest. Just because you have a virtio-balloon
>   device defined would mean something is suddenly active and
>   discarding/trying to discard pages.
> - vfio: free page reporting is completely useless right now and
>   *only* overhead.
> - prealloc does not expect that pages get suddenly discarded
> - s390x, which has CMM and might not benefit at all (except when using
>   huge pages as backing storage)
>
> No, I don't think it's acceptable to enable this as default. I remember
> that it is quite common to just define a balloon device but never use it.
>
> E.g., "A virtual memory balloon device is added to all Xen and KVM/QEMU
> guest virtual machines. It will be seen as <memballoon> element" [1].
>
> I think we should let upper layers decide (just as we do for free page
> hinting, for example).

Okay. I guess there are a number of other cases I hand't thought of. I
will switch the default to false.

Thanks.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

