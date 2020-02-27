Return-Path: virtio-dev-return-6805-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0BDC1985E3D
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Feb 2020 14:43:32 +0000 (UTC)
Date: Thu, 27 Feb 2020 15:43:22 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200227144322.qasfqiyg47vfcqur@sirius.home.kraxel.org>
References: <20200207182842.770bfb27@collabora.com>
 <20200225162105.1912fae0@collabora.com>
 <CAD=HUj5R_iOsCwaN85_nNUxo+3sp+QxR6bjPknqFM2Y+u0GOUg@mail.gmail.com>
 <20200227100951.19e5c8df@collabora.com>
 <CAD=HUj5jCSotWP0pN_QMFYwuJMnaW8Xzzz1ZhCkjYXFu94ccoA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD=HUj5jCSotWP0pN_QMFYwuJMnaW8Xzzz1ZhCkjYXFu94ccoA@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC] Upstreaming virtio-wayland (or an alternative)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Stevens <stevensd@chromium.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > > Can you provide more detail about the envisioned scope of this
> > > framework?
> >
> > The scope is "generic message+FD passing" interface, which is pretty
> > much what virtio-wl provides.
>=20
> I think that scope is too broad. A socket is a 'generic message+FD'
> interface. Unless there's the expectation that the interface should
> eventually be as flexible as a regular domain socket, I think it would
> be a good idea to frame the scope of the interface more precisely.

Yes, sure, we need to exactly specify the different kinds of file
handles / resources.  I think it makes sense to have a virtio feature
flag for each of them, so guest+host can easily negotiate what they are
able to handle and what not.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

