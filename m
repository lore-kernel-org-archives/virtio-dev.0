Return-Path: virtio-dev-return-6771-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC35A985CA6
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Feb 2020 14:25:47 +0000 (UTC)
Date: Mon, 24 Feb 2020 15:25:42 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
Message-ID: <20200224152542.65830458@collabora.com>
In-Reply-To: <20200224145743.76b55a97@collabora.com>
References: <20200207182842.770bfb27@collabora.com>
	<20200217145835.0bd7b028@collabora.com>
	<CAFNex=BuHdsEjFK3_cTqO2nOE-kB_MSH26sCTekF_6AK8Fyv3Q@mail.gmail.com>
	<20200217192150.07f9e253@collabora.com>
	<20200224113348.356d8cb8@collabora.com>
	<20200224121255.upo5fjcy24h4gyc6@sirius.home.kraxel.org>
	<20200224134513.660fb144@collabora.com>
	<20200224141835.798fac4e@collabora.com>
	<20200224134231.75jsws2qnkpzl274@sirius.home.kraxel.org>
	<20200224145743.76b55a97@collabora.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [RFC] Upstreaming virtio-wayland (or an
 alternative)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Zach Reizner <zachr@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, David Stevens <stevensd@chromium.org>, =?UTF-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 24 Feb 2020 14:57:43 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Mon, 24 Feb 2020 14:42:31 +0100
> Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> >   Hi,
> >  =20
> > > > But let's say we go for a dedicated virtio-device to preserve this
> > > > granularity. Should we aim at providing a generic virtio-msg device=
 or
> > > > should we keep this so-called wayland-specific virtio device (I'd l=
ike
> > > > to remind you that it's actually protocol-agnostic)?   =20
> > >=20
> > > Maybe there's another option (not sure I mentioned it previously):
> > > de-correlate the message passing and fd-passing interfaces. If we add=
 a
> > > virtio-fd device that takes care of FD passing between guest and host=
,
> > > we can still use a regular vsock to pass messages (can be vhost or
> > > !vhost depending on your level of parano=C3=AFa). The wayland proxies=
 would
> > > then queue/dequeue messages to/from the vsock and FDs to/from virtio-=
fd.   =20
> >=20
> > Hmm, I suspect supporting unix socket passing (by creating a tunnel for
> > them) is going to be tricky in with that approach. =20
>=20
> Yes, If you want a generic vsock <-> unix proxy, you'll have to
> encapsulate the 'message+number of FDs passed' information so the other
> end knows how many FDs should be dequeued on the virtio-fd dev. The
> other option being to implement proxies that can parse the messages and
> extract the 'number of FDs' from there.

Nevermind, I misunderstood your concern. Indeed, supporting unix FD
passing would be trickier (you'd need to attach both a vosck and a
virtio-fd instance).

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

