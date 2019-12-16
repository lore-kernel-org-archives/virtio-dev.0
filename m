Return-Path: virtio-dev-return-6519-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 26140985BE3
	for <virtio-dev@lists.oasis-open.org>; Mon, 16 Dec 2019 13:00:53 +0000 (UTC)
From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Date: Mon, 16 Dec 2019 14:00:31 +0100
Message-ID: <20191216130031.21912-1-Anton.Yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3] virtio-snd: add virtio sound device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, kraxel@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

This patch proposes virtio specification for new virtio sound device, that =
may
be useful in case, when having audio is required but a device passthrough o=
r
emulation is not an option.

Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
---

v2 -> v3 changes:
1. Define 4 mandatory queues: control, event, tx and rx.
2. Define feature bits for shared memory transport.
   Make a message-based transport default.
3. Replace device features with stream features.
4. Rework device configuration space, now it contains only the total
   number of available PCM streams.
5. Add the get stream capabilities control request and define
   the stream capabilities structure.
6. Replace the set format with the set parameters control request.
7. Add the PCM notifications section.
8. Rework the PCM I/O messages section.

 conformance.tex  |  22 ++
 content.tex      |   1 +
 virtio-sound.tex | 561 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 584 insertions(+)
 create mode 100644 virtio-sound.tex

diff --git a/conformance.tex b/conformance.tex
index 50969e5..de09e3e 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -191,6 +191,17 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \item \ref{drivernormative:Device Types / RPMB Device / Device Operation}
 \end{itemize}
=20
+\conformance{\subsection}{Sound Driver Conformance}\label{sec:Conformance =
/ Driver Conformance / Sound Driver Conformance}
+
+A sound driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / Sound Device / Device Operation =
/ PCM Stream Parameters}
+\item \ref{drivernormative:Device Types / Sound Device / Device Operation =
/ PCM Notifications}
+\item \ref{drivernormative:Device Types / Sound Device / Device Operation =
/ PCM Output Stream}
+\item \ref{drivernormative:Device Types / Sound Device / Device Operation =
/ PCM Input Stream}
+\end{itemize}
+
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device =
Conformance}
=20
 A device MUST conform to the following normative statements:
@@ -360,6 +371,17 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \item \ref{devicenormative:Device Types / RPMB Device / Device Operation}
 \end{itemize}
=20
+\conformance{\subsection}{Sound Device Conformance}\label{sec:Conformance =
/ Device Conformance / Sound Device Conformance}
+
+A sound device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / Sound Device / Device Initializa=
tion}
+\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ PCM Stream Capabilities}
+\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ PCM Stream Parameters}
+\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ PCM Input Stream}
+\end{itemize}
+
 \conformance{\section}{Legacy Interface: Transitional Device and Transitio=
nal Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitio=
nal Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
 non-transitional, see \ref{intro:Legacy
diff --git a/content.tex b/content.tex
index d68cfaf..70ad066 100644
--- a/content.tex
+++ b/content.tex
@@ -5739,6 +5739,7 @@ \subsubsection{Legacy Interface: Framing Requirements=
}\label{sec:Device
 \input{virtio-vsock.tex}
 \input{virtio-fs.tex}
 \input{virtio-rpmb.tex}
+\input{virtio-sound.tex}
=20
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
=20
diff --git a/virtio-sound.tex b/virtio-sound.tex
new file mode 100644
index 0000000..30b5f4f
--- /dev/null
+++ b/virtio-sound.tex
@@ -0,0 +1,561 @@
+\section{Sound Device}\label{sec:Device Types / Sound Device}
+
+The virtio sound card is a virtual audio device supporting output and inpu=
t PCM
+streams.
+
+A device is managed by control requests and can send various notifications
+through dedicated queues. A driver can transmit PCM frames using message-b=
ased
+transport or shared memory.
+
+\subsection{Device ID}\label{sec:Device Types / Sound Device / Device ID}
+
+25
+
+\subsection{Virtqueues}\label{sec:Device Types / Sound Device / Virtqueues=
}
+
+\begin{description}
+\item[0] controlq
+\item[1] eventq
+\item[2] txq
+\item[3] rxq
+\end{description}
+
+The control queue is used for sending control messages from the driver to
+the device.
+
+The event queue is used for sending notifications from the device to the d=
river.
+
+The tx queue is used for sending PCM I/O messages for an output stream.
+
+The rx queue is used for sending PCM I/O messages for an input stream.
+
+\subsection{Feature bits}\label{sec:Device Types / Sound Device / Feature =
bits}
+
+None currently defined.
+
+\subsection{Device configuration layout}\label{sec:Device Types / Sound De=
vice / Device configuration layout}
+
+\begin{lstlisting}
+struct virtio_snd_config {
+    le32 pcm_streams;
+};
+\end{lstlisting}
+
+A configuration space contains the following field:
+
+\begin{description}
+\item[\field{pcm_streams}] (driver-read-only) is a total number of all ava=
ilable
+PCM streams.
+\end{description}
+
+\subsection{Device Initialization}
+
+\begin{enumerate}
+\item Configure the control, event, tx and rx queues.
+\item Read the \field{pcm_streams} value from the configuration space.
+\item Send control request to query capabilities per each available PCM st=
ream.
+\end{enumerate}
+
+\devicenormative{\subsubsection}{Device Initialization}{Device Types / Sou=
nd Device / Device Initialization}
+
+\begin{enumerate}
+\item The device MUST set non-zero value for the \field{pcm_streams} confi=
guration
+field.
+\end{enumerate}
+
+\subsection{Device Operation}\label{sec:Device Types / Sound Device / Devi=
ce Operation}
+
+All control messages are placed into the control queue and all notificatio=
ns
+are placed into the event queue. They use the following layout structure a=
nd
+definitions:
+
+\begin{lstlisting}
+enum {
+    /* PCM control request types */
+    VIRTIO_SND_R_PCM_GET_CAPS =3D 1,
+    VIRTIO_SND_R_PCM_SET_PARAMS,
+    VIRTIO_SND_R_PCM_PREPARE,
+    VIRTIO_SND_R_PCM_RELEASE,
+    VIRTIO_SND_R_PCM_START,
+    VIRTIO_SND_R_PCM_STOP,
+    VIRTIO_SND_R_PCM_PAUSE,
+    VIRTIO_SND_R_PCM_UNPAUSE,
+
+    /* PCM event types */
+    VIRTIO_SND_EVT_PCM_PERIOD =3D 0x1000,
+    VIRTIO_SND_EVT_PCM_XRUN,
+
+    /* common status codes */
+    VIRTIO_SND_S_OK =3D 0x8000,
+    VIRTIO_SND_S_BAD_MSG,
+    VIRTIO_SND_S_NOT_SUPP,
+    VIRTIO_SND_S_IO_ERR
+};
+
+/* a common header */
+struct virtio_snd_hdr {
+    le32 code;
+};
+\end{lstlisting}
+
+A generic control message consists of a request part and a response part.
+
+A request part has or consists of a common header containing the following
+field:
+
+\begin{description}
+\item[\field{code}] (device-readable) specifies a device request type
+(VIRTIO_SND_R_*).
+\end{description}
+
+A response part has or consists of a common header containing the followin=
g
+field:
+
+\begin{description}
+\item[\field{code}] (device-writable) specifies a device request status
+(VIRTIO_SND_S_*).
+\end{description}
+
+The status field can take one of the following values:
+
+\begin{itemize*}
+\item VIRTIO_SND_S_OK: success.
+\item VIRTIO_SND_S_BAD_MSG: a control message is malformed or contains inv=
alid
+parameters.
+\item VIRTIO_SND_S_NOT_SUPP: requested operation or parameters are not sup=
ported.
+\item VIRTIO_SND_S_IO_ERR: an I/O error occurred.
+\end{itemize*}
+
+The request part may be followed by an additional device-readable payload,
+and the response part may be followed by an additional device-writable pay=
load.
+
+A notification has or consists of a common header containing the following=
 field:
+
+\begin{description}
+\item[\field{code}] (device-writable) specifies an event type (VIRTIO_SND_=
EVT_*).
+\end{description}
+
+A notification header also may be followed by an additional device-writabl=
e
+payload.
+
+\subsubsection{PCM Control Messages}\label{sec:Device Types / Sound Device=
 / Device Operation / PCM Control Messages}
+
+A PCM control request has or consists of a common header with the followin=
g
+layout structure:
+
+\begin{lstlisting}
+struct virtio_snd_pcm_hdr {
+    struct virtio_snd_hdr hdr;
+    le32 stream_id;
+};
+\end{lstlisting}
+
+The header consists of the following field:
+
+\begin{description}
+\item[\field{hdr}] (device-readable) contains request type (VIRTIO_SND_R_P=
CM_*).
+\item[\field{stream_id}] (device-readable) specifies a PCM stream identifi=
er
+from 0 to \field{pcm_streams} - 1.
+\end{description}
+
+\subsubsection{PCM Command Lifecycle}
+
+A PCM stream has the following command lifecycle:
+
+\begin{enumerate}
+\item SET PARAMETERS
+
+The driver negotiates the stream parameters (format, transport, etc) with
+the device.
+
+Possible valid transitions: set parameters, prepare.
+
+\item PREPARE
+
+The device prepares the stream (allocates resources, etc).
+
+Possible valid transitions: start, release.
+
+\item Output only: the driver transfers data for pre-buffing.
+\item START
+
+The device starts the stream (unmute, putting into running state, etc).
+
+Possible valid transitions: pause, stop.
+
+\item The driver transfers data to/from the stream.
+\begin{enumerate}
+\item PAUSE
+
+The device pauses the stream.
+
+Possible valid transitions: unpause, stop.
+
+\item UNPAUSE
+
+The device releases the stream from pause.
+
+Possible valid transitions: pause, stop.
+
+\end{enumerate}
+\item STOP
+
+The device stops the stream (mute, putting into non-running state, etc).
+
+Possible valid transitions: start, release.
+
+\item RELEASE
+
+The device releases the stream (frees resources, etc).
+
+Possible valid transitions: set parameters, prepare.
+
+\end{enumerate}
+
+\paragraph{VIRTIO_SND_R_PCM_GET_CAPS}
+
+Query stream capabilities for the specified stream ID.
+
+The request has no additional payload, and the response uses the following
+structure and layout definitions:
+
+\begin{lstlisting}
+/* supported PCM stream types */
+enum {
+    VIRTIO_SND_PCM_T_OUTPUT =3D 0,
+    VIRTIO_SND_PCM_T_INPUT
+};
+
+/* supported PCM stream features */
+enum {
+    VIRTIO_SND_PCM_F_HOST_MEM =3D 0,
+    VIRTIO_SND_PCM_F_GUEST_MEM,
+    VIRTIO_SND_PCM_F_CHMAP,
+    VIRTIO_SND_PCM_F_EVT_PERIOD,
+    VIRTIO_SND_PCM_F_EVT_XRUN
+};
+
+/* supported PCM sample formats */
+enum {
+    /* analog formats (width / physical width) */
+    VIRTIO_SND_PCM_FMT_IMA_ADPCM =3D 0,   /*  4 /  4 bits */
+    VIRTIO_SND_PCM_FMT_MU_LAW,          /*  8 /  8 bits */
+    VIRTIO_SND_PCM_FMT_A_LAW,           /*  8 /  8 bits */
+    VIRTIO_SND_PCM_FMT_S8,              /*  8 /  8 bits */
+    VIRTIO_SND_PCM_FMT_U8,              /*  8 /  8 bits */
+    VIRTIO_SND_PCM_FMT_S16,             /* 16 / 16 bits */
+    VIRTIO_SND_PCM_FMT_U16,             /* 16 / 16 bits */
+    VIRTIO_SND_PCM_FMT_S18_3,           /* 18 / 24 bits */
+    VIRTIO_SND_PCM_FMT_U18_3,           /* 18 / 24 bits */
+    VIRTIO_SND_PCM_FMT_S20_3,           /* 20 / 24 bits */
+    VIRTIO_SND_PCM_FMT_U20_3,           /* 20 / 24 bits */
+    VIRTIO_SND_PCM_FMT_S24_3,           /* 24 / 24 bits */
+    VIRTIO_SND_PCM_FMT_U24_3,           /* 24 / 24 bits */
+    VIRTIO_SND_PCM_FMT_S20,             /* 20 / 32 bits */
+    VIRTIO_SND_PCM_FMT_U20,             /* 20 / 32 bits */
+    VIRTIO_SND_PCM_FMT_S24,             /* 24 / 32 bits */
+    VIRTIO_SND_PCM_FMT_U24,             /* 24 / 32 bits */
+    VIRTIO_SND_PCM_FMT_S32,             /* 32 / 32 bits */
+    VIRTIO_SND_PCM_FMT_U32,             /* 32 / 32 bits */
+    VIRTIO_SND_PCM_FMT_FLOAT,           /* 32 / 32 bits */
+    VIRTIO_SND_PCM_FMT_FLOAT64,         /* 64 / 64 bits */
+    /* digital formats (width / physical width) */
+    VIRTIO_SND_PCM_FMT_DSD_U8,          /*  8 /  8 bits */
+    VIRTIO_SND_PCM_FMT_DSD_U16,         /* 16 / 16 bits */
+    VIRTIO_SND_PCM_FMT_DSD_U32,         /* 32 / 32 bits */
+    VIRTIO_SND_PCM_FMT_IEC958_SUBFRAME  /* 32 / 32 bits */
+};
+
+/* supported PCM frame rates */
+enum {
+    VIRTIO_SND_PCM_RATE_5512 =3D 0,
+    VIRTIO_SND_PCM_RATE_8000,
+    VIRTIO_SND_PCM_RATE_11025,
+    VIRTIO_SND_PCM_RATE_16000,
+    VIRTIO_SND_PCM_RATE_22050,
+    VIRTIO_SND_PCM_RATE_32000,
+    VIRTIO_SND_PCM_RATE_44100,
+    VIRTIO_SND_PCM_RATE_48000,
+    VIRTIO_SND_PCM_RATE_64000,
+    VIRTIO_SND_PCM_RATE_88200,
+    VIRTIO_SND_PCM_RATE_96000,
+    VIRTIO_SND_PCM_RATE_176400,
+    VIRTIO_SND_PCM_RATE_192000,
+    VIRTIO_SND_PCM_RATE_384000
+};
+
+/* standard channel position definition */
+enum {
+    VIRTIO_SND_PCM_CH_NONE =3D 0, /* undefined */
+    VIRTIO_SND_PCM_CH_NA,       /* silent */
+    VIRTIO_SND_PCM_CH_MONO,     /* mono stream */
+    VIRTIO_SND_PCM_CH_FL,       /* front left */
+    VIRTIO_SND_PCM_CH_FR,       /* front right */
+    VIRTIO_SND_PCM_CH_RL,       /* rear left */
+    VIRTIO_SND_PCM_CH_RR,       /* rear right */
+    VIRTIO_SND_PCM_CH_FC,       /* front center */
+    VIRTIO_SND_PCM_CH_LFE,      /* low frequency (LFE) */
+    VIRTIO_SND_PCM_CH_SL,       /* side left */
+    VIRTIO_SND_PCM_CH_SR,       /* side right */
+    VIRTIO_SND_PCM_CH_RC,       /* rear center */
+    VIRTIO_SND_PCM_CH_FLC,      /* front left center */
+    VIRTIO_SND_PCM_CH_FRC,      /* front right center */
+    VIRTIO_SND_PCM_CH_RLC,      /* rear left center */
+    VIRTIO_SND_PCM_CH_RRC,      /* rear right center */
+    VIRTIO_SND_PCM_CH_FLW,      /* front left wide */
+    VIRTIO_SND_PCM_CH_FRW,      /* front right wide */
+    VIRTIO_SND_PCM_CH_FLH,      /* front left high */
+    VIRTIO_SND_PCM_CH_FCH,      /* front center high */
+    VIRTIO_SND_PCM_CH_FRH,      /* front right high */
+    VIRTIO_SND_PCM_CH_TC,       /* top center */
+    VIRTIO_SND_PCM_CH_TFL,      /* top front left */
+    VIRTIO_SND_PCM_CH_TFR,      /* top front right */
+    VIRTIO_SND_PCM_CH_TFC,      /* top front center */
+    VIRTIO_SND_PCM_CH_TRL,      /* top rear left */
+    VIRTIO_SND_PCM_CH_TRR,      /* top rear right */
+    VIRTIO_SND_PCM_CH_TRC,      /* top rear center */
+    VIRTIO_SND_PCM_CH_TFLC,     /* top front left center */
+    VIRTIO_SND_PCM_CH_TFRC,     /* top front right center */
+    VIRTIO_SND_PCM_CH_TSL,      /* top side left */
+    VIRTIO_SND_PCM_CH_TSR,      /* top side right */
+    VIRTIO_SND_PCM_CH_LLFE,     /* left LFE */
+    VIRTIO_SND_PCM_CH_RLFE,     /* right LFE */
+    VIRTIO_SND_PCM_CH_BC,       /* bottom center */
+    VIRTIO_SND_PCM_CH_BLC,      /* bottom left center */
+    VIRTIO_SND_PCM_CH_BRC       /* bottom right center */
+};
+
+/* a maximum possible number of channels */
+#define VIRTIO_SND_PCM_CH_MAX   16
+
+/* a response containing PCM stream capabilities */
+struct virtio_snd_pcm_caps {
+    struct virtio_snd_hdr hdr; /* VIRTIO_SND_S_* */
+    u8 type;
+    u8 channels_min;
+    u8 channels_max;
+    u8 features; /* 1 << VIRTIO_SND_PCM_F_XXX */
+    le64 formats; /* 1 << VIRTIO_SND_PCM_FMT_XXX */
+    le64 rates; /* 1 << VIRTIO_SND_PCM_RATE_XXX */
+    u8 chmap[VIRTIO_SND_PCM_CH_MAX];
+};
+\end{lstlisting}
+
+The response contains the following fields:
+
+\begin{description}
+\item[\field{type}] (device-writable) is a PCM stream type (VIRTIO_SND_PCM=
_T_*).
+\item[\field{channels_min}] (device-writable) is a minimum number of suppo=
rted
+channels.
+\item[\field{channels_max}] (device-writable) is a maximum number of suppo=
rted
+channels.
+\item[\field{features}] (device-writable) is a supported feature bit map:
+\begin{itemize*}
+\item VIRTIO_SND_PCM_F_HOST_MEM: support sharing a host memory with a gues=
t,
+\item VIRTIO_SND_PCM_F_GUEST_MEM: support sharing a guest memory with a ho=
st,
+\item VIRTIO_SND_PCM_F_CHMAP: support a channel map,
+\item VIRTIO_SND_PCM_F_EVT_PERIOD: support elapsed period notifications,
+\item VIRTIO_SND_PCM_F_EVT_XRUN: support underrun/overrun notifications.
+\end{itemize*}
+\item[\field{formats}] (device-writable) is a supported sample format bit =
map.
+\item[\field{rates}] (device-writable) is a supported frame rate bit map.
+\item[\field{chmap}] (device-writable) if the VIRTIO_SND_PCM_F_CHMAP featu=
re bit
+is set, then the first \field{channels_max} elements are valid and contain
+channel positions (VIRTIO_SND_PCM_CH_*).
+\end{description}
+
+Only interleaved samples are supported.
+
+\devicenormative{\subparagraph}{Stream Capabilities}{Device Types / Sound =
Device / Device Operation / PCM Stream Capabilities}
+
+\begin{itemize*}
+\item The device MUST NOT set undefined stream type values.
+\item The device MUST NOT set undefined feature, format and rate bits.
+\item If the VIRTIO_SND_PCM_F_CHMAP feature bit is not set, then the devic=
e
+MUST initialize the \field{chmap} field with the VIRTIO_SND_PCM_CH_NONE po=
sition
+values.
+\end{itemize*}
+
+\paragraph{VIRTIO_SND_R_PCM_SET_PARAMS}\label{sec:Device Types / Sound Dev=
ice / Device Operation / PCM Stream Parameters}
+
+Set selected stream parameters for the specified stream ID.
+
+The request uses the following structure and layout definitions:
+
+\begin{lstlisting}
+struct virtio_snd_pcm_set_params {
+    struct virtio_snd_pcm_hdr hdr; /* .code =3D VIRTIO_SND_R_PCM_SET_PARAM=
S */
+    u8 features;
+    u8 channels;
+    u8 format;
+    u8 rate;
+    le32 buffer_bytes;
+    le32 period_bytes;
+};
+\end{lstlisting}
+
+The request contains the following fields:
+
+\begin{description}
+\item[\field{features}] (device-readable) is a selected feature bit map:
+\begin{itemize*}
+\item VIRTIO_SND_PCM_F_HOST_MEM: use shared memory allocated by the host (=
TBD),
+\item VIRTIO_SND_PCM_F_GUEST_MEM: use shared memory allocated by the guest=
 (TBD),
+\item VIRTIO_SND_PCM_F_EVT_PERIOD: enable elapsed period notifications,
+\item VIRTIO_SND_PCM_F_EVT_XRUN: enable underrun/overrun notifications.
+\end{itemize*}
+\item[\field{channels}] (device-readable) specifies a selected number of c=
hannels.
+\item[\field{format}] (device-readable) specifies a selected sample format
+(VIRTIO_SND_PCM_FMT_*).
+\item[\field{rate}] (device-readable) specifies a selected frame rate
+(VIRTIO_SND_PCM_RATE_*).
+\item[\field{buffer_bytes}] (device-readable) specifies the size of the ha=
rdware
+buffer used by the driver.
+\item[\field{period_bytes}] (device-readable) if the VIRTIO_SND_PCM_F_EVT_=
PERIOD
+feature bit is selected, then specifies the size of the period used by the=
 driver.
+\end{description}
+
+\devicenormative{\subparagraph}{Stream Parameters}{Device Types / Sound De=
vice / Device Operation / PCM Stream Parameters}
+
+\begin{itemize*}
+\item If the device has an intermediate buffer, its size MUST be no less t=
han
+the specified \field{buffer_bytes} value.
+\end{itemize*}
+
+\drivernormative{\subparagraph}{Stream Parameters}{Device Types / Sound De=
vice / Device Operation / PCM Stream Parameters}
+
+\begin{itemize*}
+\item The driver MUST NOT set undefined feature, format and rate values.
+\item The driver MUST NOT specify the \field{channels} value as less than =
the \field{channels_min}
+or greater than the \field{channels_max} values reported in the stream cap=
abilities.
+\item The driver MUST NOT set feature bits which the device did not offer.
+\item The driver MUST NOT set the VIRTIO_SND_PCM_F_HOST_MEM and VIRTIO_SND=
_PCM_F_GUEST_MEM
+bits at the same time.
+\item If the bits associated with the shared memory are not selected, the =
driver
+MUST use the tx and rx queues for data transfer
+(see \nameref{sec:Device Types / Sound Device / Device Operation / PCM IO =
Messages}).
+\item If the VIRTIO_SND_PCM_F_EVT_PERIOD feature bit is not selected, then
+the driver MUST set the \field{period_bytes} field to 0.
+\end{itemize*}
+
+\paragraph{VIRTIO_SND_R_PCM_PREPARE}
+
+Prepare a stream with specified stream ID.
+
+\paragraph{VIRTIO_SND_R_PCM_RELEASE}
+
+Release a stream with specified stream ID.
+
+\paragraph{VIRTIO_SND_R_PCM_START}
+
+Start a stream with specified stream ID.
+
+\paragraph{VIRTIO_SND_R_PCM_STOP}
+
+Stop a stream with specified stream ID.
+
+\paragraph{VIRTIO_SND_R_PCM_PAUSE}
+
+Set a stream with specified stream ID on pause.
+
+\paragraph{VIRTIO_SND_R_PCM_UNPAUSE}
+
+Resume a paused stream with specified stream ID.
+
+\subsubsection{PCM Notifications}
+
+The device can announce support for different PCM events using feature bit=
s
+in the stream capabilities structure. To enable notifications, the driver
+must negotiate these features using the set stream parameters request
+(see \ref{sec:Device Types / Sound Device / Device Operation / PCM Stream =
Parameters}).
+
+The following PCM event types are currently supported:
+
+\begin{itemize*}
+\item VIRTIO_SND_EVT_PCM_PERIOD: send notifications about each elapsed per=
iod,
+the size of the period is specified in the \field{period_bytes} field.
+\item VIRTIO_SND_EVT_PCM_XRUN: send notification about underflow for the o=
utput
+stream or overflow for the input stream.
+\end{itemize*}
+
+A PCM notification consists of the struct virtio_snd_pcm_hdr
+(see \ref{sec:Device Types / Sound Device / Device Operation / PCM Control=
 Messages})
+and contains the following fields:
+
+\begin{description}
+\item[\field{hdr}] (device-writable) contains event type (VIRTIO_SND_EVT_P=
CM_*).
+\item[\field{stream_id}] (device-writable) specifies a PCM stream identifi=
er
+from 0 to \field{pcm_streams} - 1.
+\end{description}
+
+\drivernormative{\paragraph}{PCM Notifications}{Device Types / Sound Devic=
e / Device Operation / PCM Notifications}
+
+\begin{itemize}
+\item If VIRTIO_SND_PCM_F_EVT_PERIOD and/or VIRTIO_SND_PCM_F_EVT_XRUN is n=
egotiated:
+\begin{itemize}
+\item The driver MUST populate the event queue with empty buffers before s=
tarting
+the stream.
+\item Each buffer MUST be at least the size of the struct virtio_snd_pcm_h=
dr.
+\end{itemize}
+\end{itemize}
+
+\subsubsection{PCM I/O Messages}\label{sec:Device Types / Sound Device / D=
evice Operation / PCM IO Messages}
+
+An I/O message consists of the header part, followed by the buffer, and th=
en
+the status part.
+
+\begin{lstlisting}
+/* an I/O header */
+struct virtio_snd_pcm_xfer {
+    le32 stream_id;
+};
+\end{lstlisting}
+
+The header part consists of the following field:
+
+\begin{description}
+\item[\field{stream_id}] (device-readable) specifies a PCM stream identifi=
er
+from 0 to \field{pcm_streams} - 1.
+\end{description}
+
+The status part consists of the struct virtio_snd_hdr
+(see \ref{sec:Device Types / Sound Device / Device Operation}) and contain=
s the
+following field:
+
+\begin{description}
+\item[\field{code}] (device-writable) contains VIRTIO_SND_S_OK if an opera=
tion
+is successful, and VIRTIO_SND_S_IO_ERR otherwise.
+\end{description}
+
+\paragraph{Output Stream}
+
+In case of an output stream, the header is followed by a device-readable b=
uffer
+containing PCM frames for writing to the device. All messages are placed i=
nto
+the tx queue.
+
+\drivernormative{\subparagraph}{Output Stream}{Device Types / Sound Device=
 / Device Operation / PCM Output Stream}
+
+\begin{itemize*}
+\item The driver MUST NOT place device-writable buffers into the tx queue.
+\end{itemize*}
+
+\paragraph{Input Stream}
+
+In case of an input stream, the header is followed by a device-writable bu=
ffer
+being populated with PCM frames from the device. All messages are placed i=
nto
+the rx queue.
+
+\devicenormative{\subparagraph}{Input Stream}{Device Types / Sound Device =
/ Device Operation / PCM Input Stream}
+
+\begin{itemize*}
+\item The device MUST NOT complete the I/O request until the buffer is ful=
l.
+The only exception is the end of the stream.
+\end{itemize*}
+
+\drivernormative{\subparagraph}{Input Stream}{Device Types / Sound Device =
/ Device Operation / PCM Input Stream}
+
+\begin{itemize*}
+\item The driver MUST populate the rx queue with empty buffers before star=
ting
+the stream.
+\item The driver MUST NOT place device-readable buffers into the rx queue.
+\end{itemize*}
--=20
2.24.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

