Return-Path: virtio-dev-return-5727-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 514F3985DFA
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 May 2019 12:17:02 +0000 (UTC)
Date: Fri, 10 May 2019 14:16:56 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190510121656.3ab7w5xef6io764o@sirius.home.kraxel.org>
References: <20190429134754.GI7587@stefanha-x1.localdomain>
 <4fcd7456-de22-7f6d-d5ef-939cd3d7cf95@13byte.com>
 <20190501170525.GB22391@stefanha-x1.localdomain>
 <c74aebe9-5db4-902f-ef0b-f0a786806acd@13byte.com>
 <20190503164501.GB8373@stefanha-x1.localdomain>
 <863e1be1-11cc-816b-896d-3954427e98f3@13byte.com>
 <20190506052715.vkdopunuauyhl22m@sirius.home.kraxel.org>
 <7ac2ae97-bcb7-22cc-272a-723e7209910c@13byte.com>
 <20190509122710.rfhfnhqez2u7inju@sirius.home.kraxel.org>
 <5d316321-2c48-342b-f2ce-359e3596dae0@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d316321-2c48-342b-f2ce-359e3596dae0@opensynergy.com>
Subject: Re: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Mikhail Golubev <mikhail.golubev@opensynergy.com>
Cc: Marco Martinelli - 13Byte srl <marco@13byte.com>, virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, May 10, 2019 at 11:45:24AM +0200, Mikhail Golubev wrote:
> Hi all!
> 
> Sorry for breaking in the middle of the virtio audio driver and device
> development discussion. But we are developing a virtio sound card prototype for
> a while and we would like to share our specification draft and public header
> file (attaching 'virtio_snd.h' and 'virtio-snd-spec-draft.md'). The PoC for
> proposed approach was tested with virtio audio driver in Linux and in Windows 10
> as well.
> 
> It would be really great if we can collaborate on this topic. I would be happy
> to answer any questions.

Wow.  That looks pretty complete already ...

> Configuration space provides a maximum amount of available virtual queues. The
> nqueues value MUST be at least one.
> 
> ```
> struct virtio_snd_config
> {
>     le32 nqueues;
> };
> ```

Including or excluding the control queue?

> Each request begins with a 2-byte field that identifies a recipient function
> followed by a 2-byte field that identifies a function-specific request type.
> 
> Each response begins with a 4-byte field that contains a status code. The values
> 0-31 are reserved for common status codes, a function can define function-specific
> status codes starting from 32.

I'd suggest to use a common scheme with a single le32 field for both
requests and responses.

#define VIRTIO_SND_BASE_OFFSET 0x10000
#define VIRTIO_SND_PCM_OFFSET  0x20000

enum virtio_sound_request {
	VIRTIO_SND_BASE_REQ1 = VIRTIO_SND_BASE_OFFSET,
        VIRTIO_SND_BASE_REQ2,
	[ ... ]
	VIRTIO_SND_PCM_REQ1 = VIRTIO_SND_PCM_OFFSET,
	VIRTIO_SND_PCM_REQ2,
	[ ... ]
};

enum virtio_sound_response {
	VIRTIO_SND_E_SUCCESS,

	VIRTIO_SND_E_GENERAL = VIRTIO_SND_BASE_OFFSET,
	VIRTIO_SND_E_NOTSUPPORTED,
	[ ... ]
	VIRTIO_SND_PCM_E_NOT_READY = VIRTIO_SND_PCM_OFFSET,
	[ ... ]
};

> struct virtio_snd_req
> {
	enum virtio_sound_request;

> struct virtio_snd_rsp
> {
	enum virtio_sound_response;

(maybe just drop the single-element structs and use the enums directly).

> ### Device Configuration
> 
> The device reports its configuration using descriptors. A descriptor is a data
> structure with a defined format. Each descriptor begins with a byte-wide field
> that contains the total number of bytes in the descriptor followed by a byte-wide
> field that identifies the descriptor type.
> 
> ```
> struct virtio_snd_generic_desc
> {
>     u8 length;
>     u8 type;
>     u16 padding;

I'd make length and type u16 and drop the padding.

> With the exception of the base function, all implemented functions MUST define
> its own descriptor(s) format (either presented in this specification or
> vendor-specific) and MUST includes these in configuration only if a particular
> function (or part of its functionality) is enabled in the device.

I don't think it is a good idea to allow vendor-specific descriptors
here.  It should all be in the virtio spec.  We might want reserve a
sub-range of "type" for experimental/development purposes though.

> ### Function Operation
> 
> #### Get Device Configuration
> 
> The driver sends the VIRTIO_SND_BASE_R_GET_CFG generic request, the device
> answers with a response containing device configuration.

Which is a list of descriptors I assume?

> #### Suspend
> 
> The driver sends the VIRTIO_SND_BASE_R_SUSPEND generic request, the device
> answers with a generic response. For each initialized function, the device SHOULD
> be able to preserve its runtime state and MUST put it into function-specific
> suspended state.
> 
> #### Resume
> 
> The driver sends the VIRTIO_SND_BASE_R_RESUME generic request, the device
> answers with a generic response. For each initialized function, the device SHOULD
> be able to restore its runtime state and MUST put it into function-specific
> non-suspended state.

Why these two are needed?

Also restoring state as optional device feature doesn't look useful to
me.

> - *Manual mode*: the driver assigns a dedicated virtual queue for a PCM substream
> and use it to transmit data buffers to the device. The device writes/reads PCM
> frames only upon receiving a buffer from the driver.

That is how I expect a virtio-audio device work.

> - *Automatic mode*: the driver allocates and shares with the device a pseudophysically
> continuous memory area containing runtime control registers and data buffer itself.

What is "pseudophysically continuous memory"?
Why do you think this is needed?

> Regardless of the mode of operation, the device MAY require to specify an
> approximate data buffer update frequency. In such case, the driver MUST specify
> an approximate update frequency (expressed in both microseconds and bytes units)
> before starting a PCM substream.

Why both microseconds and bytes?  Isn't that redundant?

> /* a PCM function descriptor */
> struct virtio_snd_pcm_desc
> {
>     /* sizeof(struct virtio_snd_pcm_desc) */
>     u8 length;
>     /* VIRTIO_SND_DESC_PCM */
>     u8 type;
>     /* a PCM function ID (assigned by the device) */
>     u8 pcm_id;
>     /* # of PCM stream descriptors in the configuration (one per supported PCM stream type) */
>     u8 nstreams;
> };

> /* supported PCM sample formats */
> #define VIRTIO_SND_PCM_FMT_MU_LAW       0
> #define VIRTIO_SND_PCM_FMT_A_LAW        1
> #define VIRTIO_SND_PCM_FMT_S8           2
> #define VIRTIO_SND_PCM_FMT_U8           3
> #define VIRTIO_SND_PCM_FMT_S16_LE       4
> #define VIRTIO_SND_PCM_FMT_S16_BE       5
> #define VIRTIO_SND_PCM_FMT_U16_LE       6
> #define VIRTIO_SND_PCM_FMT_U16_BE       7
> #define VIRTIO_SND_PCM_FMT_S24_LE       8
> #define VIRTIO_SND_PCM_FMT_S24_BE       9
> #define VIRTIO_SND_PCM_FMT_U24_LE       10
> #define VIRTIO_SND_PCM_FMT_U24_BE       11
> #define VIRTIO_SND_PCM_FMT_S32_LE       12
> #define VIRTIO_SND_PCM_FMT_S32_BE       13
> #define VIRTIO_SND_PCM_FMT_U32_LE       14
> #define VIRTIO_SND_PCM_FMT_U32_BE       15
> #define VIRTIO_SND_PCM_FMT_FLOAT_LE     16
> #define VIRTIO_SND_PCM_FMT_FLOAT_BE     17
> #define VIRTIO_SND_PCM_FMT_FLOAT64_LE   18
> #define VIRTIO_SND_PCM_FMT_FLOAT64_BE   19
> #define VIRTIO_SND_PCM_FMT_S20_LE       20
> #define VIRTIO_SND_PCM_FMT_S20_BE       21
> #define VIRTIO_SND_PCM_FMT_U20_LE       22
> #define VIRTIO_SND_PCM_FMT_U20_BE       23
> #define VIRTIO_SND_PCM_FMT_S24_3LE      24
> #define VIRTIO_SND_PCM_FMT_S24_3BE      25
> #define VIRTIO_SND_PCM_FMT_U24_3LE      26
> #define VIRTIO_SND_PCM_FMT_U24_3BE      27
> #define VIRTIO_SND_PCM_FMT_S20_3LE      28
> #define VIRTIO_SND_PCM_FMT_S20_3BE      29
> #define VIRTIO_SND_PCM_FMT_U20_3LE      30
> #define VIRTIO_SND_PCM_FMT_U20_3BE      31
> #define VIRTIO_SND_PCM_FMT_S18_3LE      32
> #define VIRTIO_SND_PCM_FMT_U18_3LE      33
> #define VIRTIO_SND_PCM_FMT_S18_3BE      34
> #define VIRTIO_SND_PCM_FMT_U18_3BE      35

That looks a bit over-engineered to me.

First, virtio uses little endian.  How about dropping all bigendian
formats?

Are 8-bit formats are still used in practice?

What are VIRTIO_SND_PCM_FMT_{S,U}20_LE ?

What are VIRTIO_SND_PCM_FMT_*_3BE ?

Which of these formats are actually implemented in your prototype?

> /* supported PCM frame rates */
> #define VIRTIO_SND_PCM_RATE_5512        0
> #define VIRTIO_SND_PCM_RATE_8000        1
> #define VIRTIO_SND_PCM_RATE_11025       2
> #define VIRTIO_SND_PCM_RATE_16000       3
> #define VIRTIO_SND_PCM_RATE_22050       4
> #define VIRTIO_SND_PCM_RATE_32000       5
> #define VIRTIO_SND_PCM_RATE_44100       6
> #define VIRTIO_SND_PCM_RATE_48000       7
> #define VIRTIO_SND_PCM_RATE_64000       8
> #define VIRTIO_SND_PCM_RATE_88200       9
> #define VIRTIO_SND_PCM_RATE_96000       10
> #define VIRTIO_SND_PCM_RATE_176400      11
> #define VIRTIO_SND_PCM_RATE_192000      12

Same question: Do we actually need all those?  My impression is that
these days 48000 is pretty much standard.  96000 + 192000 for higher
quality.  44100 sometimes still because it happens to be the CD sample
rate.  Maybe 32000/16000/8000 for low bandwidth codecs.

But 5512, 11025 & friends?

> The driver gets the VIRTIO_SND_PCM_FEAT_CHANNEL_MAP feature value in order to obtain
> a channel map with specified index, the device answers with the virtio_snd_pcm_chmap
> PCM response.
> 
> If channel map type allows to swap channels, the driver can set the VIRTIO_SND_PCM_FEAT_CHANNEL_MAP
> feature value specifying selected channel map data as a request argument. The
> device answers with a generic response.
> 
> ```
> /* a PCM channel map definitions */
> 
> /* All channels have fixed channel positions */
> #define VIRTIO_SND_PCM_CHMAP_FIXED      0
> /* All channels are swappable (e.g. {FL/FR/RL/RR} -> {RR/RL/FR/FL}) */
> #define VIRTIO_SND_PCM_CHMAP_VARIABLE   1
> /* Only pair-wise channels are swappable (e.g. {FL/FR/RL/RR} -> {RL/RR/FL/FR}) */
> #define VIRTIO_SND_PCM_CHMAP_PAIRED     2

What this is good for?  How would a driver ask the device to actually
swap the channels?  And isn't it easier to have the device provide a
complete list of possible channel maps and let the driver simply pick
one?

> /* Standard channel position definition */
> #define VIRTIO_SND_PCM_CH_NONE          0   /* undefined */
> #define VIRTIO_SND_PCM_CH_NA            1   /* silent */
> #define VIRTIO_SND_PCM_CH_MONO          2   /* mono stream */
> #define VIRTIO_SND_PCM_CH_FL            3   /* front left */
> #define VIRTIO_SND_PCM_CH_FR            4   /* front right */
> #define VIRTIO_SND_PCM_CH_RL            5   /* rear left */
> #define VIRTIO_SND_PCM_CH_RR            6   /* rear right */
> #define VIRTIO_SND_PCM_CH_FC            7   /* front center */
> #define VIRTIO_SND_PCM_CH_LFE           8   /* low frequency (LFE) */
> #define VIRTIO_SND_PCM_CH_SL            9   /* side left */
> #define VIRTIO_SND_PCM_CH_SR            10  /* side right */
> #define VIRTIO_SND_PCM_CH_RC            11  /* rear center */
> #define VIRTIO_SND_PCM_CH_FLC           12  /* front left center */
> #define VIRTIO_SND_PCM_CH_FRC           13  /* front right center */
> #define VIRTIO_SND_PCM_CH_RLC           14  /* rear left center */
> #define VIRTIO_SND_PCM_CH_RRC           15  /* rear right center */
> #define VIRTIO_SND_PCM_CH_FLW           16  /* front left wide */
> #define VIRTIO_SND_PCM_CH_FRW           17  /* front right wide */
> #define VIRTIO_SND_PCM_CH_FLH           18  /* front left high */
> #define VIRTIO_SND_PCM_CH_FCH           19  /* front center high */
> #define VIRTIO_SND_PCM_CH_FRH           20  /* front right high */
> #define VIRTIO_SND_PCM_CH_TC            21  /* top center */
> #define VIRTIO_SND_PCM_CH_TFL           22  /* top front left */
> #define VIRTIO_SND_PCM_CH_TFR           23  /* top front right */
> #define VIRTIO_SND_PCM_CH_TFC           24  /* top front center */
> #define VIRTIO_SND_PCM_CH_TRL           25  /* top rear left */
> #define VIRTIO_SND_PCM_CH_TRR           26  /* top rear right */
> #define VIRTIO_SND_PCM_CH_TRC           27  /* top rear center */
> #define VIRTIO_SND_PCM_CH_TFLC          28  /* top front left center */
> #define VIRTIO_SND_PCM_CH_TFRC          29  /* top front right center */
> #define VIRTIO_SND_PCM_CH_TSL           30  /* top side left */
> #define VIRTIO_SND_PCM_CH_TSR           31  /* top side right */
> #define VIRTIO_SND_PCM_CH_LLFE          32  /* left LFE */
> #define VIRTIO_SND_PCM_CH_RLFE          33  /* right LFE */
> #define VIRTIO_SND_PCM_CH_BC            34  /* bottom center */
> #define VIRTIO_SND_PCM_CH_BLC           35  /* bottom left center */
> #define VIRTIO_SND_PCM_CH_BRC           36  /* bottom right center */

Wow.  What is the use case for all those channels?  cinema sound?

> #### Prepare
> 
> The driver MUST send the VIRTIO_SND_PCM_R_PREPARE generic PCM request to prepare
> a substream for running, the device answers with a generic response.
> 
> #### Start
> 
> The driver sends the VIRTIO_SND_PCM_R_START generic PCM request, the device
> answers with a generic response.

So I guess the way to start a stream is (a) prepare, (b) queue some
buffers, (c) start.  Correct?

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

