Return-Path: virtio-dev-return-7083-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C3695986014
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Apr 2020 18:21:17 +0000 (UTC)
MIME-Version: 1.0
References: <CAKgT0UcaBfyKdTPErOxxLJgShOaJNfo9Maqps0ufABMbAo0iuQ@mail.gmail.com>
 <EDD25A47-8A8D-4F9B-9875-B983A1BA72C2@redhat.com> <CAKgT0Uf9a8K50XAS9K39KxBGdNRd5+G7nmkg2PsCHOYHAZ7Xew@mail.gmail.com>
 <f685fa75-6898-4fbe-c2a1-ba35424cb4a2@redhat.com> <20200416102229-mutt-send-email-mst@kernel.org>
 <5df12fd8-da98-dd3c-04ef-740189bc48ea@redhat.com>
In-Reply-To: <5df12fd8-da98-dd3c-04ef-740189bc48ea@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 16 Apr 2020 11:21:05 -0700
Message-ID: <CAKgT0UeVi=xnNxaVE5vB44rDwR4-m305wE671VdaK6R2TM6KGw@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v19 QEMU 1/4] virtio-balloon: Implement support for page
 poison tracking feature
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, "Wang, Wei W" <wei.w.wang@intel.com>, David Hildenbrand <dhildenb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Apr 16, 2020 at 7:55 AM David Hildenbrand <david@redhat.com> wrote:
>
> >> We should document our result of page poisoning, free page hinting, an=
d
> >> free page reporting there as well. I hope you'll have time for the lat=
ter.
> >>
> >> ----------------------------------------------------------------------=
---
> >> Semantics of VIRTIO_BALLOON_F_PAGE_POISON
> >> ----------------------------------------------------------------------=
---
> >>
> >> "The VIRTIO_BALLOON_F_PAGE_POISON feature bit is used to indicate if t=
he
> >> guest is using page poisoning. Guest writes to the poison_val config
> >> field to tell host about the page poisoning value that is in use."
> >> -> Very little information, no signs about what has to be done.
> >
> > I think it's an informational field. Knowing that free pages
> > are full of a specific pattern can be handy for the hypervisor
> > for a variety of reasons. E.g. compression/deduplication?
>
> I was referring to the documentation of the feature and what we
> (hypervisor) are expected to do (in regards to inflation/deflation).
>
> Yes, it might be valuable to know that the guest is using poisoning. I
> assume compression/deduplication (IOW KSM) will figure out themselves
> that such pages are equal.

The other thing to keep in mind is that the poison value only really
comes into play with hinting/reporting. In the case of the standard
balloon the pages are considered allocated from the guest's
perspective until the balloon is deflated. Then any poison/init will
occur over again anyway so I don't think the standard balloon should
really care.

For hinting it somewhat depends. Currently the implementation is
inflating a balloon so having poisoning or init_on_free means it is
written to immediately after it is freed so it defeats the purpose of
the hinting. However that is a Linux implementation issue, not
necessarily an issue with the QEMU implementation. As such may be I
should fix that in the Linux driver since that has been ignored in
QEMU up until now anyway. The more interesting bit is what should the
behavior be from the hypervisor when a page is marked as being hinted.
I think right now the behavior is to just not migrate the page. I
wonder though if we shouldn't instead just consider the page a zero
page, and then maybe modify the zero page behavior for the case where
we know page poisoning is enabled.

For reporting it is a matter of tracking the contents. We don't want
to modify the contents in any way as we are attempting to essentially
do in-place tracking of the page. So if it is poisoned or initialized
it needs to stay in that state so we cannot invalidate the page if
doing so will cause it to lose state information.

> >> "Let the hypervisor know that we are expecting a specific value to be
> >> written back in balloon pages."
> >
> >
> >
> >> -> Okay, that talks about "balloon pages", which would include right n=
ow
> >> -- pages "inflated" and then "deflated" using free page hinting
> >> -- pages "inflated" and then "deflated" using oridnary inflate/deflate
> >>    queue
> >
> > ATM, in this case driver calls "free" and that fills page with the
> > poison value.
>
> Yes, that's what I mentioned somehwere, it's currently done by Linux and =
...
>
> >
> > It might be a valid optimization to allow driver to skip
> > poisoning of freed pages in this case.
>
> ... we should prepare for that :)

Agreed.

> >
> >> And I would add
> >>
> >> "However, if the inflated page was not filled with "poison_val" when
> >> inflating, it's not predictable if the original page or a page filled
> >> with "poison_val" is returned."
> >>
> >> Which would cover the "we did not discard the page in the hypervisor, =
so
> >> the original page is still there".
> >>
> >>
> >> We should also document what is expected to happen if "poison_val" is
> >> suddenly changed by the guest at one point in time again. (e.g., not
> >> supported, unexpected things can happen, etc.)
> >
> > Right. I think we should require that this can only be changed
> > before features have been negotiated.
> > That is the only point where hypervisor can still fail
> > gracefully (i.e. fail FEATURES_OK).
>
> Agreed.

I believe that is the current behavior. Essentially if poisoning
enabled then the feature flag is left set. I think the one change I
will make in the driver is that if poisoning is enabled in the kernel,
but PAGE_POISON is not available as a feature, I am going to disable
both the reporting and hinting features in virtballoon_validate.

> I can totally understand if Alex would want to stop working on
> VIRTIO_BALLOON_F_PAGE_POISON at this point and only fix the guest to not
> enable free page reporting in case we don't have
> VIRTIO_BALLOON_F_PAGE_POISON (unless that's already done), lol. :)

I already have a patch for that.

The bigger issue is how to deal with the PAGE_POISON being enabled
with FREE_PAGE_HINTING. The legacy code at this point is just broken
and is plowing through with FREE_PAGE_HINTING while it is enabled.
That is safe for now because it is using a balloon, the side effect is
that it is going to defer migration. If it switches to a page
reporting type setup at some point in the future we would need to make
sure something is written to the other end to identify the poison/zero
pages.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

