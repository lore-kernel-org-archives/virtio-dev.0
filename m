Return-Path: virtio-dev-return-6485-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B1284985B2F
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Dec 2019 01:53:51 +0000 (UTC)
MIME-Version: 1.0
References: <20191128131941.25069-1-kraxel@redhat.com> <CAAfnVBkfO47zim4t0wemLLyTte2r+hkr=+umm8E_0_J9Ketatg@mail.gmail.com>
 <20191205070852.u5jldmgsruyvm3ew@sirius.home.kraxel.org> <CAAfnVBmYMZ5TBY7kw-azLgYAPm4OzuVtQ2yDB8d7it9WHBgVEw@mail.gmail.com>
 <20191209113131.v6l2nxmrsaczyxdl@sirius.home.kraxel.org>
In-Reply-To: <20191209113131.v6l2nxmrsaczyxdl@sirius.home.kraxel.org>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Mon, 9 Dec 2019 17:53:37 -0800
Message-ID: <CAAfnVBnnfVngO6=F6JWKpNR9WTaN59AdC0Zp6JWBG0hUL-xKmA@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH] virtio-gpu: add shared resource feature
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Dec 9, 2019 at 3:31 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > > > 1) Driver sends RESOURCE_CREATE_2D shared request
> > > > 2) Driver sends ATTACH_BACKING request
> > > > 3) Device creates a shared resource
> > > > 4) Driver sends SET_SCANOUT request
> > > > 5) Device sends shared resource to display
> > > > 6) Driver sends DETACH_BACKING request
> > >
> > > Hmm, I think you can crash the current qemu code that way (didn't tes=
t
> > > though).  I think the proper solution would be to return -EBUSY on th=
e
> > > DETACH_BACKING request.  Guess I'll add a new error code for that.
> >
> > That would add the extra complication of a "delayed detach list" in
> > the guest kernel.
>
> Why?  I can't see how that can happen with the linux guest driver.  You
> need a drm framebuffer to map an gem object to a scanout.  The drm
> framebuffer holds a reference of the gem object, so the linux kernel
> wouldn't try to delete the gem object (-> DETACH_BACKING + UNREF) while
> it is mapped to the scanout because the refcount wouldn't go down to
> zero.

The case I'm thinking about is:

1) Guest DRM framebuffer refcount goes to zero
2) Host DRM framebuffer refcount is non-zero

I prefer the guest kernel just complain loudly rather than doing
complicated tricks in such instance.

>
> > I don't know if it's absolutely necessary --
> > because the open source implementation (udmabuf) seems to take a
> > reference on all constituent pages like DRM gem does [a][b][c][d].  We
> > should figure out if the extra reference is sufficient to prevent the
> > pages from going back to guest RAM (the guest kernel takes references
> > on those pages too -- I don't know if guest references are treated
> > differently).
>
> They are never taken away from guest ram.  The guest is free to do
> whatever it wants with the pages.  It's the job of the guest driver to
> make sure the pages are not released until the host stopped using them.
> So the host must drop all references before completing the
> DETACH_BACKING command.

Let's write that in the spec.

>
> > > I think we can do 90% of that optimization without changing the
> > > protocol.  Display updates typically involve multiple commands.  A
> > > transfer, possibly a set-scanout (when page-flipping), finally flush.
> > > The driver can first queue all commands, then notify the host, so we
> > > will have only one vmexit per display update instead of one vmexit pe=
r
> > > command.
> >
> > We also want to prevent this scenario:
> >
> > 1) Guest creates a writecombine mapping (like drm_gem_shmem_* helpers
> > do), but the pages were previously accessed and thus some data is in
> > the cache.
> > 2) Cache eviction
> > 3) Non-zero data in buffer.
>
> This can happen on arm I guess?

Exactly.

> I know caching is a more complicated on
> arm than on x86.  Care to explaint this (or do you have a good link?).

Two differences:
- On x86, the guest can perform cache operations, while on ARM it's a
privileged operation [1].
- On ARM, the guest attribute seems to override the host attribute[1].
I've verified this.

Even on x86, it seems it's possible to get WC buffers by changing the
MTTR[2] (though I haven't verified this yet).

[1] https://events.static.linuxfound.org/sites/events/files/slides/slides_1=
0.pdf
[2] https://lwn.net/Articles/646712/

We (you?) need to modify drm_gem_shmem_* helpers to always be cached
for virtgpu for now, since the TTM removal changed that behavior.

Then, we should expose host properties to the guest, like [1] suggests
(maybe something like VIRTIO_GPU_F_GUEST_ATTRIBUTE_OVERRIDE,
VIRTIO_GPU_F_GUEST_CACHE_OPS).  If there's already a method to do
this, that would be awesome.

Then we can optimize away.

>
> Also: what is special in virtualization here?  There are arm drivers
> using drm_gem_shmem_* helpers.  How do they manage this?

Panfrost, v3d.  I'm surprised they haven't hit this issue yet.

>
> > > Is there a good reason why the driver should be aware of that?
> >
> > Technically TRANSFER_TO_HOST is legal for 2D resources (though rarely
> > used).
>
> It's used for dumb gem objects.
>
> > I suppose we can modify RESOURCE_INFO to inform userspace the
> > resource is shared, and thus avoid hypercalls.
> >
> > If we leave the decision to create the shared resource to the driver
> > and not the device, *_2D_SHARED makes sense.  Right now, it's
> > *_2D_MAYBE_SHARED.
>
> Yes, the guest can't force it.
>
> cheers,
>   Gerd
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

