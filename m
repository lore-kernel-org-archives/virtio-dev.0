Return-Path: <stefanha@redhat.com>
Date: Thu, 18 Nov 2021 14:45:09 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3 0/2] virtio: introduce STOP status bit
Message-ID: <YZZm9TVW2YiNWHdv@stefanha-x1.localdomain>
References: <20211111185812.2326093-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z5wMSZRUdWugY+D0"
Content-Disposition: inline
In-Reply-To: <20211111185812.2326093-1-eperezma@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, mst@redhat.com, jasowang@redhat.com, amikheev@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, pasic@linux.ibm.com, cohuck@redhat.com, bodong@nvidia.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, parav@nvidia.com, mgurtovoy@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>


--z5wMSZRUdWugY+D0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 11, 2021 at 07:58:10PM +0100, Eugenio P=E9rez wrote:
> This patch introduces a new status bit STOP. This can be used by the
> driver to stop the device in order to safely fetch used descriptors
> status, making sure the device will not fetch new available ones.
>=20
> Its main use case is live migration, although it has other orthogonal
> use cases. It can be used to safely discard requests that have not been
> used: in other words, to rewind available descriptors.

This sounds non-trivial and would require more explanation.

> Stopping the device in the live migration context is done by per-device
> operations in vhost backends, but the introduction of STOP as a basic
> virtio facility comes with advantages:
> * All the device virtio-specific state is summarized in a single entity,
>   making easier to reason about it.

This point isn't clear to me. I think it's saying that using STOP
somehow unifies things compared to the way that vhost devices are
stopped today. Given that vhost already syncs state back to the VMM's
emulated VIRTIO device, I'm not sure how STOP is different.

> * VMM does not need to implement device specific operations in the
>   driver part.

What is the "driver part"?

> * Work out of the box for devices that use pure virtio backends in some
>   part of the device emulation chain (virtio_pci_vdpa or virtio_vdpa),
>   in any transport the device can use.

?

> * It's totally self-contained, solving the nested virtualization case
>   straightforwardly.

Make sense.

> To fully understand its position in the live migration case, it's needed
> to note that the VMM acts as a part (or the whole) of the virtio device
> from the guest point of view, and it can act as a part of the driver
> from an external virtio device point of view. This is already the case
> when using vhost-net, for example, where VMM exposes a combination of
> backend and VMM features, and can mask them if needed.
>=20
> To migrate an external device the VMM needs to retrieve its (guest
> visible) status and make sure the device does not modify it or

"status" means device state here, not VIRTIO Status Register? (There
even a third use of "status" in the first paragraph related to used
descriptors. I found this confusing.)

> communicate with the guest anymore. The STOP status bit achieves the
> last part, and even the first one in case of a pure stateless device
> using the split vring.
>=20
> In its simpler way of working, the VMM masks the VIRTIO_F_STOP feature
> to the guest, and also masks the STOP and STOP_FAILED status bit. This
> way the VMM can stop and resume operation unilaterally, totally
> transparent for the latter.

"latter" means the guest here?

--z5wMSZRUdWugY+D0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmGWZvUACgkQnKSrs4Gr
c8i+ywgAwEIiDLtXs+xSc2tXxA2cLtoxUDeUPoaU6H6JkXdaIBMaJEueBuNX0pCM
Fyu4j+Q9wjjnuGPYJIl6yqkXWp13656T9J8ln5ZWYGdh4bt/m0TvMSzUOc6K7JDl
7ZXAn4SzvHLixdJ/IsW2Gm7IdK1mnH/AqOlbhP3foYnDvSwJD8U5GXIMxMzFdTXh
4qr+nt5CaQObmfZF3dJ66pTGik+9S40wlhbNT1LgNUICt/nqMHNXnju8HbU0FNcq
mjgT9EPht/cOHxhuRrPyRCEQQSRKnlCgdnA7MVuiAic1WKoNUWvc6+Fb2ZmHVjc/
yvpbkgOtkBksJ3sgxhw1BWDuwE8RQA==
=G6mM
-----END PGP SIGNATURE-----

--z5wMSZRUdWugY+D0--

