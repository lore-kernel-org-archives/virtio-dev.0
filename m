Return-Path: virtio-dev-return-6753-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A5C6698432E
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Feb 2020 12:32:29 +0000 (UTC)
Date: Mon, 17 Feb 2020 13:32:16 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200217123216.bdojgvvnpw34kmgp@sirius.home.kraxel.org>
References: <20200207182842.770bfb27@collabora.com>
 <20200210133856.cethya3kuzbagzw4@sirius.home.kraxel.org>
 <20200217112838.1699d5ce@collabora.com>
MIME-Version: 1.0
In-Reply-To: <20200217112838.1699d5ce@collabora.com>
Subject: Re: [virtio-dev] Re: [RFC] Upstreaming virtio-wayland (or an
 alternative)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, David Stevens <stevensd@chromium.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> As pointed in my reply to David's email, I'm a bit worried by the
> security implications of this approach. As long as the dmabuf -> UUID
> conversion stays in kernel space we should be safe, but if we start
> allowing a guest proxy (running in userland) to send raw UUIDs on a
> VSOCK connection, we lose the ability to check if the process is
> actually allowed to use this resource.

Correct.

The UUID namespace is huge (128bit), so playing guessing games to access
resources you don't own isn't exactly trivial.  I would not be concerned
too much.  If you want avoid uuids nevertheless the only way is option
#1 (extent vsock) I think.

> to attach UUIDs to resources. This could be addressed with the
> virtio-dmabuf infrastructure you proposed, but it looks like David's
> proposal does not generalize this interface (it's a virtio-gpu-only
> thing right now).

The idea is that virtio-gpu guest driver adds a uuid to any dma-buf it
exports.  Then other drivers importing the dma-buf can figure what the
uuid is.  We could also add a ioctl (on the dma-buf fd) to query the
uuid.

> > Also it is a fact that approach #1 didn't went anywhere so far but we
> > have a working implementation of approach #3.  So I guess I wouldn't
> > veto approach #3 if you pick it after evaluating the options on the
> > table.
>=20
> I'd really like to investigate option #1, unless you have strong
> reasons to think this is a dead end.

Last time I discussed this with Stefan Hajnoczi he didn't like the idea
too much.  IIRC the main concern was that it would work on specific
kinds of file handles only and that vsock would need special support
code for every file handle type.

It quite a while ago though, maybe time for a re-evaluation.  The
limitation to specific file handles wouldn't go away, and likewise the
need for special support code.  We have a more clear plan for dma-buf
support though.  Also we got virtio-fs meanwhile and being able to pass
virtio-fs file handles over vsock looks like a pretty cool feature to
me.

Stefan?

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

