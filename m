Return-Path: virtio-dev-return-6343-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B9394985D81
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Nov 2019 16:09:23 +0000 (UTC)
Message-ID: <21039a042ad38302e9dc9010014223d915704b91.camel@linux.intel.com>
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Tue, 19 Nov 2019 16:09:18 +0000
In-Reply-To: <ee52234e-6b53-1f2a-563f-c3dd50dd1764@opensynergy.com>
References: <20190924144323.4590-1-Mikhail.Golubev@opensynergy.com>
	 <6a4978e85505ae00ca9e2b170f5e893a064c03d2.camel@linux.intel.com>
	 <568f32dc-8d82-a189-469f-5cb3a0140b8c@opensynergy.com>
	 <0cc8007b70f4f5984223703313730d8e066006a7.camel@linux.intel.com>
	 <20191112110937.GA4187507@lophozonia>
	 <0c5939ad0b330bc4f42d63536340293745dce728.camel@linux.intel.com>
	 <20191112160554.GA16008@lophozonia>
	 <4ca16fb1d412bc92a2a65104680282b80742f6b1.camel@linux.intel.com>
	 <ee52234e-6b53-1f2a-563f-c3dd50dd1764@opensynergy.com>
Mime-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 2019-11-13 at 10:44 +0100, Anton Yakovlev wrote:
> On 12.11.2019 19:02, Liam Girdwood wrote:
> > On Tue, 2019-11-12 at 17:05 +0100, Jean-Philippe Brucker wrote:
> > > > This would be a good improvement, it's less copying and would
> > > > likely
> > > > improve user experience, however the buffer ptr still suffers
> > > > latency
> > > > as it's queued (same for stream positions going the other way).
> > >=20
> > > Right if the queuing overhead is still too large, then I don't
> > > think
> > > the
> > > current virtqueues can be used.
> >=20
> > They can be used for non low latency audio, I don't see any issues
> > if
> > latency is not important. e.g. media playback, some gaming, most
> > system
> > notifications.
>=20
> It can support low latency as well.=20

Not really, without zero copy buffering and immediate position
reporting it's difficult to get latency below a certain threshold. As
discussed most use cases don't care, but some use cases do.=20

> We are not talking about high-throughput=20
> device like block or network devices. Bit stream here is constant and
> quite=20
> low (in compare with), so it's not a problem even with message based
> approach=20
> to write/read frames near actual hw pointer.
>=20

Throughput has no relation to latency. MMC cards have a great
throughput but have high latency. e.g. recording a WAV to MMC using a
small application buffer (say 8 - 16k) will consistently overflow the
buffer since MMC write latency is poor (but once your start writing
throughput is very high).=20

> And here I want to talk about real issue. I already mentioned it a
> few times:=20
> operating system schedulers. You describe low latency solution, but
> you didn't=20
> explain how are you gonna support realtime properties. The closer to
> hw=20
> position we read/write - the easier to miss a deadline.
>=20

This is hypervisor/HW/guest specific and unrelated to this proposal.=20

In general if I have guest core affinity then hypervisor context
switching for that guest is in low 10s of uS (depends on hypervisor of
course and HW). This is good enough for low latency audio.

> The fact: tasks can be delayed. Using RT-schedulers in soft realtime
> OSes does=20
> not help much, since they do not give you any guarantees. Thus, delay
> can be=20
> random and quite big, and it fully depends on number of available
> cores (and=20
> their speed). If a VM has dedicated cores, it's great. But usually
> for type 2=20
> hv we will have shared cores, that makes situation even worse.
>=20
> Since low latency applications in a guest are not virtualization-
> awared, they
> will push latency to the limit. From other side, virtio driver is=20
> virtualization-awared and could assist somehow. In our draft solution
> with=20
> message based approach we artificially increase a latency to an
> extent=20
> allowing to avoid xrun condition due to the worst possible delay
> (just put=20
> additional silence at the beginning of a stream). And it's still far
> from=20
> ideal, since a length of that additional latency highly depends on
> hardware=20
> and virtualization setup.

I'm saying there is nothing wrong with the message based approach for
most use cases. We just need to build in support (to the configuration
structures) for zero copy and immediate position reporting so that
guests/drivers that can support it can use it.

I would like the PCM configuration data to be robust enough to be able
to report such capabilities and for guests to configure these
capabilities if supported. I know a lot of the buffer sharing APIs are
at proposal stage, so I think we are good as long as we have headroom
to add these later (without breaking any backward compatibility).

Thanks

Liam


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

