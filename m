Return-Path: virtio-dev-return-6803-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AA1F5985E3D
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Feb 2020 12:24:30 +0000 (UTC)
Date: Thu, 27 Feb 2020 13:24:25 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
Message-ID: <20200227132425.1138be49@collabora.com>
In-Reply-To: <20200227102917.vuey2acv5ziizwnb@sirius.home.kraxel.org>
References: <20200207182842.770bfb27@collabora.com>
	<20200225162105.1912fae0@collabora.com>
	<20200226151224.tqctou74uxdaxtut@sirius.home.kraxel.org>
	<20200226180504.66596367@collabora.com>
	<20200227102917.vuey2acv5ziizwnb@sirius.home.kraxel.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [RFC] Upstreaming virtio-wayland (or an
 alternative)
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, David Stevens <stevensd@chromium.org>, =?UTF-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 27 Feb 2020 11:29:17 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> > I'm still unsure how FDs coming from a host application can be
> > converted to resource objects (and then UUIDs so they can be passed
> > to the ipc_connection) if they've not been previously created/passed
> > by the guest though. =20
>=20
> Depends on the kind of fd I think.  For unix sockets or virtio-fs files
> it should be easy.  dma-bufs or sysv shmem would be more tricky because
> we have to map them into the guest address space (if we want support
> that).  Not impossible though, we could use the new shared memory
> support for that.

I was more worried about the complexity an import_resource() API would
put on the host proxy: it will have to know which subsystem each of the
resources/FDs it tries to pass to the virtio-ipc socket should be
attached to, and none of those resources have actually been created by
the proxy itself. That implies having a way to get that information from
a FD (is it a dmabuf FD, a unix socket fd, ... and depending on the kind
of FD, which device/subsystem is in charge of this FD, for instance, for
dmabufs, you might need to know who allocated the buffer).



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

