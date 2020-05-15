Return-Path: virtio-dev-return-7344-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7EEA5986048
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 May 2020 05:07:20 +0000 (UTC)
MIME-Version: 1.0
References: <20200311112004.47138-1-stevensd@chromium.org> <20200311112004.47138-2-stevensd@chromium.org>
 <CAKMK7uHFgiHLe9oiFBr-VR-6rU9-hLTpBTEVNh0ezyj54u70jw@mail.gmail.com>
 <CAD=HUj6k-y1=64zY8ZFOQBZ7WSUWiQfvkiTpXXt10JB_CGqk1A@mail.gmail.com> <20200514123007.GP206103@phenom.ffwll.local>
In-Reply-To: <20200514123007.GP206103@phenom.ffwll.local>
From: David Stevens <stevensd@chromium.org>
Date: Fri, 15 May 2020 14:07:06 +0900
Message-ID: <CAD=HUj7452eFfn9i=JWm54Mke3Lew-7AWYeoKZLAjCSg7eLO6A@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v3 1/4] dma-buf: add support for virtio exported objects
Content-Type: text/plain; charset="UTF-8"
To: David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE, NET..." <virtualization@lists.linux-foundation.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, virtio-dev@lists.oasis-open.org
Cc: Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, May 14, 2020 at 9:30 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, May 14, 2020 at 05:19:40PM +0900, David Stevens wrote:
> > Sorry for the duplicate reply, didn't notice this until now.
> >
> > > Just storing
> > > the uuid should be doable (assuming this doesn't change during the
> > > lifetime of the buffer), so no need for a callback.
> >
> > Directly storing the uuid doesn't work that well because of
> > synchronization issues. The uuid needs to be shared between multiple
> > virtio devices with independent command streams, so to prevent races
> > between importing and exporting, the exporting driver can't share the
> > uuid with other drivers until it knows that the device has finished
> > registering the uuid. That requires a round trip to and then back from
> > the device. Using a callback allows the latency from that round trip
> > registration to be hidden.
>
> Uh, that means you actually do something and there's locking involved.
> Makes stuff more complicated, invariant attributes are a lot easier
> generally. Registering that uuid just always doesn't work, and blocking
> when you're exporting?

Registering the id at creation and blocking in gem export is feasible,
but it doesn't work well for systems with a centralized buffer
allocator that doesn't support batch allocations (e.g. gralloc). In
such a system, the round trip latency would almost certainly be
included in the buffer allocation time. At least on the system I'm
working on, I suspect that would add 10s of milliseconds of startup
latency to video pipelines (although I haven't benchmarked the
difference). Doing the blocking as late as possible means most or all
of the latency can be hidden behind other pipeline setup work.

In terms of complexity, I think the synchronization would be basically
the same in either approach, just in different locations. All it would
do is alleviate the need for a callback to fetch the UUID.

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

