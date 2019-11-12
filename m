Return-Path: virtio-dev-return-6318-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DFDAE985DEF
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Nov 2019 00:54:29 +0000 (UTC)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain> <CAD=HUj41r8wHZ2-By8tLftkoqC5r_Bw=pr=zX2aZ7GTs1ESWhg@mail.gmail.com>
 <c8a6b6f35664ce036c2a48ec41eab97b0f40704d.camel@linux.intel.com>
In-Reply-To: <c8a6b6f35664ce036c2a48ec41eab97b0f40704d.camel@linux.intel.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Mon, 11 Nov 2019 16:54:14 -0800
Message-ID: <CAAfnVBkMWurTpseQFjcna5kk3__40n6M68=RTHLbQsu__2AFxg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: David Stevens <stevensd@chromium.org>, Stefan Hajnoczi <stefanha@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Keiichi Watanabe <keiichiw@chromium.org>, geoff@hostfission.com, virtio-dev@lists.oasis-open.org, Alex Lau <alexlau@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, qemu-devel@nongnu.org, Tomasz Figa <tfiga@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Dylan Reid <dgreid@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Pawel Osciak <posciak@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Nov 5, 2019 at 2:55 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> Each buffer also has some properties to carry metadata, some fixed (id, s=
ize, application), but
> also allow free form (name =3D value, framebuffers would have
> width/height/stride/format for example).

Sounds a lot like the recently added DMA_BUF_SET_NAME ioctls:

https://patchwork.freedesktop.org/patch/310349/

For virtio-wayland + virtio-vdec, the problem is sharing -- not allocation.

As the buffer reaches a kernel boundary, it's properties devolve into
[fd, size].  Userspace can typically handle sharing metadata.  The
issue is the guest dma-buf fd doesn't mean anything on the host.

One scenario could be:

1) Guest userspace (say, gralloc) allocates using virtio-gpu.  When
allocating, we call uuidgen() and then pass that via RESOURCE_CREATE
hypercall to the host.
2) When exporting the dma-buf, we call DMA_BUF_SET_NAME (the buffer
name will be "virtgpu-buffer-${UUID}").
3) When importing, virtio-{vdec, video} reads the dma-buf name in
userspace, and calls fd to handle.  The name is sent to the host via a
hypercall, giving host virtio-{vdec, video} enough information to
identify the buffer.

This solution is entirely userspace -- we can probably come up with
something in kernel space [generate_random_uuid()] if need be.  We
only need two universal IDs: {device ID, buffer ID}.

> On Wed, Nov 6, 2019 at 2:28 PM Geoffrey McRae <geoff@hostfission.com> wro=
te:
> The entire point of this for our purposes is due to the fact that we can
> not allocate the buffer, it's either provided by the GPU driver or
> DirectX. If virtio-gpu were to allocate the buffer we might as well
> forget
> all this and continue using the ivshmem device.

We have a similar problem with closed source drivers.  As @lfy
mentioned, it's possible to map memory directory into virtio-gpu's PCI
bar and it's actually a planned feature.  Would that work for your use
case?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

