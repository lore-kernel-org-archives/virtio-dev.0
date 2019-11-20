Return-Path: virtio-dev-return-6354-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BBF6F985E73
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Nov 2019 14:24:53 +0000 (UTC)
References: <20190924144323.4590-1-Mikhail.Golubev@opensynergy.com>
 <6a4978e85505ae00ca9e2b170f5e893a064c03d2.camel@linux.intel.com>
 <568f32dc-8d82-a189-469f-5cb3a0140b8c@opensynergy.com>
 <0cc8007b70f4f5984223703313730d8e066006a7.camel@linux.intel.com>
 <20191112110937.GA4187507@lophozonia>
 <0c5939ad0b330bc4f42d63536340293745dce728.camel@linux.intel.com>
 <20191112160554.GA16008@lophozonia>
 <4ca16fb1d412bc92a2a65104680282b80742f6b1.camel@linux.intel.com>
 <ee52234e-6b53-1f2a-563f-c3dd50dd1764@opensynergy.com>
 <21039a042ad38302e9dc9010014223d915704b91.camel@linux.intel.com>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <07b9804d-2c20-9ff4-a375-2c65f1d27f63@opensynergy.com>
Date: Wed, 20 Nov 2019 15:24:45 +0100
MIME-Version: 1.0
In-Reply-To: <21039a042ad38302e9dc9010014223d915704b91.camel@linux.intel.com>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 19.11.2019 17:09, Liam Girdwood wrote:
> On Wed, 2019-11-13 at 10:44 +0100, Anton Yakovlev wrote:
>> On 12.11.2019 19:02, Liam Girdwood wrote:
>>> On Tue, 2019-11-12 at 17:05 +0100, Jean-Philippe Brucker wrote:

snip

>> And here I want to talk about real issue. I already mentioned it a
>> few times:
>> operating system schedulers. You describe low latency solution, but
>> you didn't
>> explain how are you gonna support realtime properties. The closer to
>> hw
>> position we read/write - the easier to miss a deadline.
>>
>=20
> This is hypervisor/HW/guest specific and unrelated to this proposal.
>=20
> In general if I have guest core affinity then hypervisor context
> switching for that guest is in low 10s of uS (depends on hypervisor of
> course and HW). This is good enough for low latency audio.

Honestly, I'm not sure whether this relates to the proposed spec or not.
I want to describe an experiment we conducted regarding possible zero-copy
approach. We had simple audio device in QEmu and simple ALSA driver in virt=
ual=20
guest.

The driver basically allocated a buffer, allowed to mmap it into user-space
application and shared this memory with the device (i.e. device could acces=
s
the whole buffer at any moment of time). Then we shared yet one memory page
where we placed current application pointer value. We did it in order to av=
oid
possible issues with sharing actual ALSA control page. Also, we used
the SNDRV_PCM_INFO_SYNC_APPLPTR feature to enforce the application to notif=
y
kernel on every position update. Thus, we could update our shared applicati=
on
pointer value immediately. As a hardware position we returned estimated one
(frame rate * elapsed time).

On playback stream start, QEmu device activated a dedicated thread (SCHED_F=
IFO
/ high priority) that waked up every 10ms, shifted its own position value t=
o
10ms and compared it with current application pointer value.

In short, we tried to simulate the closest possible HW behavior for zero-co=
py
low latency case. It might be not so perfect, but at least it gave us more =
or
less accurate estimation.

A host had 4 physical cores (2 cores with enabled HT), a guest had 4 vcpus
and we used as a test PA and some low latency applications (like voice call
and so on). And we observed empty buffer ~1-2 times per second. It
would most probably mean underrun conditions if it were a real zero-copy
implementation. Also we found out that different Linux distros as a guest g=
ive
different results (but always not so good for audio). :)

 From other side, we also had a host with 8 physical cores (4 cores with
enabled HT) and a guest had the same 4 vcpus. And there the same setup work=
ed
perfectly.

That's why we are really curious how other people target such issues with
audio virtualization. And that's why I'm not sure about the spec in this
regard. We could say something like "you can activate zero-copy mode, but i=
t's
up to your HW, OS and luck", but it does not sound very nicely.


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

