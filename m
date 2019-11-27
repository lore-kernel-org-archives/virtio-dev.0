Return-Path: virtio-dev-return-6407-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 61209985ECE
	for <virtio-dev@lists.oasis-open.org>; Wed, 27 Nov 2019 07:58:15 +0000 (UTC)
Date: Wed, 27 Nov 2019 08:58:03 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191127075803.e5i72nzayi4t6aw2@sirius.home.kraxel.org>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain>
 <CAD=HUj41r8wHZ2-By8tLftkoqC5r_Bw=pr=zX2aZ7GTs1ESWhg@mail.gmail.com>
 <c8a6b6f35664ce036c2a48ec41eab97b0f40704d.camel@linux.intel.com>
 <CAAfnVBkMWurTpseQFjcna5kk3__40n6M68=RTHLbQsu__2AFxg@mail.gmail.com>
 <4a5dd822e86757f004d04af62fb7dd35ba75392d.camel@linux.intel.com>
 <CAAfnVB=F+HeQrrn23c=rZeOa5BfHo=9ArcG--gLf87gqBXfZ9A@mail.gmail.com>
 <bee3aae13f6cf69ee909aa9884926853d6123b25.camel@linux.intel.com>
 <20191120095349.oobeosin3lujgcja@sirius.home.kraxel.org>
 <296b7d844a283996a16769ecf3daade5198ae307.camel@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <296b7d844a283996a16769ecf3daade5198ae307.camel@linux.intel.com>
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>, David Stevens <stevensd@chromium.org>, Stefan Hajnoczi <stefanha@gmail.com>, Keiichi Watanabe <keiichiw@chromium.org>, geoff@hostfission.com, virtio-dev@lists.oasis-open.org, Alex Lau <alexlau@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, qemu-devel@nongnu.org, Tomasz Figa <tfiga@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Dylan Reid <dgreid@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Pawel Osciak <posciak@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> > I'm not convinced this is useful for audio ...
> >=20
> > I basically see two modes of operation which are useful:
> >=20
> >   (1) send audio data via virtqueue.
> >   (2) map host audio buffers into the guest address space.
> >=20
> > The audio driver api (i.e. alsa) typically allows to mmap() the audio
> > data buffers, so it is the host audio driver which handles the
> > allocation.=20
>=20
> Yes, in regular non VM mode, it's the host driver which allocs the
> buffers.
>=20
> My end goal is to be able to share physical SG pages from host to
> guests and HW (including DSP firmwares).=20

Yep.  So the host driver would allocate the pages, in a way that the hw
can access them of course.  qemu (or another vmm) would mmap() those
buffer pages, using the usual sound app interface, which would be alsa
on linux.

Virtio got support for shared memory recently (it is in the version 1.2
draft), virtio-pci transport uses a pci bar for the shared memory
regions.  qemu (or other vmms) can use that to map the buffer pages into
guest address space.

There are plans use shared memory in virtio-gpu too, for pretty much the
same reasons.  Some kinds of gpu buffers must be allocated by the host
gpu driver, to make sure the host hardware can use the buffers as
intended.

> >  Let the audio hardware dma from/to userspace-allocated
> > buffers is not possible[1], but we would need that to allow qemu (or
> > other vmms) use guest-allocated buffers.
>=20
> My misunderstanding here on how the various proposals being discussed
> all pass buffers between guests & host. I'm reading that some are
> passing buffers via userspace descriptors and this would not be
> workable for audio.

Yep, dma-buf based buffer passing doesn't help much for audio.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

