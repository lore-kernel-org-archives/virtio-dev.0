Return-Path: virtio-dev-return-6338-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2CF73985D53
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Nov 2019 09:26:20 +0000 (UTC)
References: <20190924144323.4590-1-Mikhail.Golubev@opensynergy.com>
 <6a4978e85505ae00ca9e2b170f5e893a064c03d2.camel@linux.intel.com>
 <568f32dc-8d82-a189-469f-5cb3a0140b8c@opensynergy.com>
 <5ab80b22-8183-b885-6cf3-65ce5ada7ebd@opensynergy.com>
 <20191029121810.GB5253@sirena.co.uk>
 <1c0ff8aa-84e7-a574-11f5-bfd4be36d873@opensynergy.com>
 <20191030121137.GC6693@sirena.co.uk>
 <4440d22e-75fa-fb70-26d1-daf1f2f16fca@opensynergy.com>
 <20191111193903.GE4264@sirena.co.uk>
 <d7bc3c70-2860-cb11-4f25-15804deecf54@opensynergy.com>
 <20191114212940.GC4664@sirena.co.uk>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <99e349c0-a8c6-a4c8-080c-da6095d4f7e1@opensynergy.com>
Date: Tue, 19 Nov 2019 10:26:11 +0100
MIME-Version: 1.0
In-Reply-To: <20191114212940.GC4664@sirena.co.uk>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 14.11.2019 22:29, Mark Brown wrote:
> On Wed, Nov 13, 2019 at 01:01:56PM +0100, Anton Yakovlev wrote:
>> On 11.11.2019 20:39, Mark Brown wrote:
>=20
>>> Can you provide examples of host systems which have interfaces that
>>> provide absolutely no timing information that can be used by
>>> applications?  It's common for systems to provide simplified interfaces
>>> for applications that have simple needs (especially "please play this
>>> track" style interfaces) but there's usually something richer there for
>>> the applications that need it.
>=20
>> Two common cases: PulseAudio and QEmu. PA has some timing info, but it
>> states clear that it's "rough estimations".
>=20
> PA does a lot better than it claims, and bear in mind that the PA
> specific APIs are simplified ones and it does expose emulations of far
> richer interfaces.

Yes, certainly, PA itself is pretty good.


>>                                              QEmu provides nothing in th=
is
>> regard. And it's understandable, since they need to provide some unified
>> API/strategy to clients while hiding details of actual backends (that co=
uld
>> be a PCM device, bluetooth, network, whatever).
>=20
> My understanding was that QEmu emulated some regular sound hardware?

Yes, it is. And all emulated sound hardware communicate with built-in QEmu=
=20
audio mixer.


>>>> Yes, it's true. And it's not like we against having error reporting. T=
he
>>>> problem is there's no deterministic way how to treat such errors in
>>>> pv-solution.
>=20
>>> I think you are being overly pessimistic about what is posible and not
>>> providing any room for better quality of implementation.  I'm not seein=
g
>>> how a virtualized system is that different to an application running
>>> with a sound server.
>=20
>> That's why we needed discussion. It makes little sense to put something =
that
>> you are not sure into a public spec.
>=20
> OK.
>=20
>>>> It's like with periods discussed above. If a device is a native
>>>> ALSA-application and talks directly with hardware in exclusive mode, t=
hen
>>>> it's capable to signal actual underflow/overflow condition reported by=
 ALSA
>>>> layer. But if a device is a client of sw mixer server, then reported e=
rror
>>>> might be server-specific (like "underflow" means, that server's queue =
is
>>>> empty, but real hardware buffer still might contain 10ms or 50ms of fr=
ames
>>>> for playback; i.e. guest application probably has enough time to provi=
de new
>>>> data).
>=20
>>> You're describing a quality of implementation issue there, if something
>>> is indicating that it's underlowed when it has not in fact underflowed
>>> then it's buggy.
>=20
>> Not necessary. It may implement its own workflow. And if our terms do no=
t
>> align with their, it does not necessary mean they have buggy anything.
>=20
> To me it's about what the spec says - if the spec says X and you do Y
> then that's quality of implementation.  There can definitely be issues
> translating the spec language into something that's useful in the
> context of the specific implementation but that's a normal part of
> interacting with a spec.

In that regards yes, you are right. We just talked about features that coul=
d=20
be useful in one particular case and totally useless in another one.


>>>> At the end, the main source of xrun conditions is delayed execution of=
 a
>>>> virtual machine or an application in it (like double scheduling and so=
 on).
>>>> And 44100Hz is still ~44100 frames per seconds. After different experi=
ments,
>>>> we decided just to stick to simpler design.
>=20
>>> People are more than capable of writing software which has trouble even
>>> without any involvement from virtualization!  Applications like VoIP,
>>> music production and gaming frequently try to push latencies very low.
>=20
>>> I'm not sure what you mean by experiments here but I don't really see
>>> how they are relevant here, obviously if the system is working well the=
n
>>> none of this will come up - under and overflow are about situations
>>> where things go wrong.
>=20
>> I meant, what did work good enough and what not.
>=20
> I see.  Part of my pessimism about the need for error handling here is
> that there's a great deal of quality variation in audio hardware and
> software out there so lots of potential for things to not behave as
> expected when put under stress.  Adding a virtualization layer seems
> like the sort of stress that might cause problems, hopefully not but it
> seems better to at least have the facilities in the spec so it's easier
> to resolve any problems that do come up.

Good, I will summarize all the points from our discussion and we will decid=
e=20
how to improve current spec draft.


>>>> Again, it could be an optional feature if device has reliable source o=
f
>>>> error notifications.
>=20
>>> Right now there is no option to provide the feature.
>=20
>> It's under discussion right now.
>=20
> Ah, I see - I may be confused about the process, I saw a call for votes
> which looked like things were pretty final.

We had no comments for quite a long time. And it looked like the spec is re=
ady.


--=20
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone: +49 30 60 98 54 0
E-Mail: anton.yakovlev@opensynergy.com

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

