Return-Path: virtio-dev-return-6402-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 370FB985DB0
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Nov 2019 16:50:10 +0000 (UTC)
Message-ID: <0db3b7a6dc7f960a71dd062e7a755fe0d5b1f2b5.camel@linux.intel.com>
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Mon, 25 Nov 2019 16:50:04 +0000
In-Reply-To: <07b9804d-2c20-9ff4-a375-2c65f1d27f63@opensynergy.com>
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
	 <07b9804d-2c20-9ff4-a375-2c65f1d27f63@opensynergy.com>
Mime-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 2019-11-20 at 15:24 +0100, Anton Yakovlev wrote:
> this
> regard. We could say something like "you can activate zero-copy mode,
> but it's
> up to your HW, OS and luck", but it does not sound very nicely.

"luck" is a bit unfair here :) But in general it will boil down to
hypervisor, HW and OS config (which will be customised for the
application).

Liam


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

