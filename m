Return-Path: virtio-dev-return-6663-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 75643985F6B
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Jan 2020 11:26:55 +0000 (UTC)
Date: Wed, 15 Jan 2020 12:26:40 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200115112640.52kemwg4lncuvvir@sirius.home.kraxel.org>
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <7740094.NyiUUSuA9g@os-lin-dmo>
 <20200113095636.blov62o4gbf27om5@sirius.home.kraxel.org>
 <12433898.dW097sEU6C@os-lin-dmo>
 <20200113110521.5ogc3fcy4zq32yzg@sirius.home.kraxel.org>
 <CAAFQd5D16G0E85BCZVx1LXd1TauQH8Lbgs5-0gLv7tNpm4sp_A@mail.gmail.com>
 <20200113132654.r4lhspfx2z7zse2v@sirius.home.kraxel.org>
 <CAAFQd5A3=4JC+3bRf2iw8RwsoB1jJz8p5afi6KaHO6ML2LC0Rg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAFQd5A3=4JC+3bRf2iw8RwsoB1jJz8p5afi6KaHO6ML2LC0Rg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 0/1] VirtIO video device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Tomasz Figa <tfiga@chromium.org>
Cc: Dmitry Sepp <dmitry.sepp@opensynergy.com>, spice-devel@lists.freedesktop.org, Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > If you have (1) hardware you simply can't import buffers with arbitrary
> > plane offsets, so I'd expect software would prefer the single buffer
> > layout (i) over (ii), even when using another driver + dmabuf
> > export/import, to be able to support as much hardware as possible.
> > So (ii) might end up being unused in practice.
> >
> > But maybe not, was just an idea, feel free to scratch it.
>=20
> That's true, simple user space would often do that. However, if more
> devices are in the game, often some extra alignment or padding between
> planes is needed and that is not allowed by (1), even though all the
> planes are in the same buffer.
>=20
> My suggestion, based on the latest V4L2 discussion on unifying the
> UAPI of i) and ii), is that we may want to instead always specify
> buffers on a per-plane basis. Any additional requirements would be
> then validated by the host, which could check if the planes end up in
> the same buffer (or different buffers for (3)) and/or at the right
> offsets.

Hmm, using (ii) the API, then check whenever your three plane buffers
happen to have the correct layout for (1) hardware looks somewhat
backwards to me.

I'd suggest to use (i) API and allow the device specify alignment
requirements.  So (1) hardware would say "need_align=3D0", whereas (3)
hardware would probably say "need_align=3DPAGE_SIZE" so it can easily
split the single buffer into three per-plane buffers.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

