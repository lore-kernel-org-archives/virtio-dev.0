Return-Path: virtio-dev-return-6750-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E5D5298432C
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Feb 2020 10:22:28 +0000 (UTC)
MIME-Version: 1.0
References: <20200207182842.770bfb27@collabora.com> <CAD=HUj7pR2ymWdVxi=5pcjBE2f9KKUhB10atsq-vsnPU8me8ww@mail.gmail.com>
 <20200217110222.2c4f2bef@collabora.com>
In-Reply-To: <20200217110222.2c4f2bef@collabora.com>
From: David Stevens <stevensd@chromium.org>
Date: Mon, 17 Feb 2020 19:22:15 +0900
Message-ID: <CAD=HUj5ceXPURE62XE1mm6_00Mh97MrweZ1_Bti5jWrLQDUkEQ@mail.gmail.com>
Subject: [virtio-dev] Re: [RFC] Upstreaming virtio-wayland (or an alternative)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

> > > FD <-> VFD mappings would have to be created
> > > by the subsystem in charge of the object backing the FD (virtio-gpu f=
or
> > > exported GEM buffers, virtio-vdec for video buffers, vsock for unix
> > > sockets if we decide to bridge unix and vsock sockets to make it
> > > transparent, ...). The FD <-> VFD mapping would also have to be creat=
ed
> > > on the host side, probably by the virtio device implementation
> > > (virglrenderer for GEM bufs for instance), which means host and guest
> > > need a way to inform the other end that a new FD <-> VFD mapping has
> > > been created so the other end can create a similar mapping (I guess t=
his
> > > requires extra device-specific commands to work).
> >
> > My recent proposal for cross device resource sharing seems like it
> > could be relevant here: https://markmail.org/thread/jsaoqy7phrqdcpqu.
>
> Thanks for sharing this link. I had a quick look at this proposal, and,
> maybe I'm wrong, but I'm not sure it actually addresses Tomasz' concern
> [1] if we keep letting a userspace proxy do the FD <-> UUID conversion
> and sending the UUID through the VSOCK. To me, a UUID only guarantees
> that 2 buffers will get different UUIDs (assuming they use the same
> algorithm to generate this UUID), but nothing prevents a malicious app
> from opening a connection to the host proxy and sending valid wayland
> messages with forged UUIDs, in the hope that one of them will match an
> already exported resource.

You're correct that it wouldn't really protect against malicious apps.
My email was more about pointing out a mechanism that could
potentially help address the FD <-> VFD mapping.

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

