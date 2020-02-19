Return-Path: virtio-dev-return-6759-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DB920985EA8
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Feb 2020 08:08:17 +0000 (UTC)
From: David Stevens <stevensd@chromium.org>
Date: Wed, 19 Feb 2020 17:06:35 +0900
Message-Id: <20200219080637.61312-1-stevensd@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 0/2] Support virtio cross-device resources
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, David Stevens <stevensd@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

This patchset implements the current proposal for virtio cross-device
resource sharing [1], with minor changes based on recent comments (i.e.
renumbering the new virtio gpu command and adding a feature flag).

The patchset adds a new flavor of dma-bufs that supports querying the
underlying virtio object UUID, as well as adding support for exporting
resources from virtgpu. It is expected that this will be used to import
virtgpu resources into the virtio-video driver currently under
discussion [2].

[1] https://markmail.org/thread/jsaoqy7phrqdcpqu
[2] https://markmail.org/thread/p5d3k566srtdtute

David Stevens (2):
  virtio: add dma-buf support for exported objects
  drm/virtio: Support virtgpu exported resources

 drivers/gpu/drm/virtio/virtgpu_drv.c   |   3 +
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  21 +++++
 drivers/gpu/drm/virtio/virtgpu_kms.c   |   4 +
 drivers/gpu/drm/virtio/virtgpu_prime.c | 109 ++++++++++++++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_vq.c    |  58 +++++++++++++
 drivers/virtio/Makefile                |   2 +-
 drivers/virtio/virtio.c                |   6 ++
 drivers/virtio/virtio_dma_buf.c        |  97 ++++++++++++++++++++++
 include/linux/virtio.h                 |   1 +
 include/linux/virtio_dma_buf.h         |  62 ++++++++++++++
 include/uapi/linux/virtio_gpu.h        |  19 +++++
 11 files changed, 378 insertions(+), 4 deletions(-)
 create mode 100644 drivers/virtio/virtio_dma_buf.c
 create mode 100644 include/linux/virtio_dma_buf.h

--=20
2.25.0.265.gbab2e86ba0-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

