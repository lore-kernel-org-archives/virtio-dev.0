Return-Path: virtio-dev-return-5199-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 28A17985DD1
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Dec 2018 16:56:47 +0000 (UTC)
Date: Thu, 13 Dec 2018 16:56:41 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181213165641.GA24424@stefanha-x1.localdomain>
References: <20181213091933.21114-1-stefanha@redhat.com>
 <20181213102151-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <20181213102151-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH v11] vsock: add vsock device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 10:22:23AM -0500, Michael S. Tsirkin wrote:
> On Thu, Dec 13, 2018 at 09:19:33AM +0000, Stefan Hajnoczi wrote:
> > The virtio vsock device is a zero-configuration socket communications
> > device.  It is designed as a guest<->host management channel suitable
> > for communicating with guest agents.
> >=20
> > vsock is designed with the sockets API in mind and the driver is
> > typically implemented as an address family (at the same level as
> > AF_INET).  Applications written for the sockets API can be ported with
> > minimal changes (similar amount of effort as adding IPv6 support to an
> > IPv4 application).
> >=20
> > Unlike the existing console device, which is also used for guest<->host
> > communication, multiple clients can connect to a server at the same time
> > over vsock.  This limitation requires console-based users to arbitrate
> > access through a single client.  In vsock they can connect directly and
> > do not have to synchronize with each other.
> >=20
> > Unlike network devices, no configuration is necessary because the device
> > comes with its address in the configuration space.
> >=20
> > The vsock device was prototyped by Gerd Hoffmann and Asias He.  I picked
> > the code and design up from them.
> >=20
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/27
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > v11:
> >  * Fix bogus \begin{description} with missing \item [Michael]
>=20
> I applied already doing this fix manually - is this the only change?

Yes, it is.

Stefan

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcEo9JAAoJEJykq7OBq3PItRwIAIkib64d+S0xNggXcbRJO/+B
y/m2u2/bNdGUvC9TA7XvxxgC83aGj94l1Ggr1E/qMVPSWYG3TIw9ZJc4ML2SKZ/2
MVkcl6AluAS1Yn+5ycCJYP3fuuA9vlf/7NAfbmMwSjvhNAYIh+nOjRl2Tw1bMLHD
/76mNsDYxP/RYFI/psXm3ED3ahi3IUIYvgpg1u/lSbXBBuDTGaIO1tqkA/Oobu1L
MnEm20iqHKLbeq1XZ4tl1h56iHMt/RJdYCNUcyHVNFF7qijKKbHNcsUrmVlmKl9C
L+MGgEq3QhTIYGk+H6DTvPcqTLQQqD2nl5yFL8H2p6qhgOZVwDR3MIkU6ZTQF+4=
=VBHJ
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
