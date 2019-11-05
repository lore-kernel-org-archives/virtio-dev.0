Return-Path: virtio-dev-return-6283-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E492B985E9B
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Nov 2019 10:55:05 +0000 (UTC)
Date: Tue, 5 Nov 2019 11:54:56 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [virtio-dev] guest / host buffer sharing ...
To: Keiichi Watanabe <keiichiw@chromium.org>
Cc: David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Dylan Reid <dgreid@chromium.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>, geoff@hostfission.com, Gurchetan Singh <gurchetansingh@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi folks,

The issue of sharing buffers between guests and hosts keeps poping
up again and again in different contexts.  Most recently here:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg656685.html

So, I'm grabbing the recipient list of the virtio-vdec thread and some
more people I know might be interested in this, hoping to have everyone
included.

Reason is:  Meanwhile I'm wondering whenever "just use virtio-gpu
resources" is really a good answer for all the different use cases
we have collected over time.  Maybe it is better to have a dedicated
buffer sharing virtio device?  Here is the rough idea:


(1) The virtio device
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Has a single virtio queue, so the guest can send commands to register
and unregister buffers.  Buffers are allocated in guest ram.  Each buffer
has a list of memory ranges for the data.  Each buffer also has some
properties to carry metadata, some fixed (id, size, application), but
also allow free form (name =3D value, framebuffers would have
width/height/stride/format for example).


(2) The linux guest implementation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

I guess I'd try to make it a drm driver, so we can re-use drm
infrastructure (shmem helpers for example).  Buffers are dumb drm
buffers.  dma-buf import and export is supported (shmem helpers
get us that for free).  Some device-specific ioctls to get/set
properties and to register/unregister the buffers on the host.


(3) The qemu host implementation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

qemu (likewise other vmms) can use the udmabuf driver to create
host-side dma-bufs for the buffers.  The dma-bufs can be passed to
anyone interested, inside and outside qemu.  We'll need some protocol
for communication between qemu and external users interested in those
buffers, to receive dma-bufs (via unix file descriptor passing) and
update notifications.  Dispatching updates could be done based on the
application property, which could be "virtio-vdec" or "wayland-proxy"
for example.


commments?

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

