Return-Path: virtio-dev-return-6787-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B8EC8985DFF
	for <virtio-dev@lists.oasis-open.org>; Wed, 26 Feb 2020 09:25:51 +0000 (UTC)
Date: Wed, 26 Feb 2020 10:25:46 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
Message-ID: <20200226102546.06440f6b@collabora.com>
In-Reply-To: <87y2sqy84f.fsf@linaro.org>
References: <20200207182842.770bfb27@collabora.com>
	<20200225162105.1912fae0@collabora.com>
	<87y2sqy84f.fsf@linaro.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [RFC] Upstreaming virtio-wayland (or an
 alternative)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Zach Reizner <zachr@chromium.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, David Stevens <stevensd@chromium.org>, =?UTF-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 25 Feb 2020 15:55:12 +0000
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Boris Brezillon <boris.brezillon@collabora.com> writes:
>=20
> > Hi all,
> >
> > On Fri, 7 Feb 2020 18:28:42 +0100
> > Boris Brezillon <boris.brezillon@collabora.com> wrote:
> > =20
> >> Hello everyone,
> >>=20
> >> I recently took over Tomeu's task of upstreaming virtio-wayland. After
> >> spending quite a bit of time collecting information from his different
> >> attempts [1][2] I wanted to sync with all the people that were involve=
d
> >> in the previous discussions (if I missed some of them, feel free to ad=
d
> >> them back).
> >>=20
> >> The goal here is to get a rough idea of the general direction this
> >> should take so I can start implementing a PoC and see if it fits
> >> everyone's needs.
> >>=20
> >> virtio-wayland [3] started as a solution to pass wayland messages
> >> between host and guests so the guest can execute wayland apps whose
> >> surface buffers are passed to the wayland compositor running on the
> >> host. While this was its primary use case, I've heard it's been used t=
o
> >> transport other protocols. And that's not surprising, when looking at
> >> the code I noticed it was providing a protocol-agnostic message passin=
g
> >> interface between host and guests, similar to what VSOCK provides but
> >> with FD passing as an extra feature.
> >>=20
> >> Based on all previous discussions, I could identify 3 different
> >> approaches:
> >>=20
> >>     1/ Use VSOCK and extend it to support passing (some) FDs
> >>     2/ Use a user space VSOCK-based proxy that's in charge of
> >>        a/ passing regular messages
> >>        b/ passing specific handles to describe objects shared
> >>           between host and guest (most focus has been on dmabufs as
> >>           this is what we really care about for the gfx use case,
> >>           but other kind of FDs can be emulated through a
> >>           VSOCK <-> UNIX_SOCK bridging)
> >>     3/ Have a dedicated kernel space solution that provides features
> >>        exposed by #1 but through a virtio device interface (basically
> >>        what virtio-wayland does today)
> >>  =20
> <snip>
>=20
> > Option #1 sounds like a good idea on
> > the paper, but the fact that Google wants a solution that does not
> > involve vhost and given Gerd's concern about being able to use vsock
> > in some cases and do !vsock message-passing in others, it might not be
> > possible to use vsock (there can only be one vsock implementation
> > active). =20
>=20
> Forgive me for jumping in but what is the concern about vhost here? Is
> it purely the increased attack surface to the kernel or some more
> fundamental issue? Is this something that can be addressed with a
> vhost-user backend where all the complications of the host end are dealt
> with in user-space?

That's a question for Zach or St=C3=A9phane, but AFAIU it has to do with th=
e
increased attack surface to the host kernel. Firecraker (which, IIUC, is
a fork of crosvm) had the same request [1] and implemented a !vhost
vsock backend [2] to address that.

[1]https://github.com/firecracker-microvm/firecracker/issues/650
[2]https://github.com/firecracker-microvm/firecracker/pull/1176

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

