Return-Path: virtio-dev-return-6352-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 687CF985E71
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Nov 2019 12:11:26 +0000 (UTC)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain> <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
In-Reply-To: <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 20 Nov 2019 21:11:12 +0900
Message-ID: <CAAFQd5BVXv7SU2JWf_pa__tWydd6UqNpMo6aQHLDjjU+Vch75A@mail.gmail.com>
Subject: [virtio-dev] Re: guest / host buffer sharing ...
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, geoff@hostfission.com, virtio-dev@lists.oasis-open.org, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Alexandre Courbot <acourbot@chromium.org>, qemu-devel <qemu-devel@nongnu.org>, Keiichi Watanabe <keiichiw@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Dylan Reid <dgreid@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Pawel Osciak <posciak@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Nov 6, 2019 at 6:51 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > Reason is:  Meanwhile I'm wondering whenever "just use virtio-gpu
> > > resources" is really a good answer for all the different use cases
> > > we have collected over time.  Maybe it is better to have a dedicated
> > > buffer sharing virtio device?  Here is the rough idea:
> >
> > My concern is that buffer sharing isn't a "device".  It's a primitive
> > used in building other devices.  When someone asks for just buffer
> > sharing it's often because they do not intend to upstream a
> > specification for their device.
>
> Well, "vsock" isn't a classic device (aka nic/storage/gpu/...) either.
> It is more a service to allow communication between host and guest
>
> That buffer sharing device falls into the same category.  Maybe it even
> makes sense to build that as virtio-vsock extension.  Not sure how well
> that would work with the multi-transport architecture of vsock though.
>
> > If this buffer sharing device's main purpose is for building proprietar=
y
> > devices without contributing to VIRTIO, then I don't think it makes
> > sense for the VIRTIO community to assist in its development.
>
> One possible use case would be building a wayland proxy, using vsock for
> the wayland protocol messages and virtio-buffers for the shared buffers
> (wayland client window content).
>
> It could also simplify buffer sharing between devices (feed decoded
> video frames from decoder to gpu), although in that case it is less
> clear that it'll actually simplify things because virtio-gpu is
> involved anyway.
>
> We can't prevent people from using that for proprietary stuff (same goes
> for vsock).
>
> There is the option to use virtio-gpu instead, i.e. add support to qemu
> to export dma-buf handles for virtio-gpu resources to other processes
> (such as a wayland proxy).  That would provide very similar
> functionality (and thereby create the same loophole).
>
> > VIRTIO recently gained a shared memory resource concept for access to
> > host memory.  It is being used in virtio-pmem and virtio-fs (and
> > virtio-gpu?).
>
> virtio-gpu is in progress still unfortunately (all kinds of fixes for
> the qemu drm drivers and virtio-gpu guest driver refactoring kept me
> busy for quite a while ...).
>
> > If another flavor of shared memory is required it can be
> > added to the spec and new VIRTIO device types can use it.  But it's not
> > clear why this should be its own device.
>
> This is not about host memory, buffers are in guest ram, everything else
> would make sharing those buffers between drivers inside the guest (as
> dma-buf) quite difficult.

I wonder if we're not forgetting about the main reason we ended up
with all this chaos - the host-allocated buffers. ;)

Do we really have an issue with sharing guest memory between different
virtio devices? Each of those devices could just accept a scatterlist
of guest pages and import that memory to whatever host component it's
backed by.

The case that really needs some support from VIRTIO is when the
buffers are allocated in the host. Sharing buffers from virtio-gpu
with a virtio video decoder or Wayland (be it a dedicated virtio
device or vsock) are some of the examples.

Best regards,
Tomasz

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

