Return-Path: virtio-dev-return-6475-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7453C986088
	for <virtio-dev@lists.oasis-open.org>; Fri,  6 Dec 2019 08:32:18 +0000 (UTC)
Date: Fri, 6 Dec 2019 09:31:58 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191206083158.2efasijbbxdwwww6@sirius.home.kraxel.org>
References: <20191121090403.6vjnovlru4zrmzzs@sirius.home.kraxel.org>
 <84fb109c-1d1e-a52c-8efa-8dcd00b864b3@opensynergy.com>
 <20191122071954.2ar6u3jwwn7yutjt@sirius.home.kraxel.org>
 <770a5ce0-ba97-df47-5d65-67404b7e1bf6@opensynergy.com>
 <20191125093110.vixnxeasmpdfbcxs@sirius.home.kraxel.org>
 <b96600a6-1161-dbaf-c74c-c1bf8331de00@opensynergy.com>
 <20191203090038.2bwfz4br7g4gvnaf@sirius.home.kraxel.org>
 <7237a715-87ae-e5b1-bcd1-55ebd57d4767@opensynergy.com>
 <20191204125259.hykob5tupysatqv2@sirius.home.kraxel.org>
 <ad400a90-4fe9-ef27-92c5-b0518c306652@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <ad400a90-4fe9-ef27-92c5-b0518c306652@opensynergy.com>
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > I don't think there is a use case which guestmem can handle but hostmem
> > can not.
>=20
> There may be a special security requirement like "a guest must not have a=
ny
> access to a host memory" (especially in case of type 1 hv).

Hmm, ok.  Point.

> Also, sharing memory implies sharing of two things: buffer itself and a p=
age
> containing position counter. And it goes in both directions (a host share=
s
> buffer and hardware position or a guest shares buffer and application
> position). And it seems, that overall solution can benefit if there will =
be
> four independent entities. For example, message-based transport can have
> some benefits, if a host will provide its hardware pointer in a shared pa=
ge.

Hmm, I'm not sure mixing things is a good idea.  When using shared
memory I would use it for both data and pointer.

> > > > So, it's not a "here is a buffer, fill it please", "here is the nex=
t,
> > > > ..." ping pong game between driver and device.  There is a queue wi=
th
> > > > multiple buffers instead, and the device fills them one by one.
> > >=20
> > > Then, should we make this pattern to be mandatory?
> >=20
> > It's pretty standard for virtio.  The network receive queue works
> > fundamentally the same way for example, except that network buffers
> > actually might be half-filled only because you get network packets
> > where you don't know the size beforehand instead of a constant stream
> > of sound samples which you can easily pack into buffers as you like.
>=20
> Except the end of the capture stream case. Can we use the len field in
> virtq_used_elem for storing actual captured size then?

Yes.

> > Note that it depends on the use case whenever long latencies are
> > actually worse.  Some use cases don't care much (music playback).  For
> > some use cases it is good enough to know the exact latency so you can
> > take it into account for synchronization (video playback).  Some
> > usecases are pretty much impossible with long latencies (games, voip).
>=20
> By the way, there is a good point here. Maybe it makes sense for the devi=
ce
> somehow reports its current/additionally latency value? Like, as a part o=
f a
> response to the set_params request?

You mean for latencies additional to the ones implied by buffer size?
Yes, that sounds useful.

> > > There's always a trade-off and an implementer might choose
> > > whatever fits better.
> >=20
> > Sure.  But you choose once, when configuring the stream, not for each
> > individual buffer, right?  So the driver will:
> >=20
> >    (1) set-params (including period_bytes), taking into account what
> >        userspace asked for.
> >    (2) queue buffers for the stream, each being period_bytes in size.
> >    (3) start stream.
>=20
> Originally, we introduced period_bytes for enabling period notification
> feature (which is optional). At least, it was not supposed to be used for
> slicing a buffer into pieces (although, the driver may chose to work in t=
his
> way).

Ah, I've missed the detail that you've decoupled buffers and period
notification.  Guess we talked past each other because of that.  So I'm
trying to outline things again, just to be sure we are on the same page:

The driver picks total buffer size (say 16k for example) and period size
(say 2k).  The driver allocates 8 virtio buffers with 2k each.
Allocating one big buffer and slice it works too of course.  Then the
driver goes queue up these 8 virtio buffers to the virtqueue.  The
device returns the filled virtio buffers to the driver.  Then you don't
separate period notification in the first place, you can simply use the
buffer completion notifications for that.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

