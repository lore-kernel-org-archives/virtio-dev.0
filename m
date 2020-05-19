Return-Path: virtio-comment-return-1270-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <158956393696.246123.9443729217250549606.stgit@ahduyck-workstation>
 <158956400429.246123.15328266658164976911.stgit@ahduyck-workstation>
From: David Hildenbrand <david@redhat.com>
Message-ID: <16b7b50f-880b-b9f7-a356-540c6a863850@redhat.com>
Date: Tue, 19 May 2020 12:27:42 +0200
MIME-Version: 1.0
In-Reply-To: <158956400429.246123.15328266658164976911.stgit@ahduyck-workstation>
Content-Language: en-US
Subject: Re: [virtio-comment] [PATCH v2 3/3] content: Document balloon feature
 free page reporting
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>, mst@redhat.com, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 15.05.20 19:33, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>=20
> Free page reporting is a feature that allows the guest to proactively
> report unused pages to the host. By making use of this feature is is
> possible to reduce the overall memory footprint of the guest in cases whe=
re
> some significant portion of the memory is idle. Add documentation for the
> free page reporting feature describing the functionality and requirements=
.
>=20
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  content.tex |   84 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 83 insertions(+), 1 deletion(-)
>=20
> diff --git a/content.tex b/content.tex
> index 3d30fd5bb6fa..3cb38105f794 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -5007,12 +5007,15 @@ \subsection{Virtqueues}\label{sec:Device Types / =
Memory Balloon Device / Virtque
>  \item[1] deflateq
>  \item[2] statsq
>  \item[3] free_page_vq
> +\item[4] reporting_vq
>  \end{description}
> =20
>    statsq only exists if VIRTIO_BALLOON_F_STATS_VQ is set.
> =20
>    free_page_vq only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set.
> =20
> +  reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set.
> +
>  \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device=
 / Feature bits}
>  \begin{description}
>  \item[VIRTIO_BALLOON_F_MUST_TELL_HOST (0)] Host has to be told before
> @@ -5029,6 +5032,8 @@ \subsection{Feature bits}\label{sec:Device Types / =
Memory Balloon Device / Featu
>  \item[ VIRTIO_BALLOON_F_PAGE_POISON(4) ] The device has to be notified i=
f
>      the driver is expecting balloon pages to contain a certain value whe=
n
>      returned. Configuration field poison_val is valid.
> +\item[ VIRTIO_BALLOON_F_PAGE_REPORTING(5) ] The device has support for f=
ree
> +    page reporting. A virtqueue for reporting free guest memory is prese=
nt.
> =20
>  \end{description}
> =20
> @@ -5039,6 +5044,10 @@ \subsection{Feature bits}\label{sec:Device Types /=
 Memory Balloon Device / Featu
>  The driver SHOULD clear the VIRTIO_BALLOON_F_PAGE_POISON flag if it is n=
ot
>  expecting any specific value to be stored in the page.
> =20
> +If the driver is expecting the pages to retain some initialized value,
> +it MUST NOT accept VIRTIO_BALLOON_F_PAGE_REPORTING unless it also
> +negotiates VIRTIO_BALLOON_F_PAGE_POISON.
> +

Is "accept" really the right word here? Below you use "negotiate", which
makes more sense.

>  \devicenormative{\subsubsection}{Feature bits}{Device Types / Memory Bal=
loon Device / Feature bits}
>  If the device offers the VIRTIO_BALLOON_F_MUST_TELL_HOST feature
>  bit, and if the driver did not accept this feature bit, the
> @@ -5101,10 +5110,16 @@ \subsection{Device Initialization}\label{sec:Devi=
ce Types / Memory Balloon Devic
>  \item If the VIRTIO_BALLOON_F_PAGE_POISON feature bit is negotiated, the
>    driver updates the \field{poison_val} configuration field.
> =20
> +\item If the VIRTIO_BALLOON_F_PAGE_REPORTING feature bit is negotiated t=
he
> +  reporting_vq is identified.
> +
>  \item DRIVER_OK is set: device operation begins.
> =20
>  \item If the VIRTIO_BALLOON_F_STATS_VQ feature bit is negotiated, then
>    notify the device about the stats virtqueue buffer.
> +
> +\item If the VIRTIO_BALLOON_F_PAGE_REPORTING feature bit is negotiated t=
hen
> +  begin reporting free pages to device.
>  \end{enumerate}
> =20
>  \subsection{Device Operation}\label{sec:Device Types / Memory Balloon De=
vice / Device Operation}
> @@ -5478,7 +5493,9 @@ \subsubsection{Page Poison}\label{sec:Device Types =
/ Memory Balloon Device / Dev
> =20
>  Page Poison provides a way to notify the host of the contents that are
>  currently in the balloon pages, and those that are expected to be in the
> -pages when they are pulled from the balloon.
> +pages when they are pulled from the balloon. It is used for in-place
> +reporting of pages without needing to pull them from the memory allocato=
r
> +of the guest.

Let's see how that looks like after you modify patch #2.

> =20
>  If VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the guest
>  will place the expected poison value into the \field{poison_val}
> @@ -5504,6 +5521,71 @@ \subsubsection{Page Poison}\label{sec:Device Types=
 / Memory Balloon Device / Dev
>  page hinting, the device MAY ignore the content of \field{poison_val}
>  for those operations.
> =20
> +\subsubsection{Free Page Reporting}\label{sec:Device Types / Memory Ball=
oon Device / Device Operation / Free Page Reporting}
> +
> +Free Page Reporting provides a mechanism similar to balloon inflation,
> +however it does not provide a deflation queue. The expectation is that t=
he
> +device will have a means by which it can detect the guest page access an=
d
> +fault in such pages with some initial value, likely a zero page.
> +
> +The driver will respond to to memory conditions and begin reporting free

"to to memory conditions" I don't understand what you are trying to say.
The driver will simply report some free pages (e.g., of a guest-specific
minimum size) when it feels like the right time has come.

This (and below) is too implementation specific. You could just
implement a driver that hints a single page every time it is getting
freed. Nothing wrong about that. There is just the option do to a bulk
report whenever the driver feels like doing it.

> +pages when some number of pages are available.
> +
> +\begin{enumerate}
> +
> +\item The driver determines it has enough pages available to begin
> +  reporting pages.
> +
> +\item The driver gathers pages into a scatter-gather list and adds them =
to
> +  the reporting_vq.
> +
> +\item The device acknowledges the reporting request by using the
> +  reporting_vq descriptor.
> +
> +\item Once the device has acknowledged the report, the pages can be
> +  returned to the location from which they were pulled.
> +
> +\item The driver can then continue to gather and report pages until it
> +  has determined it has reported a sufficient quantity of pages.
> +
> +\end{enumerate}
> +
> +\drivernormative{\paragraph}{Free Page Reporting}{Device Types / Memory =
Balloon Device / Device Operation / Free Page Reporting}
> +
> +Normative statements in this section apply if the
> +VIRTIO_BALLOON_F_PAGE_REPORTING feature has been negotiated.
> +
> +If the driver is expecting the free page to contain some initial value i=
t
> +MUST NOT negotiate this feature without negotiating the
> +VIRTIO_BALLOON_F_PAGE_POISON feature as well and supply this value via
> +\field{poison_val}.
> +
> +If the driver is expecting the pages to retain some initialized value,
> +it MUST NOT accept VIRTIO_BALLOON_F_PAGE_REPORTING unless it also
> +negotiates the VIRTIO_BALLOON_F_PAGE_POISON feature and supplies this
> +value via \field{poison_val}.

I'd probably do something like

The driver MUST NOT negotiate VIRTIO_BALLOON_F_PAGE_REPORTING without
VIRTIO_BALLOON_F_PAGE_POISON in case it relies on reported pages to not
change their content.

The driver MUST negotiate VIRTIO_BALLOON_F_PAGE_REPORTING and
VIRTIO_BALLOON_F_PAGE_POISON in case it relies on reported pages to be
filled with \field{poison_val} when reusing them.

But I'll have to double check your QEMU patches :)

> +
> +The driver MUST NOT use the reported pages until the device has
> +acknowledged the reporting request.
> +
> +The driver MAY report free pages any time after DRIVER_OK is set.

Now, this is the right thing to document. Maybe also something like "The
driver MAY decide to not report some free pages, especially of smaller
granularity."

> +
> +It is RECOMMENDED that the driver avoid unnecessary reads or writes to t=
he

s/avoid/avoids/

> +page contents as this could reduce the performance for free page reporti=
ng.
> +
You're the second user of RECOMMENDED.

I'd do: "The driver SHOULD avoid unnecessary reads ..."

> +\devicenormative{\paragraph}{Free Page Reporting}{Device Types / Memory =
Balloon Device / Device Operation / Free Page Reporting}
> +
> +Normative statements in this section apply if the
> +VIRTIO_BALLOON_F_PAGE_REPORTING feature has been negotiated.
> +
> +The device MAY modify the contents of any page supplied in a report
> +request even before acknowledging that request by using the
> +reporting_vq descriptor.
> +
> +If the VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the dev=
ice
> +SHALL NOT modify the the page if this will result in the page containing=
 a
> +value other than \field{poison_val}.

You're the first user of "SHALL NOT" -> "MUST NOT" ?

s/the the page/the content of a reported page/

"If the VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the
device MUST NOT modify the content of a reported page to something other
than than \field{poison_val}." ?

> +
>  \section{SCSI Host Device}\label{sec:Device Types / SCSI Host Device}
> =20


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

