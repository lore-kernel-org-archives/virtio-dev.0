Return-Path: virtio-dev-return-6342-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 09E15985D81
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Nov 2019 15:49:31 +0000 (UTC)
Message-ID: <cf8ca463c132c059ed3c1083af1f278d4568f600.camel@linux.intel.com>
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Tue, 19 Nov 2019 15:49:24 +0000
In-Reply-To: <b2e8d449-93d6-3452-097b-9df9aa0785cb@opensynergy.com>
References: <20190924144323.4590-1-Mikhail.Golubev@opensynergy.com>
	 <6a4978e85505ae00ca9e2b170f5e893a064c03d2.camel@linux.intel.com>
	 <568f32dc-8d82-a189-469f-5cb3a0140b8c@opensynergy.com>
	 <0cc8007b70f4f5984223703313730d8e066006a7.camel@linux.intel.com>
	 <050946d2-e55e-1104-96ff-a63862c154ab@opensynergy.com>
	 <394b40a75959454bc634636d9c99bf9bca98454d.camel@linux.intel.com>
	 <b2e8d449-93d6-3452-097b-9df9aa0785cb@opensynergy.com>
Mime-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 2019-11-13 at 10:05 +0100, Anton Yakovlev wrote:
> > > > >=20
> > > > > Since xrun conditions are higher level conceptions, we
> > > > > decided to
> > > > > delegate
> > > > > such issues to guest application itself. It helps to make
> > > > > overall
> > > > > design
> > > > > simpler. And it seems there's not so much we can do if xrun
> > > > > condition
> > > > > is
> > > > > happened on the device side.
> > > >=20
> > > > We can inform the guest. The guest userspace can then take any
> > > > remedial
> > > > action if needed.
> > >=20
> > > Then, we need the third queue for notifications.
> >=20
> > Why, this should go in the queue that's used for stream position ?
>=20
> Then, the I/O queue will multiplex already three things: read
> requests, write=20
> requests and notifications. The question is how rational is it.

If there is no multiplexing, then we probably need 4 queues per virtual
PCM:

1) Playback data
2) Playback notifications
3) Capture data
4) Capture notifications

additionally, if we include a controls (like volume, mixer etc) we can
also include:

5) control W data
6) control R data

Latency is important for 1 - 4 (where multiplexing may not be
desirable), but 5 & 6 can be easily multiplexed for multiple controls.

>=20
>=20
> > >=20
> > >=20
> > > > >=20
> > > > >=20
> > > > > > 2) Zero copy of audio data and stream positions. Essential
> > > > > > for
> > > > > > any
> > > > > > low
> > > > > > latency audio use cases (if supported by HW, hypervisor, VM
> > > > > > framework).
> > > > >=20
> > > > > What do you mean by zero-copy? Shared memory between device
> > > > > and
> > > > > driver sides?
> > > >=20
> > > > Yes, but I see this is now a separate thread as it used by
> > > > others
> > > > too.
> > >=20
> > > Shared memory based approach was proposed in the very first
> > > version
> > > of the
> > > spec (and we are rooting for this). Then there was discussion and
> > > it
> > > was
> > > postponed for some future virtio device. One of the reason - it's
> > > not
> > > suitable
> > > for arch with non-coherent memory between host and guest.
> >=20
> > I'm rooting for this too. I do think we need to be a bit more
> > flexible
> > so we can deal with non coherent architectures via a SW virtio copy
> > and
> > support coherent architectures via zero copy.
> >=20
> > We should be good as long as we can leave some configuration
> > space/types in the stream config to allow mapping of operating
> > modes
> > (zero copy, periodic, mmap etc). The device driver should also send
> > it's capabilities during init so that guests will know what use
> > cases
> > and modes are supported.
>=20
> Yes, we can use device feature bits for this.

Can we also include some reserved words to ease spec updates ? e.g.
guest is using older version of spec than device driver but we still
want working audio.

Thanks

Liam=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

