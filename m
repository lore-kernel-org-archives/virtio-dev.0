Return-Path: virtio-dev-return-7328-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E654C985FB2
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 May 2020 02:09:04 +0000 (UTC)
MIME-Version: 1.0
References: <20200311112004.47138-1-stevensd@chromium.org> <20200311112004.47138-2-stevensd@chromium.org>
 <CAKMK7uHFgiHLe9oiFBr-VR-6rU9-hLTpBTEVNh0ezyj54u70jw@mail.gmail.com>
In-Reply-To: <CAKMK7uHFgiHLe9oiFBr-VR-6rU9-hLTpBTEVNh0ezyj54u70jw@mail.gmail.com>
From: David Stevens <stevensd@chromium.org>
Date: Thu, 14 May 2020 11:08:52 +0900
Message-ID: <CAD=HUj6d9gdZegTGad6thKdHv5b+qOZnkCv5VcWo9AcHifR9uA@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v3 1/4] dma-buf: add support for virtio exported objects
Content-Type: text/plain; charset="UTF-8"
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Tomasz Figa <tfiga@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE, NET..." <virtualization@lists.linux-foundation.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, May 14, 2020 at 12:45 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Wed, Mar 11, 2020 at 12:20 PM David Stevens <stevensd@chromium.org> wrote:
> >
> > This change adds a new dma-buf operation that allows dma-bufs to be used
> > by virtio drivers to share exported objects. The new operation allows
> > the importing driver to query the exporting driver for the UUID which
> > identifies the underlying exported object.
> >
> > Signed-off-by: David Stevens <stevensd@chromium.org>
>
> Adding Tomasz Figa, I've discussed this with him at elce last year I
> think. Just to make sure.
>
> Bunch of things:
> - obviously we need the users of this in a few drivers, can't really
> review anything stand-alone

Here is a link to the usage of this feature by the currently under
development virtio-video driver:
https://markmail.org/thread/j4xlqaaim266qpks

> - adding very specific ops to the generic interface is rather awkward,
> eventually everyone wants that and we end up in a mess. I think the
> best solution here would be if we create a struct virtio_dma_buf which
> subclasses dma-buf, add a (hopefully safe) runtime upcasting
> functions, and then a virtio_dma_buf_get_uuid() function. Just storing
> the uuid should be doable (assuming this doesn't change during the
> lifetime of the buffer), so no need for a callback.

So you would prefer a solution similar to the original version of this
patchset? https://markmail.org/message/z7if4u56q5fmaok4

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

