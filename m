Return-Path: virtio-dev-return-6889-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A0F76985D7E
	for <virtio-dev@lists.oasis-open.org>; Wed,  4 Mar 2020 11:22:29 +0000 (UTC)
References: <20200302152429.1666557-1-Anton.Yakovlev@opensynergy.com>
 <20200303112053.xuskcdi4747rnzcd@sirius.home.kraxel.org>
 <54b98087-36c8-b595-49f9-26cb6fdbd9bb@opensynergy.com>
 <20200303121005.mmcjlwuu7v7vvyqm@sirius.home.kraxel.org>
 <abfad80f-4e7d-bb58-1fbd-513f30ca3c2a@opensynergy.com>
 <20200303145249.wix2y6eoddpmwnei@sirius.home.kraxel.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <81c78dc1-50ff-fa8b-dfa4-38fdea855242@opensynergy.com>
Date: Wed, 4 Mar 2020 10:34:19 +0100
MIME-Version: 1.0
In-Reply-To: <20200303145249.wix2y6eoddpmwnei@sirius.home.kraxel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v6] virtio-snd: add virtio sound device
 specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>



On 03.03.2020 15:52, Gerd Hoffmann wrote:
> On Tue, Mar 03, 2020 at 01:27:38PM +0100, Anton Yakovlev wrote:
>> On 03.03.2020 13:10, Gerd Hoffmann wrote:
>>> On Tue, Mar 03, 2020 at 12:28:32PM +0100, Anton Yakovlev wrote:
>>>> Hi,
>>>>
>>>> On 03.03.2020 12:20, Gerd Hoffmann wrote:
>>>>>      Hi,
>>>>>
>>>>>> 4. Introduce the polling mode feature for a message-based transport.
>>>>>
>>>>> BTW: is that driver -> device or device -> driver or both?
>>>>> In case both: should we have two separate feature flags maybe?
>>>>
>>>> It's driver -> device direction. The driver needs notifications from t=
he
>>>> device in any case, so it makes no sense to suppress notifications in =
this
>>>> direction (device -> driver).
>>>
>>> Hmm, unless I missed something it doesn't matter whenever the guest
>>> kernel checks virtqueues from irq handler or timer ...
>>
>> Because in the general case, it is impossible to predict when a notifica=
tion
>> will come from the device. Even if we are talking about a period time, t=
his
>> does not mean that the device will send notifications precisely at these
>> intervals. And this means that the driver must do a tricky poll, trying
>> to guess when the notification will arrive, i.e. just waste CPU resource=
s.
>=20
> Well, the simplest way to handle this would be that each time the driver
> submits a buffer to the device it also checks whenever the device has
> completed buffers.  No irq, no timer -> no extra wakeups to collect
> completed buffers.
>=20
> Drawback is that completed buffers might be unnoticed for a while then
> due to jitter, the driver might see sometimes no buffers and sometimes
> multiple buffers.  For latency-sensitive workloads this will probably
> not work very well.
>=20
> So, not sure whenever it makes sense to have that as an option or
> whenever guest drivers would just use notifications unconditionally
> anyway.

Well, right from the beginning the driver enqueues buffers at stream start.=
 At
this moment there are no completed buffers in the queue (the first one shou=
ld
arrive after one period). So, no completed buffers and no notifications fro=
m
the device. The only option is to set a hrtimer. We tried such approach and
it's just bad for an audio in a vm. Because it's impossible to predict when
timer will fire. We tried to set a 10ms hrtimer and it could wake up after
10ms or after 80ms in the worst case. And what's the point then? Interrupts
for message-based transport enforced not only for making a driver design mu=
ch
simpler, but also to guarantee that the driver will receive completed buffe=
r
exactly at right time.


>=20
> But in any case we should clarify in the spec that this means the driver
> doesn't notify and the device polls.

I think it's not necessary. Now the spec states

---
\item VIRTIO_SND_PCM_F_MSG_POLLING - suppress available buffer notification=
s
for tx and rx queues,
---

So, it's about available buffers, not used ones. It should be pretty obviou=
s,=20
that is this case the device must poll virtqueue for new messages.


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

