Return-Path: virtio-dev-return-6432-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BB2E2985A87
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Dec 2019 10:02:33 +0000 (UTC)
Date: Mon, 2 Dec 2019 10:02:27 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20191202100227.GA131786@stefanha-x1.localdomain>
References: <20170421111259.4b900b6b.cornelia.huck@de.ibm.com>
 <20170428124909.GH7270@stefanha-x1.localdomain>
 <a056497e-dbd6-749c-fa1a-c3d48edcbafa@siemens.com>
MIME-Version: 1.0
In-Reply-To: <a056497e-dbd6-749c-fa1a-c3d48edcbafa@siemens.com>
Subject: Re: [virtio-dev] virtio-blk: What's up with VIRTIO_BLK_T_GET_ID (8)?
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2019 at 06:06:48PM +0100, Jan Kiszka wrote:
> On 28.04.17 14:49, Stefan Hajnoczi wrote:
> > On Fri, Apr 21, 2017 at 11:12:59AM +0200, Cornelia Huck wrote:
> > > I see the request type in $SUBJECT implemented in both Linux and QEMU=
,
> > > but I can't find it in the standard.
> > >=20
> > > If we believe that getting a s/n is useful, we should spec it;
> > > otherwise, if we consider it just a legacy request type, it wouldn't
> > > hurt to mention it in the legacy section.
> >=20
> > It's not a legacy request type.
> >=20
> > Alexey Zaytev documented it in 2012:
> >=20
> > https://lists.linuxfoundation.org/pipermail/virtualization/2012-Decembe=
r/022313.html
> >=20
> > It was in the VIRTIO <1.0 spec:
> >=20
> > https://github.com/rustyrussell/virtio-spec/blob/master/virtio-spec.lyx
> >=20
> > I don't understand why it wasn't part of VIRTIO 1.0... :/
> >=20
> > It's worth sending a patch to add the request type to the spec again.
> >=20
>=20
> What happened with this? I was already searching for weired queue
> corruptions in my implementation when I suddenly got this unspecified
> request type.
>=20
> How should this be added? With a feature bit? Or just document the given
> reality (mandatory)?

I have sent a patch to add it.  Let's document it as-is since it has
been widely supported for years.

A new feature bit wouldn't help in this case since existing drivers
already use the command.  Devices that don't support the command respond
with BLK_S_UNSUPP.

Stefan

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3k4TIACgkQnKSrs4Gr
c8hSbAf7Bv+Tz9H7pt5vlz72m2YO0p472L4XMjr9wQz0NtG5O2uM3DhhxuQcZbid
ahhr6RLWzHByNSiSLDC4CA2BKzL2IYRgMRolE6badKhw5oqjBhyUHVWIhUPBIQ0l
LQlCacsJ6iC2abTmlRoMYatOqfg/q0ptYJVeEMRCxVrJm6XSZbu0pOq6SoOfFL7C
jxdAOWTvlxPWQcXHqZLgA5ZTxrmRxCEJoZSnvSw4RXKUsHvkryjlCdogRimFu4DA
GCkqggIRs4aENcgvBGf9m6WBoBOli65y2CJz4yt7W2lfYU1Ov0dbKNrxXbkUdQX+
NjKiT3zJgHRw80lBlNkJA/F45eNVhQ==
=KLS+
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--

