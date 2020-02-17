Return-Path: virtio-dev-return-6755-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3DD51984331
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Feb 2020 13:58:41 +0000 (UTC)
Date: Mon, 17 Feb 2020 14:58:35 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
Message-ID: <20200217145835.0bd7b028@collabora.com>
In-Reply-To: <20200207182842.770bfb27@collabora.com>
References: <20200207182842.770bfb27@collabora.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [RFC] Upstreaming virtio-wayland (or an alternative)
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, David Stevens <stevensd@chromium.org>, =?UTF-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 7 Feb 2020 18:28:42 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> Based on all previous discussions, I could identify 3 different
> approaches:
>=20
>     1/ Use VSOCK and extend it to support passing (some) FDs
>     2/ Use a user space VSOCK-based proxy that's in charge of
>        a/ passing regular messages
>        b/ passing specific handles to describe objects shared
>           between host and guest (most focus has been on dmabufs as
>           this is what we really care about for the gfx use case,
>           but other kind of FDs can be emulated through a
>           VSOCK <-> UNIX_SOCK bridging)
>     3/ Have a dedicated kernel space solution that provides features
>        exposed by #1 but through a virtio device interface (basically
>        what virtio-wayland does today)
>=20
> Each of them has its pros and cons, which I'll try to sum-up (please
> correct me if I'm wrong, and add new things if you think they are
> missing).
>=20
> #1 might require extra care if we want to make it safe, as pointed
> out by Stefan here [4] (but I wonder if the problem is not the same
> for a virtio-wayland based solution). Of course you also need a bit of
> infrastructure to register FD <-> VFD mappings (VFD being a virtual
> file descriptor that's only used as unique IDs identifying the resource
> backed by the local FD). FD <-> VFD mappings would have to be created
> by the subsystem in charge of the object backing the FD (virtio-gpu for
> exported GEM buffers, virtio-vdec for video buffers, vsock for unix
> sockets if we decide to bridge unix and vsock sockets to make it
> transparent, ...). The FD <-> VFD mapping would also have to be created
> on the host side, probably by the virtio device implementation
> (virglrenderer for GEM bufs for instance), which means host and guest
> need a way to inform the other end that a new FD <-> VFD mapping has
> been created so the other end can create a similar mapping (I guess this
> requires extra device-specific commands to work).

We might be able to do that lazily if we add
->virtio_fd_to_vfd()/->virtio_vfd_to_fd() hooks to the file_operations
struct, instead of expecting the subsystem to pro-actively create those
mappings (when those hooks are not implemented, that means the resource
backed by this FD can't be passed on a VSOCK). Anyway, that's just an
implementation detail, the first question being, should we pursue in
this direction or not?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

