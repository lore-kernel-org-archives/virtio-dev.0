Return-Path: virtio-dev-return-4918-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 009BC985A65
	for <virtio-dev@lists.oasis-open.org>; Tue, 30 Oct 2018 06:32:11 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 30 Oct 2018 07:32:04 +0100
Message-Id: <20181030063206.19528-1-kraxel@redhat.com>
Subject: [virtio-dev] [PATCH v4 0/2] virtio-gpu: add VIRTIO_GPU_F_EDID feature
To: virtio-dev@lists.oasis-open.org, dri-devel@lists.freedesktop.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This little patch series implements the VIRTIO_GPU_F_EDID feature for
linux.  Patch #1 updates the virtio_gpu header file according to the
specification, patch #3 is the actual implementation.

The spec update patch is here:
  https://lists.oasis-open.org/archives/virtio-dev/201810/msg00028.html

Qemu branch for testing is here:
  https://git.kraxel.org/cgit/qemu/log/?h=sirius/edid

cheers,
  Gerd

Gerd Hoffmann (2):
  virtio-gpu: add VIRTIO_GPU_F_EDID feature
  drm/virtio: add edid support

 drivers/gpu/drm/virtio/virtgpu_drv.h     |  3 ++
 include/uapi/linux/virtio_gpu.h          | 18 +++++++++
 drivers/gpu/drm/virtio/virtgpu_display.c | 12 ++++++
 drivers/gpu/drm/virtio/virtgpu_drv.c     |  1 +
 drivers/gpu/drm/virtio/virtgpu_kms.c     |  8 ++++
 drivers/gpu/drm/virtio/virtgpu_vq.c      | 67 ++++++++++++++++++++++++++++++++
 6 files changed, 109 insertions(+)

-- 
2.9.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

