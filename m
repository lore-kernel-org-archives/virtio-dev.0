Return-Path: virtio-dev-return-6460-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5963498604A
	for <virtio-dev@lists.oasis-open.org>; Wed,  4 Dec 2019 11:16:04 +0000 (UTC)
References: <4ca16fb1d412bc92a2a65104680282b80742f6b1.camel@linux.intel.com>
 <ee52234e-6b53-1f2a-563f-c3dd50dd1764@opensynergy.com>
 <21039a042ad38302e9dc9010014223d915704b91.camel@linux.intel.com>
 <07b9804d-2c20-9ff4-a375-2c65f1d27f63@opensynergy.com>
 <20191121090403.6vjnovlru4zrmzzs@sirius.home.kraxel.org>
 <84fb109c-1d1e-a52c-8efa-8dcd00b864b3@opensynergy.com>
 <20191122071954.2ar6u3jwwn7yutjt@sirius.home.kraxel.org>
 <770a5ce0-ba97-df47-5d65-67404b7e1bf6@opensynergy.com>
 <20191125093110.vixnxeasmpdfbcxs@sirius.home.kraxel.org>
 <b96600a6-1161-dbaf-c74c-c1bf8331de00@opensynergy.com>
 <20191203090038.2bwfz4br7g4gvnaf@sirius.home.kraxel.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <7237a715-87ae-e5b1-bcd1-55ebd57d4767@opensynergy.com>
Date: Wed, 4 Dec 2019 12:15:58 +0100
MIME-Version: 1.0
In-Reply-To: <20191203090038.2bwfz4br7g4gvnaf@sirius.home.kraxel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 03.12.2019 10:00, Gerd Hoffmann wrote:

...snip...

>>>>> PCM_MSG -- I would drop the feature bit and make that mandatory, so w=
e
>>>>> have a common baseline on which all drivers and devices can agree on.
>>>>
>>>> Then we need to inform device what "transport" will be in use (I assum=
ed it
>>>> would be feature negotiation).
>>>
>>> Whenever other transports (i.e. via shared memory) are supported: yes,
>>> that should be a feature bit.
>>>
>>> Not sure about choosing the transport.  If both msg (i.e. via virtqueue=
)
>>> and shared memory are available, does it make sense to allow the driver
>>> choose the transport each time it starts a stream?
>>
>> Shared memory based transport in any case will require some additional
>> actions. For HOST_MEM case the driver will need to get an access to host
>> buffer somehow. In GUEST_MEM case the driver will need to provide a buff=
er for
>> the host.
>>
>> At first sight, we could extend the set_params request with the
>> transport_type field and some additional information.
>=20
> Or have a per-transport set_params request command.

Or, since now we decided to make a message-based transport as a default one=
,
at the moment we can go without explicit transport selection. Some addition=
al
extensions could be done at the future, when buffer sharing mechanism will =
be
stabilized.


>> For example, in case
>> of GUEST_MEM the request could be followed by a buffer sg-list.
>=20
> I'm not convinced guest_mem is that useful.  host_mem allows to give the
> guest access to the buffers used by the hosts sound hardware, which is
> probably what you need if the MSG transport can't handle the latency
> requirements you have.

Actually, it might be pretty useful.

If a device is not capable of sharing host memory with a guest but still
capable of using guest shared memory, then there's a good use case for that=
:
when a buffer is mapped into a user space application. It assumes, that the
driver is not involved in frame transfer at all (thus, it can not queue
buffers into a virtqueue and send notifications to the device). But if that
memory is shared with the device (as long as some piece of memory containin=
g
an application position as well), then it's possible to implement quite
simple poller in the device. And it would be pretty aligned with common
software mixer workflow (like in PA or QEmu), where a mixer invokes client'=
s
callbacks for reading/writing next piece of data. The device will need only
to check an application position and directly read from/write to a shared
buffer.


...snip...

>> If we gonna introduce any buffer constrains, it must be set by the
>> device in a stream configuration.
>=20
> If we want allow the device specify min/max period_bytes which it can
> handle, then yes, that should go into the stream configuration.
>=20
> Or we use negotiation: driver asks for period_bytes in set-params, the
> driver picks the closest period_bytes value it can handle and returns
> that.

As I said before, periods are not used everywhere. Also, even in ALSA such
kind of negotiations may be non trivial. I would propose to leave choosing =
the
period_bytes value up to the driver. We could add yet one mandatory field t=
o
the set_params request - driver's buffer size. (If the driver wants to use
period notification feature, then buffer_bytes % period_bytes must be 0). I=
f
the device has its own intermediate buffer of any kind, it's possible to
adjust this according to the buffer_bytes value (like making it's being no
smaller than the specified size and so on). This way we could resolve origi=
nal=20
concerns regarding possible different buffer sizes.


>>>> Also, the capture stream is a special case. Now we don't state explici=
tly
>>>> whether read request is blockable or not.
>>>
>>> The concept of "blockable" doesn't exist at that level.  The driver
>>> submits buffers to the device, the device fills them and notifies the
>>> driver when the buffer is full.  It simply doesn't work like a read(2)
>>> syscall.
>>
>> But you described exactly "blockable" case: an I/O request is completed =
not
>> immediately but upon some condition (the buffer is full). In case of mes=
sage-
>> based transport, both the device and the driver will have its own buffer=
s.
>=20
> Well, no.  The device doesn't need any buffers, it can use the buffers
> submitted by the driver.  Typical workflow:
>=20
>    (1) The driver puts a bunch of empty buffers into the rx (record/read)
>        virtqueue (each being period_bytes in size).
>    (2) The driver starts recording.
>    (3) The device fills the first buffer with recorded sound data.
>    (4) When the buffer is full the device returns it to the driver,
>        takes the next from the virtqueue to continue recording.
>    (5) The driver takes the filled buffer and does whatever it wants do
>        with the data (typically pass on to the userspace app).
>    (6) The driver submits a new empty buffer to the virtqueue to make
>        sure the device doesn't run out of buffers.
>=20
> So, it's not a "here is a buffer, fill it please", "here is the next,
> ..." ping pong game between driver and device.  There is a queue with
> multiple buffers instead, and the device fills them one by one.

Then, should we make this pattern to be mandatory?


...snip...

>=20
>> And
>> for capturing these buffers might be filled at different speed. For exam=
ple,
>> in order to improve latency, the device could complete requests immediat=
ely
>> and fill in buffers with whatever it has at the moment.
>=20
> Latency obviously depends on period_bytes.  If the driver cares about
> latency it should simply work with lots of small buffers instead of a
> few big ones.

Well, smaller buffers would mean higher rate of hypercalls/traps but better
latency. And larger buffers would mean less amount of hypercalls/traps but
worse latency. There's always a trade-off and an implementer might choose
whatever fits better. I mean, this idea was behind previous design version
(where we could use the actual_length field for supporting all possible
cases).


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

