Return-Path: virtio-dev-return-6287-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A9E60985EE3
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Nov 2019 08:36:35 +0000 (UTC)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
In-Reply-To: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
From: David Stevens <stevensd@chromium.org>
Date: Wed, 6 Nov 2019 17:36:22 +0900
Message-ID: <CAD=HUj7EsxrkSubmY6HE4aYJOykVKtmGXjMjeGqnoJw1KZUc5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: guest / host buffer sharing ...
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Dylan Reid <dgreid@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>, geoff@hostfission.com, Gurchetan Singh <gurchetansingh@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

> (1) The virtio device
> =====================
>
> Has a single virtio queue, so the guest can send commands to register
> and unregister buffers.  Buffers are allocated in guest ram.  Each buffer
> has a list of memory ranges for the data. Each buffer also has some

Allocating from guest ram would work most of the time, but I think
it's insufficient for many use cases. It doesn't really support things
such as contiguous allocations, allocations from carveouts or <4GB,
protected buffers, etc.

> properties to carry metadata, some fixed (id, size, application), but

What exactly do you mean by application?

> also allow free form (name = value, framebuffers would have
> width/height/stride/format for example).

Is this approach expected to handle allocating buffers with
hardware-specific constraints such as stride/height alignment or
tiling? Or would there need to be some alternative channel for
determining those values and then calculating the appropriate buffer
size?

-David

On Tue, Nov 5, 2019 at 7:55 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi folks,
>
> The issue of sharing buffers between guests and hosts keeps poping
> up again and again in different contexts.  Most recently here:
>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg656685.html
>
> So, I'm grabbing the recipient list of the virtio-vdec thread and some
> more people I know might be interested in this, hoping to have everyone
> included.
>
> Reason is:  Meanwhile I'm wondering whenever "just use virtio-gpu
> resources" is really a good answer for all the different use cases
> we have collected over time.  Maybe it is better to have a dedicated
> buffer sharing virtio device?  Here is the rough idea:
>
>
> (1) The virtio device
> =====================
>
> Has a single virtio queue, so the guest can send commands to register
> and unregister buffers.  Buffers are allocated in guest ram.  Each buffer
> has a list of memory ranges for the data.  Each buffer also has some
> properties to carry metadata, some fixed (id, size, application), but
> also allow free form (name = value, framebuffers would have
> width/height/stride/format for example).
>
>
> (2) The linux guest implementation
> ==================================
>
> I guess I'd try to make it a drm driver, so we can re-use drm
> infrastructure (shmem helpers for example).  Buffers are dumb drm
> buffers.  dma-buf import and export is supported (shmem helpers
> get us that for free).  Some device-specific ioctls to get/set
> properties and to register/unregister the buffers on the host.
>
>
> (3) The qemu host implementation
> ================================
>
> qemu (likewise other vmms) can use the udmabuf driver to create
> host-side dma-bufs for the buffers.  The dma-bufs can be passed to
> anyone interested, inside and outside qemu.  We'll need some protocol
> for communication between qemu and external users interested in those
> buffers, to receive dma-bufs (via unix file descriptor passing) and
> update notifications.  Dispatching updates could be done based on the
> application property, which could be "virtio-vdec" or "wayland-proxy"
> for example.
>
>
> commments?
>
> cheers,
>   Gerd
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

