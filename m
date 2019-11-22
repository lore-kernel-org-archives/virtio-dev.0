Return-Path: virtio-dev-return-6381-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D0591985EB2
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Nov 2019 13:46:48 +0000 (UTC)
References: <0cc8007b70f4f5984223703313730d8e066006a7.camel@linux.intel.com>
 <20191112110937.GA4187507@lophozonia>
 <0c5939ad0b330bc4f42d63536340293745dce728.camel@linux.intel.com>
 <20191112160554.GA16008@lophozonia>
 <4ca16fb1d412bc92a2a65104680282b80742f6b1.camel@linux.intel.com>
 <ee52234e-6b53-1f2a-563f-c3dd50dd1764@opensynergy.com>
 <21039a042ad38302e9dc9010014223d915704b91.camel@linux.intel.com>
 <07b9804d-2c20-9ff4-a375-2c65f1d27f63@opensynergy.com>
 <20191121090403.6vjnovlru4zrmzzs@sirius.home.kraxel.org>
 <84fb109c-1d1e-a52c-8efa-8dcd00b864b3@opensynergy.com>
 <20191122071954.2ar6u3jwwn7yutjt@sirius.home.kraxel.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <770a5ce0-ba97-df47-5d65-67404b7e1bf6@opensynergy.com>
Date: Fri, 22 Nov 2019 14:46:43 +0100
MIME-Version: 1.0
In-Reply-To: <20191122071954.2ar6u3jwwn7yutjt@sirius.home.kraxel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 22.11.2019 08:19, Gerd Hoffmann wrote:
>> Feature bits
>> ------------
>>
>> VIRTIO_SND_F_PCM_OUTPUT
>> VIRTIO_SND_F_PCM_INPUT
>>
>> and new ones would be
>>
>> VIRTIO_SND_F_PCM_EVT_PERIOD - support elapsed period notifications
>> VIRTIO_SND_F_PCM_EVT_XRUN - support underrun/overrun notifications
>> VIRTIO_SND_F_PCM_MSG - support message-based data transport
>> VIRTIO_SND_F_PCM_HOST_MEM - support sharing host memory with guest
>> VIRTIO_SND_F_PCM_GUEST_MEM - support sharing guest memory with host
>>
>> Not sure about correct naming here.
>=20
> Hmm, I think at least parts of this should be device configuration not
> feature bits ...
>=20
> Instead of PCM_OUTPUT and PCM_INPUT I would put the number of input and
> output streams into the device config space (and explicitly allow count
> being zero).

There are several options for the number of streams:

1. The device can provide one input and/or output stream.
2. The device can provide several input and/or output streams, and all of t=
hem
share the same capabilities.
3. The device can provide several input and/or output streams, and they can
have different set of capabilities.

Overall design depends on chosen option. Current draft is based on p.1. But=
 we
have never discussed what is the best solution here.


> PCM_EVT_* probably makes sense to be a per-stream configuration bit.

Yes, it definitely makes sense.


> PCM_MSG -- I would drop the feature bit and make that mandatory, so we
> have a common baseline on which all drivers and devices can agree on.

Then we need to inform device what "transport" will be in use (I assumed it
would be feature negotiation).


>> By the way, Liam mentioned something about using PCI BARs for mapping ho=
st
>> memory. Does it mean, that some features will be transport-specific?
>=20
> In the latest spec revision virtio got support for shared memory
> regions.  This should be used for VIRTIO_SND_F_PCM_HOST_MEM.
>=20
>> What about virtio mmio?
>=20
> Right now this is defined for the pci transport only.

And now we only declare a feature bit, right?


>> Virtqueues
>> ----------
>>
>> As Gerd explained, we need 4 virtqueues in total:
>>
>> 1. control queue (guest->host: commands)
>> 2. events queue (host->guest: notifications)
>> 3. tx queue (guest->host: playback)
>> 4. rx queue (host->guest: capture)
>>
>> The first one always exists, but all other depend on feature bits. Shoul=
d we
>> check and assign these in some pre-defined order?
>=20
> I'd suggest to make them all mandatory.

Yes, it would be the simplest solution.


>> Configuration space
>> -------------------
>>
>> We talked about PCM formats defined in ALSA. In Linux kernel v5.4-rc8 we=
 have
>>
>> Do we really need all of them? And I skipped endianess, but should we ca=
re
>> about it as well?
>=20
> I'd keep the list as short as possible.  The formats listed in the patch
> looked like a good start.

It was proposed to have all non-compressed formats.

And... do we care about cross-endian cases?


>> It also affects how large configuration space should be.
>=20
> I'd make the format bitfield 64bit no matter what.  It doesn't cost much
> and it leaves room to extend things without hassle if needed.

Good, then it will be le64.


>> Common control message structure will be explicitly splitted into two
>>
>> struct virtio_snd_ctl_req {
>>      le32 type;
>        le32 stream_id;
>>      u8 payload[];
>> };
>=20
>> and the SET_FORMAT request will be replaced with the SET_PARAMS
>>
>> struct virtio_snd_pcm_set_params {
>>      struct virtio_snd_pcm_hdr hdr;
>>      le32 channels;
>>      le32 format;
>>      le32 rate;
>>      le32 period_size;
>> };
>>
>> We only need to decide units for the period_size field (frames or bytes)=
.
>=20
> I'd suggest bytes (and rename the field to period_bytes).

Okey.


>> PCM I/O requests
>> --------------------
>>
>> As we get rid of multiplexing, we don't need a header anymore.
>=20
> What if a device wants support two playback streams (possibly even with
> different features, say one stereo and one 5:1)?

We need to make a design choice (see comment above).


>> And a message
>> will have only status
>>
>> struct virtio_snd_pcm_status {
>>      le32 status;
>>      le32 actual_length;
>> };
>=20
> Hmm.  Why actual_length?  Do we want allow short transfers?  Why?
> Wouldn't it be more useful to just fill the buffer completely?

In current design we have no buffer size requirements. It means, that in
theory the device and the driver could have buffers with different sizes.

Also, the capture stream is a special case. Now we don't state explicitly
whether read request is blockable or not. And if the device complete it=20
immediately, the request could contain less frames than was expected by the
driver.

> cheers,
>    Gerd
>=20
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
Gesch=E4ftsf=FChrer/Managing Director: Regis Adjamah

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

