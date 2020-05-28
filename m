Return-Path: virtio-dev-return-7420-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C171698604B
	for <virtio-dev@lists.oasis-open.org>; Thu, 28 May 2020 08:31:29 +0000 (UTC)
Date: Thu, 28 May 2020 10:31:15 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200528083115.a6p3y24x3vqzcj4k@sirius.home.kraxel.org>
References: <20200526105811.30784-1-stevensd@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20200526105811.30784-1-stevensd@chromium.org>
Subject: [virtio-dev] Re: [PATCH v4 0/3] Support virtio cross-device resources
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: David Stevens <stevensd@chromium.org>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, May 26, 2020 at 07:58:08PM +0900, David Stevens wrote:
> This patchset implements the current proposal for virtio cross-device
> resource sharing [1]. It will be used to import virtio resources into
> the virtio-video driver currently under discussion [2]. The patch
> under consideration to add support in the virtio-video driver is [3].
> It uses the APIs from v3 of this series, but the changes to update it
> are relatively minor.
> 
> This patchset adds a new flavor of dma-bufs that supports querying the
> underlying virtio object UUID, as well as adding support for exporting
> resources from virtgpu.
> 
> [1] https://markmail.org/thread/2ypjt5cfeu3m6lxu
> [2] https://markmail.org/thread/p5d3k566srtdtute
> [3] https://markmail.org/thread/j4xlqaaim266qpks
> 
> v3 -> v4 changes:
>  - Replace dma-buf hooks with virtio dma-buf from v1.
>  - Remove virtio_attach callback, as the work that had been done
>    in that callback is now done on dma-buf export. The documented
>    requirement that get_uuid only be called on attached virtio
>    dma-bufs is also removed.
>  - Rebase and add call to virtio_gpu_notify for ASSIGN_UUID.
> 
> David Stevens (3):
>   virtio: add dma-buf support for exported objects
>   virtio-gpu: add VIRTIO_GPU_F_RESOURCE_UUID feature
>   drm/virtio: Support virtgpu exported resources

Looks all sane to me.  mst, have you looked at the virtio core changes?
How we are going to merge this?  If you ack I can merge via
drm-misc-next.  Merging through virtio queue would be fine too.

thanks,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

