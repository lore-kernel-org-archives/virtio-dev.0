Return-Path: virtio-comment-return-1271-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <158956393696.246123.9443729217250549606.stgit@ahduyck-workstation>
 <158956398852.246123.13563550180731658368.stgit@ahduyck-workstation>
 <7558cc20-262b-ddc4-2442-e05f0b74b59d@redhat.com> <CAKgT0Ucx6nF9_e6+Qj-A6t_c5Mm1u-=kphAtF31bz9t8Oo+n6w@mail.gmail.com>
 <15d1908f-4137-8079-da20-e423721014c8@redhat.com>
In-Reply-To: <15d1908f-4137-8079-da20-e423721014c8@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 19 May 2020 08:34:50 -0700
Message-ID: <CAKgT0UcvteBsvKa8TJFoOpXxXPDxqUPLwtqbfGj287g6_NAeYQ@mail.gmail.com>
Subject: Re: [virtio-comment] [PATCH v2 1/3] content: Document balloon feature
 free page hints
Content-Type: text/plain; charset="UTF-8"
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Wang, Wei W" <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, May 19, 2020 at 2:40 AM David Hildenbrand <david@redhat.com> wrote:
>
> [...]
> >>> +\begin{description}
> >>> +\item[VIRTIO_BALLOON_CMD_ID_STOP (0)] Any command ID previously supplied by
> >>> +  the device is invalid. The driver should halt all hinting until a new
> >>> +  command ID is supplied.
> >>
> >> Maybe "The driver should stop hinting free pages, but should not reuse
> >> all previously hinted pages."
> >
> > The "reuse all previously hinted pages" seems rather unclear to me. I
> > would like to make clear that in this case the "use" is the guest
> > making use of the memory, not the driver doing something like
> > recycling hints. So in the spots where you reference "the driver
>
> IMHO, In term of use/reuse, I think it does not matter. From spec POV,
> whatever happens in the guest in respect to hinting is under driver
> control. The driver just has to find a way that the memory won't be reused.

My only complaint about the use/reuse term is that when it was
previously employed it was to describe things in relation to a
balloon. So you would "use/reuse a page from the balloon" which
implied removing it. Without the balloon terminology it becomes much
more vague as "use" could mean many different things when the page
might be left on the guest already.

> > reusing pages" I think I might prefer to go with something along the
> > lines of "releasing pages for use by the guest". The problem is that
> > when you have a balloon we were referencing using pages from the
> > balloon. Since we cannot reference the balloon I figure I will go with
> > language where we "supply" and "release" hinted pages. That way we
> > acknowledge that the driver is holding onto pages and not freeing them
> > for use by the guest.
> >
> > I'll probably go with something like:
> >   The driver should stop hinting free pages, but
> >   should not release any hinted pages for use by the guest.
> >
>
> I'd say "release any hinted pages" is an implementation detail in the
> guest to make sure the pages won't be reused. But I don't have a strong
> opinion here as long as it helps to describe what has to be done :)

Well the wording here is "should not" which implies that not releasing
the pages is optional but recommended. The problem with releasing the
pages is that without something like the page reporting code I did for
the Linux kernel the guest would end up having to hint all the pages
again to get to where it was before.

>
> >>> +
> >>> +The driver SHOULD return pages for use once \field{free_page_hint_cmd_id}
> >>> +reports a value of VIRTIO_BALLOON_CMD_ID_DONE.
> >>
> >> "return pages" -> "start to reuse all previously hinted pages".
> >
> > The driver SHOULD release all hinted pages for use by the guest once
> > \field{free_page_hint_cmd_id} reports a value of VIRTIO_BALLOON_CMD_ID_DONE.
> >
> >> Also,
> >>
> >> "The driver MUST reinitialize hinted pages before reusing them."
> >
> > That isn't quite correct though. It is only necessary to initialize
> > the pages if the guest depends on them being initialized.
> >
> > Maybe something like:
> >   The driver MUST treat the content of all hinted pages as uninitialized memory.
> >
>
> Makes sense.
>
> >>> +
> >>> +\devicenormative{\paragraph}{Free Page Hinting}{Device Types / Memory Balloon Device / Device Operation / Free Page Hinting}
> >>> +
> >>> +Normative statements in this section apply if the
> >>> +VIRTIO_BALLOON_F_FREE_PAGE_HINT feature has been negotiated.
> >>> +
> >>> +The device MUST set \field{free_page_hint_cmd_id} to
> >>> +VIRTIO_BALLOON_CMD_ID_STOP any time that the dirty pages for the given
> >>> +guest are being recorded.
> >>> +
> >>> +The device MUST NOT reuse a command ID until it has received an output
> >>> +descriptor containing VIRTIO_BALLOON_CMD_ID_STOP from the driver.
> >>> +
> >>> +The device MUST ignore pages that are provided with a command ID that does
> >>> +not match the current value in \field{free_page_hint_cmd_id}.
> >>> +
> >>> +The device MAY modify the contents of the page in the balloon if the page
> >>> +has not been modified by the guest since the \field{free_page_hint_cmd_id}
> >>> +associated with the hint was issued by the device.
> >>
> >> "page in the balloon" -> "previously hinted pages"
> >>
> >> But it's not that easy in respect to the guest reusing the pages.
> >>
> >> "previously hinted pages and not reused pages" ?
> >>
> >> Also, something like
> >>
> >> "The device MUST NOT modify the contents of previously hinted pages in
> >> case they are reused by the devices, even if they are reused by the
> >> driver before the hinting request is processed."
> >
> > That is not quite true.
>
> I proposed that the driver MUST reinitialize the pages when reusing
> (which is what Linux does), so then this is true. Reuse implies
> initializing, implies modification. It's somewhat simpler than what you
> propose, leaving the case open where the driver would reuse pages by
> only reading them (I don't really see a use case for that ...). But I
> don't care as long as it's consistent and correct :)

Linux does not reinitialize the pages when it frees them. That only
happens if poison or init_on_free are enabled which are rare cases.
When it does reinitialize the pages then I agree that the device
cannot modify the contents.

The current implementation is assuming QEMU live-migration with the
Linux guest as the only use case. As such I want to make sure we
correctly capture all of the behaviors that are expected based on
those assumptions, but I want to avoid inserting behaviors we would
like to see occur but aren't really a part of this.

> >
> > The driver can end up releasing the pages back to the buddy allocator
> > and if they are not poisoned/init_on_free then they will go there and
> > can still potentially change until such time as the guest writes to
> > the page modifying it or the balloon driver switches the cmd ID to
> > VIRTIO_BALLOON_CMD_ID_DONE. That was one of the reasons for trying to
> > frame it the way I did. So what I can do is reword the two statements
> > as follows:
> >
> >   If the content of a previously hinted page has not been modified by the
> >   guest since the device issued the \field{free_page_hint_cmd_id} associated
> >   with the hint, the device MAY modify the contents of the page.
> >
> >   The device MUST NOT modify the content of a previously hinted page
> > after
> >   \field{free_page_hint_cmd_id} is set to VIRTIO_BALLOON_CMD_ID_DONE.
> Is it really only "DONE" that closes the current window? I think a
> "STOP" from the device will also close the window. DONE is only set at
> the very last iteration during memory migration.

So the CMD_ID_DONE is issued when the migration has occurred. The
migration is what is actually modifying the memory.

> (virtio_balloon_free_page_report_notify() in QEMU)
>
> I consider one window == one iteration == one value of
> \field{free_page_hint_cmd_id} until either DONE or STOP

CMD_ID_STOP will close the current window for providing hints, but the
migration hasn't happened yet. We are still accumulating the hints. We
don't receive CMD_ID_DONE from the device until the migration has
occurred. It is the migration that will alter the content of the pages
by leaving them behind on the previous VM.

> [...]
>
> Let's think this through, what about this scenario:
>
> The device sets \field{free_page_hint_cmd_id} = X
> The driver starts reporting free pages (and reports all pages it has)
> 1. Sends X to start the windows
> 2. Sends all page hints (\field{free_page_hint_cmd_id} stays X)
> 3. Sends VIRTIO_BALLOON_CMD_ID_STOP to end the window
> The driver sets \field{free_page_hint_cmd_id} = DONE or STOP
>
> The guest can reuse the pages any time (triggered by the shrinker),
> especially, during 2, before the hypervisor even processed a hint
> request. It can happen that the guest reuses a page before the
> hypervisor processes the request and before
> \field{free_page_hint_cmd_id} changes.
>
> In QEMU, the double-bitmap magic makes sure that this is guaranteed to
> work IIRC.
>
> In that case, the page has to be migrated in that windows, the
> hypervisor must not modify the content.

If by "reuse" you mean write to or reinitialize then that is correct.
All that is really happening is that any pages that are hinted have
the potential to be left behind with the original VM and not migrated
to the new one. We get the notification that the migration happened
when CMD_ID_DONE is passed to us. At that point the hinting is
complete and the device has no use for additional data.

Instead of CMD_ID_STOP it probably would have made more sense to call
it something like CMD_ID_PAUSE or CMD_ID_HOLD as that is what it is
really doing. It is just temporarily holding the hints off while the
hypervisor synchronizes the dirty bits from the host.

> >>> +
> >>> +The device MAY NOT modify the contents of the balloon after
> >>> +\field{free_page_hint_cmd_id} is set to VIRTIO_BALLOON_CMD_ID_DONE.
> >>
> >> "contents of the balloon" is misleading. What exactly did you want to
> >> say here? Modifying the content of previously hinted pages?
> >>
> >> "MAY NOT" does not exist in RFC2119. Was this meant to be "MUST NOT".
> >
> > Thanks for pointing that out.
> >
> >>> +
> >>>  \section{SCSI Host Device}\label{sec:Device Types / SCSI Host Device}
> >>>
> >>>  The virtio SCSI host device groups together one or more virtual
> >>>
> >>>
> >>>
> >>
> >> Whenever you add new normative sections/paragraphs, you also have to
> >> link to them from conformance.tex (both, for devices and drivers).
> >
> > I will go through and update that.
> >
> >>
> >> In addition, we should document that VIRTIO_BALLOON_F_MUST_TELL_HOST
> >> does not affect VIRTIO_BALLOON_F_FREE_PAGE_HINT.
> >
> > I'm not sure that really makes sense though. With the "balloon" and
> > "deflate" wording being stripped I'm not sure it makes sense to
> > indicate that we don't need to deflate the hinted pages since we don't
> > describe doing that anywhere.
>
> Agreed, if we rip out any trace of "balloon" "inflate" and "deflate",
> this should work.

Sounds good. Thanks.

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

