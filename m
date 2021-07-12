Return-Path: <stefanha@redhat.com>
Date: Mon, 12 Jul 2021 11:12:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V2 0/2] Vitqueue State Synchronization
Message-ID: <YOwVc1V3k6+/xGHa@stefanha-x1.localdomain>
References: <20210706043334.36359-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZxY4ZgZ9MyjyHkC8"
Content-Disposition: inline
In-Reply-To: <20210706043334.36359-1-jasowang@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mgurtovoy@nvidia.com, cohuck@redhat.com, eperezma@redhat.com, oren@nvidia.com, shahafs@nvidia.com, parav@nvidia.com, bodong@nvidia.com, amikheev@nvidia.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>


--ZxY4ZgZ9MyjyHkC8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 06, 2021 at 12:33:32PM +0800, Jason Wang wrote:
> Hi All:
>=20
> This is an updated version to implement virtqueue state
> synchronization which is a must for the migration support.
>=20
> The first patch introduces virtqueue states as a new basic facility of
> the virtio device. This is used by the driver to save and restore
> virtqueue state. The states were split into available state and used
> state to ease the transport specific implementation. It is also
> allowed for the device to have its own device specific way to save and
> resotre extra virtqueue states like in flight request.
>=20
> The second patch introduce a new status bit STOP. This bit is used for
> the driver to stop the device. The major difference from reset is that
> STOP must preserve all the virtqueue state plus the device state.
>=20
> A driver can then:
>=20
> - Get the virtqueue state if STOP status bit is set
> - Set the virtqueue state after FEATURE_OK but before DRIVER_OK
>=20
> Device specific state synchronization could be built on top.

Will you send a proof-of-concept implementation to demonstrate how it
works in practice?

You mentioned being able to migrate virtio-net devices using this
interface, but what about state like VIRTIO_NET_S_LINK_UP that is either
per-device or associated with a non-rx/tx virtqueue?

Basically I'm not sure if the scope of this is just to migrate state
associated with offloaded virtqueues (vDPA, VFIO/mdev, etc) or if it's
really supposed to migrate the entire device?

Do you have an approach in mind for saving/loading device-specific
state? Here are devices and their state:
- virtio-blk: a list of requests that the destination device can
  re-submit
- virtio-scsi: a list of requests that the destination device can
  re-submit
- virtio-serial: active ports, including the current buffer being
  transferred
- virtio-net: MAC address, status, etc

Stefan

--ZxY4ZgZ9MyjyHkC8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDsFXMACgkQnKSrs4Gr
c8ihLQgAp/Xa0TcrABEGHIl4843xxE5a5E0iVCZk5cnOObiz7tKtgpXFJrY3NBWE
7dAMngn5pzNns/ytnVEVrj1yhZufgpgE1MAw1GoFijERdnWdkWvPzBMiEY3wZLvR
4bM71FSqNdqeVJNMouAVFTH5gbWdENlizKi3mjtw7HQ4igK/jiR3+OcuJXnGQvxN
tKcVaNZwzNjA2B4qe8gOnTNcr9fLiZmSmkXzbi2NdLXuGBmXLzj3nP/6KJq+iKTw
T5XFFWrQjrBmBk/ZOLCIxIGH9SBXfKm5hJR6O7peXcFk6JsMlE3fU/WVkxcBnqbh
W3ASoiw0xeVYzwnjlepg5+6yWuE6aA==
=Amkb
-----END PGP SIGNATURE-----

--ZxY4ZgZ9MyjyHkC8--

