Return-Path: virtio-dev-return-6329-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 777F6985F54
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Nov 2019 07:54:50 +0000 (UTC)
References: <20190924144323.4590-1-Mikhail.Golubev@opensynergy.com>
 <6a4978e85505ae00ca9e2b170f5e893a064c03d2.camel@linux.intel.com>
 <568f32dc-8d82-a189-469f-5cb3a0140b8c@opensynergy.com>
 <0cc8007b70f4f5984223703313730d8e066006a7.camel@linux.intel.com>
 <20191112110937.GA4187507@lophozonia>
 <0c5939ad0b330bc4f42d63536340293745dce728.camel@linux.intel.com>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <1e950359-8a68-f5d2-95c4-34b199a19974@opensynergy.com>
Date: Wed, 13 Nov 2019 08:54:45 +0100
MIME-Version: 1.0
In-Reply-To: <0c5939ad0b330bc4f42d63536340293745dce728.camel@linux.intel.com>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>



On 12.11.2019 15:20, Liam Girdwood wrote:
> On Tue, 2019-11-12 at 12:09 +0100, Jean-Philippe Brucker wrote:
>> Hi,
>>
>> On Mon, Nov 11, 2019 at 03:20:55PM +0000, Liam Girdwood wrote:
>>>>>> +struct virtio_snd_ctl_msg {
>>>>>> +    /* device-read-only data */
>>>>>> +    le32 request_code;
>>>>>> +    u8 request_payload[];
>>>>>
>>>>> How do I know how much data to read here ? Is size embedded in
>>>>> request_code ?
>>>>
>>>> Yes, you are right. Actual request/response length can be easily
>>>> derived from
>>>> a request_code.
>>>>
>>>
>>> Nak, please use a separate size and type code otherwise we will
>>> have
>>> real problems in the future when we come to add new features (with
>>> new
>>> codes or bigger sizes).
>>
>> Other virtio devices rely on the buffer length already provided by
>> virtio
>> for this. For example see the virtio-net control virtqueue
>> (virtio_net_ctrl*), which is extended with new commands from time to
>> time.
>> Most recently, the "receive-side scaling" feature introduces a large
>> structure as payload to virtio_net_ctrl.
>>
>=20
> Sorry, not following, what does this have to do with combining type and
> size into request_code ? Or are you saying the size is encoded
> elsewhere in the virtio transport data ?

A virtqueue operates with sg-lists, where every entry has additional proper=
ty=20
specifying whether it refers to RO or WO memory. Thus, as with any sg-list,=
=20
it's possible to calculate its buffer size.


>> [...]
>>>>>> +\begin{lstlisting}
>>>>>> +struct virtio_snd_pcm_xfer {
>>>>>> +    le32 stream;
>>>>>> +    u8 data[];
>>>>>> +    le32 status;
>>>>>> +    le32 actual_length;
>>>>>
>>>>> Not following this, is actual_length the size of data[]. If so,
>>>>> it
>>>>> must
>>>>> preceed data[].
>>>>
>>>> No, the actual_length field is supposed to be used by device side
>>>> to
>>>> report
>>>> actual amount of bytes read from/written to a buffer.
>>
>> By the way the written size is already provided by virtio (field len
>> in
>> the used descriptor), but not the read size.
>>
>>>> In real world
>>>> scenario,
>>>> if an I/O request contains N bytes, a device can play/capture *up
>>>> to*
>>>> N bytes.
>>>> Thus, it's required to report this length back to a driver.
>>>>
>>>
>>> This is not how PCM audio buffering works. I don't copy extra
>>> padding
>>> if I dont need to, I only copy when my buffer is full. See the need
>>> for
>>> period size in earlier comments.
>>
>> [...]
>>>>> 2) Zero copy of audio data and stream positions. Essential for
>>>>> any
>>>>> low
>>>>> latency audio use cases (if supported by HW, hypervisor, VM
>>>>> framework).
>>>>
>>>> What do you mean by zero-copy? Shared memory between device and
>>>> driver sides?
>>>
>>> Yes, but I see this is now a separate thread as it used by others
>>> too.
>>
>> The virtio transport already permits zero-copy, because one buffer
>> can be
>> described with a chain of descriptors, each pointing to a different
>> area
>> in memory. The driver can split the virtio_snd_pcm_xfer into header
>> and
>> data:
>>
>>      virtqueue
>>      desc ring
>>      |       |
>>      +-------+
>>      |       |---------> header (copied)
>>      +- - - -+
>>      |       |---------> PCM data (mapped)
>>      +-------+
>>      |       |
>>
>> So it might be a good idea to put all the metadata (stream, status,
>> actual_length) at the beginning of the virtio_snd_pcm_xfer struct,
>> otherwise the driver will need three descriptors instead of two to
>> achieve
>=20
> This would be a good improvement, it's less copying and would likely
> improve user experience, however the buffer ptr still suffers latency
> as it's queued (same for stream positions going the other way).

It will violate virtio spec.

<quote>
2.6.4.2 Driver Requirements: Message Framing

The driver MUST place any device-writable descriptor elements after any=20
device-readable descriptor elements.
</quote>

and

<quote>
2.6.5 The Virtqueue Descriptor Table

... Each descriptor describes a buffer which is read-only for the device=20
(=E2=80=9Cdevice-readable=E2=80=9D) or write-only for the device (=E2=80=9C=
device-writable=E2=80=9D), ...
</quote>

It means, that a device can "map" this memory as RO or WO and will be right=
.=20
Thus, you can not put in one descriptor both readable and writable fields. =
You=20
can take a look into virtio-blk spec. There is a reason, why they put statu=
s=20
field at the very end of a request.


--=20
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

