Return-Path: virtio-comment-return-1226-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Mon, 11 May 2020 14:36:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20200511143609.61d813f8.cohuck@redhat.com>
In-Reply-To: <158895819643.529821.7983378511879531418.stgit@ahduyck-workstation>
References: <158895811782.529821.115832709184722087.stgit@ahduyck-workstation>
	<158895819643.529821.7983378511879531418.stgit@ahduyck-workstation>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH 3/3] content: Document balloon feature free page
 reporting
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: virtio-comment@lists.oasis-open.org, mst@redhat.com, david@redhat.com, virtio-dev@lists.oasis-open.org, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 08 May 2020 10:16:36 -0700
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Free page reporting is a feature that allows the guest to proactively
> report unused pages to the host. By making use of this feature is is
> possible to reduce the overall memory footprint of the guest in cases where
> some significant portion of the memory is idle. Add documentation for the
> free page reporting feature describing the functionality and requirements.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  content.tex |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index e154948a9a1a..97a2c01d498f 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -5007,12 +5007,15 @@ \subsection{Virtqueues}\label{sec:Device Types / Memory Balloon Device / Virtque
>  \item[1] deflateq
>  \item[2] statsq
>  \item[3] free_page_vq
> +\item[4] reporting_vq
>  \end{description}
>  
>    statsq only exists if VIRTIO_BALLOON_F_STATS_VQ is set.
>  
>    free_page_vq only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set.
>  
> +  reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set.
> +
>  \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Feature bits}
>  \begin{description}
>  \item[VIRTIO_BALLOON_F_MUST_TELL_HOST (0)] Host has to be told before
> @@ -5029,6 +5032,8 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
>  \item[ VIRTIO_BALLOON_F_PAGE_POISON(4) ] Host has to be notified if guest
>      is expecting reported pages to contain a certain value when returned.
>      Configuration field poison_val is valid.
> +\item[ VIRTIO_BALLOON_F_PAGE_REPORTING(5) ] Device has support for free

s/Device/The device/

> +    page reporting. A virtqueue for reporting free guest memory is present.
>  
>  \end{description}
>  
> @@ -5039,6 +5044,10 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
>  The driver SHOULD clear the VIRTIO_BALLOON_F_PAGE_POISON flag if it is not
>  expecting any specific value to be stored in the page.
>  
> +The driver MUST NOT accept VIRTIO_BALLOON_F_PAGE_REPORTING if it is expecting
> +the pages to retain some initialized value and it has not negotiated
> +VIRTIO_BALLOON_F_PAGE_POISON as a feature.

"If the driver is expecting the pages to retain some initialized value,
it MUST NOT accept VIRTIO_BALLOON_F_PAGE_REPORTING unless it also
negotiates VIRTIO_BALLOON_F_PAGE_POISON." ?

> +
>  \devicenormative{\subsubsection}{Feature bits}{Device Types / Memory Balloon Device / Feature bits}
>  If the device offers the VIRTIO_BALLOON_F_MUST_TELL_HOST feature
>  bit, and if the driver did not accept this feature bit, the

(...)

> +\drivernormative{\paragraph}{Free Page Reporting}{Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
> +
> +Normative statements in this section apply if the
> +VIRTIO_BALLOON_F_PAGE_REPORTING feature has been negotiated.
> +
> +If the driver is expecting the free page to contain some initial value it
> +MUST NOT negotiate this feature without negotiating the
> +VIRTIO_BALLOON_F_PAGE_POISON feature as well and supply this value via
> +\field{poison_val}.

Maybe use my suggestion from above (and add the "and supply...")?

> +
> +The driver MUST NOT use the reported pages until the device has
> +acknowledged the reporting request.
> +
> +The driver MAY report free pages any time after DRIVER_OK is set.
> +
> +It is RECOMMENDED that the driver avoid unnecessary reads or writes to the
> +page contents as this could reduce the performance for free page reporting.
> +
> +\devicenormative{\paragraph}{Free Page Reporting}{Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
> +
> +Normative statements in this section apply if the
> +VIRTIO_BALLOON_F_PAGE_REPORTING feature has been negotiated.
> +
> +The device MAY modify the contents of a page in the report after detecting
> +its physical number in an report request and before acknowledging the
> +reporting request by using the reporting_vq descriptor.

"The device MAY modify the contents of any page supplied in a report
request even before acknowledging that request by using the
reporting_vq descriptor." ?

> +
> +If the VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the device
> +SHALL NOT modify the the page if this will result in the page containing a
> +value other than \field{poison_val}.
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

