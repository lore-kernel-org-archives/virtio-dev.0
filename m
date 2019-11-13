Return-Path: virtio-dev-return-6330-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 00526985F62
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Nov 2019 09:05:25 +0000 (UTC)
References: <20190924144323.4590-1-Mikhail.Golubev@opensynergy.com>
 <6a4978e85505ae00ca9e2b170f5e893a064c03d2.camel@linux.intel.com>
 <568f32dc-8d82-a189-469f-5cb3a0140b8c@opensynergy.com>
 <0cc8007b70f4f5984223703313730d8e066006a7.camel@linux.intel.com>
 <050946d2-e55e-1104-96ff-a63862c154ab@opensynergy.com>
 <394b40a75959454bc634636d9c99bf9bca98454d.camel@linux.intel.com>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <b2e8d449-93d6-3452-097b-9df9aa0785cb@opensynergy.com>
Date: Wed, 13 Nov 2019 10:05:20 +0100
MIME-Version: 1.0
In-Reply-To: <394b40a75959454bc634636d9c99bf9bca98454d.camel@linux.intel.com>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 12.11.2019 16:16, Liam Girdwood wrote:
> On Tue, 2019-11-12 at 13:45 +0100, Anton Yakovlev wrote:
>> On 11.11.2019 16:20, Liam Girdwood wrote:
>>> On Tue, 2019-10-29 at 10:42 +0100, Anton Yakovlev wrote:
>>>> Hi Liam,
>>>>
>>>> Thank you for comments! Please, take a look at our answers below.
>>>
>>> Apologies, been travelling. More comments below.
>>>
>>>>
>>>>
>>>> On 28.10.2019 17:05, Liam Girdwood wrote:
>>>>> On Tue, 2019-09-24 at 15:43 +0100, Mikhail Golubev wrote:
>>>>>> From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
>>>>>>
>>>>>>
>=20
> snip
>=20
>>>>>> diff --git a/virtio-sound.tex b/virtio-sound.tex
>>>>>> new file mode 100644
>>>>>> index 0000000..68a606e
>>>>>> --- /dev/null
>>>>>> +++ b/virtio-sound.tex
>>>>>> @@ -0,0 +1,405 @@
>>>>>> +\section{Sound Device}\label{sec:Device Types / Sound
>>>>>> Device}
>>>>>> +
>>>>>> +The virtio sound card is a virtual audio device supporting
>>>>>> output
>>>>>> and input PCM
>>>>>> +streams. All device control requests are placed into the
>>>>>> control
>>>>>> virtqueue, all
>>>>>> +I/O requests are placed into the PCM virtqueue.
>>>>>
>>>>> Where are stream position updates placed ? These are usually
>>>>> synchronous from the driver and enable the player application
>>>>> to
>>>>> render
>>>>> or read data from the correct locations in the buffers. This is
>>>>> latency
>>>>> sensitive data.
>>>>
>>>> It happens in an interrupt handler. Since PCM frame transfer is
>>>> message based,
>>>> the only possible way to figure out consumed or captured amount
>>>> of
>>>> frames is
>>>> to take a look into a message response.
>>>>
>>>
>>> Ok, this is what I thought. This wont work for low latency audio
>>> use
>>> cases since the buffers and position responses are queued (voice
>>> calls,
>>> some gaming, some system notifications like keypress or volume
>>> change).
>>
>> But it's not different from typical HW. A driver receives an
>> interrupt once
>> DMA transaction is finished (i.e. some part of data was copied
>> to/from host).
>> And hardware pointer value usually is extrapolated based on some
>> internal
>> device state.
>=20
> Modern HW can usually provide the HW position to the nearest word. Some
> older/bad HW provides to the nearest period though and this is when we
> have to estimate.
>=20
> Native (non virtual) audio device drivers typically have no latency
> reading the stream position and it's read at the same time as the
> system clock. Reading the same clocks together is important as it means
> the relationship between the two is deterministic and not subject to
> any jitter (which can be introduced by reading stream position over
> virtio).
>=20
>> A virtio driver could do something similar: it could either
>> return "real" pointer value (i.e. what it internally uses) or could
>> show fake
>> "extrapolated" value (like frame_rate * elappsed_time). Although,
>> it's a
>> different story.
>>
>>
>=20
> Virtio driver should return real stream position alongside real common
> system time (of when stream position was read).

Do you propose to share stream position via shared memory? Or will it be re=
ad=20
with special request?


>>> However, it's probably tolerable for most other use cases. What use
>>> cases have you tried in your testing ?
>>
>> All typical cases: multimedia (video + audio or audio only), network
>> streaming, video calls, system events, volume changing and so on.
>>
>> By the way, could you define the "low latency" term that we are
>> talking about?
>> Just to be on the same wave.
>>
>=20
> Low latency audio is when any application or processing can render data
> very close to the HW stream R/W position (typically low or sub
> millisecond). This needs zero copy buffering to HW on host/VM/user side
> and also timely and accurate stream positions.

Good.


>> es
>>>>>> /
>>>>>> Sound Device / Device configuration layout}
>>>>>> +
>>>>>> +\begin{lstlisting}
>>>>>> +/* supported PCM sample formats */
>>>>>> +enum {
>>>>>> +    VIRTIO_SND_PCM_FMT_S8 =3D 0,
>>>>>> +    VIRTIO_SND_PCM_FMT_U8,
>>>>>> +    VIRTIO_SND_PCM_FMT_S16,
>>>>>> +    VIRTIO_SND_PCM_FMT_U16,
>>>
>>> 24 bit.
>>
>> These kinds of sample (18/20/24-bit) were discussed here earlier and
>> caused
>> some concerns (regarding supporting in a guest, testing and so on),
>> so they
>> were removed for simplicity.
>>
>>   From other side, if we are up to add these, maybe it's better not to
>> hardcode
>> format names and use some kind of generic description instead?
>> Something like
>>
>> struct {
>>     kind; /* S/U/F */
>>     significant_bits;
>>     storage_bits;
>> }
>>
>> It allows to describe formats like 24 and 24_3 in unified way and to
>> add
>> future formats without changing the protocol. What do you think?
>>
>=20
> I would recommend copying the exact formats used by ALSA, these formats
> are industry standard (although naming will be different on other
> OSes)
I mean, there are two options:

1. We can go with defining format names. But then we will need to update th=
e=20
protocol and (perhaps) existing drivers.
2. We can develop some generic way to report supported formats (as well, as=
=20
rates). And it will not require to touch the spec on every update.


>>
>>>>>> +    VIRTIO_SND_PCM_FMT_S32,
>>>>>> +    VIRTIO_SND_PCM_FMT_U32,
>>>>>> +    VIRTIO_SND_PCM_FMT_FLOAT,
>>>>>> +    VIRTIO_SND_PCM_FMT_FLOAT64
>>>>>> +};
>>>>>> +
>>>>>> +/* supported PCM frame rates */
>>>>>> +enum {
>>>>>> +    VIRTIO_SND_PCM_RATE_8000 =3D 0,
>>>>>> +    VIRTIO_SND_PCM_RATE_11025,
>>>>>> +    VIRTIO_SND_PCM_RATE_16000,
>>>>>> +    VIRTIO_SND_PCM_RATE_22050,
>>>>>> +    VIRTIO_SND_PCM_RATE_32000,
>>>>>> +    VIRTIO_SND_PCM_RATE_44100,
>>>>>> +    VIRTIO_SND_PCM_RATE_48000,
>>>>>> +    VIRTIO_SND_PCM_RATE_64000,
>>>>>> +    VIRTIO_SND_PCM_RATE_88200,
>>>>>> +    VIRTIO_SND_PCM_RATE_96000,
>>>>>> +    VIRTIO_SND_PCM_RATE_176400,
>>>>>> +    VIRTIO_SND_PCM_RATE_192000
>>>>>
>>>>> It may be best to use the same rates and format from the ALSA
>>>>> spec,
>>>>> this covers any holes (like rates that are not in the above
>>>>> list).
>>>>
>>>> These rates are from ALSA definitions. And what formats should be
>>>> added?
>>>>
>>>
>>> Rate, Knot - I would copy ALSA supported rates and formats just
>>> like
>>> with the channel maps.
>>
>> See a comment above.
>>
>=20
> See comment above :)
>>
>>>>>
>>>>>> +
>>>>>> +/* a device configuration space */
>>>>>> +struct virtio_snd_config {
>>>>>> +    struct virtio_pcm_config {
>>>>>> +        struct virtio_pcm_stream_config output;
>>>>>> +        struct virtio_pcm_stream_config input;
>>>>>> +    } pcm;
>>>>>> +};
>>>>>> +\end{lstlisting}
>>>>>
>>>>> I assuming this is sent to configure PCM capabilities ?
>>>>
>>>> Yes, minimum amount of information required to setup a PCM stream
>>>> in
>>>> any kind
>>>> of guest.
>>>>
>>>>
>>>>> What about buffer and period size capabilities ?
>>>>
>>>> In this specification we assume that buffer size is up to guest
>>>> decision.
>>>> Also, period size is ALSA-only conception and should not be
>>>> mentioned
>>>> here at
>>>> all (we are not stick only to ALSA).
>>>>
>>>>
>>>
>>> Period size =3D=3D fragment size =3D=3D block size (probably a few othe=
r
>>> naming
>>> conventions too), we should be able to tell the device VM our
>>> period/block/fragment size so we can configure the HW
>>> appropriately.
>>> This can also be used to make our stream copying more efficient
>>> too.
>>
>> Then let's talk about playback. As I can understand, you are
>> describing a
>> case, when
>> 1. ALSA application sets some period size
>> 2. fills the whole buffer with non-silence frames
>> 3. upon every period notification, provides next period-sized part of
>> data
>>
>> It's one of use cases, but quite rare.
>=20
> Ehm, it's bog standard file R/W (non mmap()) audio and extremely common
> on Linux and derivatives.
>=20
> Step 4 is
>=20
> 4) Unblock and wake userspace R/W for next period/block/fragment.
>=20
>> More often (especially if we are
>> talking about latency control and low latency audio) things will be
>> 1. an application fills the whole buffer with silence
>> 2. suppresses period notifications
>> 3. starts stream and almost immediatly seeks to near hw position
>> 4. puts non-silence frames there (size is set according to desired
>> latency)
>> 5. provides new frames at some interval (usually in 5-10ms)
>=20
> So this describes mmap() audio where we block by poll()ing, read HW
> ptr, and the write new frames.
>=20
> This proposal needs to support both operating modes and there is
> nothing I can see with virtio and some minor changes to this proposal
> that would prevent that ?

Yes, nothing prevents. I explained, why it was not here from the start.


>>
>> It's how software mixers usually work: PulseAudio, Windows in-kernel
>> mixer,
>> new Android system mixer and so on. Also, you can find such approach
>> in low
>> latency player applications (when they work directly with device).
>>
>> The point is they do not rely on notifications from the driver and
>> use their
>> own timers. The only thing they querying is current hw position.
>>
>> The point is we could have period notifications from the device. But
>> it seems
>> they will be useful only in minority of cases. Also, for example,
>> Windows
>> audio driver has no such concept at all.
>=20
> Windows does not need to use periodic mode, but a lot of Linux
> userspace will use it and this will currently will break those
> applications.

It does not break anything. Since the driver must notify on every elapsed=
=20
period in any case. And exactly that happens in an interrupt handler.


>>>>
>>>> Since xrun conditions are higher level conceptions, we decided to
>>>> delegate
>>>> such issues to guest application itself. It helps to make overall
>>>> design
>>>> simpler. And it seems there's not so much we can do if xrun
>>>> condition
>>>> is
>>>> happened on the device side.
>>>
>>> We can inform the guest. The guest userspace can then take any
>>> remedial
>>> action if needed.
>>
>> Then, we need the third queue for notifications.
>=20
> Why, this should go in the queue that's used for stream position ?

Then, the I/O queue will multiplex already three things: read requests, wri=
te=20
requests and notifications. The question is how rational is it.


>>
>>
>>>>
>>>>
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
>> Shared memory based approach was proposed in the very first version
>> of the
>> spec (and we are rooting for this). Then there was discussion and it
>> was
>> postponed for some future virtio device. One of the reason - it's not
>> suitable
>> for arch with non-coherent memory between host and guest.
>=20
> I'm rooting for this too. I do think we need to be a bit more flexible
> so we can deal with non coherent architectures via a SW virtio copy and
> support coherent architectures via zero copy.
>=20
> We should be good as long as we can leave some configuration
> space/types in the stream config to allow mapping of operating modes
> (zero copy, periodic, mmap etc). The device driver should also send
> it's capabilities during init so that guests will know what use cases
> and modes are supported.

Yes, we can use device feature bits for this.


> Btw, please don't take my comments as trying to block your proposal. I
> am behind this work, I'll likely be one of the first users. My
> intention is to help provide something that is both flexible enough to
> cater for all current OS users/use cases on HDA like hardware and has
> scope for future enhancements.

As we are! :)


> Thanks
>=20
> Liam
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

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

