Return-Path: virtio-dev-return-7057-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 20D9F985F3D
	for <virtio-dev@lists.oasis-open.org>; Tue, 14 Apr 2020 10:42:45 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
References: <20200330163413.975345-1-anton.yakovlev@opensynergy.com>
Message-ID: <ceb22f05-67d5-e897-e31f-e07623a1e758@opensynergy.com>
Date: Tue, 14 Apr 2020 12:41:52 +0200
MIME-Version: 1.0
In-Reply-To: <20200330163413.975345-1-anton.yakovlev@opensynergy.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v8] virtio-snd: add virtio sound device specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, kraxel@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi all,

There seems to be no additional comments here. Is it ready to vote then?


On 30.03.2020 18:34, Anton Yakovlev wrote:
> From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
>=20
> This patch proposes virtio specification for a new virtio sound device,
> that may be useful in case when having audio is required but a device
> passthrough or emulation is not an option.
>=20
> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> ---
>=20
> v7->v8 changes:
> 1. Add a universal control request to query information about any
>     configuration item (jacks, streams and channel maps). The request
>     allows to get information in one by one or in a batch manner.
> 2. Add a common information header that allows to link items together
>     in a unified way.
> 3. Rework a jack configuration as a jack information structure.
> 4. Rework a stream configuration as a stream information structure.
> 5. Make a channel map as a separate item and add the
>     "Channel Map Control Messages" section.
>=20
>   conformance.tex  |  33 +-
>   content.tex      |   1 +
>   introduction.tex |   3 +
>   virtio-sound.tex | 807 +++++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 841 insertions(+), 3 deletions(-)
>   create mode 100644 virtio-sound.tex
>=20
> diff --git a/conformance.tex b/conformance.tex
> index b6fdec0..ffa1f76 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -15,7 +15,7 @@ \section{Conformance Targets}\label{sec:Conformance / C=
onformance Targets}
>     \begin{itemize}
>       \item Clause \ref{sec:Conformance / Driver Conformance}.
>       \item One of clauses \ref{sec:Conformance / Driver Conformance / PC=
I Driver Conformance}, \ref{sec:Conformance / Driver Conformance / MMIO Dri=
ver Conformance} or \ref{sec:Conformance / Driver Conformance / Channel I/O=
 Driver Conformance}.
> -    \item One of clauses \ref{sec:Conformance / Driver Conformance / Net=
work Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Block=
 Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Console D=
river Conformance}, \ref{sec:Conformance / Driver Conformance / Entropy Dri=
ver Conformance}, \ref{sec:Conformance / Driver Conformance / Traditional M=
emory Balloon Driver Conformance}, \ref{sec:Conformance / Driver Conformanc=
e / SCSI Host Driver Conformance}, \ref{sec:Conformance / Driver Conformanc=
e / Input Driver Conformance}, \ref{sec:Conformance / Driver Conformance / =
Crypto Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Soc=
ket Driver Conformance} or \ref{sec:Conformance / Driver Conformance / IOMM=
U Driver Conformance}.
> +    \item One of clauses \ref{sec:Conformance / Driver Conformance / Net=
work Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Block=
 Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Console D=
river Conformance}, \ref{sec:Conformance / Driver Conformance / Entropy Dri=
ver Conformance}, \ref{sec:Conformance / Driver Conformance / Traditional M=
emory Balloon Driver Conformance}, \ref{sec:Conformance / Driver Conformanc=
e / SCSI Host Driver Conformance}, \ref{sec:Conformance / Driver Conformanc=
e / Input Driver Conformance}, \ref{sec:Conformance / Driver Conformance / =
Crypto Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Soc=
ket Driver Conformance}, \ref{sec:Conformance / Driver Conformance / IOMMU =
Driver Conformance} or \ref{sec:Conformance / Driver Conformance / Sound Dr=
iver Conformance}.
>       \item Clause \ref{sec:Conformance / Legacy Interface: Transitional =
Device and Transitional Driver Conformance}.
>     \end{itemize}
>   \item[Device] A device MUST conform to four conformance clauses:
> @@ -32,8 +32,9 @@ \section{Conformance Targets}\label{sec:Conformance / C=
onformance Targets}
>   \ref{sec:Conformance / Device Conformance / Input Device Conformance},
>   \ref{sec:Conformance / Device Conformance / Crypto Device Conformance},
>   \ref{sec:Conformance / Device Conformance / Socket Device Conformance},
> -\ref{sec:Conformance / Device Conformance / RPMB Device Conformance} or
> -\ref{sec:Conformance / Device Conformance / IOMMU Device Conformance}.
> +\ref{sec:Conformance / Device Conformance / RPMB Device Conformance},
> +\ref{sec:Conformance / Device Conformance / IOMMU Device Conformance} or
> +\ref{sec:Conformance / Device Conformance / Sound Device Conformance}.
>       \item Clause \ref{sec:Conformance / Legacy Interface: Transitional =
Device and Transitional Driver Conformance}.
>     \end{itemize}
>   \end{description}
> @@ -220,6 +221,18 @@ \section{Conformance Targets}\label{sec:Conformance =
/ Conformance Targets}
>   \item \ref{drivernormative:Device Types / IOMMU Device / Device operati=
ons / Fault reporting}
>   \end{itemize}
>  =20
> +\conformance{\subsection}{Sound Driver Conformance}\label{sec:Conformanc=
e / Driver Conformance / Sound Driver Conformance}
> +
> +A sound driver MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{drivernormative:Device Types / Sound Device / Device Initiali=
zation}
> +\item \ref{drivernormative:Device Types / Sound Device / Item Informatio=
n Request}
> +\item \ref{drivernormative:Device Types / Sound Device / Device Operatio=
n / PCM Stream Parameters}
> +\item \ref{drivernormative:Device Types / Sound Device / Device Operatio=
n / PCM Output Stream}
> +\item \ref{drivernormative:Device Types / Sound Device / Device Operatio=
n / PCM Input Stream}
> +\end{itemize}
> +
>   \conformance{\section}{Device Conformance}\label{sec:Conformance / Devi=
ce Conformance}
>  =20
>   A device MUST conform to the following normative statements:
> @@ -408,6 +421,20 @@ \section{Conformance Targets}\label{sec:Conformance =
/ Conformance Targets}
>   \item \ref{devicenormative:Device Types / IOMMU Device / Device operati=
ons / Fault reporting}
>   \end{itemize}
>  =20
> +\conformance{\subsection}{Sound Device Conformance}\label{sec:Conformanc=
e / Device Conformance / Sound Device Conformance}
> +
> +A sound device MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{devicenormative:Device Types / Sound Device / Device Operatio=
n / Jack Information}
> +\item \ref{devicenormative:Device Types / Sound Device / Device Operatio=
n / PCM Stream Information}
> +\item \ref{devicenormative:Device Types / Sound Device / Device Operatio=
n / PCM Stream Parameters}
> +\item \ref{devicenormative:Device Types / Sound Device / Device Operatio=
n / PCM Stream Release}
> +\item \ref{devicenormative:Device Types / Sound Device / Device Operatio=
n / PCM Output Stream}
> +\item \ref{devicenormative:Device Types / Sound Device / Device Operatio=
n / PCM Input Stream}
> +\item \ref{devicenormative:Device Types / Sound Device / Device Operatio=
n / Channel Map Information}
> +\end{itemize}
> +
>   \conformance{\section}{Legacy Interface: Transitional Device and Transi=
tional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transi=
tional Device and Transitional Driver Conformance}
>   A conformant implementation MUST be either transitional or
>   non-transitional, see \ref{intro:Legacy
> diff --git a/content.tex b/content.tex
> index b91a132..edab0ca 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -6062,6 +6062,7 @@ \subsubsection{Legacy Interface: Framing Requiremen=
ts}\label{sec:Device
>   \input{virtio-fs.tex}
>   \input{virtio-rpmb.tex}
>   \input{virtio-iommu.tex}
> +\input{virtio-sound.tex}
>  =20
>   \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>  =20
> diff --git a/introduction.tex b/introduction.tex
> index 33da3ec..07674f8 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -66,6 +66,9 @@ \section{Normative References}\label{sec:Normative Refe=
rences}
>           \phantomsection\label{intro:eMMC}\textbf{[eMMC]} &
>           eMMC Electrical Standard (5.1), JESD84-B51,
>           \newline\url{http://www.jedec.org/sites/default/files/docs/JESD=
84-B51.pdf}\\
> +=09\phantomsection\label{intro:HDA}\textbf{[HDA]} &
> +=09High Definition Audio Specification,
> +=09\newline\url{https://www.intel.com/content/dam/www/public/us/en/docum=
ents/product-specifications/high-definition-audio-specification.pdf}\\
>  =20
>   \end{longtable}
>  =20
> diff --git a/virtio-sound.tex b/virtio-sound.tex
> new file mode 100644
> index 0000000..195eadd
> --- /dev/null
> +++ b/virtio-sound.tex
> @@ -0,0 +1,807 @@
> +\section{Sound Device}\label{sec:Device Types / Sound Device}
> +
> +The virtio sound card is a virtual audio device supporting input and out=
put PCM
> +streams.
> +
> +A device is managed by control requests and can send various notificatio=
ns
> +through dedicated queues. A driver can transmit PCM frames using message=
-based
> +transport or shared memory.
> +
> +A small part of the specification reuses existing layouts and values fro=
m the
> +High Definition Audio specification (\hyperref[intro:HDA]{HDA}). It allo=
ws to
> +provide the same functionality and assist in two possible cases:
> +
> +\begin{enumerate}
> +\item implementation of a universal sound driver,
> +\item implementation of a sound driver as part of the High Definition Au=
dio
> +subsystem.
> +\end{enumerate}
> +
> +\subsection{Device ID}\label{sec:Device Types / Sound Device / Device ID=
}
> +
> +25
> +
> +\subsection{Virtqueues}\label{sec:Device Types / Sound Device / Virtqueu=
es}
> +
> +\begin{description}
> +\item[0] controlq
> +\item[1] eventq
> +\item[2] txq
> +\item[3] rxq
> +\end{description}
> +
> +The control queue is used for sending control messages from the driver t=
o
> +the device.
> +
> +The event queue is used for sending notifications from the device to the=
 driver.
> +
> +The tx queue is used to send PCM frames for output streams.
> +
> +The rx queue is used to receive PCM frames from input streams.
> +
> +\subsection{Feature Bits}\label{sec:Device Types / Sound Device / Featur=
e Bits}
> +
> +None currently defined.
> +
> +\subsection{Device Configuration Layout}\label{sec:Device Types / Sound =
Device / Device Configuration Layout}
> +
> +\begin{lstlisting}
> +struct virtio_snd_config {
> +    le32 jacks;
> +    le32 streams;
> +    le32 chmaps;
> +};
> +\end{lstlisting}
> +
> +A configuration space contains the following fields:
> +
> +\begin{description}
> +\item[\field{jacks}] (driver-read-only) indicates a total number of all =
available
> +jacks.
> +\item[\field{streams}] (driver-read-only) indicates a total number of al=
l available
> +PCM streams.
> +\item[\field{chmaps}] (driver-read-only) indicates a total number of all=
 available
> +channel maps.
> +\end{description}
> +
> +\subsection{Device Initialization}
> +
> +\begin{enumerate}
> +\item Configure the control, event, tx and rx queues.
> +\item Read the \field{jacks} field and send a control request to query i=
nformation
> +about the available jacks.
> +\item Read the \field{streams} field and send a control request to query=
 information
> +about the available PCM streams.
> +\item Read the \field{chmaps} field and send a control request to query =
information
> +about the available channel maps.
> +\item Populate the event queue with empty buffers.
> +\end{enumerate}
> +
> +\drivernormative{\subsubsection}{Device Initialization}{Device Types / S=
ound Device / Device Initialization}
> +
> +\begin{itemize}
> +\item The driver MUST populate the event queue with empty buffers of at =
least
> +the struct virtio_snd_event size.
> +\item The driver MUST NOT put a device-readable buffers in the event que=
ue.
> +\end{itemize}
> +
> +\subsection{Device Operation}\label{sec:Device Types / Sound Device / De=
vice Operation}
> +
> +All control messages are placed into the control queue and all notificat=
ions
> +are placed into the event queue. They use the following layout structure=
 and
> +definitions:
> +
> +\begin{lstlisting}
> +enum {
> +    /* jack control request types */
> +    VIRTIO_SND_R_JACK_INFO =3D 1,
> +    VIRTIO_SND_R_JACK_REMAP,
> +
> +    /* PCM control request types */
> +    VIRTIO_SND_R_PCM_INFO =3D 0x0100,
> +    VIRTIO_SND_R_PCM_SET_PARAMS,
> +    VIRTIO_SND_R_PCM_PREPARE,
> +    VIRTIO_SND_R_PCM_RELEASE,
> +    VIRTIO_SND_R_PCM_START,
> +    VIRTIO_SND_R_PCM_STOP,
> +
> +    /* channel map control request types */
> +    VIRTIO_SND_R_CHMAP_INFO =3D 0x0200,
> +
> +    /* jack event types */
> +    VIRTIO_SND_EVT_JACK_CONNECTED =3D 0x1000,
> +    VIRTIO_SND_EVT_JACK_DISCONNECTED,
> +
> +    /* PCM event types */
> +    VIRTIO_SND_EVT_PCM_PERIOD_ELAPSED =3D 0x1100,
> +    VIRTIO_SND_EVT_PCM_XRUN,
> +
> +    /* common status codes */
> +    VIRTIO_SND_S_OK =3D 0x8000,
> +    VIRTIO_SND_S_BAD_MSG,
> +    VIRTIO_SND_S_NOT_SUPP,
> +    VIRTIO_SND_S_IO_ERR
> +};
> +
> +/* a common header */
> +struct virtio_snd_hdr {
> +    le32 code;
> +};
> +
> +/* an event notification */
> +struct virtio_snd_event {
> +    struct virtio_snd_hdr hdr;
> +    le32 data;
> +};
> +\end{lstlisting}
> +
> +A generic control message consists of a request part and a response part=
.
> +
> +A request part has, or consists of, a common header containing the follo=
wing
> +device-readable field:
> +
> +\begin{description}
> +\item[\field{code}] specifies a device request type (VIRTIO_SND_R_*).
> +\end{description}
> +
> +A response part has, or consists of, a common header containing the foll=
owing
> +device-writable field:
> +
> +\begin{description}
> +\item[\field{code}] indicates a device request status (VIRTIO_SND_S_*).
> +\end{description}
> +
> +The status field can take one of the following values:
> +
> +\begin{itemize}
> +\item VIRTIO_SND_S_OK - success.
> +\item VIRTIO_SND_S_BAD_MSG - a control message is malformed or contains =
invalid
> +parameters.
> +\item VIRTIO_SND_S_NOT_SUPP - requested operation or parameters are not =
supported.
> +\item VIRTIO_SND_S_IO_ERR - an I/O error occurred.
> +\end{itemize}
> +
> +The request part may be followed by an additional device-readable payloa=
d,
> +and the response part may be followed by an additional device-writable p=
ayload.
> +
> +An event notification contains the following device-writable fields:
> +
> +\begin{description}
> +\item[\field{hdr}] indicates an event type (VIRTIO_SND_EVT_*).
> +\item[\field{data}] indicates an optional event data.
> +\end{description}
> +
> +For all entities involved in the exchange of audio data, the device uses=
 one of
> +the following data flow directions:
> +
> +\begin{lstlisting}
> +enum {
> +    VIRTIO_SND_D_OUTPUT =3D 0,
> +    VIRTIO_SND_D_INPUT
> +};
> +\end{lstlisting}
> +
> +\subsubsection{Item Information Request}\label{sec:Device Types / Sound =
Device / Device Operation / Item Information Request}
> +
> +A special control message is used to request information about any kind =
of
> +configuration item. The request part uses the following structure defini=
tion:
> +
> +\begin{lstlisting}
> +struct virtio_snd_query_info {
> +    struct virtio_snd_hdr hdr;
> +    le32 start_id;
> +    le32 count;
> +    le32 size;
> +};
> +\end{lstlisting}
> +
> +The request contains the following device-readable fields:
> +
> +\begin{description}
> +\item[\field{hdr}] specifies a particular item request type (VIRTIO_SND_=
R_*_INFO).
> +\item[\field{start_id}] specifies the starting identifier for the item (=
the range
> +of available identifiers is limited by the total number of particular it=
ems that
> +is indicated in the device configuration space).
> +\item[\field{count}] specifies the number of items for which information=
 is
> +requested (the total number of particular items is indicated in the devi=
ce
> +configuration space).
> +\item[\field{size}] specifies the size of the structure containing infor=
mation
> +for one item (used for backward compatibility).
> +\end{description}
> +
> +The response consists of the virtio_snd_hdr structure (contains the requ=
est
> +status code), followed by the device-writable information structures of =
the
> +item. Each information structure begins with the following common header=
:
> +
> +\begin{lstlisting}
> +struct virtio_snd_info {
> +    le32 hda_fn_nid;
> +};
> +\end{lstlisting}
> +
> +The header contains the following field:
> +
> +\begin{description}
> +\item[\field{hda_fn_nid}] indicates a function group node identifier
> +(see \hyperref[intro:HDA]{HDA}, section 7.1.2). This field can be used t=
o link
> +together different types of resources (e.g. jacks with streams and chann=
el maps
> +with streams).
> +\end{description}
> +
> +\drivernormative{\subsubsection}{Item Information Request}{Device Types =
/ Sound Device / Item Information Request}
> +
> +\begin{itemize}
> +\item The driver MUST NOT set \field{start_id} and \field{count} such th=
at
> +\field{start_id} + \field{count} is greater than the total number of par=
ticular
> +items that is indicated in the device configuration space.
> +\item The driver MUST provide a buffer of sizeof(struct virtio_snd_hdr) =
+
> +\field{count} * \field{size} bytes for the response.
> +\end{itemize}
> +
> +\subsubsection{Relationships with the High Definition Audio Specificatio=
n}\label{sec:Device Types / Sound Device / Device Operation / Relationships=
 with HDA}
> +
> +The High Definition Audio specification introduces the codec as part of =
the
> +hardware that implements some of the functionality. The codec architectu=
re and
> +capabilities are described by tree structure of special nodes each of wh=
ich is
> +either a function module or a function group (see \hyperref[intro:HDA]{H=
DA} for
> +details).
> +
> +The virtio sound specification assumes that a single codec is implemente=
d in the
> +device. Function module nodes are simulated by item information structur=
es,
> +and function group nodes are simulated by the \field{hda_fn_nid} field i=
n each
> +such structure.
> +
> +\subsubsection{Jack Control Messages}\label{sec:Device Types / Sound Dev=
ice / Device Operation / Jack Control Messages}
> +
> +A jack control request has, or consists of, a common header with the fol=
lowing
> +layout structure:
> +
> +\begin{lstlisting}
> +struct virtio_snd_jack_hdr {
> +    struct virtio_snd_hdr hdr;
> +    le32 jack_id;
> +};
> +\end{lstlisting}
> +
> +The header consists of the following device-readable fields:
> +
> +\begin{description}
> +\item[\field{hdr}] specifies a request type (VIRTIO_SND_R_JACK_*).
> +\item[\field{jack_id}] specifies a jack identifier from 0 to \field{jack=
s} - 1.
> +\end{description}
> +
> +\paragraph{VIRTIO_SND_R_JACK_INFO}
> +
> +Query information about the available jacks.
> +
> +The request consists of the virtio_snd_query_info structure
> +(see \nameref{sec:Device Types / Sound Device / Device Operation / Item =
Information Request}).
> +The response consists of the virtio_snd_hdr structure, followed by the f=
ollowing
> +jack information structures:
> +
> +\begin{lstlisting}
> +/* supported jack features */
> +enum {
> +    VIRTIO_SND_JACK_F_REMAP =3D 0
> +};
> +
> +struct virtio_snd_jack_info {
> +    struct virtio_snd_info hdr;
> +    le32 features; /* 1 << VIRTIO_SND_JACK_F_XXX */
> +    le32 hda_reg_defconf;
> +    le32 hda_reg_caps;
> +    u8 connected;
> +
> +    u8 padding[7];
> +};
> +\end{lstlisting}
> +
> +The structure contains the following device-writable fields:
> +
> +\begin{description}
> +\item[\field{features}] indicates a supported feature bit map:
> +\begin{itemize}
> +\item VIRTIO_SND_JACK_F_REMAP - jack remapping support.
> +\end{itemize}
> +\item[\field{hda_reg_defconf}] indicates a pin default configuration val=
ue
> +(see \hyperref[intro:HDA]{HDA}, section 7.3.3.31).
> +\item[\field{hda_reg_caps}] indicates a pin capabilities value
> +(see \hyperref[intro:HDA]{HDA}, section 7.3.4.9).
> +\item[\field{connected}] indicates the current jack connection status
> +(1 - connected, 0 - disconnected).
> +\end{description}
> +
> +\devicenormative{\subparagraph}{Jack Information}{Device Types / Sound D=
evice / Device Operation / Jack Information}
> +
> +\begin{itemize}
> +\item The device MUST NOT set undefined feature values.
> +\item The device MUST initialize the \field{padding} bytes to 0.
> +\end{itemize}
> +
> +\paragraph{VIRTIO_SND_R_JACK_REMAP}
> +
> +If the VIRTIO_SND_JACK_F_REMAP feature bit is set in the jack informatio=
n,
> +then the driver can send a control request to change the association and=
/or
> +sequence number for the specified jack ID.
> +
> +The request uses the following structure and layout definitions:
> +
> +\begin{lstlisting}
> +struct virtio_snd_jack_remap {
> +    struct virtio_snd_jack_hdr hdr; /* .code =3D VIRTIO_SND_R_JACK_REMAP=
 */
> +    le32 association;
> +    le32 sequence;
> +};
> +\end{lstlisting}
> +
> +The request contains the following device-readable fields:
> +
> +\begin{description}
> +\item[\field{association}] specifies the selected association number.
> +\item[\field{sequence}] specifies the selected sequence number.
> +\end{description}
> +
> +\subsubsection{Jack Notifications}
> +
> +Jack notifications consist of a virtio_snd_event structure, which has th=
e following
> +device-writable fields:
> +
> +\begin{description}
> +\item[\field{hdr}] indicates a jack event type:
> +\begin{itemize}
> +\item VIRTIO_SND_EVT_JACK_CONNECTED - an external device has been connec=
ted to the jack.
> +\item VIRTIO_SND_EVT_JACK_DISCONNECTED - an external device has been dis=
connected from the jack.
> +\end{itemize}
> +\item[\field{data}] indicates a jack identifier from 0 to \field{jacks} =
- 1.
> +\end{description}
> +
> +\subsubsection{PCM Control Messages}\label{sec:Device Types / Sound Devi=
ce / Device Operation / PCM Control Messages}
> +
> +A PCM control request has, or consists of, a common header with the foll=
owing
> +layout structure:
> +
> +\begin{lstlisting}
> +struct virtio_snd_pcm_hdr {
> +    struct virtio_snd_hdr hdr;
> +    le32 stream_id;
> +};
> +\end{lstlisting}
> +
> +The header consists of the following device-readable fields:
> +
> +\begin{description}
> +\item[\field{hdr}] specifies request type (VIRTIO_SND_R_PCM_*).
> +\item[\field{stream_id}] specifies a PCM stream identifier from 0 to \fi=
eld{streams} - 1.
> +\end{description}
> +
> +\paragraph{PCM Command Lifecycle}
> +
> +A PCM stream has the following command lifecycle:
> +
> +\begin{enumerate}
> +\item SET PARAMETERS
> +
> +The driver negotiates the stream parameters (format, transport, etc) wit=
h
> +the device.
> +
> +Possible valid transitions: set parameters, prepare.
> +
> +\item PREPARE
> +
> +The device prepares the stream (allocates resources, etc).
> +
> +Possible valid transitions: set parameters, prepare, start, release.
> +
> +\item Output only: the driver transfers data for pre-buffing.
> +
> +\item START
> +
> +The device starts the stream (unmute, putting into running state, etc).
> +
> +Possible valid transitions: stop.
> +
> +\item The driver transfers data to/from the stream.
> +
> +\item STOP
> +
> +The device stops the stream (mute, putting into non-running state, etc).
> +
> +Possible valid transitions: start, release.
> +
> +\item RELEASE
> +
> +The device releases the stream (frees resources, etc).
> +
> +Possible valid transitions: set parameters, prepare.
> +
> +\end{enumerate}
> +
> +\paragraph{VIRTIO_SND_R_PCM_INFO}
> +
> +Query information about the available streams.
> +
> +The request consists of the virtio_snd_query_info structure
> +(see \nameref{sec:Device Types / Sound Device / Device Operation / Item =
Information Request}).
> +The response consists of the virtio_snd_hdr structure, followed by the f=
ollowing
> +stream information structures:
> +
> +\begin{lstlisting}
> +/* supported PCM stream features */
> +enum {
> +    VIRTIO_SND_PCM_F_SHMEM_HOST =3D 0,
> +    VIRTIO_SND_PCM_F_SHMEM_GUEST,
> +    VIRTIO_SND_PCM_F_MSG_POLLING,
> +    VIRTIO_SND_PCM_F_EVT_SHMEM_PERIODS,
> +    VIRTIO_SND_PCM_F_EVT_XRUNS
> +};
> +
> +/* supported PCM sample formats */
> +enum {
> +    /* analog formats (width / physical width) */
> +    VIRTIO_SND_PCM_FMT_IMA_ADPCM =3D 0,   /*  4 /  4 bits */
> +    VIRTIO_SND_PCM_FMT_MU_LAW,          /*  8 /  8 bits */
> +    VIRTIO_SND_PCM_FMT_A_LAW,           /*  8 /  8 bits */
> +    VIRTIO_SND_PCM_FMT_S8,              /*  8 /  8 bits */
> +    VIRTIO_SND_PCM_FMT_U8,              /*  8 /  8 bits */
> +    VIRTIO_SND_PCM_FMT_S16,             /* 16 / 16 bits */
> +    VIRTIO_SND_PCM_FMT_U16,             /* 16 / 16 bits */
> +    VIRTIO_SND_PCM_FMT_S18_3,           /* 18 / 24 bits */
> +    VIRTIO_SND_PCM_FMT_U18_3,           /* 18 / 24 bits */
> +    VIRTIO_SND_PCM_FMT_S20_3,           /* 20 / 24 bits */
> +    VIRTIO_SND_PCM_FMT_U20_3,           /* 20 / 24 bits */
> +    VIRTIO_SND_PCM_FMT_S24_3,           /* 24 / 24 bits */
> +    VIRTIO_SND_PCM_FMT_U24_3,           /* 24 / 24 bits */
> +    VIRTIO_SND_PCM_FMT_S20,             /* 20 / 32 bits */
> +    VIRTIO_SND_PCM_FMT_U20,             /* 20 / 32 bits */
> +    VIRTIO_SND_PCM_FMT_S24,             /* 24 / 32 bits */
> +    VIRTIO_SND_PCM_FMT_U24,             /* 24 / 32 bits */
> +    VIRTIO_SND_PCM_FMT_S32,             /* 32 / 32 bits */
> +    VIRTIO_SND_PCM_FMT_U32,             /* 32 / 32 bits */
> +    VIRTIO_SND_PCM_FMT_FLOAT,           /* 32 / 32 bits */
> +    VIRTIO_SND_PCM_FMT_FLOAT64,         /* 64 / 64 bits */
> +    /* digital formats (width / physical width) */
> +    VIRTIO_SND_PCM_FMT_DSD_U8,          /*  8 /  8 bits */
> +    VIRTIO_SND_PCM_FMT_DSD_U16,         /* 16 / 16 bits */
> +    VIRTIO_SND_PCM_FMT_DSD_U32,         /* 32 / 32 bits */
> +    VIRTIO_SND_PCM_FMT_IEC958_SUBFRAME  /* 32 / 32 bits */
> +};
> +
> +/* supported PCM frame rates */
> +enum {
> +    VIRTIO_SND_PCM_RATE_5512 =3D 0,
> +    VIRTIO_SND_PCM_RATE_8000,
> +    VIRTIO_SND_PCM_RATE_11025,
> +    VIRTIO_SND_PCM_RATE_16000,
> +    VIRTIO_SND_PCM_RATE_22050,
> +    VIRTIO_SND_PCM_RATE_32000,
> +    VIRTIO_SND_PCM_RATE_44100,
> +    VIRTIO_SND_PCM_RATE_48000,
> +    VIRTIO_SND_PCM_RATE_64000,
> +    VIRTIO_SND_PCM_RATE_88200,
> +    VIRTIO_SND_PCM_RATE_96000,
> +    VIRTIO_SND_PCM_RATE_176400,
> +    VIRTIO_SND_PCM_RATE_192000,
> +    VIRTIO_SND_PCM_RATE_384000
> +};
> +
> +struct virtio_snd_pcm_info {
> +    struct virtio_snd_info hdr;
> +    le32 features; /* 1 << VIRTIO_SND_PCM_F_XXX */
> +    le64 formats; /* 1 << VIRTIO_SND_PCM_FMT_XXX */
> +    le64 rates; /* 1 << VIRTIO_SND_PCM_RATE_XXX */
> +    u8 direction;
> +    u8 channels_min;
> +    u8 channels_max;
> +
> +    u8 padding[5];
> +};
> +\end{lstlisting}
> +
> +The structure contains the following device-writable fields:
> +
> +\begin{description}
> +\item[\field{features}] indicates a bit map of the supported features, w=
hich can
> +be negotiated by setting the stream parameters:
> +\begin{itemize}
> +\item VIRTIO_SND_PCM_F_SHMEM_HOST - supports sharing a host memory with =
a guest,
> +\item VIRTIO_SND_PCM_F_SHMEM_GUEST - supports sharing a guest memory wit=
h a host,
> +\item VIRTIO_SND_PCM_F_MSG_POLLING - supports polling mode for message-b=
ased
> +transport,
> +\item VIRTIO_SND_PCM_F_EVT_SHMEM_PERIODS - supports elapsed period notif=
ications
> +for shared memory transport,
> +\item VIRTIO_SND_PCM_F_EVT_XRUNS - supports underrun/overrun notificatio=
ns.
> +\end{itemize}
> +\item[\field{formats}] indicates a supported sample format bit map.
> +\item[\field{rates}] indicates a supported frame rate bit map.
> +\item[\field{direction}] indicates the direction of data flow (VIRTIO_SN=
D_D_*).
> +\item[\field{channels_min}] indicates a minimum number of supported chan=
nels.
> +\item[\field{channels_max}] indicates a maximum number of supported chan=
nels.
> +\end{description}
> +
> +Only interleaved samples are supported.
> +
> +\devicenormative{\subparagraph}{Stream Information}{Device Types / Sound=
 Device / Device Operation / PCM Stream Information}
> +
> +\begin{itemize}
> +\item The device MUST NOT set undefined feature, format, rate and direct=
ion
> +values.
> +\item The device MUST initialize the \field{padding} bytes to 0.
> +\end{itemize}
> +
> +\paragraph{VIRTIO_SND_R_PCM_SET_PARAMS}\label{sec:Device Types / Sound D=
evice / Device Operation / PCM Stream Parameters}
> +
> +Set selected stream parameters for the specified stream ID.
> +
> +The request uses the following structure and layout definitions:
> +
> +\begin{lstlisting}
> +struct virtio_snd_pcm_set_params {
> +    struct virtio_snd_pcm_hdr hdr; /* .code =3D VIRTIO_SND_R_PCM_SET_PAR=
AMS */
> +    le32 buffer_bytes;
> +    le32 period_bytes;
> +    le32 features; /* 1 << VIRTIO_SND_PCM_F_XXX */
> +    u8 channels;
> +    u8 format;
> +    u8 rate;
> +
> +    u8 padding;
> +};
> +\end{lstlisting}
> +
> +The request contains the following device-readable fields:
> +
> +\begin{description}
> +\item[\field{buffer_bytes}] specifies the size of the hardware buffer us=
ed by
> +the driver.
> +\item[\field{period_bytes}] specifies the size of the hardware period us=
ed by
> +the driver.
> +\item[\field{features}] specifies a selected feature bit map:
> +\begin{itemize}
> +\item VIRTIO_SND_PCM_F_SHMEM_HOST - use shared memory allocated by the h=
ost
> +(is a placeholder and MUST NOT be selected at the moment),
> +\item VIRTIO_SND_PCM_F_SHMEM_GUEST - use shared memory allocated by the =
guest
> +(is a placeholder and MUST NOT be selected at the moment),
> +\item VIRTIO_SND_PCM_F_MSG_POLLING - suppress available buffer notificat=
ions
> +for tx and rx queues (device should poll virtqueue),
> +\item VIRTIO_SND_PCM_F_EVT_SHMEM_PERIODS - enable elapsed period notific=
ations
> +for shared memory transport,
> +\item VIRTIO_SND_PCM_F_EVT_XRUNS - enable underrun/overrun notifications=
.
> +\end{itemize}
> +\item[\field{channels}] specifies a selected number of channels.
> +\item[\field{format}] specifies a selected sample format (VIRTIO_SND_PCM=
_FMT_*).
> +\item[\field{rate}] specifies a selected frame rate (VIRTIO_SND_PCM_RATE=
_*).
> +\end{description}
> +
> +\devicenormative{\subparagraph}{Stream Parameters}{Device Types / Sound =
Device / Device Operation / PCM Stream Parameters}
> +
> +\begin{itemize}
> +\item If the device has an intermediate buffer, its size MUST be no less=
 than
> +the specified \field{buffer_bytes} value.
> +\end{itemize}
> +
> +\drivernormative{\subparagraph}{Stream Parameters}{Device Types / Sound =
Device / Device Operation / PCM Stream Parameters}
> +
> +\begin{itemize}
> +\item \field{period_bytes} MUST be a divider \field{buffer_bytes}, i.e. =
\field{buffer_bytes} \% \field{period_bytes} =3D=3D 0.
> +\item The driver MUST NOT set undefined feature, format and rate values.
> +\item The driver MUST NOT set the feature, format, and rate that are not=
 specified
> +in the stream configuration.
> +\item The driver MUST NOT set the \field{channels} value as less than th=
e \field{channels_min}
> +or greater than the \field{channels_max} values specified in the stream =
configuration.
> +\item The driver MUST NOT set the VIRTIO_SND_PCM_F_SHMEM_HOST and VIRTIO=
_SND_PCM_F_SHMEM_GUEST
> +bits at the same time.
> +\item The driver MUST initialize the \field{padding} byte to 0.
> +\item If the bits associated with the shared memory are not selected, th=
e driver
> +MUST use the tx and rx queues for data transfer
> +(see \nameref{sec:Device Types / Sound Device / Device Operation / PCM I=
O Messages}).
> +\end{itemize}
> +
> +\paragraph{VIRTIO_SND_R_PCM_PREPARE}
> +
> +Prepare a stream with specified stream ID.
> +
> +\paragraph{VIRTIO_SND_R_PCM_RELEASE}
> +
> +Release a stream with specified stream ID.
> +
> +\devicenormative{\subparagraph}{Stream Release}{Device Types / Sound Dev=
ice / Device Operation / PCM Stream Release}
> +
> +\begin{itemize}
> +\item The device MUST complete all pending I/O messages for the specifie=
d
> +stream ID.
> +\item The device MUST NOT complete the control request while there are p=
ending
> +I/O messages for the specified stream ID.
> +\end{itemize}
> +
> +\paragraph{VIRTIO_SND_R_PCM_START}
> +
> +Start a stream with specified stream ID.
> +
> +\paragraph{VIRTIO_SND_R_PCM_STOP}
> +
> +Stop a stream with specified stream ID.
> +
> +\subsubsection{PCM Notifications}
> +
> +The device can announce support for different PCM events using feature b=
its
> +in the stream information structure. To enable notifications, the driver
> +must negotiate these features using the set stream parameters request
> +(see \ref{sec:Device Types / Sound Device / Device Operation / PCM Strea=
m Parameters}).
> +
> +PCM stream notifications consist of a virtio_snd_event structure, which =
has the
> +following device-writable fields:
> +
> +\begin{description}
> +\item[\field{hdr}] indicates a PCM stream event type:
> +\begin{itemize}
> +\item VIRTIO_SND_EVT_PCM_PERIOD_ELAPSED - a hardware buffer period has e=
lapsed,
> +the period size is controlled using the \field{period_bytes} field.
> +\item VIRTIO_SND_EVT_PCM_XRUN - an underflow for the output stream or an=
 overflow
> +for the input stream has occurred.
> +\end{itemize}
> +\item[\field{data}] indicates a PCM stream identifier from 0 to \field{s=
treams} - 1.
> +\end{description}
> +
> +\subsubsection{PCM I/O Messages}\label{sec:Device Types / Sound Device /=
 Device Operation / PCM IO Messages}
> +
> +An I/O message consists of the header part, followed by the buffer, and =
then
> +the status part.
> +
> +\begin{lstlisting}
> +/* an I/O header */
> +struct virtio_snd_pcm_xfer {
> +    le32 stream_id;
> +};
> +
> +/* an I/O status */
> +struct virtio_snd_pcm_status {
> +    le32 status;
> +    le32 latency_bytes;
> +};
> +\end{lstlisting}
> +
> +The header part consists of the following device-readable field:
> +
> +\begin{description}
> +\item[\field{stream_id}] specifies a PCM stream identifier from 0 to \fi=
eld{streams} - 1.
> +\end{description}
> +
> +The status part consists of the following device-writable fields:
> +
> +\begin{description}
> +\item[\field{status}] contains VIRTIO_SND_S_OK if an operation is succes=
sful,
> +and VIRTIO_SND_S_IO_ERR otherwise.
> +\item[\field{latency_bytes}] indicates the current device latency.
> +\end{description}
> +
> +Since all buffers in the queue (with one exception) should be of the siz=
e
> +\field{period_bytes}, the completion of such an I/O request can be consi=
dered an
> +elapsed period notification.
> +
> +\paragraph{Output Stream}
> +
> +In case of an output stream, the header is followed by a device-readable=
 buffer
> +containing PCM frames for writing to the device. All messages are placed=
 into
> +the tx queue.
> +
> +\devicenormative{\subparagraph}{Output Stream}{Device Types / Sound Devi=
ce / Device Operation / PCM Output Stream}
> +
> +\begin{itemize}
> +\item The device MUST NOT complete the I/O request until the buffer is t=
otally
> +consumed.
> +\end{itemize}
> +
> +\drivernormative{\subparagraph}{Output Stream}{Device Types / Sound Devi=
ce / Device Operation / PCM Output Stream}
> +
> +\begin{itemize}
> +\item The driver SHOULD populate the tx queue with \field{period_bytes} =
sized
> +buffers. The only exception is the end of the stream.
> +\item The driver MUST NOT place device-writable buffers into the tx queu=
e.
> +\end{itemize}
> +
> +\paragraph{Input Stream}
> +
> +In case of an input stream, the header is followed by a device-writable =
buffer
> +being populated with PCM frames from the device. All messages are placed=
 into
> +the rx queue.
> +
> +A used descriptor specifies the length of the buffer that was written by=
 the
> +device. It should be noted that the length value contains the size of th=
e
> +virtio_snd_pcm_status structure plus the size of the recorded frames.
> +
> +\devicenormative{\subparagraph}{Input Stream}{Device Types / Sound Devic=
e / Device Operation / PCM Input Stream}
> +
> +\begin{itemize}
> +\item The device MUST NOT complete the I/O request until the buffer is f=
ull.
> +The only exception is the end of the stream.
> +\end{itemize}
> +
> +\drivernormative{\subparagraph}{Input Stream}{Device Types / Sound Devic=
e / Device Operation / PCM Input Stream}
> +
> +\begin{itemize}
> +\item The driver SHOULD populate the rx queue with \field{period_bytes} =
sized
> +empty buffers before starting the stream.
> +\item The driver MUST NOT place device-readable buffers into the rx queu=
e.
> +\end{itemize}
> +
> +\subsubsection{Channel Map Control Messages}\label{sec:Device Types / So=
und Device / Device Operation / Channel Map Control Messages}
> +
> +A device can provide one or more channel maps assigned to all streams wi=
th
> +the same data flow direction in the same function group.
> +
> +\paragraph{VIRTIO_SND_R_CHMAP_INFO}
> +
> +Query information about the available channel maps.
> +
> +The request consists of the virtio_snd_query_info structure
> +(see \nameref{sec:Device Types / Sound Device / Device Operation / Item =
Information Request}).
> +The response consists of the virtio_snd_hdr structure, followed by the f=
ollowing
> +channel map information structures:
> +
> +\begin{lstlisting}
> +/* standard channel position definition */
> +enum {
> +    VIRTIO_SND_CHMAP_NONE =3D 0,  /* undefined */
> +    VIRTIO_SND_CHMAP_NA,        /* silent */
> +    VIRTIO_SND_CHMAP_MONO,      /* mono stream */
> +    VIRTIO_SND_CHMAP_FL,        /* front left */
> +    VIRTIO_SND_CHMAP_FR,        /* front right */
> +    VIRTIO_SND_CHMAP_RL,        /* rear left */
> +    VIRTIO_SND_CHMAP_RR,        /* rear right */
> +    VIRTIO_SND_CHMAP_FC,        /* front center */
> +    VIRTIO_SND_CHMAP_LFE,       /* low frequency (LFE) */
> +    VIRTIO_SND_CHMAP_SL,        /* side left */
> +    VIRTIO_SND_CHMAP_SR,        /* side right */
> +    VIRTIO_SND_CHMAP_RC,        /* rear center */
> +    VIRTIO_SND_CHMAP_FLC,       /* front left center */
> +    VIRTIO_SND_CHMAP_FRC,       /* front right center */
> +    VIRTIO_SND_CHMAP_RLC,       /* rear left center */
> +    VIRTIO_SND_CHMAP_RRC,       /* rear right center */
> +    VIRTIO_SND_CHMAP_FLW,       /* front left wide */
> +    VIRTIO_SND_CHMAP_FRW,       /* front right wide */
> +    VIRTIO_SND_CHMAP_FLH,       /* front left high */
> +    VIRTIO_SND_CHMAP_FCH,       /* front center high */
> +    VIRTIO_SND_CHMAP_FRH,       /* front right high */
> +    VIRTIO_SND_CHMAP_TC,        /* top center */
> +    VIRTIO_SND_CHMAP_TFL,       /* top front left */
> +    VIRTIO_SND_CHMAP_TFR,       /* top front right */
> +    VIRTIO_SND_CHMAP_TFC,       /* top front center */
> +    VIRTIO_SND_CHMAP_TRL,       /* top rear left */
> +    VIRTIO_SND_CHMAP_TRR,       /* top rear right */
> +    VIRTIO_SND_CHMAP_TRC,       /* top rear center */
> +    VIRTIO_SND_CHMAP_TFLC,      /* top front left center */
> +    VIRTIO_SND_CHMAP_TFRC,      /* top front right center */
> +    VIRTIO_SND_CHMAP_TSL,       /* top side left */
> +    VIRTIO_SND_CHMAP_TSR,       /* top side right */
> +    VIRTIO_SND_CHMAP_LLFE,      /* left LFE */
> +    VIRTIO_SND_CHMAP_RLFE,      /* right LFE */
> +    VIRTIO_SND_CHMAP_BC,        /* bottom center */
> +    VIRTIO_SND_CHMAP_BLC,       /* bottom left center */
> +    VIRTIO_SND_CHMAP_BRC        /* bottom right center */
> +};
> +
> +/* maximum possible number of channels */
> +#define VIRTIO_SND_CHMAP_MAX_SIZE 18
> +
> +struct virtio_snd_chmap_info {
> +    struct virtio_snd_info hdr;
> +    u8 direction;
> +    u8 channels;
> +    u8 positions[VIRTIO_SND_CHMAP_MAX_SIZE];
> +};
> +\end{lstlisting}
> +
> +The structure contains the following device-writable fields:
> +
> +\begin{description}
> +\item[\field{direction}] indicates the direction of data flow (VIRTIO_SN=
D_D_*).
> +\item[\field{channels}] indicates the number of valid channel position v=
alues.
> +\item[\field{positions}] indicates channel position values (VIRTIO_SND_C=
HMAP_*).
> +\end{description}
> +
> +\devicenormative{\subparagraph}{Channel Map Information}{Device Types / =
Sound Device / Device Operation / Channel Map Information}
> +
> +\begin{itemize}
> +\item The device MUST NOT set undefined direction values.
> +\item The device MUST NOT set the channels value to more than VIRTIO_SND=
_CHMAP_MAX_SIZE.
> +\end{itemize}
>=20

--=20
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

