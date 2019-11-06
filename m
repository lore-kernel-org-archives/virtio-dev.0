Return-Path: virtio-dev-return-6291-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 68C3E985EED
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Nov 2019 12:41:09 +0000 (UTC)
Date: Wed, 6 Nov 2019 13:41:01 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191106124101.fsfxibdkypo4rswv@sirius.home.kraxel.org>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <CAD=HUj7EsxrkSubmY6HE4aYJOykVKtmGXjMjeGqnoJw1KZUc5Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD=HUj7EsxrkSubmY6HE4aYJOykVKtmGXjMjeGqnoJw1KZUc5Q@mail.gmail.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [virtio-dev] Re: guest / host buffer sharing ...
To: David Stevens <stevensd@chromium.org>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Dylan Reid <dgreid@chromium.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>, geoff@hostfission.com, Gurchetan Singh <gurchetansingh@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Nov 06, 2019 at 05:36:22PM +0900, David Stevens wrote:
> > (1) The virtio device
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Has a single virtio queue, so the guest can send commands to register
> > and unregister buffers.  Buffers are allocated in guest ram.  Each buff=
er
> > has a list of memory ranges for the data. Each buffer also has some
>=20
> Allocating from guest ram would work most of the time, but I think
> it's insufficient for many use cases. It doesn't really support things
> such as contiguous allocations, allocations from carveouts or <4GB,
> protected buffers, etc.

If there are additional constrains (due to gpu hardware I guess)
I think it is better to leave the buffer allocation to virtio-gpu.

virtio-gpu can't do that right now, but we have to improve virtio-gpu
memory management for vulkan support anyway.

> > properties to carry metadata, some fixed (id, size, application), but
>=20
> What exactly do you mean by application?

Basically some way to group buffers.  A wayland proxy for example would
add a "application=3Dwayland-proxy" tag to the buffers it creates in the
guest, and the host side part of the proxy could ask qemu (or another
vmm) to notify about all buffers with that tag.  So in case multiple
applications are using the device in parallel they don't interfere with
each other.

> > also allow free form (name =3D value, framebuffers would have
> > width/height/stride/format for example).
>=20
> Is this approach expected to handle allocating buffers with
> hardware-specific constraints such as stride/height alignment or
> tiling? Or would there need to be some alternative channel for
> determining those values and then calculating the appropriate buffer
> size?

No parameter negotiation.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

