Return-Path: virtio-dev-return-4811-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 643CA985EBD
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Aug 2018 12:20:30 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 29 Aug 2018 14:20:24 +0200
Message-Id: <20180829122026.27012-1-kraxel@redhat.com>
Subject: [virtio-dev] [PATCH 0/2] drm/virtio: add iommu support.
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



Gerd Hoffmann (2):
  drm/virtio: add virtio_gpu_object_detach() function
  drm/virtio: add iommu support.

 drivers/gpu/drm/virtio/virtgpu_drv.h |  5 ++--
 drivers/gpu/drm/virtio/virtgpu_fb.c  |  2 +-
 drivers/gpu/drm/virtio/virtgpu_ttm.c |  3 +--
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 52 +++++++++++++++++++++++++++++-------
 4 files changed, 48 insertions(+), 14 deletions(-)

-- 
2.9.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

