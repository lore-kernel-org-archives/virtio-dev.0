Return-Path: virtio-dev-return-6401-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D5308985DB0
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Nov 2019 16:46:58 +0000 (UTC)
Message-ID: <296b7d844a283996a16769ecf3daade5198ae307.camel@linux.intel.com>
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Mon, 25 Nov 2019 16:46:49 +0000
In-Reply-To: <20191120095349.oobeosin3lujgcja@sirius.home.kraxel.org>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
	 <20191106084344.GB189998@stefanha-x1.localdomain>
	 <CAD=HUj41r8wHZ2-By8tLftkoqC5r_Bw=pr=zX2aZ7GTs1ESWhg@mail.gmail.com>
	 <c8a6b6f35664ce036c2a48ec41eab97b0f40704d.camel@linux.intel.com>
	 <CAAfnVBkMWurTpseQFjcna5kk3__40n6M68=RTHLbQsu__2AFxg@mail.gmail.com>
	 <4a5dd822e86757f004d04af62fb7dd35ba75392d.camel@linux.intel.com>
	 <CAAfnVB=F+HeQrrn23c=rZeOa5BfHo=9ArcG--gLf87gqBXfZ9A@mail.gmail.com>
	 <bee3aae13f6cf69ee909aa9884926853d6123b25.camel@linux.intel.com>
	 <20191120095349.oobeosin3lujgcja@sirius.home.kraxel.org>
Mime-Version: 1.0
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>, David Stevens <stevensd@chromium.org>, Stefan Hajnoczi <stefanha@gmail.com>, Keiichi Watanabe <keiichiw@chromium.org>, geoff@hostfission.com, virtio-dev@lists.oasis-open.org, Alex Lau <alexlau@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, qemu-devel@nongnu.org, Tomasz Figa <tfiga@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Dylan Reid <dgreid@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Pawel Osciak <posciak@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 2019-11-20 at 10:53 +0100, Gerd Hoffmann wrote:
>   Hi,
>=20
> > > > DSP FW has no access to userspace so we would need some
> > > > additional
> > > > API
> > > > on top of DMA_BUF_SET_NAME etc to get physical hardware pages ?
> > >=20
> > > The dma-buf api currently can share guest memory sg-lists.
> >=20
> > Ok, IIUC buffers can either be shared using the GPU proposed APIs
> > (above) or using the dma-buf API to share via userspace ? My
> > preference
> > would be to use teh more direct GPU APIs sending physical page
> > addresses from Guest to device driver. I guess this is your use
> > case
> > too ?
>=20
> I'm not convinced this is useful for audio ...
>=20
> I basically see two modes of operation which are useful:
>=20
>   (1) send audio data via virtqueue.
>   (2) map host audio buffers into the guest address space.
>=20
> The audio driver api (i.e. alsa) typically allows to mmap() the audio
> data buffers, so it is the host audio driver which handles the
> allocation.=20

Yes, in regular non VM mode, it's the host driver which allocs the
buffers.

My end goal is to be able to share physical SG pages from host to
guests and HW (including DSP firmwares).=20

>  Let the audio hardware dma from/to userspace-allocated
> buffers is not possible[1], but we would need that to allow qemu (or
> other vmms) use guest-allocated buffers.

My misunderstanding here on how the various proposals being discussed
all pass buffers between guests & host. I'm reading that some are
passing buffers via userspace descriptors and this would not be
workable for audio.

>=20
> cheers,
>   Gerd
>=20
> [1] Disclaimer: It's been a while I looked at alsa more closely, so
>     there is a chance this might have changed without /me noticing.
>=20

Your all good here from audio. Disclaimer: I'm new to virtio.

Liam=20



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

