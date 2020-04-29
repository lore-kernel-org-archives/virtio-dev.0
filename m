Return-Path: virtio-dev-return-7201-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 704A1985E7F
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Apr 2020 09:20:48 +0000 (UTC)
Date: Wed, 29 Apr 2020 10:20:40 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200429092040.GB122432@stefanha-x1.localdomain>
References: <MN2PR06MB60303B243BCA31472FD8A4C189AC0@MN2PR06MB6030.namprd06.prod.outlook.com>
 <MN2PR06MB60301F725442727DCDDFCEBD89AC0@MN2PR06MB6030.namprd06.prod.outlook.com>
 <MN2PR06MB6030882BFE3EC7A8D332C44789AC0@MN2PR06MB6030.namprd06.prod.outlook.com>
 <20200428100215-mutt-send-email-mst@kernel.org>
 <MN2PR06MB6030237A3D6C56DB9369FF2A89AD0@MN2PR06MB6030.namprd06.prod.outlook.com>
 <MN2PR06MB6030AB1BB9DF369159BB235A89AD0@MN2PR06MB6030.namprd06.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <MN2PR06MB6030AB1BB9DF369159BB235A89AD0@MN2PR06MB6030.namprd06.prod.outlook.com>
Subject: Re: [virtio-dev] Re: Transparent compress in virtio
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
To: keens keens <keens312@hotmail.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2020 at 02:00:39AM +0000, keens keens wrote:
> I want to compress all the data or files when the apps in VMs writes to a=
 pass-through block device via kvm virtio.
> And decompress the data when the apps in VMs trying to read the data from=
 the pass-through block device on host.
>=20
> My idea is to add a data transform layer into virtio architecture for the=
 purpose of transparent compress.
> I am reading the virtio.c, virtio_ring.c code, but have not found the pla=
ce where I can do the data compress.
> Is it feasible that we can add a filter into the virtio, and there is a c=
hance to do data compress or encrypt in the filter?

Can you use existing volume-level compression features instead of
reimplementing compression in virtio-specific code?

For example, the VDO device-mapper target is available for Linux:
https://github.com/dm-vdo/kvdo
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/ht=
ml/deduplicating_and_compressing_storage/deploying-vdo_deduplicating-and-co=
mpressing-storage

If not, can you explain your use case in more detail?

Thanks,
Stefan

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6pRugACgkQnKSrs4Gr
c8g23Qf/agrhi89p42HEL3Jdw/4Hv9/dM/L9o/sFIKLP2efxGxocHsr7dZJDYNwC
K72nm6U8NnCVGZWZiPP8+cnfNPVPpYUJfzMPlhUtBnecLjA0SxZNO7jk8+V9nvSD
Kj5NtcM3LbLu5xE/tB80A14R0rOKmvso9VY786kglX+DmvPG5LjuPK801AzxqluL
9mstJHobQ2+eepVPyoa0a8CJcxWlvSrpymmHkEQh6qfp20barL1XB3buZnwn9wsH
otYbVKBcxtXoXNyhdTdXQqFGA3bTTu4coqGvrRz5rGFmpLQyCxnu0s9rH2K2JSmk
aWscEFeSWh1jifszAAld86gYEUSCpQ==
=0Fe8
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--

