Return-Path: virtio-dev-return-6271-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 76667985D46
	for <virtio-dev@lists.oasis-open.org>; Tue, 29 Oct 2019 17:04:11 +0000 (UTC)
References: <20190924144323.4590-1-Mikhail.Golubev@opensynergy.com>
 <6a4978e85505ae00ca9e2b170f5e893a064c03d2.camel@linux.intel.com>
 <568f32dc-8d82-a189-469f-5cb3a0140b8c@opensynergy.com>
 <5ab80b22-8183-b885-6cf3-65ce5ada7ebd@opensynergy.com>
 <20191029121810.GB5253@sirena.co.uk>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <1c0ff8aa-84e7-a574-11f5-bfd4be36d873@opensynergy.com>
Date: Tue, 29 Oct 2019 14:16:04 +0100
MIME-Version: 1.0
In-Reply-To: <20191029121810.GB5253@sirena.co.uk>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 29.10.2019 13:18, Mark Brown wrote:
> On Tue, Oct 29, 2019 at 11:14:52AM +0100, Anton Yakovlev wrote:
>> On 28.10.2019 17:05, Liam Girdwood wrote:
>>> On Tue, 2019-09-24 at 15:43 +0100, Mikhail Golubev wrote:
>=20
>>>> +    VIRTIO_SND_PCM_RATE_8000 =3D 0,
>>>> +    VIRTIO_SND_PCM_RATE_11025,
>>>> +    VIRTIO_SND_PCM_RATE_16000,
>>>> +    VIRTIO_SND_PCM_RATE_22050,
>>>> +    VIRTIO_SND_PCM_RATE_32000,
>>>> +    VIRTIO_SND_PCM_RATE_44100,
>>>> +    VIRTIO_SND_PCM_RATE_48000,
>>>> +    VIRTIO_SND_PCM_RATE_64000,
>>>> +    VIRTIO_SND_PCM_RATE_88200,
>>>> +    VIRTIO_SND_PCM_RATE_96000,
>>>> +    VIRTIO_SND_PCM_RATE_176400,
>>>> +    VIRTIO_SND_PCM_RATE_192000
>=20
>>> It may be best to use the same rates and format from the ALSA spec,
>>> this covers any holes (like rates that are not in the above list).
>=20
>> These rates are from ALSA definitions. And what formats should be added?
>=20
> There was one rate at the lower end which I'm not super convinced is
> useful but would be handy for making the numbers in the enum line up and
> a couple of higher rates up to 384kHz.  Those probably *are* useful for
> ultrasonic applications, you may also find some regular audio files
> encoded at that rate but most of the oversampled hifi stuff tops out at
> 192kHz.

I think, you talk about 5512Hz. If it's reasonable, two more values in enum=
 is=20
not a problem.


>>> What about buffer and period size capabilities ?
>=20
>> In this specification we assume that buffer size is up to guest decision.
>> Also, period size is ALSA-only conception and should not be mentioned he=
re
>> at all (we are not stick only to ALSA).
>=20
> Period size isn't just an ALSA thing - it's a widely supported and used
> hardware feature.  When using a ring buffer (or just sending large
> amounts of data at once, but mainly ring buffers) it is useful to know
> how the hardware is progressing through the data without having to use
> CPU timers (which may not be well synced with the audio clock), the
> period interrupts do that.

Periods here are kind of notification frequency, right? It's supposed to be=
=20
used for sending notifications to driver?


>>>> +\begin{lstlisting}
>>>> +struct virtio_snd_pcm_xfer {
>>>> +    le32 stream;
>>>> +    u8 data[];
>>>> +    le32 status;
>>>> +    le32 actual_length;
>=20
>>> Not following this, is actual_length the size of data[]. If so, it must
>>> preceed data[].
>=20
>> No, the actual_length field is supposed to be used by device side to rep=
ort
>> actual amount of bytes read from/written to a buffer. In real world
>> scenario, if an I/O request contains N bytes, a device can play/capture =
*up
>> to* N bytes. Thus, it's required to report this length back to a driver.
>=20
> So really there's two structs here, a header struct with just stream in
> it and then a tail struct with the length and status information which
> the consumer locates by looking at the end of the buffer and working
> backwards?

Yes, it is. Since both these structures are coupled together and must be se=
nt=20
at the same time, in spec they are represented as one "structure".


>>> 1) Underruns and overruns. i.e. how do we recover and resync audio
>>> between guests.
>=20
>> Since xrun conditions are higher level conceptions, we decided to delega=
te
>> such issues to guest application itself. It helps to make overall design
>> simpler. And it seems there's not so much we can do if xrun condition is
>> happened on the device side.
>=20
> I'm not so sure about that - in a message based system I would expect
> the device side to be able to at least say "I am throwing away data" for
> cases where it's arriving too fast to be consumed and the device ran out
> of buffer space, and ideally also say if it underflows.  It's more of a
> high level concept with free running ring buffers where the device can
> just happily keep reading to or writing from the buffer regardless of if
> the host is paying attention to it.

That's the point. The spec describes a device. Device is supposed just to r=
ead=20
from/write to hardware buffer regardless of its content.

Also, the main problems with xrun is what to do with this information? Let'=
s=20
assume that device can report something like "I'm going to run out of frame=
s=20
for playback soon" or "I have no more frames for playback", then what? In l=
ow=20
latency scenario, user space application will provide small chunks of data.=
 It=20
means, hardware buffer will be empty in like 95% of cases. And the only thi=
ng=20
driver can do is somehow indicate xrun to upper layer (which will be not tr=
ue=20
from application point's of view, if hardware pointer has not crossed=20
application pointer yet in ALSA). I.e. exactly the same result, where there=
's=20
no notification from the device side.


--=20
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone: +49 30 60 98 54 0
E-Mail: anton.yakovlev@opensynergy.com

www.opensynergy.com

Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 108616B
Gesch=E4ftsf=FChrer/Managing Director: Regis Adjamah

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

