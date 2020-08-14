Return-Path: virtio-dev-return-7639-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2135B985DAA
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Aug 2020 02:40:05 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 13 Aug 2020 19:39:36 -0700
Message-Id: <20200814024000.2485-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 00/24] Blob prerequisites + blob resources
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com, mst@redhat.com, vgoyal@redhat.com, sebastien.boeuf@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Dear all,

I'm excited to share with you a breathtaking advance in the field of
virtualized graphics: blob resources.

Blob resources are size-based containers for host, guest, or host+guest
allocations.  These resources are designed with multi-process 3D support
in mind, but also usable in virtio-gpu 2d.  They are needed for GL4.5,
Vulkan and zero-copy virtio-gpu.  Details in the various patches.

Patch 1 is a bug fix needed for drm-misc-next.

Patches 2-4 are David Steven's F_RESOURCE_UUID patches. The spec has been
approved by the virtio committee [a] and has ack's from many virtio [b] and
DRM luminaries, but has of yet the patches haven't been merged into
drm-misc-next.  Hopefully, we can get a plan for these patches at least.

Patches 5-7 are Sebastien Boeuf's shm region patches, which have been
floating around for a while.  Vivek sent them out with the latest
virtio-fs patches and perhaps we can merge these somehow too.

Patches 8-9 are random preparatory patches, and patches 10-12 are the uapi
changes, and patches 12-24 are the blob implementation.  The entire tree
is available at:

https://gitlab.freedesktop.org/virgl/drm-misc-next/-/commits/resource-blob

Blob resources are a product of a congenial collaboration by many notable
personalities from the Linux VM graphics ecosystem.  Thanks to everyone who
participated!

--- Open-source userspace ---

As per DRM requirements, there are open-source userspace implementations
of blob resources.  Patches have been reviewed or landed in Mesa [c],
virglrenderer [d], AOSP [e], and crosvm [f].  Most of these features are
behind a flag though.

--- Testing ---

Testing has taken place with x86 and ARM chromebooks, as well as
standard Linux desktop environments.  Intel/Nvidia GPUs have been tested.

For Mesa, blob resources have been tested with Piglit's ARB_buffer_storage
tests and apitraces.  Apitraces of GL4.5 games show we're between 70% to
80% of host performance on Iris, based on a apitrace of a 2013 GL4.5 game:

11.204 FPS (guest)
15.947 FPS (host)

This is still better than the status quo, when said game was unplayable
with Virgl due to an inefficient GL4.3 fallback.  But there's still room
for improvement if we want to match HW-assisted virtualization.

For gfxstream, blob resources have been tested with dEQP.vk.memory* and
running Vulkan applications in production with the "Cuttlefish" virtual
Android device [g].

Perhaps the best improvements come in terms of power.  Blob resources have
been shown decrease power consumption when playing 1080p60fps video by 10%.
As such, embedded devices in particular should transition to zero-copy
blob resources.

[a] https://www.oasis-open.org/committees/ballot.php?id=3D3500
[b] https://lists.oasis-open.org/archives/virtio-dev/202006/msg00070.html
[c] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/4821
[d] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/374
[e] https://android-review.googlesource.com/c/device/generic/goldfish-openg=
l/+/1283761
[f] https://chromium.googlesource.com/chromiumos/platform/crosvm/+/refs/hea=
ds/master/devices/src/virtio/gpu/virtio_3d_backend.rs#815
[g] https://source.android.com/setup/create/cuttlefish

David Stevens (3):
  virtio: add dma-buf support for exported objects
  virtio-gpu: add VIRTIO_GPU_F_RESOURCE_UUID feature
  drm/virtio: Support virtgpu exported resources

Gerd Hoffmann (6):
  virtio-gpu api: blob resources
  virtio-gpu api: host visible feature
  drm/virtio: implement blob resources: probe for the feature.
  drm/virtio: implement blob resources: probe for host visible region
  drm/virtio: implement blob resources: implement vram object
  drm/virtio: implement blob resources: resource create blob ioctl

Gurchetan Singh (12):
  drm/virtio: Revert "drm/virtio: Call the right shmem helpers"
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
 drivers/gpu/drm/virtio/virtgpu_debugfs.c |  24 +++
 drivers/gpu/drm/virtio/virtgpu_drv.c     |   4 +
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  90 +++++++++-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   | 183 ++++++++++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_kms.c     |  45 ++++-
 drivers/gpu/drm/virtio/virtgpu_object.c  |  44 +++--
 drivers/gpu/drm/virtio/virtgpu_plane.c   |  23 ++-
 drivers/gpu/drm/virtio/virtgpu_prime.c   | 112 ++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_vq.c      | 200 ++++++++++++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_vram.c    | 164 +++++++++++++++++++
 drivers/virtio/Makefile                  |   2 +-
 drivers/virtio/virtio.c                  |   6 +
 drivers/virtio/virtio_dma_buf.c          |  82 ++++++++++
 drivers/virtio/virtio_mmio.c             |  31 ++++
 drivers/virtio/virtio_pci_modern.c       | 102 ++++++++++++
 include/linux/virtio.h                   |   1 +
 include/linux/virtio_config.h            |  19 +++
 include/linux/virtio_dma_buf.h           |  37 +++++
 include/uapi/drm/virtgpu_drm.h           |  39 ++++-
 include/uapi/linux/virtio_gpu.h          |  97 +++++++++++
 include/uapi/linux/virtio_mmio.h         |  11 ++
 include/uapi/linux/virtio_pci.h          |  11 +-
 23 files changed, 1290 insertions(+), 39 deletions(-)
 create mode 100644 drivers/gpu/drm/virtio/virtgpu_vram.c
 create mode 100644 drivers/virtio/virtio_dma_buf.c
 create mode 100644 include/linux/virtio_dma_buf.h

--=20
2.24.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

