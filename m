Return-Path: virtio-dev-return-5875-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 82AA9985D3F
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Jul 2019 10:45:39 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <b850e8e5-cd1e-1a5e-cc42-51bc5f205fbc@opensynergy.com>
Date: Tue, 23 Jul 2019 12:45:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH] Add virtio sound device specification
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

This patch proposes a virtio specification for virtio sound device supporting 
playback/capture PCM streams.


---
  content.tex      |   1 +
  virtio-sound.tex | 461 +++++++++++++++++++++++++++++++++++++++++++++++
  2 files changed, 462 insertions(+)
  create mode 100644 virtio-sound.tex

diff --git a/content.tex b/content.tex
index 8f0498e..5c2356a 100644
--- a/content.tex
+++ b/content.tex
@@ -5598,6 +5598,7 @@ \subsubsection{Legacy Interface: Framing 
Requirements}\label{sec:Device
  \input{virtio-input.tex}
  \input{virtio-crypto.tex}
  \input{virtio-vsock.tex}
+\input{virtio-sound.tex}

  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}

diff --git a/virtio-sound.tex b/virtio-sound.tex
new file mode 100644
index 0000000..3d78d18
--- /dev/null
+++ b/virtio-sound.tex
@@ -0,0 +1,461 @@
+\section{Sound Device}\label{sec:Device Types / Sound Device}
+
+The virtio sound card is an extendable virtual audio device. It provides its
+functionality in a form of functions that can be configured and managed in an
+independent way.
+
+\subsection{Device ID}\label{sec:Device Types / Sound Device / Device ID}
+
+25
+
+\subsection{Virtqueues}\label{sec:Device Types / Sound Device / Virtqueues}
+
+\begin{description}
+	\item[0] controlq
+	\item[1..N] function-specific virtqueues
+\end{description}
+
+\subsection{Feature bits}\label{sec:Device Types / Sound Device / Feature bits}
+
+There are currently no feature bits defined for this device.
+
+\subsection{Device configuration layout}\label{sec:Device Types / Sound 
Device / Device configuration layout}
+
+Configuration space provides a maximum amount of available virtqueues
+(including the control queue).
+
+\begin{lstlisting}
+struct virtio_snd_config {
+    le32 nqueues;
+};
+\end{lstlisting}
+
+\subsection{Device Initialization}\label{sec:Device Types / Sound Device / 
Device Initialization}
+
+\begin{enumerate}
+\item Initialize the base function.
+\item Initialize all functions enabled in the device configuration.
+\end{enumerate}
+
+\subsubsection{Device Initialization: Base function}
+
+\begin{enumerate}
+\item Initialize all available virtqueues.
+\item Retrieve a device configuration.
+\end{enumerate}
+
+A device configuration is represented with a set of descriptors having
+a fixed header using the following layout structure and definitions:
+
+\begin{lstlisting}
+enum {
+    /* the PCM function descriptor types */
+    VIRTIO_SND_DESC_PCM = 0,
+    VIRTIO_SND_DESC_PCM_STREAM
+};
+
+struct virtio_snd_desc {
+    u8 length;
+    u8 type;
+
+    u16 padding;
+};
+\end{lstlisting}
+
+The fixed header \field{struct virtio_snd_desc} in each
+descriptor includes the following fields:
+
+\begin{description}
+\item[\field{length}] specifies the total number of bytes in the descriptor.
+\item[\field{type}] identifies the descriptor type (VIRTIO_SND_DESC_*).
+\end{description}
+
+With the exception of the base function, all implemented functions MUST add
+their descriptors in configuration only if a particular function (or part of
+its functionality) is enabled in the device.
+
+\subsubsection{Device Initialization: PCM function}
+
+\begin{enumerate}
+\item Set one of available virtqueues as a PCM data queue.
+\end{enumerate}
+
+\subsection{Device Operation}\label{sec:Device Types / Sound Device / Device 
Operation}
+
+All control messages are placed into a single virtqueue with index zero.
+
+All requests and responses on the queue consist of or are preceded by
+a header using the following layout structure and definitions:
+
+\begin{lstlisting}
+enum {
+    /* the base function request types */
+    VIRTIO_SND_R_BASE_GET_CFG = 0,
+
+    /* the PCM function request types */
+    VIRTIO_SND_R_PCM_SET_QUEUE = 0x0100,
+    VIRTIO_SND_R_PCM_SET_FORMAT,
+    VIRTIO_SND_R_PCM_PREPARE,
+    VIRTIO_SND_R_PCM_START,
+    VIRTIO_SND_R_PCM_STOP,
+    VIRTIO_SND_R_PCM_PAUSE,
+    VIRTIO_SND_R_PCM_UNPAUSE,
+    VIRTIO_SND_R_PCM_QUERY_CHMAP,
+    VIRTIO_SND_R_PCM_USE_CHMAP,
+
+    /* response status codes */
+    VIRTIO_SND_S_OK = 0x8000,
+    VIRTIO_SND_S_ENOTSUPPORTED,
+    VIRTIO_SND_S_EINVALID,
+    VIRTIO_SND_S_EIO
+};
+
+struct virtio_snd_hdr {
+    le32 code;
+};
+\end{lstlisting}
+
+The generic header \field{struct virtio_snd_hdr} contains the only field:
+
+\begin{description}
+\item[\field{code}] specifies a type of the driver request
+(VIRTIO_SND_R_*) or a device response status code (VIRTIO_SND_S_*).
+\end{description}
+
+\subsubsection{Device Operation: Base function}
+
+The base function is responsible for operations having a scope of or that
+can affect the entire device.
+
+\begin{description}
+
+\item[VIRTIO_SND_R_BASE_GET_CFG]
+Retrieve the current device configuration, response is \field{struct 
virtio_snd_base_configuration}
+containing a set of function descriptors.
+
+\begin{lstlisting}
+/* a maximum possible configuration data size (in bytes) */
+#define VIRTIO_SND_BASE_CFG_MAX_SIZE    1024
+
+/* a response containing device configuration */
+struct virtio_snd_base_configuration {
+    struct virtio_snd_hdr hdr;
+    /* size in bytes of configuration data */
+    le32 length;
+    /* configuration data */
+    u8 data[VIRTIO_SND_BASE_CFG_MAX_SIZE];
+};
+\end{lstlisting}
+
+\end{description}
+
+\subsubsection{Device Operation: PCM function}
+
+The PCM function provides up to one playback and up to one capture PCM stream.
+If the device supports more than one PCM stream of the same type, it MUST
+provide them as separate PCM functions.
+
+The function puts a PCM function descriptor to a device configuration. The 
descriptor
+is followed by up to two PCM stream descriptors. The data is stored according to
+the following layout structure and definitions:
+
+\begin{lstlisting}
+/* supported PCM stream types */
+enum {
+    VIRTIO_SND_PCM_T_PLAYBACK = 0,
+    VIRTIO_SND_PCM_T_CAPTURE
+};
+
+/* supported PCM sample formats */
+enum {
+    VIRTIO_SND_PCM_FMT_S8 = 0,
+    VIRTIO_SND_PCM_FMT_U8,
+    VIRTIO_SND_PCM_FMT_S16,
+    VIRTIO_SND_PCM_FMT_U16,
+    VIRTIO_SND_PCM_FMT_S24,
+    VIRTIO_SND_PCM_FMT_U24,
+    VIRTIO_SND_PCM_FMT_S32,
+    VIRTIO_SND_PCM_FMT_U32,
+    VIRTIO_SND_PCM_FMT_FLOAT,
+    VIRTIO_SND_PCM_FMT_FLOAT64,
+    VIRTIO_SND_PCM_FMT_S20,
+    VIRTIO_SND_PCM_FMT_U20,
+    VIRTIO_SND_PCM_FMT_S24_3,
+    VIRTIO_SND_PCM_FMT_U24_3,
+    VIRTIO_SND_PCM_FMT_S20_3,
+    VIRTIO_SND_PCM_FMT_U20_3,
+    VIRTIO_SND_PCM_FMT_S18_3,
+    VIRTIO_SND_PCM_FMT_U18_3
+};
+
+/* supported PCM frame rates */
+enum {
+    VIRTIO_SND_PCM_RATE_8000 = 0,
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
+    VIRTIO_SND_PCM_RATE_192000
+};
+
+/* PCM function descriptor */
+struct virtio_snd_pcm_desc {
+    /* sizeof(struct virtio_snd_pcm_desc) */
+    u8 length;
+    /* VIRTIO_SND_DESC_PCM */
+    u8 type;
+    /* a PCM function ID (assigned by the device) */
+    u8 pcm_id;
+    /* # of PCM stream descriptors in the configuration (one per supported
+     * PCM stream type)
+     */
+    u8 nstreams;
+};
+
+/* PCM stream descriptor */
+struct virtio_snd_pcm_stream_desc {
+    /* sizeof(struct virtio_snd_pcm_stream_desc) */
+    u8 length;
+    /* VIRTIO_SND_DESC_PCM_STREAM */
+    u8 type;
+    /* a PCM stream type (VIRTIO_SND_PCM_T_*) */
+    u8 stream_type;
+    /* # of supported channel maps */
+    u8 nchmaps;
+    /* minimum # of supported channels */
+    le16 channels_min;
+    /* maximum # of supported channels */
+    le16 channels_max;
+    /* supported sample format bit mask (1 << VIRTIO_SND_PCM_FMT_*) */
+    le32 formats;
+    /* supported frame rate bit mask (1 << VIRTIO_SND_PCM_RATE_*) */
+    le32 rates;
+};
+\end{lstlisting}
+
+The function assumes the following command lifecycle:
+
+\begin{enumerate}
+\item Set format
+\item Prepare
+\item Playback: transfer data for prebuffing.
+\item Start
+\item Transfer data to/from the PCM device.
+\begin{enumerate}
+	\item Pause
+	\item Unpause
+\end{enumerate}
+\item Stop
+\end{enumerate}
+
+PCM control requests have or consist of a fixed header with the following
+layout structure:
+
+\begin{lstlisting}
+struct virtio_snd_pcm_hdr {
+    /* a PCM request type (VIRTIO_SND_R_PCM_*) */
+    struct virtio_snd_hdr hdr;
+    /* a PCM identifier (assigned in configuration) */
+    u8 pcm_id;
+    /* a PCM stream type (VIRTIO_SND_PCM_T_*) */
+    u8 stream_type;
+
+    u16 padding;
+};
+\end{lstlisting}
+
+\begin{description}
+
+\item[VIRTIO_SND_R_PCM_SET_QUEUE]
+Set selected virtqueue as a PCM data queue for a specified PCM function
+instance.
+
+\begin{lstlisting}
+struct virtio_snd_pcm_set_queue {
+    struct virtio_snd_hdr hdr;
+    /* a PCM identifier (assigned in configuration) */
+    u8 pcm_id;
+    /* a queue index */
+    u8 queue;
+
+    u16 padding;
+};
+\end{lstlisting}
+
+\item[VIRTIO_SND_R_PCM_SET_FORMAT]
+Set selected PCM format.
+
+\begin{lstlisting}
+struct virtio_snd_pcm_set_format {
+    struct virtio_snd_pcm_hdr hdr;
+    /* # of channels */
+    le16 channels;
+    /* a PCM sample format (VIRTIO_SND_PCM_FMT_*) */
+    le16 format;
+    /* a PCM frame rate (VIRTIO_SND_PCM_RATE_*) */
+    le16 rate;
+
+    u16 padding;
+};
+\end{lstlisting}
+
+\item[VIRTIO_SND_R_PCM_PREPARE]
+Prepare the PCM device.
+
+\item[VIRTIO_SND_R_PCM_START]
+Start the PCM device.
+
+\item[VIRTIO_SND_R_PCM_STOP]
+Stop the PCM device.
+
+\item[VIRTIO_SND_R_PCM_PAUSE]
+Set the PCM device on pause.
+
+\item[VIRTIO_SND_R_PCM_UNPAUSE]
+Unset the PCM device from pause.
+
+\item[VIRTIO_SND_R_PCM_QUERY_CHMAP]
+Query PCM channel map information.
+
+The function reports an amount of available channel maps in the PCM stream
+configuration descriptor. The driver can enumerate these using the following
+request and response layout structure and definitions:
+
+\begin{lstlisting}
+enum {
+    /* All channels have fixed channel positions */
+    VIRTIO_SND_PCM_CHMAP_FIXED = 0,
+    /* All channels are swappable (e.g. {FL/FR/RL/RR} -> {RR/RL/FR/FL}) */
+    VIRTIO_SND_PCM_CHMAP_VARIABLE,
+    /* Only pair-wise channels are swappable (e.g. {FL/FR/RL/RR} -> 
{RL/RR/FL/FR}) */
+    VIRTIO_SND_PCM_CHMAP_PAIRED
+};
+
+/* Standard channel position definitions */
+enum {
+    VIRTIO_SND_PCM_CH_NONE = 0, /* undefined */
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
+#define VIRTIO_SND_PCM_CH_MAX		   256
+
+struct virtio_snd_pcm_query_chmap {
+    struct virtio_snd_hdr hdr;
+    /* a PCM identifier (assigned in configuration) */
+    u8 pcm_id;
+    /* a PCM stream type (VIRTIO_SND_PCM_T_*) */
+    u8 stream_type;
+    /* a PCM channel map identifier [0 .. virtio_snd_pcm_stream_desc::nchmaps 
- 1] */
+    u8 chmap_id;
+
+    u8 padding;
+};
+
+/* a response containing PCM channel map information */
+struct virtio_snd_pcm_chmap_info {
+    /* a response status code (VIRTIO_SND_S_*) */
+    struct virtio_snd_hdr hdr;
+    /* unused */
+    u8 pcm_id;
+    /* a PCM channel map type (VIRTIO_SND_PCM_CHMAP_*) */
+    u8 type;
+    /* # of valid entries in the positions array */
+    le16 nchannels;
+    /* PCM channel positions */
+    u8 positions[VIRTIO_SND_PCM_CH_MAX];
+};
+\end{lstlisting}
+
+\item[VIRTIO_SND_R_PCM_USE_CHMAP]
+Use modified PCM channel map.
+
+In case of a channel map has swappable positions, the driver can set a modified
+channel map using the same \field{struct virtio_snd_pcm_chmap_info} structure as
+request.
+
+\begin{lstlisting}
+/* a request containing PCM channel map information */
+struct virtio_snd_pcm_chmap_info {
+    /* VIRTIO_SND_R_PCM_USE_CHMAP */
+    struct virtio_snd_hdr hdr;
+    /* a PCM identifier (assigned in configuration) */
+    u8 pcm_id;
+    /* a PCM stream type (VIRTIO_SND_PCM_T_*) */
+    u8 type;
+    /* # of valid entries in the positions array */
+    le16 nchannels;
+    /* PCM channel positions */
+    u8 positions[VIRTIO_SND_PCM_CH_MAX];
+};
+\end{lstlisting}
+
+\end{description}
+
+All IO requests and responses are placed into a single virtqueue
+assigned for PCM data transfers using the following layout structure:
+
+\begin{lstlisting}
+/* PCM stream data transfer */
+struct virtio_snd_pcm_xfer {
+	/* a guest physical start address of data buffer */
+	le64 address;
+	/* a size in bytes of data buffer */
+	le32 length;
+	/* a PCM stream type (VIRTIO_SND_PCM_T_*) */
+	u8 stream_type;
+
+	u8 padding[3];
+};
+
+/* PCM stream data transfer status */
+struct virtio_snd_pcm_status {
+    /* VIRTIO_SND_S_* */
+    le32 status;
+    /* an amount of bytes actually read from/written to data buffer */
+    le32 length;
+};
+\end{lstlisting}
+
+Request is \field{struct virtio_snd_pcm_xfer} and it supports only interleaved
+channels layout. Response is \field{struct virtio_snd_pcm_status}.
-- 
2.22.0



-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone: +49 30 60 98 54 0
E-Mail: anton.yakovlev@opensynergy.com

www.opensynergy.com

Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 108616B
Geschäftsführer/Managing Director: Regis Adjamah

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

