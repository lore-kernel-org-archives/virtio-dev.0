Return-Path: <stefanha@redhat.com>
Date: Tue, 3 Aug 2021 11:37:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Message-ID: <YQkcguccUO5IruuJ@stefanha-x1.localdomain>
References: <YPVz9A/DkawlKoD1@stefanha-x1.localdomain>
 <0213e6c2-59aa-f140-7231-36231b42051d@redhat.com>
 <YPaOYTAHaHYcelth@stefanha-x1.localdomain>
 <b4e23058-df0b-e630-a10e-458ddfedb2cb@redhat.com>
 <YPf00fKOCoBUETzW@stefanha-x1.localdomain>
 <5b5a366a-152f-def3-6978-9a2772aefe3a@redhat.com>
 <YPlHew9Dqy7n5v2N@stefanha-x1.localdomain>
 <ccd8b978-3e39-b997-4346-0f5e1a99b259@redhat.com>
 <YP7Prxye4x5FwixU@stefanha-x1.localdomain>
 <632c4c4f-7896-ec06-b3f1-bcd4d1ec58ca@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fKa08FM53YxfCgwp"
Content-Disposition: inline
In-Reply-To: <632c4c4f-7896-ec06-b3f1-bcd4d1ec58ca@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, mreitz@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


--fKa08FM53YxfCgwp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 03, 2021 at 02:33:20PM +0800, Jason Wang wrote:
> =E5=9C=A8 2021/7/26 =E4=B8=8B=E5=8D=8811:07, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > I guess this is just a summary of what we've already discussed and not
> > new information. I think an implementation today would use DBus VMState
> > to transfer implementation-specific device state (an opaque blob).
>=20
>=20
> Instead of trying to migrate those opaque stuffs which is kind of tricky,=
 I
> wonder if we can avoid them by recording the mapping in the shared
> filesystem itself.

The problem is that virtiofsd has no way of reopening the exact same
files without Linux file handles. So they need to be transferred to the
destination (or stored on a shared file system as you suggested),
regardless of whether they are part of the VIRTIO spec's device state or
not.

Implementation-specific state can be considered outside the scope of the
VIRTIO spec. In other words, we could exclude it from the VIRTIO-level
device state that save/load operate on. This does not solve the problem,
it just shifts the responsibility to the virtualization stack to migrate
this state.

The Linux file handles or other virtiofsd implementation-specific state
would be migrated separately (e.g. using DBus VMstate) so that by the
time the destination device does a VIRTIO load operation, it has the
necessary implementation-specific state ready.

I prefer to support in-band migration of implementation-specific state
because it's less complex to have a single device state instead of
splitting it.

Is this the direction you were thinking in?

Stefan

--fKa08FM53YxfCgwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEJHIIACgkQnKSrs4Gr
c8jLMwf8CeufmtzaB9AQ/CBnbBJt9kl01NWhhezifGv4oivJBnJn6YwLXj95q8la
vG2UAnldrKS6AUCKXKtcQZaqw2Vil47YekAytaF6vOnq7ezRChxDDvqxU6ZpkZEx
bTeoxmYNybgICXwOY9LUHq48QgQGkJzD1sawTlEU50H334mGJwHmHqhsAOHBUBx3
v6NdfvoQdB+ZYOTnmMwPlOjaK3p6FIk0NvGFxmncNNRukVasl8HUVoiuYOvh6HCH
RIfD3x+aRU7Tbff6ozcIXHnquD+Dxv1y+YvDtTGr298+jNxlTfxi8ugjq0++Pypx
zLfanEzo6Cnzdg1qbSAaVHgRXCj3BQ==
=RKzq
-----END PGP SIGNATURE-----

--fKa08FM53YxfCgwp--

