Return-Path: virtio-comment-return-1451-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <159836664741.231431.2775539890399592989.stgit@ahduyck-workstation>
 <159836670239.231431.14835898822569373567.stgit@ahduyck-workstation>
 <fd8d3fed-a92a-4356-7a3d-fb773b04880a@siemens.com> <CAKgT0Ud7XfcEVL8jy-6kNQ=BDUJqh-xp94MZ7F2+Vf+mv1vj3Q@mail.gmail.com>
 <2faa1a86-fc9c-f325-00f0-99df49b2421d@siemens.com>
In-Reply-To: <2faa1a86-fc9c-f325-00f0-99df49b2421d@siemens.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 11 Sep 2020 08:11:15 -0700
Message-ID: <CAKgT0UercLR43iY1PQ7LOvEnqt-c2mds7Mv7XS=77Uju-Qdz=g@mail.gmail.com>
Subject: Re: [virtio-comment] Re: [virtio-dev] [PATCH v8 1/3] content:
 Document balloon feature free page hints
Content-Type: text/plain; charset="UTF-8"
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Wang, Wei W" <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 10, 2020 at 10:28 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 04.09.20 18:56, Alexander Duyck wrote:
> > On Fri, Sep 4, 2020 at 8:20 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> On 25.08.20 16:45, Alexander Duyck wrote:
> >>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>>
> >>> Free page hints allow the balloon driver to provide information on what
> >>> pages are not currently in use so that we can avoid the cost of copying
> >>> them in migration scenarios. Add a feature description for free page hints
> >>> describing basic functioning and requirements.
> >>>
> >>> Acked-by: Cornelia Huck <cohuck@redhat.com>
> >>> Reviewed-by: David Hildenbrand <david@redhat.com>
> >>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>> ---
> >>>  conformance.tex |    2 +
> >>>  content.tex     |  161 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
> >>>  2 files changed, 157 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/conformance.tex b/conformance.tex
> >>> index b6fdec090383..a14e26edfcb2 100644
> >>> --- a/conformance.tex
> >>> +++ b/conformance.tex
> >>> @@ -149,6 +149,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> >>>  \item \ref{drivernormative:Device Types / Memory Balloon Device / Feature bits}
> >>>  \item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation}
> >>>  \item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation / Memory Statistics}
> >>> +\item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation / Free Page Hinting}
> >>>  \end{itemize}
> >>>
> >>>  \conformance{\subsection}{SCSI Host Driver Conformance}\label{sec:Conformance / Driver Conformance / SCSI Host Driver Conformance}
> >>> @@ -331,6 +332,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> >>>  \item \ref{devicenormative:Device Types / Memory Balloon Device / Feature bits}
> >>>  \item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation}
> >>>  \item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation / Memory Statistics}
> >>> +\item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation / Free Page Hinting}
> >>>  \end{itemize}
> >>>
> >>>  \conformance{\subsection}{SCSI Host Device Conformance}\label{sec:Conformance / Device Conformance / SCSI Host Device Conformance}
> >>> diff --git a/content.tex b/content.tex
> >>> index 91735e3eb018..76dfce919b97 100644
> >>> --- a/content.tex
> >>> +++ b/content.tex
> >>> @@ -5005,10 +5005,13 @@ \subsection{Virtqueues}\label{sec:Device Types / Memory Balloon Device / Virtque
> >>>  \begin{description}
> >>>  \item[0] inflateq
> >>>  \item[1] deflateq
> >>> -\item[2] statsq.
> >>> +\item[2] statsq
> >>> +\item[3] free_page_vq
> >>>  \end{description}
> >>>
> >>> -  Virtqueue 2 only exists if VIRTIO_BALLOON_F_STATS_VQ set.
> >>> +  statsq only exists if VIRTIO_BALLOON_F_STATS_VQ is set.
> >>> +
> >>> +  free_page_vq only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set.
> >>>
> >>>  \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Feature bits}
> >>>  \begin{description}
> >>> @@ -5019,6 +5022,10 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
> >>>      memory statistics is present.
> >>>  \item[VIRTIO_BALLOON_F_DEFLATE_ON_OOM (2) ] Deflate balloon on
> >>>      guest out of memory condition.
> >>> +\item[ VIRTIO_BALLOON_F_FREE_PAGE_HINT(3) ] The device has support for free
> >>> +    page hinting. A virtqueue for providing hints as to what memory is
> >>> +    currently free is present. Configuration field \field{free_page_hint_cmd_id}
> >>> +    is valid.
> >>>
> >>>  \end{description}
> >>>
> >>> @@ -5042,13 +5049,17 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
> >>>  VIRTIO_BALLOON_F_MUST_TELL_HOST is not negotiated.
> >>>
> >>>  \subsection{Device configuration layout}\label{sec:Device Types / Memory Balloon Device / Device configuration layout}
> >>> -  Both fields of this configuration
> >>> -  are always available.
> >>> +  \field{num_pages} and \field{actual} are always available.
> >>> +
> >>> +  \field{free_page_hint_cmd_id} is available if
> >>> +    VIRTIO_BALLOON_F_FREE_PAGE_HINT has been negotiated and is read-only by
> >>> +    the driver.
> >>
> >> This reads at least to me like "...if VIRTIO_BALLOON_F_FREE_PAGE_HINT
> >> ... is read-only by the driver". I suspect you rather meant
> >> "free_page_hint_cmd_id is read-only...". Maybe split up into two sentences?
> >
> > Yes, the intention is:
> > 1. free_page_hint_cmd_id is only available if
> > VIRTIO_BALLOON_F_FREE_PAGE_HINT has been negotiated
> > 2. free_page_hint_cmd_id is read only by the driver
> >
> > If needed I suppose we could break it up by splitting it into two
> > sentences, or adding "the field" after the "and".
> >
>
> I'm fine with both options but please adjust this - on top (Michael just
> opened the voting for this version again due to the formal typo in round 1).
>
> Jan

Since the patch set is being voted on is there a preferred method for
making this sort of update? I'm just wondering if I should do an
additional incremental patch, just submit a replacement for this
patch, or make the change and resubmit the entire patch set?

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

