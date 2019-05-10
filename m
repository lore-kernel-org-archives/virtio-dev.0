Return-Path: virtio-dev-return-5724-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D17BB985DFA
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 May 2019 10:34:57 +0000 (UTC)
Date: Fri, 10 May 2019 11:34:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190510103452.GD22311@stefanha-x1.localdomain>
References: <abe4bd97-8010-8fd0-8ded-f9e847a4fdb3@13byte.com>
 <20190429134754.GI7587@stefanha-x1.localdomain>
 <4fcd7456-de22-7f6d-d5ef-939cd3d7cf95@13byte.com>
 <20190501170525.GB22391@stefanha-x1.localdomain>
 <c74aebe9-5db4-902f-ef0b-f0a786806acd@13byte.com>
 <20190503164501.GB8373@stefanha-x1.localdomain>
 <863e1be1-11cc-816b-896d-3954427e98f3@13byte.com>
 <20190506052715.vkdopunuauyhl22m@sirius.home.kraxel.org>
 <7ac2ae97-bcb7-22cc-272a-723e7209910c@13byte.com>
 <20190509122710.rfhfnhqez2u7inju@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline
In-Reply-To: <20190509122710.rfhfnhqez2u7inju@sirius.home.kraxel.org>
Subject: Re: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marco Martinelli - 13Byte srl <marco@13byte.com>, virtio-dev@lists.oasis-open.org, =?utf-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2019 at 02:27:10PM +0200, Gerd Hoffmann wrote:
> > For the sake of the specification I think we need to focus on is how to
> > transport these streams and how to share a configuration for each one.
>=20
> I think we need at least three virt queues.  One control queue for
> commands (query capabilities, set configuration, start/stop streams,
> volume control, ...).  One queue for input streams.  One queue for
> output streams.
>=20
> If we want allow for multiple inputs/outputs we have basically two
> options: (a) one queue per stream, or (b) use a small header for each
> data packet, telling what stream it belongs to.
>=20
> Maybe a small header is a good idea anyway, for timestamps.

I agree with the 3 virtqueue layout.

Multiplexing streams over a single input/output virtqueue pair has pros
and cons.  Overall I think it's a good fit though:
+ Number of streams can change at runtime (virtqueues are static!)
+ Easy to handle multiple inputs/outputs
+ Ability to synchronize streams, including transferring buffers for
  multiple streams in a single message with a single timestamp
- Virtqueue must be sized to handle maximum simultaneous streams without
  running out of descriptors
- Extra latency (jitter) and locking requirements due to sharing
  virtqueues between streams even if they are processed on different
  vCPUs

Stefan

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzVU8wACgkQnKSrs4Gr
c8gVygf/UXrY3DhXM14FCxmWJyAOI/9FafrPobGbFbfhQfyMcShoP8ysM8tJw9EJ
jMFie4hlvfwF2gX9knyCTlZxM3TBeta7wwIe2Y5pgEwlyPhtfx2Xw4qovCtgIQE3
c6f7/gZglc7ps86QogG7+RcEtwpSSpK4k6rAprPMlwXc3C3GgPmt+ZnPNSJ+wyDR
PqScBxfv0UTVLammOLWyQAo+iOHM9rjR4U1P9O7yl16gGO2ZX+RKSKMF0iyypI4G
z+qpLrFpSE5sHkO1NeInZxbzpqrxKDu/xbJRfEfRTgUVTtjUKu96YCByEpohm7OP
V3xciW6HKGgcSIv0L+veROCxe+BuJg==
=0Dgq
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
