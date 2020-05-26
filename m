Return-Path: virtio-comment-return-1291-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <158956393696.246123.9443729217250549606.stgit@ahduyck-workstation>
 <158956398852.246123.13563550180731658368.stgit@ahduyck-workstation>
 <7558cc20-262b-ddc4-2442-e05f0b74b59d@redhat.com> <CAKgT0Ucx6nF9_e6+Qj-A6t_c5Mm1u-=kphAtF31bz9t8Oo+n6w@mail.gmail.com>
 <15d1908f-4137-8079-da20-e423721014c8@redhat.com> <CAKgT0UcvteBsvKa8TJFoOpXxXPDxqUPLwtqbfGj287g6_NAeYQ@mail.gmail.com>
 <be88b182-3e52-1244-a44c-f8db013ddcd9@redhat.com> <CAKgT0Uff+fJV1ZeDVysMWSZcRdUCAx5TwDw7DEMBKYO8kwu2dQ@mail.gmail.com>
 <e1a22ec8-3a90-8786-39d9-75f9477c442d@redhat.com>
In-Reply-To: <e1a22ec8-3a90-8786-39d9-75f9477c442d@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 26 May 2020 08:09:23 -0700
Message-ID: <CAKgT0Uf4XYGTPR3P5C=M3DZB1SaHZNXGdzY4C2Bwwi5PxuHSPQ@mail.gmail.com>
Subject: Re: [virtio-comment] [PATCH v2 1/3] content: Document balloon feature
 free page hints
Content-Type: text/plain; charset="UTF-8"
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Wang, Wei W" <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, May 20, 2020 at 1:24 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 19.05.20 23:00, Alexander Duyck wrote:
> > On Tue, May 19, 2020 at 9:09 AM David Hildenbrand <david@redhat.com> wrote:

[...]

> >>>>
> >>>> Let's think this through, what about this scenario:
> >>>>
> >>>> The device sets \field{free_page_hint_cmd_id} = X
> >>>> The driver starts reporting free pages (and reports all pages it has)
> >>>> 1. Sends X to start the windows
> >>>> 2. Sends all page hints (\field{free_page_hint_cmd_id} stays X)
> >>>> 3. Sends VIRTIO_BALLOON_CMD_ID_STOP to end the window
> >>>> The driver sets \field{free_page_hint_cmd_id} = DONE or STOP
> >>>>
> >>>> The guest can reuse the pages any time (triggered by the shrinker),
> >>>> especially, during 2, before the hypervisor even processed a hint
> >>>> request. It can happen that the guest reuses a page before the
> >>>> hypervisor processes the request and before
> >>>> \field{free_page_hint_cmd_id} changes.
> >>>>
> >>>> In QEMU, the double-bitmap magic makes sure that this is guaranteed to
> >>>> work IIRC.
> >>>>
> >>>> In that case, the page has to be migrated in that windows, the
> >>>> hypervisor must not modify the content.
> >>>
> >>> If by "reuse" you mean write to or reinitialize then that is correct.
> >>> All that is really happening is that any pages that are hinted have
> >>> the potential to be left behind with the original VM and not migrated
> >>> to the new one. We get the notification that the migration happened
> >>> when CMD_ID_DONE is passed to us. At that point the hinting is
> >>> complete and the device has no use for additional data.
> >>>
> >>> Instead of CMD_ID_STOP it probably would have made more sense to call
> >>> it something like CMD_ID_PAUSE or CMD_ID_HOLD as that is what it is
> >>> really doing. It is just temporarily holding the hints off while the
> >>> hypervisor synchronizes the dirty bits from the host.
> >>
> >> I think if migration fails, it will be left set to STOP. Guess we should
> >> specify that possibility somehow as well.
> >
> > Actually I think that is a bug in the QEMU implementation. We cannot
> > let that happen otherwise the guest is never going to let the memory
> > go. If we have to abort the migration we should be calling
> > virtio_balloon_free_page_done(), probably in response to something
> > like PRECOPY_NOTIFY_CLEANUP?
> >
> > The problem is I am not that familiar with the migration process
> > itself within QEMU so I am not sure which labels mean what in the
> > notifier, but we should be signaling DONE if we are either going to
> > abort the migration or if we completed it and are now on the new
> > system.
> >
>
> We are starting to see way too many issues in QEMU code that are hard to
> tackle.
>
> 1. The issue with hinted pages not being 0 or the old content when
> re-accessed, due to the way they are skipped during migration. MST
> called that a memory corruption and that this would be broken. Very hard
> to fix, maybe impossible.
>
> 2. Some cases (migration failing while we are only sending memory) not
> setting the status to DONE. The handling is just a mess.
>
> 3. Take a look at that asynchronous iothread handling.
> virtio_ballloon_get_free_page_hints(). I think you can trick it into
> doing nasty things while you are e.g., resetting the device. Also,
> virtio_ballloon_get_free_page_hints() will just busy-loop while waiting
> for requests. Just ugly. Also that block_iothread, just hard to grasp.
>
> Besides all the other issues I keep finding.
>
> At this point I'd just love to rip out the QEMU implement and let
> whoever wants to really have it try again. The Linux side seems to be in
> a better state.
>
> This feature is in an unmaintainable state in QEMU.
>
> @MST, is there something that speaks against ripping out the QEMU and
> Linux parts, documenting in the spec that this feature should not be used?

Have we mad a decision on this? I plan to resubmit my QEMU patch set
as I had a bug in patch 3 that needs to be addressed. I'm just
wondering if I should rebase on David's patches that fix free page
hinting, or if I should just replace the patch with one that removes
free page hinting?

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

