Return-Path: virtio-dev-return-6797-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 93FB6985E3D
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Feb 2020 09:34:03 +0000 (UTC)
Date: Thu, 27 Feb 2020 10:33:58 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
Message-ID: <20200227103358.1fb6f623@collabora.com>
In-Reply-To: <CAFNex=C4wm7=iH9XmyHoTSdkDfA3vbFOuLaaQ4aLjE9keu_NDg@mail.gmail.com>
References: <20200207182842.770bfb27@collabora.com>
	<20200225162105.1912fae0@collabora.com>
	<CAD=HUj5R_iOsCwaN85_nNUxo+3sp+QxR6bjPknqFM2Y+u0GOUg@mail.gmail.com>
	<20200227100951.19e5c8df@collabora.com>
	<CAFNex=C4wm7=iH9XmyHoTSdkDfA3vbFOuLaaQ4aLjE9keu_NDg@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [RFC] Upstreaming virtio-wayland (or an
 alternative)
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Zach Reizner <zachr@google.com>
Cc: David Stevens <stevensd@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, =?UTF-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 27 Feb 2020 01:22:11 -0800
Zach Reizner <zachr@google.com> wrote:

> On Thu, Feb 27, 2020 at 1:09 AM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > What's not entirely clear is whether we need to support cases where the
> > host create its own resources (without being asked by the guest) and
> > decides to pass them to a virtio-ipc-connection (through the unix <->
> > virtio-ipc bridge). If that's needed, we need interfaces to let host
> > apps import their resources in the VM (again, those interfaces are
> > likely to be resource-type dependent). =20
>=20
> When the wayland compositor sends the keyboard map or requests
> clipboard content, the compositor (or another client on the host) will
> create a resource (shm or pipe) and send it over the unix domain
> socket. Would this be a case of the above situation you mentioned
> above? It seems like we need to support the host creating resources
> passed over the virtio-ipc-connection.

Okay. There's also another problem I noticed just now: every time an FD
is passed on a unix socket a new FD is created on the receiver's side,
even if the receiver already has an opened-FD pointing to the exact
same file, which means we can't easily create an FD <-> virtio-resource
mapping on the host (there's this kcmp() [1] syscall, but it doesn't
seem to have a wrapper in glibc which is not a good sign, plus you need
to enable CONFIG_CHECKPOINT_RESTORE).

[1]http://man7.org/linux/man-pages/man2/kcmp.2.html

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

