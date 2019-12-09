Return-Path: virtio-dev-return-6479-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EF621984345
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Dec 2019 11:31:37 +0000 (UTC)
Date: Mon, 9 Dec 2019 12:31:31 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191209113131.v6l2nxmrsaczyxdl@sirius.home.kraxel.org>
References: <20191128131941.25069-1-kraxel@redhat.com>
 <CAAfnVBkfO47zim4t0wemLLyTte2r+hkr=+umm8E_0_J9Ketatg@mail.gmail.com>
 <20191205070852.u5jldmgsruyvm3ew@sirius.home.kraxel.org>
 <CAAfnVBmYMZ5TBY7kw-azLgYAPm4OzuVtQ2yDB8d7it9WHBgVEw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAfnVBmYMZ5TBY7kw-azLgYAPm4OzuVtQ2yDB8d7it9WHBgVEw@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH] virtio-gpu: add shared resource feature
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

> > > 1) Driver sends RESOURCE_CREATE_2D shared request
> > > 2) Driver sends ATTACH_BACKING request
> > > 3) Device creates a shared resource
> > > 4) Driver sends SET_SCANOUT request
> > > 5) Device sends shared resource to display
> > > 6) Driver sends DETACH_BACKING request
> >
> > Hmm, I think you can crash the current qemu code that way (didn't test
> > though).  I think the proper solution would be to return -EBUSY on the
> > DETACH_BACKING request.  Guess I'll add a new error code for that.
>=20
> That would add the extra complication of a "delayed detach list" in
> the guest kernel.

Why?  I can't see how that can happen with the linux guest driver.  You
need a drm framebuffer to map an gem object to a scanout.  The drm
framebuffer holds a reference of the gem object, so the linux kernel
wouldn't try to delete the gem object (-> DETACH_BACKING + UNREF) while
it is mapped to the scanout because the refcount wouldn't go down to
zero.

> I don't know if it's absolutely necessary --
> because the open source implementation (udmabuf) seems to take a
> reference on all constituent pages like DRM gem does [a][b][c][d].  We
> should figure out if the extra reference is sufficient to prevent the
> pages from going back to guest RAM (the guest kernel takes references
> on those pages too -- I don't know if guest references are treated
> differently).

They are never taken away from guest ram.  The guest is free to do
whatever it wants with the pages.  It's the job of the guest driver to
make sure the pages are not released until the host stopped using them.
So the host must drop all references before completing the
DETACH_BACKING command.

> > I think we can do 90% of that optimization without changing the
> > protocol.  Display updates typically involve multiple commands.  A
> > transfer, possibly a set-scanout (when page-flipping), finally flush.
> > The driver can first queue all commands, then notify the host, so we
> > will have only one vmexit per display update instead of one vmexit per
> > command.
>=20
> We also want to prevent this scenario:
>=20
> 1) Guest creates a writecombine mapping (like drm_gem_shmem_* helpers
> do), but the pages were previously accessed and thus some data is in
> the cache.
> 2) Cache eviction
> 3) Non-zero data in buffer.

This can happen on arm I guess?  I know caching is a more complicated on
arm than on x86.  Care to explaint this (or do you have a good link?).

Also: what is special in virtualization here?  There are arm drivers
using drm_gem_shmem_* helpers.  How do they manage this?

> > Is there a good reason why the driver should be aware of that?
>=20
> Technically TRANSFER_TO_HOST is legal for 2D resources (though rarely
> used).

It's used for dumb gem objects.

> I suppose we can modify RESOURCE_INFO to inform userspace the
> resource is shared, and thus avoid hypercalls.
>=20
> If we leave the decision to create the shared resource to the driver
> and not the device, *_2D_SHARED makes sense.  Right now, it's
> *_2D_MAYBE_SHARED.

Yes, the guest can't force it.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

