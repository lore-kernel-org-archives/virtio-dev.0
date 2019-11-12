Return-Path: virtio-dev-return-6325-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0E1C4985E63
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Nov 2019 16:05:59 +0000 (UTC)
Date: Tue, 12 Nov 2019 17:05:54 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <20191112160554.GA16008@lophozonia>
References: <20190924144323.4590-1-Mikhail.Golubev@opensynergy.com>
 <6a4978e85505ae00ca9e2b170f5e893a064c03d2.camel@linux.intel.com>
 <568f32dc-8d82-a189-469f-5cb3a0140b8c@opensynergy.com>
 <0cc8007b70f4f5984223703313730d8e066006a7.camel@linux.intel.com>
 <20191112110937.GA4187507@lophozonia>
 <0c5939ad0b330bc4f42d63536340293745dce728.camel@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <0c5939ad0b330bc4f42d63536340293745dce728.camel@linux.intel.com>
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Nov 12, 2019 at 02:20:44PM +0000, Liam Girdwood wrote:
> > Other virtio devices rely on the buffer length already provided by
> > virtio
> > for this. For example see the virtio-net control virtqueue
> > (virtio_net_ctrl*), which is extended with new commands from time to
> > time.
> > Most recently, the "receive-side scaling" feature introduces a large
> > structure as payload to virtio_net_ctrl.
> >=20
>=20
> Sorry, not following, what does this have to do with combining type and
> size into request_code ? Or are you saying the size is encoded
> elsewhere in the virtio transport data ?

Yes, the buffer size is encoded in the transport data.

[...]
> This would be a good improvement, it's less copying and would likely
> improve user experience, however the buffer ptr still suffers latency
> as it's queued (same for stream positions going the other way).

Right if the queuing overhead is still too large, then I don't think the
current virtqueues can be used.

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

