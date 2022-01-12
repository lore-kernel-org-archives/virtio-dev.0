Return-Path: <virtio-dev-return-9021-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C3192983E07
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Jan 2022 10:44:38 +0000 (UTC)
Date: Wed, 12 Jan 2022 10:44:17 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <Yd6xAbl9TGjU72Ng@stefanha-x1.localdomain>
References: <20220112055755.41011-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220112055755.41011-1-jasowang@redhat.com>
Subject: [virtio-dev] Re: [PATCH V2 0/2] virito-pci: PASID support
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="slkAVZCHN6Z7n8sg"
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, eperezma@redhat.com, lulu@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

--slkAVZCHN6Z7n8sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 12, 2022 at 01:57:53PM +0800, Jason Wang wrote:
> Hi All:
>=20
> This series tries to add PASID support for virtio-pci to allow the
> virtqueue to use PASID TLP prefix for PCI transactions. This will be
> useful for future work like, queue assignment, virtqueue
> virtualization and presenting multiple vDPA devices with a single PCI
> device.
>=20
> Since we're short of the space for the PCI capabilities, the PCI
> extended capability for virtio structure is introduced that allows the
> PASID configuration structure to use.
>=20
> A prototype is implemented with emulated virtio-pci device in [1]. A
> test driver is implemented in [2].
>=20
> Please review.

I don't know the security model for PASIDs. My guess is that PASIDs can
be bruteforced so we must trust the driver (it can assign PASIDs to
virtqueue groups) and we must prevent untrusted applications from
setting PASIDs on virtqueues. Is that correct?

Thanks,
Stefan

--slkAVZCHN6Z7n8sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmHesQEACgkQnKSrs4Gr
c8jCngf9FARUcyBmbEEP+JQaCUNx5i2/5DxTSqbaHendQMHYWbT81/v65w/p5hks
B63viSqQCHipx1aIqOH5ebzoE+rCgy3G31Le8R0HetxosKFGgU8s6bvVnqFuSPFS
k5iem8SKz9uPFccTsYL4e2V6fZbiQPPiRPWyGfAEYJA2PR6BIp0HHVGBcKSmF8ja
qSapaYU5Nsv4UKTFs+ePayVCemjKfcPDeuZOUQgdPviBMj6vfRNxP2CjG3bblPGh
HG7vz0gCFdXfTqZejEjL7Rfd5JMvSwLVRd6g71f6Q4p11rGh4+8qe4jYrEmwgfPy
2uJchNHIlcqTReguPSf6SqJCO9EsBg==
=TVx9
-----END PGP SIGNATURE-----

--slkAVZCHN6Z7n8sg--

