Return-Path: virtio-dev-return-5365-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9FB0E985A3D
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Feb 2019 05:36:35 +0000 (UTC)
Date: Mon, 4 Feb 2019 13:36:28 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190204053628.GD29758@stefanha-x1.localdomain>
References: <501110004.11631.1549031044295@oodm23.prod.google.com>
 <CAJPjb1LF0x6AJ3vgvudURwhJ_OYkNHG0sG-ZfD7H-n7PcN1uBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Content-Disposition: inline
In-Reply-To: <CAJPjb1LF0x6AJ3vgvudURwhJ_OYkNHG0sG-ZfD7H-n7PcN1uBA@mail.gmail.com>
Subject: Re: [virtio-dev] RFC: Doorbell suppression, packed-ring mode and
 hardware offload
To: Rob Miller <rob.miller@broadcom.com>
Cc: David Riddoch <driddoch@solarflare.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 01, 2019 at 09:43:02AM -0800, Rob Miller wrote:
> Agreed that this is needed.
>=20
> I would also like to suggest splitting the F_IN_ORDER into
> F_RX_IN_ORDER and F_TX_IN_ORDER to support hw LRO implementations,
> which can be more of a scatter/gather than tx. This would allow
> batchmode for tx at least in packed rings.
>=20
> Finally, i would suggest a means to specify a given rings ring mode
> and packed leans more towards TX, whilst split can be either really
> depending upon LRO, jumbo, rx buff size, ect.. just like F_IN_ORDER,
> we can have RX & TX, split out.

Device types beside virtio-net might also want per-virtqueue F_IN_ORDER
and other features, so let's find a way to make it independent of
virtio-net concepts like rx/tx.

The per-virtqueue in-order flag could live in struct
pvirtq_event_suppress (VIRTIO 1.1 2.7.14 Event Suppression Structure
Format).

Or a new structure could be used for per-virtqueue configuration.  Doing
this is a little tricky if you want to select split vs packed ring
layout on a per-virtqueue basis, since this structure is part of the
split/packed ring layout.  It would probably be necessary to add vring
mode selection to the transport (PCI, MMIO, CCW) instead.

Stefan

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcV89cAAoJEJykq7OBq3PI/ywH/j0QaziT7E0ExNN+I+E0zEKw
xG5Uk7ibDbJCZTPJFBW094FkuG7x6jUipAOipa7l8OY0I+KeJ71/S1LLSFLYY2UG
bj4lIWp3bkDhy6bzx9VE3Ys+5YFAFMVssxJQ2CMm5h5gOcQlvdpxvVKU8UmrPh/5
eiefkpK4geB//AiZ3zRL9+W44gYs0x7cGRkPt5AvEKknnRLcUd/z2c+SAYS04/jK
ns/f7lnJzUNfwrS8Xs1ECBb/uddUyTkwJe6Q1fJu+KId31aqItLcHZncaqY5mmu8
7El5CDqS7Jq9rYJURMa4T0LsLcIQG83XTXBaStammXII6YGcpstE4BbxWEhGPYE=
=ars1
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--
