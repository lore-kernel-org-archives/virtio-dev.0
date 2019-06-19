Return-Path: virtio-dev-return-5785-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D3A78985D77
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Jun 2019 14:54:41 +0000 (UTC)
Date: Wed, 19 Jun 2019 15:54:30 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190619145430.GA1232@stefanha-x1.localdomain>
References: <1557600460-18966-1-git-send-email-ndragazis@arrikto.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <1557600460-18966-1-git-send-email-ndragazis@arrikto.com>
Subject: Re: [virtio-dev] [PATCH v3 0/4] introduce virtio vhost-user backend
 device type
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Vangelis Koukis <vkoukis@arrikto.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2019 at 09:47:36PM +0300, Nikos Dragazis wrote:
> Hi everyone,
>=20
> this PATCH presents an updated version of the RFC virtio device spec for
> the virtio-vhost-user device. The initial RFC implementation can be
> found here: [1].
>=20
> This PATCH is split into four parts:
>=20
> 1. the first commit is just a refactored version of the initial RFC
> implementation [1]. I just moved the device spec into a separate .tex
> file and changed the device id from #24 to #28 since the ids #24-#27 are
> reserved.
>=20
> 2. the second commit fixes some minor issues with the device spec. This
> is quite straightforward.
>=20
> 3. the third commit enhances the notification capability with some
> device/driver requirements. This makes sense because the notification
> capability behaves similarly to the MSI-X capability, thereby having
> some requirements that need to be mentioned.
>=20
> 4. the fourth commit synchronizes the shared memory capability with a
> recent patch [2] that attempts to standardize a standalone
> SHARED_MEMORY_CFG virtio capability.
>=20
> v3 changes:
>  * Device Requirements for the Notification Capability: point out the
>    difference between the MSI-X Table Size stored in the Message Control
>    register of the MSI-X capability structure and the actual MSI-X Table
>    Size
>=20
> v2 changes:
>  * Change device id from #25 to #28
>=20
> Looking forward to your comments.

I'm happy with v3.

Any other comments or shall we proceed to a vote?

Stefan

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0KTKYACgkQnKSrs4Gr
c8ionwf/cZlh8ttDKAvQXx9wa4CwUsgs5Njbz9ZbYraLvxx+LJNsJCk0v+IXvqIe
N6nmB9Oog2haKMCFwnZ5dPQMgMcjyQPqZyrK4mDg7MbigmCnCOcWLQgRsFq8gpJb
w/6p8pOSAvKVyT/VO5EknPNf7ow602FtkhC+t3Ow8QWTqKH3/mOeWLBSkHpE0NSB
nAI6EVH7LViVGoBvulspbVDaP3YqaaHwpSPRAUVu/VsGCq9G1JCbwVkygl3rn1QU
11vMl5ztOwAmlZ/0jJX9dtBdE7jWbZ40PoMXhpN+fLWP7a0MQ2r9N/OPujNxOK/M
r6L0zTTN49QSzQhascyPNthUTmDq6A==
=iTP3
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
