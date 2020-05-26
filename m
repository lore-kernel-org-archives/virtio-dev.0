Return-Path: virtio-comment-return-1290-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <158994007522.397236.7536927155973222190.stgit@ahduyck-workstation>
 <158994014779.397236.836253101843237605.stgit@ahduyck-workstation>
 <60278259-9a04-77ab-f96f-c13bc2ffb070@redhat.com> <CAKgT0UfixL+bE9_-vLqvU02DMJ_9UDXR0c1C4M9U6wmH57H9Eg@mail.gmail.com>
 <53e66faa-ed7f-f7c1-6284-1e2a6e63c936@redhat.com>
In-Reply-To: <53e66faa-ed7f-f7c1-6284-1e2a6e63c936@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 26 May 2020 07:50:59 -0700
Message-ID: <CAKgT0Uc2haPLSaQg6Jsp-qtAZWgJ9Dku1RMqOhzYNg52SMkQug@mail.gmail.com>
Subject: Re: [virtio-comment] [PATCH v3 2/3] content: Document balloon feature
 page poison
Content-Type: text/plain; charset="UTF-8"
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Wang, Wei W" <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, May 26, 2020 at 1:24 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 20.05.20 18:25, Alexander Duyck wrote:
> > On Wed, May 20, 2020 at 2:28 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 20.05.20 04:02, Alexander Duyck wrote:
> >>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>>
> >>> Page poison provides a way for the guest to notify the host of the content
> >>> expected to be found in pages when they are added back to the guest after
> >>> being discarded. The feature currently doesn't apply to the existing
> >>> balloon features, however it will apply to an upcoming feature, free page
> >>> reporting. Add documentation for the page poison feature describing the
> >>> basic functionality and requirements.
> >>>
> >>
> >> I would rephrase this, starting what it does *without* free page
> >> reporting (which is not "provides a way for the guest to notify ..."),
> >> and then eventually how this feature will also be used in the future as
> >> well with free page reporting.
> >
> > Below is a rewrite on this description. I'm thinking that we can
> > probably call out the advantage to free page reporting in a different
> > way. Basically with the page poison feature we know a few things about
> > the behavior and I have called them out in the new patch description:
> >
> > Page poison provides a way for the guest to notify the host that it is
> > initializing or poisoning freed pages with some specific poison value. As a
> > result of this we can infer a couple traits about the guest:
> >
> > 1. Free pages will contain a specific pattern within the guest.
> > 2. Modifying free pages from this value may cause an error in the guest.
> > 3. Pages will be immediately written to by the driver when deflated.
> >
> > There are currently no existing features that make use of this data. In the
> > upcoming feature free page reporting we will need to make use of this to
> > identify if we can evict pages from the guest without causing data
> > corruption.
> >
> > Add documentation for the page poison feature describing the basic
> > functionality and requirements.
> >

[...]

> >>> +
> >>> +If the guest is not initializing or poisoning freed pages it should reject
> >>
> >> Sometimes you use "write to pages after deflating", here you use "freed
> >> pages"
> >
> > So when I am referencing "freed pages" I am talking about all free
> > memory, while when I refer to "pages after deflating" I am talking
> > about pages coming out of the balloon.
> >
> > My thought is that there maybe be additional uses for "poison_val" be
> > to feed it into some future use other than just the balloon portion of
> > the deflation. Basically what this is telling us is that we could look
> > for a pattern of pages containing nothing but poison_val if we wanted
> > to do some sort of same page merging, or maybe define something to
> > optimize migration by defining a poison page similar to a zero page
> > that could be used to reduce migration overhead in the future.
> >
> >>> +the VIRTIO_BALLOON_F_PAGE_POISON feature.
> >>> +
> >>> +If VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the guest
> >>> +will place the expected poison value into the \field{poison_val}
> >>
> >> again, "expected" is misleading in the context of this patch only.
> >
> > I will rewrite this statement at follows:
> >   If VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the driver
> >   will place the initialization and/or poison value into the \field{poison_val}
> >   configuration field data.
> >
> > I think I might strengthen things a bit as well. In the driver
> > normative section I think I might add the following:
> >   The driver MUST initialize and/or poison the deflated pages with
> >   \field{poison_val} when they are reused by the driver.
> >
>
> Maybe simplify that whole "initialize and/or poison " handling across
> this patch to "initialize with \field{poison_val}" - if the
> initialization is used for poisoning or initialization doesn't matter
> from spec POV.
>
> In general looks good to me, I'll have another look at the full result.

Okay, I will go through and try to flush out the "and/or poison" in
favor of just calling out the initialization.

> Still wondering what to do with free page hinting ... in the meantime
> I'll have a look at free page reporting :)

The problem is it is already out there so I worry we wouldn't ever be
able to get rid of it. At most we could deprecate it, but we are still
stuck with it consuming bit resources and such.

Anyway I'll try to get another iteration of these patches out later today.

Thanks.

- Alex

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

