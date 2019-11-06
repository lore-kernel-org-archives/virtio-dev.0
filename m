Return-Path: virtio-dev-return-6290-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E78F7985EE3
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Nov 2019 10:11:10 +0000 (UTC)
Date: Wed, 6 Nov 2019 10:10:57 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20191106101057.GC2802@work-vm>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain>
 <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, geoff@hostfission.com, virtio-dev@lists.oasis-open.org, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Alexandre Courbot <acourbot@chromium.org>, qemu-devel@nongnu.org, Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Dylan Reid <dgreid@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Pawel Osciak <posciak@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

* Gerd Hoffmann (kraxel@redhat.com) wrote:
>   Hi,
>=20
> > > Reason is:  Meanwhile I'm wondering whenever "just use virtio-gpu
> > > resources" is really a good answer for all the different use cases
> > > we have collected over time.  Maybe it is better to have a dedicated
> > > buffer sharing virtio device?  Here is the rough idea:
> >=20
> > My concern is that buffer sharing isn't a "device".  It's a primitive
> > used in building other devices.  When someone asks for just buffer
> > sharing it's often because they do not intend to upstream a
> > specification for their device.
>=20
> Well, "vsock" isn't a classic device (aka nic/storage/gpu/...) either.
> It is more a service to allow communication between host and guest
>=20
> That buffer sharing device falls into the same category.  Maybe it even
> makes sense to build that as virtio-vsock extension.  Not sure how well
> that would work with the multi-transport architecture of vsock though.
>=20
> > If this buffer sharing device's main purpose is for building proprietar=
y
> > devices without contributing to VIRTIO, then I don't think it makes
> > sense for the VIRTIO community to assist in its development.
>=20
> One possible use case would be building a wayland proxy, using vsock for
> the wayland protocol messages and virtio-buffers for the shared buffers
> (wayland client window content).
>=20
> It could also simplify buffer sharing between devices (feed decoded
> video frames from decoder to gpu), although in that case it is less
> clear that it'll actually simplify things because virtio-gpu is
> involved anyway.
>=20
> We can't prevent people from using that for proprietary stuff (same goes
> for vsock).
>=20
> There is the option to use virtio-gpu instead, i.e. add support to qemu
> to export dma-buf handles for virtio-gpu resources to other processes
> (such as a wayland proxy).  That would provide very similar
> functionality (and thereby create the same loophole).
>=20
> > VIRTIO recently gained a shared memory resource concept for access to
> > host memory.  It is being used in virtio-pmem and virtio-fs (and
> > virtio-gpu?).
>=20
> virtio-gpu is in progress still unfortunately (all kinds of fixes for
> the qemu drm drivers and virtio-gpu guest driver refactoring kept me
> busy for quite a while ...).
>=20
> > If another flavor of shared memory is required it can be
> > added to the spec and new VIRTIO device types can use it.  But it's not
> > clear why this should be its own device.
>=20
> This is not about host memory, buffers are in guest ram, everything else
> would make sharing those buffers between drivers inside the guest (as
> dma-buf) quite difficult.

Given it's just guest memory, can the guest just have a virt queue on
which it places pointers to the memory it wants to share as elements in
the queue?

Dave

> > My question would be "what is the actual problem you are trying to
> > solve?".
>=20
> Typical use cases center around sharing graphics data between guest
> and host.
>=20
> cheers,
>   Gerd
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

