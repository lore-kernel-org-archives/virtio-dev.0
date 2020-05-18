Return-Path: virtio-comment-return-1260-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <158956393696.246123.9443729217250549606.stgit@ahduyck-workstation>
 <158956398852.246123.13563550180731658368.stgit@ahduyck-workstation>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7558cc20-262b-ddc4-2442-e05f0b74b59d@redhat.com>
Date: Mon, 18 May 2020 15:18:48 +0200
MIME-Version: 1.0
In-Reply-To: <158956398852.246123.13563550180731658368.stgit@ahduyck-workstation>
Content-Language: en-US
Subject: Re: [virtio-comment] [PATCH v2 1/3] content: Document balloon feature
 free page hints
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>, mst@redhat.com, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 15.05.20 19:33, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>=20
> Free page hints allow the balloon driver to provide information on what
> pages are not currently in use so that we can avoid the cost of copying
> them in migration scenarios. Add a feature description for free page hint=
s
> describing basic functioning and requirements.
>=20
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  content.tex |  128 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 122 insertions(+), 6 deletions(-)
>=20
> diff --git a/content.tex b/content.tex
> index 91735e3eb018..ec0abf177526 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -5005,10 +5005,13 @@ \subsection{Virtqueues}\label{sec:Device Types / =
Memory Balloon Device / Virtque
>  \begin{description}
>  \item[0] inflateq
>  \item[1] deflateq
> -\item[2] statsq.
> +\item[2] statsq
> +\item[3] free_page_vq
>  \end{description}
> =20
> -  Virtqueue 2 only exists if VIRTIO_BALLOON_F_STATS_VQ set.
> +  statsq only exists if VIRTIO_BALLOON_F_STATS_VQ is set.
> +
> +  free_page_vq only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set.
> =20
>  \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device=
 / Feature bits}
>  \begin{description}
> @@ -5019,6 +5022,10 @@ \subsection{Feature bits}\label{sec:Device Types /=
 Memory Balloon Device / Featu
>      memory statistics is present.
>  \item[VIRTIO_BALLOON_F_DEFLATE_ON_OOM (2) ] Deflate balloon on
>      guest out of memory condition.
> +\item[ VIRTIO_BALLOON_F_FREE_PAGE_HINT(3) ] The device has support for f=
ree
> +    page hinting. A virtqueue for providing hints as to what memory is
> +    currently free is present. Configuration field free_page_hint_cmd_id
> +    is valid.

\field{free_page_hint_cmd_id} ?

> =20
>  \end{description}
> =20
> @@ -5042,13 +5049,17 @@ \subsection{Feature bits}\label{sec:Device Types =
/ Memory Balloon Device / Featu
>  VIRTIO_BALLOON_F_MUST_TELL_HOST is not negotiated.
> =20
>  \subsection{Device configuration layout}\label{sec:Device Types / Memory=
 Balloon Device / Device configuration layout}
> -  Both fields of this configuration
> -  are always available.
> +  \field{num_pages} and \field{actual} are always available.
> +
> +  \field{free_page_hint_cmd_id} is available if
> +    VIRTIO_BALLOON_F_FREE_PAGE_HINT has been negotiated and is read-only=
 by
> +    the driver.
> =20
>  \begin{lstlisting}
>  struct virtio_balloon_config {
>          le32 num_pages;
>          le32 actual;
> +        le32 free_page_hint_cmd_id;
>  };
>  \end{lstlisting}
> =20
> @@ -5072,9 +5083,15 @@ \subsection{Device Initialization}\label{sec:Devic=
e Types / Memory Balloon Devic
>    \begin{enumerate}
>    \item Identify the stats virtqueue.
>    \item Add one empty buffer to the stats virtqueue.
> -  \item DRIVER_OK is set: device operation begins.
> -  \item Notify the device about the stats virtqueue buffer.
>    \end{enumerate}
> +
> +\item If the VIRTIO_BALLOON_F_FREE_PAGE_HINT feature bit is negotiated, =
the
> +  free_page_vq is identified.
> +
> +\item DRIVER_OK is set: device operation begins.
> +
> +\item If the VIRTIO_BALLOON_F_STATS_VQ feature bit is negotiated, then
> +  notify the device about the stats virtqueue buffer.
>  \end{enumerate}
> =20
>  \subsection{Device Operation}\label{sec:Device Types / Memory Balloon De=
vice / Device Operation}
> @@ -5345,6 +5362,105 @@ \subsubsection{Memory Statistics Tags}\label{sec:=
Device Types / Memory Balloon D
>    allocations in the guest.
>  \end{description}
> =20
> +\subsubsection{Free Page Hinting}\label{sec:Device Types / Memory Balloo=
n Device / Device Operation / Free Page Hinting}
> +
> +Free page hinting is designed to be used during migration to determine w=
hat
> +pages within the guest are currently unused so that they can be skipped =
over
> +while migrating the guest. The device will indicate that it is ready to =
start
> +performing hinting by setting the \field{free_page_hint_cmd_id} to one o=
f the
> +non-reserved values that can be used as a command ID. The following valu=
es
> +are reserved:
> +
> +\begin{description}
> +\item[VIRTIO_BALLOON_CMD_ID_STOP (0)] Any command ID previously supplied=
 by
> +  the device is invalid. The driver should halt all hinting until a new
> +  command ID is supplied.

Maybe "The driver should stop hinting free pages, but should not reuse
all previously hinted pages."

> +
> +\item[VIRTIO_BALLOON_CMD_ID_DONE (1)] Any command ID previously supplied=
 by
> +  the device is invalid. The driver should halt all hinting and the hint=
ing
> +  balloon can now be deflated returning all pages to the guest.

I would avoid the terminology "hinting balloon" and "deflation".

"The driver should stop hinting free pages and should reuse all
previously hinted pages.".

> +\end{description}
> +
> +A request for free page hinting proceeds as follows:
> +
> +\begin{enumerate}
> +
> +\item The driver examines the \field{free_page_hint_cmd_id} configuratio=
n field.
> +  If it contains a non-reserved value then inflation of the balloon will=
 begin.
> +
> +\item To supply memory to the hinting balloon:
> +  \begin{enumerate}
> +  \item The driver constructs an output descriptor containing the new va=
lue
> +    from the \field{free_page_hint_cmd_id} configuration field and adds =
it to
> +    the free_page_hint_vq.
> +  \item The driver maps a series of pages and adds them to the
> +    free_page_hint_vq as individual scatter-gather input descriptor entr=
ies.
> +  \item When the driver is no longer able to fetch additional pages to a=
dd
> +    to the free_page_hint_vq, it will construct an output descriptor
> +    containing the command ID VIRTIO_BALLOON_CMD_ID_STOP.
> +  \end{enumerate}
> +
> +\item A round of hinting ends either when the driver is no longer able t=
o
> +  add more pages to the balloon as described above, or when the device
> +  updates \field{free_page_hint_cmd_id} configuration field contain eith=
er
> +  VIRTIO_BALLOON_CMD_ID_STOP or VIRTIO_BALLOON_CMD_ID_DONE.
> +
> +\item The device may follow VIRTIO_BALLOON_CMD_ID_STOP with a new
> +  non-reserved value for the \field{free_page_hint_cmd_id} configuration
> +  field in which case it will resume supplying the hinting balloon.

Again, I would avoid any kind of "hinting balloon" terminology.

> +
> +\item Otherwise, if the device provides VIRTIO_BALLOON_CMD_ID_DONE then
> +  hinting is complete and the guest may begin to re-use pages previously
> +  given to the balloon.

See my rephrase attempt above.

> +
> +\end{enumerate}
> +
> +\drivernormative{\paragraph}{Free Page Hinting}{Device Types / Memory Ba=
lloon Device / Device Operation / Free Page Hinting}
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
> +\field{free_page_hint_cmd_id} reports a value of VIRTIO_BALLOON_CMD_ID_S=
TOP.
> +
> +If the driver is unable to supply pages, it MUST complete hinting by add=
ing
> +an output descriptor containing the command ID VIRTIO_BALLOON_CMD_ID_STO=
P.
> +
> +The driver MAY use pages from the balloon after adding them to the ballo=
on,
> +including when the device has not yet used the descriptor containing the
> +hinting request.
> +
> +The driver SHOULD return pages for use once \field{free_page_hint_cmd_id=
}
> +reports a value of VIRTIO_BALLOON_CMD_ID_DONE.

"return pages" -> "start to reuse all previously hinted pages".


Also,

"The driver MUST reinitialize hinted pages before reusing them."

> +
> +\devicenormative{\paragraph}{Free Page Hinting}{Device Types / Memory Ba=
lloon Device / Device Operation / Free Page Hinting}
> +
> +Normative statements in this section apply if the
> +VIRTIO_BALLOON_F_FREE_PAGE_HINT feature has been negotiated.
> +
> +The device MUST set \field{free_page_hint_cmd_id} to
> +VIRTIO_BALLOON_CMD_ID_STOP any time that the dirty pages for the given
> +guest are being recorded.
> +
> +The device MUST NOT reuse a command ID until it has received an output
> +descriptor containing VIRTIO_BALLOON_CMD_ID_STOP from the driver.
> +
> +The device MUST ignore pages that are provided with a command ID that do=
es
> +not match the current value in \field{free_page_hint_cmd_id}.
> +
> +The device MAY modify the contents of the page in the balloon if the pag=
e
> +has not been modified by the guest since the \field{free_page_hint_cmd_i=
d}
> +associated with the hint was issued by the device.

"page in the balloon" -> "previously hinted pages"

But it's not that easy in respect to the guest reusing the pages.

"previously hinted pages and not reused pages" ?

Also, something like

"The device MUST NOT modify the contents of previously hinted pages in
case they are reused by the devices, even if they are reused by the
driver before the hinting request is processed."

?

> +
> +The device MAY NOT modify the contents of the balloon after
> +\field{free_page_hint_cmd_id} is set to VIRTIO_BALLOON_CMD_ID_DONE.

"contents of the balloon" is misleading. What exactly did you want to
say here? Modifying the content of previously hinted pages?

"MAY NOT" does not exist in RFC2119. Was this meant to be "MUST NOT".

> +
>  \section{SCSI Host Device}\label{sec:Device Types / SCSI Host Device}
> =20
>  The virtio SCSI host device groups together one or more virtual
>=20
>=20
>=20

Whenever you add new normative sections/paragraphs, you also have to
link to them from conformance.tex (both, for devices and drivers).


In addition, we should document that VIRTIO_BALLOON_F_MUST_TELL_HOST
does not affect VIRTIO_BALLOON_F_FREE_PAGE_HINT.

--=20
Thanks,

David / dhildenb


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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

