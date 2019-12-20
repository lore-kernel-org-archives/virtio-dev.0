Return-Path: virtio-dev-return-6554-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CD810985F55
	for <virtio-dev@lists.oasis-open.org>; Fri, 20 Dec 2019 10:11:09 +0000 (UTC)
References: <20191216130031.21912-1-Anton.Yakovlev@opensynergy.com>
 <20191217144542.5kptswa2ew4f6umi@sirius.home.kraxel.org>
 <3cb7b655-857c-d787-57fa-befd35a3fc46@opensynergy.com>
 <20191218115259.23s5ogtfi6yh4zw5@sirius.home.kraxel.org>
 <02b0c91b-6c05-7acc-dd8a-aa20953f020c@opensynergy.com>
 <20191219071740.xsjnsqrslrwkstkq@sirius.home.kraxel.org>
 <26ac6029-73d8-d2d3-1001-534901973059@opensynergy.com>
 <20191220075315.sdnbat3hgiffwnny@sirius.home.kraxel.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <e3164aba-ceee-cb52-c580-6c0bb9bd28fa@opensynergy.com>
Date: Fri, 20 Dec 2019 11:11:03 +0100
MIME-Version: 1.0
In-Reply-To: <20191220075315.sdnbat3hgiffwnny@sirius.home.kraxel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v3] virtio-snd: add virtio sound device
 specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

On 20.12.2019 08:53, Gerd Hoffmann wrote:
>    Hi,
>=20
>>> qemu has rather small buffers backend buffers, to keep latencies low.
>>> So, yes it would copy data to backend buffers.  No, it would most likel=
y
>>> not copy over everything immediately.  It will most likely leave buffer=
s
>>> in the virtqueue, reading the data piecewise in the audio backend timer
>>> callback, complete the virtio request when it has read all data.  So
>>> there wouldn't be a huge gap between completing the request and feeding
>>> the data to the host hardware.
>>
>> Yes, there is a gap, and this causes the following two concerns:
>>
>> 1. An application can rewind its pointer and rewrite part of this buffer=
. The
>> worst case is if the application rewrites the part currently being read =
by the
>> device.
>=20
> Depends on the driver implementation.  If the driver will copy over the
> data to a buffer not visible to the userspace application this can't
> happen.  If the driver allows userspace mmap the buffer, then queues
> virtio requests with pointers to those buffers, then yes, the
> application could modify buffers which are sitting in the queue waiting
> to be processed by the device.

Yes, it seems that the protocol cannot protect against all possible problem=
s.
Let's delegate this to the device / driver implementation then.


>>> While talking about latencies:  What happened to the idea to signal
>>> additional device latencies (backend buffering and processing ...) to
>>> the driver?
>>
>> Yeah, such an additional latency has a runtime nature, and we could repo=
rt it
>> as part of an I/O request completion. We only need to choose units (time=
 or
>> bytes).
>=20
> I'd stick to bytes, for consistency with period and buffer sizes.

Great!


>> Now we have only optional notifications (periods and xrun). But let's sa=
y,
>> that the device MAY send the xrun notifications and MUST send the period
>> notifications, and remove them from feature bits.
>>
>> Then we define requirements for message-based transport:
>> 1. the tx and rx queues are filled in with buffers having period_bytes s=
ize,
>> 2. buffer_bytes % period_bytes =3D=3D 0,
>> 3. total buffers size in the queue is buffer_bytes.
>>
>> It is still not clear, when to complete playback buffers, but at least s=
uch
>> approach makes the driver being interrupt-driven.
>=20
> Period notification would be implicit (playback buffer completion) or
> explicit event queue message?

Good question. I think, for message-base transport they would be implicit,
since we will require to enqueue period_size length buffers. The only
exception here will be the end of the stream for playback.

As for shared memory, I think that they could work as an optional notificat=
ion
(as suggested earlier), and the driver should enable them using the set par=
ams
request (setting the feature bit).


> On playback buffer completion: adding a latency field to the completion
> field could solve that nicely I think.  The latency field would specify
> how long it will take until the device finishes playing that buffer.  So
> in case the device completes the buffer when playback is finished it
> would fill in "0" there.  In case the device completes the buffer after
> copying over the data to the internal buffer it would fill in the
> internal buffer size there (or maybe even the number of bytes which are
> currently used in the internal buffer).

Yes, nice idea. Then let's put it into the spec.


>>> Completely different topic:  I think we should consider adding tags to
>>> streams.  Some background:  In qemu we have two almost identical hda
>>> codecs: hda-duplex and hda-micro.  The only difference is that
>>> hda-duplex has the input stream tagged as "line-in" and the output
>>> stream as "line-out", whereas hda-micro has the input channel tagged as
>>> "microphone" and the output channel as "speaker".  hda-micro was create=
d
>>> because some windows application refused to accept "line-in" as audio
>>> source.  So applications clearly do care, and in case you have two inpu=
t
>>> streams it would help applications pick a reasonable default.
>>
>> Should it be a fixed-size field in the capabilities structure?
>=20
> Yes, a simple enum would do the trick I think.

And just reuse existing values from the HDA spec, right?


> Not sure if we want add more properties.  hda codecs can also specify
> the color coding of physical jacks (line-in is red, ...) for example.
> Probably not useful for most use cases (i.e. when sound data lands @
> pulseaudio where the user can re-route things as he wants), but it might
> be useful when a fixed physical host output is assigned to the guest.

Well, if we are gonna introduce jacks colors, then we should introduce a ja=
ck
entity itself. Like, define some kind of jack descriptor, enumerate all
available jacks for the stream, putting into the descriptor its color and
other properties, maybe allow jack hotplug/unplug, etc.


> cheers,
>    Gerd
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
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
Gesch=C3=A4ftsf=C3=BChrer/Managing Director: Regis Adjamah

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

