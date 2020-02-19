Return-Path: virtio-dev-return-6762-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 114D6985EA9
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Feb 2020 08:52:43 +0000 (UTC)
Date: Wed, 19 Feb 2020 09:52:37 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
Message-ID: <20200219095237.6c3e8238@collabora.com>
In-Reply-To: <CAFNex=A8fU3e=FYP=t7jQ0J2E5aoyGKujhj8Df+vOhkzV8etgA@mail.gmail.com>
References: <20200207182842.770bfb27@collabora.com>
	<20200217145835.0bd7b028@collabora.com>
	<CAFNex=BuHdsEjFK3_cTqO2nOE-kB_MSH26sCTekF_6AK8Fyv3Q@mail.gmail.com>
	<20200217192150.07f9e253@collabora.com>
	<CAFNex=A8fU3e=FYP=t7jQ0J2E5aoyGKujhj8Df+vOhkzV8etgA@mail.gmail.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [RFC] Upstreaming virtio-wayland (or an alternative)
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Zach Reizner <zachr@google.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, David Stevens <stevensd@chromium.org>, =?UTF-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 18 Feb 2020 13:15:04 -0800
Zach Reizner <zachr@google.com> wrote:

> >> <snip> I don't think extending vsock is a
> >> good idea because there's enough going on with virtio-wayland with
> >> respect to FD passing and emulation that a generic interface will be
> >> too opinionated. =20
> >
> > Can you be more specific? What would be the limitations of such a
> > generic interface that would make it unusable for the virtio-wayland
> > use case? =20
>=20
> What I meant by that statement was that virtio-wayland implements
> juuuust enough FD semantics to make wayland work. It's true that some
> other protocols also work over virtio-wayland, but that was a
> combination of filling in the holes for that protocol and coincidence.
> I'm afraid that a generic interface would have to contend with a long
> tail of FD semantics that don't line up with most other protocols. To
> give you a specific example, when virtio-wayland encounters an FD in
> the guest->host direction that it doesn't recognize, but that can be
> written or read to, it will create a unix pipe on the host side and
> send it along the wayland connection. This choice works fine for
> wayland, but that's because that was the entire point of the design. A
> more generic system would have to realize that interaction more
> authentically (e.g. for sending a bi-directional socket),

Indeed, but is that really a bad thing? I mean, do we really want
any kind of FD to transit between guest and host as soon as they
implement ->read/write(). For instance, should we forward device FDs
which have ->read/write() implemented but on which guest users might
want to call ioctl().

> and I'm not
> sure it's going to be possible.
>=20
> > =20
> > > I like the combination with virtio-gpu because it
> > > already has two related but separate graphics concepts combined into
> > > one device (display and rendering), so wayland would feel right at
> > > home. =20
> >
> > Except that, looking at the virtio-wayland code nothing in there looks
> > fundamentally wayland specific, or even display-server specific. Sure,
> > FD passing support is focused on what wayland needs (pipes, dmabuf FDs,
> > ...), but I see nothing that would prevent making it generic enough to
> > pass other kind of resources if we ever need to. =20
>=20
> That was intentional, and you have a good point. The reason I was
> suggesting integration with virtio-gpu was because I saw that as the
> most viable path towards upstreaming. It seems that creating a
> dedicated virtio device is highly contentious.
>=20
> >
> > I must admit I'm not a huge fan of integrating a protocol-agnostic
> > message passing interface (with FD-passing support) to virtio-gpu.
> > Sounds like something that could be re-used without virtio-gpu being
> > involved to me. As for the resource bridging thing, that's more or less
> > what I proposed with the generic interface to translate resource handle=
s
> > (what I called VFDs) to local FDs. It would probably be easier with a
> > vhost-based solution, but your resource bridge interface in crosvm
> > seems to provide the same kind of abstraction. Any reason you want to
> > avoid this split? =20
>=20
> If the upstreamed version of this actually becomes agnostic, than
> keeping it separate from virtio-gpu would make the most sense, but
> that seems to be unsettled.

Gerd, Stefan, any comment?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

