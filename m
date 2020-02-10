Return-Path: virtio-dev-return-6709-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5603C985A56
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Feb 2020 16:15:45 +0000 (UTC)
Date: Mon, 10 Feb 2020 16:15:38 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200210161538.GC411895@stefanha-x1.localdomain>
References: <eb379913-fcd9-1030-6f51-2dfeae7c95a9@mailbox.tu-berlin.de>
MIME-Version: 1.0
In-Reply-To: <eb379913-fcd9-1030-6f51-2dfeae7c95a9@mailbox.tu-berlin.de>
Subject: Re: [virtio-dev] May a device use buffers after putting them into
 the used ring?
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline
To: Benedikt Radtke <benediktradtke@mailbox.tu-berlin.de>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2020 at 06:42:52PM +0100, Benedikt Radtke wrote:
> I am using qemu-system-arm with "-device virtio-net-device" to emulate a =
nic
> (mmio, legacy). I have noticed that a receive queue uses the same buffer
> multiple times, although it has been added to the used ring (and not been
> added to the available ring again). Is it allowed to do that?

No, that should not happen.  Once the device places a buffer in the used
ring it will not touch it again.

> This is the first buffer (index 0) in the descriptor table:
> (gdb) x/16x 0x46008000
> 0x46008000:=A0=A0=A0=A0 0x00000000=A0=A0=A0=A0=A0 0x00000000=A0=A0=A0=A0=
=A0 0xffff0000 0xffffffff
> 0x46008010:=A0=A0=A0=A0 0x000a5552=A0=A0=A0=A0=A0 0x06080202=A0=A0=A0=A0=
=A0 0x00080100 0x01000406
> 0x46008020:=A0=A0=A0=A0 0x000a5552=A0=A0=A0=A0=A0 0x000a0202=A0=A0=A0=A0=
=A0 0x00000202 0x00000000
> 0x46008030:=A0=A0=A0=A0 0x0f02000a=A0=A0=A0=A0=A0 0x00000000=A0=A0=A0=A0=
=A0 0x00000000 0x00000000
> As you can see it contains a legacy virtio_net_hdr and an ethernet frame
> with an arp packet.
>=20
> After receiving two such arp packets the used ring looks like this:
> (gdb) x/8x 0x46005000
> 0x46005000:=A0=A0=A0=A0 0x00020001=A0=A0=A0=A0=A0 0x00000000=A0=A0=A0=A0=
=A0 0x00000034 0x00000000
> 0x46005010:=A0=A0=A0=A0 0x00000034=A0=A0=A0=A0=A0 0x00000000=A0=A0=A0=A0=
=A0 0x00000000 0x00000000

I didn't look at these hex dumps.  I don't have time to try to match
them up to the specification.  If you'd like help debugging the rings,
please annotate the hex dumps and describe what happens at each step.

> The used index is 2, and both entries use the first buffer in the descrip=
tor
> table (0). The virtio 1.1 spec says in section 2.6.8 ("The Virtqueue Used
> Ring"): "The used ring is where the device returns buffers once it is don=
e
> with them". I'd expect that any buffer that appears in the used ring will
> not be touched by the device (unless the driver puts it into an available
> ring again).
>=20
> Is my interpretation of the phrasing wrong, or is the device misbehaving?

QEMU's virtio-net and virtio-mmio implementation isn't known to have
this bug.  It would have probably been noticed a long time ago.
Therefore it's likely that the bug is in new code that you're testing
(i.e. guest driver or device emulation).

Stefan

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5BgakACgkQnKSrs4Gr
c8gRgQf7BSrHjSOdDSznN6TOIfDEnKSi021nTUQjtsxCB3hG+V/SnzuCRUNA8Y9K
XI+s9cG2a5v/aQ8LrQCuy4r0pcZTr8Ga0Z+OWW0x3deQ9Mng9oiNgqtEl7seDz8f
oppZgmAuy+JokDvRsD9stVo42V0QlwgB596fz8G5lyUnwRjjDO+eYMnuHT6qMYOE
4OX0klGfIYqygmn02kPhhH76w+mRzQpT4/HztJlqcNgC6CSSGfbFz+O6uRVJHrD7
0TSsgRb55vWibnO4faA/WNT1CAoE7ppWRwxAS3nKBbGPc5EUG84mKJcK06oEVYLj
1Q6fiR2tq/BQiOFwOliSljt/u9cJ8A==
=c6Vf
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--

