Return-Path: virtio-dev-return-4899-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7CD21985E78
	for <virtio-dev@lists.oasis-open.org>; Thu, 18 Oct 2018 06:40:49 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 18 Oct 2018 08:39:45 +0200
Message-Id: <20181018063946.22919-1-kraxel@redhat.com>
Subject: [virtio-dev] [PATCH v3] virtio-gpu: add VIRTIO_GPU_F_EDID feature
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

Just noticed I had the wrong email address for the virtio-dev
list in v2.  So, resending.  Relates bits:

Guest driver patch implementing this:
  https://git.kraxel.org/cgit/linux/log/?h=drm-edid-virtio

Qemu test branch:
  https://git.kraxel.org/cgit/qemu/log/?h=sirius/edid

virtio spec update:
  https://git.kraxel.org/cgit/virtio-spec/log/?h=virtio-gpu

cheers,
  Gerd

Gerd Hoffmann (1):
  virtio-gpu: add VIRTIO_GPU_F_EDID feature

 include/uapi/linux/virtio_gpu.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.9.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

