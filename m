Return-Path: virtio-dev-return-6535-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 80D2C985F08
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Dec 2019 15:34:30 +0000 (UTC)
References: <20191216130031.21912-1-Anton.Yakovlev@opensynergy.com>
 <20191217144542.5kptswa2ew4f6umi@sirius.home.kraxel.org>
 <3cb7b655-857c-d787-57fa-befd35a3fc46@opensynergy.com>
 <20191218115259.23s5ogtfi6yh4zw5@sirius.home.kraxel.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <02b0c91b-6c05-7acc-dd8a-aa20953f020c@opensynergy.com>
Date: Wed, 18 Dec 2019 16:34:12 +0100
MIME-Version: 1.0
In-Reply-To: <20191218115259.23s5ogtfi6yh4zw5@sirius.home.kraxel.org>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v3] virtio-snd: add virtio sound device specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 18.12.2019 12:52, Gerd Hoffmann wrote:
>>>> +/* supported PCM stream features */
>>>> +enum {
>>>> +    VIRTIO_SND_PCM_F_HOST_MEM =3D 0,
>>>> +    VIRTIO_SND_PCM_F_GUEST_MEM,
>>>
>>> Is this useful as stream property?  I would expect when supported by a
>>> device it would work for all streams.
>>
>> Since we allowed different capabilities for different streams, now it's
>> possible to have different backends for them. I=E2=80=99m not sure how m=
uch this can
>> be a real scenario, but it is theoretically possible to have one backend=
 that
>> is able to work with shared memory, and the other is not. The same can b=
e said
>> for other stream feature bits.
>=20
> Hmm, ok.  Point.
>=20
> Independant from that they should either be a note that these two are
> nor (yet) specified and are just placeholders.  Or simply be deleted and
> re-added with the actual specification for guestmem + hostmem.

I think having a note is better.


>>>> +    VIRTIO_SND_PCM_F_EVT_PERIOD,
>>>
>>> I think this is only useful for hostmem/guestmem.
>>
>> Using message-based transport, an application can send the entire playba=
ck
>> buffer at the beginning, and then send period-sized parts on each period
>> notification.
>=20
> The driver can still split the data from the application into a set of
> smaller virtio buffers.  And this is how I would write a driver.  Create
> a bunch of buffers, period_bytes each, enough to cover buffer_bytes.
> Then go submit them, re-use them robin-round (each time the device
> completes a buffer re-fill and re-submit it), without a special case
> with one big buffer for the (playback) stream start.

Yes, but what about device side? Most likely, it will copy the contents of =
the
buffer to another location and immediately complete the request (otherwise =
it
is not clear when to complete). In addition, the driver must advance the
hardware position, and completing the request is the only possible place to=
 do
this. In most cases, all this will not coincide with the period notificatio=
n.
This means that the notification itself is an optional feature that may or =
may
not be enabled for message-based transport.

Of course, the benefits of such notifications largely depend on the
implementation of the driver. But at least people here claimed that they co=
uld
be useful.


> I still think this is not needed for message-based transport.
>=20
> Maybe this is not needed for hostmem/guestmem either.  The point of
> using shared memory is to avoid system calls and vmexits for buffer
> management, so VIRTIO_SND_PCM_F_EVT_PERIOD doesn't look that useful
> here too.  But maybe it is nice to have that as option.

Earlier there was a big discussion on this topic, which resulted in having
this feature. The main point was it reflects the state of the hardware devi=
ce,
not the virtual device itself. But they may not always be useful or necessa=
ry,
so this feature is optional.


>>>> +\subsubsection{PCM I/O Messages}\label{sec:Device Types / Sound Devic=
e / Device Operation / PCM IO Messages}
>>>> +
>>>> +An I/O message consists of the header part, followed by the buffer, a=
nd then
>>>> +the status part.
>>>
>>> Each buffer MUST (or SHOULD?) be period_bytes in size.
>>>
>>> The driver SHOULD queue (buffer_bytes / period_bytes) virtio buffers, s=
o
>>> the device has buffer_bytes total buffer space available.
>>
>> I think, it's better not to set queued buffer size restrictions.
>=20
> Lets make it SHOULD then.

Again, if periods are not used, then there's no period_bytes. And they are =
not
used, for example, in most low-latency applications.

(Well, technically speaking, low-latency applications in Linux must configu=
re
period size for ALSA. But then they usually suppress period notifications a=
nd
send very small chunks of data, which usually do not correspond to the size=
 of
the period at all.)

>> Periods are an optional feature. If the driver is not interested in
>> period notifications, it's unclear what period_bytes means here.
>=20
> Well, the driver has to manage buffers, so I can't see how a driver is
> not interested in completion notifications.  If the driver isn't
> interested in keeping the latency low by using lots of small buffers it
> still needs to queue at least two (larger) buffers, so the device still
> has data to continue playback when it completed a buffer.  And the
> driver needs to know when the device is done with a buffer so it can
> either recycle the buffer or free the pages.

It seems that you have mixed up two different things: sending/completing a
request containing a buffer, and period notifications. They are not the sam=
e.


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

