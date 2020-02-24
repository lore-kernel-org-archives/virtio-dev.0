Return-Path: virtio-dev-return-6766-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 90F11985C6B
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Feb 2020 12:45:46 +0000 (UTC)
Date: Mon, 24 Feb 2020 13:45:13 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
Message-ID: <20200224134513.660fb144@collabora.com>
In-Reply-To: <20200224121255.upo5fjcy24h4gyc6@sirius.home.kraxel.org>
References: <20200207182842.770bfb27@collabora.com>
	<20200217145835.0bd7b028@collabora.com>
	<CAFNex=BuHdsEjFK3_cTqO2nOE-kB_MSH26sCTekF_6AK8Fyv3Q@mail.gmail.com>
	<20200217192150.07f9e253@collabora.com>
	<20200224113348.356d8cb8@collabora.com>
	<20200224121255.upo5fjcy24h4gyc6@sirius.home.kraxel.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [RFC] Upstreaming virtio-wayland (or an alternative)
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Zach Reizner <zachr@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, David Stevens <stevensd@chromium.org>, =?UTF-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 24 Feb 2020 13:12:55 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Mon, Feb 24, 2020 at 11:33:48AM +0100, Boris Brezillon wrote:
> > On Mon, 17 Feb 2020 19:21:50 +0100
> > Boris Brezillon <boris.brezillon@collabora.com> wrote:
> >  =20
> > > > > Thats why I don't like the new virtio device idea much and would =
prefer
> > > > > vhost being reused, either directly (#1) or via proxy (#2).   =20
> > > >=20
> > > > For crosvm's purposes, we are looking at ways to reduce vhost usage=
 in
> > > > order to reduce host kernel exposure to untrusted guest input,
> > > > including from the guest kernel. That is why a non-vhost based
> > > > solution would be prefered.   =20
> > >=20
> > > Okay, I didn't know you were avoiding vhost-based solutions to
> > > reduce the attack surface. =20
> >=20
> > Looks like they implemented vhost-less vsock in Firecracker[1]. Not
> > sure how much work that would be to port this implementation to crosvm,
> > but maybe that's an option.
> >=20
> > [1]https://github.com/firecracker-microvm/firecracker/pull/1176 =20
>=20
> Well, the nice thing about vsock is that (a) you have the same interface
> on guest and host, and (b) it is hypervisor-agnostic.  Applications can
> simply use the usual system calls (socket, bind, listen, connect) with
> AF_VSOCK socket type and be done with it.
>=20
> When not using vhost this goes away (on the host side).  firecracker
> seems to have a vsock <-> unix socket bridge in vmm userspace instead
> (pull req msg sounds like that, didn't check the code).

That's also my understanding. Note that you still keep the genericity
on the guest side, which is a good thing I guess.

>=20
> I think there can be only one vsock device per guest.  So you can't have
> multiple instances, one with a vsock backend on the host and one with a
> userspace backend on the host, then pick one of the two depending on the
> use case.
>=20
> So, one advantage of a separate device would be that we'll gain some
> flexibility in terms of the host side implementation.  vsock vhost can
> be used together with a wayland userspace backend.

Yes, though if you really want to avoid vhost to reduce the attack
surface, you'll probably want to never use vhost instead of having this
restriction on a per-use-case basis.

But let's say we go for a dedicated virtio-device to preserve this
granularity. Should we aim at providing a generic virtio-msg device or
should we keep this so-called wayland-specific virtio device (I'd like
to remind you that it's actually protocol-agnostic)?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

