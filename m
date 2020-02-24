Return-Path: virtio-dev-return-6765-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D7948985C6B
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Feb 2020 12:32:30 +0000 (UTC)
Date: Mon, 24 Feb 2020 13:32:19 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200224123219.ld5376khkazvcxln@sirius.home.kraxel.org>
References: <20200207182842.770bfb27@collabora.com>
 <20200217145835.0bd7b028@collabora.com>
 <CAFNex=BuHdsEjFK3_cTqO2nOE-kB_MSH26sCTekF_6AK8Fyv3Q@mail.gmail.com>
 <20200217192150.07f9e253@collabora.com>
MIME-Version: 1.0
In-Reply-To: <20200217192150.07f9e253@collabora.com>
Subject: [virtio-dev] Re: [RFC] Upstreaming virtio-wayland (or an alternative)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Zach Reizner <zachr@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, David Stevens <stevensd@chromium.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > Because wayland benefits from allocation and sharing of
> > virtio-gpu buffers, a virtio-gpu combo device simplifies access to
> > those buffers, whereas the separate virtio devices as implemented in
> > crosvm requires bridging of resource handles (in guest kernel) and FDs
> > (in crosvm).
>=20
> I must admit I'm not a huge fan of integrating a protocol-agnostic
> message passing interface (with FD-passing support) to virtio-gpu.
> Sounds like something that could be re-used without virtio-gpu being
> involved to me.

Agree.

> As for the resource bridging thing, that's more or less
> what I proposed with the generic interface to translate resource handles
> (what I called VFDs) to local FDs.

Yes, I think it makes sense to figure a sensible way to translate/manage
resource handles and have multiple virtio device work together.  What if
you want pass a handle to a virtio-fs file instead of a virtio-gpu
dma-buf between host and guest?

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

