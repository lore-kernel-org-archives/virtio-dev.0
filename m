Return-Path: virtio-comment-return-1289-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <158994007522.397236.7536927155973222190.stgit@ahduyck-workstation>
 <158994015407.397236.11198079430562924182.stgit@ahduyck-workstation> <47a104e2-995d-71bd-68ee-606c5210372d@redhat.com>
In-Reply-To: <47a104e2-995d-71bd-68ee-606c5210372d@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 26 May 2020 07:42:06 -0700
Message-ID: <CAKgT0Udo8Jw9A+3avM+=DWg+DnSkRLtt6p2p3r575oYMqaT9vg@mail.gmail.com>
Subject: Re: [virtio-comment] [PATCH v3 3/3] content: Document balloon feature
 free page reporting
Content-Type: text/plain; charset="UTF-8"
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Wang, Wei W" <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, May 26, 2020 at 2:06 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 20.05.20 04:02, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > Free page reporting is a feature that allows the guest to proactively
> > report unused pages to the host. By making use of this feature is is
> > possible to reduce the overall memory footprint of the guest in cases where
> > some significant portion of the memory is idle. Add documentation for the
> > free page reporting feature describing the functionality and requirements.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  conformance.tex |    2 +
> >  content.tex     |   82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 83 insertions(+), 1 deletion(-)
> >
> > diff --git a/conformance.tex b/conformance.tex
> > index 5038b36324ac..5496a25e93ef 100644
> > --- a/conformance.tex
> > +++ b/conformance.tex
> > @@ -151,6 +151,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> >  \item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation / Memory Statistics}
> >  \item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation / Free Page Hinting}
> >  \item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation / Page Poison}
> > +\item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
> >  \end{itemize}
> >
> >  \conformance{\subsection}{SCSI Host Driver Conformance}\label{sec:Conformance / Driver Conformance / SCSI Host Driver Conformance}
> > @@ -335,6 +336,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> >  \item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation / Memory Statistics}
> >  \item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation / Free Page Hinting}
> >  \item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation / Page Poison}
> > +\item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
> >  \end{itemize}
> >
> >  \conformance{\subsection}{SCSI Host Device Conformance}\label{sec:Conformance / Device Conformance / SCSI Host Device Conformance}
> > diff --git a/content.tex b/content.tex
> > index 89e9948b7399..acdbcfc81538 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -5007,12 +5007,15 @@ \subsection{Virtqueues}\label{sec:Device Types / Memory Balloon Device / Virtque
> >  \item[1] deflateq
> >  \item[2] statsq
> >  \item[3] free_page_vq
> > +\item[4] reporting_vq
> >  \end{description}
> >
> >    statsq only exists if VIRTIO_BALLOON_F_STATS_VQ is set.
> >
> >    free_page_vq only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set.
> >
> > +  reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set.
> > +
> >  \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Feature bits}
> >  \begin{description}
> >  \item[VIRTIO_BALLOON_F_MUST_TELL_HOST (0)] Host has to be told before
> > @@ -5029,6 +5032,8 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
> >  \item[ VIRTIO_BALLOON_F_PAGE_POISON(4) ] The device has to be notified if
> >      the driver is expecting balloon pages to contain a certain value when
> >      returned. Configuration field poison_val is valid.
> > +\item[ VIRTIO_BALLOON_F_PAGE_REPORTING(5) ] The device has support for free
> > +    page reporting. A virtqueue for reporting free guest memory is present.
> >
> >  \end{description}
> >
> > @@ -5039,6 +5044,10 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
> >  The driver SHOULD clear the VIRTIO_BALLOON_F_PAGE_POISON flag if it is not
> >  expecting any specific value to be stored in the page.
> >
> > +If the driver is expecting the pages to retain some initialized value,
>
> "some" -> the value communicated via poison_val?

So I left this somewhat vague on purpose. What this is referring to is
that if the driver/guest is expecting any given pattern to be retained
by the driver and the VIRTIO_BALLOON_F_PAGE_POISON value is not set
then we must not accept the reporting feature. As such in this case
there is no value in poison_val as VIRTIO_BALLOON_F_PAGE_POISON is not
negotiated.

> > +it MUST NOT accept VIRTIO_BALLOON_F_PAGE_REPORTING unless it also
> > +negotiates VIRTIO_BALLOON_F_PAGE_POISON.
> > +
> >  \devicenormative{\subsubsection}{Feature bits}{Device Types / Memory Balloon Device / Feature bits}
> >  If the device offers the VIRTIO_BALLOON_F_MUST_TELL_HOST feature
> >  bit, and if the driver did not accept this feature bit, the
> > @@ -5101,10 +5110,16 @@ \subsection{Device Initialization}\label{sec:Device Types / Memory Balloon Devic
> >  \item If the VIRTIO_BALLOON_F_PAGE_POISON feature bit is negotiated, the
> >    driver updates the \field{poison_val} configuration field.
> >
> > +\item If the VIRTIO_BALLOON_F_PAGE_REPORTING feature bit is negotiated the
> > +  reporting_vq is identified.
> > +
> >  \item DRIVER_OK is set: device operation begins.
> >
> >  \item If the VIRTIO_BALLOON_F_STATS_VQ feature bit is negotiated, then
> >    notify the device about the stats virtqueue buffer.
> > +
> > +\item If the VIRTIO_BALLOON_F_PAGE_REPORTING feature bit is negotiated then
> > +  begin reporting free pages to device.
>
> s/to device/to the device/

I will fix it.

> >  \end{enumerate}
> >
> >  \subsection{Device Operation}\label{sec:Device Types / Memory Balloon Device / Device Operation}
> > @@ -5490,7 +5505,8 @@ \subsubsection{Page Poison}\label{sec:Device Types / Memory Balloon Device / Dev
> >
> >  Page Poison provides a way to notify the host that the guest is initializing
> >  and/or poisoning free pages. When the feature is enabled pages that are
> > -deflated might be immediately written to by the guest.
> > +deflated might be immediately written to by the guest, and pages reported by
> > +free page reporting will contain the value indicated by \field{poison_val}.
>
> maybe mention that this value will be retained by the device.

I could just replace "contain" with "retain" if that works for you.

> >
> >  If the guest is not initializing or poisoning freed pages it should reject
> >  the VIRTIO_BALLOON_F_PAGE_POISON feature.
> > @@ -5517,6 +5533,70 @@ \subsubsection{Page Poison}\label{sec:Device Types / Memory Balloon Device / Dev
> >  The device MAY use the content of \field{poison_val} as a hint to guest
> >  behavior.
> >
> > +\subsubsection{Free Page Reporting}\label{sec:Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
> > +
> > +Free Page Reporting provides a mechanism similar to balloon inflation,
> > +however it does not provide a deflation queue. The expectation is that the
> > +device will have a means by which it can detect the guest page access and
> > +fault in such pages with some initial value, likely a zero page.
>
> Too many unnecessary details IMHO. I'd simplify to
>
> "Free Page Reporting provides a mechanism similar to balloon inflation,
> however, it does not provide a deflation queue. Reported free pages can
> be reused by the guest once the reporting requested without notifying
> the device."
>
> But maybe s/guest/driver/

I can work with that wording.

> > +
> > +The driver will begin reporting free pages. When exactly and which free
> > +pages are reported is up to the driver.
> > +
> > +\begin{enumerate}
> > +
> > +\item The driver determines it has enough pages available to begin
> > +  reporting pages.
>
> "free pages", "reporting free pages" ?

Will update.

> > +
> > +\item The driver gathers pages into a scatter-gather list and adds them to
> > +  the reporting_vq.
>
> "free pages" ?

Will fix.

> > +
> > +\item The device acknowledges the reporting request by using the
> > +  reporting_vq descriptor.
> > +
> > +\item Once the device has acknowledged the report, the pages can be
> > +  returned to the location from which they were pulled.
>
> I'd suggest something like
>
> "Once the device has acknowledged the report, the driver can reuse the
> free pages when needed (e.g., by putting them back to free page lists in
> the guest operating system)."

Works for me.

> > +
> > +\item The driver can then continue to gather and report pages until it
> > +  has determined it has reported a sufficient quantity of pages.
>
> "free pages"

I'll update that.

> > +
> > +\end{enumerate}
> > +
> > +\drivernormative{\paragraph}{Free Page Reporting}{Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
> > +
> > +Normative statements in this section apply if the
> > +VIRTIO_BALLOON_F_PAGE_REPORTING feature has been negotiated.
> > +
> > +If the VIRTIO_BALLOON_F_PAGE_POISON feature has not been negotiated, then
> > +the driver MUST treat all reported pages as uninitialized memory.
> > +
> > +If the VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the driver
> > +MUST guarantee that the page has been filled with no value other than
> > +\field{poison_val}.
>
> "the page" is unclear
>
> "If the VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the
> driver MUST initialize all free pages with \field{poison_val} before
> reporting them." ?
>
> Again, the "MUST guarantee" part is irrelevant from spec POV, because
> for us, driver == guest.

Okay, I will use your wording.

> > +
> > +The driver MUST NOT use the reported pages until the device has
> > +acknowledged the reporting request.
> > +
> > +The driver MAY report free pages any time after DRIVER_OK is set.
> > +
> > +The driver SHOULD attempt to report large pages rather than smaller ones.
> > +
> > +The driver SHOULD avoid unnecessary reads or writes to the reported page
> > +contents.
>
> maybe simply "The driver SHOULD avoid reading/writing reported pages if
> not strictly necessary."

Okay, I will update.

> > +
> > +\devicenormative{\paragraph}{Free Page Reporting}{Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
> > +
> > +Normative statements in this section apply if the
> > +VIRTIO_BALLOON_F_PAGE_REPORTING feature has been negotiated.
> > +
> > +The device MAY modify the contents of any page supplied in a report
> > +request before acknowledging that request by using the reporting_vq
> > +descriptor.
>
> Maybe start that with
>
> "If the VIRTIO_BALLOON_F_PAGE_POISON feature has not been negotiated,
> the device ..."

Done.

> > +
> > +If the VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the device
> > +MUST NOT modify the the content of a reported page to a value other than
> > +\field{poison_val}.
> > +
> >  \section{SCSI Host Device}\label{sec:Device Types / SCSI Host Device}
>
> That part sounds good to me.

Thanks for the review.

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

