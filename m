Return-Path: virtio-dev-return-6486-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E1A48985CD4
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Dec 2019 08:50:09 +0000 (UTC)
Date: Tue, 10 Dec 2019 09:50:05 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191210085005.pmvkwgix7hveozf4@sirius.home.kraxel.org>
References: <20191128131941.25069-1-kraxel@redhat.com>
 <CAAfnVBkfO47zim4t0wemLLyTte2r+hkr=+umm8E_0_J9Ketatg@mail.gmail.com>
 <20191205070852.u5jldmgsruyvm3ew@sirius.home.kraxel.org>
 <CAAfnVBmYMZ5TBY7kw-azLgYAPm4OzuVtQ2yDB8d7it9WHBgVEw@mail.gmail.com>
 <20191209113131.v6l2nxmrsaczyxdl@sirius.home.kraxel.org>
 <CAAfnVBnnfVngO6=F6JWKpNR9WTaN59AdC0Zp6JWBG0hUL-xKmA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAfnVBnnfVngO6=F6JWKpNR9WTaN59AdC0Zp6JWBG0hUL-xKmA@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH] virtio-gpu: add shared resource feature
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > They are never taken away from guest ram.  The guest is free to do
> > whatever it wants with the pages.  It's the job of the guest driver to
> > make sure the pages are not released until the host stopped using them.
> > So the host must drop all references before completing the
> > DETACH_BACKING command.
>=20
> Let's write that in the spec.

Yes, saying so explicitly that totally makes sense.
I'll update the patch accordingly.

> We (you?) need to modify drm_gem_shmem_* helpers to always be cached
> for virtgpu for now, since the TTM removal changed that behavior.

We can just roll our own mmap function to handle that.
I'll prepare a patch (that is independent from F_SHARED anyway).

> Then, we should expose host properties to the guest, like [1] suggests
> (maybe something like VIRTIO_GPU_F_GUEST_ATTRIBUTE_OVERRIDE,
> VIRTIO_GPU_F_GUEST_CACHE_OPS).  If there's already a method to do
> this, that would be awesome.

We'll need that for sure when mapping host resources into the guest, but
we are not there yet with F_SHARED only.

> > Also: what is special in virtualization here?  There are arm drivers
> > using drm_gem_shmem_* helpers.  How do they manage this?
>=20
> Panfrost, v3d.  I'm surprised they haven't hit this issue yet.

Maybe because all mappings are consistent.  With virtio-gpu you could
end up in a situation where the guest uses wc whereas the host uses
cached and things go boom from there.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

