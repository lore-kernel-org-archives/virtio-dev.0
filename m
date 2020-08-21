Return-Path: virtio-comment-return-1422-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <159777170579.321346.6847340295291298122.stgit@ahduyck-workstation>
 <159777196068.321346.13474880755639133891.stgit@ahduyck-workstation> <de287e27-2307-eb30-c79b-4621abb51b1b@redhat.com>
In-Reply-To: <de287e27-2307-eb30-c79b-4621abb51b1b@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 21 Aug 2020 14:27:36 -0700
Message-ID: <CAKgT0Udx=XhZ69UfxO9+ZOjQ3339fpBm9pG45VtizYTLWu2NYw@mail.gmail.com>
Subject: Re: [virtio-comment] [PATCH RESEND v6 2/3] content: Document balloon
 feature page poison
Content-Type: text/plain; charset="UTF-8"
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Wang, Wei W" <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Aug 21, 2020 at 11:24 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 18.08.20 19:32, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

<snip>

> > +\devicenormative{\paragraph}{Page Poison}{Device Types / Memory Balloon Device / Device Operation / Page Poison}
> > +
> > +Normative statements in this section apply if the
> > +VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated.
> > +
> > +The device MAY use the content of \field{poison_val} as a hint to guest
> > +behavior.
> > +>>>>>>> patched
>
> ^ looks strange

Yeah, this must have been a merge conflict that didn't get sorted
correctly. I will fix and submit a v7 next week with your
"Reviewed-by" included.

> Apart from that
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
>
> Thanks!

Thanks for taking the time to review this. I will push v7 out on
Monday and ask for a vote for inclusion.

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

