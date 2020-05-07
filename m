Return-Path: virtio-comment-return-1215-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <20200429184122.1248.4817.stgit@localhost.localdomain>
 <20200429185751.1248.24816.stgit@localhost.localdomain> <20200507174819.32e1f831.cohuck@redhat.com>
In-Reply-To: <20200507174819.32e1f831.cohuck@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 7 May 2020 13:16:20 -0700
Message-ID: <CAKgT0UdGtLgnp=jCq5KjGmOHCJJ0E1d1N8_oyHnKNErUaAZdxw@mail.gmail.com>
Subject: [virtio-comment] Re: [PATCH RFC 2/3] content: Document balloon feature page poison
Content-Type: text/plain; charset="UTF-8"
To: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, May 7, 2020 at 8:48 AM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Wed, 29 Apr 2020 11:57:51 -0700
> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > Page poison provides a way for the guest to notify the host of the content
> > expected to be found in pages when they are added back to the guest after
> > being discarded. The feature currently doesn't apply to the existing
> > balloon features, however it will apply to an upcoming feature, free page
> > reporting. Add documentation for the page poison feature describing the
> > basic functionality and requirements.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  content.tex |   45 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/content.tex b/content.tex
> > index 796901e83a71..c98b8ea9526a 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -5026,6 +5026,9 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
> >      page hinting. A virtqueue for providing hints as to what memory is
> >      currently free is present. Configuration field free_page_hint_cmd_id
> >      is valid.
> > +\item[ VIRTIO_BALLOON_F_PAGE_POISON(4) ] Host has to be notified if guest
> > +    is expecting reported pages to contain a certain value when returned.
> > +    Configuration field poison_val is valid.
> >
> >  \end{description}
> >
> > @@ -5033,6 +5036,9 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
> >  The driver SHOULD accept the VIRTIO_BALLOON_F_MUST_TELL_HOST
> >  feature if offered by the device.
> >
> > +The driver SHOULD clear the VIRTIO_BALLOON_F_PAGE_POISON flag if it is not
> > +expecting any specific value to be stored in the page.
> > +
> >  \devicenormative{\subsubsection}{Feature bits}{Device Types / Memory Balloon Device / Feature bits}
> >  If the device offers the VIRTIO_BALLOON_F_MUST_TELL_HOST feature
> >  bit, and if the driver did not accept this feature bit, the
> > @@ -5058,6 +5064,7 @@ \subsection{Device configuration layout}\label{sec:Device Types / Memory Balloon
> >          le32 num_pages;
> >          le32 actual;
> >          le32 free_page_hint_cmd_id;
> > +        le32 poison_val;
>
> Add
>
> "\field{poison_val} is available if VIRTIO_BALLOON_F_PAGE_POISON has
> been negotiated."
>
> above.
>
> >  };
> >  \end{lstlisting}
> >
> > @@ -5087,6 +5094,9 @@ \subsection{Device Initialization}\label{sec:Device Types / Memory Balloon Devic
> >
> >  \item If the VIRTIO_BALLOON_F_FREE_PAGE_HINT feature bit is negotiated the
> >    free_page_vq is identified.
> > +
> > +\item If the VIRTIO_BALLOON_F_PAGE_POISON feature bit is negotiated then
> > +  the driver MUST update the poison_val configuration field.
>
> When does the driver set the field? Before or after DRIVER_OK?
>
> Can it change it later?

It should be before DRIVER_OK, and it should not change. The expected
use case is that this provides information that should be static about
behaviors expected of the balloon driver so if the value is changed we
would likely need to unload and reload the driver, or at least deflate
the balloon and reset reporting.

> >  \end{enumerate}
> >
> >  \subsection{Device Operation}\label{sec:Device Types / Memory Balloon Device / Device Operation}
> > @@ -5452,6 +5462,41 @@ \subsubsection{Free Page Hinting}\label{sec:Device Types / Memory Balloon Device
> >  the guest or \field{free_page_hint_cmd_id} is set to
> >  VIRTIO_BALLOON_CMD_ID_DONE.
> >
> > +\subsubsection{Page Poison}\label{sec:Device Types / Memory Balloon Device / Device Operation / Page Poison}
> > +
> > +Page Poison provides a way to notify the host of the contents that are
> > +currently in the balloon pages, and those that are expected to be in the
> > +pages when they are pulled from the balloon. It is used for in-place
> > +reporting of pages without needing to pull them from the memory allocator
> > +of the guest.
> > +
> > +\begin{enumerate}
> > +
> > +\item If VIRTIO_BALLOON_F_PAGE_POISON feature is negotiated, the guest will
>
> s/is/has been/
>
> s/the guest/the driver/
>
> > +  place the expected poison value in \field{poison_val} configuration data.
> > +
> > +\end{enumerate}
>
> Do you really need a list with one item?

Probably not, what I was trying to do is just define this as a
separate part from the explanation of what it is in the paragraph
above. I will take a look at what options I have as this is
essentially just a statement that if the feature has been negotiated
then the guest will populate the data.

> > +
> > +\drivernormative{\paragraph}{Page Poison}{Device Types / Memory Balloon Device / Device Operation / Page Poison}
> > +
> > +Normative statements in this section apply if and only if  the
> > +VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated.
>
> "If the VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated:"
>
> > +
> > +The driver MUST populate the \field{poison_val} configuration data if it is
> > +expecting the page to contain some fixed value when free.
>
> Are there any restrictions of which values may be used here? E.g., is 0
> a valid value?

There are no restrictions other than that it is an unsigned 32b value.
So 0 is a valid value and actually I suspect it won't be that
uncommon.

> > +
> > +The driver MAY opt to disable the feature if it will take care of
> > +re-initializing pages when first accessing them.
> > +
> > +\devicenormative{\paragraph}{Page Poison}{Device Types / Memory Balloon Device / Device Operation / Page Poison}
> > +
> > +Normative statements in this section apply if and only if  the
> > +VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated.
>
> "If the VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated:"
>
> > +
> > +The device MAY ignore the \field{poison_val} for normal balloon operations and
> > +free page hinting as this feature did not exist prior to those features being
> > +added.
>
> So, for which operations is the device required to do something here?
> If it does not want to honour the field, it can simply elect to not
> offer the feature? Or is there a dependency between features?

So this is laying the groundwork for free page reporting. Currently
the driver and the device both have the option of not enabling the
page poison feature. The expectation is that in most cases the driver
will just disable it when there is no poison value to report, and the
way the current balloon drivers are implemented make it unnecessary
for existing features.

It is an optional feature that will become a requirement for new
features under certain circumstances. I still have patches outstanding
for it as the Linux kernel driver implemented it, but it never was
added to QEMU. What will happen in the future is that the guest will
disable free page reporting if it has to report a poison value and
cannot due to the poison feature not being negotiated.

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

