Return-Path: virtio-comment-return-1272-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <158956393696.246123.9443729217250549606.stgit@ahduyck-workstation>
 <158956398852.246123.13563550180731658368.stgit@ahduyck-workstation>
 <7558cc20-262b-ddc4-2442-e05f0b74b59d@redhat.com> <CAKgT0Ucx6nF9_e6+Qj-A6t_c5Mm1u-=kphAtF31bz9t8Oo+n6w@mail.gmail.com>
 <20200519085440.1edb9b9c.cohuck@redhat.com>
In-Reply-To: <20200519085440.1edb9b9c.cohuck@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 19 May 2020 08:35:28 -0700
Message-ID: <CAKgT0UcsG21fndi-Rn62S09NFiLu59HTymG4QQ2phHG19uEcwA@mail.gmail.com>
Subject: Re: [virtio-comment] [PATCH v2 1/3] content: Document balloon feature
 free page hints
Content-Type: text/plain; charset="UTF-8"
To: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Wang, Wei W" <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, May 18, 2020 at 11:54 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Mon, 18 May 2020 13:15:50 -0700
> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>
> > On Mon, May 18, 2020 at 6:18 AM David Hildenbrand <david@redhat.com> wrote:
> > >
> > > On 15.05.20 19:33, Alexander Duyck wrote:
>
> > > > +\subsubsection{Free Page Hinting}\label{sec:Device Types / Memory Balloon Device / Device Operation / Free Page Hinting}
> > > > +
> > > > +Free page hinting is designed to be used during migration to determine what
> > > > +pages within the guest are currently unused so that they can be skipped over
> > > > +while migrating the guest. The device will indicate that it is ready to start
> > > > +performing hinting by setting the \field{free_page_hint_cmd_id} to one of the
> > > > +non-reserved values that can be used as a command ID. The following values
> > > > +are reserved:
> > > > +
> > > > +\begin{description}
> > > > +\item[VIRTIO_BALLOON_CMD_ID_STOP (0)] Any command ID previously supplied by
> > > > +  the device is invalid. The driver should halt all hinting until a new
> > > > +  command ID is supplied.
> > >
> > > Maybe "The driver should stop hinting free pages, but should not reuse
> > > all previously hinted pages."
> >
> > The "reuse all previously hinted pages" seems rather unclear to me. I
> > would like to make clear that in this case the "use" is the guest
> > making use of the memory, not the driver doing something like
> > recycling hints. So in the spots where you reference "the driver
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
>
> "The driver should stop hinting free pages until a new command ID is
> supplied, but should not release..."
>
> would sound good to me.

Thanks, I will make that tweak.

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

