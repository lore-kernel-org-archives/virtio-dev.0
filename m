Return-Path: virtio-dev-return-6364-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9097C985E92
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Nov 2019 12:57:56 +0000 (UTC)
References: <6a4978e85505ae00ca9e2b170f5e893a064c03d2.camel@linux.intel.com>
 <568f32dc-8d82-a189-469f-5cb3a0140b8c@opensynergy.com>
 <0cc8007b70f4f5984223703313730d8e066006a7.camel@linux.intel.com>
 <20191112110937.GA4187507@lophozonia>
 <0c5939ad0b330bc4f42d63536340293745dce728.camel@linux.intel.com>
 <20191112160554.GA16008@lophozonia>
 <4ca16fb1d412bc92a2a65104680282b80742f6b1.camel@linux.intel.com>
 <ee52234e-6b53-1f2a-563f-c3dd50dd1764@opensynergy.com>
 <21039a042ad38302e9dc9010014223d915704b91.camel@linux.intel.com>
 <07b9804d-2c20-9ff4-a375-2c65f1d27f63@opensynergy.com>
 <20191121090403.6vjnovlru4zrmzzs@sirius.home.kraxel.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <84fb109c-1d1e-a52c-8efa-8dcd00b864b3@opensynergy.com>
Date: Thu, 21 Nov 2019 13:57:51 +0100
MIME-Version: 1.0
In-Reply-To: <20191121090403.6vjnovlru4zrmzzs@sirius.home.kraxel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: Gerd Hoffmann <kraxel@redhat.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Again, thank you all for your valuable comments! There were quite a lot of
suggestions, so I briefly gathered all of them.


Feature bits
------------

VIRTIO_SND_F_PCM_OUTPUT
VIRTIO_SND_F_PCM_INPUT

and new ones would be

VIRTIO_SND_F_PCM_EVT_PERIOD - support elapsed period notifications
VIRTIO_SND_F_PCM_EVT_XRUN - support underrun/overrun notifications
VIRTIO_SND_F_PCM_MSG - support message-based data transport
VIRTIO_SND_F_PCM_HOST_MEM - support sharing host memory with guest
VIRTIO_SND_F_PCM_GUEST_MEM - support sharing guest memory with host

Not sure about correct naming here.

By the way, Liam mentioned something about using PCI BARs for mapping host=
=20
memory. Does it mean, that some features will be transport-specific?
What about virtio mmio?


Virtqueues
----------

As Gerd explained, we need 4 virtqueues in total:

1. control queue (guest->host: commands)
2. events queue (host->guest: notifications)
3. tx queue (guest->host: playback)
4. rx queue (host->guest: capture)

The first one always exists, but all other depend on feature bits. Should w=
e
check and assign these in some pre-defined order?


Configuration space
-------------------

We talked about PCM formats defined in ALSA. In Linux kernel v5.4-rc8 we ha=
ve

SNDRV_PCM_FORMAT_S8
SNDRV_PCM_FORMAT_U8
SNDRV_PCM_FORMAT_S16
SNDRV_PCM_FORMAT_U16
SNDRV_PCM_FORMAT_S24
SNDRV_PCM_FORMAT_U24
SNDRV_PCM_FORMAT_S32
SNDRV_PCM_FORMAT_U32
SNDRV_PCM_FORMAT_FLOAT
SNDRV_PCM_FORMAT_FLOAT64
SNDRV_PCM_FORMAT_IEC958_SUBFRAME
SNDRV_PCM_FORMAT_MU_LAW
SNDRV_PCM_FORMAT_A_LAW
SNDRV_PCM_FORMAT_IMA_ADPCM
SNDRV_PCM_FORMAT_MPEG
SNDRV_PCM_FORMAT_GSM
SNDRV_PCM_FORMAT_S20
SNDRV_PCM_FORMAT_U20
SNDRV_PCM_FORMAT_S24_3
SNDRV_PCM_FORMAT_U24_3
SNDRV_PCM_FORMAT_S20_3
SNDRV_PCM_FORMAT_U20_3
SNDRV_PCM_FORMAT_S18_3
SNDRV_PCM_FORMAT_U18_3
SNDRV_PCM_FORMAT_G723_24
SNDRV_PCM_FORMAT_G723_24_1B
SNDRV_PCM_FORMAT_G723_40
SNDRV_PCM_FORMAT_G723_40_1B
SNDRV_PCM_FORMAT_DSD_U8
SNDRV_PCM_FORMAT_DSD_U16
SNDRV_PCM_FORMAT_DSD_U32

Do we really need all of them? And I skipped endianess, but should we care
about it as well?

It also affects how large configuration space should be.


PCM control requests
--------------------

There were comments about having additional request for freeing resources
on device side and regarding invalid command sequences. Maybe it's better t=
o
define kind of state machine and describe what is expected from device and
driver at every state/transition? It will help to define valid command
sequences as well.

Common control message structure will be explicitly splitted into two

struct virtio_snd_ctl_req {
     le32 type;
     u8 payload[];
};

struct virtio_snd_ctl_rsp {
     le32 status;
     u8 payload[];
};

and the SET_FORMAT request will be replaced with the SET_PARAMS

struct virtio_snd_pcm_set_params {
     struct virtio_snd_pcm_hdr hdr;
     le32 channels;
     le32 format;
     le32 rate;
     le32 period_size;
};

We only need to decide units for the period_size field (frames or bytes).


PCM notifications
-----------------

I think all types of notification (two at the moment) could be described
by single structure:

enum {
     VIRTIO_SND_PCM_EVT_PERIOD,
     VIRTIO_SND_PCM_EVT_XRUN
};

struct virtio_snd_event {
     le32 type; // VIRTIO_SND_PCM_EVT_XXX
};

It's unclear whether it requires some payload or not.


PCM I/O requests
--------------------

As we get rid of multiplexing, we don't need a header anymore. And a messag=
e
will have only status

struct virtio_snd_pcm_status {
     le32 status;
     le32 actual_length;
};



Hope, I didn't forget anything.


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
Gesch=E4ftsf=FChrer/Managing Director: Regis Adjamah

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

