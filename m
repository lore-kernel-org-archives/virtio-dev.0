Return-Path: <virtio-dev-return-10102-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4680B986429
	for <virtio-dev@lists.oasis-open.org>; Mon, 31 Oct 2022 13:05:03 +0000 (UTC)
Date: Thu, 27 Oct 2022 17:22:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <Y1r2qQ+Wrx9K0aag@fedora>
References: <20221007165643.3920613-1-usama.arif@bytedance.com>
 <20221007165643.3920613-3-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MEkU/pIVc3PPX7C8"
Content-Disposition: inline
In-Reply-To: <20221007165643.3920613-3-usama.arif@bytedance.com>
Subject: [virtio-dev] Re: [PATCH v3 2/4] content: Introduce driver/device aux.
 notification cfg type for PCI
To: Usama Arif <usama.arif@bytedance.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com
List-ID: <virtio-dev.lists.oasis-open.org>

--MEkU/pIVc3PPX7C8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 07, 2022 at 05:56:41PM +0100, Usama Arif wrote:
> This includes the PCI device conformances for these notification
> capabilities.
>=20
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

You can keep this, but please see comments below.

> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
> ---
>  conformance.tex |   2 +
>  content.tex     | 191 ++++++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 171 insertions(+), 22 deletions(-)
>=20
> diff --git a/conformance.tex b/conformance.tex
> index c3c1d3e..f6914b0 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -370,6 +370,8 @@ \section{Conformance Targets}\label{sec:Conformance /=
 Conformance Targets}
>  \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bu=
s / PCI Device Layout / Notification capability}
>  \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bu=
s / PCI Device Layout / ISR status capability}
>  \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bu=
s / PCI Device Layout / Device-specific configuration}
> +\item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bu=
s / PCI Device Layout / Device auxiliary notification capability}
> +\item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bu=
s / PCI Device Layout / Driver auxiliary notification capability}
>  \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bu=
s / PCI Device Layout / Shared memory capability}
>  \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bu=
s / PCI Device Layout / PCI configuration access capability}
>  \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bu=
s / PCI-specific Initialization And Device Operation / Device Initializatio=
n / Non-transitional Device With Legacy Driver}
> diff --git a/content.tex b/content.tex
> index 49f9f2a..33362b7 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -719,6 +719,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{=
sec:Virtio Transport Option
>  \item ISR Status
>  \item Device-specific configuration (optional)
>  \item PCI configuration access
> +\item Driver auxiliary notifications (optional)
> +\item Device auxiliary notifications (optional)
>  \end{itemize}
> =20
>  Each structure can be mapped by a Base Address register (BAR) belonging =
to
> @@ -765,19 +767,23 @@ \subsection{Virtio Structure PCI Capabilities}\labe=
l{sec:Virtio Transport Option
> =20
>  \begin{lstlisting}
>  /* Common configuration */
> -#define VIRTIO_PCI_CAP_COMMON_CFG        1
> +#define VIRTIO_PCI_CAP_COMMON_CFG             1
>  /* Notifications */
> -#define VIRTIO_PCI_CAP_NOTIFY_CFG        2
> +#define VIRTIO_PCI_CAP_NOTIFY_CFG             2
>  /* ISR Status */
> -#define VIRTIO_PCI_CAP_ISR_CFG           3
> +#define VIRTIO_PCI_CAP_ISR_CFG                3
>  /* Device specific configuration */
> -#define VIRTIO_PCI_CAP_DEVICE_CFG        4
> +#define VIRTIO_PCI_CAP_DEVICE_CFG             4
>  /* PCI configuration access */
> -#define VIRTIO_PCI_CAP_PCI_CFG           5
> +#define VIRTIO_PCI_CAP_PCI_CFG                5
> +/* Device auxiliary notification */
> +#define VIRTIO_PCI_CAP_DEVICE_AUX_NOTIFY_CFG  6
> +/* Driver auxiliary notification */
> +#define VIRTIO_PCI_CAP_DRIVER_AUX_NOTIFY_CFG  7
>  /* Shared memory region */
> -#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
> +#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG      8
>  /* Vendor-specific data */
> -#define VIRTIO_PCI_CAP_VENDOR_CFG        9
> +#define VIRTIO_PCI_CAP_VENDOR_CFG             9
>  \end{lstlisting}
> =20
>          Any other value is reserved for future use.
> @@ -1158,11 +1164,11 @@ \subsubsection{ISR status capability}\label{sec:V=
irtio Transport Options / Virti
>  The ISR bits allow the driver to distinguish between device-specific con=
figuration
>  change interrupts and normal virtqueue interrupts:
> =20
> -\begin{tabular}{ |l||l|l|l| }
> +\begin{tabular}{ |l||l|l|l|l| }
>  \hline
> -Bits       & 0                               & 1               &  2 to 3=
1 \\
> +Bits       & 0                               & 1                        =
        & 2                      & 3 to 31 \\
>  \hline
> -Purpose    & Queue Interrupt  & Device Configuration Interrupt & Reserve=
d \\
> +Purpose    & Queue Interrupt  & Device Configuration Interrupt & Driver =
Auxiliary Notification Interrupt & Reserved \\
>  \hline
>  \end{tabular}
> =20
> @@ -1208,6 +1214,135 @@ \subsubsection{Device-specific configuration}\lab=
el{sec:Virtio Transport Options
> =20
>  The \field{offset} for the device-specific configuration MUST be 4-byte =
aligned.
> =20
> +\subsubsection{Device auxiliary notification capability}\label{sec:Virti=
o Transport Options / Virtio Over PCI Bus / PCI Device Layout / Device auxi=
liary notification capability}
> +
> +The device auxiliary notification \ref{sec:Basic Facilities of a Virtio =
Device / Notifications}
> +location is found using the VIRTIO_PCI_CAP_DEVICE_AUX_NOTIFY_CFG capabil=
ity. This
> +capability is immediately followed by an additional field, like so:
> +
> +\begin{lstlisting}
> +struct virtio_pci_dev_aux_notification_cap {
> +        struct virtio_pci_cap cap;
> +        le32 dev_aux_notification_off_multiplier;
> +};
> +\end{lstlisting}
> +
> +The device auxiliary notification address within a BAR is calculated as =
follows:
> +
> +\begin{lstlisting}
> +cap.offset + dev_aux_notification_idx * dev_aux_notification_off_multipl=
ier
> +\end{lstlisting}
> +
> +The \field{cap.offset} and \field{dev_aux_notification_off_multiplier} a=
re taken
> +from the device auxiliary notification capability structure above, and t=
he
> +\field{dev_aux_notification_idx} is the device auxiliary notification in=
dex.
> +There is no restriction for the mapping between device auxiliary notific=
ations
> +and dev_aux_notification_idx. The number of device auxiliary notificatio=
ns and
> +their purpose is device-specific.
> +
> +\devicenormative{\paragraph}{Device auxiliary notification capability}{V=
irtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Device =
auxiliary notification capability}
> +
> +The data width of the device auxiliary notifications is device specific.
> +
> +For devices that provide a data width of 1 byte:
> +
> +The \field{cap.offset} MUST be byte aligned.

How can it not be byte-aligned? The offset field is in units of bytes. I
suggest dropping this sentence.

> +
> +The value \field{cap.length} presented by the device MUST be at least 1
> +and MUST be large enough to support device auxiliary notification offset=
s for all supported
> +device auxiliary notifications in all possible configurations.
> +
> +The value \field{cap.length} presented by the device MUST satisfy:
> +
> +\begin{lstlisting}
> +cap.length >=3D max_dev_aux_notification_idx * dev_aux_notification_off_=
multiplier + 1
> +\end{lstlisting}
> +
> +where \field{max_dev_aux_notification_idx} is the maximum device auxilia=
ry
> +notification index and is dependent on the device.
> +
> +For devices that provide a data width of 2 bytes:
> +
> +The \field{cap.offset} MUST be 2-byte aligned.
> +
> +The device MUST either present \field{dev_aux_notification_off_multiplie=
r} as an
> +even power of 2, or present \field{dev_aux_notification_off_multiplier} =
as 0.
> +
> +The value \field{cap.length} presented by the device MUST be at least 2
> +and MUST be large enough to support device auxiliary notification offset=
s for
> +all supported device auxiliary notifications in all possible configurati=
ons.
> +
> +The value \field{cap.length} presented by the device MUST satisfy:
> +
> +\begin{lstlisting}
> +cap.length >=3D max_dev_aux_notification_idx * dev_aux_notification_off_=
multiplier + 2
> +\end{lstlisting}
> +
> +where \field{max_dev_aux_notification_idx} is the maximum device auxilia=
ry
> +notification index and is dependent on the device.
> +
> +For devices that provide a data width of 4 bytes:
> +
> +The \field{cap.offset} MUST be 4-byte aligned.
> +
> +The device MUST either present \field{dev_aux_notification_off_multiplie=
r} as a
> +number that is a power of 2 that is also a multiple 4, or present
> +\field{dev_aux_notification_off_multiplier} as 0.
> +
> +The value \field{cap.length} presented by the device MUST be at least 4
> +and MUST be large enough to support device auxiliary notification offset=
s for all supported
> +device auxiliary notifications in all possible configurations.
> +
> +The value \field{cap.length} presented by the device MUST satisfy:
> +
> +\begin{lstlisting}
> +cap.length >=3D max_dev_aux_notification_idx * dev_aux_notification_off_=
multiplier + 4
> +\end{lstlisting}
> +
> +where \field{max_dev_aux_notification_idx} is the maximum device auxilia=
ry
> +notification index and is dependent on the device.
> +
> +\subsubsection{Driver auxiliary notification capability}\label{sec:Virti=
o Transport Options / Virtio Over PCI Bus / PCI Device Layout / Driver auxi=
liary notification capability}
> +
> +The Driver auxiliary notification
> +\ref{sec:Basic Facilities of a Virtio Device / Notifications} location
> +is found using the VIRTIO_PCI_CAP_DRIVER_AUX_NOTIFY_CFG capability. The
> +driver auxiliary notification structure allows MSI-X vectors to be
> +configured for notification interrupts. If MSI-X is not available, bit 2
> +of the ISR status \ref{sec:Virtio Transport Options / Virtio Over PCI
> +Bus / PCI Device Layout / ISR status capability} indicates that a
> +driver auxiliary notification occurred. If MSI-X is not available,
> +it is not possible to determine which driver auxiliary notification occu=
red,
> +hence only a single notification is supported.
> +
> +The driver auxiliary notification structure is the following:
> +
> +\begin{lstlisting}
> +struct virtio_pci_driver_aux_notification_cfg {
> +	le16 driver_aux_notification_select;              /* read-write */
> +	le16 driver_aux_notification_msix_vector;         /* read-write */
> +};
> +\end{lstlisting}
> +
> +The driver indicates which notification is of interest by writing the
> +\field{driver_aux_notification_select} field. The driver then writes the=
 MSI-X
> +vector or VIRTIO_MSI_NO_VECTOR to \field{driver_aux_notification_msix_ve=
ctor} to
> +change the MSI-X vector for that notification.
> +
> +The mapping between notifications and notification indices is
> +device-specific. The total number of notifications is also
> +device-specific.
> +
> +\devicenormative{\paragraph}{Driver auxiliary notification capability}{V=
irtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Driver =
auxiliary notification capability}
> +
> +Device MUST ignore writes to \field{driver_aux_notification_msix_vector}=
 if the
> +value written to \field{driver_aux_notification_select} is not a valid n=
otification
> +index.
> +
> +Device MUST return VIRTIO_MSI_NO_VECTOR for reads from
> +\field{driver_aux_notification_msix_vector} if the value written to
> +\field{driver_aux_notification_select} is not a valid notification index.
> +
>  \subsubsection{Shared memory capability}\label{sec:Virtio Transport Opti=
ons / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
> =20
>  Shared memory regions \ref{sec:Basic Facilities of a Virtio
> @@ -1519,15 +1654,17 @@ \subsubsection{Device Initialization}\label{sec:V=
irtio Transport Options / Virti
>  \paragraph{MSI-X Vector Configuration}\label{sec:Virtio Transport Option=
s / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation =
/ Device Initialization / MSI-X Vector Configuration}
> =20
>  When MSI-X capability is present and enabled in the device
> -(through standard PCI configuration space) \field{config_msix_vector} an=
d \field{queue_msix_vector} are used to map configuration change and queue
> -interrupts to MSI-X vectors. In this case, the ISR Status is unused.
> +(through standard PCI configuration space) \field{config_msix_vector},
> +\field{queue_msix_vector} and \field{driver_aux_notification_msix_vector=
} are used
> +to map configuration change, queue and device-specific interrupts to
> +MSI-X vectors respectively. In this case, the ISR Status is unused.
> =20
>  Writing a valid MSI-X Table entry number, 0 to 0x7FF, to
> -\field{config_msix_vector}/\field{queue_msix_vector} maps interrupts tri=
ggered
> -by the configuration change/selected queue events respectively to
> -the corresponding MSI-X vector. To disable interrupts for an
> -event type, the driver unmaps this event by writing a special NO_VECTOR
> -value:
> +\field{config_msix_vector}/\field{queue_msix_vector}/\field{driver_aux_n=
otification_msix_vector}
> +maps interrupts triggered by the configuration change/selected
> +queue/device-specific events respectively to the corresponding MSI-X
> +vector. To disable interrupts for an event type, the driver unmaps this
> +event by writing a special NO_VECTOR value:
> =20
>  \begin{lstlisting}
>  /* Vector value used to disable MSI for queue */
> @@ -1541,6 +1678,14 @@ \subsubsection{Device Initialization}\label{sec:Vi=
rtio Transport Options / Virti
> =20
>  A device that has an MSI-X capability SHOULD support at least 2
>  and at most 0x800 MSI-X vectors.
> +
> +A device that has an MSI-X capability MUST support atleast:

"at least"

> +\begin{lstlisting}
> +num_msix_vectors >=3D 1 /* config_msix_vector */ + num_vqs /* queue_msix=
_vectors */ + num_driver_aux_notifications
> +\end{lstlisting}
> +where num_vqs is the number of virtqueues and num_driver_aux_notificatio=
ns is
> +the number of driver auxiliary notifications.

Is this a new requirement? I'm not aware of any limit on num_vqs vs
MSI-X vectors. I think it's possible to have a device that supports more
vqs than MSI-X vectors. We probably shouldn't introduce a requirement
that makes existing devices non-compliant.

> +
>  Device MUST report the number of vectors supported in
>  \field{Table Size} in the MSI-X Capability as specified in
>  \hyperref[intro:PCI]{[PCI]}.
> @@ -1554,16 +1699,18 @@ \subsubsection{Device Initialization}\label{sec:V=
irtio Transport Options / Virti
>  vector 0 to MSI-X \field{Table Size}.
>  Device MUST support unmapping any event type.
> =20
> -The device MUST return vector mapped to a given event,
> -(NO_VECTOR if unmapped) on read of \field{config_msix_vector}/\field{que=
ue_msix_vector}.
> -The device MUST have all queue and configuration change
> -events are unmapped upon reset.
> +The device MUST return the vector mapped to a given event,
> +(NO_VECTOR if unmapped) on read of
> +\field{config_msix_vector}/\field{queue_msix_vector}/\field{driver_aux_n=
otification_msix_vector}.
> +The device MUST have all queue/configuration change/device-specific
> +events unmapped upon reset.
> =20
>  Devices SHOULD NOT cause mapping an event to vector to fail
>  unless it is impossible for the device to satisfy the mapping
>  request.  Devices MUST report mapping
>  failures by returning the NO_VECTOR value when the relevant
> -\field{config_msix_vector}/\field{queue_msix_vector} field is read.=20
> +\field{config_msix_vector}/\field{queue_msix_vector}/\field{driver_aux_n=
otification_msix_vector}
> +field is read.
> =20
>  \drivernormative{\subparagraph}{MSI-X Vector Configuration}{Virtio Trans=
port Options / Virtio Over PCI Bus / PCI-specific Initialization And Device=
 Operation / Device Initialization / MSI-X Vector Configuration}
> =20
> --=20
> 2.25.1
>=20

--MEkU/pIVc3PPX7C8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmNa9qkACgkQnKSrs4Gr
c8h9Ygf6AqI6teu7pjtgaswNDytUrGdxhIS76s/ospSlEhdWYRWznEG5Qq3EL418
VrdHhbnyGrmAHQP+mdU8APm+8D8rYgUpU3CRs0m4VshFUpbc+zJp+DAKtELe312/
sddAbQ3B4jCP0b2q3ooii6xCyy1boEtwDG+ZG1UWyQ4X2Kfz8lYp5VVo8UBEs3ls
Ha/wEEK8KvwWpjXQWg7dpptWbaK0RIJE3QF5CU0fzRmhM+XEz1AhyUQ+LbmnuAKV
VfV0kl913WSEpDXd8o2vMr3SZXatDXoyoIVwqTcOYK2gQ/U/JeRIURe3SnZxra6X
/Ois6qasSHO6iuQYD2cXKhS+fbxwTw==
=5fLg
-----END PGP SIGNATURE-----

--MEkU/pIVc3PPX7C8--

