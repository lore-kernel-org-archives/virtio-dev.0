Return-Path: virtio-dev-return-6293-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 33EB7985EFA
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Nov 2019 06:48:31 +0000 (UTC)
Date: Thu, 7 Nov 2019 07:48:17 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191107064817.j3sfzl6viea4qigc@sirius.home.kraxel.org>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <CAD=HUj7EsxrkSubmY6HE4aYJOykVKtmGXjMjeGqnoJw1KZUc5Q@mail.gmail.com>
 <20191106124101.fsfxibdkypo4rswv@sirius.home.kraxel.org>
 <72712fe048af1489368f7416faa92c45@hostfission.com>
MIME-Version: 1.0
In-Reply-To: <72712fe048af1489368f7416faa92c45@hostfission.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [virtio-dev] Re: guest / host buffer sharing ...
To: Geoffrey McRae <geoff@hostfission.com>
Cc: David Stevens <stevensd@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Dylan Reid <dgreid@chromium.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

> On 2019-11-06 23:41, Gerd Hoffmann wrote:
> > On Wed, Nov 06, 2019 at 05:36:22PM +0900, David Stevens wrote:
> > > > (1) The virtio device
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > Has a single virtio queue, so the guest can send commands to regist=
er
> > > > and unregister buffers.  Buffers are allocated in guest ram.  Each =
buffer
> > > > has a list of memory ranges for the data. Each buffer also has some
> > >=20
> > > Allocating from guest ram would work most of the time, but I think
> > > it's insufficient for many use cases. It doesn't really support thing=
s
> > > such as contiguous allocations, allocations from carveouts or <4GB,
> > > protected buffers, etc.
> >=20
> > If there are additional constrains (due to gpu hardware I guess)
> > I think it is better to leave the buffer allocation to virtio-gpu.
>=20
> The entire point of this for our purposes is due to the fact that we can
> not allocate the buffer, it's either provided by the GPU driver or
> DirectX. If virtio-gpu were to allocate the buffer we might as well forge=
t
> all this and continue using the ivshmem device.

Well, virtio-gpu resources are in guest ram, like the buffers of a
virtio-buffers device would be.  So it isn't much of a difference.  If
the buffer provided by the (nvidia/amd/intel) gpu driver lives in ram
you can create a virtio-gpu resource for it.

On the linux side that is typically handled with dma-buf, one driver
exports the dma-buf and the other imports it.  virtio-gpu doesn't
support that fully yet though (import is being worked on, export is done
and will land upstream in the next merge window).

No clue how this looks like for windows guests ...

> Currently IVSHMEM is used by two projects that I am aware of, Looking
> Glass and SCREAM. While Looking Glass is solving a problem that is out of
> scope for QEMU, SCREAM is working around the audio problems in QEMU that
> have been present for years now.

Side note: sound in qemu 3.1+ should be alot better than in 2.x
versions.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

