Return-Path: virtio-comment-return-1224-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Mon, 11 May 2020 14:09:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20200511140951.2afe0cca.cohuck@redhat.com>
In-Reply-To: <158895818234.529821.13300630585219085797.stgit@ahduyck-workstation>
References: <158895811782.529821.115832709184722087.stgit@ahduyck-workstation>
	<158895818234.529821.13300630585219085797.stgit@ahduyck-workstation>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH 1/3] content: Document balloon feature free page hints
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: virtio-comment@lists.oasis-open.org, mst@redhat.com, david@redhat.com, virtio-dev@lists.oasis-open.org, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 08 May 2020 10:16:22 -0700
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
>  content.tex |  128 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 122 insertions(+), 6 deletions(-)
> 

> @@ -5072,9 +5083,15 @@ \subsection{Device Initialization}\label{sec:Device Types / Memory Balloon Devic
>    \begin{enumerate}
>    \item Identify the stats virtqueue.
>    \item Add one empty buffer to the stats virtqueue.
> -  \item DRIVER_OK is set: device operation begins.
> -  \item Notify the device about the stats virtqueue buffer.
>    \end{enumerate}
> +
> +\item If the VIRTIO_BALLOON_F_FREE_PAGE_HINT feature bit is negotiated the

s/negotiated/negotiated,/

> +  free_page_vq is identified.
> +
> +\item DRIVER_OK is set: device operation begins.
> +
> +\item If the VIRTIO_BALLOON_F_STATS_VQ feature bit is negotiated then

s/negotiated/negotiated,/

> +  notify the device about the stats virtqueue buffer.
>  \end{enumerate}
>  
>  \subsection{Device Operation}\label{sec:Device Types / Memory Balloon Device / Device Operation}
> @@ -5345,6 +5362,105 @@ \subsubsection{Memory Statistics Tags}\label{sec:Device Types / Memory Balloon D
>    allocations in the guest.
>  \end{description}
>  
> +\subsubsection{Free Page Hinting}\label{sec:Device Types / Memory Balloon Device / Device Operation / Free Page Hinting}
> +
> +Free page hinting is designed to be used during migration to determine what
> +pages within the guest are currently unused so that they can be skipped over
> +while migrating the guest. The device will indicate that it is ready to start
> +performing hinting by setting the \field{free_page_hint_cmd_id} to one of the
> +non-reserved values that can be used as a command ID. The following values
> +are reserved:
> +
> +\begin{description}
> +\item[VIRTIO_BALLOON_CMD_ID_STOP (0)] Any command ID previously supplied by
> +  the device is invalid. The driver should halt all hinting until a new
> +  command ID is supplied.
> +
> +\item[VIRTIO_BALLOON_CMD_ID_DONE (1)] Any command ID previously supplied by
> +  the device is invalid. The driver should halt all hinting and the hinting
> +  balloon can now be deflated returning all pages to the guest.
> +\end{description}
> +
> +A request for free page hinting proceeds as follows:
> +
> +\begin{enumerate}
> +
> +\item The driver examines \field{free_page_hint_cmd_id} configuration field.

s/examines/examines the/

> +  If it contains a non-reserved value then inflation of the balloon will begin.
> +
> +\item To supply memory to the hinting balloon:
> +  \begin{enumerate}
> +  \item The driver constructs an output descriptor containing the new value
> +    from \field{free_page_hint_cmd_id} configuration field and adds it to

s/from/from the/

> +    the free_page_hint_vq.
> +  \item The driver maps a series of pages and adds them to the
> +    free_page_hint_vq as individual scatter-gather input descriptor entries.
> +  \item When the driver is no longer able to fetch additional pages to add
> +    to the free_page_hint_vq it will construct an output descriptor

s/ it/, it/

> +    containing the command ID VIRTIO_BALLOON_CMD_ID_STOP.
> +  \end{enumerate}
> +
> +\item A round of hinting ends either when the driver is no longer able to
> +  add more pages to the balloon as described above, or when the device
> +  updates \field{free_page_hint_cmd_id} configuration field contain either
> +  VIRTIO_BALLOON_CMD_ID_STOP or VIRTIO_BALLOON_CMD_ID_DONE.
> +
> +\item The device may follow VIRTIO_BALLOON_CMD_ID_STOP with a new
> +  non-reserved value for \field{free_page_hint_cmd_id} configuration field

s/for/for the/
s/field/field,/

> +  in which case it will resume supplying the hinting balloon.
> +
> +\item Otherwise, if the device provides VIRTIO_BALLOON_CMD_ID_DONE then
> +  hinting is complete and the guest may begin to re-use pages previously
> +  given to the balloon.
> +
> +\end{enumerate}
> +
> +\drivernormative{\paragraph}{Free Page Hinting}{Device Types / Memory Balloon Device / Device Operation / Free Page Hinting}
> +
> +Normative statements in this section apply if the
> +VIRTIO_BALLOON_F_FREE_PAGE_HINT feature has been negotiated.
> +
> +The driver SHOULD supply pages to the hinting balloon when
> +\field{free_page_hint_cmd_id} reports a value of 2 or greater.
> +
> +The driver MUST start hinting by providing an output descriptor
> +containing the current command ID for the given block of pages.
> +
> +The driver SHOULD stop supplying pages to the hinting balloon when
> +\field{free_page_hint_cmd_id} reports a value of VIRTIO_BALLOON_CMD_ID_STOP.
> +
> +If the driver is unable to supply pages it MUST complete hinting by adding

s/pages/pages,/

> +an output descriptor containing the command ID VIRTIO_BALLOON_CMD_ID_STOP.
> +
> +The driver MAY use pages from the balloon after adding them to the balloon,
> +including when the device has not yet used the descriptor contianing the

s/contianing/containing/

> +hinting request.
> +
> +The driver SHOULD return pages for use once \field{free_page_hint_cmd_id}
> +reports a value of VIRTIO_BALLOON_CMD_ID_DONE.
> +
> +\devicenormative{\paragraph}{Free Page Hinting}{Device Types / Memory Balloon Device / Device Operation / Free Page Hinting}
> +
> +Normative statements in this section apply if the
> +VIRTIO_BALLOON_F_FREE_PAGE_HINT feature has been negotiated.
> +
> +The device MUST set \field{free_page_hint_cmd_id} to
> +VIRTIO_BALLOON_CMD_ID_STOP any time that the dirty pages for the given
> +guest are being recorded.
> +
> +The device MUST NOT reuse a command ID until it has received an output

What does 'reuse' mean in this context? I would expect that it is
forbidden to do the following:
- device sets id in config space
- driver queues descriptor with id
- device changes id to anything other than the current id or the
  reserved ids <== bad

Maybe "The device MUST NOT change a command ID actively in use by the
driver until..." ?

> +descriptor containing VIRTIO_BALLOON_CMD_ID_STOP from the driver.
> +
> +The device MUST ignore pages that are provided with a command ID that does
> +not match the current value in \field{free_page_hint_cmd_id}.
> +
> +The device MAY modify the contents of the page in the balloon if the page
> +has not been modified by the guest since the \field{free_page_hint_cmd_id}
> +associated with the hint was issued by the device.
> +
> +The device MAY NOT modify the contents of the balloon after
> +\field{free_page_hint_cmd_id} is set to VIRTIO_BALLOON_CMD_ID_DONE.
> +
>  \section{SCSI Host Device}\label{sec:Device Types / SCSI Host Device}
>  
>  The virtio SCSI host device groups together one or more virtual
> 
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

