Return-Path: virtio-dev-return-6362-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CC0C3985E8D
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Nov 2019 09:04:10 +0000 (UTC)
Date: Thu, 21 Nov 2019 10:04:03 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191121090403.6vjnovlru4zrmzzs@sirius.home.kraxel.org>
References: <6a4978e85505ae00ca9e2b170f5e893a064c03d2.camel@linux.intel.com>
 <568f32dc-8d82-a189-469f-5cb3a0140b8c@opensynergy.com>
 <0cc8007b70f4f5984223703313730d8e066006a7.camel@linux.intel.com>
 <20191112110937.GA4187507@lophozonia>
 <0c5939ad0b330bc4f42d63536340293745dce728.camel@linux.intel.com>
 <20191112160554.GA16008@lophozonia>
 <4ca16fb1d412bc92a2a65104680282b80742f6b1.camel@linux.intel.com>
 <ee52234e-6b53-1f2a-563f-c3dd50dd1764@opensynergy.com>
 <21039a042ad38302e9dc9010014223d915704b91.camel@linux.intel.com>
 <07b9804d-2c20-9ff4-a375-2c65f1d27f63@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <07b9804d-2c20-9ff4-a375-2c65f1d27f63@opensynergy.com>
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > In general if I have guest core affinity then hypervisor context
> > switching for that guest is in low 10s of uS (depends on hypervisor
> > of course and HW). This is good enough for low latency audio.

> That's why we are really curious how other people target such issues
> with audio virtualization. And that's why I'm not sure about the spec
> in this regard. We could say something like "you can activate
> zero-copy mode, but it's up to your HW, OS and luck", but it does not
> sound very nicely.

real-time stuff in virtual machines is tricky, and real-time audio isn't
special here.  I don't think there is a need to discuss that in the
device specification.

The part which is important for the virtual hardware is to design the it
in a way that the number of context switches (system calls, vmexits) is
minimized.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

