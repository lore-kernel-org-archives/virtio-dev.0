Return-Path: <virtio-comment-return-3100-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Fri, 3 Jun 2022 17:31:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <Ypo3eSzZp3OxXKCm@stefanha-x1.localdomain>
References: <20220601235559.41091-1-dmitry.fomichev@wdc.com>
 <Yphlet2cKT9ySAay@stefanha-x1.localdomain>
 <bf9ea224c637ce7f202418359ac96a6a182f45bb.camel@wdc.com>
 <CAJSP0QXiUy-=pyGtxjpguWFt=+HJFqjKo3ipwN+YpF43nsxAag@mail.gmail.com>
 <d0c0fcfc-01d2-9af3-3018-e8ca03f21fab@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AGdYCDw/95yTd2np"
Content-Disposition: inline
In-Reply-To: <d0c0fcfc-01d2-9af3-3018-e8ca03f21fab@opensource.wdc.com>
Subject: [virtio-comment] Re: [virtio-dev] [RFC PATCH] virtio-blk: add zoned block device
 specification
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, "hare@suse.de" <hare@suse.de>, "its@irrelevant.dk" <its@irrelevant.dk>, Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Hans Holmberg <Hans.Holmberg@wdc.com>, "faithilikerun@gmail.com" <faithilikerun@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--AGdYCDw/95yTd2np
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 03, 2022 at 05:16:01PM +0900, Damien Le Moal wrote:
> On 6/3/22 16:33, Stefan Hajnoczi wrote:
> [...]
> >> If partial is 0, the nr_zones will contain the number of zones that po=
tentially
> >> can be reported starting from the request "sector" position and until =
the end of
> >> sector range of the device. It does not necessarily equal the total nu=
mber of
> >> zones on the drive.
> >=20
> > The driver knows zone_sectors and nr_zones, so it can calculate
> > nr_zones - (sector / zone_sectors) itself. Why send a ZONE_REPORT
> > partial=3D0 request to the device to get this value?
>=20
> Good point. Indeed, the partial bit is not useful when we have all zone
> with the same size. ZBC does not enforce that. So in general, it is not
> possible to calculate the number of zones starting from a particular LBA
> even if the total capacity is known. A report zones reply thus always
> indicate the *total* number of zones that could be reported from a given
> LBA, regardless of the report buffer size. This forces the drives to go
> through all zones even if the report zones buffer is already filled up. So
> longer command execution times.
>=20
> The partial bit prevents that and is very useful to speedup a zone report
> for a single zone (e.g. to know that zone wp location).
>=20
> For a Linux host, since the kernel enforces that all zones must have the
> same size, the partial bit is not useful. But other hosts may not enforce
> this, in which case the partial bit can be useful.
>=20
> That said, I would not mind getting rid of it and assume a partial=3D1
> behavior, always. The kernel ioctl API does not have that parameter
> anyway, so it would have to be emulated by the driver. Not too hard to do,
> but still more code than strictly necessary.

Okay. We can start simple and introduce a feature bit later for devices
that have multiple zone sizes, if necessary.

Stefan

--AGdYCDw/95yTd2np
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmKaN3kACgkQnKSrs4Gr
c8jzRggAliVhrC6ZQoE4fyBBiewQQJXFhLhQsx08vmlh9/gOkM0+QGd7q4apbJD4
sXRuLHLcsphFJif3zyW3lskt/Dd+q7IAl5USk6r3LxkOP9McWtKZAIEbohUnTPfG
Yn+g8h2FXqXIdyzWvgxEy30IuEGQIsAdp+oobO60kSA3EIhu5Hv+9a+QvnUzgcSX
9tMF5rDaAqaLI/8uO58D+lR0KVVetynM9KIfPl1b4V9q6BtoL7hxpgeFU7seEsgR
Hs59IeZY3ZKE/RR/H9ifqChBHpczOheCVKGj50+wqaYQpYYhGhfibsD5sworS4MX
hE0XwWze278JmDzBAyy1N9TIlsx5nQ==
=KXTz
-----END PGP SIGNATURE-----

--AGdYCDw/95yTd2np--

