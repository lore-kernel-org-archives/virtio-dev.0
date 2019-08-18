Return-Path: virtio-dev-return-5991-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 40FEA983CCC
	for <virtio-dev@lists.oasis-open.org>; Sun, 18 Aug 2019 13:09:43 +0000 (UTC)
Date: Sun, 18 Aug 2019 09:09:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190818080722-mutt-send-email-mst@kernel.org>
References: <20190816202628.14818-1-Mikhail.Golubev@opensynergy.com>
 <20190816202628.14818-2-Mikhail.Golubev@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816202628.14818-2-Mikhail.Golubev@opensynergy.com>
Subject: Re: [virtio-dev] [RFC] snd: Add virtio sound device specification
To: Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Aug 16, 2019 at 10:26:28PM +0200, Mikhail Golubev wrote:
> From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> 
> The virtio sound device is an extendable virtual audio device. It
> provides playback and capture PCM streams to a guest.
> 
> The device is implemented as a collection of a device-specific functions
> that provide dedicated audio-related functionality. At the moment it
> supports the following:
> 
> 1. Base function (generic device management);
> 2. PCM function (a playback/capture PCM stream).
> 
> Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> Signed-off-by: Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
> ---
>  content.tex      |   1 +
>  virtio-sound.tex | 432 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 433 insertions(+)
>  create mode 100644 virtio-sound.tex
> 
> diff --git a/content.tex b/content.tex
> index ee0d7c9..6a7f9a3 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -5677,6 +5677,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
>  \input{virtio-input.tex}
>  \input{virtio-crypto.tex}
>  \input{virtio-vsock.tex}
> +\input{virtio-sound.tex}
> 
>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> 
> diff --git a/virtio-sound.tex b/virtio-sound.tex
> new file mode 100644
> index 0000000..4039d64
> --- /dev/null
> +++ b/virtio-sound.tex
> @@ -0,0 +1,432 @@
> +\section{Sound Device}\label{sec:Device Types / Sound Device}
> +
> +The virtio sound card is an extendable virtual audio device. It provides its
> +functionality in a form of functions that can be configured and managed in an
> +independent way.
> +
> +\subsection{Device ID}\label{sec:Device Types / Sound Device / Device ID}
> +
> +25
> +
> +\subsection{Virtqueues}\label{sec:Device Types / Sound Device / Virtqueues}
> +
> +Depending on provided functionality, a device can use one or more virtqueues
> +described in a configuration space. A virtqueue assigned to the base function
> +is mandatory and referred as a control queue.

Pls look at other devices such as e.g. serial for examples of how
other devices list virtqueues.

> +
> +\subsection{Feature bits}\label{sec:Device Types / Sound Device / Feature bits}
> +
> +There are currently no feature bits defined for this device.

I see at least PCM as an optional feature.
Pls make that a feature bit so we can have
reasonable forward and backward compatibility.


> +
> +\subsection{Device configuration layout}\label{sec:Device Types / Sound Device / Device configuration layout}
> +
> +Configuration space provides information about available virtqueues and their
> +assignments to enabled functions using following layout structure and definitions:
> +
> +\begin{lstlisting}
> +enum {
> +    /* function identifiers for virtqueue assignments */
> +    VIRTIO_SND_FN_BASE = 0,
> +    VIRTIO_SND_FN_PCM

Please document that PCM is 1, and add comments.

> +};

So I think we should have PCM as a feature bit.


> +
> +struct virtio_snd_queue_info {
> +    /* VIRTIO_SND_FN_* */
> +    le16 function;
> +    /* a function device id */
> +    u8 device_id;
> +    /* a function subdevice id */
> +    u8 subdevice_id;

Are all fields read-only?

For each config field you need to explain where it's read only, write only,
read/write.


> +};
> +
> +struct virtio_snd_config {
> +    /* maximum # of available virtqueues */
> +    le32 nqueues;
> +};
> +\end{lstlisting}
> +
> +The \field{nqueues} field contains a maximum amount of available virtqueues and
> +is followed by an \field{nqueues}-sized array of \field{struct virtio_snd_queue_info}
> +structures.

This will require lots of config space. Do we need fast access to this?
If not we could add a queue selector, or even a config virtqueue.
But I really think there should just be a fixed queue for each
function.

> \field{struct virtio_snd_queue_info} with index \field{i} describes
> +a device function assigned to a virtqueue with index \field{i}.

i is not a field that appears in the above text.



> \field{device_id}
> +and \field{subdevice_id} fields are used to distinguish different instances of
> +the same function type.

How are they used? I see no explanation anywhere.

> +
> +\subsection{Device Initialization}\label{sec:Device Types / Sound Device / Device Initialization}
> +
> +\begin{enumerate}
> +\item Initialize all available virtqueues.
> +\item Retrieve a device configuration.
> +\item Initialize all functions enabled in the device configuration.
> +\end{enumerate}
> +
> +A device configuration is represented with a set of descriptors having
> +a fixed header using the following layout structure and definitions:

Do you mean this appears in config space? Or sent on some queue?

Also please avoid using the term "descriptor" since it's already
used for ring operation descriptions.

I also wonder why is all this in the configuration space.

> +
> +\begin{lstlisting}
> +enum {
> +    /* the PCM function descriptor types */
> +    VIRTIO_SND_DESC_PCM = 0,
> +    VIRTIO_SND_DESC_PCM_STREAM
> +};
> +
> +struct virtio_snd_desc {
> +    u8 length;
> +    u8 type;
> +
> +    u16 padding;
> +};
> +\end{lstlisting}
> +
> +The fixed header \field{struct virtio_snd_desc} in each
> +descriptor includes the following fields:
> +
> +\begin{description}
> +\item[\field{length}] specifies the total number of bytes in the descriptor.

why do we need the length? buffer length not enough?

> +\item[\field{type}] identifies the descriptor type (VIRTIO_SND_DESC_*).
> +\end{description}

> +
> +With the exception of the base function, all implemented functions MUST add
> +their descriptors in configuration only if a particular function (or part of
> +its functionality) is enabled in the device.

This kind of ad-hoc feature negotiation goes against the
idea of using virtio for unifying device operation.
Please add each optional feature with a feature bit,
and dedicate a vq to it. This way you will have
fixed 2 vqs right now (I think?) and no need for
the complex discovery mechanism.


> +
> +\subsection{Device Operation}\label{sec:Device Types / Sound Device / Device Operation}
> +
> +All control messages are placed into a single control queue.
> +
> +All requests and responses on the queue consist of or are preceded by
> +a header using the following layout structure and definitions:
> +
> +\begin{lstlisting}
> +enum {


> +    /* the base function request types */
> +    VIRTIO_SND_R_BASE_GET_CFG = 0,
> +
> +    /* the PCM function request types */
> +    VIRTIO_SND_R_PCM_SET_FORMAT = 0x0100,
> +    VIRTIO_SND_R_PCM_PREPARE,
> +    VIRTIO_SND_R_PCM_START,
> +    VIRTIO_SND_R_PCM_STOP,
> +    VIRTIO_SND_R_PCM_PAUSE,
> +    VIRTIO_SND_R_PCM_UNPAUSE,
> +    VIRTIO_SND_R_PCM_QUERY_CHMAP,
> +    VIRTIO_SND_R_PCM_USE_CHMAP,

Where are these documented?
> +
> +    /* response status codes */
> +    VIRTIO_SND_S_OK = 0x8000,
> +    VIRTIO_SND_S_ENOTSUPPORTED,
> +    VIRTIO_SND_S_EINVALID,
> +    VIRTIO_SND_S_EIO

where are these used?

> +};
> +
> +struct virtio_snd_hdr {
> +    le32 code;
> +};
> +\end{lstlisting}
> +
> +The generic header \field{struct virtio_snd_hdr} contains the only field:
> +
> +\begin{description}
> +\item[\field{code}] specifies a type of the driver request
> +(VIRTIO_SND_R_*) or a device response status code (VIRTIO_SND_S_*).
> +\end{description}
> +
> +\subsubsection{Device Operation: Base function}
> +
> +The base function is responsible for operations having a scope of or that
> +can affect the entire device.
> +
> +\begin{description}
> +
> +\item[VIRTIO_SND_R_BASE_GET_CFG]
> +Retrieve the current device configuration, response is \field{struct virtio_snd_base_configuration}
> +containing a set of function descriptors.
> +
> +\begin{lstlisting}
> +/* a maximum possible configuration data size (in bytes) */
> +#define VIRTIO_SND_BASE_CFG_MAX_SIZE    1024
> +
> +/* a response containing device configuration */
> +struct virtio_snd_base_configuration {
> +    struct virtio_snd_hdr hdr;
> +    /* size in bytes of configuration data */
> +    le32 length;
> +    /* configuration data */
> +    u8 data[VIRTIO_SND_BASE_CFG_MAX_SIZE];
> +};
> +\end{lstlisting}
> +
> +\end{description}
> +
> +\subsubsection{Device Operation: PCM function}
> +
> +The PCM function provides up to one playback and up to one capture PCM stream.
> +If the device supports more than one PCM stream of the same type, it MUST
> +provide them as separate PCM functions.


Please put all conformance statements (including MAY/MUST) in the normative sections.

> +
> +The function puts a PCM function descriptor to a device configuration.

what does this mean? "put to" is not in my English dictionary. Typo?

> The descriptor
> +is followed by up to two PCM stream descriptors. The data is stored according to
> +the following layout structure and definitions:

You don't document which parts of the buffer are read and which write
(VIRTQ_DESC_F_WRITE).

> +
> +\begin{lstlisting}
> +/* supported PCM stream types */
> +enum {
> +    VIRTIO_SND_PCM_T_PLAYBACK = 0,
> +    VIRTIO_SND_PCM_T_CAPTURE
> +};
> +
> +/* supported PCM sample formats */
> +enum {
> +    VIRTIO_SND_PCM_FMT_S8 = 0,
> +    VIRTIO_SND_PCM_FMT_U8,
> +    VIRTIO_SND_PCM_FMT_S16,
> +    VIRTIO_SND_PCM_FMT_U16,
> +    VIRTIO_SND_PCM_FMT_S32,
> +    VIRTIO_SND_PCM_FMT_U32,
> +    VIRTIO_SND_PCM_FMT_FLOAT,
> +    VIRTIO_SND_PCM_FMT_FLOAT64
> +};
> +
> +/* supported PCM frame rates */
> +enum {
> +    VIRTIO_SND_PCM_RATE_8000 = 0,
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
> +    VIRTIO_SND_PCM_RATE_192000
> +};
> +
> +/* PCM function descriptor */
> +struct virtio_snd_pcm_desc {
> +    /* sizeof(struct virtio_snd_pcm_desc) */
> +    u8 length;

So if it's a fixed value, why do we need it? Same in below types.

> +    /* VIRTIO_SND_DESC_PCM */
> +    u8 type;
> +    /* a PCM function ID (assigned by the device) */
> +    u8 pcm_id;
> +    /* # of PCM stream descriptors in the configuration (one per supported
> +     * PCM stream type)
> +     */
> +    u8 nstreams;
> +};
> +
> +/* PCM stream descriptor */
> +struct virtio_snd_pcm_stream_desc {
> +    /* sizeof(struct virtio_snd_pcm_stream_desc) */
> +    u8 length;
> +    /* VIRTIO_SND_DESC_PCM_STREAM */
> +    u8 type;
> +    /* a PCM stream type (VIRTIO_SND_PCM_T_*) */
> +    u8 stream_type;
> +    /* # of supported channel maps */
> +    u8 nchmaps;
> +    /* minimum # of supported channels */
> +    le16 channels_min;
> +    /* maximum # of supported channels */
> +    le16 channels_max;
> +    /* supported sample format bit mask (1 << VIRTIO_SND_PCM_FMT_*) */
> +    le32 formats;
> +    /* supported frame rate bit mask (1 << VIRTIO_SND_PCM_RATE_*) */
> +    le32 rates;
> +};
> +\end{lstlisting}
> +
> +The function assumes the following command lifecycle:
> +
> +\begin{enumerate}
> +\item Set format
> +\item Prepare
> +\item Playback: transfer data for prebuffing.
> +\item Start
> +\item Transfer data to/from the PCM device.
> +\begin{enumerate}
> +       \item Pause
> +       \item Unpause
> +\end{enumerate}
> +\item Stop
> +\end{enumerate}
> +
> +PCM control requests have or consist of a fixed header with the following
> +layout structure:
> +
> +\begin{lstlisting}
> +struct virtio_snd_pcm_hdr {
> +    /* a PCM request type (VIRTIO_SND_R_PCM_*) */
> +    struct virtio_snd_hdr hdr;
> +    /* a PCM identifier (assigned in configuration) */
> +    u8 pcm_id;
> +    /* a PCM stream type (VIRTIO_SND_PCM_T_*) */
> +    u8 stream_type;
> +
> +    u16 padding;
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +
> +\item[VIRTIO_SND_R_PCM_SET_FORMAT]
> +Set selected PCM format.
> +
> +\begin{lstlisting}
> +struct virtio_snd_pcm_set_format {
> +    struct virtio_snd_pcm_hdr hdr;
> +    /* # of channels */
> +    le16 channels;
> +    /* a PCM sample format (VIRTIO_SND_PCM_FMT_*) */
> +    le16 format;
> +    /* a PCM frame rate (VIRTIO_SND_PCM_RATE_*) */
> +    le16 rate;
> +
> +    u16 padding;
> +};
> +\end{lstlisting}
> +
> +\item[VIRTIO_SND_R_PCM_PREPARE]
> +Prepare the PCM device.
> +
> +\item[VIRTIO_SND_R_PCM_START]
> +Start the PCM device.
> +
> +\item[VIRTIO_SND_R_PCM_STOP]
> +Stop the PCM device.
> +
> +\item[VIRTIO_SND_R_PCM_PAUSE]
> +Set the PCM device on pause.
> +
> +\item[VIRTIO_SND_R_PCM_UNPAUSE]
> +Unset the PCM device from pause.
> +
> +\item[VIRTIO_SND_R_PCM_QUERY_CHMAP]
> +Query PCM channel map information.
> +
> +The function reports an amount of available channel maps in the PCM stream
> +configuration descriptor. The driver can enumerate these using the following
> +request and response layout structure and definitions:
> +
> +\begin{lstlisting}
> +enum {
> +    /* All channels have fixed channel positions */
> +    VIRTIO_SND_PCM_CHMAP_FIXED = 0,
> +    /* All channels are swappable (e.g. {FL/FR/RL/RR} -> {RR/RL/FR/FL}) */
> +    VIRTIO_SND_PCM_CHMAP_VARIABLE,
> +    /* Only pair-wise channels are swappable (e.g. {FL/FR/RL/RR} -> {RL/RR/FL/FR}) */
> +    VIRTIO_SND_PCM_CHMAP_PAIRED
> +};
> +
> +/* Standard channel position definitions */
> +enum {
> +    VIRTIO_SND_PCM_CH_NONE = 0, /* undefined */
> +    VIRTIO_SND_PCM_CH_NA,       /* silent */
> +    VIRTIO_SND_PCM_CH_MONO,     /* mono stream */
> +    VIRTIO_SND_PCM_CH_FL,       /* front left */
> +    VIRTIO_SND_PCM_CH_FR,       /* front right */
> +    VIRTIO_SND_PCM_CH_RL,       /* rear left */
> +    VIRTIO_SND_PCM_CH_RR,       /* rear right */
> +    VIRTIO_SND_PCM_CH_FC,       /* front center */
> +    VIRTIO_SND_PCM_CH_LFE,      /* low frequency (LFE) */
> +    VIRTIO_SND_PCM_CH_SL,       /* side left */
> +    VIRTIO_SND_PCM_CH_SR,       /* side right */
> +    VIRTIO_SND_PCM_CH_RC,       /* rear center */
> +    VIRTIO_SND_PCM_CH_FLC,      /* front left center */
> +    VIRTIO_SND_PCM_CH_FRC,      /* front right center */
> +    VIRTIO_SND_PCM_CH_RLC,      /* rear left center */
> +    VIRTIO_SND_PCM_CH_RRC,      /* rear right center */
> +    VIRTIO_SND_PCM_CH_FLW,      /* front left wide */
> +    VIRTIO_SND_PCM_CH_FRW,      /* front right wide */
> +    VIRTIO_SND_PCM_CH_FLH,      /* front left high */
> +    VIRTIO_SND_PCM_CH_FCH,      /* front center high */
> +    VIRTIO_SND_PCM_CH_FRH,      /* front right high */
> +    VIRTIO_SND_PCM_CH_TC,       /* top center */
> +    VIRTIO_SND_PCM_CH_TFL,      /* top front left */
> +    VIRTIO_SND_PCM_CH_TFR,      /* top front right */
> +    VIRTIO_SND_PCM_CH_TFC,      /* top front center */
> +    VIRTIO_SND_PCM_CH_TRL,      /* top rear left */
> +    VIRTIO_SND_PCM_CH_TRR,      /* top rear right */
> +    VIRTIO_SND_PCM_CH_TRC,      /* top rear center */
> +    VIRTIO_SND_PCM_CH_TFLC,     /* top front left center */
> +    VIRTIO_SND_PCM_CH_TFRC,     /* top front right center */
> +    VIRTIO_SND_PCM_CH_TSL,      /* top side left */
> +    VIRTIO_SND_PCM_CH_TSR,      /* top side right */
> +    VIRTIO_SND_PCM_CH_LLFE,     /* left LFE */
> +    VIRTIO_SND_PCM_CH_RLFE,     /* right LFE */
> +    VIRTIO_SND_PCM_CH_BC,       /* bottom center */
> +    VIRTIO_SND_PCM_CH_BLC,      /* bottom left center */
> +    VIRTIO_SND_PCM_CH_BRC       /* bottom right center */
> +};
> +
> +#define VIRTIO_SND_PCM_CH_MAX             256
> +
> +struct virtio_snd_pcm_query_chmap {
> +    struct virtio_snd_hdr hdr;
> +    /* a PCM identifier (assigned in configuration) */
> +    u8 pcm_id;
> +    /* a PCM stream type (VIRTIO_SND_PCM_T_*) */
> +    u8 stream_type;
> +    /* a PCM channel map identifier [0 .. virtio_snd_pcm_stream_desc::nchmaps - 1] */
> +    u8 chmap_id;
> +
> +    u8 padding;
> +};
> +
> +/* a response containing PCM channel map information */
> +struct virtio_snd_pcm_chmap_info {
> +    /* a response status code (VIRTIO_SND_S_*) */
> +    struct virtio_snd_hdr hdr;
> +    /* unused */
> +    u8 pcm_id;
> +    /* a PCM channel map type (VIRTIO_SND_PCM_CHMAP_*) */
> +    u8 type;
> +    /* # of valid entries in the positions array */
> +    le16 nchannels;
> +    /* PCM channel positions */
> +    u8 positions[VIRTIO_SND_PCM_CH_MAX];
> +};
> +\end{lstlisting}
> +
> +\item[VIRTIO_SND_R_PCM_USE_CHMAP]
> +Use modified PCM channel map.
> +
> +In case of a channel map has swappable positions, the driver can set a modified
> +channel map using the same \field{struct virtio_snd_pcm_chmap_info} structure as
> +request.
> +
> +\begin{lstlisting}
> +/* a request containing PCM channel map information */
> +struct virtio_snd_pcm_chmap_info {
> +    /* VIRTIO_SND_R_PCM_USE_CHMAP */
> +    struct virtio_snd_hdr hdr;
> +    /* a PCM identifier (assigned in configuration) */
> +    u8 pcm_id;
> +    /* a PCM stream type (VIRTIO_SND_PCM_T_*) */
> +    u8 type;
> +    /* # of valid entries in the positions array */
> +    le16 nchannels;
> +    /* PCM channel positions */
> +    u8 positions[VIRTIO_SND_PCM_CH_MAX];
> +};
> +\end{lstlisting}
> +
> +\end{description}
> +
> +All IO requests are placed into a single virtqueue assigned for PCM data
> +transport. Each request is of form:
> +
> +\begin{lstlisting}
> +struct virtio_snd_pcm_xfer {
> +    /* a PCM stream type (VIRTIO_SND_PCM_T_*) */
> +    u8 stream_type;
> +    /* a PCM frame buffer */
> +    u8 data[];
> +    /* VIRTIO_SND_S_* */
> +    le32 status;
> +};
> +\end{lstlisting}
> +
> +The device returns an actual amount of bytes read from/written to data buffer.

So are there two buffers? read and write?
> --
> 2.22.1
> 
> 
> Please mind our privacy notice<https://www.opensynergy.com/datenschutzerklaerung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-general-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.opensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaeftspartner-gem-art-13-dsgvo/>
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

