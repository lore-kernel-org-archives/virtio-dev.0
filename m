Return-Path: virtio-dev-return-7333-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4FF7A985FC2
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 May 2020 08:19:52 +0000 (UTC)
MIME-Version: 1.0
References: <20200311112004.47138-1-stevensd@chromium.org> <20200311112004.47138-2-stevensd@chromium.org>
 <CAKMK7uHFgiHLe9oiFBr-VR-6rU9-hLTpBTEVNh0ezyj54u70jw@mail.gmail.com>
In-Reply-To: <CAKMK7uHFgiHLe9oiFBr-VR-6rU9-hLTpBTEVNh0ezyj54u70jw@mail.gmail.com>
From: David Stevens <stevensd@chromium.org>
Date: Thu, 14 May 2020 17:19:40 +0900
Message-ID: <CAD=HUj6k-y1=64zY8ZFOQBZ7WSUWiQfvkiTpXXt10JB_CGqk1A@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v3 1/4] dma-buf: add support for virtio exported objects
Content-Type: text/plain; charset="UTF-8"
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Tomasz Figa <tfiga@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE, NET..." <virtualization@lists.linux-foundation.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Sorry for the duplicate reply, didn't notice this until now.

> Just storing
> the uuid should be doable (assuming this doesn't change during the
> lifetime of the buffer), so no need for a callback.

Directly storing the uuid doesn't work that well because of
synchronization issues. The uuid needs to be shared between multiple
virtio devices with independent command streams, so to prevent races
between importing and exporting, the exporting driver can't share the
uuid with other drivers until it knows that the device has finished
registering the uuid. That requires a round trip to and then back from
the device. Using a callback allows the latency from that round trip
registration to be hidden.

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

