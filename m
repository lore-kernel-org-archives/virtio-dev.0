Return-Path: virtio-dev-return-5717-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AB9E8985B4A
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 May 2019 19:52:14 +0000 (UTC)
References: <abe4bd97-8010-8fd0-8ded-f9e847a4fdb3@13byte.com>
 <20190429134754.GI7587@stefanha-x1.localdomain>
 <4fcd7456-de22-7f6d-d5ef-939cd3d7cf95@13byte.com>
 <20190501170525.GB22391@stefanha-x1.localdomain>
 <c74aebe9-5db4-902f-ef0b-f0a786806acd@13byte.com>
 <20190503164501.GB8373@stefanha-x1.localdomain>
From: Marco Martinelli - 13Byte srl <marco@13byte.com>
Message-ID: <863e1be1-11cc-816b-896d-3954427e98f3@13byte.com>
Date: Fri, 3 May 2019 21:52:10 +0200
MIME-Version: 1.0
In-Reply-To: <20190503164501.GB8373@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


Il 03/05/19 18:45, Stefan Hajnoczi ha scritto:
> On Thu, May 02, 2019 at 01:18:40PM +0200, Marco Martinelli - 13Byte srl w=
rote:
>> Il 01/05/19 19:05, Stefan Hajnoczi ha scritto:
>>
>>> On Mon, Apr 29, 2019 at 07:39:17PM +0200, Marco Martinelli - 13Byte srl=
 wrote:
>>>> Il 29/04/19 15:47, Stefan Hajnoczi ha scritto:
>>>>> On Mon, Apr 29, 2019 at 12:22:41AM +0200, Marco Martinelli - 13Byte s=
rl wrote:
>>>>>> I'm not sure how this works, is that number already assigned and I s=
hould
>>>>>> use that or should I get a new one?
>>>>>>
>>>>>> For last, I have a question to clear the things up for me. It is my
>>>>>> understanding that in this mailing list you discuss about the
>>>>>> specifications, not the actual code. What's the usual process when w=
riting a
>>>>>> new virtio device?
>>>>>> Should I start with writing the code and then document how it works =
or is it
>>>>>> the opposite? Should I document it and have it approved and then imp=
lement
>>>>>> the specifications?
>>>>>>
>>>>>> I know that this may sound like a stupid question, but please be pat=
ient
>>>>>> with me, it's my first time.
>>>>> I suggest posting a draft specification for the new device type before
>>>>> investing too much time in the implementation.
>>>>>
>>>>> Then work on the code while the spec discussion is ongoing.  This way
>>>>> you won't have to wait too long before implementation but you also wo=
n't
>>>>> find that reviewers are asking for large changes after you completed
>>>>> your work.
>>>> I feared that would be the answer.
>>>> As I stated I'm not familiar with most of the technologies involved. I=
 don't
>>>> know if I have the capabilities to write a draft of the specifications
>>>> without first working on some code to clear things up.
>>>> I'll try my best.
>>> I'm happy to help you get started.
>>>
>>> I have a basic understanding of sound cards (mostly from an audio API
>>> and application perspective) and can explain the virtio device model.
>>>
>>> Please post the requirements and scope of the device you'd like to
>>> create.  Are you thinking of something general-purpose like the USB
>>> Audio Device Class specification, which can handle many different types
>>> of devices.  Or were you thinking of something more limited?
>>>
>>> In terms of virtio concepts, audio streams would be transferred in
>>> chunks over virtqueues.  A "control" virtqueue might be necessary to
>>> configure the device.  It would process configuration request/response
>>> packets.
>>>
>>> Stefan
>> Hi Stefan,
>>
>> thank you for your offer.
>>
>> I'll explain what I have in mind.
> Thanks.  Some random thoughts (not strong opinions) below:
>
>> The scope of my project is to transfer a multichannel PCM stream from th=
e VM
>> to the host and another the other way.
>>
>> The VM will see this transport interface like a generic soundcard with
>> configurable input / output.
>>
>> Both windows and alsa work with PCM internally and it's not a problem to
>> feed the stream of one to the other, keeping in mind that channel mapping
>> may vary.
>> I'm not aware of systems where PCM isn't used, I don't expect problems w=
ith
>> this.
>>
>> In Scream ( https://github.com/duncanthrax/scream ) I've used IVSHMEM as=
 a
>> ring buffer. That worked very well, it reduced the latency and improved =
the
>> performances quite a bit over the original network protocol, but it's one
>> way only (windows VM to linux host) and not as fast as it can be with vi=
rtio
>> I think.
>>
>> My idea is to have a device configuration layout where both the host and=
 the
>> guest can expose their current audio configuration, more or less like th=
is.
>>
>> struct virtio_audio_config {
>>  =A0=A0=A0=A0=A0=A0=A0 le32 sample_rate;=A0=A0=A0=A0=A0 //from 8000Hz up=
 to 192000Hz
>>  =A0=A0=A0=A0=A0=A0=A0 le8=A0 sample_size;=A0=A0=A0=A0=A0 //8bit, 16bit,=
 32bit or floating point
>>  =A0=A0=A0=A0=A0=A0=A0 le8=A0 channels;=A0=A0=A0=A0=A0=A0=A0=A0 //from 1=
 (mono) up to 8 (7.1 surround) or
>> even more in theory (eg. Dolby Atmos, 64 channels, or MAudio 1010, 20+
>> channels)
>>  =A0=A0=A0=A0=A0=A0=A0 le8=A0 channel_map[...]; //it's a list of constan=
ts to identify the
>> channel order in the PCM stream (eg. CH_LEFT, CH_RIGHT, CH_CENTER)
>> };
>>
>> The struct will be double, one from audio out, one for audio in. When the
>> host or the guest change it's configuration its struct should be updated=
 and
>> the other side notified.
>>
>> If the other side can't handle the configuration I'd like to figure out a
>> graceful fallback. I have a few ideas in mind but I want to do some tests
>> first.
> This does not offer a way to enumerate supported configurations.  The
> other side blindly suggests a configuration which may or may not be
> accepted.
>
> Enumeration of sample rates, channel topologies, sample formats, etc
> would allow for negotiation that works the first time and instead of
> guessing a configuration that ends up being rejected by the other side.

I agree with you on this. The reason I opted to keep it simple in my=20
description is that I have yet to clear my ideas on how to implement=20
this particular feature.

 From my previous experience with MSVAD driver I saw that the driver=20
enumerate all the possible configurations when it's initialized.

I think ALSA works in the same way but I have yet to verify this.

It's possible to enquiry the virtio-audio device about the host=20
capabilities at this time but I'm not sure how to implement this in=20
every audio backend of qemu (alsa, pulse, oss, coreaudio, dsound, ...)

Another thing to consider is that the host may have multiple sound=20
cards. For example I have three sound cards at the moment, an integrated=20
one with stereo at max 96kHZ, a dedicated one with 7.1 surround up to=20
192kHz and my video card has HDMI audio out (not sure of the specs).

What can be considered a valid configuration in this scenario?

Another possibility is that the user can configure the virtio-audio=20
device with the capabilities that he want to expose to the guest,=20
regardless if the host really support them or not. What do you think?

In this scenario the user can even setup two separate VM with one=20
virtio-audio device each and route the audio from one to another with=20
something like JACK even if the host don't support the VM configuration.=20
Anything capable of piping the stream from one VM to the other will do=20
just fine.

Another idea is that the user may want to record the stream to process=20
it later. It doesn't matter if the host audio card is not capable of=20
reproducing it. The host may not even have a sound card in this case.

Can you think of any other use case?

>
>> If the host or the guest don't support audio out they can write 0 as num=
ber
>> of channel, or zero out the entire struct during device initialization.
>> If they don't support audio input they can ignore it.
>>
>> I imagine two separate virtqueues, one for the output stream, another for
>> the input stream.
>>
>> What I want to do in the end consist in a few modules:
>> - virtio-audio specifications
>> - a new QEMU device based on the specs
>> - Windows driver for guest, based on MSVAD sample driver or SYSVAD sample
>> driver, both released under MS-PL (I'll have to figure out how to have t=
hem
>> signed and distributed, is MS-PL a problem?)
>> - ALSA driver for linux guest
> This is also what I'd imagine.
>
>> Maybe I'll focus more on audio output at first and audio input later,
>> because that's the common use case.
>>
>> This weekend I'll take the time to document this better.
>>
>> If you have any question or I was not clear let me know.
> Okay, it sounds like an audio API-level interface, not lower-level like
> what the USB Audio Device Class does.  I'm not sure if we lose any
> important functionality by choosing a high level interface.

Yes, it's not too low level, all I want is to push the PCM stream to the=20
host (or pull one if it's an input).

No channel mixing, no signal processing, .. this will be the host job.
> How would soundcards with multiple inputs work?  Is each input
> represented as a separate virtio-audio device?  The alternative is to
> use an arbitrary number of mono or stereo channel pairs...

I admit I never considered this. I always pictured one input and one=20
output with different number of channels.

I guess the simple answer is that users can attach as many virtio-audio=20
devices as they want with different configurations but I'll look around=20
to see if there is any benefit in having multiple input or output in the=20
same device.

>
> Stefan


Marco


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

