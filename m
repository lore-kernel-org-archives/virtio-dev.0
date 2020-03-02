Return-Path: virtio-dev-return-6829-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BDF80985A89
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Mar 2020 02:25:03 +0000 (UTC)
MIME-Version: 1.0
References: <20200207182842.770bfb27@collabora.com> <20200225162105.1912fae0@collabora.com>
 <CAD=HUj5R_iOsCwaN85_nNUxo+3sp+QxR6bjPknqFM2Y+u0GOUg@mail.gmail.com>
 <20200227100951.19e5c8df@collabora.com> <CAD=HUj5jCSotWP0pN_QMFYwuJMnaW8Xzzz1ZhCkjYXFu94ccoA@mail.gmail.com>
 <20200227144322.qasfqiyg47vfcqur@sirius.home.kraxel.org> <20200228090404.656686c5@collabora.com>
 <20200228092757.mvcm3c5rbafloold@sirius.home.kraxel.org> <CAD=HUj5pxUe2qJUNAyPS0E1SannNjsCXR48Xwj7n66=oYNR43A@mail.gmail.com>
 <20200228103041.j7dt3236qckqb7v7@sirius.home.kraxel.org>
In-Reply-To: <20200228103041.j7dt3236qckqb7v7@sirius.home.kraxel.org>
From: David Stevens <stevensd@chromium.org>
Date: Mon, 2 Mar 2020 11:24:50 +0900
Message-ID: <CAD=HUj5pnug_ePq8_Z=+qb1VcmiDWVwTysBY+x3anxXLTvRHWA@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC] Upstreaming virtio-wayland (or an alternative)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Feb 28, 2020 at 7:30 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Fri, Feb 28, 2020 at 07:11:40PM +0900, David Stevens wrote:
> > > But there also is "unix socket", or maybe a somewhat broader "stream"=
,
> > > which would be another feature flag I guess because virtio-ipc would
> > > just tunnel the stream without the help from other devices.
> >
> > Can you elaborate on what you mean by this? I can envision how
> > virtio-ipc would be a generic mechanism for passing data+virtio
> > resources, including any new types of resources it itself defines.
> > However, if "unix sockets" or a generic "stream" expands beyond
> > virtio, that seems too broad, with too many edge cases to be feasible
> > to implement.
>
> As far I know this is exactly what virtio-wayland does today if you try
> to pass a unix socket file descriptor to the other side, so I assume
> this functionality is needed ...

As Zach said earlier, virtio-wayland implements just enough FD sharing
support to get wayland working. However, there are many other
situations where virtio-wayland's unix socket support isn't
sufficient. I think adding support for sharing unix sockets to a
generic virtio-ipc would imply that the support is more comprehensive
than would be feasible to implement. So while virtio-ipc should
support wayland, either directly or with the support of
userspace/another virtio device, it also shouldn't overpromise what it
is capable of doing.

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

