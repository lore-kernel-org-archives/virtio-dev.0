Return-Path: virtio-dev-return-6464-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BAC7A98603A
	for <virtio-dev@lists.oasis-open.org>; Thu,  5 Dec 2019 07:08:58 +0000 (UTC)
Date: Thu, 5 Dec 2019 08:08:52 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191205070852.u5jldmgsruyvm3ew@sirius.home.kraxel.org>
References: <20191128131941.25069-1-kraxel@redhat.com>
 <CAAfnVBkfO47zim4t0wemLLyTte2r+hkr=+umm8E_0_J9Ketatg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAfnVBkfO47zim4t0wemLLyTte2r+hkr=+umm8E_0_J9Ketatg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH] virtio-gpu: add shared resource feature
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> If the following scenario happens:
>=20
> 1) Driver sends RESOURCE_CREATE_2D shared request
> 2) Driver sends ATTACH_BACKING request
> 3) Device creates a shared resource
> 4) Driver sends SET_SCANOUT request
> 5) Device sends shared resource to display
> 6) Driver sends DETACH_BACKING request

Hmm, I think you can crash the current qemu code that way (didn't test
though).  I think the proper solution would be to return -EBUSY on the
DETACH_BACKING request.  Guess I'll add a new error code for that.

> > +Otherwise the shared resources are used like normal resources.
> > +Especially the driver must send explicit VIRTIO_GPU_CMD_TRANSFER_*
> > +commands to the device for both normal and shared resources.  Reason:
> > +The device might have to flush caches.
>=20
> Can we make this spec stronger to avoid to avoid transfers all the
> time (i.e, in virtio_gpu_update_dumb_bo)?
>=20
> drm_gem_shmem_* helpers seem to use WC buffers, and dumb buffers are
> traditionally WC as well.  If we mandate the host ("device?" here)
> must properly clean caches at creation time, it may be possible to
> avoid hypercalls for 2D_SHARED resources.

I think we can do 90% of that optimization without changing the
protocol.  Display updates typically involve multiple commands.  A
transfer, possibly a set-scanout (when page-flipping), finally flush.
The driver can first queue all commands, then notify the host, so we
will have only one vmexit per display update instead of one vmexit per
command.

> > The device MAY also choose to
> > +not create mapping for the shared resource.  Especially for small
> > +resources it might be more efficient to just copy the data instead of
> > +establishing a shared mapping.
>=20
> Should the device send a response code  (OK_SHARED} to inform the
> driver that the resource is shared?

Is there a good reason why the driver should be aware of that?

I'd prefer to make that an internal implementation detail of
the device and not inform the guest.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

