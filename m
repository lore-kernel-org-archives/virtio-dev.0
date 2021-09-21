Return-Path: <virtio-dev-return-8690-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B358D98636B
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Sep 2021 23:20:28 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Tue, 21 Sep 2021 16:20:12 -0700
Message-Id: <20210921232024.817-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 00/12] Context types, v3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Version 2 of context types:

https://lists.oasis-open.org/archives/virtio-dev/202108/msg00141.html

Changes since RFC:
   * le32 info --> {u8 ring_idx + u8 padding[3]).
   * Max rings is now 64.

Changes since v1:
   * Document plan regarding context types + display combinations that
     need implicit sync in patch 9.

Changes since v2:
   * u8 ring_idx --> __u8 ring_idx to fix buildbot issues

Anthoine Bourgeois (2):
  drm/virtio: implement context init: probe for feature
  drm/virtio: implement context init: support init ioctl

Gurchetan Singh (10):
  virtio-gpu api: multiple context types with explicit initialization
  drm/virtgpu api: create context init feature
  drm/virtio: implement context init: track valid capabilities in a mask
  drm/virtio: implement context init: track {ring_idx, emit_fence_info}
    in virtio_gpu_fence
  drm/virtio: implement context init: plumb {base_fence_ctx, ring_idx}
    to virtio_gpu_fence_alloc
  drm/virtio: implement context init: stop using drv->context when
    creating fence
  drm/virtio: implement context init: allocate an array of fence
    contexts
  drm/virtio: implement context init: handle
    VIRTGPU_CONTEXT_PARAM_POLL_RINGS_MASK
  drm/virtio: implement context init: add virtio_gpu_fence_event
  drm/virtio: implement context init: advertise feature to userspace

 drivers/gpu/drm/virtio/virtgpu_debugfs.c |   1 +
 drivers/gpu/drm/virtio/virtgpu_drv.c     |  44 ++++-
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  28 +++-
 drivers/gpu/drm/virtio/virtgpu_fence.c   |  30 +++-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   | 195 +++++++++++++++++++++--
 drivers/gpu/drm/virtio/virtgpu_kms.c     |  26 ++-
 drivers/gpu/drm/virtio/virtgpu_plane.c   |   3 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c      |  19 +--
 include/uapi/drm/virtgpu_drm.h           |  27 ++++
 include/uapi/linux/virtio_gpu.h          |  18 ++-
 10 files changed, 355 insertions(+), 36 deletions(-)

--=20
2.33.0.464.g1972c5931b-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

