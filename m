Return-Path: virtio-dev-return-6795-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B3588985E3A
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Feb 2020 09:09:56 +0000 (UTC)
Date: Thu, 27 Feb 2020 10:09:51 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
Message-ID: <20200227100951.19e5c8df@collabora.com>
In-Reply-To: <CAD=HUj5R_iOsCwaN85_nNUxo+3sp+QxR6bjPknqFM2Y+u0GOUg@mail.gmail.com>
References: <20200207182842.770bfb27@collabora.com>
	<20200225162105.1912fae0@collabora.com>
	<CAD=HUj5R_iOsCwaN85_nNUxo+3sp+QxR6bjPknqFM2Y+u0GOUg@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [RFC] Upstreaming virtio-wayland (or an
 alternative)
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: David Stevens <stevensd@chromium.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, =?UTF-8?B?U3Q=?= =?UTF-8?B?w6lwaGFuZQ==?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 27 Feb 2020 13:20:51 +0900
David Stevens <stevensd@chromium.org> wrote:

> > * manage a central UUID <-> 'struct file' map that allows virtio-pipe
> >   to convert FDs to UUIDs, pass UUIDs through a pipe and convert those
> >   UUIDs back to FDs on the other end
> >   - we need to expose an API to let each subsystem register/unregister
> >     their UUID <-> FD mapping (subsystems are responsible for the UUID
> >     creation/negotiation) =20
>=20
> Can you provide more detail about the envisioned scope of this
> framework?

The scope is "generic message+FD passing" interface, which is pretty
much what virtio-wl provides.

> What sort of FDs and subsystems will use the framework?

Basically any subsystem/driver that wants to share resources with the
other end (host/guest depending on where you place yourself):
virtio-gpu, virtio-vdev, virtio-fs, ...

As for the sort of FDs, it can be any kind of resources that needs to
be shared: dmabuf, virtio-ipc-connection, opened-file, ...

> How
> do operations on the guest FD affect the host FD, and vice versa?

Depends what you mean by operations. If we're talking about regular
read/write/ioctl/mmap operations on the guest side, it's up to the
subsystem/driver to implement the expected behavior. Note that on the
host side, we won't manipulate plain FDs since we are in userspace and
the 'struct file' abstraction does not exists there. There will be
local-FD <-> resource mappings though, but how this is done is
resource-type dependent (for IPC FDs we create a unix socket and bridge
it to the virtio-ipc connection, for video buffers we'll ask the
gpu/videodev to export the resource as a dmabuf, ...).

What's not entirely clear is whether we need to support cases where the
host create its own resources (without being asked by the guest) and
decides to pass them to a virtio-ipc-connection (through the unix <->
virtio-ipc bridge). If that's needed, we need interfaces to let host
apps import their resources in the VM (again, those interfaces are
likely to be resource-type dependent).

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

