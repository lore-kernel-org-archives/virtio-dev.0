Return-Path: <stefanha@redhat.com>
Date: Thu, 15 Jul 2021 10:26:57 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Message-ID: <YO//YVrsCTUfgPVO@stefanha-x1.localdomain>
References: <778ffa63-c0ca-2faa-32da-3c5e71dd1dfe@redhat.com>
 <YOwSGeL+lfTxHuXg@stefanha-x1.localdomain>
 <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com>
 <YO1kQ8sBkr2eguvi@stefanha-x1.localdomain>
 <8a2037df-e527-dcb4-c4c8-a568885180e4@redhat.com>
 <YO60HpxfZnmfMCMj@stefanha-x1.localdomain>
 <094e15d4-169a-87e9-5ebb-93439ea72831@redhat.com>
 <YO79tuI72kTEWURN@stefanha-x1.localdomain>
 <542aad20-8bca-f5db-647b-41909dacb8d1@nvidia.com>
 <03c6db33-58c8-5357-4c6d-7e5e836b328c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jGIKjT5AKhzzSfXd"
Content-Disposition: inline
In-Reply-To: <03c6db33-58c8-5357-4c6d-7e5e836b328c@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--jGIKjT5AKhzzSfXd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 15, 2021 at 09:38:55AM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2021/7/15 =E4=B8=8A=E5=8D=8812:22, Max Gurtovoy =E5=86=99=E9=81=
=93:
> >=20
> > On 7/14/2021 6:07 PM, Stefan Hajnoczi wrote:
> > > > It requires much more works than the simple virtqueue interface:
> > > > (the main
> > > > issues is that the function is not self-contained in a single funct=
ion)
> > > >=20
> > > > 1) how to interact with the existing device status state machine?
> > > > 2) how to make it work in a nested environment?
> > > > 3) how to migrate the PF?
> > > > 4) do we need to allow more control other than just stop/freeze
> > > > the device
> > > > in the admin virtqueue? If yes, how to handle the concurrent
> > > > access from PF
> > > > and VF?
> > > > 5) how it is expected to work with non-PCI virtio device?
> > > I guess your device splitting proposal addresses some of these things?
> > >=20
> > > Max probably has the most to say about these points.
> > >=20
> > > If you want more input I can try to answer too, but I personally am n=
ot
> > > developing devices that need this right now, so I might not be the be=
st
> > > person to propose solutions.
> >=20
> > I think we mentioned this in the past and agreed that the only common
> > entity between my solution for virtio VF migration to this proposal is
> > the new admin control queue.
> >=20
> > I can prepare some draft for this.
> >=20
> > In our solution the PF will manage migration process for it's VFs using
> > the PF admin queue. PF is not migratable.
>=20
>=20
> That limits the use cases.
>=20
>=20
> >=20
> > I don't know who is using nested environments in production so don't
> > know if it worth talking about that.
>=20
>=20
> There should be plenty users for the nested case.

Yes, nested virtualization is becoming available in clouds, etc. I think
nested virtualization support should be part of the design.

> >=20
> > But, if you would like to implement it for testing, no problem. The VF
> > in level n, probably seen as PF in level n+1. So it can manage the
> > migration process for its nested VFs.
>=20
>=20
> The PF dependency makes the design almost impossible to be used in a nest=
ed
> environment.

I'm not sure I understood Max's example, but first I want to check I
understand yours:

A physical PF is passed through to an L1 guest. L2 guests are assigned
VFs created by the L1 guest from the PF.

Now we want to live migrate the L1 guest to another host. We need to
migrate the PF and its VFs are automatically included since there is no
migration from the L2 perspective?

> >=20
> > For question 5) what non-PCI devices are interesting in live migration ?
> >=20
>=20
> Why not? Virtio support transport other than PCI (CCW, MMIO).

Yes, VIRTIO isn't tied to PCI and the migration functionality should be
mappable to other transports.

Luckily the admin virtqueue approach maps naturally to other transports.
What requires more thought is how the admin virtqueue is
enumerated/managed on those other transports.

Stefan

--jGIKjT5AKhzzSfXd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDv/2EACgkQnKSrs4Gr
c8jnXwf/ZEzDTTJz9/Ssffu/2EneBys4l1d7vXtgP4QQ7ijw9QI/ZQ0FK28xNzva
E1U+gvzt0fAqHUCd1Z8Eg7ebZ2+TPVfPtFhPiuKn6p0ZAX5OGMUYw1ZJL5Gakt+V
/QiC9juZI7DUOZI0UZMtTZOYW410+h9vqyJAvwKK+bGwCFMQOhgj88TaCcyXrFCf
Oo5EoOncNudV2aIx5g6MFJMqm1xNXRJNhQGFh6DKamGQa0sjiQg2cECyaZSzjMdO
fjpUQ59w+kvBs/ERzk5f5EG4RKERaAUTdCsViuq1AuOlMJSlaepdUMxqpkjbG1il
Nyx7T25fJPpYNZBMIEo/mxOS1mr2qQ==
=mYux
-----END PGP SIGNATURE-----

--jGIKjT5AKhzzSfXd--

