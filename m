Return-Path: virtio-dev-return-7459-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F3E9D985E7E
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 Jun 2020 09:53:08 +0000 (UTC)
Date: Tue, 9 Jun 2020 05:52:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200609055021-mutt-send-email-mst@kernel.org>
References: <20200609012518.198908-1-stevensd@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20200609012518.198908-1-stevensd@chromium.org>
Subject: [virtio-dev] Re: [PATCH v5 0/3] Support virtio cross-device resources
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: David Stevens <stevensd@chromium.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, Jason Wang <jasowang@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org, alex.williamson@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jun 09, 2020 at 10:25:15AM +0900, David Stevens wrote:
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

Gerd, David, if possible, please test this in configuration with
virtual VTD enabled but with iommu_platform=off
to make sure we didn't break this config.


Besides that, for virtio parts:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> [1] https://markmail.org/thread/2ypjt5cfeu3m6lxu
> [2] https://markmail.org/thread/p5d3k566srtdtute
> [3] https://markmail.org/thread/j4xlqaaim266qpks
> 
> v4 -> v5 changes:
>  - Remove virtio_dma_buf_export_info.
> 
> David Stevens (3):
>   virtio: add dma-buf support for exported objects
>   virtio-gpu: add VIRTIO_GPU_F_RESOURCE_UUID feature
>   drm/virtio: Support virtgpu exported resources
> 
>  drivers/gpu/drm/virtio/virtgpu_drv.c   |  3 +
>  drivers/gpu/drm/virtio/virtgpu_drv.h   | 20 ++++++
>  drivers/gpu/drm/virtio/virtgpu_kms.c   |  4 ++
>  drivers/gpu/drm/virtio/virtgpu_prime.c | 96 +++++++++++++++++++++++++-
>  drivers/gpu/drm/virtio/virtgpu_vq.c    | 55 +++++++++++++++
>  drivers/virtio/Makefile                |  2 +-
>  drivers/virtio/virtio.c                |  6 ++
>  drivers/virtio/virtio_dma_buf.c        | 82 ++++++++++++++++++++++
>  include/linux/virtio.h                 |  1 +
>  include/linux/virtio_dma_buf.h         | 37 ++++++++++
>  include/uapi/linux/virtio_gpu.h        | 19 +++++
>  11 files changed, 321 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/virtio/virtio_dma_buf.c
>  create mode 100644 include/linux/virtio_dma_buf.h
> 
> -- 
> 2.27.0.278.ge193c7cf3a9-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

