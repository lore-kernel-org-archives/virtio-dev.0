Return-Path: virtio-dev-return-5723-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 57676985DFA
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 May 2019 09:45:50 +0000 (UTC)
References: <abe4bd97-8010-8fd0-8ded-f9e847a4fdb3@13byte.com>
 <20190429134754.GI7587@stefanha-x1.localdomain>
 <4fcd7456-de22-7f6d-d5ef-939cd3d7cf95@13byte.com>
 <20190501170525.GB22391@stefanha-x1.localdomain>
 <c74aebe9-5db4-902f-ef0b-f0a786806acd@13byte.com>
 <20190503164501.GB8373@stefanha-x1.localdomain>
 <863e1be1-11cc-816b-896d-3954427e98f3@13byte.com>
 <20190506052715.vkdopunuauyhl22m@sirius.home.kraxel.org>
 <7ac2ae97-bcb7-22cc-272a-723e7209910c@13byte.com>
 <20190509122710.rfhfnhqez2u7inju@sirius.home.kraxel.org>
From: Mikhail Golubev <mikhail.golubev@opensynergy.com>
Message-ID: <5d316321-2c48-342b-f2ce-359e3596dae0@opensynergy.com>
Date: Fri, 10 May 2019 11:45:24 +0200
MIME-Version: 1.0
In-Reply-To: <20190509122710.rfhfnhqez2u7inju@sirius.home.kraxel.org>
Content-Type: multipart/mixed;
	boundary="------------27E016126600CA6DDCC71654"
Content-Language: en-US
Subject: Re: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Gerd Hoffmann <kraxel@redhat.com>, Marco Martinelli - 13Byte srl <marco@13byte.com>
Cc: virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--------------27E016126600CA6DDCC71654
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi all!

Sorry for breaking in the middle of the virtio audio driver and device
development discussion. But we are developing a virtio sound card prototype=
 for
a while and we would like to share our specification draft and public heade=
r
file (attaching 'virtio_snd.h' and 'virtio-snd-spec-draft.md'). The PoC for
proposed approach was tested with virtio audio driver in Linux and in Windo=
ws 10
as well.

It would be really great if we can collaborate on this topic. I would be ha=
ppy
to answer any questions.


--
Mikhail Golubev
Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Telefon: +49 (30) 60 98 54 0 - 903
Fax:     +49 (30) 60 98 54 0 - 99
EMail:   mikhail.golubev@opensynergy.com

www.opensynergy.com

Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 108616=
B
Gesch=C3=A4ftsf=C3=BChrer/Managing Director: Stefaan Sonck Thiebaut

Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>
COQOS Hypervisor certified by T=C3=9CV S=C3=9CD
                [COQOS Hypervisor certified by T=C3=9CV S=C3=9CD]

--------------27E016126600CA6DDCC71654
Content-Type: text/markdown; name="virtio-snd-spec-draft.md"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="virtio-snd-spec-draft.md"

# VirtIO sound card draft specification

The VirtIO sound card is an extendible virtual audio device. It provides its
functionality in a form of device functions that can be configured and managed
in an independent way.

## Device ID

TBD

## Virtqueues

0
> controlq

##  Feature Bits

None currently defined

## Device Configuration Layout

Configuration space provides a maximum amount of available virtual queues. The
nqueues value MUST be at least one.

```
struct virtio_snd_config
{
    le32 nqueues;
};
```

## Device Initialization

The driver SHOULD perform the following initialization sequence:

1. Initialize all available virtual queues.
2. Read a device configuration.
3. For every available function perform function-specific initialization.

## Device Operation

All control messages are placed into a single virtual queue with index zero.

A control message consumes two virtual queue descriptors: one containing a
read-only request and one containing a writable response.

Each request begins with a 2-byte field that identifies a recipient function
followed by a 2-byte field that identifies a function-specific request type.

Each response begins with a 4-byte field that contains a status code. The values
0-31 are reserved for common status codes, a function can define function-specific
status codes starting from 32.

```
struct virtio_snd_req
{
    le16 function;
    le16 request;
};

/* no errors */
#define VIRTIO_SND_E_SUCCESS        0
/* an undefined error */
#define VIRTIO_SND_E_GENERAL        1
/* not supported input parameter(s) */
#define VIRTIO_SND_E_NOTSUPPORTED   2
/* invalid input parameter(s) */
#define VIRTIO_SND_E_INVALID        3
/* I/O error */
#define VIRTIO_SND_E_IO             4

struct virtio_snd_rsp
{
    le32 status; /* VIRTIO_SND_E_XXX */
};
```

If a request consists only of a generic header, it's referred as a *generic request*.

If a response consists only of a generic header, it's referred as a *generic response*.

### Device Configuration

The device reports its configuration using descriptors. A descriptor is a data
structure with a defined format. Each descriptor begins with a byte-wide field
that contains the total number of bytes in the descriptor followed by a byte-wide
field that identifies the descriptor type.

```
struct virtio_snd_generic_desc
{
    u8 length;
    u8 type;
    u16 padding;
};
```

With the exception of the base function, all implemented functions MUST define
its own descriptor(s) format (either presented in this specification or
vendor-specific) and MUST includes these in configuration only if a particular
function (or part of its functionality) is enabled in the device.

## Device Operation: Base Function

A function identifier zero is reserved for base messages that can affect the entire
device. The device MUST support all base requests and responses defined in this
specification.

```
#define VIRTIO_SND_FN_BASE              0

/* --- BASE REQUEST TYPES --- */
#define VIRTIO_SND_BASE_R_GET_CFG       0
#define VIRTIO_SND_BASE_R_SUSPEND       1
#define VIRTIO_SND_BASE_R_RESUME        2
```

### Function Operation

#### Get Device Configuration

The driver sends the VIRTIO_SND_BASE_R_GET_CFG generic request, the device
answers with a response containing device configuration. The driver MUST examine
response content, initialize all presented and supported device functions and
ignore all unsupported ones.

```
#define VIRTIO_SND_BASE_CFG_MAX_SIZE    1024

/* a response containing device configuration */
struct virtio_snd_base_configuration
{
    struct virtio_snd_rsp hdr;
    /* size in bytes of configuration data */
    le32 length;
    /* configuration data */
    u8 data[VIRTIO_SND_BASE_CFG_MAX_SIZE];
};
```

#### Suspend

The driver sends the VIRTIO_SND_BASE_R_SUSPEND generic request, the device
answers with a generic response. For each initialized function, the device SHOULD
be able to preserve its runtime state and MUST put it into function-specific
suspended state.

#### Resume

The driver sends the VIRTIO_SND_BASE_R_RESUME generic request, the device
answers with a generic response. For each initialized function, the device SHOULD
be able to restore its runtime state and MUST put it into function-specific
non-suspended state.

## Device Operation: PCM Function

The PCM function provides up to one playback and up to one capture PCM streams.
If the device supports more than one PCM streams of the same type, it MUST provide
them as separate PCM functions. A PCM stream contains one or more PCM substreams
sharing the same capabilities reported in configuration, and all further function
manipulations are happened on per dedicated substream basis.

The function supports only the interleaved channels and MUST support at least one
of the following operational modes:

- *Manual mode*: the driver assigns a dedicated virtual queue for a PCM substream
and use it to transmit data buffers to the device. The device writes/reads PCM
frames only upon receiving a buffer from the driver.
- *Automatic mode*: the driver allocates and shares with the device a pseudophysically
continuous memory area containing runtime control registers and data buffer itself.
In case of the playback stream, the device reads constant amount of PCM frames
with constant time intervals without any requests from the driver. In case of
the capture stream, the device writes constant amount of PCM frames with constant
time intervals without any notifications to the driver.

Regardless of the mode of operation, the device MAY require to specify an
approximate data buffer update frequency. In such case, the driver MUST specify
an approximate update frequency (expressed in both microseconds and bytes units)
before starting a PCM substream.

The function also MAY provide an ability to get and set supported channel maps.

The device reports mentioned functional features using the features field in a
PCM stream configuration descriptor.

A PCM request consists of or is preceded by a header:

```
#define VIRTIO_SND_FN_PCM               1

/* --- PCM REQUEST TYPES --- */
#define VIRTIO_SND_PCM_R_GET_FEATURE    0
#define VIRTIO_SND_PCM_R_SET_FEATURE    1
#define VIRTIO_SND_PCM_R_SET_FORMAT     2
#define VIRTIO_SND_PCM_R_PREPARE        3
#define VIRTIO_SND_PCM_R_START          4
#define VIRTIO_SND_PCM_R_STOP           5
#define VIRTIO_SND_PCM_R_PAUSE          6
#define VIRTIO_SND_PCM_R_UNPAUSE        7
#define VIRTIO_SND_PCM_R_REWIND         8
#define VIRTIO_SND_PCM_R_FORWARD        9

/* a PCM substream request header */
struct virtio_snd_pcm_hdr
{
    /* VIRTIO_SND_FN_PCM */
    le16 function;
    /* a PCM request type (VIRTIO_SND_PCM_R_XXX) */
    le16 request;
    /* a PCM identifier (assigned in configuration) */
    u8 pcm_id;
    /* a PCM stream type (VIRTIO_SND_PCM_T_XXX) */
    u8 stream_type;
    /* a PCM substream identifier */
    u8 substream_id;
    u8 padding;
};
```

If a PCM request consists only of a generic PCM header, it's referred to as a
*generic PCM request*.

A PCM response consists of or is preceded by a generic response header. It
contains one of the generic or PCM-specific error codes:

```
/* --- PCM ERROR CODES --- */

/* a PCM substream is not ready */
#define VIRTIO_SND_PCM_E_NOT_READY      32
```

### Function Configuration

The function puts into device configuration a PCM function descriptor followed
by up to two PCM stream descriptors.

```
#define VIRTIO_SND_DESC_PCM             0
#define VIRTIO_SND_DESC_PCM_STREAM      1

/* a PCM function descriptor */
struct virtio_snd_pcm_desc
{
    /* sizeof(struct virtio_snd_pcm_desc) */
    u8 length;
    /* VIRTIO_SND_DESC_PCM */
    u8 type;
    /* a PCM function ID (assigned by the device) */
    u8 pcm_id;
    /* # of PCM stream descriptors in the configuration (one per supported PCM stream type) */
    u8 nstreams;
};

/* supported PCM stream types */
#define VIRTIO_SND_PCM_T_PLAYBACK       0
#define VIRTIO_SND_PCM_T_CAPTURE        1

/* supported PCM stream features */
#define VIRTIO_SND_PCM_FEAT_COMMAND_MODE 0
#define VIRTIO_SND_PCM_FEAT_POLLING_MODE 1
#define VIRTIO_SND_PCM_FEAT_UPDATE_FREQUENCY 2
#define VIRTIO_SND_PCM_FEAT_CHANNEL_MAP 3

#define VIRTIO_SND_PCM_FEATBIT(bit)     (1U << VIRTIO_SND_PCM_FEAT_ ## bit)

#define VIRTIO_SND_PCM_FEATBIT_COMMAND_MODE \
    VIRTIO_SND_PCM_FEATBIT(COMMAND_MODE)
#define VIRTIO_SND_PCM_FEATBIT_POLLING_MODE \
    VIRTIO_SND_PCM_FEATBIT(POLLING_MODE)
#define VIRTIO_SND_PCM_FEATBIT_UPDATE_FREQUENCY \
    VIRTIO_SND_PCM_FEATBIT(UPDATE_FREQUENCY)
#define VIRTIO_SND_PCM_FEATBIT_CHANNEL_MAP \
    VIRTIO_SND_PCM_FEATBIT(CHANNEL_MAP)

/* supported PCM sample formats */
#define VIRTIO_SND_PCM_FMT_MU_LAW       0
#define VIRTIO_SND_PCM_FMT_A_LAW        1
#define VIRTIO_SND_PCM_FMT_S8           2
#define VIRTIO_SND_PCM_FMT_U8           3
#define VIRTIO_SND_PCM_FMT_S16_LE       4
#define VIRTIO_SND_PCM_FMT_S16_BE       5
#define VIRTIO_SND_PCM_FMT_U16_LE       6
#define VIRTIO_SND_PCM_FMT_U16_BE       7
#define VIRTIO_SND_PCM_FMT_S24_LE       8
#define VIRTIO_SND_PCM_FMT_S24_BE       9
#define VIRTIO_SND_PCM_FMT_U24_LE       10
#define VIRTIO_SND_PCM_FMT_U24_BE       11
#define VIRTIO_SND_PCM_FMT_S32_LE       12
#define VIRTIO_SND_PCM_FMT_S32_BE       13
#define VIRTIO_SND_PCM_FMT_U32_LE       14
#define VIRTIO_SND_PCM_FMT_U32_BE       15
#define VIRTIO_SND_PCM_FMT_FLOAT_LE     16
#define VIRTIO_SND_PCM_FMT_FLOAT_BE     17
#define VIRTIO_SND_PCM_FMT_FLOAT64_LE   18
#define VIRTIO_SND_PCM_FMT_FLOAT64_BE   19
#define VIRTIO_SND_PCM_FMT_S20_LE       20
#define VIRTIO_SND_PCM_FMT_S20_BE       21
#define VIRTIO_SND_PCM_FMT_U20_LE       22
#define VIRTIO_SND_PCM_FMT_U20_BE       23
#define VIRTIO_SND_PCM_FMT_S24_3LE      24
#define VIRTIO_SND_PCM_FMT_S24_3BE      25
#define VIRTIO_SND_PCM_FMT_U24_3LE      26
#define VIRTIO_SND_PCM_FMT_U24_3BE      27
#define VIRTIO_SND_PCM_FMT_S20_3LE      28
#define VIRTIO_SND_PCM_FMT_S20_3BE      29
#define VIRTIO_SND_PCM_FMT_U20_3LE      30
#define VIRTIO_SND_PCM_FMT_U20_3BE      31
#define VIRTIO_SND_PCM_FMT_S18_3LE      32
#define VIRTIO_SND_PCM_FMT_U18_3LE      33
#define VIRTIO_SND_PCM_FMT_S18_3BE      34
#define VIRTIO_SND_PCM_FMT_U18_3BE      35

#define VIRTIO_SND_PCM_FMTBIT(bit)      (1ULL << VIRTIO_SND_PCM_FMT_ ## bit)

#define VIRTIO_SND_PCM_FMTBIT_MU_LAW    VIRTIO_SND_PCM_FMTBIT(MU_LAW)
#define VIRTIO_SND_PCM_FMTBIT_A_LAW     VIRTIO_SND_PCM_FMTBIT(A_LAW)
#define VIRTIO_SND_PCM_FMTBIT_S8        VIRTIO_SND_PCM_FMTBIT(S8)
#define VIRTIO_SND_PCM_FMTBIT_U8        VIRTIO_SND_PCM_FMTBIT(U8)
#define VIRTIO_SND_PCM_FMTBIT_S16_LE    VIRTIO_SND_PCM_FMTBIT(S16_LE)
#define VIRTIO_SND_PCM_FMTBIT_S16_BE    VIRTIO_SND_PCM_FMTBIT(S16_BE)
#define VIRTIO_SND_PCM_FMTBIT_U16_LE    VIRTIO_SND_PCM_FMTBIT(U16_LE)
#define VIRTIO_SND_PCM_FMTBIT_U16_BE    VIRTIO_SND_PCM_FMTBIT(U16_BE)
#define VIRTIO_SND_PCM_FMTBIT_S24_LE    VIRTIO_SND_PCM_FMTBIT(S24_LE)
#define VIRTIO_SND_PCM_FMTBIT_S24_BE    VIRTIO_SND_PCM_FMTBIT(S24_BE)
#define VIRTIO_SND_PCM_FMTBIT_U24_LE    VIRTIO_SND_PCM_FMTBIT(U24_LE)
#define VIRTIO_SND_PCM_FMTBIT_U24_BE    VIRTIO_SND_PCM_FMTBIT(U24_BE)
#define VIRTIO_SND_PCM_FMTBIT_S32_LE    VIRTIO_SND_PCM_FMTBIT(S32_LE)
#define VIRTIO_SND_PCM_FMTBIT_S32_BE    VIRTIO_SND_PCM_FMTBIT(S32_BE)
#define VIRTIO_SND_PCM_FMTBIT_U32_LE    VIRTIO_SND_PCM_FMTBIT(U32_LE)
#define VIRTIO_SND_PCM_FMTBIT_U32_BE    VIRTIO_SND_PCM_FMTBIT(U32_BE)
#define VIRTIO_SND_PCM_FMTBIT_FLOAT_LE  VIRTIO_SND_PCM_FMTBIT(FLOAT_LE)
#define VIRTIO_SND_PCM_FMTBIT_FLOAT_BE  VIRTIO_SND_PCM_FMTBIT(FLOAT_BE)
#define VIRTIO_SND_PCM_FMTBIT_FLOAT64_LE VIRTIO_SND_PCM_FMTBIT(FLOAT64_LE)
#define VIRTIO_SND_PCM_FMTBIT_FLOAT64_BE VIRTIO_SND_PCM_FMTBIT(FLOAT64_BE)
#define VIRTIO_SND_PCM_FMTBIT_S20_LE    VIRTIO_SND_PCM_FMTBIT(S20_LE)
#define VIRTIO_SND_PCM_FMTBIT_S20_BE    VIRTIO_SND_PCM_FMTBIT(S20_BE)
#define VIRTIO_SND_PCM_FMTBIT_U20_LE    VIRTIO_SND_PCM_FMTBIT(U20_LE)
#define VIRTIO_SND_PCM_FMTBIT_U20_BE    VIRTIO_SND_PCM_FMTBIT(U20_BE)
#define VIRTIO_SND_PCM_FMTBIT_S24_3LE   VIRTIO_SND_PCM_FMTBIT(S24_3LE)
#define VIRTIO_SND_PCM_FMTBIT_S24_3BE   VIRTIO_SND_PCM_FMTBIT(S24_3BE)
#define VIRTIO_SND_PCM_FMTBIT_U24_3LE   VIRTIO_SND_PCM_FMTBIT(U24_3LE)
#define VIRTIO_SND_PCM_FMTBIT_U24_3BE   VIRTIO_SND_PCM_FMTBIT(U24_3BE)
#define VIRTIO_SND_PCM_FMTBIT_S20_3LE   VIRTIO_SND_PCM_FMTBIT(S20_3LE)
#define VIRTIO_SND_PCM_FMTBIT_S20_3BE   VIRTIO_SND_PCM_FMTBIT(S20_3BE)
#define VIRTIO_SND_PCM_FMTBIT_U20_3LE   VIRTIO_SND_PCM_FMTBIT(U20_3LE)
#define VIRTIO_SND_PCM_FMTBIT_U20_3BE   VIRTIO_SND_PCM_FMTBIT(U20_3BE)
#define VIRTIO_SND_PCM_FMTBIT_S18_3LE   VIRTIO_SND_PCM_FMTBIT(S18_3LE)
#define VIRTIO_SND_PCM_FMTBIT_S18_3BE   VIRTIO_SND_PCM_FMTBIT(S18_3BE)
#define VIRTIO_SND_PCM_FMTBIT_U18_3LE   VIRTIO_SND_PCM_FMTBIT(U18_3LE)
#define VIRTIO_SND_PCM_FMTBIT_U18_3BE   VIRTIO_SND_PCM_FMTBIT(U18_3BE)

/* supported PCM frame rates */
#define VIRTIO_SND_PCM_RATE_5512        0
#define VIRTIO_SND_PCM_RATE_8000        1
#define VIRTIO_SND_PCM_RATE_11025       2
#define VIRTIO_SND_PCM_RATE_16000       3
#define VIRTIO_SND_PCM_RATE_22050       4
#define VIRTIO_SND_PCM_RATE_32000       5
#define VIRTIO_SND_PCM_RATE_44100       6
#define VIRTIO_SND_PCM_RATE_48000       7
#define VIRTIO_SND_PCM_RATE_64000       8
#define VIRTIO_SND_PCM_RATE_88200       9
#define VIRTIO_SND_PCM_RATE_96000       10
#define VIRTIO_SND_PCM_RATE_176400      11
#define VIRTIO_SND_PCM_RATE_192000      12

#define VIRTIO_SND_PCM_RATEBIT(bit)     (1U << VIRTIO_SND_PCM_RATE_ ## bit)

#define VIRTIO_SND_PCM_RATEBIT_5512     VIRTIO_SND_PCM_RATEBIT(5512)
#define VIRTIO_SND_PCM_RATEBIT_8000     VIRTIO_SND_PCM_RATEBIT(8000)
#define VIRTIO_SND_PCM_RATEBIT_11025    VIRTIO_SND_PCM_RATEBIT(11025)
#define VIRTIO_SND_PCM_RATEBIT_16000    VIRTIO_SND_PCM_RATEBIT(16000)
#define VIRTIO_SND_PCM_RATEBIT_22050    VIRTIO_SND_PCM_RATEBIT(22050)
#define VIRTIO_SND_PCM_RATEBIT_32000    VIRTIO_SND_PCM_RATEBIT(32000)
#define VIRTIO_SND_PCM_RATEBIT_44100    VIRTIO_SND_PCM_RATEBIT(44100)
#define VIRTIO_SND_PCM_RATEBIT_48000    VIRTIO_SND_PCM_RATEBIT(48000)
#define VIRTIO_SND_PCM_RATEBIT_64000    VIRTIO_SND_PCM_RATEBIT(64000)
#define VIRTIO_SND_PCM_RATEBIT_88200    VIRTIO_SND_PCM_RATEBIT(88200)
#define VIRTIO_SND_PCM_RATEBIT_96000    VIRTIO_SND_PCM_RATEBIT(96000)
#define VIRTIO_SND_PCM_RATEBIT_176400   VIRTIO_SND_PCM_RATEBIT(176400)
#define VIRTIO_SND_PCM_RATEBIT_192000   VIRTIO_SND_PCM_RATEBIT(192000)

/* a PCM stream descriptor */
struct virtio_snd_pcm_stream_desc
{
    /* sizeof(struct virtio_snd_pcm_stream_desc) */
    u8 length;
    /* VIRTIO_SND_DESC_PCM_STREAM */
    u8 type;
    /* a PCM stream type (VIRTIO_SND_PCM_T_XXX) */
    u8 stream_type;
    /* # of substreams for the specified stream type */
    u8 nsubstreams;
    /* minimum # of supported channels */
    le16 channels_min;
    /* maximum # of supported channels */
    le16 channels_max;
    /* supported sample formats (VIRTIO_SND_PCM_FMTBIT_XXX, can be ORed) */
    le64 formats;
    /* supported frame rates (VIRTIO_SND_PCM_RATEBIT_XXX, can be ORed) */
    le32 rates;
    /* supported PCM stream features (VIRTIO_SND_PCM_FEATBIT_XXX, can be ORed) */
    le16 features;
    /* # of supported channel maps */
    le16 nchmaps;
};
```

### Function Initialization

Upon function initialization, the driver MUST set selected operational mode per
each available substream for all available streams.

### Function Operation

#### Features

The driver sends the VIRTIO_SND_PCM_R_GET_FEATURE/VIRTIO_SND_PCM_R_SET_FEATURE to
get/set substream feature-specific value.

```
/* get/set a PCM substream feature */
struct virtio_snd_pcm_feature
{
    /* VIRTIO_SND_FN_PCM */
    le16 function;
    /* VIRTIO_SND_PCM_R_GET_FEATURE / VIRTIO_SND_PCM_R_SET_FEATURE */
    le16 request;
    /* a PCM identifier (assigned in configuration) */
    u8 pcm_id;
    /* a PCM stream type (VIRTIO_SND_PCM_T_XXX) */
    u8 stream_type;
    /* a PCM substream identifier [0 .. virtio_snd_pcm_stream_desc::nsubstreams - 1] */
    u8 substream_id;
    /* a selected PCM substream feature (VIRTIO_SND_PCM_FEAT_XXX) */
    u8 feature;
    /* a feature-specific optional request data */
    union
    {
        /* VIRTIO_SND_PCM_FEAT_UPDATE_FREQUENCY [SET-only] */
        struct
        {
            /* an approximate update frequency in microseconds */
            le32 microseconds;
            /* an approximate update frequency in bytes */
            le32 bytes;
        } update_frequency;
        /*
         * VIRTIO_SND_PCM_FEAT_MANUAL_MODE [SET-only]
         *   .data = a virtual queue index
         * VIRTIO_SND_PCM_FEAT_AUTO_MODE [SET-only]
         *   .data = a pseudophysical start address of the virtio_snd_pcm_shmem structure
         * VIRTIO_SND_PCM_FEAT_CHANNEL_MAP [GET/SET]
         *   GET:
         *     .data = a channel map index [0 .. virtio_snd_pcm_stream_desc::nchmaps - 1]
         *   SET:
         *     .data = a pseudophysical start address of the virtio_snd_pcm_chmap_data structure
         */
        le64 data;
    };
};
```

<u>Manual mode (VIRTIO_SND_PCM_FEAT_MANUAL_MODE)</u>

If the device supports the manual operating mode, it sets the VIRTIO_SND_PCM_FEATBIT_MANUAL_MODE
bit in the features field value in PCM stream configuration descriptor.

In manual mode, the driver assigns a dedicated virtual queue for a PCM substream
and uses it to transmit data buffers to the device. In the playback mode, upon
receiving a data buffer, the device reads next available PCM frames from it. In
the capture mode, upon receiving a data buffer, the device writes available PCM
frames into it and notifies the driver only when the buffer is full.

The driver can move its read/write pointer using the VIRTIO_SND_PCM_R_REWIND or
the VIRTIO_SND_PCM_R_FORWARD requests.

The driver enables manual mode by setting the VIRTIO_SND_PCM_FEAT_MANUAL_MODE
feature for a substream and specifying virtual queue index as a request argument.
The device answers with a generic response.

<u>Automatic mode (VIRTIO_SND_PCM_FEAT_AUTO_MODE)</u>

If the device supports the automatic operating mode, it sets the VIRTIO_SND_PCM_FEATBIT_AUTO_MODE
bit in the features field value in PCM stream configuration descriptor.

In automatic mode, the driver allocates a pseudophysically continuous memory area
consisted of:

1. *Hardware registers*: represents the device runtime state.
2. *Software registers*: represents the driver runtime state.
3. *DMA buffer*: PCM frames storage.

```
/* --- PCM HARDWARE STATE BITMAP --- */
#define VIRTIO_SND_PCM_HW_S_RUNNING     0x0001
#define VIRTIO_SND_PCM_HW_S_PAUSED      0x0002

struct virtio_snd_pcm_hw_regs
{
    /*
     *  Bits | Mnemonic  | Description
     * ------+-----------+------------------------------------------------------
     *     0 | RUNNING   | 0 = Substream is not running
     *       |           | 1 = Substream is running
     * ------+-----------+------------------------------------------------------
     *     1 | PAUSED    | 0 = Substream is not paused
     *       |           | 1 = Substream is paused
     * ------+-----------+------------------------------------------------------
     *  2:31 |           | Reserved, must be zero.
     */
    le32 state;
    /* additional hardware latency: unsigned value in bytes */
    le32 latency;
    /* current hardware position: unsigned value in bytes [0 .. dma_size - 1] */
    le32 dma_position;
};

struct virtio_snd_pcm_sw_regs
{
    /* current DMA buffer size in bytes */
    le32 dma_size;
};

/* a PCM substream shared memory structure */
struct virtio_snd_pcm_shmem
{
    /*
     * automatic mode hardware registers
     *   device: writable
     *   driver: read-only
     */
    struct virtio_snd_pcm_hw_regs hwrs;

    /*
     * automatic mode software registers
     *   device: read-only
     *   driver: writable
     */
    struct virtio_snd_pcm_sw_regs swrs;

    /*
     * followed by a variable sized DMA buffer
     *   in the playback mode:
     *     device: read-only
     *     driver: writable
     *   in the capture mode:
     *     device: writable
     *     driver: read-only
     */
};
```

The driver enables automatic mode by setting the VIRTIO_SND_PCM_FEAT_AUTO_MODE
feature for a substream and specifying a pseudophysical start address of the
virtio_snd_pcm_shmem structure as a request argument. The device answers with a
generic response.

The driver MUST allocates DMA buffer of maximum possible size and set the dma_size
field value to this size while sending the VIRTIO_SND_PCM_R_SET_FEATURE request.
Depending on selected PCM format, the actual buffer size can be less or equal to
maximum possible one.

In case of the playback stream, the device reads constant amount of PCM frames
with constant time intervals without any requests from the driver. In case of
the capture stream, the device writes constant amount of PCM frames with constant
time intervals without any notifications to the driver.

<u>Update frequency (VIRTIO_SND_PCM_FEAT_UPDATE_FREQUENCY)</u>

If the device requires specifying an approximate data buffer update frequency,
it sets the VIRTIO_SND_PCM_FEATBIT_UPDATE_FREQUENCY bit in the features field
value in PCM stream configuration descriptor.

In such case, the driver MUST set the VIRTIO_SND_PCM_FEAT_UPDATE_FREQUENCY feature
and specify an approximate update frequency (expressed in both microseconds and
bytes units) as a request argument before starting a PCM substream. The device
answers with a generic response.

<u>Channel map (VIRTIO_SND_PCM_FEAT_CHANNEL_MAP)</u>

If the device provides an ability to get supported channel maps, it sets
the VIRTIO_SND_PCM_FEATBIT_CHANNEL_MAP bit in the features field value and
specifies an amount of supported channel maps in the nchmaps field in PCM stream
configuration descriptor.

The driver gets the VIRTIO_SND_PCM_FEAT_CHANNEL_MAP feature value in order to obtain
a channel map with specified index, the device answers with the virtio_snd_pcm_chmap
PCM response.

If channel map type allows to swap channels, the driver can set the VIRTIO_SND_PCM_FEAT_CHANNEL_MAP
feature value specifying selected channel map data as a request argument. The
device answers with a generic response.

```
/* a PCM channel map definitions */

/* All channels have fixed channel positions */
#define VIRTIO_SND_PCM_CHMAP_FIXED      0
/* All channels are swappable (e.g. {FL/FR/RL/RR} -> {RR/RL/FR/FL}) */
#define VIRTIO_SND_PCM_CHMAP_VARIABLE   1
/* Only pair-wise channels are swappable (e.g. {FL/FR/RL/RR} -> {RL/RR/FL/FR}) */
#define VIRTIO_SND_PCM_CHMAP_PAIRED     2

/* Standard channel position definition */
#define VIRTIO_SND_PCM_CH_NONE          0   /* undefined */
#define VIRTIO_SND_PCM_CH_NA            1   /* silent */
#define VIRTIO_SND_PCM_CH_MONO          2   /* mono stream */
#define VIRTIO_SND_PCM_CH_FL            3   /* front left */
#define VIRTIO_SND_PCM_CH_FR            4   /* front right */
#define VIRTIO_SND_PCM_CH_RL            5   /* rear left */
#define VIRTIO_SND_PCM_CH_RR            6   /* rear right */
#define VIRTIO_SND_PCM_CH_FC            7   /* front center */
#define VIRTIO_SND_PCM_CH_LFE           8   /* low frequency (LFE) */
#define VIRTIO_SND_PCM_CH_SL            9   /* side left */
#define VIRTIO_SND_PCM_CH_SR            10  /* side right */
#define VIRTIO_SND_PCM_CH_RC            11  /* rear center */
#define VIRTIO_SND_PCM_CH_FLC           12  /* front left center */
#define VIRTIO_SND_PCM_CH_FRC           13  /* front right center */
#define VIRTIO_SND_PCM_CH_RLC           14  /* rear left center */
#define VIRTIO_SND_PCM_CH_RRC           15  /* rear right center */
#define VIRTIO_SND_PCM_CH_FLW           16  /* front left wide */
#define VIRTIO_SND_PCM_CH_FRW           17  /* front right wide */
#define VIRTIO_SND_PCM_CH_FLH           18  /* front left high */
#define VIRTIO_SND_PCM_CH_FCH           19  /* front center high */
#define VIRTIO_SND_PCM_CH_FRH           20  /* front right high */
#define VIRTIO_SND_PCM_CH_TC            21  /* top center */
#define VIRTIO_SND_PCM_CH_TFL           22  /* top front left */
#define VIRTIO_SND_PCM_CH_TFR           23  /* top front right */
#define VIRTIO_SND_PCM_CH_TFC           24  /* top front center */
#define VIRTIO_SND_PCM_CH_TRL           25  /* top rear left */
#define VIRTIO_SND_PCM_CH_TRR           26  /* top rear right */
#define VIRTIO_SND_PCM_CH_TRC           27  /* top rear center */
#define VIRTIO_SND_PCM_CH_TFLC          28  /* top front left center */
#define VIRTIO_SND_PCM_CH_TFRC          29  /* top front right center */
#define VIRTIO_SND_PCM_CH_TSL           30  /* top side left */
#define VIRTIO_SND_PCM_CH_TSR           31  /* top side right */
#define VIRTIO_SND_PCM_CH_LLFE          32  /* left LFE */
#define VIRTIO_SND_PCM_CH_RLFE          33  /* right LFE */
#define VIRTIO_SND_PCM_CH_BC            34  /* bottom center */
#define VIRTIO_SND_PCM_CH_BLC           35  /* bottom left center */
#define VIRTIO_SND_PCM_CH_BRC           36  /* bottom right center */

/*
 * The channel is phase inverted (thus summing left and right channels would
 * result in almost silence).
 */
#define VIRTIO_SND_PCM_CH_F_PHASE_INVERSE 0x01

#define VIRTIO_SND_PCM_CH_MAX           256

/* a PCM channel information */
struct virtio_snd_pcm_chinfo
{
    /* a PCM channel position (VIRTIO_SND_PCM_CH_XXX) */
    u8 position;
    /* a PCM channel flags (VIRTIO_SND_PCM_CH_F_XXX, can be ORed) */
    u8 flags;
};

/* a PCM channel map data */
struct virtio_snd_pcm_chmap_data
{
    /* # of valid entries in the PCM channel map */
    le32 nchannels;
    /* a PCM channel map */
    struct virtio_snd_pcm_chinfo channel_map[VIRTIO_SND_PCM_CH_MAX];
};

/* a response containing PCM channel map */
struct virtio_snd_pcm_chmap
{
    struct virtio_snd_rsp hdr;
    /* a channel map type (VIRTIO_SND_PCM_CHMAP_XXX) */
    u8 type;
    /* reserved, must be zero */
    u8 reserved[3];
    /* a channel map data */
    struct virtio_snd_pcm_chmap_data data;
};
```

#### Set Format

The driver MUST send the VIRTIO_SND_PCM_R_SET_FORMAT request containing selected
PCM stream parameters, the device answers with a generic response.

```
/* set a PCM substream format */
struct virtio_snd_pcm_set_format
{
    /* .request = VIRTIO_SND_PCM_R_SET_FORMAT */
    struct virtio_snd_pcm_hdr hdr;
    /* # of channels */
    le16 channels;
    /* a PCM sample format (VIRTIO_SND_PCM_FMT_XXX) */
    le16 format;
    /* a PCM frame rate (VIRTIO_SND_PCM_RATE_XXX) */
    le16 rate;
    u16 padding;
};
```

#### Prepare

The driver MUST send the VIRTIO_SND_PCM_R_PREPARE generic PCM request to prepare
a substream for running, the device answers with a generic response.

#### Start

The driver sends the VIRTIO_SND_PCM_R_START generic PCM request, the device
answers with a generic response.

In automatic mode:

- on success, the VIRTIO_SND_PCM_HW_S_RUNNING substream state bit MUST be set,
- the device MUST start to read/write PCM frames from/to shared DMA buffer.

#### Stop

The driver sends the VIRTIO_SND_PCM_R_STOP generic PCM request, the device answers
with a generic response.

In manual mode:

- the device MUST release all provided buffers by setting result length to zero
and notifying the driver.

In automatic mode:

- the VIRTIO_SND_PCM_HW_S_RUNNING substream state bit MUST be cleared,
- the device MUST stop to read/write PCM frames from/to shared DMA buffer.

#### Pause

The driver sends the VIRTIO_SND_PCM_R_PAUSE generic PCM request, the device
answers with a generic response.

In automatic mode:

- on success, the VIRTIO_SND_PCM_HW_S_PAUSED substream state bit MUST be set.

#### Unpause

The driver sends the VIRTIO_SND_PCM_R_UNPAUSE generic PCM request, the device
answers with a generic response.

In automatic mode:

- the VIRTIO_SND_PCM_HW_S_PAUSED substream state bit MUST be cleared.

#### Rewind/Forward

[Available only in manual mode]

The driver sends the VIRTIO_SND_PCM_R_REWIND or the VIRTIO_SND_PCM_R_FORWARD
request containing seek count, the device answers with a generic response.

```
/* seek (rewind/forward) a PCM substream read/write position */
struct virtio_snd_pcm_seek
{
    /* .request = VIRTIO_SND_PCM_R_REWIND / VIRTIO_SND_PCM_R_FORWARD */
    struct virtio_snd_pcm_hdr hdr;
    /* seek count: unsigned value in bytes */
    le32 count;
    u32 padding;
};
```

--------------27E016126600CA6DDCC71654
Content-Type: text/x-chdr; name="virtio_snd.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="virtio_snd.h"

/*
 * Copyright (C) 2019  OpenSynergy GmbH
 *
 * This header is BSD licensed so anyone can use the definitions to
 * implement compatible drivers/servers.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of OpenSynergy GmbH nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
 * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
 * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE. */

#ifndef VIRTIO_SND_IF_H
#define VIRTIO_SND_IF_H

#include <linux/virtio_types.h>

/*******************************************************************************
 * COMMON DEFINITIONS
 */

/* a configuration space */
struct virtio_snd_config
{
    /* maximum # of available virtual queues */
    __virtio32 nqueues;
};

/* --- GENERIC ERROR CODES --- */
/* no errors */
#define VIRTIO_SND_E_SUCCESS            0
/* an undefined error */
#define VIRTIO_SND_E_GENERAL            1
/* not supported input parameter(s) */
#define VIRTIO_SND_E_NOTSUPPORTED       2
/* invalid input parameter(s) */
#define VIRTIO_SND_E_INVALID            3
/* I/O error */
#define VIRTIO_SND_E_IO                 4

/* a generic request header */
struct virtio_snd_req
{
    __virtio16 function;
    __virtio16 request;
};

/* a generic response header */
struct virtio_snd_rsp
{
    __virtio32 status; /* VIRTIO_SND_E_XXX */
};

/* supported function types */
#define VIRTIO_SND_FN_BASE              0
#define VIRTIO_SND_FN_PCM               1

/* supported descriptor types */
#define VIRTIO_SND_DESC_PCM             0
#define VIRTIO_SND_DESC_PCM_STREAM      1

/* a generic descriptor */
struct virtio_snd_generic_desc
{
    __u8 length;
    __u8 type;
    __u16 padding;
};

/*******************************************************************************
 * BASE FUNCTION DEFINITIONS
 */

/* --- BASE REQUEST TYPES --- */
#define VIRTIO_SND_BASE_R_GET_CFG       0
#define VIRTIO_SND_BASE_R_SUSPEND       1
#define VIRTIO_SND_BASE_R_RESUME        2

/* a maximum possible configuration data size (in bytes) */
#define VIRTIO_SND_BASE_CFG_MAX_SIZE    1024

/* a response containing device configuration */
struct virtio_snd_base_configuration
{
    struct virtio_snd_rsp hdr;
    /* size in bytes of configuration data */
    __virtio32 length;
    /* configuration data */
    __u8 data[VIRTIO_SND_BASE_CFG_MAX_SIZE];
};

/*******************************************************************************
 * PCM FUNCTION DEFINITIONS
 */

/* supported PCM stream types */
#define VIRTIO_SND_PCM_T_PLAYBACK       0
#define VIRTIO_SND_PCM_T_CAPTURE        1

/* supported PCM stream features */
#define VIRTIO_SND_PCM_FEAT_MANUAL_MODE 0
#define VIRTIO_SND_PCM_FEAT_AUTO_MODE   1
#define VIRTIO_SND_PCM_FEAT_UPDATE_FREQUENCY 2
#define VIRTIO_SND_PCM_FEAT_CHANNEL_MAP 3

#define VIRTIO_SND_PCM_FEATBIT(bit)     (1U << VIRTIO_SND_PCM_FEAT_ ## bit)

#define VIRTIO_SND_PCM_FEATBIT_MANUAL_MODE \
    VIRTIO_SND_PCM_FEATBIT(MANUAL_MODE)
#define VIRTIO_SND_PCM_FEATBIT_AUTO_MODE \
    VIRTIO_SND_PCM_FEATBIT(AUTO_MODE)
#define VIRTIO_SND_PCM_FEATBIT_UPDATE_FREQUENCY \
    VIRTIO_SND_PCM_FEATBIT(UPDATE_FREQUENCY)
#define VIRTIO_SND_PCM_FEATBIT_CHANNEL_MAP \
    VIRTIO_SND_PCM_FEATBIT(CHANNEL_MAP)

/* supported PCM sample formats */
#define VIRTIO_SND_PCM_FMT_MU_LAW       0
#define VIRTIO_SND_PCM_FMT_A_LAW        1
#define VIRTIO_SND_PCM_FMT_S8           2
#define VIRTIO_SND_PCM_FMT_U8           3
#define VIRTIO_SND_PCM_FMT_S16_LE       4
#define VIRTIO_SND_PCM_FMT_S16_BE       5
#define VIRTIO_SND_PCM_FMT_U16_LE       6
#define VIRTIO_SND_PCM_FMT_U16_BE       7
#define VIRTIO_SND_PCM_FMT_S24_LE       8
#define VIRTIO_SND_PCM_FMT_S24_BE       9
#define VIRTIO_SND_PCM_FMT_U24_LE       10
#define VIRTIO_SND_PCM_FMT_U24_BE       11
#define VIRTIO_SND_PCM_FMT_S32_LE       12
#define VIRTIO_SND_PCM_FMT_S32_BE       13
#define VIRTIO_SND_PCM_FMT_U32_LE       14
#define VIRTIO_SND_PCM_FMT_U32_BE       15
#define VIRTIO_SND_PCM_FMT_FLOAT_LE     16
#define VIRTIO_SND_PCM_FMT_FLOAT_BE     17
#define VIRTIO_SND_PCM_FMT_FLOAT64_LE   18
#define VIRTIO_SND_PCM_FMT_FLOAT64_BE   19
#define VIRTIO_SND_PCM_FMT_S20_LE       20
#define VIRTIO_SND_PCM_FMT_S20_BE       21
#define VIRTIO_SND_PCM_FMT_U20_LE       22
#define VIRTIO_SND_PCM_FMT_U20_BE       23
#define VIRTIO_SND_PCM_FMT_S24_3LE      24
#define VIRTIO_SND_PCM_FMT_S24_3BE      25
#define VIRTIO_SND_PCM_FMT_U24_3LE      26
#define VIRTIO_SND_PCM_FMT_U24_3BE      27
#define VIRTIO_SND_PCM_FMT_S20_3LE      28
#define VIRTIO_SND_PCM_FMT_S20_3BE      29
#define VIRTIO_SND_PCM_FMT_U20_3LE      30
#define VIRTIO_SND_PCM_FMT_U20_3BE      31
#define VIRTIO_SND_PCM_FMT_S18_3LE      32
#define VIRTIO_SND_PCM_FMT_U18_3LE      33
#define VIRTIO_SND_PCM_FMT_S18_3BE      34
#define VIRTIO_SND_PCM_FMT_U18_3BE      35

#define VIRTIO_SND_PCM_FMTBIT(bit)      (1ULL << VIRTIO_SND_PCM_FMT_ ## bit)

#define VIRTIO_SND_PCM_FMTBIT_MU_LAW    VIRTIO_SND_PCM_FMTBIT(MU_LAW)
#define VIRTIO_SND_PCM_FMTBIT_A_LAW     VIRTIO_SND_PCM_FMTBIT(A_LAW)
#define VIRTIO_SND_PCM_FMTBIT_S8        VIRTIO_SND_PCM_FMTBIT(S8)
#define VIRTIO_SND_PCM_FMTBIT_U8        VIRTIO_SND_PCM_FMTBIT(U8)
#define VIRTIO_SND_PCM_FMTBIT_S16_LE    VIRTIO_SND_PCM_FMTBIT(S16_LE)
#define VIRTIO_SND_PCM_FMTBIT_S16_BE    VIRTIO_SND_PCM_FMTBIT(S16_BE)
#define VIRTIO_SND_PCM_FMTBIT_U16_LE    VIRTIO_SND_PCM_FMTBIT(U16_LE)
#define VIRTIO_SND_PCM_FMTBIT_U16_BE    VIRTIO_SND_PCM_FMTBIT(U16_BE)
#define VIRTIO_SND_PCM_FMTBIT_S24_LE    VIRTIO_SND_PCM_FMTBIT(S24_LE)
#define VIRTIO_SND_PCM_FMTBIT_S24_BE    VIRTIO_SND_PCM_FMTBIT(S24_BE)
#define VIRTIO_SND_PCM_FMTBIT_U24_LE    VIRTIO_SND_PCM_FMTBIT(U24_LE)
#define VIRTIO_SND_PCM_FMTBIT_U24_BE    VIRTIO_SND_PCM_FMTBIT(U24_BE)
#define VIRTIO_SND_PCM_FMTBIT_S32_LE    VIRTIO_SND_PCM_FMTBIT(S32_LE)
#define VIRTIO_SND_PCM_FMTBIT_S32_BE    VIRTIO_SND_PCM_FMTBIT(S32_BE)
#define VIRTIO_SND_PCM_FMTBIT_U32_LE    VIRTIO_SND_PCM_FMTBIT(U32_LE)
#define VIRTIO_SND_PCM_FMTBIT_U32_BE    VIRTIO_SND_PCM_FMTBIT(U32_BE)
#define VIRTIO_SND_PCM_FMTBIT_FLOAT_LE  VIRTIO_SND_PCM_FMTBIT(FLOAT_LE)
#define VIRTIO_SND_PCM_FMTBIT_FLOAT_BE  VIRTIO_SND_PCM_FMTBIT(FLOAT_BE)
#define VIRTIO_SND_PCM_FMTBIT_FLOAT64_LE VIRTIO_SND_PCM_FMTBIT(FLOAT64_LE)
#define VIRTIO_SND_PCM_FMTBIT_FLOAT64_BE VIRTIO_SND_PCM_FMTBIT(FLOAT64_BE)
#define VIRTIO_SND_PCM_FMTBIT_S20_LE    VIRTIO_SND_PCM_FMTBIT(S20_LE)
#define VIRTIO_SND_PCM_FMTBIT_S20_BE    VIRTIO_SND_PCM_FMTBIT(S20_BE)
#define VIRTIO_SND_PCM_FMTBIT_U20_LE    VIRTIO_SND_PCM_FMTBIT(U20_LE)
#define VIRTIO_SND_PCM_FMTBIT_U20_BE    VIRTIO_SND_PCM_FMTBIT(U20_BE)
#define VIRTIO_SND_PCM_FMTBIT_S24_3LE   VIRTIO_SND_PCM_FMTBIT(S24_3LE)
#define VIRTIO_SND_PCM_FMTBIT_S24_3BE   VIRTIO_SND_PCM_FMTBIT(S24_3BE)
#define VIRTIO_SND_PCM_FMTBIT_U24_3LE   VIRTIO_SND_PCM_FMTBIT(U24_3LE)
#define VIRTIO_SND_PCM_FMTBIT_U24_3BE   VIRTIO_SND_PCM_FMTBIT(U24_3BE)
#define VIRTIO_SND_PCM_FMTBIT_S20_3LE   VIRTIO_SND_PCM_FMTBIT(S20_3LE)
#define VIRTIO_SND_PCM_FMTBIT_S20_3BE   VIRTIO_SND_PCM_FMTBIT(S20_3BE)
#define VIRTIO_SND_PCM_FMTBIT_U20_3LE   VIRTIO_SND_PCM_FMTBIT(U20_3LE)
#define VIRTIO_SND_PCM_FMTBIT_U20_3BE   VIRTIO_SND_PCM_FMTBIT(U20_3BE)
#define VIRTIO_SND_PCM_FMTBIT_S18_3LE   VIRTIO_SND_PCM_FMTBIT(S18_3LE)
#define VIRTIO_SND_PCM_FMTBIT_S18_3BE   VIRTIO_SND_PCM_FMTBIT(S18_3BE)
#define VIRTIO_SND_PCM_FMTBIT_U18_3LE   VIRTIO_SND_PCM_FMTBIT(U18_3LE)
#define VIRTIO_SND_PCM_FMTBIT_U18_3BE   VIRTIO_SND_PCM_FMTBIT(U18_3BE)

/* supported PCM frame rates */
#define VIRTIO_SND_PCM_RATE_5512        0
#define VIRTIO_SND_PCM_RATE_8000        1
#define VIRTIO_SND_PCM_RATE_11025       2
#define VIRTIO_SND_PCM_RATE_16000       3
#define VIRTIO_SND_PCM_RATE_22050       4
#define VIRTIO_SND_PCM_RATE_32000       5
#define VIRTIO_SND_PCM_RATE_44100       6
#define VIRTIO_SND_PCM_RATE_48000       7
#define VIRTIO_SND_PCM_RATE_64000       8
#define VIRTIO_SND_PCM_RATE_88200       9
#define VIRTIO_SND_PCM_RATE_96000       10
#define VIRTIO_SND_PCM_RATE_176400      11
#define VIRTIO_SND_PCM_RATE_192000      12

#define VIRTIO_SND_PCM_RATEBIT(bit)     (1U << VIRTIO_SND_PCM_RATE_ ## bit)

#define VIRTIO_SND_PCM_RATEBIT_5512     VIRTIO_SND_PCM_RATEBIT(5512)
#define VIRTIO_SND_PCM_RATEBIT_8000     VIRTIO_SND_PCM_RATEBIT(8000)
#define VIRTIO_SND_PCM_RATEBIT_11025    VIRTIO_SND_PCM_RATEBIT(11025)
#define VIRTIO_SND_PCM_RATEBIT_16000    VIRTIO_SND_PCM_RATEBIT(16000)
#define VIRTIO_SND_PCM_RATEBIT_22050    VIRTIO_SND_PCM_RATEBIT(22050)
#define VIRTIO_SND_PCM_RATEBIT_32000    VIRTIO_SND_PCM_RATEBIT(32000)
#define VIRTIO_SND_PCM_RATEBIT_44100    VIRTIO_SND_PCM_RATEBIT(44100)
#define VIRTIO_SND_PCM_RATEBIT_48000    VIRTIO_SND_PCM_RATEBIT(48000)
#define VIRTIO_SND_PCM_RATEBIT_64000    VIRTIO_SND_PCM_RATEBIT(64000)
#define VIRTIO_SND_PCM_RATEBIT_88200    VIRTIO_SND_PCM_RATEBIT(88200)
#define VIRTIO_SND_PCM_RATEBIT_96000    VIRTIO_SND_PCM_RATEBIT(96000)
#define VIRTIO_SND_PCM_RATEBIT_176400   VIRTIO_SND_PCM_RATEBIT(176400)
#define VIRTIO_SND_PCM_RATEBIT_192000   VIRTIO_SND_PCM_RATEBIT(192000)

/* a PCM channel map definitions */

/* All channels have fixed channel positions */
#define VIRTIO_SND_PCM_CHMAP_FIXED      0
/* All channels are swappable (e.g. {FL/FR/RL/RR} -> {RR/RL/FR/FL}) */
#define VIRTIO_SND_PCM_CHMAP_VARIABLE   1
/* Only pair-wise channels are swappable (e.g. {FL/FR/RL/RR} -> {RL/RR/FL/FR}) */
#define VIRTIO_SND_PCM_CHMAP_PAIRED     2

/* Standard channel position definition */
#define VIRTIO_SND_PCM_CH_NONE          0   /* undefined */
#define VIRTIO_SND_PCM_CH_NA            1   /* silent */
#define VIRTIO_SND_PCM_CH_MONO          2   /* mono stream */
#define VIRTIO_SND_PCM_CH_FL            3   /* front left */
#define VIRTIO_SND_PCM_CH_FR            4   /* front right */
#define VIRTIO_SND_PCM_CH_RL            5   /* rear left */
#define VIRTIO_SND_PCM_CH_RR            6   /* rear right */
#define VIRTIO_SND_PCM_CH_FC            7   /* front center */
#define VIRTIO_SND_PCM_CH_LFE           8   /* low frequency (LFE) */
#define VIRTIO_SND_PCM_CH_SL            9   /* side left */
#define VIRTIO_SND_PCM_CH_SR            10  /* side right */
#define VIRTIO_SND_PCM_CH_RC            11  /* rear center */
#define VIRTIO_SND_PCM_CH_FLC           12  /* front left center */
#define VIRTIO_SND_PCM_CH_FRC           13  /* front right center */
#define VIRTIO_SND_PCM_CH_RLC           14  /* rear left center */
#define VIRTIO_SND_PCM_CH_RRC           15  /* rear right center */
#define VIRTIO_SND_PCM_CH_FLW           16  /* front left wide */
#define VIRTIO_SND_PCM_CH_FRW           17  /* front right wide */
#define VIRTIO_SND_PCM_CH_FLH           18  /* front left high */
#define VIRTIO_SND_PCM_CH_FCH           19  /* front center high */
#define VIRTIO_SND_PCM_CH_FRH           20  /* front right high */
#define VIRTIO_SND_PCM_CH_TC            21  /* top center */
#define VIRTIO_SND_PCM_CH_TFL           22  /* top front left */
#define VIRTIO_SND_PCM_CH_TFR           23  /* top front right */
#define VIRTIO_SND_PCM_CH_TFC           24  /* top front center */
#define VIRTIO_SND_PCM_CH_TRL           25  /* top rear left */
#define VIRTIO_SND_PCM_CH_TRR           26  /* top rear right */
#define VIRTIO_SND_PCM_CH_TRC           27  /* top rear center */
#define VIRTIO_SND_PCM_CH_TFLC          28  /* top front left center */
#define VIRTIO_SND_PCM_CH_TFRC          29  /* top front right center */
#define VIRTIO_SND_PCM_CH_TSL           30  /* top side left */
#define VIRTIO_SND_PCM_CH_TSR           31  /* top side right */
#define VIRTIO_SND_PCM_CH_LLFE          32  /* left LFE */
#define VIRTIO_SND_PCM_CH_RLFE          33  /* right LFE */
#define VIRTIO_SND_PCM_CH_BC            34  /* bottom center */
#define VIRTIO_SND_PCM_CH_BLC           35  /* bottom left center */
#define VIRTIO_SND_PCM_CH_BRC           36  /* bottom right center */

/*
 * The channel is phase inverted (thus summing left and right channels would
 * result in almost silence).
 */
#define VIRTIO_SND_PCM_CH_F_PHASE_INVERSE 0x01

/* a PCM function descriptor */
struct virtio_snd_pcm_desc
{
    /* sizeof(struct virtio_snd_pcm_desc) */
    __u8 length;
    /* VIRTIO_SND_DESC_PCM */
    __u8 type;
    /* a PCM function ID (assigned by the device) */
    __u8 pcm_id;
    /* # of PCM stream descriptors in the configuration (one per supported PCM stream type) */
    __u8 nstreams;
};

/* a PCM stream descriptor */
struct virtio_snd_pcm_stream_desc
{
    /* sizeof(struct virtio_snd_pcm_stream_desc) */
    __u8 length;
    /* VIRTIO_SND_DESC_PCM_STREAM */
    __u8 type;
    /* a PCM stream type (VIRTIO_SND_PCM_T_XXX) */
    __u8 stream_type;
    /* # of substreams for the specified stream type */
    __u8 nsubstreams;
    /* minimum # of supported channels */
    __virtio16 channels_min;
    /* maximum # of supported channels */
    __virtio16 channels_max;
    /* supported sample formats (VIRTIO_SND_PCM_FMTBIT_XXX, can be ORed) */
    __virtio64 formats;
    /* supported frame rates (VIRTIO_SND_PCM_RATEBIT_XXX, can be ORed) */
    __virtio32 rates;
    /* supported PCM stream features (VIRTIO_SND_PCM_FEATBIT_XXX, can be ORed) */
    __virtio16 features;
    /* # of supported channel maps */
    __virtio16 nchmaps;
};

/* --- PCM HARDWARE STATE BITMAP --- */
#define VIRTIO_SND_PCM_HW_S_RUNNING     0x0001
#define VIRTIO_SND_PCM_HW_S_PAUSED      0x0002

struct virtio_snd_pcm_hw_regs
{
    /*
     *  Bits | Mnemonic  | Description
     * ------+-----------+------------------------------------------------------
     *     0 | RUNNING   | 0 = Substream is not running
     *       |           | 1 = Substream is running
     * ------+-----------+------------------------------------------------------
     *     1 | PAUSED    | 0 = Substream is not paused
     *       |           | 1 = Substream is paused
     * ------+-----------+------------------------------------------------------
     *  2:31 |           | Reserved, must be zero.
     */
    __virtio32 state;
    /* additional hardware latency: unsigned value in bytes */
    __virtio32 latency;
    /* current hardware position: unsigned value in bytes [0 .. dma_size - 1] */
    __virtio32 dma_position;
};

struct virtio_snd_pcm_sw_regs
{
    /* current DMA buffer size in bytes */
    __virtio32 dma_size;
};

/* a PCM substream shared memory structure */
struct virtio_snd_pcm_shmem
{
    /*
     * automatic mode hardware registers
     *   device: writable
     *   driver: read-only
     */
    struct virtio_snd_pcm_hw_regs hwrs;

    /*
     * automatic mode software registers
     *   device: read-only
     *   driver: writable
     */
    struct virtio_snd_pcm_sw_regs swrs;

    /*
     * followed by a variable sized DMA buffer
     *   in the playback mode:
     *     device: read-only
     *     driver: writable
     *   in the capture mode:
     *     device: writable
     *     driver: read-only
     */
};

/* --- PCM REQUEST TYPES --- */
#define VIRTIO_SND_PCM_R_GET_FEATURE    0
#define VIRTIO_SND_PCM_R_SET_FEATURE    1
#define VIRTIO_SND_PCM_R_SET_FORMAT     2
#define VIRTIO_SND_PCM_R_PREPARE        3
#define VIRTIO_SND_PCM_R_START          4
#define VIRTIO_SND_PCM_R_STOP           5
#define VIRTIO_SND_PCM_R_PAUSE          6
#define VIRTIO_SND_PCM_R_UNPAUSE        7
#define VIRTIO_SND_PCM_R_REWIND         8
#define VIRTIO_SND_PCM_R_FORWARD        9

/* --- PCM ERROR CODES --- */
#define VIRTIO_SND_PCM_E_NOT_READY      32

/* a PCM substream request header */
struct virtio_snd_pcm_hdr
{
    /* VIRTIO_SND_FN_PCM */
    __virtio16 function;
    /* a PCM request type (VIRTIO_SND_PCM_R_XXX) */
    __virtio16 request;
    /* a PCM identifier (assigned in configuration) */
    __u8 pcm_id;
    /* a PCM stream type (VIRTIO_SND_PCM_T_XXX) */
    __u8 stream_type;
    /* a PCM substream identifier [0 .. virtio_snd_pcm_stream_desc::nsubstreams - 1] */
    __u8 substream_id;
    __u8 padding;
};

/* get/set a PCM substream feature */
struct virtio_snd_pcm_feature
{
    /* VIRTIO_SND_FN_PCM */
    __virtio16 function;
    /* VIRTIO_SND_PCM_R_GET_FEATURE / VIRTIO_SND_PCM_R_SET_FEATURE */
    __virtio16 request;
    /* a PCM identifier (assigned in configuration) */
    __u8 pcm_id;
    /* a PCM stream type (VIRTIO_SND_PCM_T_XXX) */
    __u8 stream_type;
    /* a PCM substream identifier [0 .. virtio_snd_pcm_stream_desc::nsubstreams - 1] */
    __u8 substream_id;
    /* a selected PCM substream feature (VIRTIO_SND_PCM_FEAT_XXX) */
    __u8 feature;
    /* a feature-specific optional request data */
    union
    {
        /* VIRTIO_SND_PCM_FEAT_UPDATE_FREQUENCY [SET-only] */
        struct
        {
            /* an approximate update frequency in microseconds */
            __virtio32 microseconds;
            /* an approximate update frequency in bytes */
            __virtio32 bytes;
        } update_frequency;
        /*
         * VIRTIO_SND_PCM_FEAT_MANUAL_MODE [SET-only]
         *   .data = a virtual queue index
         * VIRTIO_SND_PCM_FEAT_AUTO_MODE [SET-only]
         *   .data = a pseudophysical start address of the virtio_snd_pcm_shmem structure
         * VIRTIO_SND_PCM_FEAT_CHANNEL_MAP [GET/SET]
         *   GET:
         *     .data = a channel map index [0 .. virtio_snd_pcm_stream_desc::nchmaps - 1]
         *   SET:
         *     .data = a pseudophysical start address of the virtio_snd_pcm_chmap_data structure
         */
        __virtio64 data;
    };
};

#define VIRTIO_SND_PCM_CH_MAX           256

/* a PCM channel information */
struct virtio_snd_pcm_chinfo
{
    /* a PCM channel position (VIRTIO_SND_PCM_CH_XXX) */
    __u8 position;
    /* a PCM channel flags (VIRTIO_SND_PCM_CH_F_XXX, can be ORed) */
    __u8 flags;
};

/* a PCM channel map data */
struct virtio_snd_pcm_chmap_data
{
    /* # of valid entries in the PCM channel map */
    __virtio32 nchannels;
    /* a PCM channel map */
    struct virtio_snd_pcm_chinfo channel_map[VIRTIO_SND_PCM_CH_MAX];
};

/* a response containing PCM channel map */
struct virtio_snd_pcm_chmap
{
    struct virtio_snd_rsp hdr;
    /* a channel map type (VIRTIO_SND_PCM_CHMAP_XXX) */
    __u8 type;
    /* reserved, must be zero */
    __u8 reserved[3];
    /* a channel map data */
    struct virtio_snd_pcm_chmap_data data;
};

/* set a PCM substream format */
struct virtio_snd_pcm_set_format
{
    /* .request = VIRTIO_SND_PCM_R_SET_FORMAT */
    struct virtio_snd_pcm_hdr hdr;
    /* # of channels */
    __virtio16 channels;
    /* a PCM sample format (VIRTIO_SND_PCM_FMT_XXX) */
    __virtio16 format;
    /* a PCM frame rate (VIRTIO_SND_PCM_RATE_XXX) */
    __virtio16 rate;
    __u16 padding;
};

/* seek (rewind/forward) a PCM substream read/write position */
struct virtio_snd_pcm_seek
{
    /* .request = VIRTIO_SND_PCM_R_REWIND / VIRTIO_SND_PCM_R_FORWARD */
    struct virtio_snd_pcm_hdr hdr;
    /* seek count: unsigned value in bytes */
    __virtio32 count;
    __u32 padding;
};

#endif /* VIRTIO_SND_IF_H */


--------------27E016126600CA6DDCC71654
Content-Type: text/plain; charset=us-ascii


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
--------------27E016126600CA6DDCC71654--
