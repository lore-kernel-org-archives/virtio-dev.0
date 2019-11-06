Return-Path: virtio-dev-return-6286-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 00491985EE3
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Nov 2019 06:24:34 +0000 (UTC)
Date: Wed, 6 Nov 2019 07:24:28 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191106062428.4ammt22igf5d6zve@sirius.home.kraxel.org>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <7255d3ca5f10bbf14b1a3fcb6ac34a19@hostfission.com>
MIME-Version: 1.0
In-Reply-To: <7255d3ca5f10bbf14b1a3fcb6ac34a19@hostfission.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [virtio-dev] Re: guest / host buffer sharing ...
To: Geoffrey McRae <geoff@hostfission.com>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Dylan Reid <dgreid@chromium.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

> > (1) The virtio device
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Has a single virtio queue, so the guest can send commands to register
> > and unregister buffers.  Buffers are allocated in guest ram.  Each
> > buffer
> > has a list of memory ranges for the data.  Each buffer also has some
> > properties to carry metadata, some fixed (id, size, application), but
> > also allow free form (name =3D value, framebuffers would have
> > width/height/stride/format for example).
> >=20
>=20
> Perfect, however since it's to be a generic device there also needs to be=
 a
> method in the guest to identify which device is the one the application i=
s
> interested in without opening the device.

This is what the application buffer property is supposed to handle, i.e.
you'll have a single device, all applications share it and the property
tells which buffer belongs to which application.

> The device should also support a reset feature allowing the guest to
> notify the host application that all buffers have become invalid such as
> on abnormal termination of the guest application that is using the device=
.

The guest driver should cleanup properly (i.e. unregister all buffers)
when an application terminates of course, no matter what the reason is
(crash, exit without unregistering buffers, ...).  Doable without a full
device reset.

Independent from that a full reset will be supported of course, it is a
standard virtio feature.

> Conversely, qemu on unix socket disconnect should notify the guest of thi=
s
> event also, allowing each end to properly syncronize.

I was thinking more about a simple guest-side publishing of buffers,
without a backchannel.  If more coordination is needed you can use
vsocks for that for example.

> > (3) The qemu host implementation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > qemu (likewise other vmms) can use the udmabuf driver to create
> > host-side dma-bufs for the buffers.  The dma-bufs can be passed to
> > anyone interested, inside and outside qemu.  We'll need some protocol
> > for communication between qemu and external users interested in those
> > buffers, to receive dma-bufs (via unix file descriptor passing) and
> > update notifications.

Using vhost for the host-side implementation should be possible too.

> > Dispatching updates could be done based on the
> > application property, which could be "virtio-vdec" or "wayland-proxy"
> > for example.
>=20
> I don't know enough about udmabuf to really comment on this except to ask
> a question. Would this make guest to guest transfers without an
> intermediate buffer possible?

Yes.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

