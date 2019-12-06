Return-Path: virtio-dev-return-6473-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B15FB986086
	for <virtio-dev@lists.oasis-open.org>; Fri,  6 Dec 2019 01:51:30 +0000 (UTC)
MIME-Version: 1.0
References: <20191128131941.25069-1-kraxel@redhat.com> <CAAfnVBkfO47zim4t0wemLLyTte2r+hkr=+umm8E_0_J9Ketatg@mail.gmail.com>
 <20191205070852.u5jldmgsruyvm3ew@sirius.home.kraxel.org>
In-Reply-To: <20191205070852.u5jldmgsruyvm3ew@sirius.home.kraxel.org>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 5 Dec 2019 17:51:15 -0800
Message-ID: <CAAfnVBmYMZ5TBY7kw-azLgYAPm4OzuVtQ2yDB8d7it9WHBgVEw@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH] virtio-gpu: add shared resource feature
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Dec 4, 2019 at 11:09 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > If the following scenario happens:
> >
> > 1) Driver sends RESOURCE_CREATE_2D shared request
> > 2) Driver sends ATTACH_BACKING request
> > 3) Device creates a shared resource
> > 4) Driver sends SET_SCANOUT request
> > 5) Device sends shared resource to display
> > 6) Driver sends DETACH_BACKING request
>
> Hmm, I think you can crash the current qemu code that way (didn't test
> though).  I think the proper solution would be to return -EBUSY on the
> DETACH_BACKING request.  Guess I'll add a new error code for that.

That would add the extra complication of a "delayed detach list" in
the guest kernel.  I don't know if it's absolutely necessary --
because the open source implementation (udmabuf) seems to take a
reference on all constituent pages like DRM gem does [a][b][c][d].  We
should figure out if the extra reference is sufficient to prevent the
pages from going back to guest RAM (the guest kernel takes references
on those pages too -- I don't know if guest references are treated
differently).

[a] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/drm_gem.c=
#L578
[b] https://github.com/torvalds/linux/blob/master/drivers/dma-buf/udmabuf.c=
#L161
[c] https://github.com/torvalds/linux/blob/master/drivers/dma-buf/udmabuf.c=
#L203
[d] http://lkml.iu.edu/hypermail/linux/kernel/0907.3/02155.html

>
> > > +Otherwise the shared resources are used like normal resources.
> > > +Especially the driver must send explicit VIRTIO_GPU_CMD_TRANSFER_*
> > > +commands to the device for both normal and shared resources.  Reason=
:
> > > +The device might have to flush caches.
> >
> > Can we make this spec stronger to avoid to avoid transfers all the
> > time (i.e, in virtio_gpu_update_dumb_bo)?
> >
> > drm_gem_shmem_* helpers seem to use WC buffers, and dumb buffers are
> > traditionally WC as well.  If we mandate the host ("device?" here)
> > must properly clean caches at creation time, it may be possible to
> > avoid hypercalls for 2D_SHARED resources.
>
> I think we can do 90% of that optimization without changing the
> protocol.  Display updates typically involve multiple commands.  A
> transfer, possibly a set-scanout (when page-flipping), finally flush.
> The driver can first queue all commands, then notify the host, so we
> will have only one vmexit per display update instead of one vmexit per
> command.

We also want to prevent this scenario:

1) Guest creates a writecombine mapping (like drm_gem_shmem_* helpers
do), but the pages were previously accessed and thus some data is in
the cache.
2) Cache eviction
3) Non-zero data in buffer.

>
> > > The device MAY also choose to
> > > +not create mapping for the shared resource.  Especially for small
> > > +resources it might be more efficient to just copy the data instead o=
f
> > > +establishing a shared mapping.
> >
> > Should the device send a response code  (OK_SHARED} to inform the
> > driver that the resource is shared?
>
> Is there a good reason why the driver should be aware of that?

Technically TRANSFER_TO_HOST is legal for 2D resources (though rarely
used).  I suppose we can modify RESOURCE_INFO to inform userspace the
resource is shared, and thus avoid hypercalls.

If we leave the decision to create the shared resource to the driver
and not the device, *_2D_SHARED makes sense.  Right now, it's
*_2D_MAYBE_SHARED.

>
> I'd prefer to make that an internal implementation detail of
> the device and not inform the guest.
>
> cheers,
>   Gerd
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

