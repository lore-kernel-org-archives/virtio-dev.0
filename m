Return-Path: virtio-comment-return-1274-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <158956393696.246123.9443729217250549606.stgit@ahduyck-workstation>
 <158956400429.246123.15328266658164976911.stgit@ahduyck-workstation> <16b7b50f-880b-b9f7-a356-540c6a863850@redhat.com>
In-Reply-To: <16b7b50f-880b-b9f7-a356-540c6a863850@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 19 May 2020 11:52:50 -0700
Message-ID: <CAKgT0Ucoqinwnwm+R_Yp8G=rYhEWm85yk8rwP+tdfeSSm59O-Q@mail.gmail.com>
Subject: Re: [virtio-comment] [PATCH v2 3/3] content: Document balloon feature
 free page reporting
Content-Type: text/plain; charset="UTF-8"
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Wang, Wei W" <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, May 19, 2020 at 3:27 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 15.05.20 19:33, Alexander Duyck wrote:
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
> >  content.tex |   84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 83 insertions(+), 1 deletion(-)
> >
> > diff --git a/content.tex b/content.tex
> > index 3d30fd5bb6fa..3cb38105f794 100644
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
> > +it MUST NOT accept VIRTIO_BALLOON_F_PAGE_REPORTING unless it also
> > +negotiates VIRTIO_BALLOON_F_PAGE_POISON.
> > +
>
> Is "accept" really the right word here? Below you use "negotiate", which
> makes more sense.

Okay, I'll change that.

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
> >  \end{enumerate}
> >
> >  \subsection{Device Operation}\label{sec:Device Types / Memory Balloon Device / Device Operation}
> > @@ -5478,7 +5493,9 @@ \subsubsection{Page Poison}\label{sec:Device Types / Memory Balloon Device / Dev
> >
> >  Page Poison provides a way to notify the host of the contents that are
> >  currently in the balloon pages, and those that are expected to be in the
> > -pages when they are pulled from the balloon.
> > +pages when they are pulled from the balloon. It is used for in-place
> > +reporting of pages without needing to pull them from the memory allocator
> > +of the guest.
>
> Let's see how that looks like after you modify patch #2.

What I currently have is:
  Page Poison provides a way to notify the host that the guest is initializing
  and/or poisoning free pages. When the feature is enabled pages that are
  deflated will be immediately written to by the guest, and pages indicated by
  free page reporting will contain the value indicated by \field{poison_val}.

> >
> >  If VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the guest
> >  will place the expected poison value into the \field{poison_val}
> > @@ -5504,6 +5521,71 @@ \subsubsection{Page Poison}\label{sec:Device Types / Memory Balloon Device / Dev
> >  page hinting, the device MAY ignore the content of \field{poison_val}
> >  for those operations.
> >
> > +\subsubsection{Free Page Reporting}\label{sec:Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
> > +
> > +Free Page Reporting provides a mechanism similar to balloon inflation,
> > +however it does not provide a deflation queue. The expectation is that the
> > +device will have a means by which it can detect the guest page access and
> > +fault in such pages with some initial value, likely a zero page.
> > +
> > +The driver will respond to to memory conditions and begin reporting free
>
> "to to memory conditions" I don't understand what you are trying to say.
> The driver will simply report some free pages (e.g., of a guest-specific
> minimum size) when it feels like the right time has come.
>
> This (and below) is too implementation specific. You could just
> implement a driver that hints a single page every time it is getting
> freed. Nothing wrong about that. There is just the option do to a bulk
> report whenever the driver feels like doing it.
>
> > +pages when some number of pages are available.
> > +

I don't really think it is all that specific. The full wording is:
  The driver will respond to memory conditions and begin reporting free
  pages when some number of pages are available.

So in this case "memory conditions" could be freeing a page and "some
number" could be 1 if that is what you want to go for. I am not saying
it has to bulk, but it could. There are a number of ways this could be
interpreted. Basically there is "some condition" that will trigger us
reporting pages. If that is 1 free page then I think that is described
by that sentence, but so is the case where we wait until there are a
large number of free pages.

> > +\begin{enumerate}
> > +
> > +\item The driver determines it has enough pages available to begin
> > +  reporting pages.
> > +
> > +\item The driver gathers pages into a scatter-gather list and adds them to
> > +  the reporting_vq.
> > +
> > +\item The device acknowledges the reporting request by using the
> > +  reporting_vq descriptor.
> > +
> > +\item Once the device has acknowledged the report, the pages can be
> > +  returned to the location from which they were pulled.
> > +
> > +\item The driver can then continue to gather and report pages until it
> > +  has determined it has reported a sufficient quantity of pages.
> > +
> > +\end{enumerate}
> > +
> > +\drivernormative{\paragraph}{Free Page Reporting}{Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
> > +
> > +Normative statements in this section apply if the
> > +VIRTIO_BALLOON_F_PAGE_REPORTING feature has been negotiated.
> > +
> > +If the driver is expecting the free page to contain some initial value it
> > +MUST NOT negotiate this feature without negotiating the
> > +VIRTIO_BALLOON_F_PAGE_POISON feature as well and supply this value via
> > +\field{poison_val}.
> > +
> > +If the driver is expecting the pages to retain some initialized value,
> > +it MUST NOT accept VIRTIO_BALLOON_F_PAGE_REPORTING unless it also
> > +negotiates the VIRTIO_BALLOON_F_PAGE_POISON feature and supplies this
> > +value via \field{poison_val}.
>
> I'd probably do something like
>
> The driver MUST NOT negotiate VIRTIO_BALLOON_F_PAGE_REPORTING without
> VIRTIO_BALLOON_F_PAGE_POISON in case it relies on reported pages to not
> change their content.

So the problem is VIRTIO_BALLOON_F_PAGE_POISON doesn't protect the
content. It guarantees that the page will be filled with the
poison_val if they are modified.

Actually maybe I can go back through and revise this based on the
updates I did for the Free Page Hinting. I can just state that the
driver must treat reported pages as uninitialized if PAGE_POISON is
not defined.

> The driver MUST negotiate VIRTIO_BALLOON_F_PAGE_REPORTING and
> VIRTIO_BALLOON_F_PAGE_POISON in case it relies on reported pages to be
> filled with \field{poison_val} when reusing them.

Again I want to be careful about the wording here. The device doesn't
have to modify the pages. It can just do nothing in response to a
reporting request. So it is the responsibility of the driver to fill
the page with poison_val and then the device cannot modify the page in
any way that might cause it to stray from that.

So I could probably replace these with something like:
  If the VIRTIO_BALLOON_F_PAGE_POISON feature has not been negotiated, then
  the driver MUST treat all reported pages as uninitialized memory.

  If the VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the driver
  MUST guarantee that the page has been filled with no value other than
  \field{poison_val}.

Then when we complete it when we combine that with the comment in the
device section:
  If the VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the device
  MUST NOT modify the the content of a reported page to a value other than
  \field{poison_val}.

> But I'll have to double check your QEMU patches :)

So I still have the patch that enables this bit outstanding. Basically
it is disabling free page reporting because we cannot handle the case
where we have to treat a reported page a uninitialized memory if the
page poison feature is not present.

> > +
> > +The driver MUST NOT use the reported pages until the device has
> > +acknowledged the reporting request.
> > +
> > +The driver MAY report free pages any time after DRIVER_OK is set.
>
> Now, this is the right thing to document. Maybe also something like "The
> driver MAY decide to not report some free pages, especially of smaller
> granularity."

So I probably wouldn't want to use MAY here, but may want to phrase
this as more of a SHOULD.

So maybe something like:
  The driver SHOULD attempt to report large pages rather than smaller ones
  as this could improve performance for free page reporting.

> > +
> > +It is RECOMMENDED that the driver avoid unnecessary reads or writes to the
>
> s/avoid/avoids/
>
> > +page contents as this could reduce the performance for free page reporting.
> > +
> You're the second user of RECOMMENDED.
>
> I'd do: "The driver SHOULD avoid unnecessary reads ..."

I'll update it to the following:
  The driver SHOULD avoid unnecessary reads or writes to the reported page
  contents as this could reduce the performance for free page reporting.

> > +\devicenormative{\paragraph}{Free Page Reporting}{Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
> > +
> > +Normative statements in this section apply if the
> > +VIRTIO_BALLOON_F_PAGE_REPORTING feature has been negotiated.
> > +
> > +The device MAY modify the contents of any page supplied in a report
> > +request even before acknowledging that request by using the
> > +reporting_vq descriptor.
> > +
> > +If the VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the device
> > +SHALL NOT modify the the page if this will result in the page containing a
> > +value other than \field{poison_val}.
>
> You're the first user of "SHALL NOT" -> "MUST NOT" ?
>
> s/the the page/the content of a reported page/
>
> "If the VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the
> device MUST NOT modify the content of a reported page to something other
> than than \field{poison_val}." ?

I will tweak the wording to match what you have here.

So with this I think we have gone through the full set. I will see
about cleaning the last bits up and resubmitting the set later today.

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

