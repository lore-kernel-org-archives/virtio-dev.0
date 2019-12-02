Return-Path: virtio-dev-return-6436-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8B14F985A88
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Dec 2019 13:07:03 +0000 (UTC)
References: <0c5939ad0b330bc4f42d63536340293745dce728.camel@linux.intel.com>
 <20191112160554.GA16008@lophozonia>
 <4ca16fb1d412bc92a2a65104680282b80742f6b1.camel@linux.intel.com>
 <ee52234e-6b53-1f2a-563f-c3dd50dd1764@opensynergy.com>
 <21039a042ad38302e9dc9010014223d915704b91.camel@linux.intel.com>
 <07b9804d-2c20-9ff4-a375-2c65f1d27f63@opensynergy.com>
 <20191121090403.6vjnovlru4zrmzzs@sirius.home.kraxel.org>
 <84fb109c-1d1e-a52c-8efa-8dcd00b864b3@opensynergy.com>
 <20191122071954.2ar6u3jwwn7yutjt@sirius.home.kraxel.org>
 <770a5ce0-ba97-df47-5d65-67404b7e1bf6@opensynergy.com>
 <20191125093110.vixnxeasmpdfbcxs@sirius.home.kraxel.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <b96600a6-1161-dbaf-c74c-c1bf8331de00@opensynergy.com>
Date: Mon, 2 Dec 2019 14:06:53 +0100
MIME-Version: 1.0
In-Reply-To: <20191125093110.vixnxeasmpdfbcxs@sirius.home.kraxel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

Sorry for the late reply, I was not available for a week.


On 25.11.2019 10:31, Gerd Hoffmann wrote:
>    Hi,
>=20
>>> Instead of PCM_OUTPUT and PCM_INPUT I would put the number of input and
>>> output streams into the device config space (and explicitly allow count
>>> being zero).
>>
>> There are several options for the number of streams:
>>
>> 1. The device can provide one input and/or output stream.
>> 2. The device can provide several input and/or output streams, and all o=
f them
>> share the same capabilities.
>> 3. The device can provide several input and/or output streams, and they =
can
>> have different set of capabilities.
>>
>> Overall design depends on chosen option. Current draft is based on p.1. =
But we
>> have never discussed what is the best solution here.
>=20
> (3) looks most useful to me.

Then we need to refactor device configuration. I would propose to put into
configuration space only a total number of all available PCM streams and
introduce special control request to query per-stream configuration. A
response should contain a stream type (input/output) and all its capabiliti=
es.


>>> PCM_MSG -- I would drop the feature bit and make that mandatory, so we
>>> have a common baseline on which all drivers and devices can agree on.
>>
>> Then we need to inform device what "transport" will be in use (I assumed=
 it
>> would be feature negotiation).
>=20
> Whenever other transports (i.e. via shared memory) are supported: yes,
> that should be a feature bit.
>=20
> Not sure about choosing the transport.  If both msg (i.e. via virtqueue)
> and shared memory are available, does it make sense to allow the driver
> choose the transport each time it starts a stream?

Shared memory based transport in any case will require some additional
actions. For HOST_MEM case the driver will need to get an access to host
buffer somehow. In GUEST_MEM case the driver will need to provide a buffer =
for
the host.

At first sight, we could extend the set_params request with the transport_t=
ype=20
field and some additional information. For example, in case of GUEST_MEM th=
e=20
request could be followed by a buffer sg-list. This way it will work like y=
ou=20
said: the driver chooses the transport each time it starts a stream.


>>> Right now this is defined for the pci transport only.
>>
>> And now we only declare a feature bit, right?
>=20
> Not fully sure what you mean here.
>=20
> Having the first revision define only the virtqueue transport, reserve a
> feature bit for the shared memory transport and hash out the details of
> that later is possible.

Yes, that's what I wanted to clarify.


>>>> Configuration space
>>>> -------------------
>>>>
>>>> We talked about PCM formats defined in ALSA. In Linux kernel v5.4-rc8 =
we have
>>>>
>>>> Do we really need all of them? And I skipped endianess, but should we =
care
>>>> about it as well?
>>>
>>> I'd keep the list as short as possible.  The formats listed in the patc=
h
>>> looked like a good start.
>>
>> It was proposed to have all non-compressed formats.
>>
>> And... do we care about cross-endian cases?
>=20
> I'd start with little endian formats only.  virtio byte order is little
> endian, and the world is moving to little endian anyway.  We can add big
> endian formats later should this turn out to be needed, but I don't
> expect that to be the case.

Great!


>=20
>>> I'd suggest bytes (and rename the field to period_bytes).
>=20
>>>> struct virtio_snd_pcm_status {
>>>>       le32 status;
>>>>       le32 actual_length;
>>>> };
>>>
>>> Hmm.  Why actual_length?  Do we want allow short transfers?  Why?
>>> Wouldn't it be more useful to just fill the buffer completely?
>>
>> In current design we have no buffer size requirements. It means, that in
>> theory the device and the driver could have buffers with different sizes=
.
>=20
> Should we define that the (virtio) buffer size must be period_bytes then?

It will have no sense, since the driver chooses period_bytes at runtime. If=
 we
gonna introduce any buffer constrains, it must be set by the device in a
stream configuration.


>> Also, the capture stream is a special case. Now we don't state explicitl=
y
>> whether read request is blockable or not.
>=20
> The concept of "blockable" doesn't exist at that level.  The driver
> submits buffers to the device, the device fills them and notifies the
> driver when the buffer is full.  It simply doesn't work like a read(2)
> syscall.

But you described exactly "blockable" case: an I/O request is completed not
immediately but upon some condition (the buffer is full). In case of messag=
e-
based transport, both the device and the driver will have its own buffers. =
And
for capturing these buffers might be filled at different speed. For example=
,
in order to improve latency, the device could complete requests immediately
and fill in buffers with whatever it has at the moment.


> Buffers not being filled completely could possibly happen when stopping
> a stream with a half-filled buffer, if we want allow that in the spec.
>=20
> Another possible case would be compressed streams with variable bitrate,
> where the number of bytes needed for a millisecond of sound data isn't
> fixed.

Compressed streams are not part of PCM framework anyway.


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

