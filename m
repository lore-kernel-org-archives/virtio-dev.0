Return-Path: virtio-dev-return-6268-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C563B985D19
	for <virtio-dev@lists.oasis-open.org>; Tue, 29 Oct 2019 09:42:25 +0000 (UTC)
References: <20190924144323.4590-1-Mikhail.Golubev@opensynergy.com>
 <6a4978e85505ae00ca9e2b170f5e893a064c03d2.camel@linux.intel.com>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <568f32dc-8d82-a189-469f-5cb3a0140b8c@opensynergy.com>
Date: Tue, 29 Oct 2019 10:42:19 +0100
MIME-Version: 1.0
In-Reply-To: <6a4978e85505ae00ca9e2b170f5e893a064c03d2.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Liam,

Thank you for comments! Please, take a look at our answers below.


On 28.10.2019 17:05, Liam Girdwood wrote:
> On Tue, 2019-09-24 at 15:43 +0100, Mikhail Golubev wrote:
>> From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
>>
>> This patch proposes virtio specification for new virtio sound device.
>>
>> The virtio sound card is a virtual audio device supporting output and
>> input PCM streams.
>>
> 
> Apologies for the delay in response, I've just been made aware of this
> spec proposal on this list. I've also added Mark and Takashi.
> 
> Just to make you aware I'm working on a spec for DSP virtualisation,
> where the DSP can do more than just simple audio uses cases. I intend
> to support this spec as a fallback for guests who request non DSP audio
> functionality, hence my interest :)
> 
> This spec looks in the right direction for virtualising non DSP audio
> devices (where we have HW for DMAC, I2S/HDA and a codec IC). There are
> a few opens that I've detailed below.

Originally, this spec was supposed to be extendable. Since PCM is the simplest 
and most demandable feature, we decided to start only with this one.


>> Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
>> Signed-off-by: Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
>> ---
>> Fixes from RFC:
>>   * Use fixed virtqueue numbers for the control and PCM queues
>>   * Use device feature bits to indicate available input/output PCM
>> streams
>>   * Place PCM stream configuration into the device configuration space
>>   * Add sound device and driver requirements into the "Device
>> Initialization"
>>    subsection
>>   * Add sound device and driver requirements into the "Device
>> Operation" subsection
>>   * Add sound device and driver conformance subsections
>>
>> RFC link:
>> https://lists.oasis-open.org/archives/virtio-dev/201908/msg00078.html
>>
>>   conformance.tex  |  20 +++
>>   content.tex      |   1 +
>>   virtio-sound.tex | 405
>> +++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 426 insertions(+)
>>   create mode 100644 virtio-sound.tex
>>
>> diff --git a/conformance.tex b/conformance.tex
>> index 0ac58aa..31595bf 100644
>> --- a/conformance.tex
>> +++ b/conformance.tex
>> @@ -183,6 +183,16 @@ \section{Conformance
>> Targets}\label{sec:Conformance / Conformance Targets}
>>   \item \ref{drivernormative:Device Types / Socket Device / Device
>> Operation / Device Events}
>>   \end{itemize}
>>
>> +\conformance{\subsection}{Sound Driver
>> Conformance}\label{sec:Conformance / Driver Conformance / Sound
>> Driver Conformance}
>> +
>> +A sound driver MUST conform to the following normative statements:
>> +
>> +\begin{itemize}
>> +\item \ref{drivernormative:Device Types / Sound Device / Device
>> Initialization}
>> +\item \ref{drivernormative:Device Types / Sound Device / PCM control
>> requests}
>> +\item \ref{drivernormative:Device Types / Sound Device / PCM IO
>> requests}
>> +\end{itemize}
>> +
>>   \conformance{\section}{Device Conformance}\label{sec:Conformance /
>> Device Conformance}
>>
>>   A device MUST conform to the following normative statements:
>> @@ -338,6 +348,16 @@ \section{Conformance
>> Targets}\label{sec:Conformance / Conformance Targets}
>>   \item \ref{devicenormative:Device Types / Socket Device / Device
>> Operation / Receive and Transmit}
>>   \end{itemize}
>>
>> +\conformance{\subsection}{Sound Device
>> Conformance}\label{sec:Conformance / Device Conformance / Sound
>> Device Conformance}
>> +
>> +A sound device MUST conform to the following normative statements:
>> +
>> +\begin{itemize}
>> +\item \ref{devicenormative:Device Types / Sound Device / Device
>> Initialization}
>> +\item \ref{devicenormative:Device Types / Sound Device / PCM control
>> requests}
>> +\item \ref{devicenormative:Device Types / Sound Device / PCM IO
>> requests}
>> +\end{itemize}
>> +
>>   \conformance{\section}{Legacy Interface: Transitional Device and
>> Transitional Driver Conformance}\label{sec:Conformance / Legacy
>> Interface: Transitional Device and Transitional Driver Conformance}
>>   A conformant implementation MUST be either transitional or
>>   non-transitional, see \ref{intro:Legacy
>> diff --git a/content.tex b/content.tex
>> index 37a2190..4a00884 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -5682,6 +5682,7 @@ \subsubsection{Legacy Interface: Framing
>> Requirements}\label{sec:Device
>>   \input{virtio-input.tex}
>>   \input{virtio-crypto.tex}
>>   \input{virtio-vsock.tex}
>> +\input{virtio-sound.tex}
>>
>>   \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>
>> diff --git a/virtio-sound.tex b/virtio-sound.tex
>> new file mode 100644
>> index 0000000..68a606e
>> --- /dev/null
>> +++ b/virtio-sound.tex
>> @@ -0,0 +1,405 @@
>> +\section{Sound Device}\label{sec:Device Types / Sound Device}
>> +
>> +The virtio sound card is a virtual audio device supporting output
>> and input PCM
>> +streams. All device control requests are placed into the control
>> virtqueue, all
>> +I/O requests are placed into the PCM virtqueue.
> 
> Where are stream position updates placed ? These are usually
> synchronous from the driver and enable the player application to render
> or read data from the correct locations in the buffers. This is latency
> sensitive data.

It happens in an interrupt handler. Since PCM frame transfer is message based, 
the only possible way to figure out consumed or captured amount of frames is 
to take a look into a message response.


>> +
>> +\subsection{Device ID}\label{sec:Device Types / Sound Device /
>> Device ID}
>> +
>> +25
>> +
>> +\subsection{Virtqueues}\label{sec:Device Types / Sound Device /
>> Virtqueues}
>> +
>> +\begin{description}
>> +\item[0] controlq
>> +\item[1] pcmq
>> +\end{description}
>> +
>> +The controlq virtqueue always exists, the pcmq virtqueue only exists
>> if
>> +the VIRTIO_SND_F_PCM_OUTPUT and/or VIRTIO_SND_F_PCM_INPUT feature is
>> negotiated.
>> +
>> +\subsection{Feature bits}\label{sec:Device Types / Sound Device /
>> Feature bits}
>> +
>> +\begin{description}
>> +\item[VIRTIO_SND_F_PCM_OUTPUT (0)] Output PCM stream support.
>> +\item[VIRTIO_SND_F_PCM_INPUT (1)] Input PCM stream support.
>> +\end{description}
>> +
>> +\subsection{Device configuration layout}\label{sec:Device Types /
>> Sound Device / Device configuration layout}
>> +
>> +\begin{lstlisting}
>> +/* supported PCM sample formats */
>> +enum {
>> +    VIRTIO_SND_PCM_FMT_S8 = 0,
>> +    VIRTIO_SND_PCM_FMT_U8,
>> +    VIRTIO_SND_PCM_FMT_S16,
>> +    VIRTIO_SND_PCM_FMT_U16,
>> +    VIRTIO_SND_PCM_FMT_S32,
>> +    VIRTIO_SND_PCM_FMT_U32,
>> +    VIRTIO_SND_PCM_FMT_FLOAT,
>> +    VIRTIO_SND_PCM_FMT_FLOAT64
>> +};
>> +
>> +/* supported PCM frame rates */
>> +enum {
>> +    VIRTIO_SND_PCM_RATE_8000 = 0,
>> +    VIRTIO_SND_PCM_RATE_11025,
>> +    VIRTIO_SND_PCM_RATE_16000,
>> +    VIRTIO_SND_PCM_RATE_22050,
>> +    VIRTIO_SND_PCM_RATE_32000,
>> +    VIRTIO_SND_PCM_RATE_44100,
>> +    VIRTIO_SND_PCM_RATE_48000,
>> +    VIRTIO_SND_PCM_RATE_64000,
>> +    VIRTIO_SND_PCM_RATE_88200,
>> +    VIRTIO_SND_PCM_RATE_96000,
>> +    VIRTIO_SND_PCM_RATE_176400,
>> +    VIRTIO_SND_PCM_RATE_192000
> 
> It may be best to use the same rates and format from the ALSA spec,
> this covers any holes (like rates that are not in the above list).

These rates are from ALSA definitions. And what formats should be added?


>> +};
>> +
>> +/* a PCM stream configuration */
>> +struct virtio_pcm_stream_config {
>> +    u8 channels_min;
>> +    u8 channels_max;
>> +    le16 formats; /* 1 << VIRTIO_SND_PCM_FMT_XXX */
>> +    le16 rates; /* 1 << VIRTIO_SND_PCM_RATE_XXX */
>> +    u16 padding;
>> +};
> 
> Should this be packed ? Btw, padding alignment is to a non 32bit size ?

It should be naturally packed if padding is correct. And do you mean 8 and 
16-bit fields? You can read one or two bytes from device configuration space, 
it should not be a problem.


> What about buffer/period formats e.g interleaved ?

Yeah, support only for interleaved layout previously was stated in the 
specification but occasionally was lost. Will be fixed!


> 
>> +
>> +/* a device configuration space */
>> +struct virtio_snd_config {
>> +    struct virtio_pcm_config {
>> +        struct virtio_pcm_stream_config output;
>> +        struct virtio_pcm_stream_config input;
>> +    } pcm;
>> +};
>> +\end{lstlisting}
> 
> I assuming this is sent to configure PCM capabilities ?

Yes, minimum amount of information required to setup a PCM stream in any kind 
of guest.


> What about buffer and period size capabilities ?

In this specification we assume that buffer size is up to guest decision. 
Also, period size is ALSA-only conception and should not be mentioned here at 
all (we are not stick only to ALSA).


>> +
>> +\subsubsection{Device configuration fields}
>> +
>> +The \field{pcm.output} and \field{pcm.input} fields contain PCM
>> stream
>> +configuration:
>> +
>> +\begin{description}
>> +\item[\field{channels_min}] (driver-read-only) is a minimum number
>> of supported
>> +channels.
>> +\item[\field{channels_max}] (driver-read-only) is a maximum number
>> of supported
>> +channels.
>> +\item[\field{formats}] (driver-read-only) is supported sample format
>> bit map.
>> +\item[\field{rates}] (driver-read-only) is supported frame rate bit
>> map.
>> +\end{description}
>> +
>> +\subsection{Device Initialization}
>> +
>> +\begin{enumerate}
>> +\item If the VIRTIO_SND_F_PCM_OUTPUT feature is negotiated,
>> \field{pcm.output}
>> +contains valid output PCM stream configuration.
>> +\item If the VIRTIO_SND_F_PCM_INPUT feature is negotiated,
>> \field{pcm.input}
>> +contains valid input PCM stream configuration.
>> +\end{enumerate}
>> +
>> +\devicenormative{\subsubsection}{Device Initialization}{Device Types
>> / Sound Device / Device Initialization}
>> +
>> +\begin{enumerate}
>> +\item The device MUST NOT set the not defined format and rate bits.
>> +\item The device MUST initialize padding bytes
>> \field{pcm.output.padding} and
>> +\field{pcm.input.padding} to 0.
>> +\end{enumerate}
>> +
>> +\drivernormative{\subsubsection}{Device Initialization}{Device Types
>> / Sound Device / Device Initialization}
>> +
>> +\begin{enumerate}
>> +\item The driver MUST configure and initialize all virtqueues.
>> +\item The driver SHOULD ignore the not defined format and rate bits.
>> +\end{enumerate}
>> +
>> +\subsection{Device Operation}\label{sec:Device Types / Sound Device
>> / Device Operation}
>> +
>> +All control messages are placed into the controlq virtqueue and use
>> the following
>> +layout structure and definitions:
>> +
>> +\begin{lstlisting}
>> +enum {
>> +    /* PCM control request types */
>> +    VIRTIO_SND_R_PCM_CHMAP_INFO = 0,
>> +    VIRTIO_SND_R_PCM_SET_FORMAT,
>> +    VIRTIO_SND_R_PCM_PREPARE,
>> +    VIRTIO_SND_R_PCM_START,
>> +    VIRTIO_SND_R_PCM_STOP,
>> +    VIRTIO_SND_R_PCM_PAUSE,
>> +    VIRTIO_SND_R_PCM_UNPAUSE,
>> +
>> +    /* generic status codes */
>> +    VIRTIO_SND_S_OK = 0x8000,
>> +    VIRTIO_SND_S_BAD_MSG,
>> +    VIRTIO_SND_S_NOT_SUPP,
>> +    VIRTIO_SND_S_IO_ERR
>> +};
>> +
>> +struct virtio_snd_ctl_msg {
>> +    /* device-read-only data */
>> +    le32 request_code;
>> +    u8 request_payload[];
> 
> How do I know how much data to read here ? Is size embedded in
> request_code ?

Yes, you are right. Actual request/response length can be easily derived from 
a request_code.


> 
>> +    /* device-writable data */
>> +    le32 response_status;
>> +    u8 response_payload[];
>> +};
>> +\end{lstlisting}
>> +
>> +A generic control message consists of request and response parts and
>> contains
>> +the following fields:
>> +
>> +\begin{description}
>> +\item[\field{request_code}] (device-read-only) specifies a device
>> request code
>> +(VIRTIO_SND_R_*).
>> +\item[\field{request_payload}] (device-read-only) contains request-
>> specific
>> +data.
>> +\item[\field{response_status}] (device-writable) specifies a device
>> response
>> +status (VIRTIO_SND_S_*).
>> +\item[\field{response_payload}] (device-writable) contains response-
>> specific
>> +data.
>> +\end{description}
>> +
>> +Unless stated otherwise, the \field{request_payload} and
>> \field{response_payload}
>> +fields are empty.
>> +
>> +The \field{response_status} field contains one of the following
>> values:
>> +
>> +\begin{itemize*}
>> +\item VIRTIO_SND_S_OK: success.
>> +\item VIRTIO_SND_S_BAD_MSG: a control message is malformed or
>> contains invalid
>> +parameters.
>> +\item VIRTIO_SND_S_NOT_SUPP: requested operation or parameters are
>> not supported.
>> +\item VIRTIO_SND_S_IO_ERR: an I/O error occurred.
>> +\end{itemize*}
>> +
>> +\subsubsection{Device Operation: PCM control requests}
>> +
>> +A PCM stream has the following command lifecycle:
>> +
>> +\begin{enumerate}
>> +\item Set format
>> +\item Prepare
>> +\item Output only: transfer data for prebuffing
>> +\item Start
>> +\item Transfer data to/from the PCM device
>> +\begin{enumerate}
>> +       \item Pause
>> +       \item Unpause
>> +\end{enumerate}
>> +\item Stop
>> +\end{enumerate}
>> +
>> +PCM control requests have or consist of a fixed header with the
>> following
>> +layout structure:
>> +
>> +\begin{lstlisting}
>> +/* supported PCM stream types */
>> +enum {
>> +    VIRTIO_SND_PCM_T_OUTPUT = 0,
>> +    VIRTIO_SND_PCM_T_INPUT
> 
> Can we rename these PLAYBACK and CAPTURE

Playback and capture are used in ALSA drivers, sink and source are used in 
Windows drivers. We decided to stick to something obvious in-between (and it's 
just shorter). Although, it's still discussable topic.


>> +};
>> +
>> +/* PCM control request header */
>> +struct virtio_snd_pcm_hdr {
>> +    le32 code;
>> +    le32 stream;
>> +};
>> +\end{lstlisting}
>> +
>> +PCM control request fields:
>> +
>> +\begin{description}
>> +\item[\field{code}] (device-read-only) specifies a PCM device
>> request code
>> +(VIRTIO_SND_R_PCM_*).
>> +\item[\field{stream}] (device-read-only) specifies a PCM stream type
>> +(VIRTIO_SND_PCM_T_*).
>> +\end{description}
>> +
>> +\begin{description}
>> +
>> +\item[VIRTIO_SND_R_PCM_CHMAP_INFO]
>> +Query a PCM channel map information for specified stream type.
>> +
>> +A response uses the following layout structure and definitions:
>> +
>> +\begin{lstlisting}
>> +/* standard channel position definition */
>> +enum {
>> +    VIRTIO_SND_PCM_CH_NONE = 0, /* undefined */
>> +    VIRTIO_SND_PCM_CH_NA,       /* silent */
>> +    VIRTIO_SND_PCM_CH_MONO,     /* mono stream */
>> +    VIRTIO_SND_PCM_CH_FL,       /* front left */
>> +    VIRTIO_SND_PCM_CH_FR,       /* front right */
>> +    VIRTIO_SND_PCM_CH_RL,       /* rear left */
>> +    VIRTIO_SND_PCM_CH_RR,       /* rear right */
>> +    VIRTIO_SND_PCM_CH_FC,       /* front center */
>> +    VIRTIO_SND_PCM_CH_LFE,      /* low frequency (LFE) */
>> +    VIRTIO_SND_PCM_CH_SL,       /* side left */
>> +    VIRTIO_SND_PCM_CH_SR,       /* side right */
>> +    VIRTIO_SND_PCM_CH_RC,       /* rear center */
>> +    VIRTIO_SND_PCM_CH_FLC,      /* front left center */
>> +    VIRTIO_SND_PCM_CH_FRC,      /* front right center */
>> +    VIRTIO_SND_PCM_CH_RLC,      /* rear left center */
>> +    VIRTIO_SND_PCM_CH_RRC,      /* rear right center */
>> +    VIRTIO_SND_PCM_CH_FLW,      /* front left wide */
>> +    VIRTIO_SND_PCM_CH_FRW,      /* front right wide */
>> +    VIRTIO_SND_PCM_CH_FLH,      /* front left high */
>> +    VIRTIO_SND_PCM_CH_FCH,      /* front center high */
>> +    VIRTIO_SND_PCM_CH_FRH,      /* front right high */
>> +    VIRTIO_SND_PCM_CH_TC,       /* top center */
>> +    VIRTIO_SND_PCM_CH_TFL,      /* top front left */
>> +    VIRTIO_SND_PCM_CH_TFR,      /* top front right */
>> +    VIRTIO_SND_PCM_CH_TFC,      /* top front center */
>> +    VIRTIO_SND_PCM_CH_TRL,      /* top rear left */
>> +    VIRTIO_SND_PCM_CH_TRR,      /* top rear right */
>> +    VIRTIO_SND_PCM_CH_TRC,      /* top rear center */
>> +    VIRTIO_SND_PCM_CH_TFLC,     /* top front left center */
>> +    VIRTIO_SND_PCM_CH_TFRC,     /* top front right center */
>> +    VIRTIO_SND_PCM_CH_TSL,      /* top side left */
>> +    VIRTIO_SND_PCM_CH_TSR,      /* top side right */
>> +    VIRTIO_SND_PCM_CH_LLFE,     /* left LFE */
>> +    VIRTIO_SND_PCM_CH_RLFE,     /* right LFE */
>> +    VIRTIO_SND_PCM_CH_BC,       /* bottom center */
>> +    VIRTIO_SND_PCM_CH_BLC,      /* bottom left center */
>> +    VIRTIO_SND_PCM_CH_BRC       /* bottom right center */
>> +};
>> +
>> +/* a maximum possible number of channels */
>> +#define VIRTIO_SND_PCM_CH_MAX          256
>> +
>> +/* response containing a PCM channel map information */
>> +struct virtio_snd_pcm_chmap_info {
>> +    le32 status;
>> +    le32 npositions;
>> +    u8 positions[VIRTIO_SND_PCM_CH_MAX];
>> +};
>> +\end{lstlisting}
>> +
>> +PCM channel map information fields:
>> +
>> +\begin{description}
>> +\item[\field{status}] (device-writable) specifies a device response
>> status
>> +(VIRTIO_SND_S_*).
>> +\item[\field{npositions}] (device-writable) is a number of valid
>> entries in
>> +the \field{positions} array.
>> +\item[\field{positions}] (device-writable) contains PCM channel
>> positions
>> +(VIRTIO_SND_PCM_CH_*).
>> +\end{description}
>> +
>> +\item[VIRTIO_SND_R_PCM_SET_FORMAT]
>> +Set selected PCM format.
>> +
>> +\begin{lstlisting}
>> +struct virtio_snd_pcm_set_format {
>> +    struct virtio_snd_pcm_hdr hdr;
>> +    le16 channels;
>> +    le16 format;
>> +    le16 rate;
>> +    u16 padding;
>> +};
>> +\end{lstlisting}
>> +
>> +PCM control request fields:
>> +
>> +\begin{description}
>> +\item[\field{hdr}] (device-read-only) is a PCM control request
>> header.
>> +\item[\field{channels}] (device-read-only) specifies a desired
>> number of channels.
>> +\item[\field{format}] (device-read-only) specifies a desired PCM
>> sample format
>> +(VIRTIO_SND_PCM_FMT_*).
>> +\item[\field{rate}] (device-read-only) specifies a desired PCM frame
>> rate
>> +(VIRTIO_SND_PCM_RATE_*).
>> +\end{description}
>> +
>> +\item[VIRTIO_SND_R_PCM_PREPARE]
>> +Prepare the PCM device.
>> +
>> +\item[VIRTIO_SND_R_PCM_START]
>> +Start the PCM device.
>> +
>> +\item[VIRTIO_SND_R_PCM_STOP]
>> +Stop the PCM device.
>> +
>> +\item[VIRTIO_SND_R_PCM_PAUSE]
>> +Set the PCM device on pause.
>> +
>> +\item[VIRTIO_SND_R_PCM_UNPAUSE]
>> +Unset the PCM device from pause.
>> +
>> +\end{description}
>> +
>> +\devicenormative{\subsubsection}{PCM control requests}{Device Types
>> / Sound Device / PCM control requests}
>> +
>> +In a VIRTIO_SND_R_PCM_CHMAP_INFO request:
>> +
>> +\begin{itemize*}
>> +\item the device MUST return the VIRTIO_SND_S_NOT_SUPP status code,
>> if it does not
>> +support a channel map for a specified stream type;
>> +\item the device MUST set the \field{npositions} field to 0, if the
>> operation
>> +failed.
>> +\end{itemize*}
>> +
>> +\drivernormative{\subsubsection}{PCM control requests}{Device Types
>> / Sound Device / PCM control requests}
>> +
>> +The driver MUST NOT specify VIRTIO_SND_PCM_T_OUTPUT as a stream type
>> if
>> +the VIRTIO_SND_F_PCM_OUTPUT feature is not negotiated.
>> +
>> +The driver MUST NOT specify VIRTIO_SND_PCM_T_INPUT as a stream type
>> if
>> +the VIRTIO_SND_F_PCM_INPUT feature is not negotiated.
>> +
>> +In a VIRTIO_SND_R_PCM_SET_FORMAT request:
>> +
>> +\begin{itemize*}
>> +\item the driver MUST NOT specify the \field{channels} value less
>> than the \field{channels_min}
>> +or greater than the \field{channels_max} values reported in stream
>> configuration;
>> +\item the driver MUST specify the \field{format} and \field{rate}
>> values according
>> +to the \field{formats} and \field{rates} values reported in stream
>> configuration;
>> +\item the driver MUST NOT specify the not defined format and rate
>> values;
>> +\item the driver MUST initialize \field{padding} bytes to 0.
>> +\end{itemize*}
>> +
>> +\subsubsection{Device Operation: PCM I/O requests}
>> +
>> +All I/O requests are placed into the pcmq virtqueue. Each request is
>> of form:
>> +
>> +\begin{lstlisting}
>> +struct virtio_snd_pcm_xfer {
>> +    le32 stream;
>> +    u8 data[];
>> +    le32 status;
>> +    le32 actual_length;
> 
> Not following this, is actual_length the size of data[]. If so, it must
> preceed data[].

No, the actual_length field is supposed to be used by device side to report
actual amount of bytes read from/written to a buffer. In real world scenario, 
if an I/O request contains N bytes, a device can play/capture *up to* N bytes. 
Thus, it's required to report this length back to a driver.


> 
>> +};
>> +\end{lstlisting}
>> +
>> +I/O request fields:
>> +
>> +\begin{description}
>> +\item[\field{stream}] (device-read-only) specifies a PCM stream type
>> +(VIRTIO_SND_PCM_T_*).
>> +\item[\field{data}]
>> +\begin{enumerate}
>> +\item Output: (device-read-only) a buffer with PCM frames to be
>> written to the
>> +device.
>> +\item Input: (device-writable) a buffer to be filled with PCM frames
>> from the
>> +device.
>> +\end{enumerate}
>> +\item[\field{status}] (device-writable) contains VIRTIO_SND_S_OK if
>> an operation
>> +is successful, and VIRTIO_SND_S_IO_ERR otherwise.
>> +\item[\field{actual_length}] (device-writable) specifies an actual
>> amount of
>> +bytes read from/written to the \field{data} field.
>> +\end{description}
>> +
>> +\devicenormative{\subsubsection}{PCM I/O requests}{Device Types /
>> Sound Device / PCM IO requests}
>> +
>> +\begin{enumerate}
>> +\item The device MUST set the \field{actual_length} field to 0, if
>> the operation
>> +failed.
>> +\end{enumerate}
>> +
>> +\drivernormative{\subsubsection}{PCM I/O requests}{Device Types /
>> Sound Device / PCM IO requests}
>> +
>> +\begin{enumerate}
>> +\item The driver MUST NOT specify VIRTIO_SND_PCM_T_OUTPUT as a
>> stream type if
>> +the VIRTIO_SND_F_PCM_OUTPUT feature is not negotiated.
>> +\item The driver MUST NOT specify VIRTIO_SND_PCM_T_INPUT as a stream
>> type if
>> +the VIRTIO_SND_F_PCM_INPUT feature is not negotiated.
>> +\end{enumerate}
>> --
>> 2.23.0
>>
> 
> I don't see anything in here about dealing with
> 
> 1) Underruns and overruns. i.e. how do we recover and resync audio
> between guests.

Since xrun conditions are higher level conceptions, we decided to delegate 
such issues to guest application itself. It helps to make overall design 
simpler. And it seems there's not so much we can do if xrun condition is 
happened on the device side.


> 2) Zero copy of audio data and stream positions. Essential for any low
> latency audio use cases (if supported by HW, hypervisor, VM framework).

What do you mean by zero-copy? Shared memory between device and driver sides?


> I would strongly recommend reading the ALSA driver developers guide if
> you can or looking at the ALSA headers for PCMs and controls (I guess
> you have looked a little based on the channel map).

Yes, we did it. :)


> 
> Thanks
> 
> Liam
> 
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
> 

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

