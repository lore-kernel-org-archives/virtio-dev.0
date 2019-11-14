Return-Path: virtio-dev-return-6334-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8C7BA985F82
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Nov 2019 14:45:38 +0000 (UTC)
References: <20191105150606.18194-1-Mikhail.Golubev@opensynergy.com>
 <20191112132025.GB4187507@lophozonia>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <778905a7-f41b-d44b-f590-15945096e535@opensynergy.com>
Date: Thu, 14 Nov 2019 15:45:32 +0100
MIME-Version: 1.0
In-Reply-To: <20191112132025.GB4187507@lophozonia>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v2] snd: Add virtio sound device
 specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Jean,

Thank you for comments and sorry for delayed reply.


On 12.11.2019 14:20, Jean-Philippe Brucker wrote:
> Hi Mikhail,
>=20
> On Tue, Nov 05, 2019 at 04:06:06PM +0100, Mikhail Golubev wrote:
>> From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
>>
>> Hi everyone,
>>
>> the patch proposes an updated version of virtio specification for a new
>> virtio sound device. The initial PATCH can be found here: [1]. The
>> device may be useful in case when having audio is required but a device
>> passthrough or emulation is not an option.
>>
>> The virtio sound card supports output and input PCM streams. It reports
>> stream capabilities through device configuration space and utilizes two
>> virtqueues: one for control requests and one for I/O requests.
>=20
> Did you send out the implementation prototypes as well?  It might help
> understand how the device works.

Yes, we have both a device and a driver prototypes. We didn't send them yet=
=20
because there's no stable protocol at the moment. If you are interested, yo=
u=20
can take a look into our repositories at github:

QEmu device:
https://github.com/OpenSynergy/qemu/tree/virtio-snd-draft

Linux kernel driver:
https://github.com/OpenSynergy/linux/tree/virtio-snd-draft

At the moment they are both outdated (since we reworked part of the spec), =
but=20
we will update it in a few days.


> [...]
>> +\subsection{Virtqueues}\label{sec:Device Types / Sound Device / Virtque=
ues}
>> +
>> +\begin{description}
>> +\item[0] controlq
>> +\item[1] pcmq
>> +\end{description}
>> +
>> +The controlq virtqueue always exists, the pcmq virtqueue only exists if
>> +the VIRTIO_SND_F_PCM_OUTPUT and/or VIRTIO_SND_F_PCM_INPUT feature is ne=
gotiated.
>=20
> Why not use two queues, one for input and one for output?  I think most
> virtio devices do it that way. It could simplify the implementations,
> shave 32 bits off the buffers, and allow to quiesce notifications for
> input and output streams independently. And in the future you can extend
> the device with more than two streams.

This was discussed earlier (having two separate virtqueues vs multiplexing=
=20
into single one). It's hard to say what is better, but at least one virtque=
ue=20
=3D less maintenance work at runtime.


>> +
>> +\subsection{Feature bits}\label{sec:Device Types / Sound Device / Featu=
re bits}
>> +
>> +\begin{description}
>> +\item[VIRTIO_SND_F_PCM_OUTPUT (0)] Output PCM stream support.
>> +\item[VIRTIO_SND_F_PCM_INPUT (1)] Input PCM stream support.
>> +\end{description}
>> +
>> +\subsection{Device configuration layout}\label{sec:Device Types / Sound=
 Device / Device configuration layout}
>> +
>> +\begin{lstlisting}
>> +/* supported PCM sample formats */
>> +enum {
>> +    VIRTIO_SND_PCM_FMT_S8 =3D 0,
>> +    VIRTIO_SND_PCM_FMT_U8,
>> +    VIRTIO_SND_PCM_FMT_S16,
>> +    VIRTIO_SND_PCM_FMT_U16,
>> +    VIRTIO_SND_PCM_FMT_S32,
>> +    VIRTIO_SND_PCM_FMT_U32,
>> +    VIRTIO_SND_PCM_FMT_FLOAT,
>> +    VIRTIO_SND_PCM_FMT_FLOAT64
>> +};
>=20
> Is it worth adding a word or two about the encoding used, in particular
> that this is linear quantization?  Or maybe it's standard enough, I don't
> know much about audio.

Yes, these are pretty common in audio.


>> +
>> +/* supported PCM frame rates */
>> +enum {
>> +    VIRTIO_SND_PCM_RATE_5512 =3D 0,
>> +    VIRTIO_SND_PCM_RATE_8000,
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
>> +    VIRTIO_SND_PCM_RATE_192000,
>> +    VIRTIO_SND_PCM_RATE_384000
>> +};
>> +
>> +/* a PCM stream configuration */
>> +struct virtio_pcm_stream_config {
>> +    u8 channels_min;
>> +    u8 channels_max;
>> +    le16 formats; /* 1 << VIRTIO_SND_PCM_FMT_XXX */
>> +    le16 rates; /* 1 << VIRTIO_SND_PCM_RATE_XXX */
>> +    u16 padding;
>=20
> You could add a lot more padding, because the current layout doesn't allo=
w
> to extend virtio_pcm_stream_config much (an old driver will expect the
> pcm.input field to start at offset 0x8 of the config space).

Well, device configuration space in general is not very suitable place for =
any=20
multimedia configuration, because such configuration may become quite compl=
ex=20
with time. In earlier versions we proposed more flexible way for discovery=
=20
things with special control request. But it didn't align well with other=20
existing virtio devices.


>> +};
>> +
>> +/* a device configuration space */
>> +struct virtio_snd_config {
>> +    struct virtio_pcm_config {
>> +        struct virtio_pcm_stream_config output;
>> +        struct virtio_pcm_stream_config input;
>> +    } pcm;
>> +};
>> +\end{lstlisting}
>> +
>> +\subsubsection{Device configuration fields}
>> +
>> +The \field{pcm.output} and \field{pcm.input} fields contain PCM stream
>> +configuration:
>> +
>> +\begin{description}
>> +\item[\field{channels_min}] (driver-read-only) is a minimum number of s=
upported
>> +channels.
>> +\item[\field{channels_max}] (driver-read-only) is a maximum number of s=
upported
>> +channels.
>> +\item[\field{formats}] (driver-read-only) is a supported sample format =
bit map.
>> +\item[\field{rates}] (driver-read-only) is a supported frame rate bit m=
ap.
>> +\end{description}
>> +
>> +Only interleaved samples are supported.
>=20
> Similar noob remark: I guess this is standard in audio hardware and
> doesn't need more explanation?  If the term is alsa-specific then we'd
> need a few words about what the format looks like.

Yes, this is a standard thing in audio.


>> +
>> +\subsection{Device Initialization}
>> +
>> +\begin{enumerate}
>> +\item If the VIRTIO_SND_F_PCM_OUTPUT feature is negotiated, \field{pcm.=
output}
>> +contains the valid output PCM stream configuration.
>> +\item If the VIRTIO_SND_F_PCM_INPUT feature is negotiated, \field{pcm.i=
nput}
>> +contains the valid input PCM stream configuration.
>> +\end{enumerate}
>> +
>> +\devicenormative{\subsubsection}{Device Initialization}{Device Types / =
Sound Device / Device Initialization}
>> +
>> +\begin{enumerate}
>> +\item The device MUST NOT set the not defined format and rate bits.
>=20
> s/not defined/undefined/ (here and elsewhere)

Thanks!


>> +\item The device MUST initialize padding bytes \field{pcm.output.paddin=
g} and
>> +\field{pcm.input.padding} to 0.
>> +\end{enumerate}
>> +
>> +\drivernormative{\subsubsection}{Device Initialization}{Device Types / =
Sound Device / Device Initialization}
>> +
>> +\begin{enumerate}
>> +\item The driver MUST configure and initialize all virtqueues.
>> +\item The driver SHOULD ignore the not defined format and rate bits.
>> +\end{enumerate}
>> +
>> +\subsection{Device Operation}\label{sec:Device Types / Sound Device / D=
evice Operation}
>> +
>> +All control messages are placed into the controlq virtqueue and use the=
 following
>> +layout structure and definitions:
>> +
>> +\begin{lstlisting}
>> +enum {
>> +    /* PCM control request types */
>> +    VIRTIO_SND_R_PCM_CHMAP_INFO =3D 0,
>> +    VIRTIO_SND_R_PCM_SET_FORMAT,
>> +    VIRTIO_SND_R_PCM_PREPARE,
>> +    VIRTIO_SND_R_PCM_START,
>> +    VIRTIO_SND_R_PCM_STOP,
>> +    VIRTIO_SND_R_PCM_PAUSE,
>> +    VIRTIO_SND_R_PCM_UNPAUSE,
>> +
>> +    /* generic status codes */
>> +    VIRTIO_SND_S_OK =3D 0x8000,
>> +    VIRTIO_SND_S_BAD_MSG,
>> +    VIRTIO_SND_S_NOT_SUPP,
>> +    VIRTIO_SND_S_IO_ERR
>> +};
>=20
> Any reason not to use two separate enums starting from 0?

It's funny, because initially there were exactly two separate enums. It was=
=20
proposed to combine them into one to keep things in one place.


>> +
>> +struct virtio_snd_ctl_msg {
>> +    /* device-read-only data */
>> +    le32 request_code;
>> +    u8 request_payload[];
>> +    /* device-writable data */
>> +    le32 response_status;
>> +    u8 response_payload[];
>> +};
>> +\end{lstlisting}
>> +
>> +A generic control message consists of a request part and a response par=
t, and
>> +contains the following fields:
>> +
>> +\begin{description}
>> +\item[\field{request_code}] (device-read-only) specifies a device reque=
st code
>> +(VIRTIO_SND_R_*).
>> +\item[\field{request_payload}] (device-read-only) contains request-spec=
ific
>> +data.
>> +\item[\field{response_status}] (device-writable) specifies a device res=
ponse
>> +status (VIRTIO_SND_S_*).
>> +\item[\field{response_payload}] (device-writable) contains response-spe=
cific
>> +data.
>> +\end{description}
>> +
>> +Unless stated otherwise, the \field{request_payload} and \field{respons=
e_payload}
>> +fields are empty.
>> +
>> +The \field{response_status} field contains one of the following values:
>> +
>> +\begin{itemize*}
>=20
> Nit: other devices use the "description" environment for statuses. (By th=
e
> way, what does the asterisk after itemize do?)

Good question! Have no idea. :)


>> +\item VIRTIO_SND_S_OK: success.
>> +\item VIRTIO_SND_S_BAD_MSG: a control message is malformed or contains =
invalid
>> +parameters.
>> +\item VIRTIO_SND_S_NOT_SUPP: requested operation or parameters are not =
supported.
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
>> +=09\item Pause
>> +=09\item Unpause
>> +\end{enumerate}
>> +\item Stop
>=20
> Which commands are allowed after Stop, just Set format or can we send
> Start directly?

Set format or prepare.

Maybe it's better to define a state machine here. There's no example in the=
=20
virtio spec, and we decided to put a simple list instead.


>> +\end{enumerate}
>> +
>> +PCM control requests have or consist of a fixed header with the followi=
ng
>> +layout structure:
>> +
>> +\begin{lstlisting}
>> +/* supported PCM stream types */
>> +enum {
>> +    VIRTIO_SND_PCM_T_OUTPUT =3D 0,
>> +    VIRTIO_SND_PCM_T_INPUT
>> +};
>> +
>> +/* a PCM control request header */
>> +struct virtio_snd_pcm_hdr {
>> +    le32 code;
>> +    le32 stream;
>> +};
>> +\end{lstlisting}
>> +
>> +PCM control requests contain the following fields:
>> +
>> +\begin{description}
>> +\item[\field{code}] (device-read-only) specifies a PCM device request c=
ode
>> +(VIRTIO_SND_R_PCM_*).
>> +\item[\field{stream}] (device-read-only) specifies a PCM stream type
>> +(VIRTIO_SND_PCM_T_*).
>> +\end{description}
>> +
>> +\begin{description}
>> +
>> +\item[VIRTIO_SND_R_PCM_CHMAP_INFO]
>=20
> Nit: there is a lot of content in some control requests, it might look
> nicer if they each have their own \paragraph{} instead of being
> description items.

Yeah, good point.


>> +Query a PCM channel map information for specified stream type.
>> +
>> +A response uses the following layout structure and definitions:
>> +
>> +\begin{lstlisting}
>> +/* standard channel position definition */
>> +enum {
>> +    VIRTIO_SND_PCM_CH_NONE =3D 0, /* undefined */
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
>> +#define VIRTIO_SND_PCM_CH_MAX=09=09256
>> +
>> +/* a response containing a PCM channel map information */
>> +struct virtio_snd_pcm_chmap_info {
>=20
> Including the header would be more consistent with set_format below.

You are right.


>> +    le32 status;
>> +    le32 npositions;
>> +    u8 positions[VIRTIO_SND_PCM_CH_MAX];
>> +};
>> +\end{lstlisting}
>> +
>> +The PCM channel map information fields are:
>> +
>> +\begin{description}
>> +\item[\field{status}] (device-writable) specifies a device response sta=
tus
>> +(VIRTIO_SND_S_*).
>> +\item[\field{npositions}] (device-writable) is a number of valid entrie=
s in
>> +the \field{positions} array.
>> +\item[\field{positions}] (device-writable) contains PCM channel positio=
ns
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
>> +The PCM control request fields are:
>> +
>> +\begin{description}
>> +\item[\field{hdr}] (device-read-only) is a PCM control request header.
>> +\item[\field{channels}] (device-read-only) specifies a desired number o=
f channels.
>> +\item[\field{format}] (device-read-only) specifies a desired PCM sample=
 format
>> +(VIRTIO_SND_PCM_FMT_*).
>> +\item[\field{rate}] (device-read-only) specifies a desired PCM frame ra=
te
>> +(VIRTIO_SND_PCM_RATE_*).
>> +\end{description}
>> +
>> +\item[VIRTIO_SND_R_PCM_PREPARE]
>> +Prepare the PCM device.
>=20
> Isn't that for one stream rather than the whole device?  Otherwise, what
> should the hdr.stream field contain?

These requests are excactly for one stream. And a header must specify for=
=20
which one. We will rework this part to make things clearer.


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
>=20
> Or "Resume the paused PCM device"?

Thanks, will be fixed.


>> +
>> +\end{description}
>> +
>> +\devicenormative{\subsubsection}{PCM control requests}{Device Types / S=
ound Device / PCM control requests}
>> +
>> +In a VIRTIO_SND_R_PCM_CHMAP_INFO request:
>> +
>> +\begin{itemize*}
>> +\item if the device does not support a channel map for a specified stre=
am type,
>> +then it MUST return the VIRTIO_SND_S_NOT_SUPP status code;
>> +\item if the operation failed, then the device MUST set the \field{npos=
itions}
>> +field to 0.
>> +\end{itemize*}
>> +
>> +\drivernormative{\subsubsection}{PCM control requests}{Device Types / S=
ound Device / PCM control requests}
>> +
>> +If the VIRTIO_SND_F_PCM_OUTPUT feature is not negotiated, then the driv=
er MUST NOT
>> +specify VIRTIO_SND_PCM_T_OUTPUT as a stream type
>> +
>> +If the VIRTIO_SND_F_PCM_INPUT feature is not negotiated, then the drive=
r MUST NOT
>> +specify VIRTIO_SND_PCM_T_INPUT as a stream type.
>> +
>> +In a VIRTIO_SND_R_PCM_SET_FORMAT request:
>> +
>> +\begin{itemize*}
>> +\item the driver MUST NOT specify the \field{channels} value as less th=
an the \field{channels_min}
>> +or greater than the \field{channels_max} values reported in the stream =
configuration;
>> +\item the driver MUST specify the \field{format} and \field{rate} value=
s according
>> +to the \field{formats} and \field{rates} values reported in the stream =
configuration;
>> +\item the driver MUST NOT specify the not defined format and rate value=
s;
>> +\item the driver MUST initialize the \field{padding} field to 0.
>> +\end{itemize*}
>=20
> I guess configuration requests for a stream that isn't in "Set format"
> state are illegal?  Probably needs to be stated here.

Yes, some requests are illegal at some points of time. As I mentioned earli=
er,=20
maybe it's better to define a kind of state machine. Otherwise, there shoul=
d=20
be a lot of such small requirements.


> Thanks,
> Jean
>=20

--=20
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone: +49 30 60 98 54 0
E-Mail: anton.yakovlev@opensynergy.com

www.opensynergy.com

Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 108616=
B
Gesch=C3=A4ftsf=C3=BChrer/Managing Director: Regis Adjamah

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

