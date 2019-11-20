Return-Path: virtio-dev-return-6346-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CDB58985E68
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Nov 2019 09:32:43 +0000 (UTC)
Date: Wed, 20 Nov 2019 10:32:38 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191120093238.mvf7myei2oxvrlyq@sirius.home.kraxel.org>
References: <20190924144323.4590-1-Mikhail.Golubev@opensynergy.com>
 <6a4978e85505ae00ca9e2b170f5e893a064c03d2.camel@linux.intel.com>
 <568f32dc-8d82-a189-469f-5cb3a0140b8c@opensynergy.com>
 <0cc8007b70f4f5984223703313730d8e066006a7.camel@linux.intel.com>
 <050946d2-e55e-1104-96ff-a63862c154ab@opensynergy.com>
 <394b40a75959454bc634636d9c99bf9bca98454d.camel@linux.intel.com>
 <b2e8d449-93d6-3452-097b-9df9aa0785cb@opensynergy.com>
 <cf8ca463c132c059ed3c1083af1f278d4568f600.camel@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <cf8ca463c132c059ed3c1083af1f278d4568f600.camel@linux.intel.com>
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> > Then, the I/O queue will multiplex already three things: read
> > requests, write=20
> > requests and notifications. The question is how rational is it.
>=20
> If there is no multiplexing, then we probably need 4 queues per virtual
> PCM:
>=20
> 1) Playback data
> 2) Playback notifications
> 3) Capture data
> 4) Capture notifications
>=20
> additionally, if we include a controls (like volume, mixer etc) we can
> also include:
>=20
> 5) control W data
> 6) control R data
>=20
> Latency is important for 1 - 4 (where multiplexing may not be
> desirable), but 5 & 6 can be easily multiplexed for multiple controls.

You need:

  (1) control queue (guest -> host commands)
  (2) events queue (host -> guest notifications, but see below)
  (3) tx queue (playback)
  (4) rx queue (recording)

You can allow multiple rx/tx pairs, not sure multiqueue support buys us
much for audio though.

The tx/rx queue requests should have three elements: a small request
header (out), a small request status (in), and one (or more) data
buffers (out for tx, in for rx) for the actual sample data (see also
the more verbose comment elsewhere in this thread).

The request status can probably be used to notify the guest about
overruns and underruns, so maybe the event queue is not needed.

> > Yes, we can use device feature bits for this.
>=20
> Can we also include some reserved words to ease spec updates ? e.g.
> guest is using older version of spec than device driver but we still
> want working audio.

feature bits handle this.  The device knows which features are supported
by the driver and can act accordingly.  Reserved fields in structs might
make sense to simplify that (avoid struct layout change depending on
feature bits).

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

