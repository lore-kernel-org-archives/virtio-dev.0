Return-Path: virtio-dev-return-6915-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 83ACC985FD7
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Mar 2020 11:20:19 +0000 (UTC)
From: David Stevens <stevensd@chromium.org>
Date: Wed, 11 Mar 2020 20:20:00 +0900
Message-Id: <20200311112004.47138-1-stevensd@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 0/4] Support virtio cross-device resources
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Stevens <stevensd@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

This patchset implements the current proposal for virtio cross-device
resource sharing [1], with minor changes based on recent comments. It
is expected that this will be used to import virtio resources into the
virtio-video driver currently under discussion [2].

This patchset adds a new hook to dma-buf, for querying the dma-buf's
underlying virtio UUID. This hook is then plumbed through DRM PRIME
buffers, and finally implemented in virtgpu.

[1] https://markmail.org/thread/jsaoqy7phrqdcpqu
[2] https://markmail.org/thread/p5d3k566srtdtute

v2 -> v3 changes:
 - Remove ifdefs.
 - Simplify virtgpu_gem_prime_export as it can only be called once.
 - Use virtio_gpu_vbuffer's objs field instead of abusing data_buf.

David Stevens (4):
  dma-buf: add support for virtio exported objects
  drm/prime: add support for virtio exported objects
  virtio-gpu: add VIRTIO_GPU_F_RESOURCE_UUID feature
  drm/virtio: Support virtgpu exported resources

 drivers/dma-buf/dma-buf.c              | 12 ++++++
 drivers/gpu/drm/drm_prime.c            | 23 +++++++++++
 drivers/gpu/drm/virtio/virtgpu_drv.c   |  3 ++
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 18 +++++++++
 drivers/gpu/drm/virtio/virtgpu_kms.c   |  4 ++
 drivers/gpu/drm/virtio/virtgpu_prime.c | 41 +++++++++++++++++--
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 55 ++++++++++++++++++++++++++
 include/drm/drm_drv.h                  | 10 +++++
 include/linux/dma-buf.h                | 18 +++++++++
 include/uapi/linux/virtio_gpu.h        | 19 +++++++++
 10 files changed, 200 insertions(+), 3 deletions(-)

--=20
2.25.1.481.gfbce0eb801-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

