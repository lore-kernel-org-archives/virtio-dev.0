Return-Path: virtio-dev-return-6788-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2C4DE985E00
	for <virtio-dev@lists.oasis-open.org>; Wed, 26 Feb 2020 15:12:35 +0000 (UTC)
Date: Wed, 26 Feb 2020 16:12:24 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200226151224.tqctou74uxdaxtut@sirius.home.kraxel.org>
References: <20200207182842.770bfb27@collabora.com>
 <20200225162105.1912fae0@collabora.com>
MIME-Version: 1.0
In-Reply-To: <20200225162105.1912fae0@collabora.com>
Subject: Re: [virtio-dev] [RFC] Upstreaming virtio-wayland (or an alternative)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, David Stevens <stevensd@chromium.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,
=20
> So, I'm about to start working on virtio-pipe (I realize the name is
> not that great since pipes are normally unidirectional, but I'm sure
> we'll have plenty of time to bikeshed on that particular aspect once
> the other bits are sorted out :)).

virtio-ipc?

> This device would be a singleton
> (there can only be one per VM),

Why?

Alex already mentioned vhost-user.  This is basically a way to emulate
virtio devices outside qemu (not sure whenever other vmms support that
too).  With vhost emulation is done in the kernel, with vhost-user
emulation is done in another process instead.  Communication with qemu
runs over a socked with messages roughly equivalent to vhost ioctls.

There is a vhost-user implementation of virtio-gpu (see
contrib/vhost-user-gpu/ in qemu git repo).  Main motivation is that a
separate process can have a much stricter sandbox (no need to have
access to network or guest disk images), which is especially useful for
a complex thing like 3D rendering.

So one possible approach for the host side implementation would be to
write the virtio protocol parser as support library, then implement the
host applications (i.e. the host wayland proxy) as vhost-user process
using that library.

That would not work well with the singleton device approach though.

A vhost-user approach would allow for multiple vmms sharing the
implementation.  It would allow to easily pick a language other
than C (mostly relevant for qemu, crosvm isn't C anyway ...).

> * manage a central UUID <-> 'struct file' map that allows virtio-pipe
>   to convert FDs to UUIDs, pass UUIDs through a pipe and convert those
>   UUIDs back to FDs on the other end
>   - we need to expose an API to let each subsystem register/unregister
>     their UUID <-> FD mapping (subsystems are responsible for the UUID
>     creation/negotiation)

Do you have a rough plan how to do that?
On the guest side?
On the host side?

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

