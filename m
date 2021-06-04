Return-Path: virtio-dev-return-8180-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA960986575
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Jun 2021 10:32:08 +0000 (UTC)
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 04 Jun 2021 10:55:57 +0100
Message-ID: <87lf7p7wez.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] Question on VirGL/virtio-gpu features
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, David Stevens <stevensd@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, stratos-dev@op-lists.linaro.org, Peter Griffin <peter.griffin@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>


Hi All,

I was having a discussion the other day with an external team looking at
using virtualised graphics for a production platform. They had some
questions about features I couldn't answer due to my imperfect
understanding of all the moving parts. Does anyone know of any work
being done on the following:

Alternate pixel formats
-----------------------

I believe this is related to pixel data being expressed in different
colour spaces. I see that VIRTIO_GPU_CMD_RESOURCE_CREATE_2D has the
notion of different RGB layouts for pixel data. For 3D pixel data is
this something that is ever visible to the virtio layer or is this all
handled from within the OpenGL interface? I see there is a
VIRTIO_GPU_CMD_SET_SCANOUT_BLOB for defining resources that can get
referenced but that is still restricted to the same virtio_gpu_formats.

Overlay planes
--------------

As I understand it these are used for compositing multiple graphics
sources. We currently working on a virtualised virtio-video backend and
at some point we'll want to consider how you might overlay a 3D view
from one VM with a video source from a second VM and either do the
compositing in the host system or potentially a 3rd VM. Is anyone aware
of any work being done in this direction yet?

vsync
-----

The existing virtio-gpu spec doesn't mention vsync at all. My last
experience with active vsync synchronisation was back in the days of the
Atari ST so I'm a little behind on how it works with modern 3D. Is this
something that ever needs to be exposed to the guest or is it preserve
of the host system to ensure newly drawn frames are swapped out at the
right time to avoid tearing? The Khronos pages refer to Swap Interval
being a platform specific extension. Does this mean it needs to be
something specifically handled by VirGL?=20

DRM
---

Probably the least interesting problem from an open source point of view
but I guess for media consumers their needs to be a solution for DRM
protected streams to leave a VM and be handled "somewhere" else. Are
there any proposals for exposing DRM via VirtIO that anyone is aware of?

Any pointers gratefully received! Thanks in advance,

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

