Return-Path: virtio-dev-return-6326-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 46A74985ED0
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Nov 2019 18:02:12 +0000 (UTC)
Message-ID: <4ca16fb1d412bc92a2a65104680282b80742f6b1.camel@linux.intel.com>
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Tue, 12 Nov 2019 18:02:06 +0000
In-Reply-To: <20191112160554.GA16008@lophozonia>
References: <20190924144323.4590-1-Mikhail.Golubev@opensynergy.com>
	 <6a4978e85505ae00ca9e2b170f5e893a064c03d2.camel@linux.intel.com>
	 <568f32dc-8d82-a189-469f-5cb3a0140b8c@opensynergy.com>
	 <0cc8007b70f4f5984223703313730d8e066006a7.camel@linux.intel.com>
	 <20191112110937.GA4187507@lophozonia>
	 <0c5939ad0b330bc4f42d63536340293745dce728.camel@linux.intel.com>
	 <20191112160554.GA16008@lophozonia>
Mime-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 2019-11-12 at 17:05 +0100, Jean-Philippe Brucker wrote:
> > This would be a good improvement, it's less copying and would
> > likely
> > improve user experience, however the buffer ptr still suffers
> > latency
> > as it's queued (same for stream positions going the other way).
>=20
> Right if the queuing overhead is still too large, then I don't think
> the
> current virtqueues can be used.

They can be used for non low latency audio, I don't see any issues if
latency is not important. e.g. media playback, some gaming, most system
notifications.

Liam=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

