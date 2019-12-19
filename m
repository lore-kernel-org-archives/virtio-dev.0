Return-Path: virtio-dev-return-6546-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B340985F44
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Dec 2019 12:54:51 +0000 (UTC)
References: <20191216130031.21912-1-Anton.Yakovlev@opensynergy.com>
 <20191217144542.5kptswa2ew4f6umi@sirius.home.kraxel.org>
 <3cb7b655-857c-d787-57fa-befd35a3fc46@opensynergy.com>
 <20191218115259.23s5ogtfi6yh4zw5@sirius.home.kraxel.org>
 <02b0c91b-6c05-7acc-dd8a-aa20953f020c@opensynergy.com>
 <20191219071740.xsjnsqrslrwkstkq@sirius.home.kraxel.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <26ac6029-73d8-d2d3-1001-534901973059@opensynergy.com>
Date: Thu, 19 Dec 2019 13:54:40 +0100
MIME-Version: 1.0
In-Reply-To: <20191219071740.xsjnsqrslrwkstkq@sirius.home.kraxel.org>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v3] virtio-snd: add virtio sound device specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 19.12.2019 08:17, Gerd Hoffmann wrote:
>    Hi,
>=20
>>> The driver can still split the data from the application into a set of
>>> smaller virtio buffers.  And this is how I would write a driver.  Creat=
e
>>> a bunch of buffers, period_bytes each, enough to cover buffer_bytes.
>>> Then go submit them, re-use them robin-round (each time the device
>>> completes a buffer re-fill and re-submit it), without a special case
>>> with one big buffer for the (playback) stream start.
>>
>> Yes, but what about device side? Most likely, it will copy the contents =
of the
>> buffer to another location and immediately complete the request (otherwi=
se it
>> is not clear when to complete).
>=20
> qemu has rather small buffers backend buffers, to keep latencies low.
> So, yes it would copy data to backend buffers.  No, it would most likely
> not copy over everything immediately.  It will most likely leave buffers
> in the virtqueue, reading the data piecewise in the audio backend timer
> callback, complete the virtio request when it has read all data.  So
> there wouldn't be a huge gap between completing the request and feeding
> the data to the host hardware.

Yes, there is a gap, and this causes the following two concerns:

1. An application can rewind its pointer and rewrite part of this buffer. T=
he
worst case is if the application rewrites the part currently being read by =
the
device.

2. This approach looks like shared memory on a smaller scale, and the whole
meaning of the messages is lost. Because sending a message assumes that wha=
t's
gone is gone.


> Another reason for this (beside keeping latencies low) is that it is a
> good idea to avoid or at least limit guest-triggered allocations on the
> host for security reasons.

Yes, that makes sense.


> While talking about latencies:  What happened to the idea to signal
> additional device latencies (backend buffering and processing ...) to
> the driver?

Yeah, such an additional latency has a runtime nature, and we could report =
it
as part of an I/O request completion. We only need to choose units (time or
bytes).


>> In addition, the driver must advance the
>> hardware position, and completing the request is the only possible place=
 to do
>> this. In most cases, all this will not coincide with the period notifica=
tion.
>=20
> So, period notification should be triggered when the device has actually
> completed processing the data (i.e. host playback finished)?  I can see
> that this can be useful.  I think qemu wouldn't be able to support that
> with the current audio backend design, but that isn't a blocker given
> this is an optional feature.  Also I think the spec should to clarify
> how period notification is supposed to work, how that relates to
> buffer completion and latencies.
>=20
>> This means that the notification itself is an optional feature that may =
or may
>> not be enabled for message-based transport.
>=20
> Which transports are expected to support that?
> If multiple transports:  Can a device signal it supports these
> notifications for one transport but not for another?

I think this does not depend on transport, but take a look at the comment
below.


>>>> I think, it's better not to set queued buffer size restrictions.
>>>
>>> Lets make it SHOULD then.
>>
>> Again, if periods are not used, then there's no period_bytes. And they a=
re not
>> used, for example, in most low-latency applications.
>>
>> (Well, technically speaking, low-latency applications in Linux must conf=
igure
>> period size for ALSA. But then they usually suppress period notification=
s and
>> send very small chunks of data, which usually do not correspond to the s=
ize of
>> the period at all.)
>=20
> So you want pass the data on to the device in whatever chunks the
> userspace application hands them to the driver?  Ok, reasonable.
>=20
> Should we define period_bytes as upper limit then, i.e. virtio buffers
> should be period_bytes or smaller?

I think, it's becoming more and more complicated and we should revise
everything.

Now we have only optional notifications (periods and xrun). But let's say,
that the device MAY send the xrun notifications and MUST send the period
notifications, and remove them from feature bits.

Then we define requirements for message-based transport:
1. the tx and rx queues are filled in with buffers having period_bytes size=
,
2. buffer_bytes % period_bytes =3D=3D 0,
3. total buffers size in the queue is buffer_bytes.

It is still not clear, when to complete playback buffers, but at least such
approach makes the driver being interrupt-driven.

Basically, it is what you said but with little changes.


> Completely different topic:  I think we should consider adding tags to
> streams.  Some background:  In qemu we have two almost identical hda
> codecs: hda-duplex and hda-micro.  The only difference is that
> hda-duplex has the input stream tagged as "line-in" and the output
> stream as "line-out", whereas hda-micro has the input channel tagged as
> "microphone" and the output channel as "speaker".  hda-micro was created
> because some windows application refused to accept "line-in" as audio
> source.  So applications clearly do care, and in case you have two input
> streams it would help applications pick a reasonable default.

Should it be a fixed-size field in the capabilities structure?


>=20
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
Gesch=C3=A4ftsf=C3=BChrer/Managing Director: Regis Adjamah

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

