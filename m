Return-Path: virtio-dev-return-6802-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1CD14985E3D
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Feb 2020 11:51:14 +0000 (UTC)
Date: Thu, 27 Feb 2020 12:51:08 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
Message-ID: <20200227125108.52873611@collabora.com>
In-Reply-To: <CAD=HUj5jCSotWP0pN_QMFYwuJMnaW8Xzzz1ZhCkjYXFu94ccoA@mail.gmail.com>
References: <20200207182842.770bfb27@collabora.com>
	<20200225162105.1912fae0@collabora.com>
	<CAD=HUj5R_iOsCwaN85_nNUxo+3sp+QxR6bjPknqFM2Y+u0GOUg@mail.gmail.com>
	<20200227100951.19e5c8df@collabora.com>
	<CAD=HUj5jCSotWP0pN_QMFYwuJMnaW8Xzzz1ZhCkjYXFu94ccoA@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [RFC] Upstreaming virtio-wayland (or an
 alternative)
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: David Stevens <stevensd@chromium.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, =?UTF-8?B?U3Q=?= =?UTF-8?B?w6lwaGFuZQ==?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 27 Feb 2020 20:14:22 +0900
David Stevens <stevensd@chromium.org> wrote:

> On Thu, Feb 27, 2020 at 6:09 PM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > On Thu, 27 Feb 2020 13:20:51 +0900
> > David Stevens <stevensd@chromium.org> wrote:
> > =20
> > > > * manage a central UUID <-> 'struct file' map that allows virtio-pi=
pe
> > > >   to convert FDs to UUIDs, pass UUIDs through a pipe and convert th=
ose
> > > >   UUIDs back to FDs on the other end
> > > >   - we need to expose an API to let each subsystem register/unregis=
ter
> > > >     their UUID <-> FD mapping (subsystems are responsible for the U=
UID
> > > >     creation/negotiation) =20
> > >
> > > Can you provide more detail about the envisioned scope of this
> > > framework? =20
> >
> > The scope is "generic message+FD passing" interface, which is pretty
> > much what virtio-wl provides. =20
>=20
> I think that scope is too broad. A socket is a 'generic message+FD'
> interface. Unless there's the expectation that the interface should
> eventually be as flexible as a regular domain socket, I think it would
> be a good idea to frame the scope of the interface more precisely.

Generic message passing still stands I think (generic as in
protocol-agnostic). For the FD part, of course we won't support all
kind of FDs on day 1, but the idea is to abstract things so we can
extend the solution easily.

>=20
> Part of this ambiguity comes from the informal usage of the term 'FD'.
> An FD is a concept in Linux and other operating systems (and not even
> all operating systems - e.g. Fuchsia). At present, FDs are not a
> concept in virtio. Talking about sending FDs over virtio handwaves a
> lot of details about what that's actually going on.

Correct, we're actually not passing Linux FDs at the virtio level,
we're passing resource handles, but I note that those handles are
called VFD (Virtual File Descriptor) in the virtio-wayland too :).

>=20
> > > How
> > > do operations on the guest FD affect the host FD, and vice versa? =20
> >
> > Depends what you mean by operations. If we're talking about regular
> > read/write/ioctl/mmap operations on the guest side, it's up to the
> > subsystem/driver to implement the expected behavior. =20
>=20
> I think part of my confusion comes from the fact that virtio-wayland
> seems to provide both the IPC mechanism described for virtio-ipc as
> well as some additional guest/host file sharing support.

I guess that'd be another kind of resource, and would require a
specific implementation, yes. Is it related to what Gerd was mentioning
with virtio-fs?

> If that is
> actually the case, then I guess a striped down version of
> virtio-wayland would still be necessary.

Maybe, until we add support for this file sharing feature upstream.
I'll have a closer look at how file sharing is exposed by virtio-wl.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

