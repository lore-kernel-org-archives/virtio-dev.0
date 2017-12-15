Return-Path: virtio-dev-return-2839-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7B05A581803F
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 Dec 2017 09:08:53 -0800 (PST)
Date: Fri, 15 Dec 2017 17:08:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171215170834.GA31668@stefanha-x1.localdomain>
References: <20171215170519.31392-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20171215170519.31392-1-stefanha@redhat.com>
Subject: [virtio-dev] Re: [RFC virtio-dev] vhost-user-slave: add vhost-user slave device
 type
To: virtio-dev@lists.oasis-open.org
Cc: qemu-devel@nongnu.org, Wei Wang <wei.w.wang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 05:05:19PM +0000, Stefan Hajnoczi wrote:
> The vhost-user slave device facilitates vhost-user device emulation
> through vhost-user protocol exchanges and access to shared memory.
> Software-defined networking, storage, and other I/O appliances can
> provide services through this device.
>=20
> This device is based on Wei Wang's vhost-pci work.  The vhost-user slave
> device differs from vhost-pci because it is a single virtio device type
> that exposes the vhost-user protocol instead of a family of new virtio
> device types, one for each vhost-user device type.
>=20
> This device supports vhost-user slave and vhost-user master
> reconnection.  It also contains a UUID so that vhost-user slave programs
> can identify a specific device among many without using bus addresses.
>=20
> It is somewhat unconventional for a virtio device because it makes use
> of additional resources called doorbells, notifications, and shared
> memory.  A mapping of these resources to the virtio PCI transport is
> provided.  Other transports, such as CCW may not be able to support
> this device.

HTML version here:
https://stefanha.github.io/virtio/vhost-user-slave.html#x1-2830007

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaNAGSAAoJEJykq7OBq3PIOnYH/Rf4HGCbFN+UjOYk2NPsiafD
g9pOroGlAmXqweJgD/XG0IYSwnGfCly4uWp+ycRN8T6VevFLnnOUGpbH/4kYr1D3
sq3hz7AIlFxYPqMfwsIGk5C/NLigDB/eBigeU9VPvT5J60c8AS9Jm+8yph3EPykK
rbG57qkuVtfbEfUBYbuNZDAO4GB//cGxBxKnfayYqHlFIjBEybBHIHF1nFQbr8ba
nvf8pUZUNiZVzIFzlWnEv6aq/Gkf43wbDlwQ6ApBoS8voh2PFjB42h18RfcS5K04
nxMAnk4sL3eiZmdDpK/BYcJFaAHoq9EI4Hv6e3F7XnBCQzgIve07g1LuS0pfw1Y=
=JmIh
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
