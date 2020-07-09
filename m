Return-Path: virtio-comment-return-1343-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <159407016215.314508.9176034874281717628.stgit@ahduyck-workstation>
 <159407030249.314508.17637440128411067842.stgit@ahduyck-workstation> <20200708130322.6e23855e.cohuck@redhat.com>
In-Reply-To: <20200708130322.6e23855e.cohuck@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 9 Jul 2020 09:56:58 -0700
Message-ID: <CAKgT0UcA0RDn=hWc8UUa+hrk3f_KvEtR6N1Prf7fYRNDCKnx_A@mail.gmail.com>
Subject: [virtio-comment] Re: [PATCH v5 1/3] content: Document balloon feature page poison
Content-Type: text/plain; charset="UTF-8"
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Wang, Wei W" <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 8, 2020 at 4:03 AM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Mon, 06 Jul 2020 14:18:22 -0700
> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
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
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  conformance.tex |    2 ++
> >  content.tex     |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 57 insertions(+), 4 deletions(-)
>
> (...)
>
> > @@ -5042,13 +5049,17 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
> >  VIRTIO_BALLOON_F_MUST_TELL_HOST is not negotiated.
> >
> >  \subsection{Device configuration layout}\label{sec:Device Types / Memory Balloon Device / Device configuration layout}
> > -  Both fields of this configuration
> > -  are always available.
> > +  \field{num_pages} and \field{actual} are always available.
> > +
> > +  \field{poison_val} is available if VIRTIO_BALLOON_F_PAGE_POISON has been
> > +    negotiated.
> >
> >  \begin{lstlisting}
> >  struct virtio_balloon_config {
> >          le32 num_pages;
> >          le32 actual;
> > +        le32 free_page_hint_cmd_id;
>
> This is slightly confusing, as free page hinting is only introduced in
> a later patch; maybe call this 'reserved' and rename in the patch
> introducing page hinting? But no real need to do so, I just stumbled
> over it.

What I can do is switch back to the original patch order so that the
first patch added is free page hinting since it sounds like we are
keeping the feature. Then it will take care of adding this field.

> > +        le32 poison_val;
> >  };
> >  \end{lstlisting}
> >
> > @@ -5072,9 +5083,15 @@ \subsection{Device Initialization}\label{sec:Device Types / Memory Balloon Devic
> >    \begin{enumerate}
> >    \item Identify the stats virtqueue.
> >    \item Add one empty buffer to the stats virtqueue.
> > -  \item DRIVER_OK is set: device operation begins.
> > -  \item Notify the device about the stats virtqueue buffer.
> >    \end{enumerate}
> > +
> > +\item If the VIRTIO_BALLOON_F_PAGE_POISON feature bit is negotiated, the
> > +  driver updates the \field{poison_val} configuration field.
>
> s/the driver updates/update/ would be more in line with the other
> wording here; more of a nit, feel free to keep as-is.

Okay, I will update this.

> > +
> > +\item DRIVER_OK is set: device operation begins.
> > +
> > +\item If the VIRTIO_BALLOON_F_STATS_VQ feature bit is negotiated, then
> > +  notify the device about the stats virtqueue buffer.
> >  \end{enumerate}
> >
> >  \subsection{Device Operation}\label{sec:Device Types / Memory Balloon Device / Device Operation}
> > @@ -5345,6 +5362,40 @@ \subsubsection{Memory Statistics Tags}\label{sec:Device Types / Memory Balloon D
> >    allocations in the guest.
> >  \end{description}
> >
> > +\subsubsection{Page Poison}\label{sec:Device Types / Memory Balloon Device / Device Operation / Page Poison}
> > +
> > +Page Poison provides a way to notify the host that the guest is initializing
> > +free pages with \field{poison_val}. When the feature is enabled, pages will
> > +be immediately written to by the driver after deflating.
> > +
> > +If the guest is not initializing freed pages the driver should reject the
>
> s/pages/pages,/

Done.

> > +VIRTIO_BALLOON_F_PAGE_POISON feature.
> > +
> > +If VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the driver
> > +will place the initialization value into the \field{poison_val}
> > +configuration field data.
> > +
> > +\drivernormative{\paragraph}{Page Poison}{Device Types / Memory Balloon Device / Device Operation / Page Poison}
> > +
> > +Normative statements in this section apply if the
> > +VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated.
> > +
> > +The driver MUST initialize the deflated pages with \field{poison_val} when
> > +they are reused by the driver.
> > +
> > +The driver MUST populate the \field{poison_val} configuration data before
> > +setting the DRIVER_OK bit.
> > +
> > +The driver MUST NOT modify \field{poison_val} while the DRIVER_OK bit is set.
> > +
> > +\devicenormative{\paragraph}{Page Poison}{Device Types / Memory Balloon Device / Device Operation / Page Poison}
> > +
> > +Normative statements in this section apply if the
> > +VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated.
> > +
> > +The device MAY use the content of \field{poison_val} as a hint to guest
> > +behavior.
> > +
> >  \section{SCSI Host Device}\label{sec:Device Types / SCSI Host Device}
> >
> >  The virtio SCSI host device groups together one or more virtual
> >
> >
>
> Just some nits, otherwise
>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>

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

