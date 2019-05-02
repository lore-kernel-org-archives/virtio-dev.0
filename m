Return-Path: virtio-dev-return-5713-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F330F986198
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 May 2019 17:54:02 +0000 (UTC)
References: <abe4bd97-8010-8fd0-8ded-f9e847a4fdb3@13byte.com>
 <20190429134754.GI7587@stefanha-x1.localdomain>
 <4fcd7456-de22-7f6d-d5ef-939cd3d7cf95@13byte.com>
 <20190501170525.GB22391@stefanha-x1.localdomain>
From: Marco Martinelli - 13Byte srl <marco@13byte.com>
Message-ID: <c74aebe9-5db4-902f-ef0b-f0a786806acd@13byte.com>
Date: Thu, 2 May 2019 13:18:40 +0200
MIME-Version: 1.0
In-Reply-To: <20190501170525.GB22391@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, kraxel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Il 01/05/19 19:05, Stefan Hajnoczi ha scritto:

> On Mon, Apr 29, 2019 at 07:39:17PM +0200, Marco Martinelli - 13Byte srl w=
rote:
>> Il 29/04/19 15:47, Stefan Hajnoczi ha scritto:
>>> On Mon, Apr 29, 2019 at 12:22:41AM +0200, Marco Martinelli - 13Byte srl=
 wrote:
>>>> I'm not sure how this works, is that number already assigned and I sho=
uld
>>>> use that or should I get a new one?
>>>>
>>>> For last, I have a question to clear the things up for me. It is my
>>>> understanding that in this mailing list you discuss about the
>>>> specifications, not the actual code. What's the usual process when wri=
ting a
>>>> new virtio device?
>>>> Should I start with writing the code and then document how it works or=
 is it
>>>> the opposite? Should I document it and have it approved and then imple=
ment
>>>> the specifications?
>>>>
>>>> I know that this may sound like a stupid question, but please be patie=
nt
>>>> with me, it's my first time.
>>> I suggest posting a draft specification for the new device type before
>>> investing too much time in the implementation.
>>>
>>> Then work on the code while the spec discussion is ongoing.  This way
>>> you won't have to wait too long before implementation but you also won't
>>> find that reviewers are asking for large changes after you completed
>>> your work.
>> I feared that would be the answer.
>> As I stated I'm not familiar with most of the technologies involved. I d=
on't
>> know if I have the capabilities to write a draft of the specifications
>> without first working on some code to clear things up.
>> I'll try my best.
> I'm happy to help you get started.
>
> I have a basic understanding of sound cards (mostly from an audio API
> and application perspective) and can explain the virtio device model.
>
> Please post the requirements and scope of the device you'd like to
> create.  Are you thinking of something general-purpose like the USB
> Audio Device Class specification, which can handle many different types
> of devices.  Or were you thinking of something more limited?
>
> In terms of virtio concepts, audio streams would be transferred in
> chunks over virtqueues.  A "control" virtqueue might be necessary to
> configure the device.  It would process configuration request/response
> packets.
>
> Stefan

Hi Stefan,

thank you for your offer.

I'll explain what I have in mind.

The scope of my project is to transfer a multichannel PCM stream from=20
the VM to the host and another the other way.

The VM will see this transport interface like a generic soundcard with=20
configurable input / output.

Both windows and alsa work with PCM internally and it's not a problem to=20
feed the stream of one to the other, keeping in mind that channel=20
mapping may vary.
I'm not aware of systems where PCM isn't used, I don't expect problems=20
with this.

In Scream ( https://github.com/duncanthrax/scream ) I've used IVSHMEM as=20
a ring buffer. That worked very well, it reduced the latency and=20
improved the performances quite a bit over the original network=20
protocol, but it's one way only (windows VM to linux host) and not as=20
fast as it can be with virtio I think.

My idea is to have a device configuration layout where both the host and=20
the guest can expose their current audio configuration, more or less=20
like this.

struct virtio_audio_config {
 =A0=A0=A0=A0=A0=A0=A0 le32 sample_rate;=A0=A0=A0=A0=A0 //from 8000Hz up to=
 192000Hz
 =A0=A0=A0=A0=A0=A0=A0 le8=A0 sample_size;=A0=A0=A0=A0=A0 //8bit, 16bit, 32=
bit or floating point
 =A0=A0=A0=A0=A0=A0=A0 le8=A0 channels;=A0=A0=A0=A0=A0=A0=A0=A0 //from 1 (m=
ono) up to 8 (7.1 surround)=20
or even more in theory (eg. Dolby Atmos, 64 channels, or MAudio 1010,=20
20+ channels)
 =A0=A0=A0=A0=A0=A0=A0 le8=A0 channel_map[...]; //it's a list of constants =
to identify=20
the channel order in the PCM stream (eg. CH_LEFT, CH_RIGHT, CH_CENTER)
};

The struct will be double, one from audio out, one for audio in. When=20
the host or the guest change it's configuration its struct should be=20
updated and the other side notified.

If the other side can't handle the configuration I'd like to figure out=20
a graceful fallback. I have a few ideas in mind but I want to do some=20
tests first.

If the host or the guest don't support audio out they can write 0 as=20
number of channel, or zero out the entire struct during device=20
initialization.
If they don't support audio input

I imagine two separate virtqueues, one for the output stream, another=20
for the input stream.

What I want to do in the end consist in a few modules:
- virtio-audio specifications
- a new QEMU device based on the specs
- Windows driver for guest, based on MSVAD sample driver or SYSVAD=20
sample driver, both released under MS-PL (I'll have to figure out how to=20
have them signed and distributed, is MS-PL a problem?)
- ALSA driver for linux guest

Maybe I'll focus more on audio output at first and audio input later,=20
because that's the common use case.

This weekend I'll take the time to document this better.

If you have any question or I was not clear let me know.


Marco


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

