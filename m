Return-Path: virtio-dev-return-6808-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7D303985EB4
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Feb 2020 09:47:25 +0000 (UTC)
Date: Fri, 28 Feb 2020 10:27:57 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200228092757.mvcm3c5rbafloold@sirius.home.kraxel.org>
References: <20200207182842.770bfb27@collabora.com>
 <20200225162105.1912fae0@collabora.com>
 <CAD=HUj5R_iOsCwaN85_nNUxo+3sp+QxR6bjPknqFM2Y+u0GOUg@mail.gmail.com>
 <20200227100951.19e5c8df@collabora.com>
 <CAD=HUj5jCSotWP0pN_QMFYwuJMnaW8Xzzz1ZhCkjYXFu94ccoA@mail.gmail.com>
 <20200227144322.qasfqiyg47vfcqur@sirius.home.kraxel.org>
 <20200228090404.656686c5@collabora.com>
MIME-Version: 1.0
In-Reply-To: <20200228090404.656686c5@collabora.com>
Subject: Re: [virtio-dev] [RFC] Upstreaming virtio-wayland (or an alternative)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: David Stevens <stevensd@chromium.org>, Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > Yes, sure, we need to exactly specify the different kinds of file
> > handles / resources. I think it makes sense to have a virtio feature
> > flag for each of them, so guest+host can easily negotiate what they are
> > able to handle and what not.
>=20
> I was expecting that to be a feature of the resource producers
> (virtio-gpu, virtio-fs, ...) rather than a feature of virtio-ipc
> itself.

"resources from other virtio devices" would be one virtio-ipc feature
flag.  And, yes, that would for the most part have the other device
handle the problem.

But there also is "unix socket", or maybe a somewhat broader "stream",
which would be another feature flag I guess because virtio-ipc would
just tunnel the stream without the help from other devices.

Possibly there will be more ...

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

