Return-Path: virtio-dev-return-6466-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9917698607D
	for <virtio-dev@lists.oasis-open.org>; Thu,  5 Dec 2019 12:06:17 +0000 (UTC)
References: <21039a042ad38302e9dc9010014223d915704b91.camel@linux.intel.com>
 <07b9804d-2c20-9ff4-a375-2c65f1d27f63@opensynergy.com>
 <20191121090403.6vjnovlru4zrmzzs@sirius.home.kraxel.org>
 <84fb109c-1d1e-a52c-8efa-8dcd00b864b3@opensynergy.com>
 <20191122071954.2ar6u3jwwn7yutjt@sirius.home.kraxel.org>
 <770a5ce0-ba97-df47-5d65-67404b7e1bf6@opensynergy.com>
 <20191125093110.vixnxeasmpdfbcxs@sirius.home.kraxel.org>
 <b96600a6-1161-dbaf-c74c-c1bf8331de00@opensynergy.com>
 <20191203090038.2bwfz4br7g4gvnaf@sirius.home.kraxel.org>
 <7237a715-87ae-e5b1-bcd1-55ebd57d4767@opensynergy.com>
 <20191204125259.hykob5tupysatqv2@sirius.home.kraxel.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <ad400a90-4fe9-ef27-92c5-b0518c306652@opensynergy.com>
Date: Thu, 5 Dec 2019 13:06:10 +0100
MIME-Version: 1.0
In-Reply-To: <20191204125259.hykob5tupysatqv2@sirius.home.kraxel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

On 04.12.2019 13:52, Gerd Hoffmann wrote:
>>>> For example, in case
>>>> of GUEST_MEM the request could be followed by a buffer sg-list.
>>>
>>> I'm not convinced guest_mem is that useful.  host_mem allows to give th=
e
>>> guest access to the buffers used by the hosts sound hardware, which is
>>> probably what you need if the MSG transport can't handle the latency
>>> requirements you have.
>>
>> Actually, it might be pretty useful.
>>
>> If a device is not capable of sharing host memory with a guest but still
>> capable of using guest shared memory, then there's a good use case for t=
hat:
>=20
> Note that "hostmem" only means that the buffer is allocated by the host
> (i.e. the device).  Whenever the allocation is backed by actual host
> sound buffers or just normal ram depends on the device implementation
> and maybe the host sound hardware capabilities.  Qemu would probably use
> normal ram due to the extra indirection caused by the sound backend
> interface.
>=20
> I don't think there is a use case which guestmem can handle but hostmem
> can not.

There may be a special security requirement like "a guest must not have any
access to a host memory" (especially in case of type 1 hv).


>> when a buffer is mapped into a user space application. It assumes, that =
the
>> driver is not involved in frame transfer at all (thus, it can not queue
>> buffers into a virtqueue and send notifications to the device).
>=20
> The sound data can actually be in userspace mapped buffers even for the
> message transport.  Adding a buffer to the virtqueue (which actually
> stores pointer(s) to the buffer pages) effectively moves the application
> position then.

It's how we implemented a PoC for the previous spec version.


> But, yes, userspace must do a syscall for that which is not needed when
> updating the position in a shared page.

Yes, that's the trickiest part.

Also, sharing memory implies sharing of two things: buffer itself and a pag=
e
containing position counter. And it goes in both directions (a host shares
buffer and hardware position or a guest shares buffer and application
position). And it seems, that overall solution can benefit if there will be
four independent entities. For example, message-based transport can have
some benefits, if a host will provide its hardware pointer in a shared page=
.


>> But if that
>> memory is shared with the device (as long as some piece of memory contai=
ning
>> an application position as well), then it's possible to implement quite
>> simple poller in the device. And it would be pretty aligned with common
>> software mixer workflow (like in PA or QEmu), where a mixer invokes clie=
nt's
>> callbacks for reading/writing next piece of data. The device will need o=
nly
>> to check an application position and directly read from/write to a share=
d
>> buffer.
>=20
> Note that it is possible to store things in the virtqueue without
> notifying the device and expect the device poll the virtqueue instead.
> Likewise for the other direction.  That allows operating the queue
> without vmexits and might work more efficient with lots of small
> buffers.  Of course device and driver must negotiate whenever they want
> use polling or notifications.

Yes, and a shared memory only makes things simpler here.


>>>> But you described exactly "blockable" case: an I/O request is complete=
d not
>>>> immediately but upon some condition (the buffer is full). In case of m=
essage-
>>>> based transport, both the device and the driver will have its own buff=
ers.
>>>
>>> Well, no.  The device doesn't need any buffers, it can use the buffers
>>> submitted by the driver.  Typical workflow:
>>>
>>>     (1) The driver puts a bunch of empty buffers into the rx (record/re=
ad)
>>>         virtqueue (each being period_bytes in size).
>>>     (2) The driver starts recording.
>>>     (3) The device fills the first buffer with recorded sound data.
>>>     (4) When the buffer is full the device returns it to the driver,
>>>         takes the next from the virtqueue to continue recording.
>>>     (5) The driver takes the filled buffer and does whatever it wants d=
o
>>>         with the data (typically pass on to the userspace app).
>>>     (6) The driver submits a new empty buffer to the virtqueue to make
>>>         sure the device doesn't run out of buffers.
>>>
>>> So, it's not a "here is a buffer, fill it please", "here is the next,
>>> ..." ping pong game between driver and device.  There is a queue with
>>> multiple buffers instead, and the device fills them one by one.
>>
>> Then, should we make this pattern to be mandatory?
>=20
> It's pretty standard for virtio.  The network receive queue works
> fundamentally the same way for example, except that network buffers
> actually might be half-filled only because you get network packets
> where you don't know the size beforehand instead of a constant stream
> of sound samples which you can easily pack into buffers as you like.

Except the end of the capture stream case. Can we use the len field in
virtq_used_elem for storing actual captured size then?


> But, yes, it probably makes sense to explicitly say so in the specs.
> If in doubt be more verbose ;)

I think it would be the best decision here. Such pattern may be a common th=
ing
in virtio world, but people still might have their own interpretations.
Especially, if it's their first experience with implementing something.


>>>> And
>>>> for capturing these buffers might be filled at different speed. For ex=
ample,
>>>> in order to improve latency, the device could complete requests immedi=
ately
>>>> and fill in buffers with whatever it has at the moment.
>>>
>>> Latency obviously depends on period_bytes.  If the driver cares about
>>> latency it should simply work with lots of small buffers instead of a
>>> few big ones.
>>
>> Well, smaller buffers would mean higher rate of hypercalls/traps but bet=
ter
>> latency. And larger buffers would mean less amount of hypercalls/traps b=
ut
>> worse latency.
>=20
> Note that it depends on the use case whenever long latencies are
> actually worse.  Some use cases don't care much (music playback).  For
> some use cases it is good enough to know the exact latency so you can
> take it into account for synchronization (video playback).  Some
> usecases are pretty much impossible with long latencies (games, voip).

By the way, there is a good point here. Maybe it makes sense for the device
somehow reports its current/additionally latency value? Like, as a part of =
a
response to the set_params request?


>> There's always a trade-off and an implementer might choose
>> whatever fits better.
>=20
> Sure.  But you choose once, when configuring the stream, not for each
> individual buffer, right?  So the driver will:
>=20
>    (1) set-params (including period_bytes), taking into account what
>        userspace asked for.
>    (2) queue buffers for the stream, each being period_bytes in size.
>    (3) start stream.

Originally, we introduced period_bytes for enabling period notification
feature (which is optional). At least, it was not supposed to be used for
slicing a buffer into pieces (although, the driver may chose to work in thi=
s
way).


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

