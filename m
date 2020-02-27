Return-Path: virtio-dev-return-6799-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EB959985E3D
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Feb 2020 10:29:26 +0000 (UTC)
Date: Thu, 27 Feb 2020 11:29:17 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200227102917.vuey2acv5ziizwnb@sirius.home.kraxel.org>
References: <20200207182842.770bfb27@collabora.com>
 <20200225162105.1912fae0@collabora.com>
 <20200226151224.tqctou74uxdaxtut@sirius.home.kraxel.org>
 <20200226180504.66596367@collabora.com>
MIME-Version: 1.0
In-Reply-To: <20200226180504.66596367@collabora.com>
Subject: Re: [virtio-dev] [RFC] Upstreaming virtio-wayland (or an alternative)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, David Stevens <stevensd@chromium.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > So one possible approach for the host side implementation would be to
> > write the virtio protocol parser as support library, then implement the
> > host applications (i.e. the host wayland proxy) as vhost-user process
> > using that library.
> >=20
> > That would not work well with the singleton device approach though.
>=20
> Hm, so you'd have several virtio-ipc devices exposed to the guest and
> the guest user would have to select one,

Yes.  We would have to attach names to the devices so the guest can
pick the one it wants, something like protocol=3Dorg.freedesktop.wayland

> or would the guest only see one virtio-ipc device? When I said
> singleton it was from the guest perspective (though I thought this
> would also apply to the host).

Yes, you'll have the same model on both guest and host.

A singleton device would work too, but would require an extra middle man
on the host side.  The vmm directly (qemu/crosvm), or a vhost-user
process, or a vhost kernel module would have to dispatch messages to the
actual applications (wayland proxy, ...).

A protocol-specific vhost-user process could drive the virtio rings
directly instead.  Of course this approach has its drawbacks too.
Porting applications is probably easier if the familiar socket interface
is available.

> guest side prime export + FD transfer on an IPC connection:
> -----------------------------------------------------------
>=20
> * guest_virtio_gpu->prime_handle_to_fd()
>   + virtio_gpu_resource_to_uuid() request sent on link3 to get a UUID
>     - virglrenderer_get_resource_uuid() (the UUID is generated if it
>       doesn't exist yet)
>     - host_virtio_gpu exports the resource to a pseudo-'struct file'
>       representation ('struct file' only exists kernel side, but maybe
>       we can add the concept of resource on the host user space side
>       and define an interface for this resource object?)

Yep, that needs be sorted.  If everything happens inside the same
process this should be easy, it'll be just an vmm implementation detail.

Supporting multi-process vmms (see vhost-user) will be more tricky.
Let the vmm manage in this case too?  Or should the kernel help here?
Or should we have a dbus service for that?  Other ideas?

>       We'll also need resource objs to be exported as plain FDs so we
>       can pass them through a unix socket.

virtio-gpu would use dma-bufs for that.

> I'm still unsure how FDs coming from a host application can be
> converted to resource objects (and then UUIDs so they can be passed
> to the ipc_connection) if they've not been previously created/passed
> by the guest though.

Depends on the kind of fd I think.  For unix sockets or virtio-fs files
it should be easy.  dma-bufs or sysv shmem would be more tricky because
we have to map them into the guest address space (if we want support
that).  Not impossible though, we could use the new shared memory
support for that.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

