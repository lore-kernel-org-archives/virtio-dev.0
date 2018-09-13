Return-Path: virtio-dev-return-4846-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A9214985D42
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Sep 2018 08:13:03 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 13 Sep 2018 10:12:55 +0200
Message-Id: <20180913081259.27457-1-kraxel@redhat.com>
Subject: [virtio-dev] [PATCH 0/3] virtio-gpu: add VIRTIO_GPU_F_EDID feature
To: virtio-dev@lists.oasis-open.org, dri-devel@lists.freedesktop.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



Gerd Hoffmann (3):
  drm: virtual connectors can have edid too
  virtio-gpu: add VIRTIO_GPU_F_EDID feature
  drm/virtio: add edid support

 drivers/gpu/drm/virtio/virtgpu_drv.h     |  3 ++
 include/uapi/linux/virtio_gpu.h          | 17 +++++++++
 drivers/gpu/drm/drm_connector.c          |  3 +-
 drivers/gpu/drm/virtio/virtgpu_display.c |  6 ++++
 drivers/gpu/drm/virtio/virtgpu_drv.c     |  1 +
 drivers/gpu/drm/virtio/virtgpu_kms.c     |  8 +++++
 drivers/gpu/drm/virtio/virtgpu_vq.c      | 59 ++++++++++++++++++++++++++++++++
 7 files changed, 95 insertions(+), 2 deletions(-)

-- 
2.9.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

