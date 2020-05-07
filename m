Return-Path: virtio-comment-return-1211-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Thu, 7 May 2020 17:33:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20200507173303.72af6731.cohuck@redhat.com>
In-Reply-To: <20200429185745.1248.48298.stgit@localhost.localdomain>
References: <20200429184122.1248.4817.stgit@localhost.localdomain>
	<20200429185745.1248.48298.stgit@localhost.localdomain>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH RFC 1/3] content: Document balloon feature free page
 hints
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: david@redhat.com, mst@redhat.com, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 29 Apr 2020 11:57:45 -0700
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Free page hints allow the balloon driver to provide information on what
> pages are not currently in use so that we can avoid the cost of copying
> them in migration scenarios. Add a feature description for free page hints
> describing basic functioning and requirements.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  content.tex |  113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 110 insertions(+), 3 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index b91a132df146..796901e83a71 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -5006,9 +5006,12 @@ \subsection{Virtqueues}\label{sec:Device Types / Memory Balloon Device / Virtque
>  \item[0] inflateq
>  \item[1] deflateq
>  \item[2] statsq.
> +\item[3] free_page_vq.

I'd lose the trailing period (and probably also remove it from statsq;
it just looks weird.)

>  \end{description}
>  
> -  Virtqueue 2 only exists if VIRTIO_BALLOON_F_STATS_VQ set.
> +  statsq only exists if VIRTIO_BALLOON_F_STATS_VQ set.

As you are touching this line anyway, s/set/is set/

> +
> +  free_page_vq only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT set.

s/set/is set/

>  
>  \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Feature bits}
>  \begin{description}
> @@ -5019,6 +5022,10 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
>      memory statistics is present.
>  \item[VIRTIO_BALLOON_F_DEFLATE_ON_OOM (2) ] Deflate balloon on
>      guest out of memory condition.
> +\item[ VIRTIO_BALLOON_F_FREE_PAGE_HINT(3) ] Device has support for free
> +    page hinting. A virtqueue for providing hints as to what memory is
> +    currently free is present. Configuration field free_page_hint_cmd_id
> +    is valid.
>  
>  \end{description}
>  
> @@ -5042,13 +5049,15 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
>  VIRTIO_BALLOON_F_MUST_TELL_HOST is not negotiated.
>  
>  \subsection{Device configuration layout}\label{sec:Device Types / Memory Balloon Device / Device configuration layout}
> -  Both fields of this configuration
> -  are always available.
> +  The first two fields of this configuration are always present. The
> +  availability of the others all depend on various feature bits as
> +  indicated above.

Maybe make this more explicit?

"
\field{num_pages} and \field{actual} are always available.

\field{free_page_hint_cmd_id} is available if
VIRTIO_BALLOON_F_FREE_PAGE_HINT has been negotiated and is read-only by
the driver.
"

>  
>  \begin{lstlisting}
>  struct virtio_balloon_config {
>          le32 num_pages;
>          le32 actual;
> +        le32 free_page_hint_cmd_id;
>  };
>  \end{lstlisting}
>  
> @@ -5075,6 +5084,9 @@ \subsection{Device Initialization}\label{sec:Device Types / Memory Balloon Devic
>    \item DRIVER_OK is set: device operation begins.
>    \item Notify the device about the stats virtqueue buffer.
>    \end{enumerate}
> +
> +\item If the VIRTIO_BALLOON_F_FREE_PAGE_HINT feature bit is negotiated the
> +  free_page_vq is identified.

This startup sequence now seems wrong (identifying a vq after
DRIVER_OK). Should probably be:

- id inflate/deflate vqs
- if STATS_VQ:
  - id stats vq
  - put buffer on stats vq
- if FREE_PAGE_HINT:
  - id free page vq
- DRIVER_OK is set
- if STATS_VQ:
  - notify about buffer

>  \end{enumerate}
>  
>  \subsection{Device Operation}\label{sec:Device Types / Memory Balloon Device / Device Operation}
> @@ -5345,6 +5357,101 @@ \subsubsection{Memory Statistics Tags}\label{sec:Device Types / Memory Balloon D
>    allocations in the guest.
>  \end{description}
>  
> +\subsubsection{Free Page Hinting}\label{sec:Device Types / Memory Balloon Device / Device Operation / Free Page Hinting}
> +
> +Free page hinting is used during migration to determine what pages within

s/used/designed to be used/ ?

Or maybe

s/used during migration/can be used/ ?

> +the guest are current unused so that they can be skipped over when it comes

s/current/currently/

> +time for migration. The device will indicate that it is ready to start

s/when it comes time for migration/while migrating the guest/ ?

> +performing hinting by setting the \field{free_page_hint_cmd_id} to one of the
> +non-reserved values that can be used as a command ID:

s/command ID:/command ID. The following values are reserved:/

> +
> +\begin{description}
> +\item[VIRTIO_BALLOON_CMD_ID_STOP (0)] Any previous command ID is invalid.

"Any command ID previously supplied by the device is invalid." ?

> +  All hinting SHOULD halt until a new command ID is supplied.

"The driver should halt any hinting until..." ? Or what is actually
halting?

(I think we don't want to use 'SHOULD' outside of normative section,
although we probably haven't followed that rule everywhere.)

> +
> +\item[VIRTIO_BALLOON_CMD_ID_DONE (1)] Any previous command ID is invalid.

Same comment as above.

> +  All hinting SHOULD halt and pages returned to the guest for use.

Is this the same operation as above, only with returning all pages that
the guest previously hinted about?

(Hm. I see below that this is used by the driver on the vq. Can the
device actually set this in the config space?)

> +\end{description}
> +
> +A request for free page hintings proceeds as follows:
> +
> +\begin{enumerate}
> +
> +\item \field{free_page_hint_cmd_id} configuration field is examined. If it

"The driver examines..." ?

> +  contains a non-reserved value then inflation of the balloon will begin.
> +
> +\item To supply memory to the hinting balloon:
> +  \begin{enumerate}
> +  \item The driver constructs an output descriptor containing the new value
> +    from \field{free_page_hint_cmd_id} configuration field and adds it to
> +    the free_page_hint_vq.
> +  \item The driver driver maps a series of pages and adds them to the
> +    free_page_hint_vq as individual scatter-gather entries.
> +  \item When the driver is no longer able to fetch additional pages to add
> +    to the free_page_hint_vq it will construct an output descriptor
> +    containing the command ID VIRTIO_BALLOON_CMD_ID_STOP.
> +  \end{enumerate}

So the sequence is:

- The driver puts a descriptor containing only the id on the queue.
- The driver puts page pointers in a scatter-gather list on the queue...
- ...until it runs out of possible pages and put a descriptor
  containing only the STOP id on the queue.

> +
> +\item A round of hinting ends either when the driver is no longer able to
> +  add more pages to the balloon as described above, or when the device
> +  updates \field{free_page_hint_cmd_id} configuration field contain either
> +  VIRTIO_BALLOON_CMD_ID_STOP or VIRTIO_BALLOON_CMD_ID_DONE.

So, either the driver stops via STOP or the device stops via STOP or
DONE. The driver can't stop via DONE?

> +
> +\item The device may follow VIRTIO_BALLOON_CMD_ID_STOP with a new
> +  non-reserved value for \field{free_page_hint_cmd_id} configuration field
> +  in which case it will resume supplying the hinting balloon.

But the driver is not required to supply new pages and may instead
queue id + STOP?

> +
> +\item Otherwise, if the device provides VIRTIO_BALLOON_CMD_ID_DONE then
> +  hinting is complete and the guest may begin to re-use pages preivously

s/preivously/previously/

> +  given to the balloon.

So, there is no other way for the guest to regain use of pages it
hinted about?

(I'm not familiar with how this is implemented in Linux/QEMU, so some
of this might seem obvious to others. But a spec probably should
mention things like that as well :)

> +
> +\end{enumerate}
> +
> +\drivernormative{\paragraph}{Free Page Hinting}{Device Types / Memory Balloon Device / Device Operation / Free Page Hinting}
> +
> +Normative statements in this section apply if and only if  the
> +VIRTIO_BALLOON_F_FREE_PAGE_HINT feature has been negotiated.

"If the VIRTIO_BALLOON_F_FREE_PAGE_HINT feature has been negotiated:"

> +
> +The driver SHOULD supply pages to the hinting balloon when
> +\field{free_page_hint_cmd_id} reports a value of 2 or greater.
> +
> +The driver MUST start hinting by providing an output descriptor
> +containing the current command ID for the given block of pages.
> +
> +The driver SHOULD stop supplying pages to the hinting balloon when
> +\field{free_page_hint_cmd_id} reports a value of VIRTIO_BALLOON_CMD_ID_STOP.

What happens if it continues?

> +
> +If the driver is unable to supply pages it MUST complete hinting by adding
> +an output descriptor containing the command ID VIRTIO_BALLOON_CMD_ID_STOP.
> +
> +The driver MAY use pages from the balloon after adding them to the balloon,
> +including when the device has not acknowledged the hinting request.

How does the device acknowledge the hinting request?

> +
> +The driver SHOULD return pages for use once \field{free_page_hint_cmd_id}
> +reports a value of VIRTIO_BALLOON_CMD_ID_DONE.
> +
> +\devicenormative{\paragraph}{Free Page Hinting}{Device Types / Memory Balloon Device / Device Operation / Free Page Hinting}
> +
> +Normative statements in this section apply if and only if  the
> +VIRTIO_BALLOON_F_FREE_PAGE_HINT feature has been negotiated.

"If the VIRTIO_BALLOON_F_FREE_PAGE_HINT feature has been negotiated:"

> +
> +The device MUST set \field{free_page_hint_cmd_id} to
> +VIRTIO_BALLOON_CMD_ID_STOP any time that the host dirty bits for the given
> +guest are being recorded.

What does that mean? Is 'host dirty bits' really a generic term?

> +
> +The device MUST guarantee that command ID is not reused until it has
> +received an output descriptor containing VIRTIO_BALLOON_CMD_ID_STOP from
> +the driver.

"The device MUST NOT reuse a command ID until..."

> +
> +The device MUST not perform hinting on pages that are provided with a
> +command ID that does not match the current value in
> +\field{free_page_hint_cmd_id}.

So, what does it do if the driver supplies such pages? Ignore them? It
can't signal an error to the driver, can it?

> +
> +The device MAY modify the contents of the page in the balloon at any time
> +after detecting its physical number until it has either been written to by

What is the 'physical number'?

> +the guest or \field{free_page_hint_cmd_id} is set to
> +VIRTIO_BALLOON_CMD_ID_DONE.
> +
>  \section{SCSI Host Device}\label{sec:Device Types / SCSI Host Device}
>  
>  The virtio SCSI host device groups together one or more virtual
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

