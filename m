Return-Path: virtio-dev-return-5728-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9C1D4985DFA
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 May 2019 14:15:47 +0000 (UTC)
From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Date: Fri, 10 May 2019 14:15:00 +0000
Message-ID: <76D732A88286A1478FFA94B453B715C1EEA25DD4@MXS02.open-synergy.com>
References: <20190429134754.GI7587@stefanha-x1.localdomain>
 <4fcd7456-de22-7f6d-d5ef-939cd3d7cf95@13byte.com>
 <20190501170525.GB22391@stefanha-x1.localdomain>
 <c74aebe9-5db4-902f-ef0b-f0a786806acd@13byte.com>
 <20190503164501.GB8373@stefanha-x1.localdomain>
 <863e1be1-11cc-816b-896d-3954427e98f3@13byte.com>
 <20190506052715.vkdopunuauyhl22m@sirius.home.kraxel.org>
 <7ac2ae97-bcb7-22cc-272a-723e7209910c@13byte.com>
 <20190509122710.rfhfnhqez2u7inju@sirius.home.kraxel.org>
 <5d316321-2c48-342b-f2ce-359e3596dae0@opensynergy.com>,<20190510121656.3ab7w5xef6io764o@sirius.home.kraxel.org>
In-Reply-To: <20190510121656.3ab7w5xef6io764o@sirius.home.kraxel.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Gerd Hoffmann <kraxel@redhat.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Cc: Marco Martinelli - 13Byte srl <marco@13byte.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Stefan
 Hajnoczi <stefanha@redhat.com>, =?iso-8859-2?Q?K=F5v=E1g=F3_Zolt=E1n?= <dirty.ice.hu@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Gerd! My name is Anton and I'm the original author of this draft. Thanks=
 for comments!

>> Configuration space provides a maximum amount of available virtual queue=
s. The
>> nqueues value MUST be at least one.
>>
>> ```
>> struct virtio_snd_config
>> {
>>     le32 nqueues;
>> };
>> ```

> Including or excluding the control queue?

Including the control queue.


>> Each request begins with a 2-byte field that identifies a recipient func=
tion
>> followed by a 2-byte field that identifies a function-specific request t=
ype.
>>
>> Each response begins with a 4-byte field that contains a status code. Th=
e values
>> 0-31 are reserved for common status codes, a function can define functio=
n-specific
>> status codes starting from 32.

> I'd suggest to use a common scheme with a single le32 field for both
> requests and responses.
> ...
> (maybe just drop the single-element structs and use the enums directly).

IMO, both options are quite fine. We decided to choose separate namespaces =
because it's more flexible approach.


>> ### Device Configuration
>> ...
>> struct virtio_snd_generic_desc
>> {
>>     u8 length;
>>     u8 type;
>>     u16 padding;
>
> I'd make length and type u16 and drop the padding.

Well, it's a possible option. We just didn't want to waste additional space=
 here.


>> With the exception of the base function, all implemented functions MUST =
define
>> its own descriptor(s) format (either presented in this specification or
>> vendor-specific) and MUST includes these in configuration only if a part=
icular
>> function (or part of its functionality) is enabled in the device.
>
> I don't think it is a good idea to allow vendor-specific descriptors
> here.  It should all be in the virtio spec.  We might want reserve a
> sub-range of "type" for experimental/development purposes though.

Yeah, an ability to define some experimental extensions was one of the targ=
ets here (like adding sound controls, non-PCM streams, MIDI and so on). Als=
o, this spec targeted the widest possible range of cases. Like, some hardwa=
re has very tricky features which can not be (or just has no point to be) d=
efined in common specification. One example is to allow switching between s=
peaker and bluetooth output. Ususally you don't need it, but if you want to=
 provide such feature to the guest, it's better to implement this as a cust=
om extension.



>> ### Function Operation
>>
>> #### Get Device Configuration
>>
>> The driver sends the VIRTIO_SND_BASE_R_GET_CFG generic request, the devi=
ce
>> answers with a response containing device configuration.
>
> Which is a list of descriptors I assume?

You are right.


>> #### Suspend
>>
>> ...
>>
>> #### Resume
>>
>> ...
>>
>
> Why these two are needed?

I would say, that some virtualization platforms either do not notify your b=
ackend about guest suspend/resume or it's very tricky to distinguish such c=
onditions from other shutdown/initialization types. According to my practic=
e, it's always better to notify device side in explicit way, because the dr=
iver always know what is going now.

> Also restoring state as optional device feature doesn't look useful to
> me.

Well, restoring active playback or capturing is not impossible thing at all=
. From other side, maybe some device implementors might not want/need such =
functionality. So I'm not sure, what is better here.


>> - *Manual mode*: the driver assigns a dedicated virtual queue for a PCM =
substream
>> and use it to transmit data buffers to the device. The device writes/rea=
ds PCM
>> frames only upon receiving a buffer from the driver.
>
> That is how I expect a virtio-audio device work.

Yeah, I understand. But it's the very beginning of the road (see below).


>> - *Automatic mode*: the driver allocates and shares with the device a ps=
eudophysically
>> continuous memory area containing runtime control registers and data buf=
fer itself.
>
> What is "pseudophysically continuous memory"?

This memory is physically continuous from the driver's point of view.

> Why do you think this is needed?

When you implement an audio device, you usually start with what we call "ma=
nual mode". It works, but only for simple use cases. There're two major cha=
llenges here.

1) An application can use audio device in many different ways. It may fill =
the entire buffer with frames and let it draining. It may provides data in =
form of relatively big chunks. But usually you will face with so called "lo=
w latency" applications. These try to reduce result latency by providing sm=
all chunks of data. In extreme cases, the driver may receive requests conta=
ining only 5-10 frames. It means an amount of both system calls and request=
s to the device will grow. At some point this rate may become quite noticab=
le. But things may become even worse, if an application activates both stre=
ams (playback and capture) at the same time. For example, voice chat applic=
ations (trying to reduce latency as much as possible) may hang you VM becau=
se of huge amount of small requests on both PCM streams. Thus, no requests/=
traps/hypercalls to the device while a stream is running - no problems here=
.

2) Everybody wants to reduce a latency as much as possible. One of the most=
 logical way is to allow to mmap data buffer into the user space memory. (A=
ctually, in some cases you even have no choice here, like in case of the Wa=
veRT interface in Windows.) But memory mapped buffer means, that you either=
 have a very little or have not at all an idea what is going on with buffer=
 content. Even if you have information about when and where an application =
writes to or reads from the buffer (ALSA enforces an application to maintai=
n its appl_ptr value), you will have a lot of headache with tracking the re=
wind/forward cases. I can't say for everyone, but our experiments with usin=
g "manual mode" here all failed. From other side, the isochronous nature of=
 PCM stream and the nature of sound card itself suggest you right solution.=
 You don't need to care about what and how an application does with a buffe=
r. Since it's expected from the device to read/write data with constant rat=
e. Thus, you can do the same in your virtual audio device. And it works lik=
e a charm!

We wanted to be ready for every possible use case, that's why we combined s=
olutions for described issues into what we call "automatic mode". The funni=
est thing is, according to our tests, in automatic mode you can have stable=
 and clean playback/capturing even under the very high CPU pressure.


>> Regardless of the mode of operation, the device MAY require to specify a=
n
>> approximate data buffer update frequency. In such case, the driver MUST =
specify
>> an approximate update frequency (expressed in both microseconds and byte=
s units)
>> before starting a PCM substream.
>
> Why both microseconds and bytes?  Isn't that redundant?

Just to be sure that both ends have exactly the same ideas.


> /* a PCM function descriptor */
> struct virtio_snd_pcm_desc
> {
>     /* sizeof(struct virtio_snd_pcm_desc) */
>     u8 length;
>     /* VIRTIO_SND_DESC_PCM */
>     u8 type;
>     /* a PCM function ID (assigned by the device) */
>     u8 pcm_id;
>     /* # of PCM stream descriptors in the configuration (one per supporte=
d PCM stream type) */
>     u8 nstreams;
> };

> /* supported PCM sample formats */
> ...
>
> That looks a bit over-engineered to me.
>
> First, virtio uses little endian.  How about dropping all bigendian
> formats?
>
> Are 8-bit formats are still used in practice?

Actually, yeah. I saw quite recent chipsets with the U8 format support. Any=
way, is it a big issue? It costs zero to support additional formats, so why=
 not?


> What are VIRTIO_SND_PCM_FMT_{S,U}20_LE ?
>
> What are VIRTIO_SND_PCM_FMT_*_3BE ?
>
> Which of these formats are actually implemented in your prototype?

Some format's physical width is not multiple of 8. Such samples are kept in=
 "a storage" which width is multiple of 8 (like 20-bit samples are kept eit=
her in 24-bit or in 32-bit storage).

Both Linux (ALSA) and Windows (WaveXXX interfaces) just expect from you to =
report support of these formats. You don't need to do anything special in o=
rder to implemented them. So, yes, we can support them in the prototype.


>> /* supported PCM frame rates */
>> ...
>
> Same question: Do we actually need all those?  My impression is that
> these days 48000 is pretty much standard.  96000 + 192000 for higher
> quality.  44100 sometimes still because it happens to be the CD sample
> rate.  Maybe 32000/16000/8000 for low bandwidth codecs.
>
> But 5512, 11025 & friends?

Same answer: why not? :)


>> /* a PCM channel map definitions */
>>
>> /* All channels have fixed channel positions */
>> #define VIRTIO_SND_PCM_CHMAP_FIXED      0
>> /* All channels are swappable (e.g. {FL/FR/RL/RR} -> {RR/RL/FR/FL}) */
>> #define VIRTIO_SND_PCM_CHMAP_VARIABLE   1
>> /* Only pair-wise channels are swappable (e.g. {FL/FR/RL/RR} -> {RL/RR/F=
L/FR}) */
>> #define VIRTIO_SND_PCM_CHMAP_PAIRED     2
>
> What this is good for?  How would a driver ask the device to actually
> swap the channels?  And isn't it easier to have the device provide a
> complete list of possible channel maps and let the driver simply pick
> one?

Basically, we were inspired how ALSA handles these and reused the same appr=
oach here. How: a hardware can have internal router/mixer to allow flexible=
 configuration, there's nothing special. About how to provide a list of cha=
nnel maps - it's a matter of responsibilities. I would like to stick to har=
dware-like approach, when hardware just reports minimum amount of capabilit=
ies, and it's up to the driver what to do with it.


>> /* Standard channel position definition */
>> ...
>
> Wow.  What is the use case for all those channels?  cinema sound?

Virtual cinema sound!


>> #### Prepare
>> ...
>> #### Start
>> ...
>
> So I guess the way to start a stream is (a) prepare, (b) queue some
> buffers, (c) start.  Correct?

Yeap!



cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

--
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

www.opensynergy.com

Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>
COQOS Hypervisor certified by T=DCV S=DCD
                [COQOS Hypervisor certified by T=DCV S=DCD]

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

