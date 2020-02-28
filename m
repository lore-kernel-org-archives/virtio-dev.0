Return-Path: virtio-dev-return-6807-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 58AFA985EB4
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Feb 2020 08:04:10 +0000 (UTC)
Date: Fri, 28 Feb 2020 09:04:04 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
Message-ID: <20200228090404.656686c5@collabora.com>
In-Reply-To: <20200227144322.qasfqiyg47vfcqur@sirius.home.kraxel.org>
References: <20200207182842.770bfb27@collabora.com>
	<20200225162105.1912fae0@collabora.com>
	<CAD=HUj5R_iOsCwaN85_nNUxo+3sp+QxR6bjPknqFM2Y+u0GOUg@mail.gmail.com>
	<20200227100951.19e5c8df@collabora.com>
	<CAD=HUj5jCSotWP0pN_QMFYwuJMnaW8Xzzz1ZhCkjYXFu94ccoA@mail.gmail.com>
	<20200227144322.qasfqiyg47vfcqur@sirius.home.kraxel.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [RFC] Upstreaming virtio-wayland (or an
 alternative)
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Stevens <stevensd@chromium.org>, Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, =?UTF-8?B?U3Q=?= =?UTF-8?B?w6lwaGFuZQ==?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Gerd,

On Thu, 27 Feb 2020 15:43:22 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>=20
> > > > Can you provide more detail about the envisioned scope of this
> > > > framework? =20
> > >
> > > The scope is "generic message+FD passing" interface, which is pretty
> > > much what virtio-wl provides. =20
> >=20
> > I think that scope is too broad. A socket is a 'generic message+FD'
> > interface. Unless there's the expectation that the interface should
> > eventually be as flexible as a regular domain socket, I think it would
> > be a good idea to frame the scope of the interface more precisely. =20
>=20
> Yes, sure, we need to exactly specify the different kinds of file
> handles / resources. I think it makes sense to have a virtio feature
> flag for each of them, so guest+host can easily negotiate what they are
> able to handle and what not.

I was expecting that to be a feature of the resource producers
(virtio-gpu, virtio-fs, ...) rather than a feature of virtio-ipc
itself. If we go for a model where UUID <-> resource/'struct file'
mappings are created by the subsystems that are in charge of those
resources, it's hard for virtio-ipc to know what kind of resources can
be passed in advance.

Regards,

Boris

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

