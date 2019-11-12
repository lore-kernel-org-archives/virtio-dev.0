Return-Path: virtio-dev-return-6327-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 28BC0985ED1
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Nov 2019 18:47:20 +0000 (UTC)
References: <20190924144323.4590-1-Mikhail.Golubev@opensynergy.com>
 <6a4978e85505ae00ca9e2b170f5e893a064c03d2.camel@linux.intel.com>
 <568f32dc-8d82-a189-469f-5cb3a0140b8c@opensynergy.com>
 <0cc8007b70f4f5984223703313730d8e066006a7.camel@linux.intel.com>
 <20191112110937.GA4187507@lophozonia>
 <0c5939ad0b330bc4f42d63536340293745dce728.camel@linux.intel.com>
 <20191112160554.GA16008@lophozonia>
 <4ca16fb1d412bc92a2a65104680282b80742f6b1.camel@linux.intel.com>
From: Matti Moell <Matti.Moell@opensynergy.com>
Message-ID: <53ef5d67-91cf-6785-5820-246f0194cca1@opensynergy.com>
Date: Tue, 12 Nov 2019 19:47:14 +0100
MIME-Version: 1.0
In-Reply-To: <4ca16fb1d412bc92a2a65104680282b80742f6b1.camel@linux.intel.com>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Liam,

On 12.11.19 19:02, Liam Girdwood wrote:
> On Tue, 2019-11-12 at 17:05 +0100, Jean-Philippe Brucker wrote:
>>> This would be a good improvement, it's less copying and would
>>> likely
>>> improve user experience, however the buffer ptr still suffers
>>> latency
>>> as it's queued (same for stream positions going the other way).
>>
>> Right if the queuing overhead is still too large, then I don't think
>> the
>> current virtqueues can be used.
>=20
> They can be used for non low latency audio, I don't see any issues if
> latency is not important. e.g. media playback, some gaming, most system
> notifications.

You are absolutely right that the virtques come with some overhead that=20
is probably acceptable in many use cases.

The trick for even lower latency will be to use the fancy new virtio=20
shared-mem feature, this will allow making a piece of shared memory=20
between the audio DSP/sound device and the guest available that contains=20
the current sample buffer and the HW position register. Thus, once this=20
is set-up, the DSP and the guest can directly communicate without the=20
VMM or the virtual device being involved at all.

Maybe it's even enough to just have a single register containing the=20
hardware buffer position in shared mem?

Of course this has to be guarded by a feature flag but it would allow=20
true zero copy audio where instead of using the queues you would just=20
have the producer and consumer free-running without interruptions (as=20
long es everything is fine).

The buffer layout is probably the trickiest thing here, how can we know=20
what the hardware expects? If we add all known buffer formats now, how=20
can we know if they are sufficient for future hardware? Does it make=20
sense to wait and add additional buffer formats as they become necessary=20
and known?

For the "simple" things like desktop virtualization and all the other=20
boring audio use cases using the queues and playing with the=20
driver/device kick and interrupt suppression seems to be sufficient to=20
reach the respective latency requirements.


Cheers,

=09=09Matti

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

