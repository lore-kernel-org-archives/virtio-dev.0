Return-Path: virtio-comment-return-1283-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <158994007522.397236.7536927155973222190.stgit@ahduyck-workstation>
 <158994014779.397236.836253101843237605.stgit@ahduyck-workstation> <60278259-9a04-77ab-f96f-c13bc2ffb070@redhat.com>
In-Reply-To: <60278259-9a04-77ab-f96f-c13bc2ffb070@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 20 May 2020 09:25:34 -0700
Message-ID: <CAKgT0UfixL+bE9_-vLqvU02DMJ_9UDXR0c1C4M9U6wmH57H9Eg@mail.gmail.com>
Subject: Re: [virtio-comment] [PATCH v3 2/3] content: Document balloon feature
 page poison
Content-Type: text/plain; charset="UTF-8"
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Wang, Wei W" <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, May 20, 2020 at 2:28 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 20.05.20 04:02, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > Page poison provides a way for the guest to notify the host of the content
> > expected to be found in pages when they are added back to the guest after
> > being discarded. The feature currently doesn't apply to the existing
> > balloon features, however it will apply to an upcoming feature, free page
> > reporting. Add documentation for the page poison feature describing the
> > basic functionality and requirements.
> >
>
> I would rephrase this, starting what it does *without* free page
> reporting (which is not "provides a way for the guest to notify ..."),
> and then eventually how this feature will also be used in the future as
> well with free page reporting.

Below is a rewrite on this description. I'm thinking that we can
probably call out the advantage to free page reporting in a different
way. Basically with the page poison feature we know a few things about
the behavior and I have called them out in the new patch description:

Page poison provides a way for the guest to notify the host that it is
initializing or poisoning freed pages with some specific poison value. As a
result of this we can infer a couple traits about the guest:

1. Free pages will contain a specific pattern within the guest.
2. Modifying free pages from this value may cause an error in the guest.
3. Pages will be immediately written to by the driver when deflated.

There are currently no existing features that make use of this data. In the
upcoming feature free page reporting we will need to make use of this to
identify if we can evict pages from the guest without causing data
corruption.

Add documentation for the page poison feature describing the basic
functionality and requirements.

[...]

> > diff --git a/content.tex b/content.tex
> > index 816b6c1b052e..89e9948b7399 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -5026,6 +5026,9 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
> >      page hinting. A virtqueue for providing hints as to what memory is
> >      currently free is present. Configuration field \field{free_page_hint_cmd_id}
> >      is valid.
> > +\item[ VIRTIO_BALLOON_F_PAGE_POISON(4) ] The device has to be notified if
> > +    the driver is expecting balloon pages to contain a certain value when
> > +    returned. Configuration field poison_val is valid.
>
> That's not what it does in the context of this feature only, no?
>
> "A hint to the device, that the driver might immediately write
> \field{poison_val} to pages after deflating them. Configuration field
> \field{poison_val} is valid."

I'll probably just use this wording with a few slight tweaks. Thinking
about it though I will get rid of "might" and replace it with "will".
In the case of the page poison feature we expect the driver must be
poisoning the pages, it shouldn't be an optional thing that "might"
happen.

> >
> >  \end{description}
> >
> > @@ -5033,6 +5036,9 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
> >  The driver SHOULD accept the VIRTIO_BALLOON_F_MUST_TELL_HOST
> >  feature if offered by the device.
> >
> > +The driver SHOULD clear the VIRTIO_BALLOON_F_PAGE_POISON flag if it is not
> > +expecting any specific value to be stored in the page.
>
> That's not what it does in the context of this feature only, no?
>
> "The driver SHOULD clear the VIRTIO_BALLOON_F_PAGE_POISON flag if it is
> not immediately write \field{poison_val} to deflated pages (e.g., to
> initialize them, or fill them with a poison value)." ?

Again I will probably reuse this but with a slight tweak to "if it
will not immediately write" instead of using the "is".

[...]

> > @@ -5473,6 +5486,37 @@ \subsubsection{Free Page Hinting}\label{sec:Device Types / Memory Balloon Device
> >  \field{free_page_hint_cmd_id} once it no longer has need for the
> >  previously hinted pages.
> >
> > +\subsubsection{Page Poison}\label{sec:Device Types / Memory Balloon Device / Device Operation / Page Poison}
> > +
> > +Page Poison provides a way to notify the host that the guest is initializing
> > +and/or poisoning free pages. When the feature is enabled pages that are
>
> s/enabled/enabled, /
>
> > +deflated might be immediately written to by the guest.
>
> "pages might immediately get written to by the driver after deflating." ?

Again I will probably use this wording, but replace "might" with "will".

> > +
> > +If the guest is not initializing or poisoning freed pages it should reject
>
> Sometimes you use "write to pages after deflating", here you use "freed
> pages"

So when I am referencing "freed pages" I am talking about all free
memory, while when I refer to "pages after deflating" I am talking
about pages coming out of the balloon.

My thought is that there maybe be additional uses for "poison_val" be
to feed it into some future use other than just the balloon portion of
the deflation. Basically what this is telling us is that we could look
for a pattern of pages containing nothing but poison_val if we wanted
to do some sort of same page merging, or maybe define something to
optimize migration by defining a poison page similar to a zero page
that could be used to reduce migration overhead in the future.

> > +the VIRTIO_BALLOON_F_PAGE_POISON feature.
> > +
> > +If VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the guest
> > +will place the expected poison value into the \field{poison_val}
>
> again, "expected" is misleading in the context of this patch only.

I will rewrite this statement at follows:
  If VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the driver
  will place the initialization and/or poison value into the \field{poison_val}
  configuration field data.

I think I might strengthen things a bit as well. In the driver
normative section I think I might add the following:
  The driver MUST initialize and/or poison the deflated pages with
  \field{poison_val} when they are reused by the driver.

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

