Return-Path: virtio-dev-return-6279-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6CADD986111
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Nov 2019 13:37:18 +0000 (UTC)
References: <20190924144323.4590-1-Mikhail.Golubev@opensynergy.com>
 <6a4978e85505ae00ca9e2b170f5e893a064c03d2.camel@linux.intel.com>
 <568f32dc-8d82-a189-469f-5cb3a0140b8c@opensynergy.com>
 <5ab80b22-8183-b885-6cf3-65ce5ada7ebd@opensynergy.com>
 <20191029121810.GB5253@sirena.co.uk>
 <1c0ff8aa-84e7-a574-11f5-bfd4be36d873@opensynergy.com>
 <20191030121137.GC6693@sirena.co.uk>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <4440d22e-75fa-fb70-26d1-daf1f2f16fca@opensynergy.com>
Date: Fri, 1 Nov 2019 14:37:12 +0100
MIME-Version: 1.0
In-Reply-To: <20191030121137.GC6693@sirena.co.uk>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 30.10.2019 13:11, Mark Brown wrote:
> On Tue, Oct 29, 2019 at 02:16:04PM +0100, Anton Yakovlev wrote:
>> On 29.10.2019 13:18, Mark Brown wrote:
>>> On Tue, Oct 29, 2019 at 11:14:52AM +0100, Anton Yakovlev wrote:
>>>> On 28.10.2019 17:05, Liam Girdwood wrote:
>=20
>>>>> What about buffer and period size capabilities ?
>=20
>>>> In this specification we assume that buffer size is up to guest decisi=
on.
>>>> Also, period size is ALSA-only conception and should not be mentioned =
here
>>>> at all (we are not stick only to ALSA).
>=20
>>> Period size isn't just an ALSA thing - it's a widely supported and used
>>> hardware feature.  When using a ring buffer (or just sending large
>>> amounts of data at once, but mainly ring buffers) it is useful to know
>>> how the hardware is progressing through the data without having to use
>>> CPU timers (which may not be well synced with the audio clock), the
>>> period interrupts do that.
>=20
>> Periods here are kind of notification frequency, right? It's supposed to=
 be
>> used for sending notifications to driver?
>=20
> Yes, the driver gets a notification every time the hardware makes it
> through a periodn of data.

If a device implementation has reliable way to receive and forward such=20
notifications to a driver, then it's fine. The reason why we didn't add thi=
s=20
to the spec is because usually a device interacts with or implements by its=
elf=20
some kind of software mixer. And all communications with real hardware are =

hidden behind multiple abstraction layers. In such case, it's either very=20
difficult or even impossible to map period-based notifications to whatever =
a=20
sw mixer provides to its clients.

Perhaps it could be an optional feature.


>>>>>> +struct virtio_snd_pcm_xfer {
>>>>>> +    le32 stream;
>>>>>> +    u8 data[];
>>>>>> +    le32 status;
>>>>>> +    le32 actual_length;
>=20
>>>>> Not following this, is actual_length the size of data[]. If so, it mu=
st
>>>>> preceed data[].
>=20
>>>> No, the actual_length field is supposed to be used by device side to r=
eport
>>>> actual amount of bytes read from/written to a buffer. In real world
>>>> scenario, if an I/O request contains N bytes, a device can play/captur=
e *up
>>>> to* N bytes. Thus, it's required to report this length back to a drive=
r.
>=20
>>> So really there's two structs here, a header struct with just stream in
>>> it and then a tail struct with the length and status information which
>>> the consumer locates by looking at the end of the buffer and working
>>> backwards?
>=20
>> Yes, it is. Since both these structures are coupled together and must be
>> sent at the same time, in spec they are represented as one "structure".
>=20
> OK...  that is a fairly weird and confusing way of writing things.

Not sure, how to describe this in context of the specification in a better =
way.


>>>> Since xrun conditions are higher level conceptions, we decided to dele=
gate
>>>> such issues to guest application itself. It helps to make overall desi=
gn
>>>> simpler. And it seems there's not so much we can do if xrun condition =
is
>>>> happened on the device side.
>=20
>>> I'm not so sure about that - in a message based system I would expect
>>> the device side to be able to at least say "I am throwing away data" for
>>> cases where it's arriving too fast to be consumed and the device ran out
>>> of buffer space, and ideally also say if it underflows.  It's more of a
>>> high level concept with free running ring buffers where the device can
>>> just happily keep reading to or writing from the buffer regardless of if
>>> the host is paying attention to it.
>=20
>> That's the point. The spec describes a device. Device is supposed just to
>> read from/write to hardware buffer regardless of its content.
>=20
> The rate at which data is consumed or produced in an audio system is
> driven by the audio hardware.  This is very likely to not be synced to
> other clock domains in the system so users are reliant on the hardware
> to drive the rate at which data is driven through the system and hence
> need support from it for figuring out the rate to transfer data and
> handle any problems that occur.  Good error reporting is a part of that,
> it makes it much easier to diagnose problems if you can get a direct
> and clear report of what went wrong rather than having to for example
> listen to the audio and work back from that.  Like I say this is
> especially true with a message based system where software has less
> visibility of how the hardware is progressing through the buffer.

Yes, it's true. And it's not like we against having error reporting. The=20
problem is there's no deterministic way how to treat such errors in pv-solu=
tion.

It's like with periods discussed above. If a device is a native=20
ALSA-application and talks directly with hardware in exclusive mode, then i=
t's=20
capable to signal actual underflow/overflow condition reported by ALSA laye=
r.=20
But if a device is a client of sw mixer server, then reported error might b=
e=20
server-specific (like "underflow" means, that server's queue is empty, but =

real hardware buffer still might contain 10ms or 50ms of frames for playbac=
k;=20
i.e. guest application probably has enough time to provide new data).

I would say it's an issue with mixing together driver and device context,=20
where driver context is always predictable, but device' - not. And sometime=
s=20
it can lead to unexpected behavior.

At the end, the main source of xrun conditions is delayed execution of a=20
virtual machine or an application in it (like double scheduling and so on).
And 44100Hz is still ~44100 frames per seconds. After different experiments=
,=20
we decided just to stick to simpler design.

Again, it could be an optional feature if device has reliable source of err=
or=20
notifications.


>> Also, the main problems with xrun is what to do with this information? L=
et's
>> assume that device can report something like "I'm going to run out of fr=
ames
>> for playback soon" or "I have no more frames for playback", then what? In
>> low latency scenario, user space application will provide small chunks of
>> data. It means, hardware buffer will be empty in like 95% of cases. And =
the
>> only thing driver can do is somehow indicate xrun to upper layer (which =
will
>> be not true from application point's of view, if hardware pointer has not
>> crossed application pointer yet in ALSA). I.e. exactly the same result,
>> where there's no notification from the device side.
>=20
> Error handling is the application's problem, usually it will either give
> up entirely or restart the stream.  Restarting is useful since if you've
> got a situation where clocks have drifted apart what'll often happen is
> that you'll get constant glitches which are extremely distracting to
> users, when you restart the drift gets reset and things will be OK for
> as long as it takes for drift to reaccumilate.  Obviously that's not
> great and the system should be trying to avoid it but it's at least
> mitigation and like I say the explicit notification that something went
> wrong can be very helpful in diagnosing problems.

Yes, I agree. I described our concerns in a comment above.


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

