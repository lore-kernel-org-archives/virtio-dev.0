Return-Path: virtio-dev-return-6920-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A203A985FD9
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Mar 2020 14:04:58 +0000 (UTC)
From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Date: Wed, 11 Mar 2020 15:04:32 +0100
Message-ID: <20200311140432.433238-1-Anton.Yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v7] virtio-snd: add virtio sound device specification
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

v6 -> v7 changes:
1. Add more detailed rationale of relationships with the High Definition Au=
dio
   specification.
2. Rework jack configuration structure, now it's more aligned with the HDA =
spec.
3. Extend explanation of the VIRTIO_SND_PCM_F_MSG_POLLING feature.

 conformance.tex  |  32 ++-
 content.tex      |   1 +
 introduction.tex |   3 +
 virtio-sound.tex | 729 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 762 insertions(+), 3 deletions(-)
 create mode 100644 virtio-sound.tex

diff --git a/conformance.tex b/conformance.tex
index b6fdec0..4de3317 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -15,7 +15,7 @@ \section{Conformance Targets}\label{sec:Conformance / Con=
formance Targets}
   \begin{itemize}
     \item Clause \ref{sec:Conformance / Driver Conformance}.
     \item One of clauses \ref{sec:Conformance / Driver Conformance / PCI D=
river Conformance}, \ref{sec:Conformance / Driver Conformance / MMIO Driver=
 Conformance} or \ref{sec:Conformance / Driver Conformance / Channel I/O Dr=
iver Conformance}.
-    \item One of clauses \ref{sec:Conformance / Driver Conformance / Netwo=
rk Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Block D=
river Conformance}, \ref{sec:Conformance / Driver Conformance / Console Dri=
ver Conformance}, \ref{sec:Conformance / Driver Conformance / Entropy Drive=
r Conformance}, \ref{sec:Conformance / Driver Conformance / Traditional Mem=
ory Balloon Driver Conformance}, \ref{sec:Conformance / Driver Conformance =
/ SCSI Host Driver Conformance}, \ref{sec:Conformance / Driver Conformance =
/ Input Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Cr=
ypto Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Socke=
t Driver Conformance} or \ref{sec:Conformance / Driver Conformance / IOMMU =
Driver Conformance}.
+    \item One of clauses \ref{sec:Conformance / Driver Conformance / Netwo=
rk Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Block D=
river Conformance}, \ref{sec:Conformance / Driver Conformance / Console Dri=
ver Conformance}, \ref{sec:Conformance / Driver Conformance / Entropy Drive=
r Conformance}, \ref{sec:Conformance / Driver Conformance / Traditional Mem=
ory Balloon Driver Conformance}, \ref{sec:Conformance / Driver Conformance =
/ SCSI Host Driver Conformance}, \ref{sec:Conformance / Driver Conformance =
/ Input Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Cr=
ypto Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Socke=
t Driver Conformance}, \ref{sec:Conformance / Driver Conformance / IOMMU Dr=
iver Conformance} or \ref{sec:Conformance / Driver Conformance / Sound Driv=
er Conformance}.
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Dev=
ice and Transitional Driver Conformance}.
   \end{itemize}
 \item[Device] A device MUST conform to four conformance clauses:
@@ -32,8 +32,9 @@ \section{Conformance Targets}\label{sec:Conformance / Con=
formance Targets}
 \ref{sec:Conformance / Device Conformance / Input Device Conformance},=20
 \ref{sec:Conformance / Device Conformance / Crypto Device Conformance},=20
 \ref{sec:Conformance / Device Conformance / Socket Device Conformance},=20
-\ref{sec:Conformance / Device Conformance / RPMB Device Conformance} or=20
-\ref{sec:Conformance / Device Conformance / IOMMU Device Conformance}.
+\ref{sec:Conformance / Device Conformance / RPMB Device Conformance},
+\ref{sec:Conformance / Device Conformance / IOMMU Device Conformance} or
+\ref{sec:Conformance / Device Conformance / Sound Device Conformance}.
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Dev=
ice and Transitional Driver Conformance}.
   \end{itemize}
 \end{description}
@@ -220,6 +221,17 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / Fault reporting}
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
@@ -408,6 +420,20 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / Fault reporting}
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
/ PCM Stream Release}
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
index b91a132..edab0ca 100644
--- a/content.tex
+++ b/content.tex
@@ -6062,6 +6062,7 @@ \subsubsection{Legacy Interface: Framing Requirements=
}\label{sec:Device
 \input{virtio-fs.tex}
 \input{virtio-rpmb.tex}
 \input{virtio-iommu.tex}
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
index 0000000..52dd3e9
--- /dev/null
+++ b/virtio-sound.tex
@@ -0,0 +1,729 @@
+\section{Sound Device}\label{sec:Device Types / Sound Device}
+
+The virtio sound card is a virtual audio device supporting input and outpu=
t PCM
+streams.
+
+A device is managed by control requests and can send various notifications
+through dedicated queues. A driver can transmit PCM frames using message-b=
ased
+transport or shared memory.
+
+A small part of the specification reuses existing layouts and values from =
the
+High Definition Audio specification (\hyperref[intro:HDA]{HDA}). It allows=
 to
+provide the same functionality and assist in two possible cases:
+
+\begin{enumerate}
+\item implementation of a universal sound driver,
+\item implementation of a sound driver as part of the High Definition Audi=
o
+subsystem.
+\end{enumerate}
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
+The tx queue is used to send PCM frames for output streams.
+
+The rx queue is used to receive PCM frames from input streams.
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
+For all entities involved in the exchange of audio data, the device uses o=
ne of
+the following data flow directions:
+
+\begin{lstlisting}
+enum {
+    VIRTIO_SND_D_OUTPUT =3D 0,
+    VIRTIO_SND_D_INPUT
+};
+\end{lstlisting}
+
+\subsubsection{Relationships with the High Definition Audio specification}=
\label{sec:Device Types / Sound Device / Device Operation / Relationships w=
ith HDA}
+
+The High Definition Audio specification introduces the codec as part of th=
e
+hardware that implements some of the functionality. The codec architecture=
 and
+capabilities are described by tree structure of special nodes each of whic=
h is
+either a function module or a function group (see \hyperref[intro:HDA]{HDA=
} for
+details).
+
+The virtio sound specification assumes that a single codec is implemented =
in the
+device. Function module nodes are simulated by entity configuration struct=
ures,
+and functional group nodes are simulated by the \field{hda_fn_nid} field i=
n each
+such structure.
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
+    le32 features; /* 1 << VIRTIO_SND_JACK_F_XXX */
+    le32 hda_fn_nid;
+    le32 hda_reg_defconf;
+    le32 hda_reg_caps;
+    u8 connected;
+
+    u8 padding[3];
+};
+\end{lstlisting}
+
+The response contains the following device-writable fields:
+
+\begin{description}
+\item[\field{features}] indicates a supported feature bit map:
+\begin{itemize}
+\item VIRTIO_SND_JACK_F_REMAP - jack remapping support.
+\end{itemize}
+\item[\field{hda_fn_nid}] indicates a functional node identifier
+(see \hyperref[intro:HDA]{HDA}, section 7.1.2).
+\item[\field{hda_reg_defconf}] indicates a pin default configuration value
+(see \hyperref[intro:HDA]{HDA}, section 7.3.3.31).
+\item[\field{hda_reg_caps}] indicates a pin capabilities value
+(see \hyperref[intro:HDA]{HDA}, section 7.3.4.9).
+\item[\field{connected}] indicates the current jack connection status
+(1 - connected, 0 - disconnected).
+\end{description}
+
+\devicenormative{\subparagraph}{Jack Configuration}{Device Types / Sound D=
evice / Device Operation / Jack Configuration}
+
+\begin{itemize}
+\item The device MUST NOT set undefined feature values.
+\item The device MUST initialize the \field{padding} bytes to 0.
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
+Possible valid transitions: set parameters, prepare, start, release.
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
+/* supported PCM stream features */
+enum {
+    VIRTIO_SND_PCM_F_SHMEM_HOST =3D 0,
+    VIRTIO_SND_PCM_F_SHMEM_GUEST,
+    VIRTIO_SND_PCM_F_MSG_POLLING,
+    VIRTIO_SND_PCM_F_EVT_SHMEM_PERIODS,
+    VIRTIO_SND_PCM_F_EVT_XRUNS
+};
+
+/* additional PCM stream flags */
+enum {
+    VIRTIO_SND_PCM_FL_CHMAP =3D 0
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
+    le32 hda_fn_nid;
+    le32 features; /* 1 << VIRTIO_SND_PCM_F_XXX */
+    u8 flags; /* 1 << VIRTIO_SND_PCM_FL_XXX */
+    u8 direction;
+    u8 channels_min;
+    u8 channels_max;
+    le64 formats; /* 1 << VIRTIO_SND_PCM_FMT_XXX */
+    le64 rates; /* 1 << VIRTIO_SND_PCM_RATE_XXX */
+    u8 chmap[VIRTIO_SND_PCM_CH_MAX];
+};
+\end{lstlisting}
+
+The response contains the following device-writable fields:
+
+\begin{description}
+\item[\field{hda_fn_nid}] indicates a functional node identifier
+(see \hyperref[intro:HDA]{HDA}, section 7.1.2).
+\item[\field{features}] indicates a bit map of the supported features, whi=
ch can
+be negotiated by setting the stream parameters:
+\begin{itemize}
+\item VIRTIO_SND_PCM_F_SHMEM_HOST - supports sharing a host memory with a =
guest,
+\item VIRTIO_SND_PCM_F_SHMEM_GUEST - supports sharing a guest memory with =
a host,
+\item VIRTIO_SND_PCM_F_MSG_POLLING - supports polling mode for message-bas=
ed
+transport,
+\item VIRTIO_SND_PCM_F_EVT_SHMEM_PERIODS - supports elapsed period notific=
ations
+for shared memory transport,
+\item VIRTIO_SND_PCM_F_EVT_XRUNS - supports underrun/overrun notifications=
.
+\end{itemize}
+\item[\field{flags}] indicates a bit map of the additional flags:
+\begin{itemize}
+\item VIRTIO_SND_PCM_FL_CHMAP - supports a channel map.
+\end{itemize}
+\item[\field{direction}] indicates the direction of data flow (VIRTIO_SND_=
D_XXX).
+\item[\field{channels_min}] indicates a minimum number of supported channe=
ls.
+\item[\field{channels_max}] indicates a maximum number of supported channe=
ls.
+\item[\field{formats}] indicates a supported sample format bit map.
+\item[\field{rates}] indicates a supported frame rate bit map.
+\item[\field{chmap}] if the VIRTIO_SND_PCM_FL_CHMAP flag is set, then the
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
e
+values.
+\item If the VIRTIO_SND_PCM_FL_CHMAP flag is not set, then the device MUST
+initialize the \field{chmap} field with the VIRTIO_SND_PCM_CH_NONE positio=
n
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
+    le32 features; /* 1 << VIRTIO_SND_PCM_F_XXX */
+    u8 channels;
+    u8 format;
+    u8 rate;
+
+    u8 padding;
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
+\item[\field{features}] specifies a selected feature bit map:
+\begin{itemize}
+\item VIRTIO_SND_PCM_F_SHMEM_HOST - use shared memory allocated by the hos=
t
+(is a placeholder and MUST NOT be selected at the moment),
+\item VIRTIO_SND_PCM_F_SHMEM_GUEST - use shared memory allocated by the gu=
est
+(is a placeholder and MUST NOT be selected at the moment),
+\item VIRTIO_SND_PCM_F_MSG_POLLING - suppress available buffer notificatio=
ns
+for tx and rx queues (device should poll virtqueue),
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
+\item The driver MUST NOT set undefined feature, format and rate values.
+\item The driver MUST NOT set the feature, format, and rate that are not s=
pecified
+in the stream configuration.
+\item The driver MUST NOT set the \field{channels} value as less than the =
\field{channels_min}
+or greater than the \field{channels_max} values specified in the stream co=
nfiguration.
+\item The driver MUST NOT set the VIRTIO_SND_PCM_F_SHMEM_HOST and VIRTIO_S=
ND_PCM_F_SHMEM_GUEST
+bits at the same time.
+\item The driver MUST initialize the \field{padding} byte to 0.
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
+\devicenormative{\subparagraph}{Stream Release}{Device Types / Sound Devic=
e / Device Operation / PCM Stream Release}
+
+\begin{itemize}
+\item The device MUST complete all pending I/O messages for the specified
+stream ID.
+\item The device MUST NOT complete the control request while there are pen=
ding
+I/O messages for the specified stream ID.
+\end{itemize}
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
+A used descriptor specifies the length of the buffer that was written by t=
he
+device. It should be noted that the length value contains the size of the
+virtio_snd_pcm_status structure plus the size of the recorded frames.
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
2.25.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

