Return-Path: virtio-dev-return-6636-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4EC73985E3F
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Jan 2020 14:08:08 +0000 (UTC)
From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Date: Thu, 9 Jan 2020 15:07:43 +0100
Message-ID: <20200109140743.303046-1-Anton.Yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v5] virtio-snd: add virtio sound device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, kraxel@redhat.com, jean-philippe@linaro.org, Anton Yakovlev <anton.yakovlev@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This patch proposes virtio specification for a new virtio sound device,
that may be useful in case when having audio is required but a device
passthrough or emulation is not an option.

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---

v4 -> v5 changes:
1. Insert the virtio_snd_hdr to the virtio_snd_event structure.
2. Rephrase field description in structures.
3. Resize the features and rates fields in a stream configuration.
4. Replace MUST with SHOULD in queued buffer size requirements.

 conformance.tex  |  24 ++
 content.tex      |   1 +
 introduction.tex |   3 +
 virtio-sound.tex | 700 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 728 insertions(+)
 create mode 100644 virtio-sound.tex

diff --git a/conformance.tex b/conformance.tex
index 50969e5..b8c6836 100644
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
+\item \ref{drivernormative:Device Types / Sound Device / Device Initializa=
tion}
+\item \ref{drivernormative:Device Types / Sound Device / Device Operation =
/ PCM Stream Parameters}
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
@@ -360,6 +371,19 @@ \section{Conformance Targets}\label{sec:Conformance / =
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
/ Jack Configuration}
+\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ PCM Stream Configuration}
+\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ PCM Stream Parameters}
+\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ PCM Output Stream}
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
diff --git a/introduction.tex b/introduction.tex
index 33da3ec..07674f8 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -66,6 +66,9 @@ \section{Normative References}\label{sec:Normative Refere=
nces}
         \phantomsection\label{intro:eMMC}\textbf{[eMMC]} &
         eMMC Electrical Standard (5.1), JESD84-B51,
         \newline\url{http://www.jedec.org/sites/default/files/docs/JESD84-=
B51.pdf}\\
+=09\phantomsection\label{intro:HDA}\textbf{[HDA]} &
+=09High Definition Audio Specification,
+=09\newline\url{https://www.intel.com/content/dam/www/public/us/en/documen=
ts/product-specifications/high-definition-audio-specification.pdf}\\
=20
 \end{longtable}
=20
diff --git a/virtio-sound.tex b/virtio-sound.tex
new file mode 100644
index 0000000..2cd3f2e
--- /dev/null
+++ b/virtio-sound.tex
@@ -0,0 +1,700 @@
+\section{Sound Device}\label{sec:Device Types / Sound Device}
+
+The virtio sound card is a virtual audio device supporting input, output a=
nd
+bidirectional PCM streams.
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
+    le32 jacks;
+    le32 streams;
+};
+\end{lstlisting}
+
+A configuration space contains the following fields:
+
+\begin{description}
+\item[\field{jacks}] (driver-read-only) indicates a total number of all av=
ailable
+jacks.
+\item[\field{streams}] (driver-read-only) indicates a total number of all =
available
+PCM streams.
+\end{description}
+
+\subsection{Device Initialization}
+
+\begin{enumerate}
+\item Configure the control, event, tx and rx queues.
+\item Read the \field{jacks} field and send control requests to query conf=
iguration
+for each available jack.
+\item Read the \field{streams} field and send control requests to query co=
nfiguration
+for each available PCM stream.
+\item Populate the event queue with empty buffers.
+\end{enumerate}
+
+\devicenormative{\subsubsection}{Device Initialization}{Device Types / Sou=
nd Device / Device Initialization}
+
+\begin{itemize}
+\item The device MUST set a non-zero value for the \field{jacks} configura=
tion
+field.
+\item The device MUST set a non-zero value for the \field{streams} configu=
ration
+field.
+\end{itemize}
+
+\drivernormative{\subsubsection}{Device Initialization}{Device Types / Sou=
nd Device / Device Initialization}
+
+\begin{itemize}
+\item The driver MUST populate the event queue with empty buffers of at le=
ast
+the struct virtio_snd_event size.
+\item The driver MUST NOT put a device-readable buffers in the event queue=
.
+\end{itemize}
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
+    /* jack control request types */
+    VIRTIO_SND_R_JACK_GET_CONFIG =3D 1,
+    VIRTIO_SND_R_JACK_REMAP,
+
+    /* PCM control request types */
+    VIRTIO_SND_R_PCM_GET_CONFIG =3D 0x0100,
+    VIRTIO_SND_R_PCM_SET_PARAMS,
+    VIRTIO_SND_R_PCM_PREPARE,
+    VIRTIO_SND_R_PCM_RELEASE,
+    VIRTIO_SND_R_PCM_START,
+    VIRTIO_SND_R_PCM_STOP,
+
+    /* jack event types */
+    VIRTIO_SND_EVT_JACK_CONNECTED =3D 0x1000,
+    VIRTIO_SND_EVT_JACK_DISCONNECTED,
+
+    /* PCM event types */
+    VIRTIO_SND_EVT_PCM_PERIOD_ELAPSED =3D 0x1100,
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
+
+/* an event notification */
+struct virtio_snd_event {
+    struct virtio_snd_hdr hdr;
+    le32 data;
+};
+\end{lstlisting}
+
+A generic control message consists of a request part and a response part.
+
+A request part has, or consists of, a common header containing the followi=
ng
+device-readable field:
+
+\begin{description}
+\item[\field{code}] specifies a device request type (VIRTIO_SND_R_*).
+\end{description}
+
+A response part has, or consists of, a common header containing the follow=
ing
+device-writable field:
+
+\begin{description}
+\item[\field{code}] indicates a device request status (VIRTIO_SND_S_*).
+\end{description}
+
+The status field can take one of the following values:
+
+\begin{itemize}
+\item VIRTIO_SND_S_OK - success.
+\item VIRTIO_SND_S_BAD_MSG - a control message is malformed or contains in=
valid
+parameters.
+\item VIRTIO_SND_S_NOT_SUPP - requested operation or parameters are not su=
pported.
+\item VIRTIO_SND_S_IO_ERR - an I/O error occurred.
+\end{itemize}
+
+The request part may be followed by an additional device-readable payload,
+and the response part may be followed by an additional device-writable pay=
load.
+
+An event notification contains the following device-writable fields:
+
+\begin{description}
+\item[\field{hdr}] indicates an event type (VIRTIO_SND_EVT_*).
+\item[\field{data}] indicates an optional event data.
+\end{description}
+
+\subsubsection{Jack Control Messages}\label{sec:Device Types / Sound Devic=
e / Device Operation / Jack Control Messages}
+
+A jack control request has, or consists of, a common header with the follo=
wing
+layout structure:
+
+\begin{lstlisting}
+struct virtio_snd_jack_hdr {
+    struct virtio_snd_hdr hdr;
+    le32 jack_id;
+};
+\end{lstlisting}
+
+The header consists of the following device-readable fields:
+
+\begin{description}
+\item[\field{hdr}] specifies a request type (VIRTIO_SND_R_JACK_*).
+\item[\field{jack_id}] specifies a jack identifier from 0 to \field{jacks}=
 - 1.
+\end{description}
+
+\paragraph{VIRTIO_SND_R_JACK_GET_CONFIG}
+
+Query a jack configuration for the specified jack ID.
+
+The request has no additional payload, and the response uses the following
+structure and layout definitions:
+
+\begin{lstlisting}
+/* supported jack features */
+enum {
+    VIRTIO_SND_JACK_F_REMAP =3D 0
+};
+
+/* a response containing jack configuration */
+struct virtio_snd_jack_config {
+    struct virtio_snd_hdr hdr; /* VIRTIO_SND_S_XXX */
+    le32 association;
+    le32 sequence;
+    le32 features; /* 1 << VIRTIO_SND_JACK_F_XXX */
+    u8 connected;
+    u8 color;
+    u8 connection_type;
+    u8 device;
+    u8 location;
+    u8 port_connectivity;
+
+    u8 padding[2];
+};
+\end{lstlisting}
+
+The response contains the following device-writable fields:
+
+\begin{description}
+\item[\field{association}] indicates the current jack association. All jac=
ks
+with the same association number are intended to be grouped together to pr=
ovide
+multichannel support.
+\item[\field{sequence}] indicates the order of the jacks in the associatio=
n. The
+lowest numbered jack in the association should be assigned the lowest numb=
ered
+channels in the stream, etc.
+\item[\field{features}] indicates a supported feature bit map:
+\begin{itemize}
+\item VIRTIO_SND_JACK_F_REMAP - jack remapping support.
+\end{itemize}
+\item[\field{connected}] indicates the current jack connection status
+(1 - connected, 0 - disconnected).
+\item[\field{color}] indicates the color of the physical jack
+(values are documented in \hyperref[intro:HDA]{HDA}).
+\item[\field{connection_type}] indicates the type of physical connection
+(values are documented in \hyperref[intro:HDA]{HDA}).
+\item[\field{device}] indicates the intended use of the jack or device
+(values are documented in \hyperref[intro:HDA]{HDA}).
+\item[\field{location}] indicates the physical location of the jack or dev=
ice
+(values are documented in \hyperref[intro:HDA]{HDA}).
+\item[\field{port_connectivity}] indicates the external connectivity
+(values are documented in \hyperref[intro:HDA]{HDA}).
+\end{description}
+
+\devicenormative{\subparagraph}{Jack Configuration}{Device Types / Sound D=
evice / Device Operation / Jack Configuration}
+
+\begin{itemize}
+\item The device MUST NOT set undefined jack feature bits.
+\item The device MUST initialize \field{padding} bytes to 0.
+\end{itemize}
+
+\paragraph{VIRTIO_SND_R_JACK_REMAP}
+
+If the VIRTIO_SND_JACK_F_REMAP feature bit is set in the jack configuratio=
n,
+then the driver can send a control request to change the association and/o=
r
+sequence number for the specified jack ID.
+
+The request uses the following structure and layout definitions:
+
+\begin{lstlisting}
+struct virtio_snd_jack_remap {
+    struct virtio_snd_jack_hdr hdr; /* .code =3D VIRTIO_SND_R_JACK_REMAP *=
/
+    le32 association;
+    le32 sequence;
+};
+\end{lstlisting}
+
+The request contains the following device-readable fields:
+
+\begin{description}
+\item[\field{association}] specifies the selected association number.
+\item[\field{sequence}] specifies the selected sequence number.
+\end{description}
+
+\subsubsection{Jack Notifications}
+
+Jack notifications consist of a virtio_snd_event structure, which has the =
following
+device-writable fields:
+
+\begin{description}
+\item[\field{hdr}] indicates a jack event type:
+\begin{itemize}
+\item VIRTIO_SND_EVT_JACK_CONNECTED - an external device has been connecte=
d to the jack.
+\item VIRTIO_SND_EVT_JACK_DISCONNECTED - an external device has been disco=
nnected from the jack.
+\end{itemize}
+\item[\field{data}] indicates a jack identifier from 0 to \field{jacks} - =
1.
+\end{description}
+
+\subsubsection{PCM Control Messages}\label{sec:Device Types / Sound Device=
 / Device Operation / PCM Control Messages}
+
+A PCM control request has, or consists of, a common header with the follow=
ing
+layout structure:
+
+\begin{lstlisting}
+struct virtio_snd_pcm_hdr {
+    struct virtio_snd_hdr hdr;
+    le32 stream_id;
+};
+\end{lstlisting}
+
+The header consists of the following device-readable fields:
+
+\begin{description}
+\item[\field{hdr}] specifies request type (VIRTIO_SND_R_PCM_*).
+\item[\field{stream_id}] specifies a PCM stream identifier from 0 to \fiel=
d{streams} - 1.
+\end{description}
+
+\paragraph{PCM Command Lifecycle}
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
+
+\item START
+
+The device starts the stream (unmute, putting into running state, etc).
+
+Possible valid transitions: stop.
+
+\item The driver transfers data to/from the stream.
+
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
+\paragraph{VIRTIO_SND_R_PCM_GET_CONFIG}
+
+Query stream configuration for the specified stream ID.
+
+The request has no additional payload, and the response uses the following
+structure and layout definitions:
+
+\begin{lstlisting}
+/* supported PCM stream directions */
+enum {
+    VIRTIO_SND_PCM_T_OUTPUT =3D 0,
+    VIRTIO_SND_PCM_T_INPUT
+};
+
+/* supported PCM stream features */
+enum {
+    VIRTIO_SND_PCM_F_SHMEM_HOST =3D 0,
+    VIRTIO_SND_PCM_F_SHMEM_GUEST,
+    VIRTIO_SND_PCM_F_CHMAP,
+    VIRTIO_SND_PCM_F_EVT_SHMEM_PERIODS,
+    VIRTIO_SND_PCM_F_EVT_XRUNS
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
+    VIRTIO_SND_PCM_CH_NONE =3D 0,=09/* undefined */
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
+/* a response containing PCM stream configuration */
+struct virtio_snd_pcm_config {
+    struct virtio_snd_hdr hdr; /* VIRTIO_SND_S_XXX */
+    le32 association;
+    le32 features; /* 1 << VIRTIO_SND_PCM_F_XXX */
+    u8 directions; /* 1 << VIRTIO_SND_PCM_T_XXX */
+    u8 channels_min;
+    u8 channels_max;
+    u8 reserved;
+    le64 formats; /* 1 << VIRTIO_SND_PCM_FMT_XXX */
+    le64 rates; /* 1 << VIRTIO_SND_PCM_RATE_XXX */
+    u8 chmap[VIRTIO_SND_PCM_CH_MAX];
+};
+\end{lstlisting}
+
+The response contains the following device-writable fields:
+
+\begin{description}
+\item[\field{association}] indicates a stream association. All streams wit=
h the
+same association number are intended to be grouped together to share all j=
acks
+with the same association number as their physical input/output. The assoc=
iation
+can also be used by software to prioritize resource allocation in constrai=
ned
+situations. Lower association values would be higher in priority for resou=
rces.
+Unlike jacks, stream associations cannot be changed.
+\item[\field{features}] indicates a supported feature bit map:
+\begin{itemize}
+\item VIRTIO_SND_PCM_F_SHMEM_HOST - supports sharing a host memory with a =
guest,
+\item VIRTIO_SND_PCM_F_SHMEM_GUEST - supports sharing a guest memory with =
a host,
+\item VIRTIO_SND_PCM_F_CHMAP - supports a channel map,
+\item VIRTIO_SND_PCM_F_EVT_SHMEM_PERIODS - supports elapsed period notific=
ations
+for shared memory transport,
+\item VIRTIO_SND_PCM_F_EVT_XRUNS - supports underrun/overrun notifications=
.
+\end{itemize}
+\item[\field{directions}] indicates a supported direction bit map.
+\item[\field{channels_min}] indicates a minimum number of supported channe=
ls.
+\item[\field{channels_max}] indicates a maximum number of supported channe=
ls.
+\item[\field{formats}] indicates a supported sample format bit map.
+\item[\field{rates}] indicates a supported frame rate bit map.
+\item[\field{chmap}] if the VIRTIO_SND_PCM_F_CHMAP feature bit is set, the=
n the
+first \field{channels_max} elements are valid and contain channel position=
s
+(VIRTIO_SND_PCM_CH_*).
+\end{description}
+
+Only interleaved samples are supported.
+
+\devicenormative{\subparagraph}{Stream Configuration}{Device Types / Sound=
 Device / Device Operation / PCM Stream Configuration}
+
+\begin{itemize}
+\item The device MUST NOT set undefined direction, feature, format and rat=
e bits.
+\item The device MUST initialize the \field{reserved} field to 0.
+\item If the VIRTIO_SND_PCM_F_CHMAP feature bit is not set, then the devic=
e
+MUST initialize the \field{chmap} field with the VIRTIO_SND_PCM_CH_NONE po=
sition
+values.
+\end{itemize}
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
+    le32 buffer_bytes;
+    le32 period_bytes;
+    u8 direction;
+    u8 features;
+    u8 channels;
+    u8 format;
+    u8 rate;
+
+    u8 padding[3];
+};
+\end{lstlisting}
+
+The request contains the following device-readable fields:
+
+\begin{description}
+\item[\field{buffer_bytes}] specifies the size of the hardware buffer used=
 by
+the driver.
+\item[\field{period_bytes}] specifies the size of the hardware period used=
 by
+the driver.
+\item[\field{direction}] specifies a selected stream direction (VIRTIO_SND=
_PCM_T_*).
+\item[\field{features}] specifies a selected feature bit map:
+\begin{itemize}
+\item VIRTIO_SND_PCM_F_SHMEM_HOST - use shared memory allocated by the hos=
t
+(is a placeholder and MUST NOT be selected at the moment),
+\item VIRTIO_SND_PCM_F_SHMEM_GUEST - use shared memory allocated by the gu=
est
+(is a placeholder and MUST NOT be selected at the moment),
+\item VIRTIO_SND_PCM_F_EVT_SHMEM_PERIODS - enable elapsed period notificat=
ions
+for shared memory transport,
+\item VIRTIO_SND_PCM_F_EVT_XRUNS - enable underrun/overrun notifications.
+\end{itemize}
+\item[\field{channels}] specifies a selected number of channels.
+\item[\field{format}] specifies a selected sample format (VIRTIO_SND_PCM_F=
MT_*).
+\item[\field{rate}] specifies a selected frame rate (VIRTIO_SND_PCM_RATE_*=
).
+\end{description}
+
+\devicenormative{\subparagraph}{Stream Parameters}{Device Types / Sound De=
vice / Device Operation / PCM Stream Parameters}
+
+\begin{itemize}
+\item If the device has an intermediate buffer, its size MUST be no less t=
han
+the specified \field{buffer_bytes} value.
+\end{itemize}
+
+\drivernormative{\subparagraph}{Stream Parameters}{Device Types / Sound De=
vice / Device Operation / PCM Stream Parameters}
+
+\begin{itemize}
+\item \field{period_bytes} MUST be a divider \field{buffer_bytes}, i.e. \f=
ield{buffer_bytes} \% \field{period_bytes} =3D=3D 0.
+\item The driver MUST NOT set undefined direction, feature, format and rat=
e values.
+\item The driver MUST NOT set the direction, feature, format, and rate tha=
t are
+not specified in the stream configuration.
+\item In the case of a unidirectional stream, the driver MUST use the same=
 direction
+value as specified in the stream configuration.
+\item The driver MUST NOT set the \field{channels} value as less than the =
\field{channels_min}
+or greater than the \field{channels_max} values specified in the stream co=
nfiguration.
+\item The driver MUST NOT set the VIRTIO_SND_PCM_F_SHMEM_HOST and VIRTIO_S=
ND_PCM_F_SHMEM_GUEST
+bits at the same time.
+\item The driver MUST initialize the \field{padding} bytes to 0.
+\item If the bits associated with the shared memory are not selected, the =
driver
+MUST use the tx and rx queues for data transfer
+(see \nameref{sec:Device Types / Sound Device / Device Operation / PCM IO =
Messages}).
+\end{itemize}
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
+\subsubsection{PCM Notifications}
+
+The device can announce support for different PCM events using feature bit=
s
+in the stream configuration structure. To enable notifications, the driver
+must negotiate these features using the set stream parameters request
+(see \ref{sec:Device Types / Sound Device / Device Operation / PCM Stream =
Parameters}).
+
+PCM stream notifications consist of a virtio_snd_event structure, which ha=
s the
+following device-writable fields:
+
+\begin{description}
+\item[\field{hdr}] indicates a PCM stream event type:
+\begin{itemize}
+\item VIRTIO_SND_EVT_PCM_PERIOD_ELAPSED - a hardware buffer period has ela=
psed,
+the period size is controlled using the \field{period_bytes} field.
+\item VIRTIO_SND_EVT_PCM_XRUN - an underflow for the output stream or an o=
verflow
+for the input stream has occurred.
+\end{itemize}
+\item[\field{data}] indicates a PCM stream identifier from 0 to \field{str=
eams} - 1.
+\end{description}
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
+
+/* an I/O status */
+struct virtio_snd_pcm_status {
+    le32 status;
+    le32 latency_bytes;
+};
+\end{lstlisting}
+
+The header part consists of the following device-readable field:
+
+\begin{description}
+\item[\field{stream_id}] specifies a PCM stream identifier from 0 to \fiel=
d{streams} - 1.
+\end{description}
+
+The status part consists of the following device-writable fields:
+
+\begin{description}
+\item[\field{status}] contains VIRTIO_SND_S_OK if an operation is successf=
ul,
+and VIRTIO_SND_S_IO_ERR otherwise.
+\item[\field{latency_bytes}] indicates the current device latency.
+\end{description}
+
+Since all buffers in the queue (with one exception) should be of the size
+\field{period_bytes}, the completion of such an I/O request can be conside=
red an
+elapsed period notification.
+
+\paragraph{Output Stream}
+
+In case of an output stream, the header is followed by a device-readable b=
uffer
+containing PCM frames for writing to the device. All messages are placed i=
nto
+the tx queue.
+
+\devicenormative{\subparagraph}{Output Stream}{Device Types / Sound Device=
 / Device Operation / PCM Output Stream}
+
+\begin{itemize}
+\item The device MUST NOT complete the I/O request until the buffer is tot=
ally
+consumed.
+\end{itemize}
+
+\drivernormative{\subparagraph}{Output Stream}{Device Types / Sound Device=
 / Device Operation / PCM Output Stream}
+
+\begin{itemize}
+\item The driver SHOULD populate the tx queue with \field{period_bytes} si=
zed
+buffers. The only exception is the end of the stream.
+\item The driver MUST NOT place device-writable buffers into the tx queue.
+\end{itemize}
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
+\begin{itemize}
+\item The device MUST NOT complete the I/O request until the buffer is ful=
l.
+The only exception is the end of the stream.
+\end{itemize}
+
+\drivernormative{\subparagraph}{Input Stream}{Device Types / Sound Device =
/ Device Operation / PCM Input Stream}
+
+\begin{itemize}
+\item The driver SHOULD populate the rx queue with \field{period_bytes} si=
zed
+empty buffers before starting the stream.
+\item The driver MUST NOT place device-readable buffers into the rx queue.
+\end{itemize}
--=20
2.25.0.rc2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

