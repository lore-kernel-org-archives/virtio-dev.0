Return-Path: <virtio-dev-return-8593-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 542059864EA
	for <virtio-dev@lists.oasis-open.org>; Thu, 26 Aug 2021 02:05:00 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed, 25 Aug 2021 19:04:43 -0700
Message-Id: <20210826020455.1081-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC PATCH 00/12] -- 2021: The year of the context type
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Dear all,

I'm excited to share with you a ground-breaking and dare I say it even
shocking discovery in graphics virtualization.

The critics are raving -- many keen observers of VM graphics are
proclaiming 2021 to be "the year of the context type", eclipsing the
revolutionary blob resource of 2020.

The hype is justified; context types makes virtio-gpu 3D extensible,
opening the door to new designs and APIs.  Traditionally, virtio-gpu
3D is designed around the Gallium Virgl protocol and the host-side
virglrenderer implementation (as reflected with VIRTIO_GPU_F_VIRGL).

With VIRTIO_GPU_F_VIRGL + VIRTIO_GPU_F_CONTEXT_INIT, GPU/display
virtualization defined by the context type is possible.  It's entirely
possible the virglrenderer project isn't available on the host in this
scenario.

For example, the "gfxstream" [a] library is designed around (mostly) 1:1
auto-generated encode/decode of rendering commands.  This is in contrast
to virgl, which has a Gallium intermediate layer that can be complex.
The Address Space Graphics (ASG) ring-buffer is used to stream these APIs
while minimizing syscall and vm-exit overhead (somewhat like io_uring).

The gfxstream library has been supporting GLES virtualization since 2011,
and CTS-compliant Vulkan virtualization since 2018.

gfxstream is used in a wide range of products, from the Cuttlefish [b] to
the Android Studio emulator [c].

With context types, both virglrenderer and gfxstream can formally use
virtio-gpu as the transport [d].

                      GFXSTREAM DESIGN
   _________            __________          __________
  |         |          |          |        |          |
  | RENDER  |          |  GLES    |        | VULKAN   |
  | CONTROL |          |  ENCODER |        | CEREAL   |     GUEST
  | ENCODER |          |          |        | ENCODER  |     ENCODERS
  |_________|          |__________|        |__________|
       ^                    ^                    ^
       |                    |                    | <--------- ASG ring
       |                    |                    |
 - - - | - - - - - - - - -  | - - - - - - - - -  | - - - - - virtio-gpu
       |                    |                    |
   ____v____            ____v_____          _____v____
  |         |          |          |        |          |
  | RENDER  |          |  GLES    |        | VULKAN   |
  | CONTROL |          |  DECODER |        | CEREAL   |     GUEST
  | DECODER |          |          |        | DECODER  |     DECODERS
  |_________|          |__________|        |__________|
  |         |          |          |        |          |     GRAPHICS
  | EGL/GLX |          |  GLES    |        |  Vulkan  |     LIBRARIES
  |_________|          |__________|        |__________|

Indeed, context types are versatile enough to support display
virtualization too [e].  For example, one can passthrough guest Wayland
commands to enable seamless windowing.

1) Weston [guest] -> DRM/KMS virtio-gpu 2d -> VMM virtgpu 2d -> compositor
2) Sommelier [guest] -> virtio-gpu 3d -> VMM virtgpu context -> compositor

(1) is traditionally used, but (2) avoids API translations and has more
features.  Wayland passthrough has been used laptops for many years.  Here
are some videos on the subject:

https://www.youtube.com/watch?v=3DWwrXqDERFm8
https://www.youtube.com/watch?v=3DEkNBsBx501Q

With context types, seamless wayland windowing will be available to a wider
audience.

For virglrenderer, context types enable distinction between the virgl [f]
and the auto-generated "Venus" vulkan protocols [g].

In the future, GPU compute APIs or even vendor-specific protocols can use
the context type mechanism too.

Context types have been tested with crosvm and the feature is available on
the main branch.

[a] https://android.googlesource.com/device/generic/vulkan-cereal/
[b] https://source.android.com/setup/create/cuttlefish-ref-gpu
[c] https://developer.android.com/studio/run/emulator
[d] https://android.googlesource.com/device/generic/goldfish-opengl/+/refs/=
heads/master/system/vulkan_enc/ResourceTracker.cpp#1052
[e] https://chromium.googlesource.com/chromiumos/platform2/+/main/vm_tools/=
sommelier/virtualization/virtgpu_channel.cc#221
[f] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/7712
[g] https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/virtio/vulkan/=
vn_renderer_virtgpu.c#L63

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
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   | 194 +++++++++++++++++++++--
 drivers/gpu/drm/virtio/virtgpu_kms.c     |  26 ++-
 drivers/gpu/drm/virtio/virtgpu_plane.c   |   3 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c      |  19 +--
 include/uapi/drm/virtgpu_drm.h           |  27 ++++
 include/uapi/linux/virtio_gpu.h          |  18 ++-
 10 files changed, 354 insertions(+), 36 deletions(-)

--=20
2.33.0.259.gc128427fd7-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

