Return-Path: virtio-dev-return-6800-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BDCB9985E3D
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Feb 2020 11:14:34 +0000 (UTC)
MIME-Version: 1.0
References: <20200207182842.770bfb27@collabora.com> <20200225162105.1912fae0@collabora.com>
 <CAD=HUj5R_iOsCwaN85_nNUxo+3sp+QxR6bjPknqFM2Y+u0GOUg@mail.gmail.com> <20200227100951.19e5c8df@collabora.com>
In-Reply-To: <20200227100951.19e5c8df@collabora.com>
From: David Stevens <stevensd@chromium.org>
Date: Thu, 27 Feb 2020 20:14:22 +0900
Message-ID: <CAD=HUj5jCSotWP0pN_QMFYwuJMnaW8Xzzz1ZhCkjYXFu94ccoA@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC] Upstreaming virtio-wayland (or an alternative)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 27, 2020 at 6:09 PM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Thu, 27 Feb 2020 13:20:51 +0900
> David Stevens <stevensd@chromium.org> wrote:
>
> > > * manage a central UUID <-> 'struct file' map that allows virtio-pipe
> > >   to convert FDs to UUIDs, pass UUIDs through a pipe and convert thos=
e
> > >   UUIDs back to FDs on the other end
> > >   - we need to expose an API to let each subsystem register/unregiste=
r
> > >     their UUID <-> FD mapping (subsystems are responsible for the UUI=
D
> > >     creation/negotiation)
> >
> > Can you provide more detail about the envisioned scope of this
> > framework?
>
> The scope is "generic message+FD passing" interface, which is pretty
> much what virtio-wl provides.

I think that scope is too broad. A socket is a 'generic message+FD'
interface. Unless there's the expectation that the interface should
eventually be as flexible as a regular domain socket, I think it would
be a good idea to frame the scope of the interface more precisely.

Part of this ambiguity comes from the informal usage of the term 'FD'.
An FD is a concept in Linux and other operating systems (and not even
all operating systems - e.g. Fuchsia). At present, FDs are not a
concept in virtio. Talking about sending FDs over virtio handwaves a
lot of details about what that's actually going on.

> > How
> > do operations on the guest FD affect the host FD, and vice versa?
>
> Depends what you mean by operations. If we're talking about regular
> read/write/ioctl/mmap operations on the guest side, it's up to the
> subsystem/driver to implement the expected behavior.

I think part of my confusion comes from the fact that virtio-wayland
seems to provide both the IPC mechanism described for virtio-ipc as
well as some additional guest/host file sharing support. If that is
actually the case, then I guess a striped down version of
virtio-wayland would still be necessary.

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

