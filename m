Return-Path: virtio-dev-return-6332-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F2B55985F6F
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Nov 2019 12:02:02 +0000 (UTC)
References: <20190924144323.4590-1-Mikhail.Golubev@opensynergy.com>
 <6a4978e85505ae00ca9e2b170f5e893a064c03d2.camel@linux.intel.com>
 <568f32dc-8d82-a189-469f-5cb3a0140b8c@opensynergy.com>
 <5ab80b22-8183-b885-6cf3-65ce5ada7ebd@opensynergy.com>
 <20191029121810.GB5253@sirena.co.uk>
 <1c0ff8aa-84e7-a574-11f5-bfd4be36d873@opensynergy.com>
 <20191030121137.GC6693@sirena.co.uk>
 <4440d22e-75fa-fb70-26d1-daf1f2f16fca@opensynergy.com>
 <20191111193903.GE4264@sirena.co.uk>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <d7bc3c70-2860-cb11-4f25-15804deecf54@opensynergy.com>
Date: Wed, 13 Nov 2019 13:01:56 +0100
MIME-Version: 1.0
In-Reply-To: <20191111193903.GE4264@sirena.co.uk>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 11.11.2019 20:39, Mark Brown wrote:
> On Fri, Nov 01, 2019 at 02:37:12PM +0100, Anton Yakovlev wrote:
>> On 30.10.2019 13:11, Mark Brown wrote:
>>> On Tue, Oct 29, 2019 at 02:16:04PM +0100, Anton Yakovlev wrote:
>=20
>>>> Periods here are kind of notification frequency, right? It's supposed =
to be
>>>> used for sending notifications to driver?
>=20
>>> Yes, the driver gets a notification every time the hardware makes it
>>> through a periodn of data.
>=20
>> If a device implementation has reliable way to receive and forward such
>> notifications to a driver, then it's fine. The reason why we didn't add =
this
>> to the spec is because usually a device interacts with or implements by
>> itself some kind of software mixer. And all communications with real
>> hardware are hidden behind multiple abstraction layers. In such case, it=
's
>> either very difficult or even impossible to map period-based notificatio=
ns
>> to whatever a sw mixer provides to its clients.
>=20
> Can you provide examples of host systems which have interfaces that
> provide absolutely no timing information that can be used by
> applications?  It's common for systems to provide simplified interfaces
> for applications that have simple needs (especially "please play this
> track" style interfaces) but there's usually something richer there for
> the applications that need it.

Two common cases: PulseAudio and QEmu. PA has some timing info, but it stat=
es=20
clear that it's "rough estimations". QEmu provides nothing in this regard. =
And=20
it's understandable, since they need to provide some unified API/strategy t=
o=20
clients while hiding details of actual backends (that could be a PCM device=
,=20
bluetooth, network, whatever).


>>>>>> No, the actual_length field is supposed to be used by device side to=
 report
>>>>>> actual amount of bytes read from/written to a buffer. In real world
>>>>>> scenario, if an I/O request contains N bytes, a device can play/capt=
ure *up
>>>>>> to* N bytes. Thus, it's required to report this length back to a dri=
ver.
>=20
>>>>> So really there's two structs here, a header struct with just stream =
in
>>>>> it and then a tail struct with the length and status information whic=
h
>>>>> the consumer locates by looking at the end of the buffer and working
>>>>> backwards?
>=20
>>>> Yes, it is. Since both these structures are coupled together and must =
be
>>>> sent at the same time, in spec they are represented as one "structure"=
.
>=20
>>> OK...  that is a fairly weird and confusing way of writing things.
>=20
>> Not sure, how to describe this in context of the specification in a bett=
er way.
>=20
> "The start of the data will be this struct, the end of the data will be
> that struct".

Good, we will re-phrase this sentence. Thanks.


>>>> That's the point. The spec describes a device. Device is supposed just=
 to
>>>> read from/write to hardware buffer regardless of its content.
>=20
>>> The rate at which data is consumed or produced in an audio system is
>>> driven by the audio hardware.  This is very likely to not be synced to
>>> other clock domains in the system so users are reliant on the hardware
>>> to drive the rate at which data is driven through the system and hence
>>> need support from it for figuring out the rate to transfer data and
>>> handle any problems that occur.  Good error reporting is a part of that=
,
>>> it makes it much easier to diagnose problems if you can get a direct
>>> and clear report of what went wrong rather than having to for example
>>> listen to the audio and work back from that.  Like I say this is
>>> especially true with a message based system where software has less
>>> visibility of how the hardware is progressing through the buffer.
>=20
>> Yes, it's true. And it's not like we against having error reporting. The
>> problem is there's no deterministic way how to treat such errors in
>> pv-solution.
>=20
> I think you are being overly pessimistic about what is posible and not
> providing any room for better quality of implementation.  I'm not seeing
> how a virtualized system is that different to an application running
> with a sound server.

That's why we needed discussion. It makes little sense to put something tha=
t=20
you are not sure into a public spec.


>> It's like with periods discussed above. If a device is a native
>> ALSA-application and talks directly with hardware in exclusive mode, the=
n
>> it's capable to signal actual underflow/overflow condition reported by A=
LSA
>> layer. But if a device is a client of sw mixer server, then reported err=
or
>> might be server-specific (like "underflow" means, that server's queue is
>> empty, but real hardware buffer still might contain 10ms or 50ms of fram=
es
>> for playback; i.e. guest application probably has enough time to provide=
 new
>> data).
>=20
> You're describing a quality of implementation issue there, if something
> is indicating that it's underlowed when it has not in fact underflowed
> then it's buggy.

Not necessary. It may implement its own workflow. And if our terms do not=
=20
align with their, it does not necessary mean they have buggy anything.


> In the above scenario it really depends if the server is able to edit
> the already rendered buffer, if the server is able to edit the data it
> shouldn't be reporting an underflow yet while if it is not then the
> audio will glitch and there has in fact been an underflow (and the
> server side rendering buffer already used a good chunk of the latency
> for many applications).
>=20
>> At the end, the main source of xrun conditions is delayed execution of a
>> virtual machine or an application in it (like double scheduling and so o=
n).
>> And 44100Hz is still ~44100 frames per seconds. After different experime=
nts,
>> we decided just to stick to simpler design.
>=20
> People are more than capable of writing software which has trouble even
> without any involvement from virtualization!  Applications like VoIP,
> music production and gaming frequently try to push latencies very low.
>=20
> I'm not sure what you mean by experiments here but I don't really see
> how they are relevant here, obviously if the system is working well then
> none of this will come up - under and overflow are about situations
> where things go wrong.

I meant, what did work good enough and what not.


>> Again, it could be an optional feature if device has reliable source of
>> error notifications.
>=20
> Right now there is no option to provide the feature.

It's under discussion right now.


--=20
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

