Return-Path: virtio-dev-return-6832-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA627985B2F
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Mar 2020 09:28:55 +0000 (UTC)
Date: Mon, 2 Mar 2020 10:28:45 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
Message-ID: <20200302102845.1becf332@collabora.com>
In-Reply-To: <CAD=HUj5pnug_ePq8_Z=+qb1VcmiDWVwTysBY+x3anxXLTvRHWA@mail.gmail.com>
References: <20200207182842.770bfb27@collabora.com>
	<20200225162105.1912fae0@collabora.com>
	<CAD=HUj5R_iOsCwaN85_nNUxo+3sp+QxR6bjPknqFM2Y+u0GOUg@mail.gmail.com>
	<20200227100951.19e5c8df@collabora.com>
	<CAD=HUj5jCSotWP0pN_QMFYwuJMnaW8Xzzz1ZhCkjYXFu94ccoA@mail.gmail.com>
	<20200227144322.qasfqiyg47vfcqur@sirius.home.kraxel.org>
	<20200228090404.656686c5@collabora.com>
	<20200228092757.mvcm3c5rbafloold@sirius.home.kraxel.org>
	<CAD=HUj5pxUe2qJUNAyPS0E1SannNjsCXR48Xwj7n66=oYNR43A@mail.gmail.com>
	<20200228103041.j7dt3236qckqb7v7@sirius.home.kraxel.org>
	<CAD=HUj5pnug_ePq8_Z=+qb1VcmiDWVwTysBY+x3anxXLTvRHWA@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [RFC] Upstreaming virtio-wayland (or an
 alternative)
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: David Stevens <stevensd@chromium.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, =?UTF-8?B?U3Q=?= =?UTF-8?B?w6lwaGFuZQ==?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 2 Mar 2020 11:24:50 +0900
David Stevens <stevensd@chromium.org> wrote:

> On Fri, Feb 28, 2020 at 7:30 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Fri, Feb 28, 2020 at 07:11:40PM +0900, David Stevens wrote: =20
> > > > But there also is "unix socket", or maybe a somewhat broader "strea=
m",
> > > > which would be another feature flag I guess because virtio-ipc woul=
d
> > > > just tunnel the stream without the help from other devices. =20
> > >
> > > Can you elaborate on what you mean by this? I can envision how
> > > virtio-ipc would be a generic mechanism for passing data+virtio
> > > resources, including any new types of resources it itself defines.
> > > However, if "unix sockets" or a generic "stream" expands beyond
> > > virtio, that seems too broad, with too many edge cases to be feasible
> > > to implement. =20
> >
> > As far I know this is exactly what virtio-wayland does today if you try
> > to pass a unix socket file descriptor to the other side, so I assume
> > this functionality is needed ... =20
>=20
> As Zach said earlier, virtio-wayland implements just enough FD sharing
> support to get wayland working. However, there are many other
> situations where virtio-wayland's unix socket support isn't
> sufficient. I think adding support for sharing unix sockets to a
> generic virtio-ipc would imply that the support is more comprehensive
> than would be feasible to implement. So while virtio-ipc should
> support wayland, either directly or with the support of
> userspace/another virtio device, it also shouldn't overpromise what it
> is capable of doing.

I feel like some of the terms I used were confusing, but I think we're
on the same page when it comes to the actual implementation and
features we want to see supported by this virtio-ipc device. So, how
about rephrasing it this way:

"
virtio-ipc aims at providing a protocol-agnostic message passing
interface with extensible resource-passing capabilities. The initial
implementation should cover the wayland use case, and as such,
should support passing the following type of resources:

* opened virtio-ipc connections (similar to passing an FD to one end of
  a unix pipe, except communication would be bi-directional). With this
  feature we can let user space implement all sort of proxies
  (sockets <-> virtio-ipc, pipes <-> virtio-ipc, ...)
* virtio-gpu dmabufs
* ... [need to look in more details what's needed for keymap and file
  sharing]
"

Note that it's not that far from what virtio-wayland provides today with
2 main differences:

1/ the name of the device no longer implies that the interface is
   wayland-specific
2/ virtio-ipc is resource-type agnostic, and FD <-> resource ID mapping
   creation is left to the subsystem handling the resource. That means
   we shouldn't see this sort of 'convert FD to res-type X' logic [1]
   in the virtio-ipc driver, which should make it easier to extend while
   keeping the code base small enough/sane, no matter how far we
   decide to go with resource passing.

[1]https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chrome=
os-4.19/drivers/virtio/virtio_wl.c#786

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

