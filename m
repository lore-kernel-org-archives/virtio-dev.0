Return-Path: virtio-dev-return-6763-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 599C6985C31
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Feb 2020 10:33:54 +0000 (UTC)
Date: Mon, 24 Feb 2020 11:33:48 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
Message-ID: <20200224113348.356d8cb8@collabora.com>
In-Reply-To: <20200217192150.07f9e253@collabora.com>
References: <20200207182842.770bfb27@collabora.com>
	<20200217145835.0bd7b028@collabora.com>
	<CAFNex=BuHdsEjFK3_cTqO2nOE-kB_MSH26sCTekF_6AK8Fyv3Q@mail.gmail.com>
	<20200217192150.07f9e253@collabora.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [RFC] Upstreaming virtio-wayland (or an alternative)
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Zach Reizner <zachr@google.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, David Stevens <stevensd@chromium.org>, =?UTF-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 17 Feb 2020 19:21:50 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> > > Thats why I don't like the new virtio device idea much and would pref=
er
> > > vhost being reused, either directly (#1) or via proxy (#2). =20
> >=20
> > For crosvm's purposes, we are looking at ways to reduce vhost usage in
> > order to reduce host kernel exposure to untrusted guest input,
> > including from the guest kernel. That is why a non-vhost based
> > solution would be prefered. =20
>=20
> Okay, I didn't know you were avoiding vhost-based solutions to
> reduce the attack surface.

Looks like they implemented vhost-less vsock in Firecracker[1]. Not
sure how much work that would be to port this implementation to crosvm,
but maybe that's an option.

[1]https://github.com/firecracker-microvm/firecracker/pull/1176

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

