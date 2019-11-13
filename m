Return-Path: virtio-dev-return-6331-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 28C39985F62
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Nov 2019 09:44:32 +0000 (UTC)
References: <20190924144323.4590-1-Mikhail.Golubev@opensynergy.com>
 <6a4978e85505ae00ca9e2b170f5e893a064c03d2.camel@linux.intel.com>
 <568f32dc-8d82-a189-469f-5cb3a0140b8c@opensynergy.com>
 <0cc8007b70f4f5984223703313730d8e066006a7.camel@linux.intel.com>
 <20191112110937.GA4187507@lophozonia>
 <0c5939ad0b330bc4f42d63536340293745dce728.camel@linux.intel.com>
 <20191112160554.GA16008@lophozonia>
 <4ca16fb1d412bc92a2a65104680282b80742f6b1.camel@linux.intel.com>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <ee52234e-6b53-1f2a-563f-c3dd50dd1764@opensynergy.com>
Date: Wed, 13 Nov 2019 10:44:27 +0100
MIME-Version: 1.0
In-Reply-To: <4ca16fb1d412bc92a2a65104680282b80742f6b1.camel@linux.intel.com>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 12.11.2019 19:02, Liam Girdwood wrote:
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

It can support low latency as well. We are not talking about high-throughpu=
t=20
device like block or network devices. Bit stream here is constant and quite=
=20
low (in compare with), so it's not a problem even with message based approa=
ch=20
to write/read frames near actual hw pointer.

And here I want to talk about real issue. I already mentioned it a few time=
s:=20
operating system schedulers. You describe low latency solution, but you did=
n't=20
explain how are you gonna support realtime properties. The closer to hw=20
position we read/write - the easier to miss a deadline.

The fact: tasks can be delayed. Using RT-schedulers in soft realtime OSes d=
oes=20
not help much, since they do not give you any guarantees. Thus, delay can b=
e=20
random and quite big, and it fully depends on number of available cores (an=
d=20
their speed). If a VM has dedicated cores, it's great. But usually for type=
 2=20
hv we will have shared cores, that makes situation even worse.

Since low latency applications in a guest are not virtualization-awared, th=
ey
will push latency to the limit. From other side, virtio driver is=20
virtualization-awared and could assist somehow. In our draft solution with=
=20
message based approach we artificially increase a latency to an extent=20
allowing to avoid xrun condition due to the worst possible delay (just put=
=20
additional silence at the beginning of a stream). And it's still far from=
=20
ideal, since a length of that additional latency highly depends on hardware=
=20
and virtualization setup.

With zero-copy and friends based approach, what are you going to do with su=
ch=20
issues? Because (in general case) you might not have enough cores to run=20
things smoothly and deadline will be missed quite often.


--=20
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

