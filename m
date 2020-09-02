Return-Path: virtio-dev-return-7733-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D35F985EC1
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Sep 2020 21:08:52 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed,  2 Sep 2020 14:08:24 -0700
Message-Id: <20200902210847.2689-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 00/23] Blob prerequisites + blob resources
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: sebastien.boeuf@intel.com, kraxel@redhat.com, vgoyal@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This is the latest iteration of the blob series.  Changes since last time
include:

* RESOURCE_ASSIGN_UUID now merged (thanks kraxel@ and stevensd@!).

* some additional virtgpu prep patches -- not completely related to blob
  but not completely unrelated either.

* v3 of shm region series that Vivek sent out, with mst@'s acks.
  I think the plan is to merge this in 5.10.  After reading up on Linux
  kernel flow, I think merging to drm-misc-next now will accomplish the
  same effect ;-) ??

* applied checkpatch --strict fixes.  Ignored some messages that
  conflicted with existing code or didn't make sense.

* fixed some issues raised by the kbuildbot.

For further details on blob resources and links to open-source userspaces,
please refer to the original description [1].  The entire tree is
available at [2].

[1] https://lists.freedesktop.org/archives/dri-devel/2020-August/275972.htm=
l
[2] https://gitlab.freedesktop.org/virgl/drm-misc-next/-/commits/resource-b=
lob

Doug Horn (1):
  Fix use after free in get_capset_info callback.

Gerd Hoffmann (6):
  virtio-gpu api: blob resources
  virtio-gpu api: host visible feature
  drm/virtio: implement blob resources: probe for the feature.
  drm/virtio: implement blob resources: probe for host visible region
  drm/virtio: implement blob resources: implement vram object
  drm/virtio: implement blob resources: resource create blob ioctl

Gurchetan Singh (13):
  drm/virtio: fix uninitialized variable
  drm/virtio: report uuid in debugfs
  drm/virtio: blob prep: refactor getting pages and attaching backing
  drm/virtio: blob prep: make CPU responses more generic
  virtio-gpu api: cross-device feature
  drm/virtio: implement blob resources: expose
    virtio_gpu_resource_id_get
  drm/virtio: implement blob resources: add new fields to internal
    structs
  drm/virtio: implement blob resources: hypercall interface
  drm/virtio: implement blob resources: blob display integration
  drm/virtio: implement blob resources: refactor UUID code somewhat
  drm/virtio: implement blob resources: fix stride discrepancy
  drm/virtio: implement blob resources: report blob mem to userspace
  drm/virtio: advertise features to userspace

Sebastien Boeuf (3):
  virtio: Add get_shm_region method
  virtio: Implement get_shm_region for PCI transport
  virtio: Implement get_shm_region for MMIO transport

 drivers/gpu/drm/virtio/Makefile          |   2 +-
 drivers/gpu/drm/virtio/virtgpu_debugfs.c |  27 +++-
 drivers/gpu/drm/virtio/virtgpu_drv.c     |   1 +
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  79 ++++++++--
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   | 185 ++++++++++++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_kms.c     |  45 +++++-
 drivers/gpu/drm/virtio/virtgpu_object.c  |  36 +++--
 drivers/gpu/drm/virtio/virtgpu_plane.c   |  23 ++-
 drivers/gpu/drm/virtio/virtgpu_prime.c   |  46 ++++--
 drivers/gpu/drm/virtio/virtgpu_vq.c      | 165 ++++++++++++++++++--
 drivers/gpu/drm/virtio/virtgpu_vram.c    | 164 ++++++++++++++++++++
 drivers/virtio/virtio_mmio.c             |  31 ++++
 drivers/virtio/virtio_pci_modern.c       |  95 ++++++++++++
 include/linux/virtio_config.h            |  17 +++
 include/uapi/drm/virtgpu_drm.h           |  39 ++++-
 include/uapi/linux/virtio_gpu.h          |  78 ++++++++++
 include/uapi/linux/virtio_mmio.h         |  11 ++
 include/uapi/linux/virtio_pci.h          |  11 +-
 18 files changed, 991 insertions(+), 64 deletions(-)
 create mode 100644 drivers/gpu/drm/virtio/virtgpu_vram.c

--=20
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

