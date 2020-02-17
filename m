Return-Path: virtio-dev-return-6754-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B08CA984331
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Feb 2020 13:44:28 +0000 (UTC)
Date: Mon, 17 Feb 2020 14:44:23 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
Message-ID: <20200217144423.08c81406@collabora.com>
In-Reply-To: <20200217123216.bdojgvvnpw34kmgp@sirius.home.kraxel.org>
References: <20200207182842.770bfb27@collabora.com>
	<20200210133856.cethya3kuzbagzw4@sirius.home.kraxel.org>
	<20200217112838.1699d5ce@collabora.com>
	<20200217123216.bdojgvvnpw34kmgp@sirius.home.kraxel.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [RFC] Upstreaming virtio-wayland (or an
 alternative)
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, David Stevens <stevensd@chromium.org>, =?UTF-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 17 Feb 2020 13:32:16 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>=20
> > As pointed in my reply to David's email, I'm a bit worried by the
> > security implications of this approach. As long as the dmabuf -> UUID
> > conversion stays in kernel space we should be safe, but if we start
> > allowing a guest proxy (running in userland) to send raw UUIDs on a
> > VSOCK connection, we lose the ability to check if the process is
> > actually allowed to use this resource. =20
>=20
> Correct.
>=20
> The UUID namespace is huge (128bit), so playing guessing games to access
> resources you don't own isn't exactly trivial.

It depends on the UUID algorithm [1] I guess. Versions 1, 2, 3 and 5
seem easier to guess than version 4 (not sure which one you're planning
to use here).

> I would not be concerned
> too much.=20

Any potential security hole should be considered IMHO, even if it's not
easily exploitable.

> If you want avoid uuids nevertheless the only way is option
> #1 (extent vsock) I think.
>=20
> > to attach UUIDs to resources. This could be addressed with the
> > virtio-dmabuf infrastructure you proposed, but it looks like David's
> > proposal does not generalize this interface (it's a virtio-gpu-only
> > thing right now). =20
>=20
> The idea is that virtio-gpu guest driver adds a uuid to any dma-buf it
> exports.  Then other drivers importing the dma-buf can figure what the
> uuid is.  We could also add a ioctl (on the dma-buf fd) to query the
> uuid.

Okay.

>=20
> > > Also it is a fact that approach #1 didn't went anywhere so far but we
> > > have a working implementation of approach #3.  So I guess I wouldn't
> > > veto approach #3 if you pick it after evaluating the options on the
> > > table. =20
> >=20
> > I'd really like to investigate option #1, unless you have strong
> > reasons to think this is a dead end. =20
>=20
> Last time I discussed this with Stefan Hajnoczi he didn't like the idea
> too much.  IIRC the main concern was that it would work on specific
> kinds of file handles only and that vsock would need special support
> code for every file handle type.

According to [2], he was more worried by the risk of DoS than the fact
that only some FDs might be able to transit on a VSOCK (which I find
totally reasonable BTW, since it requires some coordination between
host and guest to get that working).

>=20
> It quite a while ago though, maybe time for a re-evaluation.  The
> limitation to specific file handles wouldn't go away, and likewise the
> need for special support code.  We have a more clear plan for dma-buf
> support though.  Also we got virtio-fs meanwhile and being able to pass
> virtio-fs file handles over vsock looks like a pretty cool feature to
> me.
>=20
> Stefan?
>=20

[1]https://en.wikipedia.org/wiki/Universally_unique_identifier
[2]https://www.spinics.net/lists/kvm/msg159206.html

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

