Return-Path: <stefanha@redhat.com>
Date: Mon, 12 Jul 2021 11:29:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio-pci: implement VIRTIO_F_RING_STATE
Message-ID: <YOwZhDqkYv7kUgiQ@stefanha-x1.localdomain>
References: <20210707043441.42361-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X3G9iFaxsUzVqfX2"
Content-Disposition: inline
In-Reply-To: <20210707043441.42361-1-jasowang@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mgurtovoy@nvidia.com, cohuck@redhat.com, eperezma@redhat.com, oren@nvidia.com, shahafs@nvidia.com, parav@nvidia.com, bodong@nvidia.com, amikheev@nvidia.com, pasic@linux.ibm.com, dgilbert@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


--X3G9iFaxsUzVqfX2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 07, 2021 at 12:34:41PM +0800, Jason Wang wrote:
> This patch is a follow up for the virtqueue state synchronization
> series to implement VIRTIO_F_RING_STATE via a dedicated capability for
> PCI transport.
>=20
> With the help of the STOP status bit, the virtqueue state
> synchronization for PCI should be self contained.
>=20
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  content.tex | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

This may not be critical, but the interface reminds me of the legacy
fw_cfg interface that was slow. It was replaced by a DMA interface that
reduced the number of vmexits. fw_cfg often transferred far more data
than this interface, so the inefficiency was a bigger problem.

If there was an admin virtqueue then the state of all virtqueues could
be saved/loaded in a single request instead of requiring 2 accesses per
virtqueue.

Assuming a register access takes 1 microsecond, a device with 64
virtqueues needs 128 microseconds to save/load virtqueue state. The
actual register access time will vary depending on how the device is
implemented (VFIO, vDPA, userspace). The total time is probably going to
be acceptable, however, if we need an admin virtqueue anyway, then maybe
do this as an admin virtqueue request instead of a transport-specific
method?

Stefan

--X3G9iFaxsUzVqfX2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDsGYQACgkQnKSrs4Gr
c8j+MQgAqR7L3w8kNMONitz3Vz5Dps12+b0jHULeOJW9ON2vatY3qjNG+p1E08gw
BZEQXJegW1VDBHM90wbUtd/9QZ/6mk0w1n9NUC9A+uZno/4ZqvDTnZ032ZZgEMYd
xiYLwpZSgb/guZ0hLUNDuWSx+vAuExDFvEMRmRudO7nPzahLjo0DrOwz40LoNfyF
uuHOCDsYKEKSeAaHjiL0v92eEhICAogJbs4Jy5nf1wwr8olV6fn4UWzMiIHLEI08
aY2CzAn1VOjLniHIsSUVGteNXz20rdefmXenG6N8Mzx7A9V8+zedPZ1d2GW1cpI1
Vza0bnUfNyx0qKMDGRpTx/1vZTQitw==
=5w3D
-----END PGP SIGNATURE-----

--X3G9iFaxsUzVqfX2--

